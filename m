Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: Change foreach_rcu to foreach_safe
Date: Wed, 25 Jan 2012 15:10:39 +0200
Message-Id: <1327497039-8418-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

When receiving l2cap packets and putting hciX down following
trace can be seen without this patch. If there is only one element
in RCU list after the element was deleted list_for_each_entry_rcu
iterates again over some junk data.

[   95.571834] Bluetooth: unknown link type 127
[   95.578349] BUG: unable to handle kernel paging request at 20002000
[   95.580236] IP: [<20002000>] 0x20001fff
[   95.580763] *pde = 00000000
[   95.581196] Oops: 0000 [#1] SMP
...
[   95.582298] Pid: 3355, comm: hciconfig Tainted: G           O 3.2.0-rc2niko+ #62 innotek GmbH VirtualBox
[   95.582298] EIP: 0060:[<20002000>] EFLAGS: 00210206 CPU: 0
[   95.582298] EIP is at 0x20002000
[   95.582298] EAX: ea4bc000 EBX: ea4bc000 ECX: 20002000 EDX: 00000016
[   95.582298] ESI: f49516f8 EDI: f4951008 EBP: ea4f1e6c ESP: ea4f1e50
[   95.582298]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
[   95.582298] Process hciconfig (pid: 3355, ti=ea4f0000 task=ea4a8000 task.ti=ea4f0000)
[   95.582298] Stack:
[   95.582298]  f8231ab6 f825518d f8255178 0000007f ea4bc000 f4951000 f495163c ea4f1e98
[   95.582298]  f822bcb1 f4951000 ea4f1e98 f822d679 0000000c f4951068 ea4a8000 f4951000
[   95.582298]  ffffffed 00000000 ea4f1ea8 f822e1da 400448ca ea4f6800 ea4f1ee4 f824102f
[   95.582298] Call Trace:
[   95.582298]  [<f8231ab6>] ? hci_conn_hash_flush+0x76/0xf0 [bluetooth]
[   95.582298]  [<f822bcb1>] hci_dev_do_close+0xc1/0x2e0 [bluetooth]
[   95.582298]  [<f822d679>] ? hci_dev_get+0x69/0xb0 [bluetooth]
[   95.582298]  [<f822e1da>] hci_dev_close+0x2a/0x50 [bluetooth]
[   95.582298]  [<f824102f>] hci_sock_ioctl+0x1af/0x3f0 [bluetooth]
[   95.582298]  [<c11153ea>] ? handle_pte_fault+0x8a/0x8f0
[   95.582298]  [<c146becf>] sock_ioctl+0x5f/0x260
[   95.582298]  [<c146be70>] ? sock_fasync+0x90/0x90
[   95.582298]  [<c1152b33>] do_vfs_ioctl+0x83/0x5b0
[   95.582298]  [<c1563f87>] ? do_page_fault+0x297/0x500
[   95.582298]  [<c1563cf0>] ? spurious_fault+0xd0/0xd0
[   95.582298]  [<c107165b>] ? up_read+0x1b/0x30
[   95.582298]  [<c1563f87>] ? do_page_fault+0x297/0x500
[   95.582298]  [<c100aa9f>] ? init_fpu+0xef/0x160
[   95.582298]  [<c15617c0>] ? do_debug+0x180/0x180
[   95.582298]  [<c100a958>] ? fpu_finit+0x28/0x80
[   95.582298]  [<c11530e7>] sys_ioctl+0x87/0x90
[   95.582298]  [<c156795f>] sysenter_do_call+0x12/0x38
...

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/hci_conn.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 1de6efb..cdb6a3f 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -802,11 +802,11 @@ timer:
 void hci_conn_hash_flush(struct hci_dev *hdev)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
-	struct hci_conn *c;
+	struct hci_conn *c, *n;
 
 	BT_DBG("hdev %s", hdev->name);
 
-	list_for_each_entry_rcu(c, &h->list, list) {
+	list_for_each_entry_safe(c, n, &h->list, list) {
 		c->state = BT_CLOSED;
 
 		hci_proto_disconn_cfm(c, HCI_ERROR_LOCAL_HOST_TERM);
-- 
1.7.4.1

