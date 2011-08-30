Return-Path: <cyrus@holtmann.org>
From: chen.ganir@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH] Bluetooth-next: Fixed BT ST Channel reg order
Date: Tue, 30 Aug 2011 13:58:28 +0300
Message-Id: <1314701908-15860-1-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Reordered the BT ST channel registration, to make sure that the
event channel is registered before all others. This prevents a
situation where incoming events may cause kernel panic in the ST
driver if the event channel is not yet registered to handle
incoming events.In addition, the deregistration of the channels
was also modified, to be in the reversed order of the registration,
to allow the event channel to be the last one unregistered.

Signed-off-by: Chen Ganir <chen.ganir@ti.com>
---
 drivers/bluetooth/btwilink.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/btwilink.c b/drivers/bluetooth/btwilink.c
index 65d27af..04d353f 100644
--- a/drivers/bluetooth/btwilink.c
+++ b/drivers/bluetooth/btwilink.c
@@ -125,6 +125,13 @@ static long st_receive(void *priv_data, struct sk_buff *skb)
 /* protocol structure registered with shared transport */
 static struct st_proto_s ti_st_proto[MAX_BT_CHNL_IDS] = {
 	{
+		.chnl_id = HCI_EVENT_PKT, /* HCI Events */
+		.hdr_len = sizeof(struct hci_event_hdr),
+		.offset_len_in_hdr = offsetof(struct hci_event_hdr, plen),
+		.len_size = 1, /* sizeof(plen) in struct hci_event_hdr */
+		.reserve = 8,
+	},
+	{
 		.chnl_id = HCI_ACLDATA_PKT, /* ACL */
 		.hdr_len = sizeof(struct hci_acl_hdr),
 		.offset_len_in_hdr = offsetof(struct hci_acl_hdr, dlen),
@@ -138,13 +145,6 @@ static struct st_proto_s ti_st_proto[MAX_BT_CHNL_IDS] = {
 		.len_size = 1, /* sizeof(dlen) in struct hci_sco_hdr */
 		.reserve = 8,
 	},
-	{
-		.chnl_id = HCI_EVENT_PKT, /* HCI Events */
-		.hdr_len = sizeof(struct hci_event_hdr),
-		.offset_len_in_hdr = offsetof(struct hci_event_hdr, plen),
-		.len_size = 1, /* sizeof(plen) in struct hci_event_hdr */
-		.reserve = 8,
-	},
 };
 
 /* Called from HCI core to initialize the device */
@@ -240,7 +240,7 @@ static int ti_st_close(struct hci_dev *hdev)
 	if (!test_and_clear_bit(HCI_RUNNING, &hdev->flags))
 		return 0;
 
-	for (i = 0; i < MAX_BT_CHNL_IDS; i++) {
+	for (i = MAX_BT_CHNL_IDS-1; i >= 0; i--) {
 		err = st_unregister(&ti_st_proto[i]);
 		if (err)
 			BT_ERR("st_unregister(%d) failed with error %d",
-- 
1.7.4.1

