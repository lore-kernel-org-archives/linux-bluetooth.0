Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [RFC v2 13/16] GATT: Rename Characteristic Configuration constants
Date: Wed, 18 Apr 2012 19:08:21 -0300
Message-Id: <1334786904-26282-14-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1334786904-26282-1-git-send-email-jprvita@openbossa.org>
References: <1334786904-26282-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

This patch renames the constants related to Client Characteristic
Configuration bit field to use a proper name since it is related to
GATT instead of ATT.
---
 attrib/att.h              |    4 ++--
 thermometer/thermometer.c |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/attrib/att.h b/attrib/att.h
index a74eb5a..ba11da7 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -108,8 +108,8 @@
 #define ATT_CHAR_PROPER_EXT_PROPER		0x80
 
 /* Client Characteristic Configuration bit field */
-#define ATT_CLIENT_CHAR_CONF_NOTIFICATION	0x0001
-#define ATT_CLIENT_CHAR_CONF_INDICATION		0x0002
+#define GATT_CLIENT_CHARAC_CFG_NOTIF_BIT	0x0001
+#define GATT_CLIENT_CHARAC_CFG_IND_BIT		0x0002
 
 #define ATT_MAX_MTU				256
 #define ATT_DEFAULT_L2CAP_MTU			48
diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index 92c0225..b2d41cd 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -363,7 +363,7 @@ static void process_thermometer_desc(struct descriptor *desc)
 			if (g_slist_length(ch->t->fwatchers) == 0)
 				return;
 
-			val = ATT_CLIENT_CHAR_CONF_INDICATION;
+			val = GATT_CLIENT_CHARAC_CFG_IND_BIT;
 			msg = g_strdup("Enable Temperature Measurement "
 								"indication");
 		} else if (g_strcmp0(ch->attr.uuid,
@@ -371,12 +371,12 @@ static void process_thermometer_desc(struct descriptor *desc)
 			if (g_slist_length(ch->t->iwatchers) == 0)
 				return;
 
-			val = ATT_CLIENT_CHAR_CONF_NOTIFICATION;
+			val = GATT_CLIENT_CHARAC_CFG_NOTIF_BIT;
 			msg = g_strdup("Enable Intermediate Temperature "
 								"notification");
 		} else if (g_strcmp0(ch->attr.uuid,
 					MEASUREMENT_INTERVAL_UUID) == 0) {
-			val = ATT_CLIENT_CHAR_CONF_INDICATION;
+			val = GATT_CLIENT_CHARAC_CFG_IND_BIT;
 			msg = g_strdup("Enable Measurement Interval "
 								"indication");
 		} else
-- 
1.7.7.6

