Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 May 2012 18:01:25 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Dean Jenkins <djenkins@mvista.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Proposal to remove the rfcomm session refcnt and use the rfcomm
 state machine to delete the session
Message-ID: <20120516150124.GD10880@aemeltch-MOBL1>
References: <CAJ2qBzYiTtLaDEnwqFMGS1JS+OuUaxTGrn70YE-oL3JnLi53Jg@mail.gmail.com>
 <CAJ2qBzbxL8r4x88DteVeR-P9ooXfsL81LQrUuwXxf1eK_zidug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJ2qBzbxL8r4x88DteVeR-P9ooXfsL81LQrUuwXxf1eK_zidug@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dean,

On Tue, May 15, 2012 at 07:25:02PM +0100, Dean Jenkins wrote:
> Signed-off-by: Dean Jenkins <djenkins@mvista.com>
> ---
>  net/bluetooth/rfcomm/core.c |   15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
> index 8a60238..d95c34e 100644
> --- a/net/bluetooth/rfcomm/core.c
> +++ b/net/bluetooth/rfcomm/core.c
> @@ -618,6 +618,15 @@ static struct rfcomm_session
> *rfcomm_session_add(struct socket *sock, int state)
>                         return NULL;
>                 }
> 
> +       /*
> +        * refcnt must be 1 before adding to the session list
> +        * otherwise threads such as rfcomm_security_cfm()
> +        * can interrupt and cause
> +        * rfcomm_session_hold() ... rfcomm_session_put() sequence to
> +        * erroneously delete the session structure.
> +        */
> +       rfcomm_session_hold(s);
> +
>         list_add(&s->list, &session_list);

This looks right to me.

> 
>         return s;
> @@ -678,6 +687,9 @@ static void rfcomm_session_close(struct
> rfcomm_session *s, int err)
> 
>         rfcomm_session_clear_timer(s);
>         rfcomm_session_put(s);
> +
> +       /* to match with initial session creation rfcomm_session_hold() */
> +       rfcomm_session_put(s);

Quickly looking to the changed it looks like refcounting is not changed
for accepting rfcomm but changed for connecting side. Have you tested both
situations?

>  }
> 
>  static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src,
> @@ -1905,8 +1917,6 @@ static inline void
> rfcomm_accept_connection(struct rfcomm_session *s)
> 
>         s = rfcomm_session_add(nsock, BT_OPEN);
>         if (s) {
> -               rfcomm_session_hold(s);
> -

this and 

>                 /* We should adjust MTU on incoming sessions.
>                  * L2CAP MTU minus UIH header and FCS. */
>                 s->mtu = min(l2cap_pi(nsock->sk)->chan->omtu,
> @@ -2027,7 +2037,6 @@ static int rfcomm_add_listener(bdaddr_t *ba)
>         if (!s)
>                 goto failed;
> 
> -       rfcomm_session_hold(s);

this looks OK given that we hold session when creating.

Also in the code there are places when we check is rfcomm session
initiator and then make refcounting which means something is wrong.

Best regards 
Andrei Emeltchenko 
