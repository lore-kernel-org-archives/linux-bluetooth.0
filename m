Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 1/3] Move telephony_last_dialed_number_req
Date: Tue, 15 Mar 2011 14:55:52 +0200
Message-Id: <1300193754-5748-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

telephony_last_dialed_number_req function moved to be after
send_method_call. It is used in successive commit.
---
 audio/telephony-maemo6.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
index b0f314c..04c69c6 100644
--- a/audio/telephony-maemo6.c
+++ b/audio/telephony-maemo6.c
@@ -475,18 +475,6 @@ void telephony_response_and_hold_req(void *telephony_device, int rh)
 						CME_ERROR_NOT_SUPPORTED);
 }
 
-void telephony_last_dialed_number_req(void *telephony_device)
-{
-	DBG("telephony-maemo6: last dialed number request");
-
-	if (last_dialed_number)
-		telephony_dial_number_req(telephony_device,
-						last_dialed_number);
-	else
-		telephony_last_dialed_number_rsp(telephony_device,
-						CME_ERROR_NOT_ALLOWED);
-}
-
 void telephony_terminate_call_req(void *telephony_device)
 {
 	struct csd_call *call;
@@ -589,6 +577,18 @@ static int send_method_call(const char *dest, const char *path,
 	return 0;
 }
 
+void telephony_last_dialed_number_req(void *telephony_device)
+{
+	DBG("telephony-maemo6: last dialed number request");
+
+	if (last_dialed_number)
+		telephony_dial_number_req(telephony_device,
+						last_dialed_number);
+	else
+		telephony_last_dialed_number_rsp(telephony_device,
+						CME_ERROR_NOT_ALLOWED);
+}
+
 static const char *memory_dial_lookup(int location)
 {
 	if (location == 1)
-- 
1.7.1

