Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] telephony-ofono: fix features initialization
Date: Wed,  1 Jun 2011 14:50:40 +0300
Message-Id: <1306929040-425-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Features should be ready before telephony_init return, otherwise the
record might contain invalid features.
---
 audio/telephony-ofono.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/audio/telephony-ofono.c b/audio/telephony-ofono.c
index c00637e..20dc907 100644
--- a/audio/telephony-ofono.c
+++ b/audio/telephony-ofono.c
@@ -926,13 +926,6 @@ static void handle_network_property(const char *property, DBusMessageIter *varia
 
 static int parse_network_properties(DBusMessageIter *properties)
 {
-	uint32_t features = AG_FEATURE_EC_ANDOR_NR |
-				AG_FEATURE_INBAND_RINGTONE |
-				AG_FEATURE_REJECT_A_CALL |
-				AG_FEATURE_ENHANCED_CALL_STATUS |
-				AG_FEATURE_ENHANCED_CALL_CONTROL |
-				AG_FEATURE_EXTENDED_ERROR_RESULT_CODES |
-				AG_FEATURE_THREE_WAY_CALLING;
 	int i;
 
 	/* Reset indicators */
@@ -959,9 +952,6 @@ static int parse_network_properties(DBusMessageIter *properties)
 		dbus_message_iter_next(properties);
 	}
 
-	telephony_ready_ind(features, ofono_indicators, BTRH_NOT_SUPPORTED,
-								chld_str);
-
 	return 0;
 }
 
@@ -1553,6 +1543,13 @@ static void handle_service_disconnect(DBusConnection *conn, void *user_data)
 
 int telephony_init(void)
 {
+	uint32_t features = AG_FEATURE_EC_ANDOR_NR |
+				AG_FEATURE_INBAND_RINGTONE |
+				AG_FEATURE_REJECT_A_CALL |
+				AG_FEATURE_ENHANCED_CALL_STATUS |
+				AG_FEATURE_ENHANCED_CALL_CONTROL |
+				AG_FEATURE_EXTENDED_ERROR_RESULT_CODES |
+				AG_FEATURE_THREE_WAY_CALLING;
 	const char *battery_cap = "battery";
 	int ret;
 	guint watch;
@@ -1593,6 +1590,9 @@ int telephony_init(void)
 
 	DBG("telephony_init() successfully");
 
+	telephony_ready_ind(features, ofono_indicators, BTRH_NOT_SUPPORTED,
+								chld_str);
+
 	return ret;
 }
 
-- 
1.7.5.2

