Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 06/10] thermometer: Reduce the array for temperature type
Date: Wed, 20 Jun 2012 14:27:48 -0300
Message-Id: <1340213272-2853-7-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1340213272-2853-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1340213272-2853-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Temperature Type characteristic is a 8-bits value used to describe
the type of temperature measurement in relation to the location on the
human body.
---
 thermometer/thermometer.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index 614da18..914f77c 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -49,6 +49,7 @@
 #define FLOAT_MAX_MANTISSA	16777216 /* 2^24 */
 
 #define VALID_RANGE_DESC_SIZE	4
+#define TEMPERATURE_TYPE_SIZE	1
 
 struct thermometer {
 	DBusConnection		*conn;		/* The connection to the bus */
@@ -445,7 +446,7 @@ static void read_temp_type_cb(guint8 status, const guint8 *pdu, guint16 len,
 {
 	struct characteristic *ch = user_data;
 	struct thermometer *t = ch->t;
-	uint8_t value[ATT_MAX_MTU];
+	uint8_t value[TEMPERATURE_TYPE_SIZE];
 	ssize_t vlen;
 
 	if (status != 0) {
-- 
1.7.8.6

