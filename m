Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] android/tester: Use default ssp handler in A2dp - Suspend test case
Date: Fri,  5 Sep 2014 10:09:56 +0200
Message-Id: <1409904596-10254-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1409904596-10254-1-git-send-email-marcin.kraglak@tieto.com>
References: <1409904596-10254-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Because ssp_handler was incorrectly overriden with default_ssp_req_cb
in previous test case, this test case used it also. Now it is needed
to define it for each test case where it should be used.
---
 android/tester-a2dp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/android/tester-a2dp.c b/android/tester-a2dp.c
index 6d4043b..1b2a8ce 100644
--- a/android/tester-a2dp.c
+++ b/android/tester-a2dp.c
@@ -243,6 +243,7 @@ static struct test_case test_cases[] = {
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
 	TEST_CASE_BREDRLE("A2DP Suspend - Success",
+		ACTION_SUCCESS(set_default_ssp_request_handler, NULL),
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
-- 
1.9.0

