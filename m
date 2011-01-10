Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] telephony-ofono: add support for inband ringtone feature
Date: Mon, 10 Jan 2011 15:05:42 +0200
Message-Id: <1294664745-16487-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

---
 audio/telephony-ofono.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/audio/telephony-ofono.c b/audio/telephony-ofono.c
index ae8f56a..3f76bc7 100644
--- a/audio/telephony-ofono.c
+++ b/audio/telephony-ofono.c
@@ -719,6 +719,7 @@ static void handle_network_property(const char *property, DBusMessageIter *varia
 static int parse_network_properties(DBusMessageIter *properties)
 {
 	uint32_t features = AG_FEATURE_EC_ANDOR_NR |
+				AG_FEATURE_INBAND_RINGTONE |
 				AG_FEATURE_REJECT_A_CALL |
 				AG_FEATURE_ENHANCED_CALL_STATUS |
 				AG_FEATURE_EXTENDED_ERROR_RESULT_CODES;
-- 
1.7.1

