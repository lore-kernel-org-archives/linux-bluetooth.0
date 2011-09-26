Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<ulrik.lauren@stericsson.com>, <henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] Bluetooth: rfcomm: Fix sleep in invalid context in rfcomm_security_cfm
Date: Mon, 26 Sep 2011 14:19:47 +0200
Message-ID: <1317039587-22992-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This was triggered by turning off encryption on ACL link when rfcomm
was using high security. rfcomm_security_cfm (which is called from rx
task) was closing DLC and this involves sending disconnect message
(and locking socket).

Move closing DLC to rfcomm_process_dlcs and only flag DLC for closure
in rfcomm_security_cfm.

BUG: sleeping function called from invalid context at net/core/sock.c:2032
in_atomic(): 1, irqs_disabled(): 0, pid: 1788, name: kworker/0:3
[<c0068a08>] (unwind_backtrace+0x0/0x108) from [<c05e25dc>] (dump_stack+0x20/0x24)
[<c05e25dc>] (dump_stack+0x20/0x24) from [<c0087ba8>] (__might_sleep+0x110/0x12c)
[<c0087ba8>] (__might_sleep+0x110/0x12c) from [<c04801d8>] (lock_sock_nested+0x2c/0x64)
[<c04801d8>] (lock_sock_nested+0x2c/0x64) from [<c05670c8>] (l2cap_sock_sendmsg+0x58/0xcc)
[<c05670c8>] (l2cap_sock_sendmsg+0x58/0xcc) from [<c047cf6c>] (sock_sendmsg+0xb0/0xd0)
[<c047cf6c>] (sock_sendmsg+0xb0/0xd0) from [<c047cfc8>] (kernel_sendmsg+0x3c/0x44)
[<c047cfc8>] (kernel_sendmsg+0x3c/0x44) from [<c056b0e8>] (rfcomm_send_frame+0x50/0x58)
[<c056b0e8>] (rfcomm_send_frame+0x50/0x58) from [<c056b168>] (rfcomm_send_disc+0x78/0x80)
[<c056b168>] (rfcomm_send_disc+0x78/0x80) from [<c056b9f4>] (__rfcomm_dlc_close+0x2d0/0x2fc)
[<c056b9f4>] (__rfcomm_dlc_close+0x2d0/0x2fc) from [<c056bbac>] (rfcomm_security_cfm+0x140/0x1e0)
[<c056bbac>] (rfcomm_security_cfm+0x140/0x1e0) from [<c0555ec0>] (hci_event_packet+0x1ce8/0x4d84)
[<c0555ec0>] (hci_event_packet+0x1ce8/0x4d84) from [<c0550380>] (hci_rx_task+0x1d0/0x2d0)
[<c0550380>] (hci_rx_task+0x1d0/0x2d0) from [<c009ee04>] (tasklet_action+0x138/0x1e4)
[<c009ee04>] (tasklet_action+0x138/0x1e4) from [<c009f21c>] (__do_softirq+0xcc/0x274)
[<c009f21c>] (__do_softirq+0xcc/0x274) from [<c009f6c0>] (do_softirq+0x60/0x6c)
[<c009f6c0>] (do_softirq+0x60/0x6c) from [<c009f794>] (local_bh_enable_ip+0xc8/0xd4)
[<c009f794>] (local_bh_enable_ip+0xc8/0xd4) from [<c05e5804>] (_raw_spin_unlock_bh+0x48/0x4c)
[<c05e5804>] (_raw_spin_unlock_bh+0x48/0x4c) from [<c040d470>] (data_from_chip+0xf4/0xaec)
[<c040d470>] (data_from_chip+0xf4/0xaec) from [<c04136c0>] (send_skb_to_core+0x40/0x178)
[<c04136c0>] (send_skb_to_core+0x40/0x178) from [<c04139f4>] (cg2900_hu_receive+0x15c/0x2d0)
[<c04139f4>] (cg2900_hu_receive+0x15c/0x2d0) from [<c0414cb8>] (hci_uart_tty_receive+0x74/0xa0)
[<c0414cb8>] (hci_uart_tty_receive+0x74/0xa0) from [<c02cbd9c>] (flush_to_ldisc+0x188/0x198)
[<c02cbd9c>] (flush_to_ldisc+0x188/0x198) from [<c00b2774>] (process_one_work+0x144/0x4b8)
[<c00b2774>] (process_one_work+0x144/0x4b8) from [<c00b2e8c>] (worker_thread+0x198/0x468)
[<c00b2e8c>] (worker_thread+0x198/0x468) from [<c00b9bc8>] (kthread+0x98/0xa0)
[<c00b9bc8>] (kthread+0x98/0xa0) from [<c0061744>] (kernel_thread_exit+0x0/0x8)

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 include/net/bluetooth/rfcomm.h |    1 +
 net/bluetooth/rfcomm/core.c    |    9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rfcomm.h
index d5eee20..e2e3eca 100644
--- a/include/net/bluetooth/rfcomm.h
+++ b/include/net/bluetooth/rfcomm.h
@@ -211,6 +211,7 @@ struct rfcomm_dlc {
 #define RFCOMM_AUTH_ACCEPT  6
 #define RFCOMM_AUTH_REJECT  7
 #define RFCOMM_DEFER_SETUP  8
+#define RFCOMM_ENC_DROP     9
 
 /* Scheduling flags and events */
 #define RFCOMM_SCHED_WAKEUP 31
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 38b618c..4e32e18 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1802,6 +1802,11 @@ static inline void rfcomm_process_dlcs(struct rfcomm_session *s)
 			continue;
 		}
 
+		if (test_bit(RFCOMM_ENC_DROP, &d->flags)) {
+			__rfcomm_dlc_close(d, ECONNREFUSED);
+			continue;
+		}
+
 		if (test_and_clear_bit(RFCOMM_AUTH_ACCEPT, &d->flags)) {
 			rfcomm_dlc_clear_timer(d);
 			if (d->out) {
@@ -2077,7 +2082,7 @@ static void rfcomm_security_cfm(struct hci_conn *conn, u8 status, u8 encrypt)
 		if (test_and_clear_bit(RFCOMM_SEC_PENDING, &d->flags)) {
 			rfcomm_dlc_clear_timer(d);
 			if (status || encrypt == 0x00) {
-				__rfcomm_dlc_close(d, ECONNREFUSED);
+				set_bit(RFCOMM_ENC_DROP, &d->flags);
 				continue;
 			}
 		}
@@ -2088,7 +2093,7 @@ static void rfcomm_security_cfm(struct hci_conn *conn, u8 status, u8 encrypt)
 				rfcomm_dlc_set_timer(d, RFCOMM_AUTH_TIMEOUT);
 				continue;
 			} else if (d->sec_level == BT_SECURITY_HIGH) {
-				__rfcomm_dlc_close(d, ECONNREFUSED);
+				set_bit(RFCOMM_ENC_DROP, &d->flags);
 				continue;
 			}
 		}
-- 
on behalf of ST-Ericsson

