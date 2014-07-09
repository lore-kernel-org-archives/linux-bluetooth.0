Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix enabling Authenticated Payload Timeout Expired event
Date: Wed,  9 Jul 2014 09:49:05 +0200
Message-Id: <1404892145-4242-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Authenticated Payload Timeout Expired event is valid for
controllers with BR/EDR Secure Connections support, but also for
LE only controllers supporting LE Ping feature. When either of them
is available enable this event. Previous it was not enabled when
the controller was only supporting LE operation.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h | 1 +
 net/bluetooth/hci_core.c    | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 6ed1f7288f13..a01236e2df13 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -357,6 +357,7 @@ enum {
 
 /* LE features */
 #define HCI_LE_CONN_PARAM_REQ_PROC	0x02
+#define HCI_LE_PING			0x10
 
 /* Connection modes */
 #define HCI_CM_ACTIVE	0x0000
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8ffaca0290f8..421faf5fa1f5 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1569,7 +1569,7 @@ static void hci_set_event_mask_page_2(struct hci_request *req)
 	}
 
 	/* Enable Authenticated Payload Timeout Expired event if supported */
-	if (lmp_ping_capable(hdev))
+	if (lmp_ping_capable(hdev) || hdev->le_features[0] & HCI_LE_PING)
 		events[2] |= 0x80;
 
 	hci_req_add(req, HCI_OP_SET_EVENT_MASK_PAGE_2, sizeof(events), events);
-- 
1.9.3

