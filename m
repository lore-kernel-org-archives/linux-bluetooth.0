Return-Path: <cyrus@holtmann.org>
From: Lukasz Pawlik <lucas.pawlik@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Pawlik <lucas.pawlik@gmail.com>
Subject: [PATCH] Fix problem with hanging up held call
Date: Wed, 13 Oct 2010 10:37:59 +0200
Message-Id: <1286959079-3566-1-git-send-email-lucas.pawlik@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to the HFP specification AT+CHUP command should not have impact
on the state of any held calls. Previously held call was terminated when
there was second alerting call. This patch fix this problem. AT+CHUP
command will go towards alerting call.
---
 audio/telephony-maemo6.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
index 05ff332..00a4b25 100644
--- a/audio/telephony-maemo6.c
+++ b/audio/telephony-maemo6.c
@@ -498,6 +498,7 @@ void telephony_last_dialed_number_req(void *telephony_device)
 void telephony_terminate_call_req(void *telephony_device)
 {
 	struct csd_call *call;
+	struct csd_call *alerting;
 	int err;
 
 	call = find_call_with_status(CSD_CALL_STATUS_ACTIVE);
@@ -511,6 +512,9 @@ void telephony_terminate_call_req(void *telephony_device)
 		return;
 	}
 
+	alerting = find_call_with_status(CSD_CALL_STATUS_MO_ALERTING);
+	if (call->on_hold && alerting)
+		err = release_call(alerting);
 	if (call->conference)
 		err = release_conference();
 	else
-- 
1.7.0.4

