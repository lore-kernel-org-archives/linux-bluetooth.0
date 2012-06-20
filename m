Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 07/10] thermometer: Reduce array size for Measurement Interval
Date: Wed, 20 Jun 2012 14:27:49 -0300
Message-Id: <1340213272-2853-8-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1340213272-2853-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1340213272-2853-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Measurement Interval is a 16-bits value characteristic used to enable
and control the interval between consecutive temperature measurements.
---
 thermometer/thermometer.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index 914f77c..087662e 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -50,6 +50,7 @@
 
 #define VALID_RANGE_DESC_SIZE	4
 #define TEMPERATURE_TYPE_SIZE	1
+#define MEASUREMENT_INTERVAL_SIZE	2
 
 struct thermometer {
 	DBusConnection		*conn;		/* The connection to the bus */
@@ -474,7 +475,7 @@ static void read_interval_cb(guint8 status, const guint8 *pdu, guint16 len,
 							gpointer user_data)
 {
 	struct characteristic *ch = user_data;
-	uint8_t value[ATT_MAX_MTU];
+	uint8_t value[MEASUREMENT_INTERVAL_SIZE];
 	uint16_t interval;
 	ssize_t vlen;
 
-- 
1.7.8.6

