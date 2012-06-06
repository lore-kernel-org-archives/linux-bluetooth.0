Return-Path: <cyrus@holtmann.org>
From: Vishal Agarwal <vishal.agarwal@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: <naresh.gupta@stericsson.com>,
	Vishal Agarwal <vishal.agarwal@stericsson.com>
Subject: [PATCH v1] Bluetooth: Fix LE pairing completion on connection failure
Date: Thu, 7 Jun 2012 05:07:09 +0530
Message-ID: <1339025829-9414-1-git-send-email-vishal.agarwal@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For BR/EDR pairing is assumed to be finished when connection is
done. For LE if connection is successful it did not necessarily
mean that pairing is also done but if the connection is unsuccessful
it should be assumed that pairing procedure is also finished.
This patch registers a new function with connect_cfm_cb callback for
LE link which sends the pairing complete signal to user space if
connection is unsuccessful.

Signed-off-by: Vishal Agarwal <vishal.agarwal@stericsson.com>
---
 net/bluetooth/mgmt.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 958f764..ce97c37 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1873,6 +1873,22 @@ static void pairing_complete_cb(struct hci_conn *conn, u8 status)
 		pairing_complete(cmd, mgmt_status(status));
 }
 
+static void le_connect_complete_cb(struct hci_conn *conn, u8 status)
+{
+	struct pending_cmd *cmd;
+
+	BT_DBG("status %u", status);
+
+	if (!status && conn->type == LE_LINK)
+		return;
+
+	cmd = find_pairing(conn);
+	if (!cmd)
+		BT_DBG("Unable to find a pending command");
+	else
+		pairing_complete(cmd, mgmt_status(status));
+}
+
 static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 		       u16 len)
 {
@@ -1941,6 +1957,8 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	/* For LE, just connecting isn't a proof that the pairing finished */
 	if (cp->addr.type == BDADDR_BREDR)
 		conn->connect_cfm_cb = pairing_complete_cb;
+	else
+		conn->connect_cfm_cb = le_connect_complete_cb;
 
 	conn->security_cfm_cb = pairing_complete_cb;
 	conn->disconn_cfm_cb = pairing_complete_cb;
-- 
1.7.0.4

