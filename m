Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 02/11] android/unit: Rename cmd handler
Date: Tue,  4 Feb 2014 15:39:00 +0100
Message-Id: <1391524749-2518-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1391524749-2518-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1391524749-2518-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This handler responses for opcode == 1, thus should use proper naming to
avoid confision when more functions sending different responses will be
added.
---
 android/test-ipc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/test-ipc.c b/android/test-ipc.c
index d0f3f6b..8e31507 100644
--- a/android/test-ipc.c
+++ b/android/test-ipc.c
@@ -363,7 +363,7 @@ static void test_cmd_reg_1(gconstpointer data)
 	ipc_cleanup();
 }
 
-static void test_cmd_handler(const void *buf, uint16_t len)
+static void test_cmd_handler_1(const void *buf, uint16_t len)
 {
 	ipc_send_rsp(0, 1, 0);
 }
@@ -383,7 +383,7 @@ static const struct test_data test_cmd_service_invalid_1 = {
 };
 
 static const struct ipc_handler cmd_handlers[] = {
-	{ test_cmd_handler, false, 0 }
+	{ test_cmd_handler_1, false, 0 }
 };
 
 static const struct test_data test_cmd_service_valid_1 = {
-- 
1.8.5.2

