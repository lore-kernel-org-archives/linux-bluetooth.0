Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] l2cap-tester: Close sk in error path
Date: Thu, 12 Dec 2013 09:48:28 +0200
Message-Id: <1386834508-9929-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This fixes resource leak warnings.
---
 tools/l2cap-tester.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 505ac79..e4dade2 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -503,6 +503,7 @@ static int create_l2cap_sock(struct test_data *data, uint16_t psm)
 	master_bdaddr = hciemu_get_master_bdaddr(data->hciemu);
 	if (!master_bdaddr) {
 		tester_warn("No master bdaddr");
+		close(sk);
 		return -ENODEV;
 	}
 
@@ -701,6 +702,7 @@ static void test_server(const void *test_data)
 			tester_warn("listening on socket failed: %s (%u)",
 					strerror(errno), errno);
 			tester_test_failed();
+			close(sk);
 			return;
 		}
 
-- 
1.8.3.2

