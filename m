Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v3 2/4] Bluetooth: Move LE event mask setting into init3 phase
Date: Tue,  1 Jul 2014 18:10:09 -0300
Message-Id: <1404249011-23645-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1404249011-23645-1-git-send-email-andre.guedes@openbossa.org>
References: <1404249011-23645-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

During init2 phase, the LE local features have not be read yet so
we aren't able to rely on hdev->le_features to determine if the
controller supports the Connection Parameters Request Procedure.

For that reason, this patch moves LE event mask setting from init2
into init3 initialization phase.

The hdev->le_features mask will be checked by the next patch in order
to know if "LE Remote Connection Parameter Request Event" should be
enabled.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_core.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 72eb414..5788e03 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1437,13 +1437,6 @@ static void hci_setup_event_mask(struct hci_request *req)
 		events[7] |= 0x20;	/* LE Meta-Event */
 
 	hci_req_add(req, HCI_OP_SET_EVENT_MASK, sizeof(events), events);
-
-	if (lmp_le_capable(hdev)) {
-		memset(events, 0, sizeof(events));
-		events[0] = 0x1f;
-		hci_req_add(req, HCI_OP_LE_SET_EVENT_MASK,
-			    sizeof(events), events);
-	}
 }
 
 static void hci_init2_req(struct hci_request *req, unsigned long opt)
@@ -1613,8 +1606,16 @@ static void hci_init3_req(struct hci_request *req, unsigned long opt)
 	if (hdev->commands[5] & 0x10)
 		hci_setup_link_policy(req);
 
-	if (lmp_le_capable(hdev))
+	if (lmp_le_capable(hdev)) {
+		u8 events[8];
+
+		memset(events, 0, sizeof(events));
+		events[0] = 0x1f;
+		hci_req_add(req, HCI_OP_LE_SET_EVENT_MASK, sizeof(events),
+			    events);
+
 		hci_set_le_support(req);
+	}
 
 	/* Read features beyond page 1 if available */
 	for (p = 2; p < HCI_MAX_PAGES && p <= hdev->max_page; p++) {
-- 
1.9.1

