Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2] Bluetooth: Fix some code style issues in hci_event.c
Date: Thu, 17 Feb 2011 16:44:23 +0100
Message-ID: <1297957463-15223-1-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1297948601-12723-10-git-send-email-szymon.janc@tieto.com>
References: <1297948601-12723-10-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/hci_event.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b39c9bb..a7c7349 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -949,7 +949,7 @@ static void hci_cs_set_conn_encrypt(struct hci_dev *hdev, __u8 status)
 }
 
 static int hci_outgoing_auth_needed(struct hci_dev *hdev,
-						struct hci_conn *conn)
+							struct hci_conn *conn)
 {
 	if (conn->state != BT_CONFIG || !conn->out)
 		return 0;
@@ -1304,7 +1304,8 @@ static inline void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *sk
 
 	mask |= hci_proto_connect_ind(hdev, &ev->bdaddr, ev->link_type);
 
-	if ((mask & HCI_LM_ACCEPT) && !hci_blacklist_lookup(hdev, &ev->bdaddr)) {
+	if ((mask & HCI_LM_ACCEPT) &&
+			!hci_blacklist_lookup(hdev, &ev->bdaddr)) {
 		/* Connection accepted */
 		struct inquiry_entry *ie;
 		struct hci_conn *conn;
@@ -2116,7 +2117,8 @@ static inline void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, struct
 	hci_dev_lock(hdev);
 
 	if ((skb->len - 1) / num_rsp != sizeof(struct inquiry_info_with_rssi)) {
-		struct inquiry_info_with_rssi_and_pscan_mode *info = (void *) (skb->data + 1);
+		struct inquiry_info_with_rssi_and_pscan_mode *info;
+		info = (void *) (skb->data + 1);
 
 		for (; num_rsp; num_rsp--) {
 			bacpy(&data.bdaddr, &info->bdaddr);
@@ -2276,12 +2278,12 @@ static inline void hci_extended_inquiry_result_evt(struct hci_dev *hdev, struct
 
 	for (; num_rsp; num_rsp--) {
 		bacpy(&data.bdaddr, &info->bdaddr);
-		data.pscan_rep_mode     = info->pscan_rep_mode;
-		data.pscan_period_mode  = info->pscan_period_mode;
-		data.pscan_mode         = 0x00;
+		data.pscan_rep_mode	= info->pscan_rep_mode;
+		data.pscan_period_mode	= info->pscan_period_mode;
+		data.pscan_mode		= 0x00;
 		memcpy(data.dev_class, info->dev_class, 3);
-		data.clock_offset       = info->clock_offset;
-		data.rssi               = info->rssi;
+		data.clock_offset	= info->clock_offset;
+		data.rssi		= info->rssi;
 		data.ssp_mode		= 0x01;
 		info++;
 		hci_inquiry_cache_update(hdev, &data);
-- 
1.7.0.4

