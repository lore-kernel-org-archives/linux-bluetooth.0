Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 6/8] shared/hfp: Remove not used assignment
Date: Thu, 20 Nov 2014 16:55:13 +0100
Message-Id: <1416498915-19534-7-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1416498915-19534-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1416498915-19534-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no need to store how much data has been drain. It is not used.
---
 src/shared/hfp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 2a09658..41eae74 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -520,7 +520,7 @@ static void process_input(struct hfp_gw *hfp)
 
 	handle_at_command(hfp, str);
 
-	len = ringbuf_drain(hfp->read_buf, count + 1);
+	ringbuf_drain(hfp->read_buf, count + 1);
 
 	if (free_ptr)
 		free(ptr);
-- 
1.8.4

