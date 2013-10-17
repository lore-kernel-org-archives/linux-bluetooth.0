Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [RFC 02/15] Bluetooth: Mgmt command for adding connection parameters
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1381965485-9159-3-git-send-email-andre.guedes@openbossa.org>
Date: Thu, 17 Oct 2013 11:22:39 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <BA029FAA-265C-47A8-953F-95E6B504941B@holtmann.org>
References: <1381965485-9159-1-git-send-email-andre.guedes@openbossa.org> <1381965485-9159-3-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch introduces a new Mgmt command (MGMT_OP_ADD_CONN_PARAM) which
> adds the connection parameters to controller's connection parameters
> list. These parameters will be used by the kernel when it establishes a
> connection with the given device.
> 
> This patch also moves the 'auto_connect' enum from hci_core.h to
> bluetooth.h since the will accessed used by userspace in order to
> send the MGMT_OP_ADD_CONN_PARAM command.

the comment about userspace makes no sense. And is not an argument to move the enum anywhere. Also if these are mgmt "modes" or "types" then they should be somewhere else and not in bluetooth.h.

> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
> include/net/bluetooth/bluetooth.h |  6 ++++++
> include/net/bluetooth/hci_core.h  |  6 +-----
> include/net/bluetooth/mgmt.h      |  9 +++++++++
> net/bluetooth/mgmt.c              | 35 +++++++++++++++++++++++++++++++++++
> 4 files changed, 51 insertions(+), 5 deletions(-)
> 
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index bf2ddff..8509520 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -354,4 +354,10 @@ void sco_exit(void);
> 
> void bt_sock_reclassify_lock(struct sock *sk, int proto);
> 
> +enum {
> +	BT_AUTO_CONN_DISABLED,
> +	BT_AUTO_CONN_ALWAYS,
> +	BT_AUTO_CONN_LINK_LOSS,
> +};
> +
> #endif /* __BLUETOOTH_H */
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 5052bf0..98be273 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -376,11 +376,7 @@ struct hci_conn_param {
> 	bdaddr_t addr;
> 	u8 addr_type;
> 
> -	enum {
> -		HCI_AUTO_CONN_DISABLED,
> -		HCI_AUTO_CONN_ALWAYS,
> -		HCI_AUTO_CONN_LINK_LOSS,
> -	} auto_connect;
> +	u8 auto_connect;
> 
> 	u16 min_conn_interval;
> 	u16 max_conn_interval;
> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> index 518c5c8..ed689b5 100644
> --- a/include/net/bluetooth/mgmt.h
> +++ b/include/net/bluetooth/mgmt.h
> @@ -369,6 +369,15 @@ struct mgmt_cp_set_scan_params {
> } __packed;
> #define MGMT_SET_SCAN_PARAMS_SIZE	4
> 
> +#define MGMT_OP_ADD_CONN_PARAM		0x002D
> +struct mgmt_cp_add_conn_param {
> +	struct mgmt_addr_info addr;
> +	__u8 auto_connect;
> +	__le16 min_conn_interval;
> +	__le16 max_conn_interval;
> +} __packed;
> +#define MGMT_ADD_CONN_PARAM_SIZE	(MGMT_ADDR_INFO_SIZE + 5)
> +
> #define MGMT_EV_CMD_COMPLETE		0x0001
> struct mgmt_ev_cmd_complete {
> 	__le16	opcode;
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index a727b47..5d1a2e8 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -79,6 +79,7 @@ static const u16 mgmt_commands[] = {
> 	MGMT_OP_SET_BREDR,
> 	MGMT_OP_SET_STATIC_ADDRESS,
> 	MGMT_OP_SET_SCAN_PARAMS,
> +	MGMT_OP_ADD_CONN_PARAM,
> };

So my 2nd patch wouldn't have been the mgmt command. I would have put all the cleanup and infrastructure changes in first. And I would have turned the connect() into the first user with a mode of "connect once" and default connection parameters.

This clearly shows later on where all this magic handling comes into place. But in the end, the connect() call is just a connect once type of passive scanning. And maybe with learned connection slave interval values from advertising data during the scanning.

The other problem that I have is that we can never update the parameters for a device. We need to remove them and re-add them. That is just not a good idea since we will almost certainly learn about updated values here. And maybe even change the mode of a device.

In general just having one Update Connection Parameters call might be better. The kernel can happily just expire values from connection once or disabled by itself. So this needs a bit more discussion. Doing the mgmt interface last would allow to get all the other patches merged. Otherwise you are stuck on the mgmt part until we figure that out.

> static const u16 mgmt_events[] = {
> @@ -4025,6 +4026,39 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
> 	return err;
> }
> 
> +static int add_conn_param(struct sock *sk, struct hci_dev *hdev, void *cp_data,
> +			  u16 len)
> +{
> +	struct mgmt_cp_add_conn_param *cp = cp_data;
> +	u8 status;
> +	u8 addr_type;
> +
> +	if (cp->addr.type == BDADDR_BREDR)
> +		return cmd_complete(sk, hdev->id, MGMT_OP_ADD_CONN_PARAM,
> +				    MGMT_STATUS_NOT_SUPPORTED, NULL, 0);

Instead of checking for BDADDR_BREDR it would be better to check for !bdaddr_type_is_le().

I really want everybody to get into the habit to do proper input validation. Not the half backed thing. That is why mgmt-tester can catch these kind of things easily and repeatedly.

> +
> +	status = mgmt_le_support(hdev);
> +	if (status)
> +		return cmd_complete(sk, hdev->id, MGMT_OP_ADD_CONN_PARAM,
> +				    status, NULL, 0);
> +
> +	if (cp->addr.type == BDADDR_LE_PUBLIC)
> +		addr_type = ADDR_LE_DEV_PUBLIC;
> +	else
> +		addr_type = ADDR_LE_DEV_RANDOM;
> +
> +	if (hci_add_conn_param(hdev, &cp->addr.bdaddr, addr_type,
> +			       cp->auto_connect,
> +			       __le16_to_cpu(cp->min_conn_interval),
> +			       __le16_to_cpu(cp->max_conn_interval)))
> +		status = MGMT_STATUS_FAILED;
> +	else
> +		status = MGMT_STATUS_SUCCESS;
> +
> +	return cmd_complete(sk, hdev->id, MGMT_OP_ADD_CONN_PARAM, status,
> +			    NULL, 0);
> +}
> +
> static const struct mgmt_handler {
> 	int (*func) (struct sock *sk, struct hci_dev *hdev, void *data,
> 		     u16 data_len);
> @@ -4076,6 +4110,7 @@ static const struct mgmt_handler {
> 	{ set_bredr,              false, MGMT_SETTING_SIZE },
> 	{ set_static_address,     false, MGMT_SET_STATIC_ADDRESS_SIZE },
> 	{ set_scan_params,        false, MGMT_SET_SCAN_PARAMS_SIZE },
> +	{ add_conn_param,         false, MGMT_ADD_CONN_PARAM_SIZE },
> };
> 

And btw. it is always plural "params". It is not single parameter.

Regards

Marcel

