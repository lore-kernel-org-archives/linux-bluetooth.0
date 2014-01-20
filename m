Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] tester: Remove test timeout for setup failure
Date: Mon, 20 Jan 2014 11:00:07 +0100
Message-Id: <1390212008-5376-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If setup fails, timeout function is not removed and still can be called,
causing random subsequent case failure.
---
 src/shared/tester.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/shared/tester.c b/src/shared/tester.c
index f3edd74..06fc415 100644
--- a/src/shared/tester.c
+++ b/src/shared/tester.c
@@ -460,6 +460,11 @@ void tester_setup_failed(void)
 	if (test->stage != TEST_STAGE_SETUP)
 		return;
 
+	if (test->timeout_id > 0) {
+		g_source_remove(test->timeout_id);
+		test->timeout_id = 0;
+	}
+
 	print_progress(test->name, COLOR_RED, "setup failed");
 
 	g_idle_add(done_callback, test);
-- 
1.8.5.2

