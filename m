Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH v1 1/7] Bluetooth: Add definitions for Add/Remove Advertising API
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1426906090-9026-2-git-send-email-armansito@chromium.org>
Date: Fri, 20 Mar 2015 20:29:46 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <1E3A0E66-1934-4347-83DE-069122DBA869@holtmann.org>
References: <1426906090-9026-1-git-send-email-armansito@chromium.org> <1426906090-9026-2-git-send-email-armansito@chromium.org>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

> This patch adds definitions for the Add Advertising and Remove
> Advertising MGMT commands and events.
> ---
> include/net/bluetooth/mgmt.h | 34 ++++++++++++++++++++++++++++++++++
> 1 file changed, 34 insertions(+)
> 
> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> index a1a6867..c18eab4 100644
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
> #define MGMT_EV_CMD_COMPLETE		0x0001
> struct mgmt_ev_cmd_complete {
> 	__le16	opcode;
> @@ -721,6 +745,16 @@ struct mgmt_ev_new_conn_param {
> 	__le16 timeout;
> } __packed;
> 
> +#define MGMT_EV_ADVERTISING_ADDED      0x0023
> +struct mgmt_ev_advertising_added {
> +	__u8    instance;
> +} __packed;
> +
> +#define MGMT_EV_ADVERTISING_REMOVED    0x0024
> +struct mgmt_ev_advertising_removed {
> +	__u8    instance;
> +} __packed;
> +
> #define MGMT_EV_UNCONF_INDEX_ADDED	0x001d
> 
> #define MGMT_EV_UNCONF_INDEX_REMOVED	0x001e

I have no idea why you sorted these two events wrongly. They come at the bottom after MGMT_EV_LOCAL_OOB_DATA_UPDATED.

Regards

Marcel

