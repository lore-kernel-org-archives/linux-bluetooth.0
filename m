Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 2/3] Change dial and re-dial in maemo6 telephony
Date: Tue, 15 Mar 2011 14:55:53 +0200
Message-Id: <1300193754-5748-2-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1300193754-5748-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1300193754-5748-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dial and re-dial to last number functions are changed in maemo6
telephony driver accordingly to updated API in csd back-end. CreateWith
method call is replaced by Create and CreateFromLast.

After such modification callerid and last dialed number are not used
and hence removed in sucessive patch.
---
 audio/telephony-maemo6.c |   27 ++++++++++++++-------------
 1 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
index 04c69c6..311b5ed 100644
--- a/audio/telephony-maemo6.c
+++ b/audio/telephony-maemo6.c
@@ -579,14 +579,19 @@ static int send_method_call(const char *dest, const char *path,
 
 void telephony_last_dialed_number_req(void *telephony_device)
 {
+	int ret;
+
 	DBG("telephony-maemo6: last dialed number request");
 
-	if (last_dialed_number)
-		telephony_dial_number_req(telephony_device,
-						last_dialed_number);
+	ret = send_method_call(CSD_CALL_BUS_NAME, CSD_CALL_PATH,
+				CSD_CALL_INTERFACE, "CreateFromLast",
+				NULL, NULL,
+				DBUS_TYPE_INVALID);
+	if (ret < 0)
+		telephony_dial_number_rsp(telephony_device,
+						CME_ERROR_AG_FAILURE);
 	else
-		telephony_last_dialed_number_rsp(telephony_device,
-						CME_ERROR_NOT_ALLOWED);
+		telephony_dial_number_rsp(telephony_device, CME_ERROR_NONE);
 }
 
 static const char *memory_dial_lookup(int location)
@@ -599,18 +604,15 @@ static const char *memory_dial_lookup(int location)
 
 void telephony_dial_number_req(void *telephony_device, const char *number)
 {
-	uint32_t flags = callerid;
 	int ret;
 
 	DBG("telephony-maemo6: dial request to %s", number);
 
-	if (strncmp(number, "*31#", 4) == 0) {
+	if (strncmp(number, "*31#", 4) == 0)
 		number += 4;
-		flags = CALL_FLAG_PRESENTATION_ALLOWED;
-	} else if (strncmp(number, "#31#", 4) == 0) {
+	else if (strncmp(number, "#31#", 4) == 0)
 		number += 4;
-		flags = CALL_FLAG_PRESENTATION_RESTRICTED;
-	} else if (number[0] == '>') {
+	else if (number[0] == '>') {
 		const char *location = &number[1];
 
 		number = memory_dial_lookup(strtol(&number[1], NULL, 0));
@@ -623,10 +625,9 @@ void telephony_dial_number_req(void *telephony_device, const char *number)
 	}
 
 	ret = send_method_call(CSD_CALL_BUS_NAME, CSD_CALL_PATH,
-				CSD_CALL_INTERFACE, "CreateWith",
+				CSD_CALL_INTERFACE, "Create",
 				NULL, NULL,
 				DBUS_TYPE_STRING, &number,
-				DBUS_TYPE_UINT32, &flags,
 				DBUS_TYPE_INVALID);
 	if (ret < 0) {
 		telephony_dial_number_rsp(telephony_device,
-- 
1.7.1

