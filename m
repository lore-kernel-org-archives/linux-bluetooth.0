Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH 1/2] shared/btp: Fix return type in btp_send
Date: Fri, 23 Feb 2018 14:40:09 +0100
Message-Id: <20180223134010.20312-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This function returns bool.
---
 src/shared/btp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/btp.c b/src/shared/btp.c
index 77622671c..555dabc39 100644
--- a/src/shared/btp.c
+++ b/src/shared/btp.c
@@ -297,7 +297,7 @@ bool btp_send(struct btp *btp, uint8_t service, uint8_t opcode, uint8_t index,
 	len = sizeof(*hdr) + length;
 	hdr = l_malloc(len);
 	if (!hdr)
-		return NULL;
+		return false;
 
 	hdr->service = service;
 	hdr->opcode = opcode;
-- 
2.14.3

