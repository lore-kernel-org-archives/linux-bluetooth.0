Return-Path: <cyrus@holtmann.org>
From: Dean Jenkins <djenkins@mvista.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/4] Bluetooth: Details of rfcomm fixes - remove session refcnt
Date: Sat, 11 Aug 2012 19:47:06 +0100
Message-Id: <1344710830-10301-1-git-send-email-djenkins@mvista.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patchset contains the following patches:

----------------------------------------------------------------
Dean Jenkins (4):
      Bluetooth: Remove rfcomm session refcnt
      Bluetooth: Return rfcomm session pointers to avoid freed session
      Bluetooth: Avoid rfcomm_session_timeout using freed pointer
      Bluetooth: On socket shutdown check rfcomm session and DLC exists

 include/net/bluetooth/rfcomm.h |    6 ----
 net/bluetooth/rfcomm/core.c    |  163 ++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------------------------------------
 2 files changed, 82 insertions(+), 87 deletions(-)

These rfcomm fixes includes a fix for a fundamental issue with the rfcomm
session refcnt that causes kernel crashes in high processor loaded
environments such as multi-core embedded ARM systems.

The concept of a refcnt is to increase the counter when something becomes
dependent on a resource. The counter is decreased when things no longer are
dependent on that resource. When the counter reaches zero, nothing is
dependent on the resource so the resource can be freed or released. The refcnt
should start with a value of 1 because something must be initially dependent on
the resource to prevent the resource from being immediately freed or released.
This means there must be 1 extra decrement operation when compared to the
number of increment operations (excluding the operation to set the initial
value of 1).

What does the rfcomm session refcnt protect ? This is unclear so here is
analysis of the locations of the calls to rfcomm_session_hold() that
increments the refcnt:

rfcomm_session_set_timer() - timer to force session disconnection when no DLCs
rfcomm_dlc_link() - binding DLC data channel to the session
rfcomm_session_close() - close the session but not delete session
rfcomm_accept_connection() - initialise refcnt to 1 for incoming connection
rfcomm_process_sessions() - protect processing of the session
rfcomm_add_listener() - initialise refcnt to 1 for listening session
rfcomm_security_cfm() - protect processing of the session


Lets go through the analysis of the rfcomm_session_hold() calls:

rfcomm_session_set_timer():
The refcnt is incremented when the rfcomm session timer is enabled. The timer
routine rfcomm_session_timeout() uses the session structure so the session
must not be deleted whilst the timer is enabled. This sounds like a valid
resource dependency, however, the timer is disabled each time the session is
closed or deleted. Therefore, protection of the session is unnecessary against
the timer expiring after the session has been deleted. It is noted that the
deletion of the timer is not SMP safe and a fix is supplied in this patchset.

rfcomm_dlc_link():
Each time a rfcomm DLC data connection is established, the refcnt is
incremented. This sounds like a valid resource dependency, however, the
rfcomm session is already dependent on DLC data channel connections because
there is a rfcomm_dlc list. In normal protocol operations, the rfcomm session is
deleted after the rfcomm control channel has been disconnected. The rfcomm
control channel is disconnected after all the rfcomm DLC data channels are
disconnected. Therefore, having a refcnt to protect against deletion of the
session whilst DLC data connections exist is unnecessary because a mechanism is
already in place.

rfcomm_session_close():
The call to rfcomm_session_hold() is matched by a call to rfcomm_session_put()
and protects the closing of DLC data connections. This looks like a
valid resource dependency to prevent the rfcomm session from being deleted
whilst closing the DLC data connections. However, rfcomm_session_close() is
called after the rfcomm control channel has disconnected or after the socket
layer has gone into a closed state (abnormal protocol handling). Therefore,
it seems that there is no risk of rfcomm_session_close() being called during
an active rfcomm control connection. This means protection of the rfcomm
session during the closing of any "orphaned" DLC data connection is
unnecessary.

rfcomm_accept_connection():
Each time an incoming rfcomm control channel connection request is detected, a
rfcomm session is created. The refcnt is set to 1 (via increment). This is
correct, however, it is not safe from thread context switching, see
below refcnt failure of rfcomm_security_cfm(). The refcnt should be set to 1
before the session is added to the session list to prevent premature deletion
of the rfcomm session due to other threads accessing the session list before
the initial increment has taken place. This is a race condition.

rfcomm_process_sessions():
The call to rfcomm_session_hold() is matched by a call to rfcomm_session_put()
and protects the calls to rfcomm_check_connection(), rfcomm_process_rx() and
rfcomm_process_dlcs(). This looks like a valid resource dependency. This is
hard to analyse. One observation is that the session cannot be deleted until
the rfcomm_session_put() is called, however, this assumes there is no
imbalance in the refcnt handling. Remember that a call to rfcomm_session_put()
will cause the session to be deleted when the refcnt hits zero. This makes the
code non-deterministic when considering abnormal protocol handling. In other
words, the session is deleted based on relative changes to the refcnt instead
of an absolute decisive reaction to an event to delete the session by the
session state machine.

rfcomm_add_listener():
A listening session is initially created. The refcnt is set to 1 (via
increment). This is correct, however, it is not safe from thread context
switching. The refcnt should be set to 1 before the session is added to the
session list to prevent premature deletion of the rfcomm session due to other
threads accessing the session list before the initial increment has taken place.
This is a race condition.

rfcomm_security_cfm():
The call to rfcomm_session_hold() is matched by a call to rfcomm_session_put()
and protects the operation of the list_for_each_safe(p, n, &s->dlcs) loop.
The protection is unnecessary because the loop does not modify the rfcomm
session structure. By experimentation, removal of the hold and put has no
impact and in fact prevents the scheduling while atomic warnings, see below.


Conclusions to what the refcnt is protecting
--------------------------------------------

Apart from doubts over the refcnt validity in rfcomm_process_sessions(), most of
the refcnt protection is duplicating existing protection mechanisms or is
setting the refcnt to an initial value of 1.

There is a fundamental flaw in the refcnt implementation. You will note that
the refcnt is not initially being set to 1 for host originated rfcomm control
channel connections. This means that there is an imbalance in the refcnt
treatment of host initiated and remote initiated rfcomm control channel
connections. It would appear that some workarounds in the disconnection code
were attempted (see below) that used the DLC initiator flag. These workarounds
are incorrect as the root cause is that the rfcomm session structure is not
added to the session list with a refcnt of 1. In other words, all rfcomm session
allocations should start with an initial refcnt of 1 and not 0. See above
description of how a refcnt should work.

IMHO the rfcomm session refcnt is adding extra code that is duplicating
existing protection mechanisms of the rfcomm core code. I believe the refcnt is
not adding anything useful to the solution and obscures the act of deleting the
rfcomm session structure. Is the refcnt worth fixing ? I think not, see
below for a solution as implemented by the patchset.

It could be argued that the refcnt and the rfcomm session state machine are
acting as a "belt and braces" solution. IMHO, the refcnt is therefore redundant
as shown by the solution in the patchset.

Note existing protection in rfcomm core includes the mutex rfcomm_lock() and
rfcomm_unlock() functions. This serialises the thread processing so only 1
rfcomm thread can run at any one time. The thread uses in a process context.
Note in kernel 2.6.34 this protection does not prevent rfcomm_security_cfm()
 unning (uses interrupt context) however this was changed in later kernels.


Patchset solution
-----------------

The "fix" for the rfcomm session refcnt is to remove the refcnt for the
following reasons.

1. The lifetime of a rfcomm session refcnt does not last outside the lifetime
of its associated rfcomm session structure. This means the refcnt becomes
invalid as soon as the session is deleted. Consequently, the rfcomm session
refcnt does not manage the rfcomm session pointer after the session has been
deleted. This allows local copies of the rfcomm session s pointer to be reused
after the rfcomm session structure has been freed. In particular, additional
accesses to rfcomm_session_put() and rfcomm_session_hold() after the session has
been deleted will be using freed or reallocated memory. This can lead to kernel
crashes or memory corruption. Test debug added to the kernel confirmed that a
freed rfcomm session was sometimes being reused in rfcomm_session_put() and
rfcomm_session_hold() function calls. This may result in a kernel crash (shown
below) or memory corruption.

ARM Project Kernel 2.6.34 unpatched kernel crash:

[  695.591056] Unable to handle kernel paging request at virtual address
00200200
[  695.791122] [<802886c4>] (rfcomm_session_del+0x18/0x70) from [<8028a560>]
(rfcomm_run+0xf10/0x12d4)
[  695.800260] [<8028a560>] (rfcomm_run+0xf10/0x12d4) from [<80065e70>]
(kthread+0x7c/0x84)
[  695.808454] [<80065e70>] (kthread+0x7c/0x84) from [<8002db04>]
(kernel_thread_exit+0x0/0x8)

2. The initial rfcomm session refcnt is 0 or 1 depending of which rfcomm peer
initated the rfcomm session. This is incorrect because the rfcomm session
connection and disconnection events are independent of each other. In
other words, the refcnt value must reach the same value to allow a successful
disconnection despite which peer initiated the rfcomm session. This is a
fundamental flaw in the refcnt implementation.

3. The rfcomm session refcnt inhibits the existing rfcomm session state machine
from deleting the rfcomm session structure immediately the state machine knows
that the session is finished. I suspect this was to prevent the session timer
expiring after the session was finished. However, it is noted that the session
timer is deleted when the session is closed so the refcnt is unnecessary for
protection. One of the patches fixes the session timer deletion for SMP systems.

4. "Broken workaround" code becomes obvious when the rfcomm session refcnt
is removed. It can be seen that multiple attempts to fix the refcnt have been
tried but these attempts failed to fix the the refcnt initialisation issue so
are flawed. Therefore remove the workaround code to allow a proper fix.

5. High processor loading causes the kernel thread order to change exposing
the rfcomm session refcnt to malfunction eg. premature session deletion or
double session deletion. In particular, rfcomm_security_cfm() causes refcnt
failure by premature session deletion when the refcnt was initially zero.
This issue is improved in kernels later than 2.6.34 as rfcomm_security_cfm()
runs in a process context rather than in an interrupt context. This caused
scheduling while atomic warnings and kernel crashes see below.

ARM Project Kernel 2.6.34 unpatched kernel crash due to premature rfcomm
session deletion in rfcomm_security_cfm() because refcnt was initially zero so
the first pair of rfcomm_session_hold() and rfcomm_session_put() calls in
rfcomm_security_cfm() cause the session to be deleted early:

[  165.033679] BUG: scheduling while atomic: uart/0/657/0x00000205
[  165.070813] [<80032754>] (unwind_backtrace+0x0/0xec) from [<802ab928>]
(schedule+0x80/0x610)
[  165.080075] [<802ab928>] (schedule+0x80/0x610) from [<802106a4>]
(lock_sock_nested+0x84/0xc4)
[  165.089350] [<802106a4>] (lock_sock_nested+0x84/0xc4) from [<80283f1c>]
(l2cap_sock_shutdown+0x24/0x1e0)
[  165.099554] [<80283f1c>] (l2cap_sock_shutdown+0x24/0x1e0) from [<802840f4>]
(l2cap_sock_release+0x1c/0x64)
[  165.110542] [<802840f4>] (l2cap_sock_release+0x1c/0x64) from [<8020efbc>]
(sock_release+0x20/0xb8)
[  165.120342] [<8020efbc>] (sock_release+0x20/0xb8) from [<80288844>]
(rfcomm_session_del+0x4c/0x70)
[  165.130347] [<80288844>] (rfcomm_session_del+0x4c/0x70) from [<80288cd8>]
(rfcomm_security_cfm+0x158/0x194)
[  165.141099] [<80288cd8>] (rfcomm_security_cfm+0x158/0x194) from [<80276c64>]
(hci_event_packet+0xc18/0x2f78)
[  165.151760] [<80276c64>] (hci_event_packet+0xc18/0x2f78) from [<802737d4>]
(hci_rx_task+0xa4/0x254)
[  165.161594] [<802737d4>] (hci_rx_task+0xa4/0x254) from [<80056568>]
(tasklet_action+0xa0/0x138)
[  165.171096] [<80056568>] (tasklet_action+0xa0/0x138) from [<80056984>]
(__do_softirq+0x94/0x124)
[  165.180657] [<80056984>] (__do_softirq+0x94/0x124) from [<80056ab0>]
(do_softirq+0x44/0x50)
[  165.189662] [<80056ab0>] (do_softirq+0x44/0x50) from [<80056cec>]
(local_bh_enable_ip+0x94/0xc8)
[  165.199323] [<80056cec>] (local_bh_enable_ip+0x94/0xc8) from [<801e34fc>]
(desc_get+0x84/0xf4)
[  165.208640] [<801e34fc>] (desc_get+0x84/0xf4) from [<801e41ec>]
(prep_slave_sg+0xc4/0x23c)
[  165.217627] [<801e41ec>] (prep_slave_sg+0xc4/0x23c) from [<801c2984>]
(tx_work_func+0x90/0x1c4)
[  165.227149] [<801c2984>] (tx_work_func+0x90/0x1c4) from [<80062ab4>]
(worker_thread+0xfc/0x194)
[  165.236621] [<80062ab4>] (worker_thread+0xfc/0x194) from [<80065d08>]
(kthread+0x7c/0x84)
[  165.245567] [<80065d08>] (kthread+0x7c/0x84) from [<8002db04>]
(kernel_thread_exit+0x0/0x8)


Additional information about the patches:

1: Bluetooth: Remove rfcomm session refcnt
------------------------------------------

This patch removes the rfcomm session refcnt. It also removes suspected
workarounds as follows:

@@ -1164,18 +1147,7 @@ static int rfcomm_recv_ua(struct rfcomm_session *s, u8 dlci)
 			break;
 
 		case BT_DISCONN:
-			/* rfcomm_session_put is called later so don't do
-			 * anything here otherwise we will mess up the session
-			 * reference counter:
-			 *
-			 * (a) when we are the initiator dlc_unlink will drive
-			 * the reference counter to 0 (there is no initial put
-			 * after session_add)
-			 *
-			 * (b) when we are not the initiator rfcomm_rx_process
-			 * will explicitly call put to balance the initial hold
-			 * done after session add.
-			 */
+			rfcomm_session_del(s);
 			break;

This workaround was incorrect because disconnection of the rfcomm session does
not depend on which peer initiated the session. The initiator flag is for the
DLC data connections and is not for the rfcomm session control channel.

The solution is to delete the rfcomm session after the DISC-UA exchange on
the control channel. This is safe because there are no resource dependencies on
the delete at this point in the rfcomm session state machine.


@@ -1875,12 +1847,8 @@ static inline void rfcomm_process_rx(struct rfcomm_session *s)
 			kfree_skb(skb);
 	}
 
-	if (sk->sk_state == BT_CLOSED) {
-		if (!s->initiator)
-			rfcomm_session_put(s);
-
+	if (sk->sk_state == BT_CLOSED)
 		rfcomm_session_close(s, sk->sk_err);
-	}
 }

This workaround was incorrect because the rfcomm session control channel is
not dependent on the DLC initiator flag. This workaround is probably attempting
to compensate for the fundamental refcnt imbalance on host initiated rfcomm
control channel connections.

The solution is to close the rfcomm session if the socket is detected as
BT_CLOSED. This occurs when L2CAP has disconnected but the rfcomm layer never
performed the disconnection procedure of the rfcomm control channel
eg. abnormal protocol handling.


2: Bluetooth: Return rfcomm session pointers to avoid freed session
-------------------------------------------------------------------

This is the major improvement that prevents the rfcomm session pointer from
being reused after the rfcomm session has been deleted. This is done by passing
the rfcomm session pointer back up the call stack so ensures that the various
local s pointers are updated in the various code blocks.

Analysis of the changes highlights a malfunction in the original code:

@@ -1842,13 +1861,15 @@ static inline void rfcomm_process_rx(struct rfcomm_session *s)
 	while ((skb = skb_dequeue(&sk->sk_receive_queue))) {
 		skb_orphan(skb);
 		if (!skb_linearize(skb))
-			rfcomm_recv_frame(s, skb);
+			s = rfcomm_recv_frame(s, skb);
 		else
 			kfree_skb(skb);
 	}
 
-	if (sk->sk_state == BT_CLOSED)
-		rfcomm_session_close(s, sk->sk_err);
+	if (s && (sk->sk_state == BT_CLOSED))
+		s = rfcomm_session_close(s, sk->sk_err);
+
+	return s;
 }

It can be seen that rfcomm_recv_frame() can result in the rfcomm session being
deleted, for example, due to a rfcomm DISC on the rfcomm control channel. This
exposes the rfcomm_session_close(s, sk->sk_err) to fail because the local s is
now pointing to freed memory or reallocated memory. The solution in the new code
is to check that the s pointer is not NULL as this NULL indicates the rfcomm
session has been deleted. The original code had no mechanism to determine
whether the rfcomm session structure had been deleted.

Therefore, a crash was possible if both a rfcomm DISC on the rfcomm control
channel is processed and the socket transitions to BT_CLOSED. This can occur
in high processor loading conditions whereby rfcomm_process_rx() becomes
pre-empted after the DISC handling and sleeps. The socket transitions to
BT_CLOSED during the sleep. When rfcomm_process_rx() awakens, it crashes because
the s pointer is now invalid when used in rfcomm_session_close().

3: Bluetooth: Avoid rfcomm_session_timeout using freed pointer
--------------------------------------------------------------

This patch ensures that the rfcomm session timer is properly deleted in SMP
systems by using timer_del_sync(). This avoids having special treatment such
as the use of a refcnt, assuming that was the intention of the refcnt in the
first place.

4: Bluetooth: On socket shutdown check rfcomm session and DLC exists
--------------------------------------------------------------------

This patch prevents old pointers from the socket layer causing rfcomm crashes
during socket shutdown triggered from userland. The old pointers attempt
to disconnect no longer existing DLC connections.

ARM Project Kernel 2.6.34 unpatched kernel crash

[  269.534202] Unable to handle kernel NULL pointer dereference at virtual
address 00000028
[  269.784897] [<8020e9c8>] (sock_sendmsg+0x78/0xac) from [<8020ea3c>]
(kernel_sendmsg+0x40/0x7c)
[  269.793614] [<8020ea3c>] (kernel_sendmsg+0x40/0x7c) from [<80289054>]
(rfcomm_send_frame+0x40/0x48)
[  269.802743] [<80289054>] (rfcomm_send_frame+0x40/0x48) from [<802890c4>]
(rfcomm_send_disc+0x68/0x70)
[  269.812045] [<802890c4>] (rfcomm_send_disc+0x68/0x70) from [<80289760>]
(__rfcomm_dlc_close+0x84/0x288)
[  269.821519] [<80289760>] (__rfcomm_dlc_close+0x84/0x288) from [<80289988>]
(rfcomm_dlc_close+0x24/0x3c)
[  269.830995] [<80289988>] (rfcomm_dlc_close+0x24/0x3c) from [<8028b9a4>]
(__rfcomm_sock_close+0x84/0x94)
[  269.840489] [<8028b9a4>] (__rfcomm_sock_close+0x84/0x94) from [<8028b9f0>]
(rfcomm_sock_shutdown+0x3c/0x7c)
[  269.850326] [<8028b9f0>] (rfcomm_sock_shutdown+0x3c/0x7c) from [<8020f008>]
(sys_shutdown+0x34/0x54)
[  269.859554] [<8020f008>] (sys_shutdown+0x34/0x54) from [<8002d0a0>]
(ret_fast_syscall+0x0/0x30)



Testing
-------

Testing including field-trialling and IOP testing has been performed on a
patchset in a multi-core ARM using a 2.6.34 based kernel.

These tested patches have been forward ported to Linux 3.5-RC1 and are released
as a patchset. Basic tests on x86 have been done but it is difficult to
reproduce failure scenarios on a high performance x86 because timing is critical
to cause a malfunction of the unpatched code.

It should be noted that the rfcomm code has changed little between 2.6.34 and
3.5-RC1 with the exception of using process context instead of interrupt
context for all rfcomm core threads. This change may lower the risk of a rfcomm
session refcnt failure, in particular avoiding the rfcomm_security_cfm()
failure of scheduling while atomic.


I welcome discussion on these patches. I am keen to get these changes into
kernel.org. I am willing to re-factor the changes based on feedback from
the community.

I am on IRC in #bluez @ freenode with nick DeanJenkins if you wish to chat
to me about these patches.

Regards,
Dean Jenkins

MontaVista Software, LLC
