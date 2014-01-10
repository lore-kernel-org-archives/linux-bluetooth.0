Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 06/13] Bluetooth: Enable Authenticated Payload Timeout Expired event
Date: Thu,  9 Jan 2014 22:40:47 -0800
Message-Id: <1389336054-54064-6-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With Secure Connections capable controllers, the authenticated payload
timeout can trigger. Enable the event so the controller informs the
host when this happens.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 5e8663c194c1..52e398f37129 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1288,6 +1288,10 @@ static void hci_set_event_mask_page_2(struct hci_request *req)
 		events[2] |= 0x08;	/* Truncated Page Complete */
 	}
 
+	/* Enable Authenticated Payload Timeout Expired event if supported */
+	if (lmp_ping_capable(hdev))
+		events[2] |= 0x80;
+
 	hci_req_add(req, HCI_OP_SET_EVENT_MASK_PAGE_2, sizeof(events), events);
 }
 
-- 
1.8.4.2

