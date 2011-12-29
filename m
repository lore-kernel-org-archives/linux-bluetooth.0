Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1324414866.1965.133.camel@aeonflux>
References: <1324408558-24653-1-git-send-email-padovan@profusion.mobi>
	<1324408558-24653-2-git-send-email-padovan@profusion.mobi>
	<1324414866.1965.133.camel@aeonflux>
Date: Thu, 29 Dec 2011 17:16:55 +0200
Message-ID: <CABBYNZ+w0hqxHW2j4JrY_LQ8tG_aEy+Jk1TEXpixKo4aMbCQRA@mail.gmail.com>
Subject: Re: [PATCH 2/2] Bluetooth: Remove HCI_PRIO_MAX from ctrl cdm in RFCOMM
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo, Marcel,

On Tue, Dec 20, 2011 at 11:01 PM, Marcel Holtmann <marcel@holtmann.org> wro=
te:
> Hi Gustavo,
>
>> RFCOMM needs a proper priority mechanism inside itself and not try to us=
e
>> l2cap priority to fix its own problem.
>
> <snip>
>
>> =A0static void rfcomm_make_uih(struct sk_buff *skb, u8 addr)
>> @@ -1786,8 +1776,15 @@ static inline int rfcomm_process_tx(struct rfcomm=
_dlc *d)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return skb_queue_len(&d->tx_queue);
>>
>> =A0 =A0 =A0 while (d->tx_credits && (skb =3D skb_dequeue(&d->tx_queue)))=
 {
>> - =A0 =A0 =A0 =A0 =A0 =A0 err =3D rfcomm_send_frame(d->session, skb->dat=
a, skb->len,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 skb->priority);
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct socket *sock =3D d->session->sock;
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct sock *sk =3D sock->sk;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (sk->sk_priority !=3D skb->priority) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lock_sock(sk);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sk->sk_priority =3D skb->prior=
ity;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_sock(sk);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D rfcomm_send_frame(d->session, skb->dat=
a, skb->len);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err < 0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 skb_queue_head(&d->tx_queue,=
 skb);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>
> coming to think about this, we might not even bother setting the
> sk->sk_priority at all here. Lets just forget about RFCOMM.

I guess you guys don't remember, but I tried to explain why the
priority has to be set even for RFCOMM, any frame sent by the kernel
with a timeout needs to be scheduled as soon as possible otherwise it
may timeout due to quote being consumed by other channels with higher
priority, so in this case if an A2DP stream in ongoing you will never
be able to complete a RFCOMM connection because there wont be enough
quote to schedule them before they timeout (usually 10 out 10 attempt
end up like that in my setup).

Perhaps if we assign a dedicated queue/hci_chan per RFCOMM socket that
should get rid of this resetting sk_priority on every frame, but that
means not depending on socket API at all to pass frames from RFCOMM to
L2CAP, so we need an API to create L2CAP frames directly in RFCOMM
modules and queue them in its hci_chan.

--=20
Luiz Augusto von Dentz
