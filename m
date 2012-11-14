Return-Path: <cyrus@holtmann.org>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Message-id: <50A355CF.4030809@samsung.com>
Date: Wed, 14 Nov 2012 09:26:55 +0100
From: Michael Knudsen <m.knudsen@samsung.com>
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYWxsZWF1?=
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] Bluetooth: Add BT_DEFER_SETUP option to sco socket
References: <1352830825-13987-1-git-send-email-frederic.dalleau@linux.intel.com>
 <1352830825-13987-2-git-send-email-frederic.dalleau@linux.intel.com>
In-reply-to: <1352830825-13987-2-git-send-email-frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 2012-11-13 19:20, Frédéric Dalleau wrote:
> In order to authenticate and later configure an incoming SCO connection, the
> BT_DEFER_SETUP option is added.
> When an connection is requested, the listening socket is unblocked but the
> effective connection setup happens only on first recv.
> Any send between accept and recv fails with -ENOTCONN.

I have a few comments, please see below.

> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index ef5b85d..2ee0ecb 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -377,6 +377,7 @@ extern int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb,
>  			      u16 flags);
>  
>  extern int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr);
> +extern int sco_defer(struct hci_dev *hdev, bdaddr_t *bdaddr);

I would prefer to make sco_defer() static and call it from sco_connect_ind()
instead of as a separate step.  More on this below.

> +static inline int hci_proto_defered(struct hci_dev *hdev, bdaddr_t *bdaddr,
> +								__u8 type)
> +{
> +	switch (type) {
> +	case SCO_LINK:
> +	case ESCO_LINK:
> +		return sco_defer(hdev, bdaddr);
> +
> +	default:
> +		return 0;
> +	}
> +}

My idea is to define (I'm not sure if this is exactly the same as what you
suggested yourself) a bit, LM_DEFER, that e.g. sco_connect_ind() may return
and propagate this bit to hci_conn_request_evt().  This way all policing of
accepting SCO connections is handled from a single entry point into sco.c.

>  static inline void hci_proto_connect_cfm(struct hci_conn *conn, __u8 status)
>  {
>  	switch (conn->type) {

>  static void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
>  {
>  	struct hci_ev_conn_request *ev = (void *) skb->data;
>  	int mask = hdev->link_mode;
> +	int defered;
>  
>  	BT_DBG("%s bdaddr %pMR type 0x%x", hdev->name, &ev->bdaddr,
>  	       ev->link_type);
>  
>  	mask |= hci_proto_connect_ind(hdev, &ev->bdaddr, ev->link_type);
> +	defered = hci_proto_defered(hdev, &ev->bdaddr, ev->link_type);

Given that these two take exactly the same parameters, I would much
rather see hci_proto_defered() folded into hci_proto_connect_ind()
and set (LM_ACCEPT | LM_DEFERRED) for deferred cases.  This would
also make sure we only do one iteration over the SCO socket list and
that the same SCO sockets are taken into account.  With your approach
there is a risk that one of the loops is changed and not the other.

-m.
