Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 03/10] bnep: Move bnep related calls to bnep.h|c
Date: Wed, 11 Dec 2013 12:13:38 +0200
Message-Id: <1386756825-934-4-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1386756825-934-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1386756825-934-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Moving bnep related calls to bnep.h|c to reduce redundancy
while using same in android/*.
---
 profiles/network/bnep.c   | 67 +++++++++++++++++++++++++++++++++++++++++++++++
 profiles/network/bnep.h   |  5 +++-
 profiles/network/server.c | 66 ----------------------------------------------
 3 files changed, 71 insertions(+), 67 deletions(-)

diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index 57dfbf9..08037e6 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -475,3 +475,70 @@ ssize_t bnep_send_ctrl_rsp(int sk, uint8_t type, uint8_t ctrl, uint16_t resp)
 
 	return send(sk, &rsp, sizeof(rsp), 0);
 }
+
+uint16_t bnep_setup_chk(uint16_t dst, uint16_t src)
+{
+	/* Allowed PAN Profile scenarios */
+	switch (dst) {
+	case BNEP_SVC_NAP:
+	case BNEP_SVC_GN:
+		if (src == BNEP_SVC_PANU)
+			return 0;
+		return BNEP_CONN_INVALID_SRC;
+	case BNEP_SVC_PANU:
+		if (src == BNEP_SVC_PANU ||  src == BNEP_SVC_GN ||
+							src == BNEP_SVC_NAP)
+			return 0;
+
+		return BNEP_CONN_INVALID_SRC;
+	}
+
+	return BNEP_CONN_INVALID_DST;
+}
+
+uint16_t bnep_setup_decode(struct bnep_setup_conn_req *req, uint16_t *dst,
+								uint16_t *src)
+{
+	const uint8_t bt_base[] = { 0x00, 0x00, 0x10, 0x00, 0x80, 0x00,
+					0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB };
+	uint8_t *dest, *source;
+	uint32_t val;
+
+	dest = req->service;
+	source = req->service + req->uuid_size;
+
+	switch (req->uuid_size) {
+	case 2: /* UUID16 */
+		*dst = bt_get_be16(dest);
+		*src = bt_get_be16(source);
+		break;
+	case 16: /* UUID128 */
+		/* Check that the bytes in the UUID, except the service ID
+		 * itself, are correct. The service ID is checked in
+		 * bnep_setup_chk(). */
+		if (memcmp(&dest[4], bt_base, sizeof(bt_base)) != 0)
+			return BNEP_CONN_INVALID_DST;
+		if (memcmp(&source[4], bt_base, sizeof(bt_base)) != 0)
+			return BNEP_CONN_INVALID_SRC;
+
+		/* Intentional no-break */
+
+	case 4: /* UUID32 */
+		val = bt_get_be32(dest);
+		if (val > 0xffff)
+			return BNEP_CONN_INVALID_DST;
+
+		*dst = val;
+
+		val = bt_get_be32(source);
+		if (val > 0xffff)
+			return BNEP_CONN_INVALID_SRC;
+
+		*src = val;
+		break;
+	default:
+		return BNEP_CONN_INVALID_SVC;
+	}
+
+	return BNEP_SUCCESS;
+}
diff --git a/profiles/network/bnep.h b/profiles/network/bnep.h
index dea0319..dd22c40 100644
--- a/profiles/network/bnep.h
+++ b/profiles/network/bnep.h
@@ -40,4 +40,7 @@ typedef void (*bnep_connect_cb) (GIOChannel *chan, char *iface, int err,
 int bnep_connect(int sk, uint16_t src, uint16_t dst, bnep_connect_cb conn_cb,
 								void *data);
 
-ssize_t bnep_send_ctrl_rsp(int sk, uint8_t type, uint8_t ctrl, uint16_t resp);
\ No newline at end of file
+ssize_t bnep_send_ctrl_rsp(int sk, uint8_t type, uint8_t ctrl, uint16_t resp);
+uint16_t bnep_setup_chk(uint16_t dst_role, uint16_t src_role);
+uint16_t bnep_setup_decode(struct bnep_setup_conn_req *req, uint16_t *dst,
+								uint16_t *src);
diff --git a/profiles/network/server.c b/profiles/network/server.c
index 296ddd8..cf34932 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -280,72 +280,6 @@ static int server_connadd(struct network_server *ns,
 	return 0;
 }
 
-static uint16_t bnep_setup_chk(uint16_t dst_role, uint16_t src_role)
-{
-	/* Allowed PAN Profile scenarios */
-	switch (dst_role) {
-	case BNEP_SVC_NAP:
-	case BNEP_SVC_GN:
-		if (src_role == BNEP_SVC_PANU)
-			return 0;
-		return BNEP_CONN_INVALID_SRC;
-	case BNEP_SVC_PANU:
-		if (src_role == BNEP_SVC_PANU ||
-				src_role == BNEP_SVC_GN ||
-				src_role == BNEP_SVC_NAP)
-			return 0;
-
-		return BNEP_CONN_INVALID_SRC;
-	}
-
-	return BNEP_CONN_INVALID_DST;
-}
-
-static uint16_t bnep_setup_decode(struct bnep_setup_conn_req *req,
-				uint16_t *dst_role, uint16_t *src_role)
-{
-	const uint8_t bt_base[] = { 0x00, 0x00, 0x10, 0x00, 0x80, 0x00,
-				0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB };
-	uint8_t *dest, *source;
-	uint32_t val;
-
-	dest = req->service;
-	source = req->service + req->uuid_size;
-
-	switch (req->uuid_size) {
-	case 2: /* UUID16 */
-		*dst_role = bt_get_be16(dest);
-		*src_role = bt_get_be16(source);
-		break;
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
-	case 4: /* UUID32 */
-		val = bt_get_be32(dest);
-		if (val > 0xffff)
-			return BNEP_CONN_INVALID_DST;
-		*dst_role = val;
-
-		val = bt_get_be32(source);
-		if (val > 0xffff)
-			return BNEP_CONN_INVALID_SRC;
-		*src_role = val;
-		break;
-	default:
-		return BNEP_CONN_INVALID_SVC;
-	}
-
-	return BNEP_SUCCESS;
-}
-
 static void session_free(void *data)
 {
 	struct network_session *session = data;
-- 
1.8.3.2

