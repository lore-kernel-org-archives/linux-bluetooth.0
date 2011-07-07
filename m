Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH 2/2] Bluetooth: Fix potential deadlock in mgmt
Date: Thu,  7 Jul 2011 10:30:36 -0300
Message-Id: <1310045436-25791-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1310045436-25791-1-git-send-email-andre.guedes@openbossa.org>
References: <1310045436-25791-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

All threads running in process context should disable local bottom
halve before locking hdev->lock.

This patch fix the following message generated when Bluetooh module
is loaded with enable_mgmt=y (CONFIG_PROVE_LOCKING enabled).

[  107.880781] =================================
[  107.881631] [ INFO: inconsistent lock state ]
[  107.881631] 2.6.39+ #1
[  107.881631] ---------------------------------
[  107.881631] inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
[  107.881631] rcuc0/7 [HC0[0]:SC1[3]:HE1:SE0] takes:
[  107.881631]  (&(&hdev->lock)->rlock){+.?...}, at: [<ffffffffa0012c8d>] mgmt_set_local_name_complete+0x84/0x10b [bluetooth]
[  107.881631] {SOFTIRQ-ON-W} state was registered at:
[  107.881631]   [<ffffffff8105188b>] __lock_acquire+0x347/0xd52
[  107.881631]   [<ffffffff810526ac>] lock_acquire+0x8a/0xa7
[  107.881631]   [<ffffffff812b3758>] _raw_spin_lock+0x2c/0x3b
[  107.881631]   [<ffffffffa0011cc2>] mgmt_control+0xd4d/0x175b [bluetooth]
[  107.881631]   [<ffffffffa0013275>] hci_sock_sendmsg+0x97/0x293 [bluetooth]
[  107.881631]   [<ffffffff8121940c>] sock_aio_write+0x126/0x13a
[  107.881631]   [<ffffffff810a35fa>] do_sync_write+0xba/0xfa
[  107.881631]   [<ffffffff810a3beb>] vfs_write+0xaa/0xca
[  107.881631]   [<ffffffff810a3d80>] sys_write+0x45/0x69
[  107.881631]   [<ffffffff812b4892>] system_call_fastpath+0x16/0x1b
[  107.881631] irq event stamp: 2100876
[  107.881631] hardirqs last  enabled at (2100876): [<ffffffff812b40d4>] restore_args+0x0/0x30
[  107.881631] hardirqs last disabled at (2100875): [<ffffffff812b3f6a>] save_args+0x6a/0x70
[  107.881631] softirqs last  enabled at (2100862): [<ffffffff8106a805>] rcu_cpu_kthread+0x2b5/0x2e2
[  107.881631] softirqs last disabled at (2100863): [<ffffffff812b56bc>] call_softirq+0x1c/0x26
[  107.881631]
[  107.881631] other info that might help us debug this:
[  107.881631]  Possible unsafe locking scenario:
[  107.881631]
[  107.881631]        CPU0
[  107.881631]        ----
[  107.881631]   lock(&(&hdev->lock)->rlock);
[  107.881631]   <Interrupt>
[  107.881631]     lock(&(&hdev->lock)->rlock);
[  107.881631]
[  107.881631]  *** DEADLOCK ***
[  107.881631]
[  107.881631] 1 lock held by rcuc0/7:
[  107.881631]  #0:  (hci_task_lock){++.-..}, at: [<ffffffffa0008353>] hci_rx_task+0x49/0x2f3 [bluetooth]
[  107.881631]
[  107.881631] stack backtrace:
[  107.881631] Pid: 7, comm: rcuc0 Not tainted 2.6.39+ #1
[  107.881631] Call Trace:
[  107.881631]  <IRQ>  [<ffffffff812ae901>] print_usage_bug+0x1e7/0x1f8
[  107.881631]  [<ffffffff8100a796>] ? save_stack_trace+0x27/0x44
[  107.881631]  [<ffffffff8104fc3f>] ? print_irq_inversion_bug.part.26+0x19a/0x19a
[  107.881631]  [<ffffffff810504bb>] mark_lock+0x106/0x258
[  107.881631]  [<ffffffff81051817>] __lock_acquire+0x2d3/0xd52
[  107.881631]  [<ffffffff8102be73>] ? vprintk+0x3ab/0x3d7
[  107.881631]  [<ffffffff810526ac>] lock_acquire+0x8a/0xa7
[  107.881631]  [<ffffffffa0012c8d>] ? mgmt_set_local_name_complete+0x84/0x10b [bluetooth]
[  107.881631]  [<ffffffff81052615>] ? lock_release+0x16c/0x179
[  107.881631]  [<ffffffff812b3952>] _raw_spin_lock_bh+0x31/0x40
[  107.881631]  [<ffffffffa0012c8d>] ? mgmt_set_local_name_complete+0x84/0x10b [bluetooth]
[  107.881631]  [<ffffffffa0012c8d>] mgmt_set_local_name_complete+0x84/0x10b [bluetooth]
[  107.881631]  [<ffffffffa000d3fe>] hci_event_packet+0x122b/0x3e12 [bluetooth]
[  107.881631]  [<ffffffff81050658>] ? mark_held_locks+0x4b/0x6d
[  107.881631]  [<ffffffff812b3cff>] ? _raw_spin_unlock_irqrestore+0x40/0x4d
[  107.881631]  [<ffffffff810507b9>] ? trace_hardirqs_on_caller+0x13f/0x172
[  107.881631]  [<ffffffff812b3d07>] ? _raw_spin_unlock_irqrestore+0x48/0x4d
[  107.881631]  [<ffffffffa00083d2>] hci_rx_task+0xc8/0x2f3 [bluetooth]
[  107.881631]  [<ffffffff8102f836>] ? __local_bh_enable+0x90/0xa4
[  107.881631]  [<ffffffff8102f5a9>] tasklet_action+0x87/0xe6
[  107.881631]  [<ffffffff8102fa11>] __do_softirq+0x9f/0x13f
[  107.881631]  [<ffffffff812b56bc>] call_softirq+0x1c/0x26
[  107.881631]  <EOI>  [<ffffffff810033b8>] ? do_softirq+0x46/0x9a
[  107.881631]  [<ffffffff8106a805>] ? rcu_cpu_kthread+0x2b5/0x2e2
[  107.881631]  [<ffffffff8102f906>] _local_bh_enable_ip+0xac/0xc9
[  107.881631]  [<ffffffff8102f93b>] local_bh_enable+0xd/0xf
[  107.881631]  [<ffffffff8106a805>] rcu_cpu_kthread+0x2b5/0x2e2
[  107.881631]  [<ffffffff81041586>] ? __init_waitqueue_head+0x46/0x46
[  107.881631]  [<ffffffff8106a550>] ? rcu_yield.constprop.42+0x98/0x98
[  107.881631]  [<ffffffff81040f0a>] kthread+0x7f/0x87
[  107.881631]  [<ffffffff812b55c4>] kernel_thread_helper+0x4/0x10
[  107.881631]  [<ffffffff812b40d4>] ? retint_restore_args+0x13/0x13
[  107.881631]  [<ffffffff81040e8b>] ? __init_kthread_worker+0x53/0x53
[  107.881631]  [<ffffffff812b55c0>] ? gs_change+0x13/0x13

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/mgmt.c |   88 +++++++++++++++++++++++++-------------------------
 1 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 64c0418..4fd11e5 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -179,7 +179,7 @@ static int read_controller_info(struct sock *sk, u16 index)
 
 	hci_del_off_timer(hdev);
 
-	hci_dev_lock(hdev);
+	hci_dev_lock_bh(hdev);
 
 	set_bit(HCI_MGMT, &hdev->flags);
 
@@ -208,7 +208,7 @@ static int read_controller_info(struct sock *sk, u16 index)
 
 	memcpy(rp.name, hdev->dev_name, sizeof(hdev->dev_name));
 
-	hci_dev_unlock(hdev);
+	hci_dev_unlock_bh(hdev);
 	hci_dev_put(hdev);
 
 	return cmd_complete(sk, index, MGMT_OP_READ_INFO, &rp, sizeof(rp));
@@ -316,7 +316,7 @@ static int set_powered(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_SET_POWERED, ENODEV);
 
-	hci_dev_lock(hdev);
+	hci_dev_lock_bh(hdev);
 
 	up = test_bit(HCI_UP, &hdev->flags);
 	if ((cp->val && up) || (!cp->val && !up)) {
@@ -343,7 +343,7 @@ static int set_powered(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	err = 0;
 
 failed:
-	hci_dev_unlock(hdev);
+	hci_dev_unlock_bh(hdev);
 	hci_dev_put(hdev);
 	return err;
 }
@@ -368,7 +368,7 @@ static int set_discoverable(struct sock *sk, u16 index, unsigned char *data,
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_SET_DISCOVERABLE, ENODEV);
 
-	hci_dev_lock(hdev);
+	hci_dev_lock_bh(hdev);
 
 	if (!test_bit(HCI_UP, &hdev->flags)) {
 		err = cmd_status(sk, index, MGMT_OP_SET_DISCOVERABLE, ENETDOWN);
@@ -403,7 +403,7 @@ static int set_discoverable(struct sock *sk, u16 index, unsigned char *data,
 		mgmt_pending_remove(cmd);
 
 failed:
-	hci_dev_unlock(hdev);
+	hci_dev_unlock_bh(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -429,7 +429,7 @@ static int set_connectable(struct sock *sk, u16 index, unsigned char *data,
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_SET_CONNECTABLE, ENODEV);
 
-	hci_dev_lock(hdev);
+	hci_dev_lock_bh(hdev);
 
 	if (!test_bit(HCI_UP, &hdev->flags)) {
 		err = cmd_status(sk, index, MGMT_OP_SET_CONNECTABLE, ENETDOWN);
@@ -463,7 +463,7 @@ static int set_connectable(struct sock *sk, u16 index, unsigned char *data,
 		mgmt_pending_remove(cmd);
 
 failed:
-	hci_dev_unlock(hdev);
+	hci_dev_unlock_bh(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -522,7 +522,7 @@ static int set_pairable(struct sock *sk, u16 index, unsigned char *data,
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_SET_PAIRABLE, ENODEV);
 
-	hci_dev_lock(hdev);
+	hci_dev_lock_bh(hdev);
 
 	if (cp->val)
 		set_bit(HCI_PAIRABLE, &hdev->flags);
@@ -538,7 +538,7 @@ static int set_pairable(struct sock *sk, u16 index, unsigned char *data,
 	err = mgmt_event(MGMT_EV_PAIRABLE, index, &ev, sizeof(ev), sk);
 
 failed:
-	hci_dev_unlock(hdev);
+	hci_dev_unlock_bh(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -739,7 +739,7 @@ static int add_uuid(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_ADD_UUID, ENODEV);
 
-	hci_dev_lock(hdev);
+	hci_dev_lock_bh(hdev);
 
 	uuid = kmalloc(sizeof(*uuid), GFP_ATOMIC);
 	if (!uuid) {
@@ -763,7 +763,7 @@ static int add_uuid(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	err = cmd_complete(sk, index, MGMT_OP_ADD_UUID, NULL, 0);
 
 failed:
-	hci_dev_unlock(hdev);
+	hci_dev_unlock_bh(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -788,7 +788,7 @@ static int remove_uuid(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_REMOVE_UUID, ENODEV);
 
-	hci_dev_lock(hdev);
+	hci_dev_lock_bh(hdev);
 
 	if (memcmp(cp->uuid, bt_uuid_any, 16) == 0) {
 		err = hci_uuids_clear(hdev);
@@ -823,7 +823,7 @@ static int remove_uuid(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	err = cmd_complete(sk, index, MGMT_OP_REMOVE_UUID, NULL, 0);
 
 unlock:
-	hci_dev_unlock(hdev);
+	hci_dev_unlock_bh(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -847,7 +847,7 @@ static int set_dev_class(struct sock *sk, u16 index, unsigned char *data,
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_SET_DEV_CLASS, ENODEV);
 
-	hci_dev_lock(hdev);
+	hci_dev_lock_bh(hdev);
 
 	hdev->major_class = cp->major;
 	hdev->minor_class = cp->minor;
@@ -857,7 +857,7 @@ static int set_dev_class(struct sock *sk, u16 index, unsigned char *data,
 	if (err == 0)
 		err = cmd_complete(sk, index, MGMT_OP_SET_DEV_CLASS, NULL, 0);
 
-	hci_dev_unlock(hdev);
+	hci_dev_unlock_bh(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -879,7 +879,7 @@ static int set_service_cache(struct sock *sk, u16 index,  unsigned char *data,
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_SET_SERVICE_CACHE, ENODEV);
 
-	hci_dev_lock(hdev);
+	hci_dev_lock_bh(hdev);
 
 	BT_DBG("hci%u enable %d", index, cp->enable);
 
@@ -897,7 +897,7 @@ static int set_service_cache(struct sock *sk, u16 index,  unsigned char *data,
 		err = cmd_complete(sk, index, MGMT_OP_SET_SERVICE_CACHE, NULL,
 									0);
 
-	hci_dev_unlock(hdev);
+	hci_dev_unlock_bh(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -931,7 +931,7 @@ static int load_keys(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	BT_DBG("hci%u debug_keys %u key_count %u", index, cp->debug_keys,
 								key_count);
 
-	hci_dev_lock(hdev);
+	hci_dev_lock_bh(hdev);
 
 	hci_link_keys_clear(hdev);
 
@@ -949,7 +949,7 @@ static int load_keys(struct sock *sk, u16 index, unsigned char *data, u16 len)
 								key->pin_len);
 	}
 
-	hci_dev_unlock(hdev);
+	hci_dev_unlock_bh(hdev);
 	hci_dev_put(hdev);
 
 	return 0;
@@ -971,7 +971,7 @@ static int remove_key(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_REMOVE_KEY, ENODEV);
 
-	hci_dev_lock(hdev);
+	hci_dev_lock_bh(hdev);
 
 	err = hci_remove_link_key(hdev, &cp->bdaddr);
 	if (err < 0) {
@@ -994,7 +994,7 @@ static int remove_key(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	}
 
 unlock:
-	hci_dev_unlock(hdev);
+	hci_dev_unlock_bh(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -1020,7 +1020,7 @@ static int disconnect(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_DISCONNECT, ENODEV);
 
-	hci_dev_lock(hdev);
+	hci_dev_lock_bh(hdev);
 
 	if (!test_bit(HCI_UP, &hdev->flags)) {
 		err = cmd_status(sk, index, MGMT_OP_DISCONNECT, ENETDOWN);
@@ -1055,7 +1055,7 @@ static int disconnect(struct sock *sk, u16 index, unsigned char *data, u16 len)
 		mgmt_pending_remove(cmd);
 
 failed:
-	hci_dev_unlock(hdev);
+	hci_dev_unlock_bh(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -1076,7 +1076,7 @@ static int get_connections(struct sock *sk, u16 index)
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_GET_CONNECTIONS, ENODEV);
 
-	hci_dev_lock(hdev);
+	hci_dev_lock_bh(hdev);
 
 	count = 0;
 	list_for_each(p, &hdev->conn_hash.list) {
@@ -1103,7 +1103,7 @@ static int get_connections(struct sock *sk, u16 index)
 
 unlock:
 	kfree(rp);
-	hci_dev_unlock(hdev);
+	hci_dev_unlock_bh(hdev);
 	hci_dev_put(hdev);
 	return err;
 }
@@ -1149,7 +1149,7 @@ static int pin_code_reply(struct sock *sk, u16 index, unsigned char *data,
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_PIN_CODE_REPLY, ENODEV);
 
-	hci_dev_lock(hdev);
+	hci_dev_lock_bh(hdev);
 
 	if (!test_bit(HCI_UP, &hdev->flags)) {
 		err = cmd_status(sk, index, MGMT_OP_PIN_CODE_REPLY, ENETDOWN);
@@ -1190,7 +1190,7 @@ static int pin_code_reply(struct sock *sk, u16 index, unsigned char *data,
 		mgmt_pending_remove(cmd);
 
 failed:
-	hci_dev_unlock(hdev);
+	hci_dev_unlock_bh(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -1216,7 +1216,7 @@ static int pin_code_neg_reply(struct sock *sk, u16 index, unsigned char *data,
 		return cmd_status(sk, index, MGMT_OP_PIN_CODE_NEG_REPLY,
 									ENODEV);
 
-	hci_dev_lock(hdev);
+	hci_dev_lock_bh(hdev);
 
 	if (!test_bit(HCI_UP, &hdev->flags)) {
 		err = cmd_status(sk, index, MGMT_OP_PIN_CODE_NEG_REPLY,
@@ -1227,7 +1227,7 @@ static int pin_code_neg_reply(struct sock *sk, u16 index, unsigned char *data,
 	err = send_pin_code_neg_reply(sk, index, hdev, cp);
 
 failed:
-	hci_dev_unlock(hdev);
+	hci_dev_unlock_bh(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -1250,14 +1250,14 @@ static int set_io_capability(struct sock *sk, u16 index, unsigned char *data,
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_SET_IO_CAPABILITY, ENODEV);
 
-	hci_dev_lock(hdev);
+	hci_dev_lock_bh(hdev);
 
 	hdev->io_capability = cp->io_capability;
 
 	BT_DBG("%s IO capability set to 0x%02x", hdev->name,
 							hdev->io_capability);
 
-	hci_dev_unlock(hdev);
+	hci_dev_unlock_bh(hdev);
 	hci_dev_put(hdev);
 
 	return cmd_complete(sk, index, MGMT_OP_SET_IO_CAPABILITY, NULL, 0);
@@ -1343,7 +1343,7 @@ static int pair_device(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_PAIR_DEVICE, ENODEV);
 
-	hci_dev_lock(hdev);
+	hci_dev_lock_bh(hdev);
 
 	if (cp->io_cap == 0x03) {
 		sec_level = BT_SECURITY_MEDIUM;
@@ -1385,7 +1385,7 @@ static int pair_device(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	err = 0;
 
 unlock:
-	hci_dev_unlock(hdev);
+	hci_dev_unlock_bh(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -1417,7 +1417,7 @@ static int user_confirm_reply(struct sock *sk, u16 index, unsigned char *data,
 	if (!hdev)
 		return cmd_status(sk, index, mgmt_op, ENODEV);
 
-	hci_dev_lock(hdev);
+	hci_dev_lock_bh(hdev);
 
 	if (!test_bit(HCI_UP, &hdev->flags)) {
 		err = cmd_status(sk, index, mgmt_op, ENETDOWN);
@@ -1435,7 +1435,7 @@ static int user_confirm_reply(struct sock *sk, u16 index, unsigned char *data,
 		mgmt_pending_remove(cmd);
 
 failed:
-	hci_dev_unlock(hdev);
+	hci_dev_unlock_bh(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -1459,7 +1459,7 @@ static int set_local_name(struct sock *sk, u16 index, unsigned char *data,
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_SET_LOCAL_NAME, ENODEV);
 
-	hci_dev_lock(hdev);
+	hci_dev_lock_bh(hdev);
 
 	cmd = mgmt_pending_add(sk, MGMT_OP_SET_LOCAL_NAME, index, data, len);
 	if (!cmd) {
@@ -1474,7 +1474,7 @@ static int set_local_name(struct sock *sk, u16 index, unsigned char *data,
 		mgmt_pending_remove(cmd);
 
 failed:
-	hci_dev_unlock(hdev);
+	hci_dev_unlock_bh(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -1493,7 +1493,7 @@ static int read_local_oob_data(struct sock *sk, u16 index)
 		return cmd_status(sk, index, MGMT_OP_READ_LOCAL_OOB_DATA,
 									ENODEV);
 
-	hci_dev_lock(hdev);
+	hci_dev_lock_bh(hdev);
 
 	if (!test_bit(HCI_UP, &hdev->flags)) {
 		err = cmd_status(sk, index, MGMT_OP_READ_LOCAL_OOB_DATA,
@@ -1523,7 +1523,7 @@ static int read_local_oob_data(struct sock *sk, u16 index)
 		mgmt_pending_remove(cmd);
 
 unlock:
-	hci_dev_unlock(hdev);
+	hci_dev_unlock_bh(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -1547,7 +1547,7 @@ static int add_remote_oob_data(struct sock *sk, u16 index, unsigned char *data,
 		return cmd_status(sk, index, MGMT_OP_ADD_REMOTE_OOB_DATA,
 									ENODEV);
 
-	hci_dev_lock(hdev);
+	hci_dev_lock_bh(hdev);
 
 	err = hci_add_remote_oob_data(hdev, &cp->bdaddr, cp->hash,
 								cp->randomizer);
@@ -1557,7 +1557,7 @@ static int add_remote_oob_data(struct sock *sk, u16 index, unsigned char *data,
 		err = cmd_complete(sk, index, MGMT_OP_ADD_REMOTE_OOB_DATA, NULL,
 									0);
 
-	hci_dev_unlock(hdev);
+	hci_dev_unlock_bh(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -1581,7 +1581,7 @@ static int remove_remote_oob_data(struct sock *sk, u16 index,
 		return cmd_status(sk, index, MGMT_OP_REMOVE_REMOTE_OOB_DATA,
 									ENODEV);
 
-	hci_dev_lock(hdev);
+	hci_dev_lock_bh(hdev);
 
 	err = hci_remove_remote_oob_data(hdev, &cp->bdaddr);
 	if (err < 0)
@@ -1591,7 +1591,7 @@ static int remove_remote_oob_data(struct sock *sk, u16 index,
 		err = cmd_complete(sk, index, MGMT_OP_REMOVE_REMOTE_OOB_DATA,
 								NULL, 0);
 
-	hci_dev_unlock(hdev);
+	hci_dev_unlock_bh(hdev);
 	hci_dev_put(hdev);
 
 	return err;
-- 
1.7.4.1

