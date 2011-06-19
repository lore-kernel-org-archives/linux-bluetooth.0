Return-Path: <cyrus@holtmann.org>
From: Jakub Adamek <adamek.kuba@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Adamek <adamek.kuba@gmail.com>
Subject: [PATCH obexd 08/10] Handle partial content response from server
Date: Sun, 19 Jun 2011 02:59:44 +0200
Message-Id: <1308445186-27135-9-git-send-email-adamek.kuba@gmail.com>
In-Reply-To: <1308445186-27135-1-git-send-email-adamek.kuba@gmail.com>
References: <1308445186-27135-1-git-send-email-adamek.kuba@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 gwobex/obex-priv.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gwobex/obex-priv.c b/gwobex/obex-priv.c
index 5d3b458..c8043e1 100644
--- a/gwobex/obex-priv.c
+++ b/gwobex/obex-priv.c
@@ -362,7 +362,7 @@ static void obex_request_done(GwObex *ctx, obex_object_t *object,
 
     ctx->obex_rsp = obex_rsp;
 
-    if (obex_rsp != OBEX_RSP_SUCCESS) {
+    if (obex_rsp != OBEX_RSP_SUCCESS && obex_rsp != OBEX_RSP_PARTIAL_CONTENT) {
         debug("%s command (0x%02x) failed: %s (0x%02x)\n",
                 optostr((uint8_t)obex_cmd), (uint8_t)obex_cmd,
                 OBEX_ResponseToString(obex_rsp), (uint8_t)obex_rsp);
-- 
1.7.0.4

