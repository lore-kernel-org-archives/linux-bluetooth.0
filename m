Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 02/10] telephony-ofono: fix not being able to answer alerting/waiting calls
Date: Wed,  5 Jan 2011 17:59:39 +0200
Message-Id: <1294243187-1849-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1294243187-1849-1-git-send-email-luiz.dentz@gmail.com>
References: <1294243187-1849-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

---
 audio/telephony-ofono.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/audio/telephony-ofono.c b/audio/telephony-ofono.c
index babf38f..4f69673 100644
--- a/audio/telephony-ofono.c
+++ b/audio/telephony-ofono.c
@@ -263,9 +263,16 @@ void telephony_terminate_call_req(void *telephony_device)
 
 void telephony_answer_call_req(void *telephony_device)
 {
-	struct voice_call *vc = find_vc_with_status(CALL_STATUS_INCOMING);
+	struct voice_call *vc;
 	int ret;
 
+	vc = find_vc_with_status(CALL_STATUS_INCOMING);
+	if (!vc)
+		vc = find_vc_with_status(CALL_STATUS_ALERTING);
+
+	if (!vc)
+		vc = find_vc_with_status(CALL_STATUS_WAITING);
+
 	if (!vc) {
 		telephony_answer_call_rsp(telephony_device,
 					CME_ERROR_NOT_ALLOWED);
-- 
1.7.1

