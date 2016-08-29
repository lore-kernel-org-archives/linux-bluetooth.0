Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [RFC] Bluetooth: Add framework for Extended Controller Information
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1472489878-28374-1-git-send-email-marcel@holtmann.org>
Date: Mon, 29 Aug 2016 10:08:46 -0700
Message-Id: <FB1A9A49-EF63-4A2D-9960-B009F7289A50@holtmann.org>
References: <1472489878-28374-1-git-send-email-marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
> include/net/bluetooth/hci.h  |  1 +
> include/net/bluetooth/mgmt.h | 18 +++++++++++++
> net/bluetooth/mgmt.c         | 62 ++++++++++++++++++++++++++++++++++++++++++--
> 3 files changed, 79 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index ddb9accac3a5..99aa5e5e3100 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -208,6 +208,7 @@ enum {
> 	HCI_MGMT_INDEX_EVENTS,
> 	HCI_MGMT_UNCONF_INDEX_EVENTS,
> 	HCI_MGMT_EXT_INDEX_EVENTS,
> +	HCI_MGMT_EXT_INFO_EVENTS,
> 	HCI_MGMT_OPTION_EVENTS,
> 	HCI_MGMT_SETTING_EVENTS,
> 	HCI_MGMT_DEV_CLASS_EVENTS,
> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> index 7647964b1efa..611b243713ea 100644
> --- a/include/net/bluetooth/mgmt.h
> +++ b/include/net/bluetooth/mgmt.h
> @@ -586,6 +586,18 @@ struct mgmt_rp_get_adv_size_info {
> 
> #define MGMT_OP_START_LIMITED_DISCOVERY	0x0041
> 
> +#define MGMT_OP_READ_EXT_INFO		0x0042
> +#define MGMT_READ_EXT_INFO_SIZE		0
> +struct mgmt_rp_read_ext_info {
> +	bdaddr_t bdaddr;
> +	__u8     version;
> +	__le16   manufacturer;
> +	__le32   supported_settings;
> +	__le32   current_settings;
> +	__le16   eir_len;
> +	__u8     eir[0];
> +} __packed;
> +
> #define MGMT_EV_CMD_COMPLETE		0x0001
> struct mgmt_ev_cmd_complete {
> 	__le16	opcode;
> @@ -800,3 +812,9 @@ struct mgmt_ev_advertising_added {
> struct mgmt_ev_advertising_removed {
> 	__u8    instance;
> } __packed;
> +
> +#define MGMT_EV_EXT_INFO_CHANGED	0x0025
> +struct mgmt_ev_ext_info_changed {
> +	__le16	eir_len;
> +	__u8	eir[0];
> +} __packed;
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 47efdb4a669a..69001f415efa 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -104,6 +104,7 @@ static const u16 mgmt_commands[] = {
> 	MGMT_OP_REMOVE_ADVERTISING,
> 	MGMT_OP_GET_ADV_SIZE_INFO,
> 	MGMT_OP_START_LIMITED_DISCOVERY,
> +	MGMT_OP_READ_EXT_INFO,
> };
> 
> static const u16 mgmt_events[] = {
> @@ -141,6 +142,7 @@ static const u16 mgmt_events[] = {
> 	MGMT_EV_LOCAL_OOB_DATA_UPDATED,
> 	MGMT_EV_ADVERTISING_ADDED,
> 	MGMT_EV_ADVERTISING_REMOVED,
> +	MGMT_EV_EXT_INFO_CHANGED,
> };
> 
> static const u16 mgmt_untrusted_commands[] = {
> @@ -149,6 +151,7 @@ static const u16 mgmt_untrusted_commands[] = {
> 	MGMT_OP_READ_UNCONF_INDEX_LIST,
> 	MGMT_OP_READ_CONFIG_INFO,
> 	MGMT_OP_READ_EXT_INDEX_LIST,
> +	MGMT_OP_READ_EXT_INFO,
> };
> 
> static const u16 mgmt_untrusted_events[] = {
> @@ -162,6 +165,7 @@ static const u16 mgmt_untrusted_events[] = {
> 	MGMT_EV_NEW_CONFIG_OPTIONS,
> 	MGMT_EV_EXT_INDEX_ADDED,
> 	MGMT_EV_EXT_INDEX_REMOVED,
> +	MGMT_EV_EXT_INFO_CHANGED,
> };
> 
> #define CACHE_TIMEOUT	msecs_to_jiffies(2 * 1000)
> @@ -862,6 +866,52 @@ static int read_controller_info(struct sock *sk, struct hci_dev *hdev,
> 				 sizeof(rp));
> }
> 
> +static int read_ext_controller_info(struct sock *sk, struct hci_dev *hdev,
> +				    void *data, u16 data_len)
> +{
> +	struct mgmt_rp_read_ext_info rp;
> +
> +	BT_DBG("sock %p %s", sk, hdev->name);
> +
> +	hci_dev_lock(hdev);
> +
> +	memset(&rp, 0, sizeof(rp));
> +
> +	bacpy(&rp.bdaddr, &hdev->bdaddr);
> +
> +	rp.version = hdev->hci_ver;
> +	rp.manufacturer = cpu_to_le16(hdev->manufacturer);
> +
> +	rp.supported_settings = cpu_to_le32(get_supported_settings(hdev));
> +	rp.current_settings = cpu_to_le32(get_current_settings(hdev));
> +
> +	rp.eir_len = cpu_to_le16(0);

this patch is functionally complete from its logic and event handling point of view. However it is missing the EIR_Data field to be filled in. At minimum it should contain Class of Device, Complete Local Name and Short Local Name EIR fields so it matches for the Read Controller Information currently returns.

I just ran out of time and it would be great if someone can pick this up. Extra bonus points for adding the Device ID fields and the LE Address (aka identity address) into it. And yes, the LE Address might differ depending on LE only mode of operation and Set Static Address setting.

Regards

Marcel

