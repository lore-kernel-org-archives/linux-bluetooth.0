Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3 v2] Fix not resetting indicators whenever the driver is initialized
Date: Mon, 14 Feb 2011 13:02:31 +0200
Message-Id: <1297681351-12277-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

This may cause invalid values to be reported since the status of call can
change during the time adaptor was off.
---
 audio/telephony-maemo6.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
index 0c99c34..86405fc 100644
--- a/audio/telephony-maemo6.c
+++ b/audio/telephony-maemo6.c
@@ -1950,6 +1950,7 @@ int telephony_init(void)
 				AG_FEATURE_ENHANCED_CALL_CONTROL |
 				AG_FEATURE_EXTENDED_ERROR_RESULT_CODES |
 				AG_FEATURE_THREE_WAY_CALLING;
+	int i;
 
 	DBG("");
 
@@ -1981,6 +1982,14 @@ int telephony_init(void)
 	DBG("telephony-maemo6 registering %s interface on path %s",
 			TELEPHONY_MAEMO_INTERFACE, TELEPHONY_MAEMO_PATH);
 
+	/* Reset indicators */
+	for (i = 0; maemo_indicators[i].desc != NULL; i++) {
+		if (g_str_equal(maemo_indicators[i].desc, "battchg"))
+			maemo_indicators[i].val = 5;
+		else
+			maemo_indicators[i].val = 0;
+	}
+
 	telephony_ready_ind(features, maemo_indicators, BTRH_NOT_SUPPORTED,
 								chld_str);
 	if (send_method_call("org.freedesktop.Hal",
-- 
1.7.1

