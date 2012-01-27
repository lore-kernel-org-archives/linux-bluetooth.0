Return-Path: <cyrus@holtmann.org>
From: Octavian Purdila <octavian.purdila@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Octavian Purdila <octavian.purdila@intel.com>,
	Gopala Krishna Murala <gopala.krishna.murala@intel.com>,
	Nick Pelly <npelly@google.com>,
	=?UTF-8?q?Luk=C3=A1=C5=A1=20Turek?= <8an@praha12.net>,
	Marcel Holtmann <marcel@holtmann.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v2] Bluetooth: fix RFCOMM session reference counting issue
Date: Fri, 27 Jan 2012 19:32:39 +0200
Message-Id: <1327685559-4351-1-git-send-email-octavian.purdila@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

There is an imbalance in the rfcomm_session_hold / rfcomm_session_put
operations which causes the following crash:

[  685.010159] BUG: unable to handle kernel paging request at 6b6b6b6b
[  685.010169] IP: [<c149d76d>] rfcomm_process_dlcs+0x1b/0x15e
[  685.010181] *pdpt = 000000002d665001 *pde = 0000000000000000
[  685.010191] Oops: 0000 [#1] PREEMPT SMP
[  685.010247]
[  685.010255] Pid: 947, comm: krfcommd Tainted: G         C  3.0.16-mid8-dirty #44
[  685.010266] EIP: 0060:[<c149d76d>] EFLAGS: 00010246 CPU: 1
[  685.010274] EIP is at rfcomm_process_dlcs+0x1b/0x15e
[  685.010281] EAX: e79f551c EBX: 6b6b6b6b ECX: 00000007 EDX: e79f40b4
[  685.010288] ESI: e79f4060 EDI: ed4e1f70 EBP: ed4e1f68 ESP: ed4e1f50
[  685.010295]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
[  685.010303] Process krfcommd (pid: 947, ti=ed4e0000 task=ed43e5e0 task.ti=ed4e0000)
[  685.010308] Stack:
[  685.010312]  ed4e1f68 c149eb53 e5925150 e79f4060 ed500000 ed4e1f70 ed4e1f80 c149ec10
[  685.010331]  00000000 ed43e5e0 00000000 ed4e1f90 ed4e1f9c c149ec87 0000bf54 00000000
[  685.010348]  00000000 ee03bf54 c149ec37 ed4e1fe4 c104fe01 00000000 00000000 00000000
[  685.010367] Call Trace:
[  685.010376]  [<c149eb53>] ? rfcomm_process_rx+0x6e/0x74
[  685.010387]  [<c149ec10>] rfcomm_process_sessions+0xb7/0xde
[  685.010398]  [<c149ec87>] rfcomm_run+0x50/0x6d
[  685.010409]  [<c149ec37>] ? rfcomm_process_sessions+0xde/0xde
[  685.010419]  [<c104fe01>] kthread+0x63/0x68
[  685.010431]  [<c104fd9e>] ? __init_kthread_worker+0x42/0x42
[  685.010442]  [<c14dae82>] kernel_thread_helper+0x6/0xd

This issue has been brought up earlier here:

https://lkml.org/lkml/2011/5/21/127

The issue appears to be the rfcomm_session_put in rfcomm_recv_ua. This
operation doesn't seem be to required as for the non-initiator case we
have the rfcomm_process_rx doing an explicit put and in the initiator
case the last dlc_unlink will drive the reference counter to 0.

There have been several attempts to fix these issue:

6c2718d Bluetooth: Do not call rfcomm_session_put() for RFCOMM UA on closed socket
683d949 Bluetooth: Never deallocate a session when some DLC points to it

but AFAICS they do not fix the issue just make it harder to reproduce.

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
Signed-off-by: Gopala Krishna Murala <gopala.krishna.murala@intel.com>

CC: Nick Pelly <npelly@google.com>
CC: Lukáš Turek <8an@praha12.net>
CC: Marcel Holtmann <marcel@holtmann.org>
CC: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---

Changes from v1:
* remove the gerrit Change-Id tag from the commit message
* rephrase the comment for clarity and fix a few spelling errors

Here is a full log of the hold/put operations which leads to the
crash, where the x in hold(x) / put(x) is the reference counter value
for the session before the hold/put operation:

[   75.332972] rfcomm_session_del: bt dump ed3cc580
[   75.332991] hold(0) 0xc149d3f2 rfcomm_accept_connection+0x65/0x99
[   75.333042] hold(0) 0xc149eb92 rfcomm_process_sessions+0x91/0xde
[   75.333074] hold(0) 0xc149ec2f rfcomm_run+0x50/0x6d
[   75.333101] hold(0) 0xc104fe01 kthread+0x63/0x68
[   75.333134] hold(0) 0xc14dae42 kernel_thread_helper+0x6/0xd
[   75.333166] 
[   75.333179] hold(1) 0xc149eb9b rfcomm_process_sessions+0x9a/0xde
[   75.333210] hold(1) 0xc149ec2f rfcomm_run+0x50/0x6d
[   75.333238] hold(1) 0xc104fe01 kthread+0x63/0x68
[   75.333266] hold(1) 0xc14dae42 kernel_thread_helper+0x6/0xd
[   75.333293] 
[   75.333306] put(2) 0xc149ebbf rfcomm_process_sessions+0xbe/0xde
[   75.333336] put(2) 0xc149ec2f rfcomm_run+0x50/0x6d
[   75.333363] put(2) 0xc104fe01 kthread+0x63/0x68
[   75.333392] put(2) 0xc14dae42 kernel_thread_helper+0x6/0xd
[   75.333419] 
[   75.333432] hold(1) 0xc149eb9b rfcomm_process_sessions+0x9a/0xde
[   75.333461] hold(1) 0xc149ec2f rfcomm_run+0x50/0x6d
[   75.333489] hold(1) 0xc104fe01 kthread+0x63/0x68
[   75.333517] hold(1) 0xc14dae42 kernel_thread_helper+0x6/0xd
[   75.333544] 
[   75.333558] put(2) 0xc149ebbf rfcomm_process_sessions+0xbe/0xde
[   75.333587] put(2) 0xc149ec2f rfcomm_run+0x50/0x6d
[   75.333615] put(2) 0xc104fe01 kthread+0x63/0x68
[   75.333643] put(2) 0xc14dae42 kernel_thread_helper+0x6/0xd
[   75.333671] 
[   75.333683] hold(1) 0xc149eb9b rfcomm_process_sessions+0x9a/0xde
[   75.333713] hold(1) 0xc149ec2f rfcomm_run+0x50/0x6d
[   75.333741] hold(1) 0xc104fe01 kthread+0x63/0x68
[   75.333769] hold(1) 0xc14dae42 kernel_thread_helper+0x6/0xd
[   75.333796] 
[   75.333808] hold(2) 0xc149dc9f rfcomm_dlc_link+0xe/0x36
[   75.333837] hold(2) 0xc149e361 rfcomm_recv_mcc+0x279/0x5f7
[   75.333866] hold(2) 0xc149ea64 rfcomm_recv_frame+0x385/0x3ae
[   75.333959] hold(2) 0xc149eacc rfcomm_process_rx+0x3f/0x74
[   75.333988] hold(2) 0xc149ebb1 rfcomm_process_sessions+0xb0/0xde
[   75.334018] hold(2) 0xc149ec2f rfcomm_run+0x50/0x6d
[   75.334045] hold(2) 0xc104fe01 kthread+0x63/0x68
[   75.334074] hold(2) 0xc14dae42 kernel_thread_helper+0x6/0xd
[   75.334102] 
[   75.334115] put(3) 0xc149ebbf rfcomm_process_sessions+0xbe/0xde
[   75.334145] put(3) 0xc149ec2f rfcomm_run+0x50/0x6d
[   75.334173] put(3) 0xc104fe01 kthread+0x63/0x68
[   75.334201] put(3) 0xc14dae42 kernel_thread_helper+0x6/0xd
[   75.334228] 
[   75.334241] hold(2) 0xc149eb9b rfcomm_process_sessions+0x9a/0xde
[   75.334271] hold(2) 0xc149ec2f rfcomm_run+0x50/0x6d
[   75.334299] hold(2) 0xc104fe01 kthread+0x63/0x68
[   75.334327] hold(2) 0xc14dae42 kernel_thread_helper+0x6/0xd
[   75.334354] 
[   75.334367] put(3) 0xc149ebbf rfcomm_process_sessions+0xbe/0xde
[   75.334397] put(3) 0xc149ec2f rfcomm_run+0x50/0x6d
[   75.334424] put(3) 0xc104fe01 kthread+0x63/0x68
[   75.334453] put(3) 0xc14dae42 kernel_thread_helper+0x6/0xd
[   75.334480] 
[   75.334493] hold(2) 0xc149d8e1 rfcomm_security_cfm+0x35/0x10e
[   75.334523] hold(2) 0xc148dcb3 hci_encrypt_cfm+0x8f/0xaa
[   75.334556] hold(2) 0xc148f900 hci_event_packet+0x34e/0x10be
[   75.334584] hold(2) 0xc148aa06 hci_rx_task+0xab/0x205
[   75.334615] hold(2) 0xc103bbc1 tasklet_action+0x6b/0xab
[   75.334645] hold(2) 0xc103c2b6 __do_softirq+0xdc/0x1dd
[   75.334670] 
[   75.334683] put(3) 0xc149d9ac rfcomm_security_cfm+0x100/0x10e
[   75.334712] put(3) 0xc148dcb3 hci_encrypt_cfm+0x8f/0xaa
[   75.334743] put(3) 0xc148f900 hci_event_packet+0x34e/0x10be
[   75.334772] put(3) 0xc148aa06 hci_rx_task+0xab/0x205
[   75.334801] put(3) 0xc103bbc1 tasklet_action+0x6b/0xab
[   75.334830] put(3) 0xc103c2b6 __do_softirq+0xdc/0x1dd
[   75.334854] 
[   75.334867] hold(2) 0xc149eb9b rfcomm_process_sessions+0x9a/0xde
[   75.334984] hold(2) 0xc149ec2f rfcomm_run+0x50/0x6d
[   75.335012] hold(2) 0xc104fe01 kthread+0x63/0x68
[   75.335042] hold(2) 0xc14dae42 kernel_thread_helper+0x6/0xd
[   75.335070] 
[   75.335082] put(3) 0xc149ebbf rfcomm_process_sessions+0xbe/0xde
[   75.335112] put(3) 0xc149ec2f rfcomm_run+0x50/0x6d
[   75.335141] put(3) 0xc104fe01 kthread+0x63/0x68
[   75.335169] put(3) 0xc14dae42 kernel_thread_helper+0x6/0xd
[   75.335195] 
[   75.335209] hold(2) 0xc149eb9b rfcomm_process_sessions+0x9a/0xde
[   75.335239] hold(2) 0xc149ec2f rfcomm_run+0x50/0x6d
[   75.335266] hold(2) 0xc104fe01 kthread+0x63/0x68
[   75.335295] hold(2) 0xc14dae42 kernel_thread_helper+0x6/0xd
[   75.335322] 
[   75.335335] put(3) 0xc149ebbf rfcomm_process_sessions+0xbe/0xde
[   75.335364] put(3) 0xc149ec2f rfcomm_run+0x50/0x6d
[   75.335392] put(3) 0xc104fe01 kthread+0x63/0x68
[   75.335420] put(3) 0xc14dae42 kernel_thread_helper+0x6/0xd
[   75.335447] 
[   75.335460] hold(2) 0xc149eb9b rfcomm_process_sessions+0x9a/0xde
[   75.335490] hold(2) 0xc149ec2f rfcomm_run+0x50/0x6d
[   75.335517] hold(2) 0xc104fe01 kthread+0x63/0x68
[   75.335545] hold(2) 0xc14dae42 kernel_thread_helper+0x6/0xd
[   75.335573] 
[   75.335586] put(3) 0xc149ebbf rfcomm_process_sessions+0xbe/0xde
[   75.335615] put(3) 0xc149ec2f rfcomm_run+0x50/0x6d
[   75.335643] put(3) 0xc104fe01 kthread+0x63/0x68
[   75.335671] put(3) 0xc14dae42 kernel_thread_helper+0x6/0xd
[   75.335698] 
[   75.335711] hold(2) 0xc149eb9b rfcomm_process_sessions+0x9a/0xde
[   75.335741] hold(2) 0xc149ec2f rfcomm_run+0x50/0x6d
[   75.335769] hold(2) 0xc104fe01 kthread+0x63/0x68
[   75.335797] hold(2) 0xc14dae42 kernel_thread_helper+0x6/0xd
[   75.335825] 
[   75.335837] put(3) 0xc149ebbf rfcomm_process_sessions+0xbe/0xde
[   75.335867] put(3) 0xc149ec2f rfcomm_run+0x50/0x6d
[   75.335958] put(3) 0xc104fe01 kthread+0x63/0x68
[   75.335988] put(3) 0xc14dae42 kernel_thread_helper+0x6/0xd
[   75.336016] 
[   75.336029] hold(2) 0xc149eb9b rfcomm_process_sessions+0x9a/0xde
[   75.336058] hold(2) 0xc149ec2f rfcomm_run+0x50/0x6d
[   75.336086] hold(2) 0xc104fe01 kthread+0x63/0x68
[   75.336114] hold(2) 0xc14dae42 kernel_thread_helper+0x6/0xd
[   75.336141] 
[   75.336154] hold(3) 0xc149d462 rfcomm_session_set_timer+0x3c/0x5c
[   75.336184] hold(3) 0xc149d55e rfcomm_dlc_unlink+0x3f/0x4a
[   75.336213] hold(3) 0xc149d715 __rfcomm_dlc_close+0x1ac/0x1b5
[   75.336242] hold(3) 0xc149da76 rfcomm_recv_ua+0xbc/0x166
[   75.336270] hold(3) 0xc149e922 rfcomm_recv_frame+0x243/0x3ae
[   75.336299] hold(3) 0xc149eacc rfcomm_process_rx+0x3f/0x74
[   75.336328] hold(3) 0xc149ebb1 rfcomm_process_sessions+0xb0/0xde
[   75.336358] hold(3) 0xc149ec2f rfcomm_run+0x50/0x6d
[   75.336385] hold(3) 0xc104fe01 kthread+0x63/0x68
[   75.336413] hold(3) 0xc14dae42 kernel_thread_helper+0x6/0xd
[   75.336441] 
[   75.336454] put(4) 0xc149d565 rfcomm_dlc_unlink+0x46/0x4a
[   75.336482] put(4) 0xc149d715 __rfcomm_dlc_close+0x1ac/0x1b5
[   75.336512] put(4) 0xc149da76 rfcomm_recv_ua+0xbc/0x166
[   75.336540] put(4) 0xc149e922 rfcomm_recv_frame+0x243/0x3ae
[   75.336569] put(4) 0xc149eacc rfcomm_process_rx+0x3f/0x74
[   75.336597] put(4) 0xc149ebb1 rfcomm_process_sessions+0xb0/0xde
[   75.336628] put(4) 0xc149ec2f rfcomm_run+0x50/0x6d
[   75.336655] put(4) 0xc104fe01 kthread+0x63/0x68
[   75.336684] put(4) 0xc14dae42 kernel_thread_helper+0x6/0xd
[   75.336711] 
[   75.336724] put(3) 0xc149ebbf rfcomm_process_sessions+0xbe/0xde
[   75.336753] put(3) 0xc149ec2f rfcomm_run+0x50/0x6d
[   75.336781] put(3) 0xc104fe01 kthread+0x63/0x68
[   75.336809] put(3) 0xc14dae42 kernel_thread_helper+0x6/0xd
[   75.336836] 
[   75.336849] hold(2) 0xc149eb9b rfcomm_process_sessions+0x9a/0xde
[   75.336939] hold(2) 0xc149ec2f rfcomm_run+0x50/0x6d
[   75.336968] hold(2) 0xc104fe01 kthread+0x63/0x68
[   75.336996] hold(2) 0xc14dae42 kernel_thread_helper+0x6/0xd
[   75.337024] 
[   75.337037] put(3) 0xc149db16 rfcomm_recv_ua+0x15c/0x166
[   75.337067] put(3) 0xc149e922 rfcomm_recv_frame+0x243/0x3ae
[   75.337095] put(3) 0xc149eacc rfcomm_process_rx+0x3f/0x74
[   75.337124] put(3) 0xc149ebb1 rfcomm_process_sessions+0xb0/0xde
[   75.337153] put(3) 0xc149ec2f rfcomm_run+0x50/0x6d
[   75.337180] put(3) 0xc104fe01 kthread+0x63/0x68
[   75.337209] put(3) 0xc14dae42 kernel_thread_helper+0x6/0xd
[   75.337236] 
[   75.337249] put(2) 0xc149ebbf rfcomm_process_sessions+0xbe/0xde
[   75.337278] put(2) 0xc149ec2f rfcomm_run+0x50/0x6d
[   75.337306] put(2) 0xc104fe01 kthread+0x63/0x68
[   75.337334] put(2) 0xc14dae42 kernel_thread_helper+0x6/0xd
[   75.337361] 
[   75.337374] hold(1) 0xc149eb9b rfcomm_process_sessions+0x9a/0xde
[   75.337404] hold(1) 0xc149ec2f rfcomm_run+0x50/0x6d
[   75.337432] hold(1) 0xc104fe01 kthread+0x63/0x68
[   75.337460] hold(1) 0xc14dae42 kernel_thread_helper+0x6/0xd
[   75.337487] 
[   75.337500] put(2) 0xc149eaee rfcomm_process_rx+0x61/0x74
[   75.337528] put(2) 0xc149ebb1 rfcomm_process_sessions+0xb0/0xde
[   75.337558] put(2) 0xc149ec2f rfcomm_run+0x50/0x6d
[   75.337586] put(2) 0xc104fe01 kthread+0x63/0x68
[   75.337614] put(2) 0xc14dae42 kernel_thread_helper+0x6/0xd
[   75.337641] 
[   75.337653] hold(1) 0xc149e000 rfcomm_session_close+0x13/0x5b
[   75.337683] hold(1) 0xc149eafb rfcomm_process_rx+0x6e/0x74
[   75.337711] hold(1) 0xc149ebb1 rfcomm_process_sessions+0xb0/0xde
[   75.337741] hold(1) 0xc149ec2f rfcomm_run+0x50/0x6d
[   75.337769] hold(1) 0xc104fe01 kthread+0x63/0x68
[   75.337796] hold(1) 0xc14dae42 kernel_thread_helper+0x6/0xd
[   75.337824] 
[   75.337837] put(2) 0xc149db3f rfcomm_session_clear_timer+0x1f/0x22
[   75.337867] put(2) 0xc149e03b rfcomm_session_close+0x4e/0x5b
[   75.337953] put(2) 0xc149eafb rfcomm_process_rx+0x6e/0x74
[   75.337982] put(2) 0xc149ebb1 rfcomm_process_sessions+0xb0/0xde
[   75.338012] put(2) 0xc149ec2f rfcomm_run+0x50/0x6d
[   75.338040] put(2) 0xc104fe01 kthread+0x63/0x68
[   75.338068] put(2) 0xc14dae42 kernel_thread_helper+0x6/0xd
[   75.338096] 
[   75.338109] put(1) 0xc149e042 rfcomm_session_close+0x55/0x5b
[   75.338138] put(1) 0xc149eafb rfcomm_process_rx+0x6e/0x74
[   75.338167] put(1) 0xc149ebb1 rfcomm_process_sessions+0xb0/0xde
[   75.338197] put(1) 0xc149ec2f rfcomm_run+0x50/0x6d
[   75.338224] put(1) 0xc104fe01 kthread+0x63/0x68
[   75.338252] put(1) 0xc14dae42 kernel_thread_helper+0x6/0xd


 net/bluetooth/rfcomm/core.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 501649b..8a60238 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1164,12 +1164,18 @@ static int rfcomm_recv_ua(struct rfcomm_session *s, u8 dlci)
 			break;
 
 		case BT_DISCONN:
-			/* When socket is closed and we are not RFCOMM
-			 * initiator rfcomm_process_rx already calls
-			 * rfcomm_session_put() */
-			if (s->sock->sk->sk_state != BT_CLOSED)
-				if (list_empty(&s->dlcs))
-					rfcomm_session_put(s);
+			/* rfcomm_session_put is called later so don't do
+			 * anything here otherwise we will mess up the session
+			 * reference counter:
+			 *
+			 * (a) when we are the initiator dlc_unlink will drive
+			 * the reference counter to 0 (there is no initial put
+			 * after session_add)
+			 *
+			 * (b) when we are not the initiator rfcomm_rx_process
+			 * will explicitly call put to balance the initial hold
+			 * done after session add.
+			 */
 			break;
 		}
 	}
-- 
1.7.4.1
