Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 3/5] android/tester: Fix hdp cases not handling ssp correctly
Date: Wed,  3 Sep 2014 10:56:39 +0200
Message-Id: <1409734601-8078-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1409734601-8078-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1409734601-8078-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-hdp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/android/tester-hdp.c b/android/tester-hdp.c
index bb73681..9ecef21 100644
--- a/android/tester-hdp.c
+++ b/android/tester-hdp.c
@@ -478,6 +478,7 @@ static struct test_case test_cases[] = {
 					BTHL_APP_REG_STATE_DEREG_SUCCESS),
 	),
 	TEST_CASE_BREDRLE("HDP Connect Source Reliable Channel",
+		ACTION_SUCCESS(set_default_ssp_request_handler, NULL),
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
@@ -498,6 +499,7 @@ static struct test_case test_cases[] = {
 						BTHL_CONN_STATE_CONNECTED),
 	),
 	TEST_CASE_BREDRLE("HDP Destroy Source Reliable Channel",
+		ACTION_SUCCESS(set_default_ssp_request_handler, NULL),
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
@@ -521,6 +523,7 @@ static struct test_case test_cases[] = {
 						BTHL_CONN_STATE_DESTROYED),
 	),
 	TEST_CASE_BREDRLE("HDP Connect Sink Streaming Channel",
+		ACTION_SUCCESS(set_default_ssp_request_handler, NULL),
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
@@ -544,6 +547,7 @@ static struct test_case test_cases[] = {
 						BTHL_CONN_STATE_CONNECTED),
 	),
 	TEST_CASE_BREDRLE("HDP Destroy Sink Streaming Channel",
+		ACTION_SUCCESS(set_default_ssp_request_handler, NULL),
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
-- 
1.9.1

