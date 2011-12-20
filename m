Return-Path: <cyrus@holtmann.org>
Message-ID: <1324414866.1965.133.camel@aeonflux>
Subject: Re: [PATCH 2/2] Bluetooth: Remove HCI_PRIO_MAX from ctrl cdm in
 RFCOMM
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 20 Dec 2011 13:01:06 -0800
In-Reply-To: <1324408558-24653-2-git-send-email-padovan@profusion.mobi>
References: <1324408558-24653-1-git-send-email-padovan@profusion.mobi>
	 <1324408558-24653-2-git-send-email-padovan@profusion.mobi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> RFCOMM needs a proper priority mechanism inside itself and not try to use
> l2cap priority to fix its own problem.

<snip>
 
>  static void rfcomm_make_uih(struct sk_buff *skb, u8 addr)
> @@ -1786,8 +1776,15 @@ static inline int rfcomm_process_tx(struct rfcomm_dlc *d)
>  		return skb_queue_len(&d->tx_queue);
>  
>  	while (d->tx_credits && (skb = skb_dequeue(&d->tx_queue))) {
> -		err = rfcomm_send_frame(d->session, skb->data, skb->len,
> -							skb->priority);
> +		struct socket *sock = d->session->sock;
> +		struct sock *sk = sock->sk;
> +
> +		if (sk->sk_priority != skb->priority) {
> +			lock_sock(sk);
> +			sk->sk_priority = skb->priority;
> +			release_sock(sk);
> +		}
> +		err = rfcomm_send_frame(d->session, skb->data, skb->len);
>  		if (err < 0) {
>  			skb_queue_head(&d->tx_queue, skb);
>  			break;

coming to think about this, we might not even bother setting the
sk->sk_priority at all here. Lets just forget about RFCOMM.

Regards

Marcel


