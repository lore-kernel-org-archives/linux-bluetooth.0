Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 02/10] profiles/network: Handle ctrl rsp after conn setup by bnep
Date: Mon,  9 Mar 2015 17:24:47 +0100
Message-Id: <1425918295-21976-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1425918295-21976-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1425918295-21976-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch moves setup control response to bnep and makes it private.
---
 android/pan.c             | 14 +++--------
 profiles/network/bnep.c   | 60 +++++++++++++++++++++++++++++------------------
 profiles/network/bnep.h   |  2 --
 profiles/network/server.c | 38 ++++++++++--------------------
 4 files changed, 52 insertions(+), 62 deletions(-)

diff --git a/android/pan.c b/android/pan.c
index a1356eb..a14ed84 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -463,7 +463,6 @@ static gboolean nap_setup_cb(GIOChannel *chan, GIOCondition cond,
 {
 	struct pan_device *dev = user_data;
 	uint8_t packet[BNEP_MTU];
-	uint16_t rsp = BNEP_CONN_NOT_ALLOWED;
 	int sk, n, err;
 
 	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL)) {
@@ -486,22 +485,16 @@ static gboolean nap_setup_cb(GIOChannel *chan, GIOCondition cond,
 	}
 
 	err = nap_create_bridge();
-	if (err < 0) {
+	if (err < 0)
 		error("pan: Failed to create bridge: %s (%d)", strerror(-err),
 									-err);
-		goto failed;
-	}
 
-	if (bnep_server_add(sk, BNEP_BRIDGE, dev->iface, &dev->dst, packet, n)
-									< 0) {
+	if (bnep_server_add(sk, (err < 0) ? NULL : BNEP_BRIDGE, dev->iface,
+						&dev->dst, packet, n) < 0) {
 		error("pan: server_connadd failed");
-		rsp = BNEP_CONN_NOT_ALLOWED;
 		goto failed;
 	}
 
-	rsp = BNEP_SUCCESS;
-	bnep_send_ctrl_rsp(sk, BNEP_CONTROL, BNEP_SETUP_CONN_RSP, rsp);
-
 	dev->watch = g_io_add_watch(chan, G_IO_HUP | G_IO_ERR | G_IO_NVAL,
 							nap_watchdog_cb, dev);
 	g_io_channel_unref(dev->io);
@@ -513,7 +506,6 @@ static gboolean nap_setup_cb(GIOChannel *chan, GIOCondition cond,
 	return FALSE;
 
 failed:
-	bnep_send_ctrl_rsp(sk, BNEP_CONTROL, BNEP_SETUP_CONN_RSP, rsp);
 	pan_device_remove(dev);
 
 	return FALSE;
diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index 0a41d73..afd94c5 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -524,6 +524,18 @@ static int bnep_del_from_bridge(const char *devname, const char *bridge)
 	return err;
 }
 
+static ssize_t bnep_send_ctrl_rsp(int sk, uint8_t type, uint8_t ctrl,
+								uint16_t resp)
+{
+	struct bnep_control_rsp rsp;
+
+	rsp.type = type;
+	rsp.ctrl = ctrl;
+	rsp.resp = htons(resp);
+
+	return send(sk, &rsp, sizeof(rsp), 0);
+}
+
 static uint16_t bnep_setup_decode(int sk, struct bnep_setup_conn_req *req,
 								uint16_t *dst)
 {
@@ -578,7 +590,6 @@ static uint16_t bnep_setup_decode(int sk, struct bnep_setup_conn_req *req,
 	case BNEP_SVC_GN:
 		if (src == BNEP_SVC_PANU)
 			return BNEP_SUCCESS;
-
 		return BNEP_CONN_INVALID_SRC;
 	case BNEP_SVC_PANU:
 		if (src == BNEP_SVC_PANU || src == BNEP_SVC_GN ||
@@ -595,7 +606,7 @@ int bnep_server_add(int sk, char *bridge, char *iface, const bdaddr_t *addr,
 						uint8_t *setup_data, int len)
 {
 	int err;
-	uint16_t dst = NULL;
+	uint16_t rsp, dst = NULL;
 	struct bnep_setup_conn_req *req = (void *) setup_data;
 
 	/* Highest known Control command ID
@@ -614,27 +625,41 @@ int bnep_server_add(int sk, char *bridge, char *iface, const bdaddr_t *addr,
 	}
 
 	/* Processing BNEP_SETUP_CONNECTION_REQUEST_MSG */
-	err = bnep_setup_decode(sk, req, &dst);
-	if (err < 0) {
+	rsp = bnep_setup_decode(sk, req, &dst);
+	if (rsp != BNEP_SUCCESS || !dst) {
+		err = -rsp;
 		error("bnep: error while decoding setup connection request: %d",
-									err);
-		return -EINVAL;
+									rsp);
+		goto reply;
 	}
 
-	if (!bridge || !iface || !addr || !dst)
-		return -EINVAL;
+	if (!dst) {
+		error("bnep: cannot decode proper destination service UUID");
+		rsp = BNEP_CONN_INVALID_DST;
+		goto reply;
+	}
 
 	err = bnep_connadd(sk, dst, iface);
-	if (err < 0)
-		return err;
+	if (err < 0) {
+		rsp = BNEP_CONN_NOT_ALLOWED;
+		goto reply;
+	}
 
 	err = bnep_add_to_bridge(iface, bridge);
 	if (err < 0) {
 		bnep_conndel(addr);
-		return err;
+		rsp = BNEP_CONN_NOT_ALLOWED;
+		goto reply;
 	}
 
-	return bnep_if_up(iface);
+	err = bnep_if_up(iface);
+	if (err < 0)
+		rsp = BNEP_CONN_NOT_ALLOWED;
+
+reply:
+	bnep_send_ctrl_rsp(sk, BNEP_CONTROL, BNEP_SETUP_CONN_RSP, rsp);
+
+	return err;
 }
 
 void bnep_server_delete(char *bridge, char *iface, const bdaddr_t *addr)
@@ -646,14 +671,3 @@ void bnep_server_delete(char *bridge, char *iface, const bdaddr_t *addr)
 	bnep_if_down(iface);
 	bnep_conndel(addr);
 }
-
-ssize_t bnep_send_ctrl_rsp(int sk, uint8_t type, uint8_t ctrl, uint16_t resp)
-{
-	struct bnep_control_rsp rsp;
-
-	rsp.type = type;
-	rsp.ctrl = ctrl;
-	rsp.resp = htons(resp);
-
-	return send(sk, &rsp, sizeof(rsp), 0);
-}
diff --git a/profiles/network/bnep.h b/profiles/network/bnep.h
index 2686ea8..633baeb 100644
--- a/profiles/network/bnep.h
+++ b/profiles/network/bnep.h
@@ -43,5 +43,3 @@ void bnep_disconnect(struct bnep *session);
 int bnep_server_add(int sk, char *bridge, char *iface, const bdaddr_t *addr,
 						uint8_t *setup_data, int len);
 void bnep_server_delete(char *bridge, char *iface, const bdaddr_t *addr);
-
-ssize_t bnep_send_ctrl_rsp(int sk, uint8_t type, uint8_t ctrl, uint16_t resp);
diff --git a/profiles/network/server.c b/profiles/network/server.c
index 4644133..9caabb0 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -288,9 +288,10 @@ static gboolean bnep_setup(GIOChannel *chan,
 	struct network_server *ns;
 	uint8_t packet[BNEP_MTU];
 	struct bnep_setup_conn_req *req = (void *) packet;
-	uint16_t dst_role, rsp = BNEP_CONN_NOT_ALLOWED;
+	uint16_t dst_role = 0;
 	uint32_t val;
 	int n, sk;
+	char *bridge = NULL;
 
 	if (cond & G_IO_NVAL)
 		return FALSE;
@@ -325,51 +326,36 @@ static gboolean bnep_setup(GIOChannel *chan,
 		break;
 	case 16:
 		if (memcmp(&req->service[4], bt_base, sizeof(bt_base)) != 0)
-			return FALSE;
+			break;
 
 		/* Intentional no-brake */
 
 	case 4:
 		val = get_be32(req->service);
 		if (val > 0xffff)
-			return FALSE;
+			break;
 
 		dst_role = val;
 		break;
 	default:
-		return FALSE;
+		break;
 	}
 
 	ns = find_server(na->servers, dst_role);
-	if (!ns) {
-		error("Server unavailable: (0x%x)", dst_role);
-		goto reply;
-	}
-
-	if (!ns->record_id) {
-		error("Service record not available");
-		goto reply;
-	}
-
-	if (!ns->bridge) {
-		error("Bridge interface not configured");
-		goto reply;
-	}
+	if (!ns || !ns->record_id || !ns->bridge)
+		error("Server error, bridge not initialized: (0x%x)", dst_role);
+	else
+		bridge = ns->bridge;
 
 	strncpy(na->setup->dev, BNEP_INTERFACE, 16);
 	na->setup->dev[15] = '\0';
 
-	if (bnep_server_add(sk, ns->bridge, na->setup->dev,
-						&na->setup->dst, packet, n) < 0)
-		goto reply;
+	if (bnep_server_add(sk, bridge, na->setup->dev, &na->setup->dst,
+							packet, n) < 0)
+		error("BNEP server cannot be added");
 
 	na->setup = NULL;
 
-	rsp = BNEP_SUCCESS;
-
-reply:
-	bnep_send_ctrl_rsp(sk, BNEP_CONTROL, BNEP_SETUP_CONN_RSP, rsp);
-
 	return FALSE;
 }
 
-- 
2.1.0

