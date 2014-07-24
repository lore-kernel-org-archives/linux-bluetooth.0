Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 12/14] android/tester-ng: Fix trying to verify late callbacks
Date: Thu, 24 Jul 2014 10:38:05 +0200
Message-Id: <1406191087-5831-12-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1406191087-5831-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1406191087-5831-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dont even try to verify late callbacks when test case already ended.
This was triggering confusing message about verifying step N+1 when we
have only N steps in current case.
---
 android/tester-main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/android/tester-main.c b/android/tester-main.c
index 40416d7..c868943 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -543,8 +543,15 @@ static gboolean verify_action(gpointer user_data)
 
 static gboolean verify_callback(gpointer user_data)
 {
+	struct test_data *data = tester_get_data();
 	struct step *step = user_data;
 
+	/* Return if callback came when all steps are already verified */
+	if (queue_isempty(data->steps)) {
+		destroy_callback_step(step);
+		return FALSE;
+	}
+
 	/*
 	 * TODO: This may call action from next step before callback data
 	 * from previous step was freed.
-- 
1.9.1

