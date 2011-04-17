Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 2/2] Add NO CARRIER reponse to maemo6 telephony driver
Date: Mon, 18 Apr 2011 00:29:14 +0300
Message-Id: <1303075754-15375-2-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1303075754-15375-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1303075754-15375-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/telephony-maemo6.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
index be2fb87..b32e8ad 100644
--- a/audio/telephony-maemo6.c
+++ b/audio/telephony-maemo6.c
@@ -630,9 +630,14 @@ static void create_call_reply(DBusPendingCall *call, void *user_data)
 	if (dbus_set_error_from_message(&err, reply)) {
 		error("csd replied with an error: %s, %s",
 				err.name, err.message);
-		dbus_error_free(&err);
-		telephony_dial_number_rsp(telephony_device,
+		if (g_strcmp0(err.name,
+			"com.nokia.csd.Call.Error.CSInactive") == 0)
+			telephony_dial_number_rsp(telephony_device,
+						CME_ERROR_NO_NETWORK_SERVICE);
+		else
+			telephony_dial_number_rsp(telephony_device,
 							CME_ERROR_AG_FAILURE);
+		dbus_error_free(&err);
 	} else
 		telephony_dial_number_rsp(telephony_device, CME_ERROR_NONE);
 
-- 
1.7.1

