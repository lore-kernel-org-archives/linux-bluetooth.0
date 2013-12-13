Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 2/2] bnep: Refactored bnep server apis for bridge addition and deletion
Date: Fri, 13 Dec 2013 14:35:50 +0200
Message-Id: <1386938150-5683-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1386938150-5683-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1386938150-5683-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

To simplify bnep server realted bridge creation and deletion calls
provided extra apis and moved related apis to static.
---
 profiles/network/bnep.c   | 99 +++++++++++++++++++++++++++++++++++++++++------
 profiles/network/bnep.h   | 15 +++----
 profiles/network/server.c | 81 ++++++--------------------------------
 3 files changed, 104 insertions(+), 91 deletions(-)

diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index 752e00e..6e1af74 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -151,7 +151,7 @@ int bnep_cleanup(void)
 	return 0;
 }
 
-int bnep_conndel(const bdaddr_t *dst)
+static int bnep_conndel(const bdaddr_t *dst)
 {
 	struct bnep_conndel_req req;
 
@@ -167,7 +167,7 @@ int bnep_conndel(const bdaddr_t *dst)
 	return 0;
 }
 
-int bnep_connadd(int sk, uint16_t role, char *dev)
+static int bnep_connadd(int sk, uint16_t role, char *dev)
 {
 	struct bnep_connadd_req req;
 
@@ -187,7 +187,7 @@ int bnep_connadd(int sk, uint16_t role, char *dev)
 	return 0;
 }
 
-int bnep_if_up(const char *devname)
+static int bnep_if_up(const char *devname)
 {
 	struct ifreq ifr;
 	int sk, err;
@@ -212,7 +212,7 @@ int bnep_if_up(const char *devname)
 	return 0;
 }
 
-int bnep_if_down(const char *devname)
+static int bnep_if_down(const char *devname)
 {
 	struct ifreq ifr;
 	int sk, err;
@@ -464,7 +464,7 @@ void bnep_free(struct bnep_conn *bc)
 	g_free(bc);
 }
 
-int bnep_add_to_bridge(const char *devname, const char *bridge)
+static int bnep_add_to_bridge(const char *devname, const char *bridge)
 {
 	int ifindex;
 	struct ifreq ifr;
@@ -495,7 +495,7 @@ int bnep_add_to_bridge(const char *devname, const char *bridge)
 	return 0;
 }
 
-int bnep_del_from_bridge(const char *devname, const char *bridge)
+static int bnep_del_from_bridge(const char *devname, const char *bridge)
 {
 	int ifindex = if_nametoindex(devname);
 	struct ifreq ifr;
@@ -535,19 +535,19 @@ ssize_t bnep_send_ctrl_rsp(int sk, uint8_t type, uint8_t ctrl, uint16_t resp)
 	return send(sk, &rsp, sizeof(rsp), 0);
 }
 
-uint16_t bnep_setup_chk(uint16_t dst, uint16_t src)
+static uint16_t bnep_setup_chk(uint16_t dst, uint16_t src)
 {
 	/* Allowed PAN Profile scenarios */
 	switch (dst) {
 	case BNEP_SVC_NAP:
 	case BNEP_SVC_GN:
 		if (src == BNEP_SVC_PANU)
-			return 0;
+			return BNEP_SUCCESS;
 		return BNEP_CONN_INVALID_SRC;
 	case BNEP_SVC_PANU:
 		if (src == BNEP_SVC_PANU ||  src == BNEP_SVC_GN ||
 							src == BNEP_SVC_NAP)
-			return 0;
+			return BNEP_SUCCESS;
 
 		return BNEP_CONN_INVALID_SRC;
 	}
@@ -555,8 +555,8 @@ uint16_t bnep_setup_chk(uint16_t dst, uint16_t src)
 	return BNEP_CONN_INVALID_DST;
 }
 
-uint16_t bnep_setup_decode(struct bnep_setup_conn_req *req, uint16_t *dst,
-								uint16_t *src)
+static uint16_t bnep_setup_decode(struct bnep_setup_conn_req *req,
+						uint16_t *dst, uint16_t *src)
 {
 	const uint8_t bt_base[] = { 0x00, 0x00, 0x10, 0x00, 0x80, 0x00,
 					0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB };
@@ -601,3 +601,80 @@ uint16_t bnep_setup_decode(struct bnep_setup_conn_req *req, uint16_t *dst,
 
 	return BNEP_SUCCESS;
 }
+
+int bnep_validate_setup_rsp(int sk, uint16_t *dst)
+{
+	uint8_t packet[BNEP_MTU];
+	struct bnep_setup_conn_req *req = (void *) packet;
+	uint16_t src;
+	uint8_t pkt[3];
+	int n, rsp = BNEP_CONN_NOT_ALLOWED;
+
+	/* Reading BNEP_SETUP_CONNECTION_REQUEST_MSG */
+	n = read(sk, packet, sizeof(packet));
+	if (n < 0) {
+		error("read(): %s(%d)", strerror(errno), errno);
+		return n;
+	}
+
+	/* Highest known Control command ID
+	 * is BNEP_FILTER_MULT_ADDR_RSP = 0x06 */
+	if (req->type == BNEP_CONTROL &&
+				req->ctrl > BNEP_FILTER_MULT_ADDR_RSP) {
+		pkt[0] = BNEP_CONTROL;
+		pkt[1] = BNEP_CMD_NOT_UNDERSTOOD;
+		pkt[2] = req->ctrl;
+
+		send(sk, pkt, sizeof(pkt), 0);
+		return -EINVAL;
+	}
+
+	if (req->type != BNEP_CONTROL || req->ctrl != BNEP_SETUP_CONN_REQ)
+		return -EINVAL;
+
+	rsp = bnep_setup_decode(req, dst, &src);
+	if (rsp)
+		return rsp;
+
+	rsp = bnep_setup_chk(*dst, src);
+
+	return rsp;
+}
+
+int bnep_server_add(int sk, uint16_t dst, char *bridge, char *iface,
+						const bdaddr_t *addr)
+{
+	if (!bridge || !bridge || !iface || !addr)
+		return -EINVAL;
+
+	if (bnep_connadd(sk, dst, iface) < 0) {
+		error("Can't add connection to the bridge %s: %s(%d)",
+						bridge, strerror(errno), errno);
+		return -errno;
+	}
+
+	if (bnep_add_to_bridge(iface, bridge) < 0) {
+		error("Can't add %s to the bridge %s: %s(%d)",
+					iface, bridge, strerror(errno), errno);
+		bnep_conndel(addr);
+		return -errno;
+	}
+
+	if (bnep_if_up(iface) < 0) {
+		error("Can't up the interface %s: %s(%d)",
+						iface, strerror(errno), errno);
+		return -errno;
+	}
+
+	return 0;
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
diff --git a/profiles/network/bnep.h b/profiles/network/bnep.h
index fcb35f7..36cfee0 100644
--- a/profiles/network/bnep.h
+++ b/profiles/network/bnep.h
@@ -30,13 +30,6 @@ uint16_t bnep_service_id(const char *svc);
 const char *bnep_uuid(uint16_t id);
 const char *bnep_name(uint16_t id);
 
-int bnep_connadd(int sk, uint16_t role, char *dev);
-int bnep_conndel(const bdaddr_t *dst);
-int bnep_if_up(const char *devname);
-int bnep_if_down(const char *devname);
-int bnep_add_to_bridge(const char *devname, const char *bridge);
-int bnep_del_from_bridge(const char *devname, const char *bridge);
-
 struct bnep_conn *bnep_new(uint16_t src, uint16_t dst,
 						const bdaddr_t *dst_addr);
 void bnep_free(struct bnep_conn *bnep);
@@ -46,7 +39,9 @@ int bnep_connect(struct bnep_conn *bnep, int sk, bnep_connect_cb conn_cb,
 				bnep_disconnect_cb disconn_cb, void *data);
 void bnep_disconnect(struct bnep_conn *bnep);
 
+int bnep_server_add(int sk, uint16_t dst, char *bridge, char *iface,
+							const bdaddr_t *addr);
+void bnep_server_delete(char *bridge, char *iface, const bdaddr_t *addr);
+
+int bnep_validate_setup_rsp(int sk, uint16_t *dst);
 ssize_t bnep_send_ctrl_rsp(int sk, uint8_t type, uint8_t ctrl, uint16_t resp);
-uint16_t bnep_setup_chk(uint16_t dst_role, uint16_t src_role);
-uint16_t bnep_setup_decode(struct bnep_setup_conn_req *req, uint16_t *dst,
-								uint16_t *src);
diff --git a/profiles/network/server.c b/profiles/network/server.c
index 73741ec..432b6d5 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -251,35 +251,6 @@ static sdp_record_t *server_record_new(const char *name, uint16_t id)
 	return record;
 }
 
-static int server_connadd(struct network_server *ns,
-				struct network_session *session,
-				uint16_t dst_role)
-{
-	char devname[16];
-	int err, nsk;
-
-	nsk = g_io_channel_unix_get_fd(session->io);
-	err = bnep_connadd(nsk, dst_role, devname);
-	if (err < 0)
-		return err;
-
-	info("Added new connection: %s", devname);
-
-	if (bnep_add_to_bridge(devname, ns->bridge) < 0) {
-		error("Can't add %s to the bridge %s: %s(%d)",
-				devname, ns->bridge, strerror(errno), errno);
-		return -EPERM;
-	}
-
-	bnep_if_up(devname);
-
-	strncpy(session->dev, devname, sizeof(devname));
-
-	ns->sessions = g_slist_append(ns->sessions, session);
-
-	return 0;
-}
-
 static void session_free(void *data)
 {
 	struct network_session *session = data;
@@ -311,10 +282,8 @@ static gboolean bnep_setup(GIOChannel *chan,
 {
 	struct network_adapter *na = user_data;
 	struct network_server *ns;
-	uint8_t packet[BNEP_MTU];
-	struct bnep_setup_conn_req *req = (void *) packet;
-	uint16_t src_role, dst_role, rsp = BNEP_CONN_NOT_ALLOWED;
-	int n, sk;
+	uint16_t dst;
+	int sk, rsp = BNEP_CONN_NOT_ALLOWED;
 
 	if (cond & G_IO_NVAL)
 		return FALSE;
@@ -325,45 +294,18 @@ static gboolean bnep_setup(GIOChannel *chan,
 	}
 
 	sk = g_io_channel_unix_get_fd(chan);
-
-	/* Reading BNEP_SETUP_CONNECTION_REQUEST_MSG */
-	n = read(sk, packet, sizeof(packet));
-	if (n < 0) {
-		error("read(): %s(%d)", strerror(errno), errno);
-		return FALSE;
-	}
-
-	/* Highest known Control command ID
-	 * is BNEP_FILTER_MULT_ADDR_RSP = 0x06 */
-	if (req->type == BNEP_CONTROL &&
-				req->ctrl > BNEP_FILTER_MULT_ADDR_RSP) {
-		uint8_t pkt[3];
-
-		pkt[0] = BNEP_CONTROL;
-		pkt[1] = BNEP_CMD_NOT_UNDERSTOOD;
-		pkt[2] = req->ctrl;
-
-		send(sk, pkt, sizeof(pkt), 0);
-
-		return FALSE;
-	}
-
-	if (req->type != BNEP_CONTROL || req->ctrl != BNEP_SETUP_CONN_REQ)
+	rsp = bnep_validate_setup_rsp(sk, &dst);
+	if (rsp < 0)
 		return FALSE;
 
-	rsp = bnep_setup_decode(req, &dst_role, &src_role);
-	if (rsp)
-		goto reply;
-
-	rsp = bnep_setup_chk(dst_role, src_role);
-	if (rsp)
+	if (rsp > 0)
 		goto reply;
 
 	rsp = BNEP_CONN_NOT_ALLOWED;
 
-	ns = find_server(na->servers, dst_role);
+	ns = find_server(na->servers, dst);
 	if (!ns) {
-		error("Server unavailable: (0x%x)", dst_role);
+		error("Server unavailable: (0x%x)", dst);
 		goto reply;
 	}
 
@@ -377,9 +319,11 @@ static gboolean bnep_setup(GIOChannel *chan,
 		goto reply;
 	}
 
-	if (server_connadd(ns, na->setup, dst_role) < 0)
+	if (bnep_server_add(sk, dst, ns->bridge, na->setup->dev,
+							&na->setup->dst) < 0)
 		goto reply;
 
+	ns->sessions = g_slist_append(ns->sessions, na->setup);
 	na->setup = NULL;
 
 	rsp = BNEP_SUCCESS;
@@ -524,10 +468,7 @@ static void server_remove_sessions(struct network_server *ns)
 		if (*session->dev == '\0')
 			continue;
 
-		bnep_del_from_bridge(session->dev, ns->bridge);
-		bnep_if_down(session->dev);
-
-		bnep_conndel(&session->dst);
+		bnep_server_delete(ns->bridge, session->dev, &session->dst);
 	}
 
 	g_slist_free_full(ns->sessions, session_free);
-- 
1.8.3.2

