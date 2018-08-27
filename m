Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] unit: Fix out of bounds
Date: Mon, 27 Aug 2018 14:41:05 +0300
Message-Id: <20180827114105.10471-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Test /gobex/test_stream_put_req requires 5 buffers to complete.
---
 unit/util.c | 5 +++++
 unit/util.h | 6 ++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/unit/util.c b/unit/util.c
index 8e3115fe3..ce4d65add 100644
--- a/unit/util.c
+++ b/unit/util.c
@@ -188,6 +188,11 @@ send:
 		goto failed;
 	}
 
+	if (d->count >= TEST_BUF_MAX) {
+		g_print("io_cb count %u\n", d->count);
+		goto failed;
+	}
+
 	if (d->recv[d->count].len < 0 || (gssize) expect_len < 0)
 		return test_io_cb(io, G_IO_OUT, user_data);
 
diff --git a/unit/util.h b/unit/util.h
index 6783c524e..b13fd2f16 100644
--- a/unit/util.h
+++ b/unit/util.h
@@ -19,6 +19,8 @@
  *
  */
 
+#define TEST_BUF_MAX 5
+
 enum {
 	TEST_ERROR_TIMEOUT,
 	TEST_ERROR_UNEXPECTED,
@@ -32,8 +34,8 @@ struct test_buf {
 struct test_data {
 	guint count;
 	GError *err;
-	struct test_buf recv[4];
-	struct test_buf send[4];
+	struct test_buf recv[TEST_BUF_MAX];
+	struct test_buf send[TEST_BUF_MAX];
 	guint provide_delay;
 	GObex *obex;
 	guint id;
-- 
2.17.1
