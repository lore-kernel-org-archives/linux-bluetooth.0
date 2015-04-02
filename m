Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/5] profiles/network: Use lib/uuid instead of operating on raw bnep msg
Date: Thu,  2 Apr 2015 13:15:25 +0200
Message-Id: <1427973328-22329-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1427973328-22329-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1427973328-22329-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch moves operation on uuids in setup to lib/uuid which handles
whole operations.
---
 profiles/network/bnep.c | 85 +++++++++++++++++++++++--------------------------
 1 file changed, 39 insertions(+), 46 deletions(-)

diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index ab72021..5b031a1 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -114,16 +114,19 @@ static int bnep_conndel(const bdaddr_t *dst)
 	return 0;
 }
 
-static int bnep_connadd(int sk, uint16_t role, char *dev)
+static int bnep_connadd(int sk, bt_uuid_t *local_role, char *dev)
 {
 	struct bnep_connadd_req req;
+	bt_uuid_t uuid;
 
 	memset(&req, 0, sizeof(req));
 	strncpy(req.device, dev, 16);
 	req.device[15] = '\0';
 
+	bt_uuid_to_uuid16(local_role, &uuid);
+
 	req.sock = sk;
-	req.role = role;
+	req.role = uuid.value.u16;
 	if (ioctl(ctl, BNEPCONNADD, &req) < 0) {
 		int err = -errno;
 		error("bnep: Failed to add device %s: %s(%d)",
@@ -203,6 +206,7 @@ static gboolean bnep_setup_cb(GIOChannel *chan, GIOCondition cond,
 	char pkt[BNEP_MTU];
 	ssize_t r;
 	int sk;
+	bt_uuid_t local_role;
 
 	if (cond & G_IO_NVAL)
 		return FALSE;
@@ -257,7 +261,7 @@ static gboolean bnep_setup_cb(GIOChannel *chan, GIOCondition cond,
 	setsockopt(sk, SOL_SOCKET, SO_RCVTIMEO, &timeo, sizeof(timeo));
 
 	sk = g_io_channel_unix_get_fd(session->io);
-	if (bnep_connadd(sk, session->src, session->iface) < 0)
+	if (bnep_connadd(sk, &local_role, session->iface) < 0)
 		goto failed;
 
 	if (bnep_if_up(session->iface) < 0) {
@@ -522,13 +526,10 @@ static ssize_t bnep_send_ctrl_rsp(int sk, uint8_t ctrl, uint16_t resp)
 }
 
 static uint16_t bnep_setup_decode(int sk, struct bnep_setup_conn_req *req,
-								uint16_t *dst)
+								bt_uuid_t *dst)
 {
-	const uint8_t bt_base[] = { 0x00, 0x00, 0x10, 0x00, 0x80, 0x00,
-					0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB };
-	uint16_t src;
+	bt_uuid_t src, nap_uuid, gn_uuid, panu_uuid;
 	uint8_t *dest, *source;
-	uint32_t val;
 
 	if (req->type != BNEP_CONTROL || req->ctrl != BNEP_SETUP_CONN_REQ)
 		return BNEP_CONN_NOT_ALLOWED;
@@ -538,60 +539,52 @@ static uint16_t bnep_setup_decode(int sk, struct bnep_setup_conn_req *req,
 
 	switch (req->uuid_size) {
 	case 2: /* UUID16 */
-		*dst = get_be16(dest);
-		src = get_be16(source);
+		bt_uuid16_create(dst, get_be16(dest));
+		bt_uuid16_create(&src, get_be16(source));
 		break;
-	case 16: /* UUID128 */
-		/* Check that the bytes in the UUID, except the service ID
-		 * itself, are correct. The service ID is checked in
-		 * bnep_setup_chk(). */
-		if (memcmp(&dest[4], bt_base, sizeof(bt_base)) != 0)
-			return BNEP_CONN_INVALID_DST;
-		if (memcmp(&source[4], bt_base, sizeof(bt_base)) != 0)
-			return BNEP_CONN_INVALID_SRC;
-
-		/* Intentional no-break */
-
 	case 4: /* UUID32 */
-		val = get_be32(dest);
-		if (val > 0xffff)
-			return BNEP_CONN_INVALID_DST;
-
-		*dst = val;
-
-		val = get_be32(source);
-		if (val > 0xffff)
-			return BNEP_CONN_INVALID_SRC;
+		bt_uuid32_create(dst, get_be32(dest));
+		bt_uuid32_create(&src, get_be32(source));
+		break;
+	case 16: {/* UUID128 */
+		uint128_t tmp_src_uuid, tmp_dst_uuid;
 
-		src = val;
+		memcpy(tmp_dst_uuid.data, dest, sizeof(tmp_dst_uuid));
+		memcpy(tmp_src_uuid.data, dest, sizeof(tmp_src_uuid));
 		break;
+		}
 	default:
 		return BNEP_CONN_INVALID_SVC;
 	}
 
+	bt_uuid16_create(&nap_uuid, BNEP_SVC_NAP);
+	bt_uuid16_create(&gn_uuid, BNEP_SVC_GN);
+	bt_uuid16_create(&panu_uuid, BNEP_SVC_PANU);
+
 	/* Allowed PAN Profile scenarios */
-	switch (*dst) {
-	case BNEP_SVC_NAP:
-	case BNEP_SVC_GN:
-		if (src == BNEP_SVC_PANU)
+	if ((!bt_uuid_cmp(dst, &nap_uuid) || !bt_uuid_cmp(dst, &gn_uuid))) {
+		if (!bt_uuid_cmp(&src, &panu_uuid))
 			return BNEP_SUCCESS;
-		return BNEP_CONN_INVALID_SRC;
-	case BNEP_SVC_PANU:
-		if (src == BNEP_SVC_PANU || src == BNEP_SVC_GN ||
-							src == BNEP_SVC_NAP)
+		else
+			return BNEP_CONN_INVALID_SRC;
+	} else if (!bt_uuid_cmp(dst, &panu_uuid)) {
+		if (!bt_uuid_cmp(&src, &panu_uuid) ||
+					!bt_uuid_cmp(&src, &gn_uuid) ||
+					!bt_uuid_cmp(&src, &nap_uuid))
 			return BNEP_SUCCESS;
-
-		return BNEP_CONN_INVALID_SRC;
+		else
+			return BNEP_CONN_INVALID_SRC;
+	} else {
+		return BNEP_CONN_INVALID_DST;
 	}
-
-	return BNEP_CONN_INVALID_DST;
 }
 
 int bnep_server_add(int sk, char *bridge, char *iface, const bdaddr_t *addr,
 						uint8_t *setup_data, int len)
 {
 	int err;
-	uint16_t rsp, dst;
+	uint16_t rsp;
+	bt_uuid_t local_role;
 	struct bnep_setup_conn_req *req = (void *) setup_data;
 
 	/* Highest known Control command ID
@@ -609,7 +602,7 @@ int bnep_server_add(int sk, char *bridge, char *iface, const bdaddr_t *addr,
 	}
 
 	/* Processing BNEP_SETUP_CONNECTION_REQUEST_MSG */
-	rsp = bnep_setup_decode(sk, req, &dst);
+	rsp = bnep_setup_decode(sk, req, &local_role);
 	if (rsp != BNEP_SUCCESS) {
 		err = -rsp;
 		error("bnep: error while decoding setup connection request: %d",
@@ -617,7 +610,7 @@ int bnep_server_add(int sk, char *bridge, char *iface, const bdaddr_t *addr,
 		goto reply;
 	}
 
-	err = bnep_connadd(sk, dst, iface);
+	err = bnep_connadd(sk, &local_role, iface);
 	if (err < 0) {
 		rsp = BNEP_CONN_NOT_ALLOWED;
 		goto reply;
-- 
2.1.0

