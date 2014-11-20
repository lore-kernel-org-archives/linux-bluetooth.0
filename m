Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 1/8] shared/hfp: Trivial, fix comments style
Date: Thu, 20 Nov 2014 16:55:08 +0100
Message-Id: <1416498915-19534-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1416498915-19534-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1416498915-19534-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/shared/hfp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index a35cb7b..7ad6e42 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -473,7 +473,8 @@ static void process_input(struct hfp_gw *hfp)
 		char *str2;
 		size_t len2;
 
-		/* If there is no more data in ringbuffer,
+		/*
+		 * If there is no more data in ringbuffer,
 		 * it's just an incomplete command.
 		 */
 		if (len == ringbuf_len(hfp->read_buf))
-- 
1.8.4

