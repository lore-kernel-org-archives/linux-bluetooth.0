Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: [RFC 2/2] Bluetooth: Fix SCO cancelation before ACL is established
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1376501342-30347-2-git-send-email-frederic.dalleau@linux.intel.com>
Date: Fri, 16 Aug 2013 12:04:18 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <07B9AA1A-178C-49A7-BA0A-F3A658A576D7@holtmann.org>
References: <1376501342-30347-1-git-send-email-frederic.dalleau@linux.intel.com> <1376501342-30347-2-git-send-email-frederic.dalleau@linux.intel.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> If SCO socket is closed before ACL connection is established, it is
> possible to cancel the ongoing ACL connection setup. This happen
> automatically when the last reference to the ACL connection is dropped.
> Thus this patch simply drop the ACL connection.
> 
> Signed-off-by: Frédéric Dalleau <frederic.dalleau@linux.intel.com>
> ---
> include/net/bluetooth/hci_core.h |    1 +
> net/bluetooth/hci_conn.c         |   10 ++++++++++
> net/bluetooth/sco.c              |    4 +++-
> 3 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 1000553..a09556a 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -587,6 +587,7 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
> 			     __u8 dst_type, __u8 sec_level, __u8 auth_type);
> struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
> 				 __u16 setting);
> +void hci_cancel_sco(struct hci_conn *hconn);
> int hci_conn_check_link_mode(struct hci_conn *conn);
> int hci_conn_check_secure(struct hci_conn *conn, __u8 sec_level);
> int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type);
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index d3befac..c3ef7a5 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -639,6 +639,16 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
> 	return sco;
> }
> 
> +void hci_cancel_sco(struct hci_conn *hcon)
> +{
> +	struct hci_conn *acl = hcon->link;
> +
> +	if (acl && acl->handle == 0)

wouldn't it be better to check acl->state for BT_CONNECTED.

> +		hci_conn_drop(acl);
> +	else
> +		BT_DBG("ACL is already established");

And drop the debug here. Just write a proper comment into the code.

> +}
> +
> /* Create SCO, ACL or LE connection. */
> struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
> 			     __u8 dst_type, __u8 sec_level, __u8 auth_type)
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index e94e654..89491a2 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -364,8 +364,10 @@ static void __sco_sock_close(struct sock *sk)
> 			sco_chan_del(sk, ECONNRESET);
> 		break;
> 
> -	case BT_CONNECT2:
> 	case BT_CONNECT:
> +		if (sco_pi(sk)->conn->hcon)
> +			hci_cancel_sco(sco_pi(sk)->conn->hcon);
> +	case BT_CONNECT2:
> 	case BT_DISCONN:
> 		sco_chan_del(sk, ECONNRESET);
> 		break;

Regards

Marcel

