Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] tools/rfcomm-tester: Fix double test pass for sock serv success TC
Date: Mon,  3 Feb 2014 16:56:57 +0100
Message-Id: <1391443017-12384-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes double set of pass state in Basic RFCOMM Socket Server
- Success test case. It avoid double test case teardown, which can
affect the proper conduct of later test cases. First set state to pass is
set within rfcomm_listen_cb. Second and properly at connection_cb.
---
 tools/rfcomm-tester.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/rfcomm-tester.c b/tools/rfcomm-tester.c
index 44df7e7..9d2cfc6 100644
--- a/tools/rfcomm-tester.c
+++ b/tools/rfcomm-tester.c
@@ -436,6 +436,7 @@ static gboolean rfcomm_listen_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
 	struct test_data *data = tester_get_data();
+	const struct rfcomm_server_data *server_data = data->test_data;
 	int sk, new_sk;
 
 	data->io_id = 0;
@@ -450,7 +451,8 @@ static gboolean rfcomm_listen_cb(GIOChannel *io, GIOCondition cond,
 
 	close(new_sk);
 
-	tester_test_passed();
+	if (server_data->client_channel == 0x0e)
+		tester_test_passed();
 
 	return false;
 }
-- 
1.8.5.2

