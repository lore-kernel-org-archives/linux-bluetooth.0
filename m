Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>,
	Chan-yeol Park <chanyeol.park@samsung.com>
Subject: [RFC 2/2] Bluetooth: Send remote name request even after
 mgmt_connection
Date: Mon, 01 Apr 2013 15:29:14 +0530
Message-id: <1364810354-2121-2-git-send-email-jaganath.k@samsung.com>
In-reply-to: <1364810354-2121-1-git-send-email-jaganath.k@samsung.com>
References: <1364810354-2121-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch sends remote name request even if mgmt_connected event
is sent to userspace.

This patch fixes the issue remote name request is not sent if
mgmt_connected happens before remote feature event completion

Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
Signed-off-by: Chan-yeol Park <chanyeol.park@samsung.com>
---
 net/bluetooth/hci_event.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d873bd6..40d7d39 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2131,7 +2131,7 @@ static void hci_remote_features_evt(struct hci_dev *hdev,
 		goto unlock;
 	}
 
-	if (!ev->status && !test_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags)) {
+	if (!ev->status) {
 		struct hci_cp_remote_name_req cp;
 		memset(&cp, 0, sizeof(cp));
 		bacpy(&cp.bdaddr, &conn->dst);
@@ -2938,10 +2938,7 @@ static void hci_remote_ext_features_evt(struct hci_dev *hdev,
 			set_bit(HCI_CONN_SSP_ENABLED, &conn->flags);
 	}
 
-	if (conn->state != BT_CONFIG)
-		goto unlock;
-
-	if (!ev->status && !test_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags)) {
+	if (!ev->status) {
 		struct hci_cp_remote_name_req cp;
 		memset(&cp, 0, sizeof(cp));
 		bacpy(&cp.bdaddr, &conn->dst);
@@ -2952,6 +2949,9 @@ static void hci_remote_ext_features_evt(struct hci_dev *hdev,
 				      conn->dst_type, 0, NULL, 0,
 				      conn->dev_class);
 
+	if (conn->state != BT_CONFIG)
+		goto unlock;
+
 	if (!hci_outgoing_auth_needed(hdev, conn)) {
 		conn->state = BT_CONNECTED;
 		hci_proto_connect_cfm(conn, ev->status);
-- 
1.7.9.5

