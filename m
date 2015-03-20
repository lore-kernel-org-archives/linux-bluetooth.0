Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH 1/6] Bluetooth: Add definitions for Add/Remove Advertising mgmt commands
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1426809877-22469-2-git-send-email-armansito@chromium.org>
Date: Thu, 19 Mar 2015 17:47:52 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <CAD3DE6B-0856-4EF9-B2C7-0122E6097935@holtmann.org>
References: <1426809877-22469-1-git-send-email-armansito@chromium.org> <1426809877-22469-2-git-send-email-armansito@chromium.org>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

> This patch adds definitions for the Add Advertising and Remove
> Advertising MGMT commands with stubs that initially return
> "Not Supported" as command status.
> 
> Signed-off-by: Arman Uguray <armansito@chromium.org>
> ---
> include/net/bluetooth/mgmt.h | 24 ++++++++++++++++++++++++
> net/bluetooth/mgmt.c         | 25 +++++++++++++++++++++++++
> 2 files changed, 49 insertions(+)
> 
> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> index a1a6867..c60a408 100644
> --- a/include/net/bluetooth/mgmt.h
> +++ b/include/net/bluetooth/mgmt.h
> @@ -539,6 +539,30 @@ struct mgmt_rp_read_adv_features {
> 	__u8   instance[0];
> } __packed;
> 
> +#define MGMT_OP_ADD_ADVERTISING		0x003E
> +struct mgmt_cp_add_advertising {
> +	__u8	instance;
> +	__le32	flags;
> +	__le16	duration;
> +	__le16	timeout;
> +	__u8	adv_data_len;
> +	__u8	scan_rsp_len;
> +	__u8	data[0];
> +} __packed;
> +#define MGMT_ADD_ADVERTISING_SIZE	11
> +struct mgmt_rp_add_advertising {
> +	__u8	instance;
> +} __packed;
> +
> +#define MGMT_OP_REMOVE_ADVERTISING	0x003F
> +struct mgmt_cp_remove_advertising {
> +	__u8	instance;
> +} __packed;
> +#define MGMT_REMOVE_ADVERTISING_SIZE	1
> +struct mgmt_rp_remove_advertising {
> +	__u8	instance;
> +} __packed;
> +

this looks good. I would just include the event data structs and constants here as well. They can come as a single patch.

> #define MGMT_EV_CMD_COMPLETE		0x0001
> struct mgmt_ev_cmd_complete {
> 	__le16	opcode;
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index f3a9579..467cac9 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -100,6 +100,8 @@ static const u16 mgmt_commands[] = {
> 	MGMT_OP_READ_LOCAL_OOB_EXT_DATA,
> 	MGMT_OP_READ_EXT_INDEX_LIST,
> 	MGMT_OP_READ_ADV_FEATURES,
> +	MGMT_OP_ADD_ADVERTISING,
> +	MGMT_OP_REMOVE_ADVERTISING,
> };
> 
> static const u16 mgmt_events[] = {
> @@ -6315,6 +6317,26 @@ static int read_adv_features(struct sock *sk, struct hci_dev *hdev,
> 	return err;
> }
> 
> +static int add_advertising(struct sock *sk, struct hci_dev *hdev,
> +			   void *data, u16 data_len)
> +{
> +	BT_DBG("%s", hdev->name);
> +
> +	/* TODO: Implement this command. */
> +	return mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
> +			       MGMT_STATUS_NOT_SUPPORTED);
> +}
> +
> +static int remove_advertising(struct sock *sk, struct hci_dev *hdev,
> +			      void *data, u16 data_len)
> +{
> +	BT_DBG("%s", hdev->name);
> +
> +	/* TODO: Implement this command. */
> +	return mgmt_cmd_status(sk, hdev->id, MGMT_OP_REMOVE_ADVERTISING,
> +			       MGMT_STATUS_NOT_SUPPORTED);
> +}

Lets not do this. Just add the structs and constants and then add the implementation in the next patch. Doing it with an empty stub just creates noise in the patchset and we have not done it that way in the past. At least not for kernel code.

Regards

Marcel

