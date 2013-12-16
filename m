Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 6/6] bnep: Refactor bnep setup response validation functionality
Date: Tue, 17 Dec 2013 00:05:16 +0200
Message-Id: <1387231516-4127-6-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1387231516-4127-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1387231516-4127-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Providing single api to validate bnep setup resp and hide
other functions.
---
 profiles/network/bnep.c   | 49 ++++++++++++++++++++++++++++++++++++++++++-----
 profiles/network/bnep.h   |  4 +---
 profiles/network/server.c | 46 +++++++++-----------------------------------
 3 files changed, 54 insertions(+), 45 deletions(-)

diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index 5deac81..6e1af74 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
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
@@ -602,6 +602,45 @@ uint16_t bnep_setup_decode(struct bnep_setup_conn_req *req, uint16_t *dst,
 	return BNEP_SUCCESS;
 }
 
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
 int bnep_server_add(int sk, uint16_t dst, char *bridge, char *iface,
 						const bdaddr_t *addr)
 {
diff --git a/profiles/network/bnep.h b/profiles/network/bnep.h
index 734055d..36cfee0 100644
--- a/profiles/network/bnep.h
+++ b/profiles/network/bnep.h
@@ -43,7 +43,5 @@ int bnep_server_add(int sk, uint16_t dst, char *bridge, char *iface,
 							const bdaddr_t *addr);
 void bnep_server_delete(char *bridge, char *iface, const bdaddr_t *addr);
 
+int bnep_validate_setup_rsp(int sk, uint16_t *dst);
 ssize_t bnep_send_ctrl_rsp(int sk, uint8_t type, uint8_t ctrl, uint16_t resp);
-uint16_t bnep_setup_chk(uint16_t dst_role, uint16_t src_role);
-uint16_t bnep_setup_decode(struct bnep_setup_conn_req *req, uint16_t *dst,
-								uint16_t *src);
diff --git a/profiles/network/server.c b/profiles/network/server.c
index 7cb5a1e..432b6d5 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -282,10 +282,8 @@ static gboolean bnep_setup(GIOChannel *chan,
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
@@ -296,45 +294,18 @@ static gboolean bnep_setup(GIOChannel *chan,
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
 
@@ -348,10 +319,11 @@ static gboolean bnep_setup(GIOChannel *chan,
 		goto reply;
 	}
 
-	if (bnep_server_add(sk, dst_role, ns->bridge, na->setup->dev,
+	if (bnep_server_add(sk, dst, ns->bridge, na->setup->dev,
 							&na->setup->dst) < 0)
 		goto reply;
 
+	ns->sessions = g_slist_append(ns->sessions, na->setup);
 	na->setup = NULL;
 
 	rsp = BNEP_SUCCESS;
-- 
1.8.3.2

