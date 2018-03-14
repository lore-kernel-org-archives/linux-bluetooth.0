Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] btmgmt: Add PHY configuration get/set commands
To: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>,
        Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
References: <1520920445-30353-1-git-send-email-jaganathx.kanakkassery@intel.com>
 <1520920445-30353-2-git-send-email-jaganathx.kanakkassery@intel.com>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Message-ID: <8762ccb9-22be-8be9-dc0c-769f95824735@jp.fujitsu.com>
Date: Wed, 14 Mar 2018 19:00:09 +0900
MIME-Version: 1.0
In-Reply-To: <1520920445-30353-2-git-send-email-jaganathx.kanakkassery@intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On 03/13/2018 02:54 PM, Jaganath Kanakkassery wrote:
> ---
>  lib/mgmt.h     |  33 +++++++++++++++
>  tools/btmgmt.c | 132 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 165 insertions(+)
>  mode change 100644 => 100755 tools/btmgmt.c
> 
> diff --git a/lib/mgmt.h b/lib/mgmt.h
> index 798a05e..7a25e17 100644
> --- a/lib/mgmt.h
> +++ b/lib/mgmt.h
> @@ -101,6 +101,7 @@ struct mgmt_rp_read_index_list {
>  #define MGMT_SETTING_PRIVACY		0x00002000
>  #define MGMT_SETTING_CONFIGURATION	0x00004000
>  #define MGMT_SETTING_STATIC_ADDRESS	0x00008000
> +#define MGMT_SETTING_PHY_CONFIGURATION 0x00010000
>  
>  #define MGMT_OP_READ_INFO		0x0004
>  struct mgmt_rp_read_info {
> @@ -546,6 +547,30 @@ struct mgmt_cp_set_appearance {
>  	uint16_t appearance;
>  } __packed;
>  
> +#define MGMT_OP_GET_PHY_CONFIGURATION	0x0044
> +struct mgmt_rp_get_phy_confguration {
> +	uint16_t	supported_phys;
> +	uint16_t	selected_phys;
> +} __packed;
> +
> +#define MGMT_PHY_LE_1M_TX		0x0001
> +#define MGMT_PHY_LE_1M_RX		0x0002
> +#define MGMT_PHY_LE_2M_TX		0x0004
> +#define MGMT_PHY_LE_2M_RX		0x0008
> +#define MGMT_PHY_LE_CODED_TX		0x0010
> +#define MGMT_PHY_LE_CODED_RX		0x0020
> +
> +#define MGMT_PHY_LE_TX_MASK (MGMT_PHY_LE_1M_TX | MGMT_PHY_LE_2M_TX | \
> +			     MGMT_PHY_LE_CODED_TX)
> +#define MGMT_PHY_LE_RX_MASK (MGMT_PHY_LE_1M_RX | MGMT_PHY_LE_2M_RX | \
> +			     MGMT_PHY_LE_CODED_RX)
> +
> +#define MGMT_OP_SET_PHY_CONFIGURATION	0x0045
> +struct mgmt_cp_set_phy_confguration {
> +	uint16_t	default_phys;
> +} __packed;
> +
> +
>  #define MGMT_EV_CMD_COMPLETE		0x0001
>  struct mgmt_ev_cmd_complete {
>  	uint16_t opcode;
> @@ -764,6 +789,11 @@ struct mgmt_ev_ext_info_changed {
>  	uint8_t  eir[0];
>  } __packed;
>  
> +#define MGMT_EV_PHY_CONFIGURATION_CHANGED	0x0026
> +struct mgmt_ev_phy_configuration_changed {
> +	uint16_t	selected_phys;
> +} __packed;
> +
>  static const char *mgmt_op[] = {
>  	"<0x0000>",
>  	"Read Version",
> @@ -833,6 +863,8 @@ static const char *mgmt_op[] = {
>  	"Start Limited Discovery",
>  	"Read Extended Controller Information",
>  	"Set Appearance",
> +	"Get PHY Configuration",
> +	"Set PHY Configuration",
>  };
>  
>  static const char *mgmt_ev[] = {
> @@ -874,6 +906,7 @@ static const char *mgmt_ev[] = {
>  	"Advertising Added",
>  	"Advertising Removed",
>  	"Extended Controller Information Changed",
> +	"PHY Configuration Changed",
>  };
>  
>  static const char *mgmt_status[] = {
> diff --git a/tools/btmgmt.c b/tools/btmgmt.c
> old mode 100644
> new mode 100755
> index 122c46d..6ada176
> --- a/tools/btmgmt.c
> +++ b/tools/btmgmt.c
> @@ -4165,6 +4165,134 @@ static void cmd_appearance(int argc, char **argv)
>  	}
>  }
>  
> +static const char *phys_str[] = {
> +	"1MTX",
> +	"1MRX",
> +	"2MTX",
> +	"2MRX",
> +	"CODEDTX",
> +	"CODEDRX",
> +};
> +
> +static const char *phys2str(uint16_t phys)
> +{
> +	static char str[256];
> +	unsigned i;
> +	int off;
> +
> +	off = 0;
> +	str[0] = '\0';
> +
> +	for (i = 0; i < NELEM(phys_str); i++) {
> +		if ((phys & (1 << i)) != 0)
> +			off += snprintf(str + off, sizeof(str) - off, "%s ",
> +							phys_str[i]);
> +	}
> +
> +	return str;
> +}
> +
> +static void get_phy_rsp(uint8_t status, uint16_t len, const void *param,
> +							void *user_data)
> +{
> +	const struct mgmt_rp_get_phy_confguration *rp = param;
> +	uint16_t supported_flags, selected_phys;
> +
> +	if (status != 0) {
> +		error("Get PHY Configuration failed with status 0x%02x (%s)",
> +						status, mgmt_errstr(status));
> +		goto done;

bt_shell_noninteractive_quit(EXIT_FAILURE) should be called if being error.


> +	}
> +
> +	if (len < sizeof(*rp)) {
> +		error("Too small get-phy reply (%u bytes)", len);
> +		goto done;

This is the same as above.


> +	}
> +
> +	supported_flags = get_le16(&rp->supported_phys);
> +	selected_phys = get_le16(&rp->selected_phys);
> +
> +	print("Supported phys: %s", phys2str(supported_flags));
> +	print("Selected phys: %s", phys2str(selected_phys));
> +
> +done:
> +	bt_shell_noninteractive_quit(EXIT_SUCCESS);
> +}
> +
> +static void cmd_get_phy(int argc, char **argv)
> +{
> +	uint16_t index;
> +
> +	index = mgmt_index;
> +	if (index == MGMT_INDEX_NONE)
> +		index = 0;
> +
> +	if (mgmt_send(mgmt, MGMT_OP_GET_PHY_CONFIGURATION, index, 0, NULL,
> +					get_phy_rsp, NULL, NULL) == 0) {
> +		error("Unable to send Get PHY cmd");
> +		return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +	}
> +}
> +
> +static void set_phy_rsp(uint8_t status, uint16_t len, const void *param,
> +							void *user_data)
> +{
> +	if (status != 0)
> +		error("Could not set PHY Configuration with status 0x%02x (%s)",
> +						status, mgmt_errstr(status));

This is the same as above.


Regards,
Eramoto


> +	else
> +		print("PHY Configuration successfully set");
> +
> +	bt_shell_noninteractive_quit(EXIT_SUCCESS);
> +}
> +
> +static void cmd_set_phy(int argc, char **argv)
> +{
> +	struct mgmt_cp_set_phy_confguration cp;
> +	int i;
> +	uint16_t phys = 0;
> +	uint16_t index;
> +
> +	if (argc < 2) {
> +		print("Specify one or more of \"1MTX\" \"1MRX\" \"2MTX\" \
> +			\"2MRX\" \"CODEDTX\" \"CODEDRX\"");
> +		return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +	}
> +
> +	for (i = 1; i < argc; i++) {
> +		if (strcasecmp(argv[i], "1MTX") == 0)
> +			phys |= MGMT_PHY_LE_1M_TX;
> +
> +		if (strcasecmp(argv[i], "1MRX") == 0)
> +			phys |= MGMT_PHY_LE_1M_RX;
> +
> +		if (strcasecmp(argv[i], "2MTX") == 0)
> +			phys |= MGMT_PHY_LE_2M_TX;
> +
> +		if (strcasecmp(argv[i], "2MRX") == 0)
> +			phys |= MGMT_PHY_LE_2M_RX;
> +
> +		if (strcasecmp(argv[i], "CODEDTX") == 0)
> +			phys |= MGMT_PHY_LE_CODED_TX;
> +
> +		if (strcasecmp(argv[i], "CODEDRX") == 0)
> +			phys |= MGMT_PHY_LE_CODED_RX;
> +	}
> +
> +	cp.default_phys = cpu_to_le16(phys);
> +
> +	index = mgmt_index;
> +	if (index == MGMT_INDEX_NONE)
> +		index = 0;
> +
> +	if (mgmt_send(mgmt, MGMT_OP_SET_PHY_CONFIGURATION, index, sizeof(cp),
> +					&cp, set_phy_rsp, NULL, NULL) == 0) {
> +		error("Unable to send %s cmd",
> +				mgmt_opstr(MGMT_OP_GET_PHY_CONFIGURATION));
> +		return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +	}
> +}
> +
>  static void register_mgmt_callbacks(struct mgmt *mgmt, uint16_t index)
>  {
>  	mgmt_register(mgmt, MGMT_EV_CONTROLLER_ERROR, index, controller_error,
> @@ -4360,6 +4488,10 @@ static const struct bt_shell_menu main_menu = {
>  		cmd_clr_adv,		"Clear advertising instances"	},
>  	{ "appearance",		"<appearance>",
>  		cmd_appearance,		"Set appearance"		},
> +	{ "get-phy",		NULL,
> +		cmd_get_phy,		"Get PHY Configuration"         },
> +        { "set-phy",		"<phys>",
> +		cmd_set_phy,		"Set PHY Configuration"         },
>  	{} },
>  };
>  
> 

