Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] gwobex: fix misuse of OBEX_SetCustomData/OBEX_GetCustomData
Date: Tue, 17 Aug 2010 16:58:30 +0300
Message-Id: <1282053510-18102-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1282053510-18102-1-git-send-email-luiz.dentz@gmail.com>
References: <1282053510-18102-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

Those function should only be used in case of custom transport which is
not the case since we are using fd transport here.

To fix that it now uses OBEX_SetUserData/OBEX_GetUserData which are not
associate with any transport in particular.
---
 gwobex/gw-obex.c   |    2 +-
 gwobex/obex-priv.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gwobex/gw-obex.c b/gwobex/gw-obex.c
index e656692..4481212 100644
--- a/gwobex/gw-obex.c
+++ b/gwobex/gw-obex.c
@@ -343,7 +343,7 @@ GwObex *gw_obex_setup_fd(int fd, const gchar *uuid, gint uuid_len,
     ctx->mutex = g_mutex_new();
 #endif
 
-    OBEX_SetCustomData(handle, ctx);
+    OBEX_SetUserData(handle, ctx);
 
     debug("Connecting to OBEX service\n");
     if (!gw_obex_connect(ctx, uuid, uuid_len)) {
diff --git a/gwobex/obex-priv.c b/gwobex/obex-priv.c
index 76a9599..aba7dd7 100644
--- a/gwobex/obex-priv.c
+++ b/gwobex/obex-priv.c
@@ -514,7 +514,7 @@ static void obex_writestream(GwObex *ctx, obex_object_t *object) {
 
 static void obex_event_handler(obex_t *handle, obex_object_t *object, int mode,
                                int event, int obex_cmd, int obex_rsp) {
-    GwObex *ctx = OBEX_GetCustomData(handle);
+    GwObex *ctx = OBEX_GetUserData(handle);
     switch (event) {
         case OBEX_EV_ABORT:
             debug("OBEX_EV_ABORT\n");
-- 
1.7.0.4

