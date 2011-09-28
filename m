Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] Fix memory corruption when decoding Read Response PDU
Date: Wed, 28 Sep 2011 15:01:32 -0400
Message-Id: <1317236492-13064-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

A bogus (or hostile) Proximity Reporter device may send a TX Power value
bigger than the buffer used. Therefore, create a temporary buffer with
the maximum size, and check for the length before using the value.

Note that all other current users of the dec_read_resp() already do
this. Another option would be to change dec_read_resp() to accept a
buffer length, but this would break external code, so it is avoided for
now.
---
 proximity/monitor.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/proximity/monitor.c b/proximity/monitor.c
index 0ce48db..884e66d 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -186,7 +186,7 @@ static int write_alert_level(struct monitor *monitor)
 static void tx_power_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 							gpointer user_data)
 {
-	uint8_t value;
+	uint8_t value[ATT_MAX_MTU];
 	int vlen;
 
 	if (status != 0) {
@@ -194,12 +194,17 @@ static void tx_power_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 		return;
 	}
 
-	if (!dec_read_resp(pdu, plen, &value, &vlen)) {
+	if (!dec_read_resp(pdu, plen, value, &vlen)) {
 		DBG("Protocol error");
 		return;
 	}
 
-	DBG("Tx Power Level: %02x", (int8_t) value);
+	if (vlen != 1) {
+		DBG("Invalid length for TX Power value: %d", vlen);
+		return;
+	}
+
+	DBG("Tx Power Level: %02x", (int8_t) value[0]);
 }
 
 static void tx_power_handle_cb(GSList *characteristics, guint8 status,
-- 
1.7.0.4

