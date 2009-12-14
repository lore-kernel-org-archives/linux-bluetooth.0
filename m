Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/2] Bluetooth: Add locking scheme to timeout callbacks.
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Cc: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>,
	linux-bluetooth@vger.kernel.org, gustavo@padovan.org
In-Reply-To: <508e92ca0912140236t2c93a8a1q3aae97cf9e7bdfd@mail.gmail.com>
References: <1251085520-9094-1-git-send-email-gustavo@las.ic.unicamp.br>
	 <508e92ca0912140236t2c93a8a1q3aae97cf9e7bdfd@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 14 Dec 2009 09:53:03 -0800
Message-Id: <1260813183.4041.15.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> > Avoid race conditions when acessing the sock.
> >
> > Signed-off-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>
> > ---
> >  net/bluetooth/l2cap.c |    4 ++++
> >  1 files changed, 4 insertions(+), 0 deletions(-)
> >
> > diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> > index c04526f..efac637 100644
> > --- a/net/bluetooth/l2cap.c
> > +++ b/net/bluetooth/l2cap.c
> > @@ -1192,6 +1192,7 @@ static void l2cap_monitor_timeout(unsigned long arg)
> >        struct sock *sk = (void *) arg;
> >        u16 control;
> >
> > +       bh_lock_sock(sk);
> >        if (l2cap_pi(sk)->retry_count >= l2cap_pi(sk)->remote_max_tx) {
> >                l2cap_send_disconn_req(l2cap_pi(sk)->conn, sk);
> 
> missing unlock ?
> 
> >                return;
> > @@ -1203,6 +1204,7 @@ static void l2cap_monitor_timeout(unsigned long arg)
> >        control = L2CAP_CTRL_POLL;
> >        control |= L2CAP_SUPER_RCV_READY;
> >        l2cap_send_sframe(l2cap_pi(sk), control);
> > +       bh_unlock_sock(sk);
> >  }
> 
> Please consider following patch:
> 
> --- a/net/bluetooth/l2cap.c
> +++ b/net/bluetooth/l2cap.c
> @@ -1208,6 +1208,7 @@ static void l2cap_monitor_timeout(unsigned long arg)
>         bh_lock_sock(sk);
>         if (l2cap_pi(sk)->retry_count >= l2cap_pi(sk)->remote_max_tx) {
>                 l2cap_send_disconn_req(l2cap_pi(sk)->conn, sk);
> +               bh_unlock_sock(sk);
>                 return;
>         }
> 
> 
> Also see complete patch attached.

I am actually forgiving when people send patches as attachments since
sometimes the corporate email servers are just stupid. However gzipped
patches is where I draw the line. Please re-send it.

Regards

Marcel


