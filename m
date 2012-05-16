Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120516150124.GD10880@aemeltch-MOBL1>
References: <CAJ2qBzYiTtLaDEnwqFMGS1JS+OuUaxTGrn70YE-oL3JnLi53Jg@mail.gmail.com>
	<CAJ2qBzbxL8r4x88DteVeR-P9ooXfsL81LQrUuwXxf1eK_zidug@mail.gmail.com>
	<20120516150124.GD10880@aemeltch-MOBL1>
Date: Wed, 16 May 2012 19:38:02 +0100
Message-ID: <CAJ2qBzaXzU994y2iuOvB86mvHYV9fvOE20U-3m6fXkBLXY=reA@mail.gmail.com>
Subject: Re: Proposal to remove the rfcomm session refcnt and use the rfcomm
 state machine to delete the session
From: Dean Jenkins <djenkins@mvista.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	Dean Jenkins <djenkins@mvista.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

Thanks for your comments.

On 16 May 2012 16:01, Andrei Emeltchenko
<andrei.emeltchenko.news@gmail.com> wrote:
>
> Hi Dean,
>
> On Tue, May 15, 2012 at 07:25:02PM +0100, Dean Jenkins wrote:
> > Signed-off-by: Dean Jenkins <djenkins@mvista.com>
> > ---
> >  net/bluetooth/rfcomm/core.c |   15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
> > index 8a60238..d95c34e 100644
> > --- a/net/bluetooth/rfcomm/core.c
> > +++ b/net/bluetooth/rfcomm/core.c
> > @@ -618,6 +618,15 @@ static struct rfcomm_session
> > *rfcomm_session_add(struct socket *sock, int state)
> >                         return NULL;
> >                 }
> >
> > +       /*
> > +        * refcnt must be 1 before adding to the session list
> > +        * otherwise threads such as rfcomm_security_cfm()
> > +        * can interrupt and cause
> > +        * rfcomm_session_hold() ... rfcomm_session_put() sequence to
> > +        * erroneously delete the session structure.
> > +        */
> > +       rfcomm_session_hold(s);
> > +
> >         list_add(&s->list, &session_list);
>
> This looks right to me.
>
> >
> >         return s;
> > @@ -678,6 +687,9 @@ static void rfcomm_session_close(struct
> > rfcomm_session *s, int err)
> >
> >         rfcomm_session_clear_timer(s);
> >         rfcomm_session_put(s);
> > +
> > +       /* to match with initial session creation rfcomm_session_hold() */
> > +       rfcomm_session_put(s);
>
> Quickly looking to the changed it looks like refcounting is not changed
> for accepting rfcomm but changed for connecting side. Have you tested both
> situations?
>
Yes, without that line, connections do not disconnect. I have a
feeling that a freed session pointer is reused in one connection
direction and that accounts for the out by 1 refcnt value. I'll try to
repeat that analysis.

>
> >  }
> >
> >  static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src,
> > @@ -1905,8 +1917,6 @@ static inline void
> > rfcomm_accept_connection(struct rfcomm_session *s)
> >
> >         s = rfcomm_session_add(nsock, BT_OPEN);
> >         if (s) {
> > -               rfcomm_session_hold(s);
> > -
>
> this and
>
> >                 /* We should adjust MTU on incoming sessions.
> >                  * L2CAP MTU minus UIH header and FCS. */
> >                 s->mtu = min(l2cap_pi(nsock->sk)->chan->omtu,
> > @@ -2027,7 +2037,6 @@ static int rfcomm_add_listener(bdaddr_t *ba)
> >         if (!s)
> >                 goto failed;
> >
> > -       rfcomm_session_hold(s);
>
> this looks OK given that we hold session when creating.
>
> Also in the code there are places when we check is rfcomm session
> initiator and then make refcounting which means something is wrong.
>
Indeed something is wrong, connection and disconnection procedures are
independent of each other so there should be no need to check the
initiator flag.

> Best regards
> Andrei Emeltchenko

The above is my conservative fix. Here are 2 radical patches that
remove the refcnt and pass back the s pointer up the call stack to
prevent freed session pointers from being reused. I suspect reuse of
freed session pointers occurs in the original code, I have a debug
patch (not shown) that demonstrates reuse of the freed session
pointers.

Patch1: Remove refcnt...

>From 7a6b05055c92af709972421c66d2ecd88b23e738 Mon Sep 17 00:00:00 2001
From: Dean Jenkins <djenkins@mvista.com>
Date: Fri, 11 May 2012 09:35:49 +0100
Subject: [PATCH 1/2] Bluetooth: remove rfcomm session refcnt

The rfcomm session refcnt is unworkable as it is hard
to predict the program flow during abnormal protocol conditions
so is easy for the refcnt to be out-of-sync.

Therefore, rely on the rfcomm state machine to absolutely delete
the rfcomm session at the right time.

Signed-off-by: Dean Jenkins <djenkins@mvista.com>
---
 include/net/bluetooth/rfcomm.h |    6 -----
 net/bluetooth/rfcomm/core.c    |   50 ++++------------------------------------
 2 files changed, 5 insertions(+), 51 deletions(-)

diff --git a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rfcomm.h
index e2e3eca..7afd419 100644
--- a/include/net/bluetooth/rfcomm.h
+++ b/include/net/bluetooth/rfcomm.h
@@ -158,7 +158,6 @@ struct rfcomm_session {
        struct timer_list timer;
        unsigned long    state;
        unsigned long    flags;
-       atomic_t         refcnt;
        int              initiator;

        /* Default DLC parameters */
@@ -276,11 +275,6 @@ static inline void rfcomm_dlc_unthrottle(struct
rfcomm_dlc *d)
 void   rfcomm_session_getaddr(struct rfcomm_session *s, bdaddr_t *src,
                                                                bdaddr_t *dst);

-static inline void rfcomm_session_hold(struct rfcomm_session *s)
-{
-       atomic_inc(&s->refcnt);
-}
-
 /* ---- RFCOMM sockets ---- */
 struct sockaddr_rc {
        sa_family_t     rc_family;
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 8a60238..9fc5a90 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -122,12 +122,6 @@ static inline void rfcomm_schedule(void)
        wake_up_process(rfcomm_thread);
 }

-static inline void rfcomm_session_put(struct rfcomm_session *s)
-{
-       if (atomic_dec_and_test(&s->refcnt))
-               rfcomm_session_del(s);
-}
-
 /* ---- RFCOMM FCS computation ---- */

 /* reversed, 8-bit, poly=0x07 */
@@ -263,16 +257,15 @@ static void rfcomm_session_set_timer(struct
rfcomm_session *s, long timeout)
 {
        BT_DBG("session %p state %ld timeout %ld", s, s->state, timeout);

-       if (!mod_timer(&s->timer, jiffies + timeout))
-               rfcomm_session_hold(s);
+       mod_timer(&s->timer, jiffies + timeout);
 }

 static void rfcomm_session_clear_timer(struct rfcomm_session *s)
 {
        BT_DBG("session %p state %ld", s, s->state);

-       if (timer_pending(&s->timer) && del_timer(&s->timer))
-               rfcomm_session_put(s);
+       if (timer_pending(&s->timer))
+               del_timer(&s->timer);
 }

 /* ---- RFCOMM DLCs ---- */
@@ -350,8 +343,6 @@ static void rfcomm_dlc_link(struct rfcomm_session
*s, struct rfcomm_dlc *d)
 {
        BT_DBG("dlc %p session %p", d, s);

-       rfcomm_session_hold(s);
-
        rfcomm_session_clear_timer(s);
        rfcomm_dlc_hold(d);
        list_add(&d->list, &s->dlcs);
@@ -370,8 +361,6 @@ static void rfcomm_dlc_unlink(struct rfcomm_dlc *d)

        if (list_empty(&s->dlcs))
                rfcomm_session_set_timer(s, RFCOMM_IDLE_TIMEOUT);
-
-       rfcomm_session_put(s);
 }

 static struct rfcomm_dlc *rfcomm_dlc_get(struct rfcomm_session *s, u8 dlci)
@@ -665,8 +654,6 @@ static void rfcomm_session_close(struct
rfcomm_session *s, int err)

        BT_DBG("session %p state %ld err %d", s, s->state, err);

-       rfcomm_session_hold(s);
-
        s->state = BT_CLOSED;

        /* Close all dlcs */
@@ -676,8 +663,7 @@ static void rfcomm_session_close(struct
rfcomm_session *s, int err)
                __rfcomm_dlc_close(d, err);
        }

-       rfcomm_session_clear_timer(s);
-       rfcomm_session_put(s);
+       rfcomm_session_del(s);
 }

 static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src,
@@ -1164,18 +1150,7 @@ static int rfcomm_recv_ua(struct rfcomm_session
*s, u8 dlci)
                        break;

                case BT_DISCONN:
-                       /* rfcomm_session_put is called later so don't do
-                        * anything here otherwise we will mess up the session
-                        * reference counter:
-                        *
-                        * (a) when we are the initiator dlc_unlink will drive
-                        * the reference counter to 0 (there is no initial put
-                        * after session_add)
-                        *
-                        * (b) when we are not the initiator rfcomm_rx_process
-                        * will explicitly call put to balance the initial hold
-                        * done after session add.
-                        */
+                       rfcomm_session_del(s);
                        break;
                }
        }
@@ -1876,9 +1851,6 @@ static inline void rfcomm_process_rx(struct
rfcomm_session *s)
        }

        if (sk->sk_state == BT_CLOSED) {
-               if (!s->initiator)
-                       rfcomm_session_put(s);
-
                rfcomm_session_close(s, sk->sk_err);
        }
 }
@@ -1905,8 +1877,6 @@ static inline void
rfcomm_accept_connection(struct rfcomm_session *s)

        s = rfcomm_session_add(nsock, BT_OPEN);
        if (s) {
-               rfcomm_session_hold(s);
-
                /* We should adjust MTU on incoming sessions.
                 * L2CAP MTU minus UIH header and FCS. */
                s->mtu = min(l2cap_pi(nsock->sk)->chan->omtu,
@@ -1954,7 +1924,6 @@ static inline void rfcomm_process_sessions(void)
                if (test_and_clear_bit(RFCOMM_TIMED_OUT, &s->flags)) {
                        s->state = BT_DISCONN;
                        rfcomm_send_disc(s, 0);
-                       rfcomm_session_put(s);
                        continue;
                }

@@ -1963,8 +1932,6 @@ static inline void rfcomm_process_sessions(void)
                        continue;
                }

-               rfcomm_session_hold(s);
-
                switch (s->state) {
                case BT_BOUND:
                        rfcomm_check_connection(s);
@@ -1976,8 +1943,6 @@ static inline void rfcomm_process_sessions(void)
                }

                rfcomm_process_dlcs(s);
-
-               rfcomm_session_put(s);
        }

        rfcomm_unlock();
@@ -2027,7 +1992,6 @@ static int rfcomm_add_listener(bdaddr_t *ba)
        if (!s)
                goto failed;

-       rfcomm_session_hold(s);
        return 0;
 failed:
        sock_release(sock);
@@ -2085,8 +2049,6 @@ static void rfcomm_security_cfm(struct hci_conn
*conn, u8 status, u8 encrypt)
        if (!s)
                return;

-       rfcomm_session_hold(s);
-
        list_for_each_safe(p, n, &s->dlcs) {
                d = list_entry(p, struct rfcomm_dlc, list);

@@ -2118,8 +2080,6 @@ static void rfcomm_security_cfm(struct hci_conn
*conn, u8 status, u8 encrypt)
                        set_bit(RFCOMM_AUTH_REJECT, &d->flags);
        }

-       rfcomm_session_put(s);
-
        rfcomm_schedule();
 }

-- 
1.7.10.1

Patch2: Pass the s pointer back up the call stack to prevent reuse of
the freed session structure...

>From e5d68ffc5c856c9dad7af65a2e7bb2ed35a2c6fc Mon Sep 17 00:00:00 2001
From: Dean Jenkins <djenkins@mvista.com>
Date: Fri, 11 May 2012 12:21:17 +0100
Subject: [PATCH 2/2] Bluetooth: return rfcomm session pointers to avoid freed
 session

Unfortunately, the design retains copies of the s rfcomm session
pointer in various code blocks and this invites the reuse of a
freed session pointer.

Therefore, return the rfcomm session pointer back up the call stack
to avoid reusing a freed rfcomm session pointer. When the rfcomm
session is deleted, NULL is passed up the call stack.

Signed-off-by: Dean Jenkins <djenkins@mvista.com>
---
 net/bluetooth/rfcomm/core.c |   85 ++++++++++++++++++++++++++-----------------
 1 file changed, 52 insertions(+), 33 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 9fc5a90..af5dfa6 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -83,7 +83,7 @@ static struct rfcomm_session
*rfcomm_session_create(bdaddr_t *src,
                                                        u8 sec_level,
                                                        int *err);
 static struct rfcomm_session *rfcomm_session_get(bdaddr_t *src, bdaddr_t *dst);
-static void rfcomm_session_del(struct rfcomm_session *s);
+static struct rfcomm_session *rfcomm_session_del(struct rfcomm_session *s);

 /* ---- RFCOMM frame parsing macros ---- */
 #define __get_dlci(b)     ((b & 0xfc) >> 2)
@@ -612,9 +612,13 @@ static struct rfcomm_session
*rfcomm_session_add(struct socket *sock, int state)
        return s;
 }

-static void rfcomm_session_del(struct rfcomm_session *s)
+static struct rfcomm_session *rfcomm_session_del(struct rfcomm_session *s)
 {
-       int state = s->state;
+       int state;
+
+       BUG_ON(s == NULL);
+
+       state = s->state;

        BT_DBG("session %p state %ld", s, s->state);

@@ -629,6 +633,8 @@ static void rfcomm_session_del(struct rfcomm_session *s)

        if (state != BT_LISTEN)
                module_put(THIS_MODULE);
+
+       return NULL;
 }

 static struct rfcomm_session *rfcomm_session_get(bdaddr_t *src, bdaddr_t *dst)
@@ -647,11 +653,13 @@ static struct rfcomm_session
*rfcomm_session_get(bdaddr_t *src, bdaddr_t *dst)
        return NULL;
 }

-static void rfcomm_session_close(struct rfcomm_session *s, int err)
+static struct rfcomm_session *rfcomm_session_close(struct
rfcomm_session *s, int err)
 {
        struct rfcomm_dlc *d;
        struct list_head *p, *n;

+       BUG_ON(s == NULL);
+
        BT_DBG("session %p state %ld err %d", s, s->state, err);

        s->state = BT_CLOSED;
@@ -663,7 +671,7 @@ static void rfcomm_session_close(struct
rfcomm_session *s, int err)
                __rfcomm_dlc_close(d, err);
        }

-       rfcomm_session_del(s);
+       return rfcomm_session_del(s);
 }

 static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src,
@@ -715,8 +723,7 @@ static struct rfcomm_session
*rfcomm_session_create(bdaddr_t *src,
        if (*err == 0 || *err == -EINPROGRESS)
                return s;

-       rfcomm_session_del(s);
-       return NULL;
+       return rfcomm_session_del(s);

 failed:
        sock_release(sock);
@@ -1105,7 +1112,7 @@ static void rfcomm_make_uih(struct sk_buff *skb, u8 addr)
 }

 /* ---- RFCOMM frame reception ---- */
-static int rfcomm_recv_ua(struct rfcomm_session *s, u8 dlci)
+static struct rfcomm_session *rfcomm_recv_ua(struct rfcomm_session *s, u8 dlci)
 {
        BT_DBG("session %p state %ld dlci %d", s, s->state, dlci);

@@ -1114,7 +1121,7 @@ static int rfcomm_recv_ua(struct rfcomm_session
*s, u8 dlci)
                struct rfcomm_dlc *d = rfcomm_dlc_get(s, dlci);
                if (!d) {
                        rfcomm_send_dm(s, dlci);
-                       return 0;
+                       return s;
                }

                switch (d->state) {
@@ -1150,14 +1157,14 @@ static int rfcomm_recv_ua(struct
rfcomm_session *s, u8 dlci)
                        break;

                case BT_DISCONN:
-                       rfcomm_session_del(s);
+                       s = rfcomm_session_del(s);
                        break;
                }
        }
-       return 0;
+       return s;
 }

-static int rfcomm_recv_dm(struct rfcomm_session *s, u8 dlci)
+static struct rfcomm_session *rfcomm_recv_dm(struct rfcomm_session *s, u8 dlci)
 {
        int err = 0;

@@ -1182,12 +1189,12 @@ static int rfcomm_recv_dm(struct
rfcomm_session *s, u8 dlci)
                        err = ECONNRESET;

                s->state = BT_CLOSED;
-               rfcomm_session_close(s, err);
+               s = rfcomm_session_close(s, err);
        }
-       return 0;
+       return s;
 }

-static int rfcomm_recv_disc(struct rfcomm_session *s, u8 dlci)
+static struct rfcomm_session *rfcomm_recv_disc(struct rfcomm_session
*s, u8 dlci)
 {
        int err = 0;

@@ -1217,10 +1224,10 @@ static int rfcomm_recv_disc(struct
rfcomm_session *s, u8 dlci)
                        err = ECONNRESET;

                s->state = BT_CLOSED;
-               rfcomm_session_close(s, err);
+               s = rfcomm_session_close(s, err);
        }

-       return 0;
+       return s;
 }

 void rfcomm_dlc_accept(struct rfcomm_dlc *d)
@@ -1641,11 +1648,17 @@ drop:
        return 0;
 }

-static int rfcomm_recv_frame(struct rfcomm_session *s, struct sk_buff *skb)
+static struct rfcomm_session *rfcomm_recv_frame(struct rfcomm_session
*s, struct sk_buff *skb)
 {
        struct rfcomm_hdr *hdr = (void *) skb->data;
        u8 type, dlci, fcs;

+       if (!s) {
+               /* no session, so free socket data */
+               kfree_skb(skb);
+               return s;
+       }
+
        dlci = __get_dlci(hdr->addr);
        type = __get_type(hdr->ctrl);

@@ -1656,7 +1669,7 @@ static int rfcomm_recv_frame(struct
rfcomm_session *s, struct sk_buff *skb)
        if (__check_fcs(skb->data, type, fcs)) {
                BT_ERR("bad checksum in packet");
                kfree_skb(skb);
-               return -EILSEQ;
+               return s;
        }

        if (__test_ea(hdr->len))
@@ -1672,22 +1685,23 @@ static int rfcomm_recv_frame(struct
rfcomm_session *s, struct sk_buff *skb)

        case RFCOMM_DISC:
                if (__test_pf(hdr->ctrl))
-                       rfcomm_recv_disc(s, dlci);
+                       s = rfcomm_recv_disc(s, dlci);
                break;

        case RFCOMM_UA:
                if (__test_pf(hdr->ctrl))
-                       rfcomm_recv_ua(s, dlci);
+                       s = rfcomm_recv_ua(s, dlci);
                break;

        case RFCOMM_DM:
-               rfcomm_recv_dm(s, dlci);
+               s = rfcomm_recv_dm(s, dlci);
                break;

        case RFCOMM_UIH:
-               if (dlci)
-                       return rfcomm_recv_data(s, dlci,
__test_pf(hdr->ctrl), skb);
-
+               if (dlci) {
+                       rfcomm_recv_data(s, dlci, __test_pf(hdr->ctrl), skb);
+                       return s;
+               }
                rfcomm_recv_mcc(s, skb);
                break;

@@ -1696,7 +1710,7 @@ static int rfcomm_recv_frame(struct
rfcomm_session *s, struct sk_buff *skb)
                break;
        }
        kfree_skb(skb);
-       return 0;
+       return s;
 }

 /* ---- Connection and data processing ---- */
@@ -1778,6 +1792,8 @@ static inline void rfcomm_process_dlcs(struct
rfcomm_session *s)
        struct rfcomm_dlc *d;
        struct list_head *p, *n;

+       BUG_ON(s == NULL);
+
        BT_DBG("session %p state %ld", s, s->state);

        list_for_each_safe(p, n, &s->dlcs) {
@@ -1833,7 +1849,7 @@ static inline void rfcomm_process_dlcs(struct
rfcomm_session *s)
        }
 }

-static inline void rfcomm_process_rx(struct rfcomm_session *s)
+static inline struct rfcomm_session *rfcomm_process_rx(struct
rfcomm_session *s)
 {
        struct socket *sock = s->sock;
        struct sock *sk = sock->sk;
@@ -1845,14 +1861,16 @@ static inline void rfcomm_process_rx(struct
rfcomm_session *s)
        while ((skb = skb_dequeue(&sk->sk_receive_queue))) {
                skb_orphan(skb);
                if (!skb_linearize(skb))
-                       rfcomm_recv_frame(s, skb);
+                       s = rfcomm_recv_frame(s, skb);
                else
                        kfree_skb(skb);
        }

-       if (sk->sk_state == BT_CLOSED) {
-               rfcomm_session_close(s, sk->sk_err);
+       if (s && (sk->sk_state == BT_CLOSED)) {
+               s = rfcomm_session_close(s, sk->sk_err);
        }
+
+       return s;
 }

 static inline void rfcomm_accept_connection(struct rfcomm_session *s)
@@ -1906,7 +1924,7 @@ static inline void
rfcomm_check_connection(struct rfcomm_session *s)

        case BT_CLOSED:
                s->state = BT_CLOSED;
-               rfcomm_session_close(s, sk->sk_err);
+               s = rfcomm_session_close(s, sk->sk_err);
                break;
        }
 }
@@ -1938,11 +1956,12 @@ static inline void rfcomm_process_sessions(void)
                        break;

                default:
-                       rfcomm_process_rx(s);
+                       s = rfcomm_process_rx(s);
                        break;
                }

-               rfcomm_process_dlcs(s);
+               if(s)
+                       rfcomm_process_dlcs(s);
        }

        rfcomm_unlock();
-- 
1.7.10.1

Is it too radical ?

Do you agree that the refcnt is redundant and that the rfcomm session
state machine is sufficient to delete the session at the right time ?

Please provide comments.

Thanks in advance.

Regards,
Dean
--
Dean Jenkins
Embedded Software Engineer
Professional Services UK/EMEA
MontaVista Software, LLC
