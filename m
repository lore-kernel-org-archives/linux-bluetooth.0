Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJ2qBzaXzU994y2iuOvB86mvHYV9fvOE20U-3m6fXkBLXY=reA@mail.gmail.com>
References: <CAJ2qBzYiTtLaDEnwqFMGS1JS+OuUaxTGrn70YE-oL3JnLi53Jg@mail.gmail.com>
	<CAJ2qBzbxL8r4x88DteVeR-P9ooXfsL81LQrUuwXxf1eK_zidug@mail.gmail.com>
	<20120516150124.GD10880@aemeltch-MOBL1>
	<CAJ2qBzaXzU994y2iuOvB86mvHYV9fvOE20U-3m6fXkBLXY=reA@mail.gmail.com>
Date: Fri, 18 May 2012 19:13:45 +0100
Message-ID: <CAJ2qBza0GkzS1usCrndspt3GYPqz9RMbYLBaeAME9+aL8FF7Aw@mail.gmail.com>
Subject: Re: Proposal to remove the rfcomm session refcnt and use the rfcomm
 state machine to delete the session
From: Dean Jenkins <djenkins@mvista.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This is a test patch that can be applied to the current Linux 3.3
rfcomm code to see that freed rfcomm session pointers are reused. My
prediction is that your kernel will hit a BUG(). Make sure you try
both target initiated and remote Bluetooth device initiated rfcomm
session and then disconnect the session from either the target or the
remote Bluetooth device. I believe one of those 4 scenarios will hit
the BUG(). I use an embedded ARM 2.6.34 solution so I am currently
unable to test on x86 with Linux 3.3. Most likely the BUG() is hit of
disconnection due to an imbalance of the refcnt resulting in early
deletion of the session.

If a freed rfcomm session pointer is reused then it has potential to
corrupt memory.

Please give this patch a go to see whether freed rfcomm session
pointers are reused in your kernel.

>From fc46a33d87a56463306433b781b5a78ee1441c97 Mon Sep 17 00:00:00 2001
From: Dean Jenkins <djenkins@mvista.com>
Date: Tue, 1 May 2012 16:15:44 +0100
Subject: [PATCH] Bluetooth: Add test for reuse of freed rfcomm session struct

Add free_flag element to the rfcomm session structure
and set free_flag to a magic number when the structure is
instantiated. Upon freeing. the free_flag is set
to zero.

When the rfcomm session structure is obtained, the
free_flag is checked to ensure the magic number is
still there, otherwise BUG() is called as the
structure is invalid, probably freed.

Signed-off-by: Dean Jenkins <djenkins@mvista.com>
---
 include/net/bluetooth/rfcomm.h |    6 ++++++
 net/bluetooth/rfcomm/core.c    |   24 +++++++++++++++++++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rfcomm.h
index e2e3eca..f5f82a1 100644
--- a/include/net/bluetooth/rfcomm.h
+++ b/include/net/bluetooth/rfcomm.h
@@ -152,6 +152,7 @@ struct rfcomm_msc {

 /* ---- Core structures, flags etc ---- */

+#define MAGIC_FREE     (0x5AA5)
 struct rfcomm_session {
        struct list_head list;
        struct socket   *sock;
@@ -166,6 +167,7 @@ struct rfcomm_session {
        uint   mtu;

        struct list_head dlcs;
+       unsigned int    free_flag;
 };

 struct rfcomm_dlc {
@@ -278,6 +280,10 @@ void   rfcomm_session_getaddr(struct
rfcomm_session *s, bdaddr_t *src,

 static inline void rfcomm_session_hold(struct rfcomm_session *s)
 {
+       /* is it a non-freed session ? */
+       if (s->free_flag != MAGIC_FREE)
+               BUG();
+
        atomic_inc(&s->refcnt);
 }

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 8a60238..aba2cc7 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -124,6 +124,10 @@ static inline void rfcomm_schedule(void)

 static inline void rfcomm_session_put(struct rfcomm_session *s)
 {
+       /* is it a non-freed session ? */
+       if (s->free_flag != MAGIC_FREE)
+               BUG();
+
        if (atomic_dec_and_test(&s->refcnt))
                rfcomm_session_del(s);
 }
@@ -599,6 +603,9 @@ static struct rfcomm_session
*rfcomm_session_add(struct socket *sock, int state)
        if (!s)
                return NULL;

+       /* all non-freed rfcomm sessions should have this flag set */
+       s->free_flag = MAGIC_FREE;
+
        BT_DBG("session %p sock %p", s, sock);

        setup_timer(&s->timer, rfcomm_session_timeout, (unsigned long) s);
@@ -627,6 +634,10 @@ static void rfcomm_session_del(struct rfcomm_session *s)
 {
        int state = s->state;

+       /* is this session already freed ? */
+       if (s->free_flag != MAGIC_FREE)
+               BUG();
+
        BT_DBG("session %p state %ld", s, s->state);

        list_del(&s->list);
@@ -636,6 +647,9 @@ static void rfcomm_session_del(struct rfcomm_session *s)

        rfcomm_session_clear_timer(s);
        sock_release(s->sock);
+
+       /* clear the flag to show that the session has been freed */
+       s->free_flag = 0;
        kfree(s);

        if (state != BT_LISTEN)
@@ -652,8 +666,12 @@ static struct rfcomm_session
*rfcomm_session_get(bdaddr_t *src, bdaddr_t *dst)
                sk = bt_sk(s->sock->sk);

                if ((!bacmp(src, BDADDR_ANY) || !bacmp(&sk->src, src)) &&
-                               !bacmp(&sk->dst, dst))
+                               !bacmp(&sk->dst, dst)) {
+                       /* is it a non-freed session ? */
+                       if (s->free_flag != MAGIC_FREE)
+                               BUG();
                        return s;
+               }
        }
        return NULL;
 }
@@ -1951,6 +1969,10 @@ static inline void rfcomm_process_sessions(void)
                struct rfcomm_session *s;
                s = list_entry(p, struct rfcomm_session, list);

+               /* is it a non-freed session ? */
+               if (s->free_flag != MAGIC_FREE)
+                       BUG();
+
                if (test_and_clear_bit(RFCOMM_TIMED_OUT, &s->flags)) {
                        s->state = BT_DISCONN;
                        rfcomm_send_disc(s, 0);
-- 
1.7.10.1

-- 
Dean Jenkins
Embedded Software Engineer
Professional Services UK/EMEA
MontaVista Software, LLC
