Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 1/2] Bluetooth: Use list _safe deleting from conn_hash_list
Date: Thu,  2 Feb 2012 10:32:17 +0200
Message-Id: <1328171538-16020-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1328171538-16020-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1328171538-16020-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Use list_for_each_entry_safe which is safe version against removal
of list entry. Otherwise we remove hci_conn element and reference
next element which result in accessing LIST_POISON.

[   95.571834] Bluetooth: unknown link type 127
[   95.578349] BUG: unable to handle kernel paging request at 20002000
[   95.580236] IP: [<20002000>] 0x20001fff
[   95.580763] *pde = 00000000
[   95.581196] Oops: 0000 [#1] SMP
...
[   95.582298] Pid: 3355, comm: hciconfig Tainted: G   O 3.2.0-VirttualBox
[   95.582298] EIP: 0060:[<20002000>] EFLAGS: 00210206 CPU: 0
[   95.582298] EIP is at 0x20002000
...
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
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_conn.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index aca71c0..b074bd6 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -795,11 +795,11 @@ timer:
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
1.7.8.3

