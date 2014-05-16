Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH] Bluetooth: Add missing msecs to jiffies conversion
Date: Fri, 16 May 2014 16:48:57 +0200
Message-ID: <1400251737-16342-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

conn_info_age value is calculated in ms, so need to be converted to
jiffies.

Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
---
 net/bluetooth/mgmt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 17ebaa3..370cd42 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4708,7 +4708,8 @@ static int get_conn_info(struct sock *sk, struct hci_dev *hdev, void *data,
 	/* Query controller to refresh cached values if they are too old or were
 	 * never read.
 	 */
-	if (time_after(jiffies, conn->conn_info_timestamp + conn_info_age) ||
+	if (time_after(jiffies, conn->conn_info_timestamp +
+		       msecs_to_jiffies(conn_info_age)) ||
 	    !conn->conn_info_timestamp) {
 		struct hci_request req;
 		struct hci_cp_read_tx_power req_txp_cp;
-- 
1.9.3

