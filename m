Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] telephony-ofono: add support for Enhanced Call Control feature
Date: Mon, 10 Jan 2011 15:05:44 +0200
Message-Id: <1294664745-16487-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1294664745-16487-1-git-send-email-luiz.dentz@gmail.com>
References: <1294664745-16487-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

The Enhanced Call Control feature is simply an extension of the current
AT+CHLD command:

 - Release Specified Call: AT+CHLD=1<idex>
 - Private Consultation Mode: AT+CHLD=1<idex>

The new arguments for this command include an index of a specific call as
indicated in the +CLCC response.
---
 audio/telephony-ofono.c |   52 +++++++++++++++++++++++++++++++++-------------
 1 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/audio/telephony-ofono.c b/audio/telephony-ofono.c
index 7687434..fb32ca9 100644
--- a/audio/telephony-ofono.c
+++ b/audio/telephony-ofono.c
@@ -267,21 +267,25 @@ static int release_answer_calls()
 						NULL, NULL, DBUS_TYPE_INVALID);
 }
 
-static int swap_calls(void)
+static int split_call(struct voice_call *call)
 {
-	DBG("");
+	DBG("%s", call->number);
 	return send_method_call(OFONO_BUS_NAME, modem_obj_path,
 						OFONO_VCMANAGER_INTERFACE,
-						"SwapCalls",
-						NULL, NULL, DBUS_TYPE_INVALID);
+						"PrivateChat",
+						NULL, NULL,
+						DBUS_TYPE_OBJECT_PATH,
+						call->obj_path,
+						DBUS_TYPE_INVALID);
+	return -1;
 }
 
-static int call_transfer(void)
+static int swap_calls(void)
 {
 	DBG("");
 	return send_method_call(OFONO_BUS_NAME, modem_obj_path,
 						OFONO_VCMANAGER_INTERFACE,
-						"Transfer",
+						"SwapCalls",
 						NULL, NULL, DBUS_TYPE_INVALID);
 }
 
@@ -466,11 +470,22 @@ static void foreach_vc_with_status(int status,
 
 void telephony_call_hold_req(void *telephony_device, const char *cmd)
 {
+	const char *idx;
 	struct voice_call *call;
 	int err = 0;
 
 	DBG("telephony-ofono: got call hold request %s", cmd);
 
+	if (strlen(cmd) > 1)
+		idx = &cmd[1];
+	else
+		idx = NULL;
+
+	if (idx)
+		call = g_slist_nth_data(calls, strtol(idx, NULL, 0) - 1);
+	else
+		call = NULL;
+
 	switch (cmd[0]) {
 	case '0':
 		if (find_vc_with_status(CALL_STATUS_WAITING))
@@ -480,18 +495,25 @@ void telephony_call_hold_req(void *telephony_device, const char *cmd)
 			foreach_vc_with_status(CALL_STATUS_HELD, release_call);
 		break;
 	case '1':
+		if (idx) {
+			if (call)
+				err = release_call(call);
+			break;
+		}
 		err = release_answer_calls();
 		break;
 	case '2':
-		call = find_vc_with_status(CALL_STATUS_WAITING);
+		if (idx) {
+			if (call)
+				err = split_call(call);
+		} else {
+			call = find_vc_with_status(CALL_STATUS_WAITING);
 
-		if (call)
-			err = answer_call(call);
-		else
-			err = swap_calls();
-		break;
-	case '4':
-		err = call_transfer();
+			if (call)
+				err = answer_call(call);
+			else
+				err = swap_calls();
+		}
 		break;
 	default:
 		DBG("Unknown call hold request");
-- 
1.7.1

