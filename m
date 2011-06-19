Return-Path: <cyrus@holtmann.org>
From: Jakub Adamek <adamek.kuba@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Adamek <adamek.kuba@gmail.com>
Subject: [PATCH obexd 03/10] Store received headers in gw_obex_xfer object
Date: Sun, 19 Jun 2011 02:59:39 +0200
Message-Id: <1308445186-27135-4-git-send-email-adamek.kuba@gmail.com>
In-Reply-To: <1308445186-27135-1-git-send-email-adamek.kuba@gmail.com>
References: <1308445186-27135-1-git-send-email-adamek.kuba@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 gwobex/obex-priv.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/gwobex/obex-priv.c b/gwobex/obex-priv.c
index aba7dd7..b9216e5 100644
--- a/gwobex/obex-priv.c
+++ b/gwobex/obex-priv.c
@@ -39,6 +39,7 @@
 #include <sys/socket.h>
 
 #include <openobex/obex.h>
+#include <openobex/obex_const.h>
 
 #ifdef HAVE_CONFIG_H
 # include "config.h"
@@ -335,6 +336,7 @@ static void get_non_body_headers(obex_t *handle, obex_object_t *object,
     obex_headerdata_t hv;
     uint8_t hi;
     unsigned int hlen;
+    struct a_header *ah;
 
     xfer->target_size = GW_OBEX_UNKNOWN_LENGTH;
     xfer->modtime = -1;
@@ -358,6 +360,26 @@ static void get_non_body_headers(obex_t *handle, obex_object_t *object,
                     xfer->apparam_size = 0;
                 break;
             default:
+                ah = g_new0(struct a_header, 1);
+                ah->hi = hi;
+                ah->hv_size = hlen;
+                switch (hi & OBEX_HDR_TYPE_MASK) {
+                    case OBEX_HDR_TYPE_UINT8:
+                    case OBEX_HDR_TYPE_UINT32:
+                        ah->hv = hv;
+                        break;
+                    case OBEX_HDR_TYPE_BYTES:
+                    case OBEX_HDR_TYPE_UNICODE:
+                        ah->hv.bs = g_try_malloc(hlen);
+                        if (ah->hv.bs) {
+                            memcpy((void *) ah->hv.bs, hv.bs, hlen);
+                            ah->hv_size = hlen;
+                        } else {
+                            ah->hv_size = hlen;
+                        }
+                        break;
+                }
+                xfer->aheaders = g_slist_append(xfer->aheaders, ah);
                 break;
         }
     }
-- 
1.7.0.4

