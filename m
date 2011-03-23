Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] telephony-ofono: fix handling of telephony_key_press_req
Date: Wed, 23 Mar 2011 17:42:07 +0200
Message-Id: <1300894927-31702-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

---
 audio/telephony-ofono.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/audio/telephony-ofono.c b/audio/telephony-ofono.c
index ef4ede7..6f5685b 100644
--- a/audio/telephony-ofono.c
+++ b/audio/telephony-ofono.c
@@ -579,19 +579,17 @@ void telephony_nr_and_ec_req(void *telephony_device, gboolean enable)
 
 void telephony_key_press_req(void *telephony_device, const char *keys)
 {
-	struct voice_call *active, *waiting;
+	struct voice_call *active, *incoming;
 	int err;
 
 	DBG("telephony-ofono: got key press request for %s", keys);
 
-	waiting = find_vc_with_status(CALL_STATUS_INCOMING);
-	if (!waiting)
-		waiting = find_vc_with_status(CALL_STATUS_DIALING);
+	incoming = find_vc_with_status(CALL_STATUS_INCOMING);
 
 	active = find_vc_with_status(CALL_STATUS_ACTIVE);
 
-	if (waiting)
-		err = answer_call(waiting);
+	if (incoming)
+		err = answer_call(incoming);
 	else if (active)
 		err = release_call(active);
 	else
-- 
1.7.1

