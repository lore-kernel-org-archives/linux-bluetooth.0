Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v2 3/4] Bluetooth: Enable new LE meta event
Date: Wed, 25 Jun 2014 21:52:54 -0300
Message-Id: <1403743975-31114-3-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1403743975-31114-1-git-send-email-andre.guedes@openbossa.org>
References: <1403743975-31114-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Bluetooth 4.1 introduces a new LE meta event called "LE Remote
Connection Parameter Request" event. In order to the controller sends
this event to host, we should enable it during controller initialization.

Therefore, this patch enables that event in case the controller supports
Bluetooth 4.1 or upper version.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/bluetooth.h | 1 +
 net/bluetooth/hci_core.c          | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 373000d..85dbc03 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -38,6 +38,7 @@
 #define BLUETOOTH_VER_1_1	1
 #define BLUETOOTH_VER_1_2	2
 #define BLUETOOTH_VER_2_0	3
+#define BLUETOOTH_VER_4_1	7
 
 /* Reserv for core and drivers use */
 #define BT_SKB_RESERVE	8
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 9852449..a8b9d70 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1461,6 +1461,13 @@ static void hci_setup_event_mask(struct hci_request *req)
 	if (lmp_le_capable(hdev)) {
 		memset(events, 0, sizeof(events));
 		events[0] = 0x1f;
+
+		/* If Bluetooth 4.1 or upper version, enable LE Remote
+		 * Connection Parameter Request Event.
+		 */
+		if (hdev->hci_ver >= BLUETOOTH_VER_4_1)
+			events[0] = events[0] | 0x20;
+
 		hci_req_add(req, HCI_OP_LE_SET_EVENT_MASK,
 			    sizeof(events), events);
 	}
-- 
1.9.1

