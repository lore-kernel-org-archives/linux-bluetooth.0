Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/6] profiles/network: Move bnep connection setup logic to bnep
Date: Thu, 19 Feb 2015 15:16:38 +0100
Message-Id: <1424355399-10015-5-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1424355399-10015-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1424355399-10015-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

BNEP connection set up logic which was added before bnep_server_add,
can be private method of bnep. Moved logic was almost doubled in two
cases: NAP role in PAN, server listening. Now set up and connect
scenario check of bnep connection is only handled in bnep part for
listen connections.
---
 android/pan.c             |  28 ++---------
 profiles/network/bnep.c   | 123 ++++++++++++++++++++++++++++------------------
 profiles/network/bnep.h   |   6 +--
 profiles/network/server.c |  43 +++++++++-------
 4 files changed, 103 insertions(+), 97 deletions(-)

diff --git a/android/pan.c b/android/pan.c
index 0bf5f71..8bafcd0 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -463,8 +463,7 @@ static gboolean nap_setup_cb(GIOChannel *chan, GIOCondition cond,
 {
 	struct pan_device *dev = user_data;
 	uint8_t packet[BNEP_MTU];
-	struct bnep_setup_conn_req *req = (void *) packet;
-	uint16_t src_role, dst_role, rsp = BNEP_CONN_NOT_ALLOWED;
+	uint16_t rsp = BNEP_CONN_NOT_ALLOWED;
 	int sk, n, err;
 
 	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL)) {
@@ -481,27 +480,6 @@ static gboolean nap_setup_cb(GIOChannel *chan, GIOCondition cond,
 		goto failed;
 	}
 
-	/* Highest known control command id BNEP_FILTER_MULT_ADDR_RSP 0x06 */
-	if (req->type == BNEP_CONTROL &&
-					req->ctrl > BNEP_FILTER_MULT_ADDR_RSP) {
-		error("cmd not understood");
-		bnep_send_ctrl_rsp(sk, BNEP_CONTROL, BNEP_CMD_NOT_UNDERSTOOD,
-								req->ctrl);
-		goto failed;
-	}
-
-	if (req->type != BNEP_CONTROL || req->ctrl != BNEP_SETUP_CONN_REQ) {
-		error("cmd is not BNEP_SETUP_CONN_REQ %02X %02X", req->type,
-								req->ctrl);
-		goto failed;
-	}
-
-	rsp = bnep_setup_decode(req, &dst_role, &src_role);
-	if (rsp != BNEP_SUCCESS) {
-		error("bnep_setup_decode failed");
-		goto failed;
-	}
-
 	err = nap_create_bridge();
 	if (err < 0) {
 		error("pan: Failed to create bridge: %s (%d)", strerror(-err),
@@ -509,8 +487,8 @@ static gboolean nap_setup_cb(GIOChannel *chan, GIOCondition cond,
 		goto failed;
 	}
 
-	if (bnep_server_add(sk, dst_role, BNEP_BRIDGE, dev->iface,
-							&dev->dst) < 0) {
+	if (bnep_server_add(sk, BNEP_BRIDGE, dev->iface, &dev->dst,
+							(void *) packet) < 0) {
 		nap_remove_bridge();
 		error("server_connadd failed");
 		rsp = BNEP_CONN_NOT_ALLOWED;
diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index 919d995..1b6ebbc 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -549,63 +549,25 @@ static int bnep_del_from_bridge(const char *devname, const char *bridge)
 	return err;
 }
 
-int bnep_server_add(int sk, uint16_t dst, char *bridge, char *iface,
-						const bdaddr_t *addr)
-{
-	int err;
-
-	if (!bridge || !iface || !addr)
-		return -EINVAL;
-
-	err = bnep_connadd(sk, dst, iface);
-	if (err < 0)
-		return err;
-
-	err = bnep_add_to_bridge(iface, bridge);
-	if (err < 0) {
-		bnep_conndel(addr);
-		return err;
-	}
-
-	return bnep_if_up(iface);
-}
-
-void bnep_server_delete(char *bridge, char *iface, const bdaddr_t *addr)
-{
-	if (!bridge || !iface || !addr)
-		return;
-
-	bnep_del_from_bridge(iface, bridge);
-	bnep_if_down(iface);
-	bnep_conndel(addr);
-}
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
-
-uint16_t bnep_setup_decode(struct bnep_setup_conn_req *req, uint16_t *dst,
-								uint16_t *src)
+static uint16_t bnep_setup_decode(int sk, struct bnep_setup_conn_req *req,
+								uint16_t *dst)
 {
 	const uint8_t bt_base[] = { 0x00, 0x00, 0x10, 0x00, 0x80, 0x00,
 					0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB };
+	uint16_t src;
 	uint8_t *dest, *source;
 	uint32_t val;
 
+	if (req->type != BNEP_CONTROL || req->ctrl != BNEP_SETUP_CONN_REQ)
+		return BNEP_CONN_NOT_ALLOWED;
+
 	dest = req->service;
 	source = req->service + req->uuid_size;
 
 	switch (req->uuid_size) {
 	case 2: /* UUID16 */
 		*dst = get_be16(dest);
-		*src = get_be16(source);
+		src = get_be16(source);
 		break;
 	case 16: /* UUID128 */
 		/* Check that the bytes in the UUID, except the service ID
@@ -629,7 +591,7 @@ uint16_t bnep_setup_decode(struct bnep_setup_conn_req *req, uint16_t *dst,
 		if (val > 0xffff)
 			return BNEP_CONN_INVALID_SRC;
 
-		*src = val;
+		src = val;
 		break;
 	default:
 		return BNEP_CONN_INVALID_SVC;
@@ -639,12 +601,13 @@ uint16_t bnep_setup_decode(struct bnep_setup_conn_req *req, uint16_t *dst,
 	switch (*dst) {
 	case BNEP_SVC_NAP:
 	case BNEP_SVC_GN:
-		if (*src == BNEP_SVC_PANU)
+		if (src == BNEP_SVC_PANU)
 			return BNEP_SUCCESS;
+
 		return BNEP_CONN_INVALID_SRC;
 	case BNEP_SVC_PANU:
-		if (*src == BNEP_SVC_PANU || *src == BNEP_SVC_GN ||
-							*src == BNEP_SVC_NAP)
+		if (src == BNEP_SVC_PANU || src == BNEP_SVC_GN ||
+							src == BNEP_SVC_NAP)
 			return BNEP_SUCCESS;
 
 		return BNEP_CONN_INVALID_SRC;
@@ -652,3 +615,65 @@ uint16_t bnep_setup_decode(struct bnep_setup_conn_req *req, uint16_t *dst,
 
 	return BNEP_CONN_INVALID_DST;
 }
+
+int bnep_server_add(int sk, char *bridge, char *iface, const bdaddr_t *addr,
+							void *setup_data)
+{
+	int err;
+	uint16_t dst = NULL;
+	struct bnep_setup_conn_req *req = setup_data;
+
+	/* Highest known Control command ID
+	 * is BNEP_FILTER_MULT_ADDR_RSP = 0x06 */
+	if (req->type == BNEP_CONTROL &&
+					req->ctrl > BNEP_FILTER_MULT_ADDR_RSP) {
+		error("cmd not understood");
+		bnep_send_ctrl_rsp(sk, BNEP_CONTROL, BNEP_CMD_NOT_UNDERSTOOD,
+								req->ctrl);
+
+		return -EINVAL;
+	}
+
+	/* Processing BNEP_SETUP_CONNECTION_REQUEST_MSG */
+	err = bnep_setup_decode(sk, setup_data, &dst);
+	if (err < 0) {
+		error("error while decoding setup connection request: %d", err);
+		return -EINVAL;
+	}
+
+	if (!bridge || !iface || !addr || !dst)
+		return -EINVAL;
+
+	err = bnep_connadd(sk, dst, iface);
+	if (err < 0)
+		return err;
+
+	err = bnep_add_to_bridge(iface, bridge);
+	if (err < 0) {
+		bnep_conndel(addr);
+		return err;
+	}
+
+	return bnep_if_up(iface);
+}
+
+void bnep_server_delete(char *bridge, char *iface, const bdaddr_t *addr)
+{
+	if (!bridge || !iface || !addr)
+		return;
+
+	bnep_del_from_bridge(iface, bridge);
+	bnep_if_down(iface);
+	bnep_conndel(addr);
+}
+
+ssize_t bnep_send_ctrl_rsp(int sk, uint8_t type, uint8_t ctrl, uint16_t resp)
+{
+	struct bnep_control_rsp rsp;
+
+	rsp.type = type;
+	rsp.ctrl = ctrl;
+	rsp.resp = htons(resp);
+
+	return send(sk, &rsp, sizeof(rsp), 0);
+}
diff --git a/profiles/network/bnep.h b/profiles/network/bnep.h
index 5aedf38..7a3efb6 100644
--- a/profiles/network/bnep.h
+++ b/profiles/network/bnep.h
@@ -41,10 +41,8 @@ void bnep_set_disconnect(struct bnep *session, bnep_disconnect_cb disconn_cb,
 								void *data);
 void bnep_disconnect(struct bnep *session);
 
-int bnep_server_add(int sk, uint16_t dst, char *bridge, char *iface,
-							const bdaddr_t *addr);
+int bnep_server_add(int sk, char *bridge, char *iface, const bdaddr_t *addr,
+							void *setup_data);
 void bnep_server_delete(char *bridge, char *iface, const bdaddr_t *addr);
 
 ssize_t bnep_send_ctrl_rsp(int sk, uint8_t type, uint8_t ctrl, uint16_t resp);
-uint16_t bnep_setup_decode(struct bnep_setup_conn_req *req, uint16_t *dst,
-								uint16_t *src);
diff --git a/profiles/network/server.c b/profiles/network/server.c
index 2091fdd..061fedf 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -46,6 +46,7 @@
 #include "src/log.h"
 #include "src/error.h"
 #include "src/sdpd.h"
+#include "src/shared/util.h"
 
 #include "bnep.h"
 #include "server.h"
@@ -280,11 +281,14 @@ static void setup_destroy(void *user_data)
 static gboolean bnep_setup(GIOChannel *chan,
 			GIOCondition cond, gpointer user_data)
 {
+	const uint8_t bt_base[] = { 0x00, 0x00, 0x10, 0x00, 0x80, 0x00,
+					0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB };
 	struct network_adapter *na = user_data;
 	struct network_server *ns;
 	uint8_t packet[BNEP_MTU];
 	struct bnep_setup_conn_req *req = (void *) packet;
-	uint16_t src_role, dst_role, rsp = BNEP_CONN_NOT_ALLOWED;
+	uint16_t dst_role, rsp = BNEP_CONN_NOT_ALLOWED;
+	uint32_t val;
 	int n, sk;
 
 	if (cond & G_IO_NVAL)
@@ -304,25 +308,26 @@ static gboolean bnep_setup(GIOChannel *chan,
 		return FALSE;
 	}
 
-	/* Highest known Control command ID
-	 * is BNEP_FILTER_MULT_ADDR_RSP = 0x06 */
-	if (req->type == BNEP_CONTROL &&
-					req->ctrl > BNEP_FILTER_MULT_ADDR_RSP) {
-		error("cmd not understood");
-		bnep_send_ctrl_rsp(sk, BNEP_CONTROL, BNEP_CMD_NOT_UNDERSTOOD,
-								req->ctrl);
-
-		return FALSE;
-	}
+	switch (req->uuid_size) {
+	case 2:
+		dst_role = get_be16(req->service);
+		break;
+	case 16:
+		if (memcmp(&req->service[4], bt_base, sizeof(bt_base)) != 0)
+			return FALSE;
 
-	if (req->type != BNEP_CONTROL || req->ctrl != BNEP_SETUP_CONN_REQ)
-		return FALSE;
+		/* Intentional no-brake */
 
-	rsp = bnep_setup_decode(req, &dst_role, &src_role);
-	if (rsp != BNEP_SUCCESS)
-		goto reply;
+	case 4:
+		val = get_be32(req->service);
+		if (val > 0xffff)
+			return FALSE;
 
-	rsp = BNEP_CONN_NOT_ALLOWED;
+		dst_role = val;
+		break;
+	default:
+		return FALSE;
+	}
 
 	ns = find_server(na->servers, dst_role);
 	if (!ns) {
@@ -343,8 +348,8 @@ static gboolean bnep_setup(GIOChannel *chan,
 	strncpy(na->setup->dev, BNEP_INTERFACE, 16);
 	na->setup->dev[15] = '\0';
 
-	if (bnep_server_add(sk, dst_role, ns->bridge, na->setup->dev,
-							&na->setup->dst) < 0)
+	if (bnep_server_add(sk, ns->bridge, na->setup->dev,
+					&na->setup->dst, (void *) packet) < 0)
 		goto reply;
 
 	na->setup = NULL;
-- 
1.9.3

