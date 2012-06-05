Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix potential NULL pointer dereference in L2CAP
Date: Tue,  5 Jun 2012 14:20:41 +0800
Message-Id: <1338877241-5346-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

In the following scenario conn->hchan is not set when l2cap_conn_del is
called:

< HCI Command: LE Create Connection (0x08|0x000d) plen 25
    bdaddr xx:xx:xx:xx:xx:xx type 0
> HCI Event: Command Status (0x0f) plen 4
    LE Create Connection (0x08|0x000d) status 0x00 ncmd 1
> HCI Event: LE Meta Event (0x3e) plen 19
    LE Connection Complete
      status 0x00 handle 64, role master
      bdaddr xx:xx:xx:xx:xx:xx (Public)
< ACL data: handle 64 flags 0x00 dlen 11
    SMP: Pairing Request (0x01)
      capability 0x04 oob 0x00 auth req 0x01
      max key size 0x10 init key dist 0x00 resp key dist 0x01
      Capability: KeyboardDisplay (OOB data not present)
      Authentication: Bonding (No MITM Protection)
      Initiator Key Distribution:
      Responder Key Distribution:  LTK
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 64 packets 1
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 64 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 64 reason 0x22
    Reason: LMP Response Timeout

This results in the following crash:

BUG: unable to handle kernel NULL pointer dereference at 00000004
IP: [<c123f9e5>] hci_chan_del+0x41/0x6e
*pde = 00000000
Oops: 0002 [#1] SMP
Modules linked in:

Pid: 32, comm: kworker/u:3 Not tainted 3.5.0-rc1+ #322 Bochs Bochs
EIP: 0060:[<c123f9e5>] EFLAGS: 00010246 CPU: 1
EIP is at hci_chan_del+0x41/0x6e
EAX: 00200909 EBX: f5dd2280 ECX: 00000000 EDX: 00000000
ESI: f5d5edc4 EDI: f6201e60 EBP: f6201e50 ESP: f6201e48
 DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
CR0: 8005003b CR2: 00000004 CR3: 35f12000 CR4: 00000690
DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
DR6: ffff0ff0 DR7: 00000400
Process kworker/u:3 (pid: 32, ti=f6200000 task=f686e730 task.ti=f6200000)
Stack:
 f5d5ef00 f6201e60 f6201e88 c12507b3 f62e6000 c12507b3 c1245fad 0000000c
 f5d5ef94 00000026 f5d5ef9c f5d5edc4 f6917800 f62e6000 00000022 f6201e98
 f6201ea8 c125440b f6201eb8 c125440b c124963d f6254622 f62e6000 f6201eb8
Call Trace:
 [<c12507b3>] l2cap_conn_del+0xef/0x135
 [<c12507b3>] ? l2cap_conn_del+0xef/0x135
 [<c1245fad>] ? mgmt_event+0x95/0xa6
 [<c125440b>] l2cap_disconn_cfm+0x49/0x57
 [<c125440b>] ? l2cap_disconn_cfm+0x49/0x57
 [<c124963d>] ? user_confirm_reply+0x7d/0x7d
 [<c124446c>] hci_event_packet+0x33e/0x1cce
 [<c124446c>] ? hci_event_packet+0x33e/0x1cce
 [<c11e1aaa>] ? __kfree_skb+0x6a/0x6d
 [<c11e1af9>] ? kfree_skb+0x25/0x27
 [<c124be14>] ? hci_send_to_sock+0x168/0x174
 [<c123b66c>] hci_rx_work+0xf3/0x347
 [<c123b66c>] ? hci_rx_work+0xf3/0x347
 [<c123b9a7>] ? hci_cmd_work+0xb4/0xd8

This patch fixes this issue by adding a NULL check for conn->hchan.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index f9bffe3..62df491 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1295,7 +1295,8 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 
 	mutex_unlock(&conn->chan_lock);
 
-	hci_chan_del(conn->hchan);
+	if (conn->hchan)
+		hci_chan_del(conn->hchan);
 
 	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT)
 		cancel_delayed_work_sync(&conn->info_timer);
-- 
1.7.10

