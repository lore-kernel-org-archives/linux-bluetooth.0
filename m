Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] unit/gatt: Fix using possible negative return value
Date: Wed,  3 Dec 2014 16:08:51 +0200
Message-Id: <1417615733-7350-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 unit/test-gatt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 03a66b9..f20da91 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -648,11 +648,11 @@ static void test_server(gconstpointer data)
 
 	len = write(context->fd, pdu.data, pdu.size);
 
+	g_assert_cmpint(len, ==, pdu.size);
+
 	if (g_test_verbose())
 		util_hexdump('<', pdu.data, len, test_debug, "GATT: ");
 
-	g_assert_cmpint(len, ==, pdu.size);
-
 	execute_context(context);
 }
 
-- 
1.9.1

