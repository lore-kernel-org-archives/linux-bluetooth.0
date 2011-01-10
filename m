Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1294672348-5619-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1294672348-5619-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Mon, 10 Jan 2011 12:25:46 -0400
Message-ID: <AANLkTimoBiCHAgyLVEin4C_kFnzqGF_LyG312h-wM5fP@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Do not use assignments in IF conditions
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Jan 10, 2011 at 11:12 AM, Emeltchenko Andrei
<Andrei.Emeltchenko.news@gmail.com> wrote:
> @@ -224,7 +226,8 @@ static void cmtp_process_transmit(struct cmtp_session *session)
>        while ((skb = skb_dequeue(&session->transmit))) {
>                struct cmtp_scb *scb = (void *) skb->cb;
>
> -               if ((tail = (session->mtu - nskb->len)) < 5) {
> +               tail = (session->mtu - nskb->len);

You can drop the parenthesis above.

> +               if (tail < 5) {
>                        cmtp_send_frame(session, nskb->data, nskb->len);
>                        skb_trim(nskb, 0);
>                        tail = session->mtu;

> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> index c791fcd..3f080fa 100644
> --- a/net/bluetooth/l2cap.c
> +++ b/net/bluetooth/l2cap.c
> @@ -4692,7 +4692,11 @@ static int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 fl
>  {
>        struct l2cap_conn *conn = hcon->l2cap_data;
>
> -       if (!conn && !(conn = l2cap_conn_add(hcon, 0)))
> +       if (!conn)
> +               goto drop;
> +
> +       conn = l2cap_conn_add(hcon, 0);
> +       if (!conn)
>                goto drop;

I think the logic has been changed here. If hcon->l2cap_data is NULL,
it should try  l2cap_conn_add(hcon, 0), and if that fails, it goes to
drop. E.g.:

###
if (!conn)
     conn = l2cap_conn_add(hcon, 0);

if (!conn)
    goto drop;
###

Regards,
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil
