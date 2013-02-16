Return-Path: <cyrus@holtmann.org>
Message-ID: <1361053940.1583.14.camel@aeonflux>
Subject: Re: [RFC v2 3/8] Bluetooth: LE connection state machine
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 16 Feb 2013 23:32:20 +0100
In-Reply-To: <1360970828-24004-4-git-send-email-andre.guedes@openbossa.org>
References: <1360970828-24004-1-git-send-email-andre.guedes@openbossa.org>
	 <1360970828-24004-4-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch implements a state machine for carrying out the general
> connection establishment procedure described in Core spec.
> 
> The state machine should be used as follows: when the kernel
> receives a new LE connection attempt, it should go to HCI_CONN_LE_
> SCAN state, starting the passive LE scanning. Once the target remote
> device is in-range, it should go to HCI_CONN_LE_FOUND, stopping the
> ongoing LE scanning. After the LE scanning is disabled, it should go
> to HCI_CONN_LE_INITIATE state where the LE connection is created.
> 
> This state machine will be used by the LE connection routine in
> order to establish LE connections.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  include/net/bluetooth/hci_core.h | 13 +++++++++++++
>  net/bluetooth/hci_conn.c         | 26 ++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 48c28ca..c704737 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -300,6 +300,16 @@ struct hci_dev {
>  
>  #define HCI_PHY_HANDLE(handle)	(handle & 0xff)
>  
> +/*
> + * States from LE connection establishment state machine.
> + * State 0 is reserved and indicates the state machine is not running.
> + */
> +enum {
> +	HCI_CONN_LE_SCAN = 1,
> +	HCI_CONN_LE_FOUND,
> +	HCI_CONN_LE_INITIATE,
> +};
> +

and why don't we have HCI_CONN_LE_IDLE = 0 then. I do not get this magic
number handling when you introduce an enum anyway. You spent more time
explaining it with a comment instead of just using an extra enum entry.

>  struct hci_conn {
>  	struct list_head list;
>  
> @@ -356,6 +366,8 @@ struct hci_conn {
>  
>  	struct hci_conn	*link;
>  
> +	atomic_t	le_state;
> +

Why is this atomic_t. I am lost on what you are trying to solve here.
This requires a detailed explanation or you just get rid of it and use
the enum.

>  	void (*connect_cfm_cb)	(struct hci_conn *conn, u8 status);
>  	void (*security_cfm_cb)	(struct hci_conn *conn, u8 status);
>  	void (*disconn_cfm_cb)	(struct hci_conn *conn, u8 reason);
> @@ -599,6 +611,7 @@ int hci_conn_check_secure(struct hci_conn *conn, __u8 sec_level);
>  int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type);
>  int hci_conn_change_link_key(struct hci_conn *conn);
>  int hci_conn_switch_role(struct hci_conn *conn, __u8 role);
> +void hci_conn_set_le_state(struct hci_conn *conn, int state);

External state setting. That does not look like a good idea in the first
place. Why do you want to do it like this. Shouldn't be this self
contained.

>  
>  void hci_conn_enter_active_mode(struct hci_conn *conn, __u8 force_active);
>  
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 25bfce0..d54c2a0 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -391,6 +391,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
>  		    (unsigned long) conn);
>  
>  	atomic_set(&conn->refcnt, 0);
> +	atomic_set(&conn->le_state, 0);
>  
>  	hci_dev_hold(hdev);
>  
> @@ -1027,3 +1028,28 @@ struct hci_chan *hci_chan_lookup_handle(struct hci_dev *hdev, __u16 handle)
>  
>  	return hchan;
>  }
> +
> +void hci_conn_set_le_state(struct hci_conn *conn, int state)
> +{
> +	struct hci_dev *hdev = conn->hdev;
> +
> +	BT_DBG("conn %p state %d -> %d", conn, atomic_read(&conn->le_state),
> +	       state);
> +
> +	if (state == atomic_read(&conn->le_state))
> +		return;
> +
> +	switch (state) {
> +	case HCI_CONN_LE_SCAN:
> +		hci_le_scan(hdev, LE_SCAN_PASSIVE, 0x60, 0x30, 0);
> +		break;
> +	case HCI_CONN_LE_FOUND:
> +		hci_cancel_le_scan(hdev);
> +		break;
> +	case HCI_CONN_LE_INITIATE:
> +		hci_le_create_connection(conn);
> +		break;
> +	}
> +
> +	atomic_set(&conn->le_state, state);
> +}

The more I read this, the more I think this is the wrong approach to
this. The kernel should have a list of device it wants to connect to. If
that list is non-empty, start scanning, if one device is found, try to
connect it, once done, keep scanning if other devices are not connected.

You need to build a foundation for LE devices that the kernel wants to
connect to. And not hack in some state machinery.

And of course, can we please do proper error handling here. This whole
thing is broken. If any of the HCI commands fail, your state machine is
screwed up.

Regards

Marcel


