Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Fix not resetting indicators whenever the driver is initialized
Date: Mon, 14 Feb 2011 12:21:21 +0200
Message-Id: <1297678882-26893-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1297678882-26893-1-git-send-email-luiz.dentz@gmail.com>
References: <1297678882-26893-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

This may cause invalid values to be reported since the status of call can
change during the time adaptor was off.
---
 audio/telephony-maemo6.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
index 0c99c34..0ab1a77 100644
--- a/audio/telephony-maemo6.c
+++ b/audio/telephony-maemo6.c
@@ -1981,6 +1981,15 @@ int telephony_init(void)
 	DBG("telephony-maemo6 registering %s interface on path %s",
 			TELEPHONY_MAEMO_INTERFACE, TELEPHONY_MAEMO_PATH);
 
+	/* Reset indicators */
+	telephony_update_indicator(maemo_indicators, "battchg", 5);
+	telephony_update_indicator(maemo_indicators, "signal", 0);
+	telephony_update_indicator(maemo_indicators, "service", 0);
+	telephony_update_indicator(maemo_indicators, "call", 0);
+	telephony_update_indicator(maemo_indicators, "callsetup", 0);
+	telephony_update_indicator(maemo_indicators, "callhelp", 0);
+	telephony_update_indicator(maemo_indicators, "roam", 0);
+
 	telephony_ready_ind(features, maemo_indicators, BTRH_NOT_SUPPORTED,
 								chld_str);
 	if (send_method_call("org.freedesktop.Hal",
-- 
1.7.1

