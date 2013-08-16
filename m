Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: [RFC 1/2] Bluetooth: Fix SCO connection without socket
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1376501342-30347-1-git-send-email-frederic.dalleau@linux.intel.com>
Date: Fri, 16 Aug 2013 12:01:07 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <22B0C843-D02D-4AC6-9B24-FF08B19A1F61@holtmann.org>
References: <1376501342-30347-1-git-send-email-frederic.dalleau@linux.intel.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> If SCO socket is closed after ACL connection is established and before
> SCO is established, it is not possible to cancel the ongoing
> synchronous connection setup. When Synchronous Connection Complete
> event is triggered, there will be no socket ready. Drop connection if
> this is the case.
> 
> There is a side effect on this patch since it does not distinguish
> between outgoing and incoming sco connections. An incoming SCO
> connection with no acceptor will be dropped.
> 
> Signed-off-by: Frédéric Dalleau <frederic.dalleau@linux.intel.com>
> ---
> include/net/bluetooth/hci_core.h |   10 +++++++---
> net/bluetooth/hci_event.c        |    5 +++--
> net/bluetooth/sco.c              |   14 +++++++++-----
> 3 files changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 1f95e9b..1000553 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -376,7 +376,7 @@ extern int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb,
> 			      u16 flags);
> 
> extern int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags);
> -extern void sco_connect_cfm(struct hci_conn *hcon, __u8 status);
> +extern int sco_connect_cfm(struct hci_conn *hcon, __u8 status);
> extern void sco_disconn_cfm(struct hci_conn *hcon, __u8 reason);
> extern int sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb);
> 
> @@ -843,8 +843,10 @@ static inline int hci_proto_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr,
> 	}
> }
> 
> -static inline void hci_proto_connect_cfm(struct hci_conn *conn, __u8 status)
> +static inline int hci_proto_connect_cfm(struct hci_conn *conn, __u8 status)
> {
> +	int canceled = 0;
> +
> 	switch (conn->type) {
> 	case ACL_LINK:
> 	case LE_LINK:
> @@ -853,7 +855,7 @@ static inline void hci_proto_connect_cfm(struct hci_conn *conn, __u8 status)
> 
> 	case SCO_LINK:
> 	case ESCO_LINK:
> -		sco_connect_cfm(conn, status);
> +		canceled = sco_connect_cfm(conn, status);
> 		break;
> 
> 	default:
> @@ -863,6 +865,8 @@ static inline void hci_proto_connect_cfm(struct hci_conn *conn, __u8 status)
> 
> 	if (conn->connect_cfm_cb)
> 		conn->connect_cfm_cb(conn, status);
> +
> +	return canceled;
> }

why are we changing connect_cfm here and not just making connect_ind reject the connection.

Regards

Marcel

