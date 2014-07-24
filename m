Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 09/14] android/tester-ng: Add socket double listen fail case
Date: Thu, 24 Jul 2014 10:38:02 +0200
Message-Id: <1406191087-5831-9-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1406191087-5831-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1406191087-5831-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-socket.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/android/tester-socket.c b/android/tester-socket.c
index 5994a3d..1ccd29b 100644
--- a/android/tester-socket.c
+++ b/android/tester-socket.c
@@ -217,6 +217,16 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
+	TEST_CASE_BREDRLE("Socket Listen - Invalid: double Listen",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(socket_listen_action, &btsock_param),
+		ACTION_SUCCESS(socket_verify_fd_action, &btsock_param),
+		ACTION_SUCCESS(socket_verify_channel_action, &btsock_param),
+		ACTION(BT_STATUS_BUSY, socket_listen_action, &btsock_param),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 };
 
 struct queue *get_socket_tests(void)
-- 
1.9.1

