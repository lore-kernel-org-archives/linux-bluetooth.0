Return-Path: <cyrus@holtmann.org>
Message-ID: <1349793574.27233.85.camel@aeonflux>
Subject: Re: [RFCv1 2/6] Bluetooth: AMP: Handle AMP_LINK timeout
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 09 Oct 2012 16:39:34 +0200
In-Reply-To: <1349707932-10006-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1349707932-10006-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1349707932-10006-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> When AMP_LINK timeouts execute HCI_OP_DISCONN_PHY_LINK as analog to
> HCI_OP_DISCONNECT for ACL_LINK.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/hci_conn.c |   35 ++++++++++++++++++++++++++++++++---
>  1 file changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 53202f6..3584f58 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -130,6 +130,20 @@ void hci_acl_disconn(struct hci_conn *conn, __u8 reason)
>  	hci_send_cmd(conn->hdev, HCI_OP_DISCONNECT, sizeof(cp), &cp);
>  }
>  
> +static void hci_amp_disconn(struct hci_conn *conn, __u8 reason)
> +{
> +	struct hci_cp_disconn_phy_link cp;
> +
> +	BT_DBG("hcon %p", conn);
> +
> +	conn->state = BT_DISCONN;
> +
> +	cp.phy_handle = (u8) conn->handle;

I rather not do this cast. Maybe having conn->phy_handle is cleaner or
some helper macro like HCI_PHY_HANDLE(conn->handle) or something. Or
just do conn->handle & 0xff.

> +	cp.reason = reason;
> +	hci_send_cmd(conn->hdev, HCI_OP_DISCONN_PHY_LINK,
> +		     sizeof(cp), &cp);
> +}
> +
>  static void hci_add_sco(struct hci_conn *conn, __u16 handle)
>  {
>  	struct hci_dev *hdev = conn->hdev;
> @@ -230,11 +244,27 @@ void hci_sco_setup(struct hci_conn *conn, __u8 status)
>  	}
>  }
>  
> +static void hci_conn_disconnect(struct hci_conn *conn)
> +{
> +	u8 reason;
> +
> +	reason = hci_proto_disconn_ind(conn);

Please keep using __u8 and in this case just make it one line.

	__u8 reason = hci_proto_disconn_ind(conn);

> +
> +	switch (conn->type) {
> +	case ACL_LINK:
> +		hci_acl_disconn(conn, reason);
> +		break;
> +

Don't bother with this empty line.

> +	case AMP_LINK:
> +		hci_amp_disconn(conn, reason);
> +		break;
> +	}
> +}
> +
>  static void hci_conn_timeout(struct work_struct *work)
>  {
>  	struct hci_conn *conn = container_of(work, struct hci_conn,
>  					     disc_work.work);
> -	__u8 reason;
>  
>  	BT_DBG("hcon %p state %s", conn, state_to_string(conn->state));
>  
> @@ -253,8 +283,7 @@ static void hci_conn_timeout(struct work_struct *work)
>  		break;
>  	case BT_CONFIG:
>  	case BT_CONNECTED:
> -		reason = hci_proto_disconn_ind(conn);
> -		hci_acl_disconn(conn, reason);
> +		hci_conn_disconnect(conn);
>  		break;
>  	default:
>  		conn->state = BT_CLOSED;

Regards

Marcel


