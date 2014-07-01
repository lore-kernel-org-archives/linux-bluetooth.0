Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v3 3/4] Bluetooth: Enable new LE meta event
Date: Tue,  1 Jul 2014 18:10:10 -0300
Message-Id: <1404249011-23645-3-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1404249011-23645-1-git-send-email-andre.guedes@openbossa.org>
References: <1404249011-23645-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Bluetooth 4.1 introduces a new LE meta event called "LE Remote
Connection Parameter Request" event. In order to the controller
sends this event to host, we should enable it during controller
initialization.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci.h | 3 +++
 net/bluetooth/hci_core.c    | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 95b7547..66358af 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -307,6 +307,9 @@ enum {
 #define LMP_HOST_LE_BREDR	0x04
 #define LMP_HOST_SC		0x08
 
+/* LE features */
+#define HCI_LE_CONN_PARAM_REQ_PROC	0x02
+
 /* Connection modes */
 #define HCI_CM_ACTIVE	0x0000
 #define HCI_CM_HOLD	0x0001
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 5788e03..8a54ca2 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1611,6 +1611,13 @@ static void hci_init3_req(struct hci_request *req, unsigned long opt)
 
 		memset(events, 0, sizeof(events));
 		events[0] = 0x1f;
+
+		/* If controller supports the Connection Parameters Request
+		 * Link Layer Procedure, enable the corresponding event.
+		 */
+		if (hdev->le_features[0] & HCI_LE_CONN_PARAM_REQ_PROC)
+			events[0] = events[0] | 0x20;
+
 		hci_req_add(req, HCI_OP_LE_SET_EVENT_MASK, sizeof(events),
 			    events);
 
-- 
1.9.1

