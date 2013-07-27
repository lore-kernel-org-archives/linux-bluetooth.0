Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Fix calling request callback more than once
Date: Sat, 27 Jul 2013 14:11:14 -0500
Message-Id: <1374952274-5829-1-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <A37716C3-EFF5-4D22-B8BB-60DB36CEF31B@holtmann.org>
References: <A37716C3-EFF5-4D22-B8BB-60DB36CEF31B@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

In certain circumstances, such as an HCI driver using __hci_cmd_sync_ev
with HCI_EV_CMD_COMPLETE as the expected completion event there is the
chance that hci_event_packet will call hci_req_cmd_complete twice (once
for the explicitly looked after event and another time in the actual
handler of cmd_complete).

In the case of __hci_cmd_sync_ev this introduces a race where the first
call wakes up the blocking __hci_cmd_sync_ev and lets it complete.
However, by the time that a second __hci_cmd_sync_ev call is already in
progress the second hci_req_cmd_complete call (from the previous
operation) will wake up the blocking function prematurely and cause it
to fail, as witnessed by the following log:

[  639.232195] hci_rx_work: hci0 Event packet
[  639.232201] hci_req_cmd_complete: opcode 0xfc8e status 0x00
[  639.232205] hci_sent_cmd_data: hci0 opcode 0xfc8e
[  639.232210] hci_req_sync_complete: hci0 result 0x00
[  639.232220] hci_cmd_complete_evt: hci0 opcode 0xfc8e
[  639.232225] hci_req_cmd_complete: opcode 0xfc8e status 0x00
[  639.232228] __hci_cmd_sync_ev: hci0 end: err 0
[  639.232234] __hci_cmd_sync_ev: hci0
[  639.232238] hci_req_add_ev: hci0 opcode 0xfc8e plen 250
[  639.232242] hci_prepare_cmd: skb len 253
[  639.232246] hci_req_run: length 1
[  639.232250] hci_sent_cmd_data: hci0 opcode 0xfc8e
[  639.232255] hci_req_sync_complete: hci0 result 0x00
[  639.232266] hci_cmd_work: hci0 cmd_cnt 1 cmd queued 1
[  639.232271] __hci_cmd_sync_ev: hci0 end: err 0
[  639.232276] Bluetooth: hci0 sending Intel patch command (0xfc8e) failed (-61)

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
v2: Only set complete callback to NULL if it was not already so

 net/bluetooth/hci_core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b821b19..5b8a8cb 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3399,8 +3399,16 @@ void hci_req_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status)
 	 */
 	if (hdev->sent_cmd) {
 		req_complete = bt_cb(hdev->sent_cmd)->req.complete;
-		if (req_complete)
+
+		if (req_complete) {
+			/* We must set the complete callback to NULL to
+			 * avoid calling the callback more than once if
+			 * this function gets called again.
+			 */
+			bt_cb(hdev->sent_cmd)->req.complete = NULL;
+
 			goto call_complete;
+		}
 	}
 
 	/* Remove all pending commands belonging to this request */
-- 
1.8.3.2

