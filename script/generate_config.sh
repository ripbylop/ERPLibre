#!/usr/bin/env bash

. ./env_var.sh

EL_USER=${USER}
EL_HOME=$PWD
EL_HOME_ODOO="${EL_HOME}/odoo"
#EL_PORT="8069"
#EL_LONGPOLLING_PORT="8072"
#EL_SUPERADMIN="admin"
EL_CONFIG_FILE="${EL_HOME}/config.conf"
#EL_MINIMAL_ADDONS="False"
#EL_INSTALL_NGINX="True"

touch "${EL_CONFIG_FILE}"
echo -e "* Creating server config file"
printf '[options] \n; This is the password that allows database operations:\n' > "${EL_CONFIG_FILE}"
printf "admin_passwd = ${EL_SUPERADMIN}\n" >> "${EL_CONFIG_FILE}"
printf "db_host = False\n" >> "${EL_CONFIG_FILE}"
printf "db_port = False\n" >> "${EL_CONFIG_FILE}"
printf "db_user = ${EL_USER}\n" >> "${EL_CONFIG_FILE}"
printf "db_password = False\n" >> "${EL_CONFIG_FILE}"
printf "xmlrpc_port = ${EL_PORT}\n" >> "${EL_CONFIG_FILE}"
printf "longpolling_port = ${EL_LONGPOLLING_PORT}\n" >> "${EL_CONFIG_FILE}"

printf "addons_path = ${EL_HOME_ODOO}/addons,${EL_HOME}/addons.odoo${EL_ODOO_VERSION}/addons," >> "${EL_CONFIG_FILE}"

if [[ ${EL_MINIMAL_ADDONS} = "False" ]]; then
    printf "${EL_HOME}/addons.odoo${EL_ODOO_VERSION}/CybroOdoo_OpenHRMS," >> "${EL_CONFIG_FILE}"
    printf "${EL_HOME}/addons.odoo${EL_ODOO_VERSION}/Numigi_odoo-partner-addons," >> "${EL_CONFIG_FILE}"
    printf "${EL_HOME}/addons.odoo${EL_ODOO_VERSION}/Numigi_odoo-web-addons," >> "${EL_CONFIG_FILE}"
    printf "${EL_HOME}/addons.odoo${EL_ODOO_VERSION}/OCA_account-budgeting," >> "${EL_CONFIG_FILE}"
    printf "${EL_HOME}/addons.odoo${EL_ODOO_VERSION}/OCA_helpdesk," >> "${EL_CONFIG_FILE}"
    printf "${EL_HOME}/addons.odoo${EL_ODOO_VERSION}/OCA_knowledge," >> "${EL_CONFIG_FILE}"
    printf "${EL_HOME}/addons.odoo${EL_ODOO_VERSION}/OCA_project," >> "${EL_CONFIG_FILE}"
    printf "${EL_HOME}/addons.odoo${EL_ODOO_VERSION}/OCA_project-agile," >> "${EL_CONFIG_FILE}"
    printf "${EL_HOME}/addons.odoo${EL_ODOO_VERSION}/OCA_server-auth," >> "${EL_CONFIG_FILE}"
    printf "${EL_HOME}/addons.odoo${EL_ODOO_VERSION}/OCA_server-brand," >> "${EL_CONFIG_FILE}"
    printf "${EL_HOME}/addons.odoo${EL_ODOO_VERSION}/OCA_server-tools," >> "${EL_CONFIG_FILE}"
    printf "${EL_HOME}/addons.odoo${EL_ODOO_VERSION}/OCA_server-ux," >> "${EL_CONFIG_FILE}"
    printf "${EL_HOME}/addons.odoo${EL_ODOO_VERSION}/OCA_social," >> "${EL_CONFIG_FILE}"
    printf "${EL_HOME}/addons.odoo${EL_ODOO_VERSION}/OCA_timesheet," >> "${EL_CONFIG_FILE}"
    printf "${EL_HOME}/addons.odoo${EL_ODOO_VERSION}/OCA_web," >> "${EL_CONFIG_FILE}"
    printf "${EL_HOME}/addons.odoo${EL_ODOO_VERSION}/Smile-SA_odoo_addons," >> "${EL_CONFIG_FILE}"
    printf "${EL_HOME}/addons.odoo${EL_ODOO_VERSION}/camptocamp_odoo-cloud-platform," >> "${EL_CONFIG_FILE}"
    printf "${EL_HOME}/addons.odoo${EL_ODOO_VERSION}/dhongu_deltatech," >> "${EL_CONFIG_FILE}"
    printf "${EL_HOME}/addons.odoo${EL_ODOO_VERSION}/muk-it_muk_web," >> "${EL_CONFIG_FILE}"
    printf "${EL_HOME}/addons.odoo${EL_ODOO_VERSION}/odoomates_odooapps," >> "${EL_CONFIG_FILE}"
fi
printf "\n" >> "${EL_CONFIG_FILE}"

printf "max_cron_threads = 2\n" >> "${EL_CONFIG_FILE}"

printf "workers = 2\n" >> "${EL_CONFIG_FILE}"
if [[ ${EL_INSTALL_NGINX} = "True" ]]; then
    printf "xmlrpc_interface = 127.0.0.1\n" >> "${EL_CONFIG_FILE}"
    printf "proxy_mode = True\n" >> "${EL_CONFIG_FILE}"
fi

# Update and fix the config.conf
# Fix only the configuration if installation is done
if [ -f "./.venv/bin/activate" ] && [ -f "./odoo/odoo-bin" ]; then
    make config_update
fi
