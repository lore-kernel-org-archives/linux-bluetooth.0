Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJ2qBzYiTtLaDEnwqFMGS1JS+OuUaxTGrn70YE-oL3JnLi53Jg@mail.gmail.com>
References: <CAJ2qBzYiTtLaDEnwqFMGS1JS+OuUaxTGrn70YE-oL3JnLi53Jg@mail.gmail.com>
Date: Tue, 15 May 2012 19:25:02 +0100
Message-ID: <CAJ2qBzbxL8r4x88DteVeR-P9ooXfsL81LQrUuwXxf1eK_zidug@mail.gmail.com>
Subject: Re: Proposal to remove the rfcomm session refcnt and use the rfcomm
 state machine to delete the session
From: Dean Jenkins <djenkins@mvista.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 14 May 2012 13:25, Dean Jenkins <djenkins@mvista.com> wrote:
> Hi,
>
> I have been working on an ARM based project that uses kernel Bluez
> from 2.6.34 plus some backports includes some upstream refcnt fixes
> from Linux 3.3. Note our project still uses the tasklet rather than
> the new workqueue design.
>
> My analysis indicates that the rfcomm session refcnt is fighting
> against the rfcomm state machine. In particular, failure occurs under
> high processor loads causing the run-time order of rfcomm threads to
> change resulting in erroneous deletion of the rfcomm session,
> "scheduling whilst atomic" warnings and reuse of the freed s session
> pointer by the rfcomm state machine. Actually, my analysis suggests
> that in normal operations when the target initiates the connection,
> the normal target disconnection procedure always accesses a freed s
> pointer.
>
> I have not fully analysed Bluez in the Linux 3.3 kernel but I can see
> that the refcnt weaknesses are still in Linux 3.3. My impression is
> that imbalance issues with the rfcomm session refcnt have been going
> on for some time, perhaps 18 months, and there have been various
> attempts at resolving it. One of the recent upstream refcnt fixes I
> have doubts about as it caused connections to not disconnect in my
> environment.
>
> I have had some success in resolving one root cause of the session
> refcnt failures. I am confident this issue is still in Linux 3.3.
>
> However, my more radical working solution is to completely remove the
> session refcnt. My reasoning is that the rfcomm state machine is
> sufficient to know when to delete the session. Indeed, it can be seen
> that the rfcomm_session_close() and rfcomm_session_del() functions
> already exist. In addition, to avoid, reuse of the freed s session
> pointer, modify some functions to pass back the s session pointer up
> the call stack, this updates the s pointer in the higher functions
> preventing reuse of a freed s pointer.
>
> My environment is not Linux 3.3 so my patches are not currently for
> the latest Bluez. If the community is interested, I will try to
> forward port the patches to Linux 3.3 and provide them in a separate
> E-mail but untested, at least initially. I am willing to work with the
> community to get my changes into the kernel.
>
> If the removal of the refcnt is too radical for the community then I
> am happy to explain one root cause of the refcnt failures and to
> provide patches for that solution.
>
> Therefore, please can community members respond to my outline
> proposals so that we can start a constructive discussion. MontaVista
> is happy to contribute our changes to Bluez.
>
> Thanks in advance.
>
> Regards,
> Dean
>
> --
> Dean Jenkins
> Embedded Software Engineer
> Professional Services UK/EMEA
> MontaVista Software, LLC

Here is a proposed workaround patch to "fix" the session refcnt under
high processor loading. My preferred radical solution is to remove the
refcnt as the refcnt appears to redundant.

The patch below is based on Linux 3.3 UNTESTED. I tested the patch on
a custom 2.6.34 kernel with refcnt backports.

>From 5c0f9c0b47bfa706fb4767d80fb586c408c34697 Mon Sep 17 00:00:00 2001
From: Dean Jenkins <djenkins@mvista.com>
Date: Wed, 2 May 2012 18:35:46 +0100
Subject: [PATCH] Bluetooth: Ensure new rfcomm session refcnt is 1 on session
 list

Prevent rfcomm_security_cfm() erroneously deleting the
rfcomm_session structure by the rfcomm_session_hold() ...
rfcomm_session_put() sequence when s->refcnt was initially
zero on the session list.

Therefore, call rfcomm_session_hold() to set s->refcnt to 1
before adding the rfcomm session structure to the session list.
Remove some now unnecessary rfcomm_session_hold() calls after the
session was created.

This change fixes the "scheduling while atomic" warning and
rfcomm crashes due to the rfcomm session being deleted at the
wrong time under high processor loading that causes the
run-time order of rfcomm threads to change. For example, the
high priority rfcomm_security_cfm() interrupts the low priority
thread creating the session and rfcomm_security_cfm() "sees" the
refcnt being zero and not 1 or more as intended.

Normal scenarios appear to terminate using state being BT_DISCONN.
No extra rfcomm_session_put() is required.

rfcomm_session_close() appears to be called in abnormal
scenarios resulting in state being BT_CLOSED. Call
rfcomm_session_put() to decrement the refcnt to cancel
the initial count of 1. Subsequently the session will be deleted.

Signed-off-by: Dean Jenkins <djenkins@mvista.com>
---
 net/bluetooth/rfcomm/core.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 8a60238..d95c34e 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -618,6 +618,15 @@ static struct rfcomm_session
*rfcomm_session_add(struct socket *sock, int state)
                        return NULL;
                }

+       /*
+        * refcnt must be 1 before adding to the session list
+        * otherwise threads such as rfcomm_security_cfm()
+        * can interrupt and cause
+        * rfcomm_session_hold() ... rfcomm_session_put() sequence to
+        * erroneously delete the session structure.
+        */
+       rfcomm_session_hold(s);
+
        list_add(&s->list, &session_list);

        return s;
@@ -678,6 +687,9 @@ static void rfcomm_session_close(struct
rfcomm_session *s, int err)

        rfcomm_session_clear_timer(s);
        rfcomm_session_put(s);
+
+       /* to match with initial session creation rfcomm_session_hold() */
+       rfcomm_session_put(s);
 }

 static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src,
@@ -1905,8 +1917,6 @@ static inline void
rfcomm_accept_connection(struct rfcomm_session *s)

        s = rfcomm_session_add(nsock, BT_OPEN);
        if (s) {
-               rfcomm_session_hold(s);
-
                /* We should adjust MTU on incoming sessions.
                 * L2CAP MTU minus UIH header and FCS. */
                s->mtu = min(l2cap_pi(nsock->sk)->chan->omtu,
@@ -2027,7 +2037,6 @@ static int rfcomm_add_listener(bdaddr_t *ba)
        if (!s)
                goto failed;

-       rfcomm_session_hold(s);
        return 0;
 failed:
        sock_release(sock);
-- 
1.7.10.1


Please comment on the patch.

I suspect the last change to the core.c file:
commit cf33e77b76d7439f21a23a94eab4ab3b405a6a7d
Author: Octavian Purdila <octavian.purdila@intel.com>
Date:   Fri Jan 27 19:32:39 2012 +0200

    Bluetooth: Fix RFCOMM session reference counting issue

is incorrect. IMHO, it causes a remote device initiated session to
fail to be deleted, at least that occurs in my 2.6.34 test kernel with
the refcnt backports. I could of missed something. But anyway, it can
be seen that keeping the refcnt in sync is not straight forward.

It did not help that target connection establishment and remote device
connection establishment procedures had different values of the refcnt
during the connection phase. My patch addresses that imbalance. The
connection and disconnection phases are independent of each other so
an established connection should have the same refcnt value regardless
of how the connection was established and subsequently deleted.

I still prefer to remove the refcnt as the counter appears to be
redundant as the session state machine knows sufficient information to
delete the session at the correct moment. I have some working patches
with refcnt deleted, but not included here.

Regards,
Dean

-- 
Dean Jenkins
Embedded Software Engineer
Professional Services UK/EMEA
MontaVista Software, LLC
