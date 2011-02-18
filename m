Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] telephony-ofono: reset indicators when a network is found
Date: Fri, 18 Feb 2011 18:24:00 +0200
Message-Id: <1298046241-8655-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

Indicators may have invalid values set from the last time they were used
---
 audio/telephony-ofono.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/audio/telephony-ofono.c b/audio/telephony-ofono.c
index 4e78801..bc8fea2 100644
--- a/audio/telephony-ofono.c
+++ b/audio/telephony-ofono.c
@@ -935,6 +935,15 @@ static int parse_network_properties(DBusMessageIter *properties)
 				AG_FEATURE_ENHANCED_CALL_CONTROL |
 				AG_FEATURE_EXTENDED_ERROR_RESULT_CODES |
 				AG_FEATURE_THREE_WAY_CALLING;
+	int i;
+
+	/* Reset indicators */
+	for (i = 0; ofono_indicators[i].desc != NULL; i++) {
+		if (g_str_equal(ofono_indicators[i].desc, "battchg"))
+			ofono_indicators[i].val = 5;
+		else
+			ofono_indicators[i].val = 0;
+	}
 
 	while (dbus_message_iter_get_arg_type(properties)
 						== DBUS_TYPE_DICT_ENTRY) {
-- 
1.7.1

