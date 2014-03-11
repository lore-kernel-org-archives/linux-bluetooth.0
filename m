Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 01/10] unit/avrcp: Pass context to control handlers
Date: Tue, 11 Mar 2014 15:05:45 +0200
Message-Id: <1394543154-25355-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1394458798-13822-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1394458798-13822-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 unit/test-avrcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 9760420..fe7009a 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -578,7 +578,7 @@ static void test_server(gconstpointer data)
 
 	avrcp_set_passthrough_handlers(context->session, passthrough_handlers,
 								context);
-	avrcp_set_control_handlers(context->session, control_handlers, NULL);
+	avrcp_set_control_handlers(context->session, control_handlers, context);
 
 	g_idle_add(send_pdu, context);
 
-- 
1.8.3.2

