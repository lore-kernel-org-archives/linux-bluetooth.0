Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH v3 2/3] shared/att: Use io_set_close_on_destroy.
Date: Wed, 13 Aug 2014 19:27:55 -0700
Message-Id: <1407983276-22573-3-git-send-email-armansito@chromium.org>
In-Reply-To: <1407983276-22573-1-git-send-email-armansito@chromium.org>
References: <1407983276-22573-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It's better to use io_set_close_on_destroy as opposed to keeping a special
"close_on_unref" flag in bt_att. This not only achieves the exact same result,
but also allows the code to automatically close the file descriptor from several
places by simply calling io_destroy.
---
 src/shared/att.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index 0d27dfa..6f5e405 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -47,7 +47,6 @@ struct att_send_op;
 struct bt_att {
 	int ref_count;
 	int fd;
-	bool close_on_unref;
 	struct io *io;
 	bool invalid;  /* bt_att becomes invalid when a request times out */
 
@@ -692,9 +691,6 @@ void bt_att_unref(struct bt_att *att)
 	io_destroy(att->io);
 	att->io = NULL;
 
-	if (att->close_on_unref)
-		close(att->fd);
-
 	if (att->timeout_destroy)
 		att->timeout_destroy(att->timeout_data);
 
@@ -712,9 +708,7 @@ bool bt_att_set_close_on_unref(struct bt_att *att, bool do_close)
 	if (!att)
 		return false;
 
-	att->close_on_unref = do_close;
-
-	return true;
+	return io_set_close_on_destroy(att->io, do_close);
 }
 
 bool bt_att_set_debug(struct bt_att *att, bt_att_debug_func_t callback,
-- 
2.1.0.rc2.206.gedb03e5

