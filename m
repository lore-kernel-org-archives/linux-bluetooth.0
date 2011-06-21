Return-Path: <cyrus@holtmann.org>
From: Jakub Adamek <adamek.kuba@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Adamek <adamek.kuba@gmail.com>
Subject: [PATCH obexd v2 04/11] Store received headers in gw_obex_xfer object
Date: Wed, 22 Jun 2011 00:24:18 +0200
Message-Id: <1308695065-3784-5-git-send-email-adamek.kuba@gmail.com>
In-Reply-To: <1308695065-3784-1-git-send-email-adamek.kuba@gmail.com>
References: <1308695065-3784-1-git-send-email-adamek.kuba@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 gwobex/obex-priv.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/gwobex/obex-priv.c b/gwobex/obex-priv.c
index aba7dd7..7d85045 100644
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
@@ -358,6 +360,10 @@ static void get_non_body_headers(obex_t *handle, obex_object_t *object,
                     xfer->apparam_size = 0;
                 break;
             default:
+                ah = make_a_header(hi, hv, hlen);
+
+                if (ah != NULL)
+                    xfer->aheaders = g_slist_append(xfer->aheaders, ah);
                 break;
         }
     }
-- 
1.7.0.4

