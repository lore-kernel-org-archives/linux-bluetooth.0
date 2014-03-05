Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] tools/sco-tester: Remove not used function argument
Date: Wed,  5 Mar 2014 08:15:47 +0100
Message-Id: <1394003747-23412-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/sco-tester.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/sco-tester.c b/tools/sco-tester.c
index 25e4af6..db45ef0 100644
--- a/tools/sco-tester.c
+++ b/tools/sco-tester.c
@@ -415,7 +415,7 @@ end:
 	close(sk);
 }
 
-static int create_sco_sock(struct test_data *data, uint16_t psm)
+static int create_sco_sock(struct test_data *data)
 {
 	const uint8_t *master_bdaddr;
 	struct sockaddr_sco addr;
@@ -514,7 +514,7 @@ static void test_connect(const void *test_data)
 	GIOChannel *io;
 	int sk;
 
-	sk = create_sco_sock(data, 0);
+	sk = create_sco_sock(data);
 	if (sk < 0) {
 		tester_test_failed();
 		return;
@@ -543,7 +543,7 @@ static void test_connect_transp(const void *test_data)
 	int sk, err;
 	struct bt_voice voice;
 
-	sk = create_sco_sock(data, 0);
+	sk = create_sco_sock(data);
 	if (sk < 0) {
 		tester_test_failed();
 		return;
-- 
1.8.5.3

