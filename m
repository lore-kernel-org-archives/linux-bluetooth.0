Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] shared/hfp: Remove dead code
Date: Mon, 22 Dec 2014 15:16:51 +0200
Message-Id: <1419254211-6211-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Remove dead code since free_tmp initialized to false.
---
 src/shared/hfp.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 9d937a5..05a8563 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -1192,10 +1192,6 @@ static void hf_process_input(struct hfp_hf *hfp)
 	if (len == ringbuf_len(hfp->read_buf))
 		goto done;
 
-	/* If we are here second time for some reason, that is wrong */
-	if (free_tmp)
-		goto done;
-
 	str2 = ringbuf_peek(hfp->read_buf, len, &len2);
 	if (!str2)
 		goto done;
-- 
2.1.0

