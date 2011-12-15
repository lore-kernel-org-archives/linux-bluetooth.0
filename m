Return-Path: <cyrus@holtmann.org>
Date: Thu, 15 Dec 2011 11:02:47 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/7] Bluetooth: Update mgmt_read_info and related mgmt
 messages
Message-ID: <20111215090245.GC15283@aemeltch-MOBL1>
References: <1323899524-13653-1-git-send-email-johan.hedberg@gmail.com>
 <1323899524-13653-2-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1323899524-13653-2-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Wed, Dec 14, 2011 at 11:51:58PM +0200, johan.hedberg@gmail.com wrote:
> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> This patch updates the mgmt_read_info and related messages to the latest
> management API which uses a bitfield of settings instead of individual
> boolean values.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci.h  |    1 +
>  include/net/bluetooth/mgmt.h |   29 +++++---
>  net/bluetooth/mgmt.c         |  146 +++++++++++++++++++++++++++---------------
>  3 files changed, 113 insertions(+), 63 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 67ad984..c9ad56f 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -210,6 +210,7 @@ enum {
>  
>  #define LMP_EV4		0x01
>  #define LMP_EV5		0x02
> +#define LMP_NO_BREDR	0x20
>  #define LMP_LE		0x40
>  
>  #define LMP_SNIFF_SUBR	0x02
> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> index 3b68806..85e9c6e 100644
> --- a/include/net/bluetooth/mgmt.h
> +++ b/include/net/bluetooth/mgmt.h
> @@ -61,22 +61,29 @@ struct mgmt_rp_read_index_list {
>  /* Reserve one extra byte for names in management messages so that they
>   * are always guaranteed to be nul-terminated */
>  #define MGMT_MAX_NAME_LENGTH		(HCI_MAX_NAME_LENGTH + 1)
> +#define MGMT_MAX_SHORT_NAME_LENGTH	(10 + 1)
> +
> +#define MGMT_SETTING_POWERED		0x00000001
> +#define MGMT_SETTING_CONNECTABLE	0x00000002
> +#define MGMT_SETTING_FAST_CONNECTABLE	0x00000004
> +#define MGMT_SETTING_DISCOVERABLE	0x00000008
> +#define MGMT_SETTING_PAIRABLE		0x00000010
> +#define MGMT_SETTING_LINK_SECURITY	0x00000020
> +#define MGMT_SETTING_SSP		0x00000040
> +#define MGMT_SETTING_BREDR		0x00000080
> +#define MGMT_SETTING_HS			0x00000100
> +#define MGMT_SETTING_LE			0x00000200

Just a minor comment.
Can we use set_bit style for the defines above?

Best regards 
Andrei Emeltchenko 

>  
>  #define MGMT_OP_READ_INFO		0x0004
>  struct mgmt_rp_read_info {
> -	__u8 type;
> -	__u8 powered;
> -	__u8 connectable;
> -	__u8 discoverable;
> -	__u8 pairable;
> -	__u8 sec_mode;
>  	bdaddr_t bdaddr;
> +	__u8 version;
> +	__le16 manufacturer;
> +	__le32 supported_settings;
> +	__le32 current_settings;
>  	__u8 dev_class[3];
> -	__u8 features[8];
> -	__u16 manufacturer;
> -	__u8 hci_ver;
> -	__u16 hci_rev;
>  	__u8 name[MGMT_MAX_NAME_LENGTH];
> +	__u8 short_name[MGMT_MAX_SHORT_NAME_LENGTH];
>  } __packed;
>  
>  struct mgmt_mode {
> @@ -285,7 +292,7 @@ struct mgmt_ev_controller_error {
>  
>  #define MGMT_EV_INDEX_REMOVED		0x0005
>  
> -#define MGMT_EV_POWERED			0x0006
> +#define MGMT_EV_NEW_SETTINGS		0x0006
>  
>  #define MGMT_EV_DISCOVERABLE		0x0007
>  
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 7a23f21..629570c 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -242,6 +242,63 @@ static int read_index_list(struct sock *sk)
>  	return err;
>  }
>  
> +static u32 get_supported_settings(struct hci_dev *hdev)
> +{
> +	u32 settings = 0;
> +
> +	settings |= MGMT_SETTING_POWERED;
> +	settings |= MGMT_SETTING_CONNECTABLE;
> +	settings |= MGMT_SETTING_FAST_CONNECTABLE;
> +	settings |= MGMT_SETTING_DISCOVERABLE;
> +	settings |= MGMT_SETTING_PAIRABLE;
> +
> +	if (hdev->features[6] & LMP_SIMPLE_PAIR)
> +		settings |= MGMT_SETTING_SSP;
> +
> +	if (!(hdev->features[4] & LMP_NO_BREDR)) {
> +		settings |= MGMT_SETTING_BREDR;
> +		settings |= MGMT_SETTING_LINK_SECURITY;
> +	}
> +
> +	if (hdev->features[4] & LMP_LE)
> +		settings |= MGMT_SETTING_LE;
> +
> +	return settings;
> +}
> +
> +static u32 get_current_settings(struct hci_dev *hdev)
> +{
> +	u32 settings = 0;
> +
> +	if (test_bit(HCI_UP, &hdev->flags))
> +		settings |= MGMT_SETTING_POWERED;
> +	else
> +		return settings;
> +
> +	if (test_bit(HCI_PSCAN, &hdev->flags))
> +		settings |= MGMT_SETTING_CONNECTABLE;
> +
> +	if (test_bit(HCI_ISCAN, &hdev->flags))
> +		settings |= MGMT_SETTING_DISCOVERABLE;
> +
> +	if (test_bit(HCI_PAIRABLE, &hdev->flags))
> +		settings |= MGMT_SETTING_PAIRABLE;
> +
> +	if (!(hdev->features[4] & LMP_NO_BREDR))
> +		settings |= MGMT_SETTING_BREDR;
> +
> +	if (hdev->extfeatures[0] & LMP_HOST_LE)
> +		settings |= MGMT_SETTING_LE;
> +
> +	if (test_bit(HCI_AUTH, &hdev->flags))
> +		settings |= MGMT_SETTING_LINK_SECURITY;
> +
> +	if (hdev->ssp_mode > 0)
> +		settings |= MGMT_SETTING_SSP;
> +
> +	return settings;
> +}
> +
>  static int read_controller_info(struct sock *sk, u16 index)
>  {
>  	struct mgmt_rp_read_info rp;
> @@ -263,26 +320,16 @@ static int read_controller_info(struct sock *sk, u16 index)
>  
>  	memset(&rp, 0, sizeof(rp));
>  
> -	rp.type = hdev->dev_type;
> +	bacpy(&rp.bdaddr, &hdev->bdaddr);
>  
> -	rp.powered = test_bit(HCI_UP, &hdev->flags);
> -	rp.connectable = test_bit(HCI_PSCAN, &hdev->flags);
> -	rp.discoverable = test_bit(HCI_ISCAN, &hdev->flags);
> -	rp.pairable = test_bit(HCI_PSCAN, &hdev->flags);
> +	rp.version = hdev->hci_ver;
>  
> -	if (test_bit(HCI_AUTH, &hdev->flags))
> -		rp.sec_mode = 3;
> -	else if (hdev->ssp_mode > 0)
> -		rp.sec_mode = 4;
> -	else
> -		rp.sec_mode = 2;
> +	put_unaligned_le16(hdev->manufacturer, &rp.manufacturer);
> +
> +	rp.supported_settings = cpu_to_le32(get_supported_settings(hdev));
> +	rp.current_settings = cpu_to_le32(get_current_settings(hdev));
>  
> -	bacpy(&rp.bdaddr, &hdev->bdaddr);
> -	memcpy(rp.features, hdev->features, 8);
>  	memcpy(rp.dev_class, hdev->dev_class, 3);
> -	put_unaligned_le16(hdev->manufacturer, &rp.manufacturer);
> -	rp.hci_ver = hdev->hci_ver;
> -	put_unaligned_le16(hdev->hci_rev, &rp.hci_rev);
>  
>  	memcpy(rp.name, hdev->dev_name, sizeof(hdev->dev_name));
>  
> @@ -365,13 +412,11 @@ static void mgmt_pending_remove(struct pending_cmd *cmd)
>  	mgmt_pending_free(cmd);
>  }
>  
> -static int send_mode_rsp(struct sock *sk, u16 opcode, u16 index, u8 val)
> +static int send_settings_rsp(struct sock *sk, u16 opcode, struct hci_dev *hdev)
>  {
> -	struct mgmt_mode rp;
> +	__le32 settings = cpu_to_le32(get_current_settings(hdev));
>  
> -	rp.val = val;
> -
> -	return cmd_complete(sk, index, opcode, &rp, sizeof(rp));
> +	return cmd_complete(sk, hdev->id, opcode, &settings, sizeof(settings));
>  }
>  
>  static int set_powered(struct sock *sk, u16 index, unsigned char *data, u16 len)
> @@ -398,7 +443,7 @@ static int set_powered(struct sock *sk, u16 index, unsigned char *data, u16 len)
>  
>  	up = test_bit(HCI_UP, &hdev->flags);
>  	if ((cp->val && up) || (!cp->val && !up)) {
> -		err = send_mode_rsp(sk, index, MGMT_OP_SET_POWERED, cp->val);
> +		err = send_settings_rsp(sk, MGMT_OP_SET_POWERED, hdev);
>  		goto failed;
>  	}
>  
> @@ -466,8 +511,7 @@ static int set_discoverable(struct sock *sk, u16 index, unsigned char *data,
>  
>  	if (cp->val == test_bit(HCI_ISCAN, &hdev->flags) &&
>  					test_bit(HCI_PSCAN, &hdev->flags)) {
> -		err = send_mode_rsp(sk, index, MGMT_OP_SET_DISCOVERABLE,
> -								cp->val);
> +		err = send_settings_rsp(sk, MGMT_OP_SET_DISCOVERABLE, hdev);
>  		goto failed;
>  	}
>  
> @@ -536,8 +580,7 @@ static int set_connectable(struct sock *sk, u16 index, unsigned char *data,
>  	}
>  
>  	if (cp->val == test_bit(HCI_PSCAN, &hdev->flags)) {
> -		err = send_mode_rsp(sk, index, MGMT_OP_SET_CONNECTABLE,
> -								cp->val);
> +		err = send_settings_rsp(sk, MGMT_OP_SET_CONNECTABLE, hdev);
>  		goto failed;
>  	}
>  
> @@ -595,8 +638,9 @@ static int mgmt_event(u16 event, struct hci_dev *hdev, void *data,
>  static int set_pairable(struct sock *sk, u16 index, unsigned char *data,
>  									u16 len)
>  {
> -	struct mgmt_mode *cp, ev;
> +	struct mgmt_mode *cp;
>  	struct hci_dev *hdev;
> +	__le32 ev;
>  	int err;
>  
>  	cp = (void *) data;
> @@ -619,13 +663,13 @@ static int set_pairable(struct sock *sk, u16 index, unsigned char *data,
>  	else
>  		clear_bit(HCI_PAIRABLE, &hdev->flags);
>  
> -	err = send_mode_rsp(sk, MGMT_OP_SET_PAIRABLE, index, cp->val);
> +	err = send_settings_rsp(sk, MGMT_OP_SET_PAIRABLE, hdev);
>  	if (err < 0)
>  		goto failed;
>  
> -	ev.val = cp->val;
> +	ev = cpu_to_le32(get_current_settings(hdev));
>  
> -	err = mgmt_event(MGMT_EV_PAIRABLE, hdev, &ev, sizeof(ev), sk);
> +	err = mgmt_event(MGMT_EV_NEW_SETTINGS, hdev, &ev, sizeof(ev), sk);
>  
>  failed:
>  	hci_dev_unlock_bh(hdev);
> @@ -2234,17 +2278,14 @@ int mgmt_index_removed(struct hci_dev *hdev)
>  struct cmd_lookup {
>  	u8 val;
>  	struct sock *sk;
> +	struct hci_dev *hdev;
>  };
>  
> -static void mode_rsp(struct pending_cmd *cmd, void *data)
> +static void settings_rsp(struct pending_cmd *cmd, void *data)
>  {
> -	struct mgmt_mode *cp = cmd->param;
>  	struct cmd_lookup *match = data;
>  
> -	if (cp->val != match->val)
> -		return;
> -
> -	send_mode_rsp(cmd->sk, cmd->opcode, cmd->index, cp->val);
> +	send_settings_rsp(cmd->sk, cmd->opcode, match->hdev);
>  
>  	list_del(&cmd->list);
>  
> @@ -2258,20 +2299,21 @@ static void mode_rsp(struct pending_cmd *cmd, void *data)
>  
>  int mgmt_powered(struct hci_dev *hdev, u8 powered)
>  {
> -	struct mgmt_mode ev;
> -	struct cmd_lookup match = { powered, NULL };
> +	struct cmd_lookup match = { powered, NULL, hdev };
> +	__le32 ev;
>  	int ret;
>  
> -	mgmt_pending_foreach(MGMT_OP_SET_POWERED, hdev, mode_rsp, &match);
> +	mgmt_pending_foreach(MGMT_OP_SET_POWERED, hdev, settings_rsp, &match);
>  
>  	if (!powered) {
>  		u8 status = ENETDOWN;
>  		mgmt_pending_foreach(0, hdev, cmd_status_rsp, &status);
>  	}
>  
> -	ev.val = powered;
> +	ev = cpu_to_le32(get_current_settings(hdev));
>  
> -	ret = mgmt_event(MGMT_EV_POWERED, hdev, &ev, sizeof(ev), match.sk);
> +	ret = mgmt_event(MGMT_EV_NEW_SETTINGS, hdev, &ev, sizeof(ev),
> +								match.sk);
>  
>  	if (match.sk)
>  		sock_put(match.sk);
> @@ -2281,17 +2323,16 @@ int mgmt_powered(struct hci_dev *hdev, u8 powered)
>  
>  int mgmt_discoverable(struct hci_dev *hdev, u8 discoverable)
>  {
> -	struct mgmt_mode ev;
> -	struct cmd_lookup match = { discoverable, NULL };
> +	struct cmd_lookup match = { discoverable, NULL, hdev };
> +	__le32 ev;
>  	int ret;
>  
> -	mgmt_pending_foreach(MGMT_OP_SET_DISCOVERABLE, hdev, mode_rsp, &match);
> +	mgmt_pending_foreach(MGMT_OP_SET_DISCOVERABLE, hdev, settings_rsp, &match);
>  
> -	ev.val = discoverable;
> +	ev = cpu_to_le32(get_current_settings(hdev));
>  
> -	ret = mgmt_event(MGMT_EV_DISCOVERABLE, hdev, &ev, sizeof(ev),
> +	ret = mgmt_event(MGMT_EV_NEW_SETTINGS, hdev, &ev, sizeof(ev),
>  								match.sk);
> -
>  	if (match.sk)
>  		sock_put(match.sk);
>  
> @@ -2300,15 +2341,16 @@ int mgmt_discoverable(struct hci_dev *hdev, u8 discoverable)
>  
>  int mgmt_connectable(struct hci_dev *hdev, u8 connectable)
>  {
> -	struct mgmt_mode ev;
> -	struct cmd_lookup match = { connectable, NULL };
> +	__le32 ev;
> +	struct cmd_lookup match = { connectable, NULL, hdev };
>  	int ret;
>  
> -	mgmt_pending_foreach(MGMT_OP_SET_CONNECTABLE, hdev, mode_rsp, &match);
> +	mgmt_pending_foreach(MGMT_OP_SET_CONNECTABLE, hdev, settings_rsp,
> +								&match);
>  
> -	ev.val = connectable;
> +	ev = cpu_to_le32(get_current_settings(hdev));
>  
> -	ret = mgmt_event(MGMT_EV_CONNECTABLE, hdev, &ev, sizeof(ev), match.sk);
> +	ret = mgmt_event(MGMT_EV_NEW_SETTINGS, hdev, &ev, sizeof(ev), match.sk);
>  
>  	if (match.sk)
>  		sock_put(match.sk);
> -- 
> 1.7.7.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
