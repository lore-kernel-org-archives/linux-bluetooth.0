Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix potential NULL dereference
Date: Tue,  3 Feb 2015 10:01:13 +0200
Message-Id: <1422950473-11562-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The bnep_get_device function may be triggered by an ioctl just after a
connection has gone down. In such a case the respective L2CAP chan->conn
pointer will get set to NULL (by l2cap_chan_del). This patch adds a
missing NULL check for this case in the bnep_get_device() function.

Reported-by: Patrik Flykt <patrik.flykt@linux.intel.com>
Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/bnep/core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index ce82722d049b..05f57e491ccb 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -511,13 +511,12 @@ static int bnep_session(void *arg)
 
 static struct device *bnep_get_device(struct bnep_session *session)
 {
-	struct hci_conn *conn;
+	struct l2cap_conn *conn = l2cap_pi(session->sock->sk)->chan->conn;
 
-	conn = l2cap_pi(session->sock->sk)->chan->conn->hcon;
-	if (!conn)
+	if (!conn || !conn->hcon)
 		return NULL;
 
-	return &conn->dev;
+	return &conn->hcon->dev;
 }
 
 static struct device_type bnep_type = {
-- 
2.1.0

