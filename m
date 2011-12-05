Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 2/4] gobex: fix wrong name of test_get_rsp_eagain
Date: Mon,  5 Dec 2011 14:35:17 +0200
Message-Id: <1323088519-18235-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1323088519-18235-1-git-send-email-luiz.dentz@gmail.com>
References: <1323088519-18235-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 unit/test-gobex-transfer.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/unit/test-gobex-transfer.c b/unit/test-gobex-transfer.c
index ae3e28a..518fd94 100644
--- a/unit/test-gobex-transfer.c
+++ b/unit/test-gobex-transfer.c
@@ -1349,7 +1349,7 @@ int main(int argc, char *argv[])
 	g_test_add_func("/gobex/test_get_rsp_delay", test_get_rsp_delay);
 
 	g_test_add_func("/gobex/test_put_req_eagain", test_put_req_eagain);
-	g_test_add_func("/gobex/test_put_req_eagain", test_get_rsp_eagain);
+	g_test_add_func("/gobex/test_get_req_eagain", test_get_rsp_eagain);
 
 	g_test_add_func("/gobex/test_put_req_random", test_put_req_random);
 
-- 
1.7.7.3

