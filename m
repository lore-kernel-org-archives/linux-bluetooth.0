Return-Path: <cyrus@holtmann.org>
Date: Mon, 22 Dec 2014 19:01:42 -0800
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: "An, Tedd" <tedd.an@intel.com>, Johan Hedberg <johan.hedberg@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH] Bluetooth: Cancel the hci_request timeout if it received
 expected event
Message-ID: <20141222190142.59176a26@tedd-test>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch cancels the hci_request timeout work if the expected event
is recevied.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 net/bluetooth/hci_event.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 39a5c8a..9d18470 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4855,6 +4855,9 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		struct hci_command_hdr *cmd_hdr = (void *) hdev->sent_cmd->data;
 		u16 opcode = __le16_to_cpu(cmd_hdr->opcode);
 
+		if (opcode != HCI_OP_NOP)
+			cancel_delayed_work(&hdev->cmd_timer);
+
 		hci_req_cmd_complete(hdev, opcode, 0);
 	}
 
-- 
1.9.1
