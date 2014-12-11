Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH 1/2 v1] Bluetooth: Fix missing hci_dev_lock/unlock in mgmt
 req_complete()
Date: Thu, 11 Dec 2014 11:43:12 +0530
Message-id: <1418278393-26981-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

mgmt_pending_remove() should be called with hci_dev_lock protection
and currently the rule to take dev lock is that all mgmt req_complete
functions should take dev lock. So this patch fixes the same in the
missing functions

Without this patch there is a chance of invalid memory access while
accessing the mgmt_pending list like below

bluetoothd:  392] [0] Backtrace:
bluetoothd:  392] [0] [<c04ec770>] (pending_eir_or_class+0x0/0x68) from [<c04f1830>] (add_uuid+0x34/0x1c4)
bluetoothd:  392] [0] [<c04f17fc>] (add_uuid+0x0/0x1c4) from [<c04f3cc4>] (mgmt_control+0x204/0x274)
bluetoothd:  392] [0] [<c04f3ac0>] (mgmt_control+0x0/0x274) from [<c04f609c>] (hci_sock_sendmsg+0x80/0x308)
bluetoothd:  392] [0] [<c04f601c>] (hci_sock_sendmsg+0x0/0x308) from [<c03d4d68>] (sock_aio_write+0x144/0x174)
bluetoothd:  392] [0]  r8:00000000 r7 7c1be90 r6 7c1be18 r5:00000017 r4 a90ea80
bluetoothd:  392] [0] [<c03d4c24>] (sock_aio_write+0x0/0x174) from [<c00e2d4c>] (do_sync_write+0xb0/0xe0)
bluetoothd:  392] [0] [<c00e2c9c>] (do_sync_write+0x0/0xe0) from [<c00e371c>] (vfs_write+0x134/0x13c)
bluetoothd:  392] [0]  r8:00000000 r7 7c1bf70 r6:beeca5c8 r5:00000017 r4 7c05900
bluetoothd:  392] [0] [<c00e35e8>] (vfs_write+0x0/0x13c) from [<c00e3910>] (sys_write+0x44/0x70)
bluetoothd:  392] [0]  r8:00000000 r7:00000004 r6:00000017 r5:beeca5c8 r4 7c05900
bluetoothd:  392] [0] [<c00e38cc>] (sys_write+0x0/0x70) from [<c000e3c0>] (ret_fast_syscall+0x0/0x30)
bluetoothd:  392] [0]  r9 7c1a000 r8:c000e568 r6:400b5f10 r5:403896d8 r4:beeca604
bluetoothd:  392] [0] Code: e28cc00c e152000c 0a00000f e3a00001 (e1d210b8)
bluetoothd:  392] [0] ---[ end trace 67b6ac67435864c4 ]---
bluetoothd:  392] [0] Kernel panic - not syncing: Fatal exception

Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
---
 net/bluetooth/hci_core.c |    2 ++
 net/bluetooth/mgmt.c     |   18 ++++++++++++------
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 96e7321..ecd7c01 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3083,7 +3083,9 @@ static void hci_power_on(struct work_struct *work)
 
 	err = hci_dev_do_open(hdev);
 	if (err < 0) {
+		hci_dev_lock(hdev);
 		mgmt_set_powered_failed(hdev, err);
+		hci_dev_unlock(hdev);
 		return;
 	}
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 44b20de..16ac037 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2199,12 +2199,14 @@ static void le_enable_complete(struct hci_dev *hdev, u8 status)
 {
 	struct cmd_lookup match = { NULL, hdev };
 
+	hci_dev_lock(hdev);
+
 	if (status) {
 		u8 mgmt_err = mgmt_status(status);
 
 		mgmt_pending_foreach(MGMT_OP_SET_LE, hdev, cmd_status_rsp,
 				     &mgmt_err);
-		return;
+		goto unlock;
 	}
 
 	mgmt_pending_foreach(MGMT_OP_SET_LE, hdev, settings_rsp, &match);
@@ -2222,17 +2224,16 @@ static void le_enable_complete(struct hci_dev *hdev, u8 status)
 	if (test_bit(HCI_LE_ENABLED, &hdev->dev_flags)) {
 		struct hci_request req;
 
-		hci_dev_lock(hdev);
-
 		hci_req_init(&req, hdev);
 		update_adv_data(&req);
 		update_scan_rsp_data(&req);
 		hci_req_run(&req, NULL);
 
 		hci_update_background_scan(hdev);
-
-		hci_dev_unlock(hdev);
 	}
+
+unlock:
+	hci_dev_unlock(hdev);
 }
 
 static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
@@ -4279,12 +4280,14 @@ static void set_advertising_complete(struct hci_dev *hdev, u8 status)
 {
 	struct cmd_lookup match = { NULL, hdev };
 
+	hci_dev_lock(hdev);
+
 	if (status) {
 		u8 mgmt_err = mgmt_status(status);
 
 		mgmt_pending_foreach(MGMT_OP_SET_ADVERTISING, hdev,
 				     cmd_status_rsp, &mgmt_err);
-		return;
+		goto unlock;
 	}
 
 	if (test_bit(HCI_LE_ADV, &hdev->dev_flags))
@@ -4299,6 +4302,9 @@ static void set_advertising_complete(struct hci_dev *hdev, u8 status)
 
 	if (match.sk)
 		sock_put(match.sk);
+
+unlock:
+	hci_dev_unlock(hdev);
 }
 
 static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data,
-- 
1.7.9.5

