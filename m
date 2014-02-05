Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 2/5] profiles/network: Allow to pass interface name to bnep_new
Date: Wed,  5 Feb 2014 17:00:31 +0100
Message-Id: <1391616034-23312-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1391616034-23312-1-git-send-email-szymon.janc@tieto.com>
References: <1391616034-23312-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pan.c                 | 3 ++-
 profiles/network/bnep.c       | 5 ++++-
 profiles/network/bnep.h       | 3 ++-
 profiles/network/connection.c | 6 ++++--
 4 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/android/pan.c b/android/pan.c
index 2bc54bd..07cddc9 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -52,6 +52,7 @@
 #define SVC_HINT_NETWORKING 0x02
 
 #define BNEP_BRIDGE "bnep"
+#define BNEP_PANU_INTERFACE "bt-pan"
 #define FORWARD_DELAY_PATH "/sys/class/net/"BNEP_BRIDGE"/bridge/forward_delay"
 
 static bdaddr_t adapter_addr;
@@ -194,7 +195,7 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer data)
 
 	sk = g_io_channel_unix_get_fd(dev->io);
 
-	dev->session = bnep_new(sk, l_role, r_role);
+	dev->session = bnep_new(sk, l_role, r_role, BNEP_PANU_INTERFACE);
 	if (!dev->session)
 		goto fail;
 
diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index 82d0d99..1aa0783 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -386,7 +386,8 @@ static gboolean bnep_conn_req_to(gpointer user_data)
 	return FALSE;
 }
 
-struct bnep *bnep_new(int sk, uint16_t local_role, uint16_t remote_role)
+struct bnep *bnep_new(int sk, uint16_t local_role, uint16_t remote_role,
+								char *iface)
 {
 	struct bnep *session;
 	int dup_fd;
@@ -399,6 +400,8 @@ struct bnep *bnep_new(int sk, uint16_t local_role, uint16_t remote_role)
 	session->io = g_io_channel_unix_new(dup_fd);
 	session->src = local_role;
 	session->dst = remote_role;
+	strncpy(session->iface, iface, 16);
+	session->iface[15] = '\0';
 
 	g_io_channel_set_close_on_unref(session->io, TRUE);
 	session->watch = g_io_add_watch(session->io,
diff --git a/profiles/network/bnep.h b/profiles/network/bnep.h
index 87cdacf..bc43d4f 100644
--- a/profiles/network/bnep.h
+++ b/profiles/network/bnep.h
@@ -30,7 +30,8 @@ uint16_t bnep_service_id(const char *svc);
 const char *bnep_uuid(uint16_t id);
 const char *bnep_name(uint16_t id);
 
-struct bnep *bnep_new(int sk, uint16_t local_role, uint16_t remote_role);
+struct bnep *bnep_new(int sk, uint16_t local_role, uint16_t remote_role,
+								char *iface);
 void bnep_free(struct bnep *session);
 
 typedef void (*bnep_connect_cb) (char *iface, int err, void *data);
diff --git a/profiles/network/connection.c b/profiles/network/connection.c
index 5f45fdb..cc73989 100644
--- a/profiles/network/connection.c
+++ b/profiles/network/connection.c
@@ -51,6 +51,7 @@
 #include "connection.h"
 
 #define NETWORK_PEER_INTERFACE "org.bluez.Network1"
+#define BNEP_INTERFACE "bnep%d"
 
 typedef enum {
 	CONNECTED,
@@ -128,7 +129,8 @@ static void bnep_disconn_cb(gpointer data)
 
 	nc->state = DISCONNECTED;
 	memset(nc->dev, 0, sizeof(nc->dev));
-	strcpy(nc->dev, "bnep%d");
+	strncpy(nc->dev, BNEP_INTERFACE, 16);
+	nc->dev[15] = '\0';
 
 	bnep_free(nc->session);
 	nc->session = NULL;
@@ -243,7 +245,7 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer data)
 	}
 
 	sk = g_io_channel_unix_get_fd(nc->io);
-	nc->session = bnep_new(sk, BNEP_SVC_PANU, nc->id);
+	nc->session = bnep_new(sk, BNEP_SVC_PANU, nc->id, BNEP_INTERFACE);
 	if (!nc->session)
 		goto failed;
 
-- 
1.8.3.2

