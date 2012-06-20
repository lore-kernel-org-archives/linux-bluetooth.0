Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 08/10] proximity: Reduce array size for Tx Power Level
Date: Wed, 20 Jun 2012 14:27:50 -0300
Message-Id: <1340213272-2853-9-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1340213272-2853-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1340213272-2853-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Tx Power Level characteristic is a signed 8-bits integer which reports
the current transmit power level.
---
 proximity/monitor.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/proximity/monitor.c b/proximity/monitor.c
index 2645321..f22d6f4 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -55,6 +55,7 @@
 #define POWER_LEVEL_CHR_UUID 0x2A07
 
 #define IMMEDIATE_TIMEOUT	5
+#define TX_POWER_SIZE		1
 
 enum {
 	ALERT_NONE = 0,
@@ -211,7 +212,7 @@ static int write_alert_level(struct monitor *monitor)
 static void tx_power_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 							gpointer user_data)
 {
-	uint8_t value[ATT_MAX_MTU];
+	uint8_t value[TX_POWER_SIZE];
 	ssize_t vlen;
 
 	if (status != 0) {
-- 
1.7.8.6

