Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 12/12] profiles/network: Move disconn cb setting to bnep connect method
Date: Thu, 26 Feb 2015 12:53:34 +0100
Message-Id: <1424951614-8527-12-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1424951614-8527-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1424951614-8527-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Disconnect callback can be set while connececting bnep. In previous
implementation there was seperated method to setting up the disconnect
callback and it was always called immediately after calling connect -
this method was redundand.
---
 android/pan.c                 |  5 ++---
 profiles/network/bnep.c       | 22 +++++++---------------
 profiles/network/bnep.h       |  6 +++---
 profiles/network/connection.c |  4 +---
 4 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/android/pan.c b/android/pan.c
index 08c8134..4c4851f 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -324,14 +324,13 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer data)
 	if (!dev->session)
 		goto fail;
 
-	perr = bnep_connect(dev->session, bnep_conn_cb, dev);
+	perr = bnep_connect(dev->session, bnep_conn_cb, bnep_disconn_cb, dev,
+									dev);
 	if (perr < 0) {
 		error("bnep connect req failed: %s", strerror(-perr));
 		goto fail;
 	}
 
-	bnep_set_disconnect(dev->session, bnep_disconn_cb, dev);
-
 	if (dev->io) {
 		g_io_channel_unref(dev->io);
 		dev->io = NULL;
diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index 7ec166c..2c10572 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -369,17 +369,21 @@ void bnep_free(struct bnep *session)
 	g_free(session);
 }
 
-int bnep_connect(struct bnep *session, bnep_connect_cb conn_cb, void *data)
+int bnep_connect(struct bnep *session, bnep_connect_cb conn_cb,
+					bnep_disconnect_cb disconn_cb,
+					void *conn_data, void *disconn_data)
 {
 	GError *gerr = NULL;
 	int err;
 
-	if (!session || !conn_cb)
+	if (!session || !conn_cb || !disconn_cb)
 		return -EINVAL;
 
 	session->attempts = 0;
 	session->conn_cb = conn_cb;
-	session->conn_data = data;
+	session->disconn_cb = disconn_cb;
+	session->conn_data = conn_data;
+	session->disconn_data = disconn_data;
 
 	bt_io_get(session->io, &gerr, BT_IO_OPT_DEST_BDADDR, &session->dst_addr,
 							BT_IO_OPT_INVALID);
@@ -417,18 +421,6 @@ void bnep_disconnect(struct bnep *session)
 	bnep_conndel(&session->dst_addr);
 }
 
-void bnep_set_disconnect(struct bnep *session, bnep_disconnect_cb disconn_cb,
-								void *data)
-{
-	if (!session || !disconn_cb)
-		return;
-
-	if (!session->disconn_cb && !session->disconn_data) {
-		session->disconn_cb = disconn_cb;
-		session->disconn_data = data;
-	}
-}
-
 static int bnep_add_to_bridge(const char *devname, const char *bridge)
 {
 	int ifindex;
diff --git a/profiles/network/bnep.h b/profiles/network/bnep.h
index 31f9b67..b284699 100644
--- a/profiles/network/bnep.h
+++ b/profiles/network/bnep.h
@@ -31,10 +31,10 @@ struct bnep *bnep_new(int sk, uint16_t local_role, uint16_t remote_role,
 void bnep_free(struct bnep *session);
 
 typedef void (*bnep_connect_cb) (char *iface, int err, void *data);
-int bnep_connect(struct bnep *session, bnep_connect_cb conn_cb, void *data);
 typedef void (*bnep_disconnect_cb) (void *data);
-void bnep_set_disconnect(struct bnep *session, bnep_disconnect_cb disconn_cb,
-								void *data);
+int bnep_connect(struct bnep *session, bnep_connect_cb conn_cb,
+					bnep_disconnect_cb disconn_cb,
+					void *conn_data, void *disconn_data);
 void bnep_disconnect(struct bnep *session);
 
 int bnep_server_add(int sk, char *bridge, char *iface, const bdaddr_t *addr,
diff --git a/profiles/network/connection.c b/profiles/network/connection.c
index 1cd3293..b12da6e 100644
--- a/profiles/network/connection.c
+++ b/profiles/network/connection.c
@@ -257,14 +257,12 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer data)
 	if (!nc->session)
 		goto failed;
 
-	perr = bnep_connect(nc->session, bnep_conn_cb, nc);
+	perr = bnep_connect(nc->session, bnep_conn_cb, bnep_disconn_cb, nc, nc);
 	if (perr < 0) {
 		error("bnep connect(): %s (%d)", strerror(-perr), -perr);
 		goto failed;
 	}
 
-	bnep_set_disconnect(nc->session, bnep_disconn_cb, nc);
-
 	if (nc->io) {
 		g_io_channel_unref(nc->io);
 		nc->io = NULL;
-- 
2.1.0

