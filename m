Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH] shared/hfp: Remove not used permissive_syntax value
Date: Wed, 24 Sep 2014 07:57:50 +0200
Message-Id: <1411538270-20722-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/shared/hfp.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 196e777..efc981f 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -46,7 +46,6 @@ struct hfp_gw {
 	struct ringbuf *write_buf;
 	struct queue *cmd_handlers;
 	bool writer_active;
-	bool permissive_syntax;
 	bool result_pending;
 	hfp_command_func_t command_callback;
 	hfp_destroy_func_t command_destroy;
@@ -507,7 +506,6 @@ struct hfp_gw *hfp_gw_new(int fd)
 	}
 
 	hfp->writer_active = false;
-	hfp->permissive_syntax = false;
 	hfp->result_pending = false;
 
 	return hfp_gw_ref(hfp);
@@ -610,16 +608,6 @@ bool hfp_gw_set_close_on_unref(struct hfp_gw *hfp, bool do_close)
 	return true;
 }
 
-bool hfp_gw_set_permissive_syntax(struct hfp_gw *hfp, bool permissive)
-{
-	if (!hfp)
-		return false;
-
-	hfp->permissive_syntax = permissive;
-
-	return true;
-}
-
 bool hfp_gw_send_result(struct hfp_gw *hfp, enum hfp_result result)
 {
 	const char *str;
-- 
1.8.4

