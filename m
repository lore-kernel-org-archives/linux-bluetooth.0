Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH] unit: Fix gobex unit tests
Date: Mon, 26 Oct 2015 22:48:03 +0100
Message-Id: <1445896083-15680-1-git-send-email-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

/gobex/test_header_encode_connid test name was duplicated.
This results in Glib assert:
(unit/test-gobex-header:15356): GLib-ERROR **: duplicate test
    case path: /gobex/test_header_encode_connid
---
 unit/test-gobex-header.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/unit/test-gobex-header.c b/unit/test-gobex-header.c
index 6f49312..8705892 100644
--- a/unit/test-gobex-header.c
+++ b/unit/test-gobex-header.c
@@ -554,7 +554,7 @@ int main(int argc, char *argv[])
 					test_header_encode_name_umlaut);
 	g_test_add_func("/gobex/test_header_encode_body",
 						test_header_encode_body);
-	g_test_add_func("/gobex/test_header_encode_connid",
+	g_test_add_func("/gobex/test_header_encode_actionid",
 						test_header_encode_actionid);
 	g_test_add_func("/gobex/test_header_encode_apparam",
 						test_header_encode_apparam);
-- 
2.6.2

