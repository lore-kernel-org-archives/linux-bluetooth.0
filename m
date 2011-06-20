Return-Path: <cyrus@holtmann.org>
From: Nami <nami.li@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <haijun@qca.qualcomm.com>, <yongli@qca.qualcomm.com>,
	Nami <nami.li@atheros.com>
Subject: [PATCH obexd 13/14] Set different data format for differnet OBEX protocol.
Date: Mon, 20 Jun 2011 17:44:59 +0800
Message-ID: <1308563100-18917-13-git-send-email-nami.li@atheros.com>
In-Reply-To: <1308563100-18917-1-git-send-email-nami.li@atheros.com>
References: <1308563100-18917-1-git-send-email-nami.li@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/session.c   |    4 ++--
 gwobex/gw-obex.c   |    6 +++---
 gwobex/gw-obex.h   |    3 ++-
 gwobex/obex-priv.c |    4 ++--
 gwobex/obex-priv.h |    2 +-
 5 files changed, 10 insertions(+), 9 deletions(-)
 mode change 100755 => 100644 client/session.c

diff --git a/client/session.c b/client/session.c
old mode 100755
new mode 100644
index 8119801..7acd3bb
--- a/client/session.c
+++ b/client/session.c
@@ -247,7 +247,7 @@ static void rfcomm_callback(GIOChannel *io, GError *err, gpointer user_data)
 	fd = g_io_channel_unix_get_fd(io);

 	obex = gw_obex_setup_fd(fd, session->target,
-			session->target_len, NULL, NULL);
+			session->target_len, NULL, NULL, FDOBEX_MT_STREAM);

 	session->obex = obex;

@@ -306,7 +306,7 @@ static void l2cap_callback(GIOChannel *io, GError *err, gpointer user_data)


 	obex = gw_obex_setup_fd(fd, session->target,
-			session->target_len, NULL, NULL);
+			session->target_len, NULL, NULL,FDOBEX_MT_SEQPACKET);

 	session->obex = obex;

diff --git a/gwobex/gw-obex.c b/gwobex/gw-obex.c
index 4481212..32331ed 100644
--- a/gwobex/gw-obex.c
+++ b/gwobex/gw-obex.c
@@ -322,11 +322,11 @@ void gw_obex_close(GwObex *ctx) {
 }

 GwObex *gw_obex_setup_fd(int fd, const gchar *uuid, gint uuid_len,
-                         GMainContext *context, gint *error) {
+                         GMainContext *context, gint *error, gint fmt) {
     obex_t *handle;
     GwObex *ctx;

-    if (!gw_obex_transport_setup(fd, &handle)) {
+    if (!gw_obex_transport_setup(fd, &handle, fmt)) {
         debug("gw_obex_open() failed\n");
         if (error)
             *error = GW_OBEX_ERROR_CONNECT_FAILED;
@@ -394,7 +394,7 @@ GwObex *gw_obex_setup_dev(const char *dev, const gchar *uuid, gint uuid_len,
         return NULL;
     }

-    ctx = gw_obex_setup_fd(fd, uuid, uuid_len, context, error);
+    ctx = gw_obex_setup_fd(fd, uuid, uuid_len, context, error, FDOBEX_MT_STREAM);
     if (ctx == NULL) {
         close(fd);
     }
diff --git a/gwobex/gw-obex.h b/gwobex/gw-obex.h
index c858341..985c85b 100644
--- a/gwobex/gw-obex.h
+++ b/gwobex/gw-obex.h
@@ -183,7 +183,8 @@ GwObex *gw_obex_setup_fd(int fd,
                          const gchar *uuid,
                          gint uuid_len,
                          GMainContext *context,
-                         gint *error);
+                         gint *error,
+                         gint fmt);


 /** Close GW OBEX connection and free all memory associated with it.
diff --git a/gwobex/obex-priv.c b/gwobex/obex-priv.c
index aba7dd7..ba24f8c 100644
--- a/gwobex/obex-priv.c
+++ b/gwobex/obex-priv.c
@@ -612,7 +612,7 @@ void obex_link_error(GwObex *ctx) {
     }
 }

-gboolean gw_obex_transport_setup(int fd, obex_t **handle) {
+gboolean gw_obex_transport_setup(int fd, obex_t **handle, int fmt) {
     *handle = OBEX_Init(OBEX_TRANS_FD, obex_event_handler, 0);
     if (*handle == NULL) {
         debug("OBEX_Init() failed\n");
@@ -621,7 +621,7 @@ gboolean gw_obex_transport_setup(int fd, obex_t **handle) {

     (void) OBEX_SetTransportMTU(*handle, GW_OBEX_RX_MTU, GW_OBEX_TX_MTU);

-    if (FdOBEX_TransportSetup(*handle, fd, fd, 0) < 0) {
+    if (FdOBEX_TransportSetup(*handle, fd, fd, 0, fmt) < 0) {
         debug("FdOBEX_TransportSetup() failed\n");
         OBEX_Cleanup(*handle);
         return FALSE;
diff --git a/gwobex/obex-priv.h b/gwobex/obex-priv.h
index f4e3e5b..66738a4 100644
--- a/gwobex/obex-priv.h
+++ b/gwobex/obex-priv.h
@@ -181,7 +181,7 @@ gboolean gw_obex_connect(GwObex *ctx, const char *target, size_t target_len);

 gboolean gw_obex_disconnect(GwObex *ctx);

-gboolean gw_obex_transport_setup(int fd, obex_t **handle);
+gboolean gw_obex_transport_setup(int fd, obex_t **handle, int fmt);

 gboolean gw_obex_action_op(GwObex *ctx, const gchar *src, const gchar *dst,
                            uint8_t action);
--
1.7.1

