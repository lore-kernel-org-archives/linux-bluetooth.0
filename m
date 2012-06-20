Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 05/10] thermometer: Reduce the array for Valid Range
Date: Wed, 20 Jun 2012 14:27:47 -0300
Message-Id: <1340213272-2853-6-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1340213272-2853-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1340213272-2853-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Valid Range descriptor contains two unsigned 16-bits integers
representing the valid range of values that the Measurement Interval
characteristic can support.
---
 thermometer/thermometer.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index c2256b6..614da18 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -48,6 +48,8 @@
 
 #define FLOAT_MAX_MANTISSA	16777216 /* 2^24 */
 
+#define VALID_RANGE_DESC_SIZE	4
+
 struct thermometer {
 	DBusConnection		*conn;		/* The connection to the bus */
 	struct btd_device	*dev;		/* Device reference */
@@ -297,7 +299,7 @@ static void valid_range_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
 							gpointer user_data)
 {
 	struct descriptor *desc = user_data;
-	uint8_t value[ATT_MAX_MTU];
+	uint8_t value[VALID_RANGE_DESC_SIZE];
 	uint16_t max, min;
 	ssize_t vlen;
 
-- 
1.7.8.6

