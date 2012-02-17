Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 1/3] Bluetooth: Move scope of state_to_string
Date: Fri, 17 Feb 2012 11:40:55 +0200
Message-Id: <1329471657-18278-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1329471657-18278-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1329471657-18278-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Function state_to_string will be used in other files in debug
statements.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/bluetooth.h |   27 +++++++++++++++++++++++++++
 net/bluetooth/l2cap_core.c        |   26 --------------------------
 2 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 4a82ca0..0a47c20 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -129,6 +129,33 @@ enum {
 	BT_CLOSED
 };
 
+/* If unused will be removed by compiler */
+static inline char *state_to_string(int state)
+{
+	switch (state) {
+	case BT_CONNECTED:
+		return "BT_CONNECTED";
+	case BT_OPEN:
+		return "BT_OPEN";
+	case BT_BOUND:
+		return "BT_BOUND";
+	case BT_LISTEN:
+		return "BT_LISTEN";
+	case BT_CONNECT:
+		return "BT_CONNECT";
+	case BT_CONNECT2:
+		return "BT_CONNECT2";
+	case BT_CONFIG:
+		return "BT_CONFIG";
+	case BT_DISCONN:
+		return "BT_DISCONN";
+	case BT_CLOSED:
+		return "BT_CLOSED";
+	}
+
+	return "invalid state";
+}
+
 /* BD Address */
 typedef struct {
 	__u8 b[6];
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 8efac78..252a96e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -215,32 +215,6 @@ static u16 l2cap_alloc_cid(struct l2cap_conn *conn)
 	return 0;
 }
 
-static char *state_to_string(int state)
-{
-	switch(state) {
-	case BT_CONNECTED:
-		return "BT_CONNECTED";
-	case BT_OPEN:
-		return "BT_OPEN";
-	case BT_BOUND:
-		return "BT_BOUND";
-	case BT_LISTEN:
-		return "BT_LISTEN";
-	case BT_CONNECT:
-		return "BT_CONNECT";
-	case BT_CONNECT2:
-		return "BT_CONNECT2";
-	case BT_CONFIG:
-		return "BT_CONFIG";
-	case BT_DISCONN:
-		return "BT_DISCONN";
-	case BT_CLOSED:
-		return "BT_CLOSED";
-	}
-
-	return "invalid state";
-}
-
 static void l2cap_state_change(struct l2cap_chan *chan, int state)
 {
 	BT_DBG("%p %s -> %s", chan, state_to_string(chan->state),
-- 
1.7.9

