Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 3/3] android/pan: Fix bnep interface name
Date: Thu, 23 Jan 2014 15:39:27 +0200
Message-Id: <1390484367-6332-3-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1390484367-6332-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1390484367-6332-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Android uses bt-pan static interface in PAN profile. In server role
it uses as bridge name. But current implementaion passes interface
names like bnep0, bnep1... Android Java layer unaware of this name
and unable to allocate IP address after profile connection setup.
---
 android/pan.c                 | 45 ++++++++++++++++++++++++++++++++++---------
 profiles/network/bnep.c       |  8 +++++---
 profiles/network/bnep.h       |  3 ++-
 profiles/network/connection.c |  5 +++--
 profiles/network/server.c     |  4 ++++
 5 files changed, 50 insertions(+), 15 deletions(-)

diff --git a/android/pan.c b/android/pan.c
index 67b62f2..8c545c0 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -51,7 +51,9 @@
 
 #define SVC_HINT_NETWORKING 0x02
 
-#define BNEP_BRIDGE "bnep"
+#define BNEP_BRIDGE "bt-pan"
+#define BNEP_PANU_INTERFACE "bt-pan"
+#define BNEP_NAP_INTERFACE "bt-pan%d"
 #define FORWARD_DELAY_PATH "/sys/class/net/"BNEP_BRIDGE"/bridge/forward_delay"
 
 static bdaddr_t adapter_addr;
@@ -71,11 +73,16 @@ struct pan_device {
 static struct {
 	uint32_t	record_id;
 	GIOChannel	*io;
+	bool		bridge;
 } nap_dev = {
 	.record_id = 0,
 	.io = NULL,
+	.bridge = false,
 };
 
+static int nap_create_bridge(void);
+static int nap_remove_bridge(void);
+
 static int device_cmp(gconstpointer s, gconstpointer user_data)
 {
 	const struct pan_device *dev = s;
@@ -102,8 +109,10 @@ static void pan_device_free(struct pan_device *dev)
 	devices = g_slist_remove(devices, dev);
 	g_free(dev);
 
-	if (g_slist_length(devices) == 0)
+	if (g_slist_length(devices) == 0) {
 		local_role = HAL_PAN_ROLE_NONE;
+		nap_remove_bridge();
+	}
 }
 
 static void bt_pan_notify_conn_state(struct pan_device *dev, uint8_t state)
@@ -140,7 +149,11 @@ static void bt_pan_notify_ctrl_state(struct pan_device *dev, uint8_t state)
 	ev.local_role = local_role;
 	ev.status = HAL_STATUS_SUCCESS;
 	memset(ev.name, 0, sizeof(ev.name));
-	memcpy(ev.name, dev->iface, sizeof(dev->iface));
+
+	if (local_role == HAL_PAN_ROLE_NAP)
+		memcpy(ev.name, BNEP_BRIDGE, sizeof(BNEP_BRIDGE));
+	else
+		memcpy(ev.name, dev->iface, sizeof(dev->iface));
 
 	ipc_send_notif(HAL_SERVICE_ID_PAN, HAL_EV_PAN_CTRL_STATE, sizeof(ev),
 									&ev);
@@ -194,7 +207,7 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer data)
 
 	sk = g_io_channel_unix_get_fd(dev->io);
 
-	dev->session = bnep_new(sk, l_role, r_role);
+	dev->session = bnep_new(sk, l_role, r_role, BNEP_PANU_INTERFACE);
 	if (!dev->session)
 		goto fail;
 
@@ -380,6 +393,9 @@ static gboolean nap_setup_cb(GIOChannel *chan, GIOCondition cond,
 		goto failed;
 	}
 
+	if (nap_create_bridge() < 0)
+		goto failed;
+
 	if (bnep_server_add(sk, dst_role, BNEP_BRIDGE, dev->iface,
 							&dev->dst) < 0) {
 		error("server_connadd failed");
@@ -448,6 +464,9 @@ static void nap_confirm_cb(GIOChannel *chan, gpointer data)
 	local_role = HAL_PAN_ROLE_NAP;
 	dev->role = HAL_PAN_ROLE_PANU;
 
+	memset(dev->iface, 0, 16);
+	strcpy(dev->iface, BNEP_NAP_INTERFACE);
+
 	dev->io = g_io_channel_ref(chan);
 	g_io_channel_set_close_on_unref(dev->io, TRUE);
 
@@ -488,6 +507,9 @@ static int nap_create_bridge(void)
 
 	DBG("%s", BNEP_BRIDGE);
 
+	if (nap_dev.bridge == true)
+		return 0;
+
 	sk = socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0);
 	if (sk < 0)
 		return -EOPNOTSUPP;
@@ -506,6 +528,11 @@ static int nap_create_bridge(void)
 
 	close(sk);
 
+	if (err == 0)
+		nap_dev.bridge = true;
+	else
+		nap_dev.bridge = false;
+
 	return err;
 }
 
@@ -515,6 +542,11 @@ static int nap_remove_bridge(void)
 
 	DBG("%s", BNEP_BRIDGE);
 
+	if (nap_dev.bridge == false)
+		return 0;
+
+	nap_dev.bridge = false;
+
 	sk = socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0);
 	if (sk < 0)
 		return -EOPNOTSUPP;
@@ -544,14 +576,9 @@ static void destroy_nap_device(void)
 static int register_nap_server(void)
 {
 	GError *gerr = NULL;
-	int err;
 
 	DBG("");
 
-	err = nap_create_bridge();
-	if (err < 0)
-		return err;
-
 	nap_dev.io = bt_io_listen(NULL, nap_confirm_cb, NULL, NULL, &gerr,
 					BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
 					BT_IO_OPT_PSM, BNEP_PSM,
diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index 2a74016..aed9260 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -173,9 +173,8 @@ static int bnep_connadd(int sk, uint16_t role, char *dev)
 {
 	struct bnep_connadd_req req;
 
-	memset(dev, 0, 16);
 	memset(&req, 0, sizeof(req));
-	strcpy(req.device, "bnep%d");
+	strcpy(req.device, dev);
 	req.sock = sk;
 	req.role = role;
 	if (ioctl(ctl, BNEPCONNADD, &req) < 0) {
@@ -384,7 +383,8 @@ static gboolean bnep_conn_req_to(gpointer user_data)
 	return FALSE;
 }
 
-struct bnep *bnep_new(int sk, uint16_t local_role, uint16_t remote_role)
+struct bnep *bnep_new(int sk, uint16_t local_role, uint16_t remote_role,
+								char *iface)
 {
 	struct bnep *session;
 	int dup_fd;
@@ -397,6 +397,8 @@ struct bnep *bnep_new(int sk, uint16_t local_role, uint16_t remote_role)
 	session->io = g_io_channel_unix_new(dup_fd);
 	session->src = local_role;
 	session->dst = remote_role;
+	memset(session->iface, 0, 16);
+	strcpy(session->iface, iface);
 
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
index c66987d..d01d178 100644
--- a/profiles/network/connection.c
+++ b/profiles/network/connection.c
@@ -51,6 +51,7 @@
 #include "connection.h"
 
 #define NETWORK_PEER_INTERFACE "org.bluez.Network1"
+#define BNEP_INTERFACE	"bnep%d"
 
 typedef enum {
 	CONNECTED,
@@ -128,7 +129,7 @@ static void bnep_disconn_cb(gpointer data)
 
 	nc->state = DISCONNECTED;
 	memset(nc->dev, 0, sizeof(nc->dev));
-	strcpy(nc->dev, "bnep%d");
+	strcpy(nc->dev, BNEP_INTERFACE);
 
 	bnep_free(nc->session);
 	nc->session = NULL;
@@ -243,7 +244,7 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer data)
 	}
 
 	sk = g_io_channel_unix_get_fd(nc->io);
-	nc->session = bnep_new(sk, BNEP_SVC_PANU, nc->id);
+	nc->session = bnep_new(sk, BNEP_SVC_PANU, nc->id, BNEP_INTERFACE);
 	if (!nc->session)
 		goto failed;
 
diff --git a/profiles/network/server.c b/profiles/network/server.c
index 7cb5a1e..755db0d 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -53,6 +53,7 @@
 
 #define NETWORK_SERVER_INTERFACE "org.bluez.NetworkServer1"
 #define SETUP_TIMEOUT		1
+#define BNEP_INTERFACE	"bnep%d"
 
 /* Pending Authorization */
 struct network_session {
@@ -348,6 +349,9 @@ static gboolean bnep_setup(GIOChannel *chan,
 		goto reply;
 	}
 
+	memset(na->setup->dev, 0, 16);
+	strcpy(na->setup->dev, BNEP_INTERFACE);
+
 	if (bnep_server_add(sk, dst_role, ns->bridge, na->setup->dev,
 							&na->setup->dst) < 0)
 		goto reply;
-- 
1.8.3.2

