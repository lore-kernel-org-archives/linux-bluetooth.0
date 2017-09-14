Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH v2] mesh: Add 'security' command
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20170913101720.15104-1-luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Message-ID: <cdc75108-2e7f-16b5-1a8a-05729c20544b@jp.fujitsu.com>
Date: Thu, 14 Sep 2017 16:51:07 +0900
MIME-Version: 1.0
In-Reply-To: <20170913101720.15104-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 09/13/2017 07:17 PM, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds 'security' command which can be used to display and change
> the provision security level:
> 
> [meshctl]# security
> Provision Security Level set to 1 (medium)
> [meshctl]# security 2
> Provision Security Level set to 2 (high)
> 
> Note: This doesn't change the default which is still medium.
> ---
>  mesh/main.c | 37 +++++++++++++++++++++++++++++++++++++
>  mesh/prov.c | 22 +++++++++++++++++++---
>  mesh/prov.h |  2 ++
>  3 files changed, 58 insertions(+), 3 deletions(-)
> 
> diff --git a/mesh/main.c b/mesh/main.c
> index 3a39d8f62..5ec76a465 100644
> --- a/mesh/main.c
> +++ b/mesh/main.c
> @@ -1721,6 +1721,41 @@ static void cmd_info(const char *arg)
>  	print_property(proxy, "TxPower");
>  }
>  
> +static const char *security2str(uint8_t level)
> +{
> +	switch (level) {
> +	case 0:
> +		return "low";
> +	case 1:
> +		return "medium";
> +	case 2:
> +		return "high";
> +	default:
> +		return "invalid";
> +	}
> +}
> +
> +static void cmd_security(const char *arg)
> +{
> +	uint8_t level;
> +	char *end;
> +
> +	if (!arg || arg[0] == '\0') {
> +		level = prov_get_sec_level();
> +		goto done;
> +	}
> +
> +	level = strtol(arg, &end, 10);
> +	if (end == arg || !prov_set_sec_level(level)) {
> +		rl_printf("Invalid security level %s\n", arg);
> +		return;
> +	}
> +
> +done:
> +	rl_printf("Provision Security Level set to %u (%s)\n", level,
> +						security2str(level));
> +}
> +
>  static void cmd_connect(const char *arg)
>  {
>  	if (check_default_ctrl() == FALSE)
> @@ -1967,6 +2002,8 @@ static const struct menu_entry meshctl_cmd_table[] = {
>  	{ "list",         NULL,       cmd_list, "List available controllers"},
>  	{ "show",         "[ctrl]",   cmd_show, "Controller information"},
>  	{ "select",       "<ctrl>",   cmd_select, "Select default controller"},
> +	{ "security",      "[level=0(low), 1(medium), 2(high)]", cmd_security,
> +				"Display or change provision security level"},

I prefer "[level]" as the arg since it is hard for users to first
decide whether or not prefix "levle=" needs.

>  	{ "info",         "[dev]",    cmd_info, "Device information"},
>  	{ "connect",      "[net_idx]",cmd_connect, "Connect to mesh network"},
>  	{ "discover-unprovisioned", "<on/off>", cmd_scan_unprovisioned_devices,
> diff --git a/mesh/prov.c b/mesh/prov.c
> index 32785dda1..b293aa5fb 100644
> --- a/mesh/prov.c
> +++ b/mesh/prov.c
> @@ -56,8 +56,6 @@
>  #define MESH_PROV_SEC_MED	1
>  #define MESH_PROV_SEC_LOW	0
>  
> -/* For Deployment, Security levels below HIGH are *not* recomended */
> -#define mesh_gatt_prov_security()	MESH_PROV_SEC_MED
>  
>  #define PROV_INVITE	0x00
>  #define PROV_CAPS	0x01
> @@ -84,6 +82,9 @@
>  #define PROV_ERR_UNEXPECTED_ERR		0x07
>  #define PROV_ERR_CANT_ASSIGN_ADDR	0x08
>  
> +/* For Deployment, Security levels below HIGH are *not* recomended */
> +static uint8_t prov_sec_level = MESH_PROV_SEC_MED;
> +
>  /* Expected Provisioning PDU sizes */
>  static const uint16_t expected_pdu_size[] = {
>  	1 + 1,					/* PROV_INVITE */
> @@ -463,7 +464,7 @@ bool prov_data_ready(struct mesh_node *node, uint8_t *buf, uint8_t len)
>  			/* Save Capability values */
>  			memcpy(&prov->conf_in.caps, buf, len);
>  
> -			sec_level = mesh_gatt_prov_security();
> +			sec_level = prov_sec_level;

I think that it is better to call prov_get_sec_level() since we can
simply find locations at which security level is gotten by only
searching prov_get_sec_level()


Regards,
Eramoto

>  
>  			if (sec_level == MESH_PROV_SEC_HIGH) {
>  
> @@ -662,3 +663,18 @@ bool prov_complete(struct mesh_node *node, uint8_t status)
>  
>  	return true;
>  }
> +
> +bool prov_set_sec_level(uint8_t level)
> +{
> +	if (level > MESH_PROV_SEC_HIGH)
> +		return false;
> +
> +	prov_sec_level = level;
> +
> +	return true;
> +}
> +
> +uint8_t prov_get_sec_level(void)
> +{
> +	return prov_sec_level;
> +}
> diff --git a/mesh/prov.h b/mesh/prov.h
> index 94ce7a1b5..2587df8fb 100644
> --- a/mesh/prov.h
> +++ b/mesh/prov.h
> @@ -29,3 +29,5 @@ bool prov_open(struct mesh_node *node, GDBusProxy *prov_in, uint16_t net_idx,
>  		provision_done_cb cb, void *user_data);
>  bool prov_data_ready(struct mesh_node *node, uint8_t *buf, uint8_t len);
>  bool prov_complete(struct mesh_node *node, uint8_t status);
> +bool prov_set_sec_level(uint8_t level);
> +uint8_t prov_get_sec_level(void);
> 

