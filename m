Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 03/12] profiles/network: Integrate get and check bnep setup services roles
Date: Thu, 26 Feb 2015 12:53:25 +0100
Message-Id: <1424951614-8527-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1424951614-8527-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1424951614-8527-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

While bnep setup, roles must be determined and checked if the connection
scanario is possible. Get and check possible service roles routines are
always performed in serie. So there is no need to split it to separate
calls.
---
 android/pan.c             |  8 +-------
 profiles/network/bnep.c   | 37 ++++++++++++++++---------------------
 profiles/network/bnep.h   |  1 -
 profiles/network/server.c |  6 +-----
 4 files changed, 18 insertions(+), 34 deletions(-)

diff --git a/android/pan.c b/android/pan.c
index 972af89..0bf5f71 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -497,17 +497,11 @@ static gboolean nap_setup_cb(GIOChannel *chan, GIOCondition cond,
 	}
 
 	rsp = bnep_setup_decode(req, &dst_role, &src_role);
-	if (rsp) {
+	if (rsp != BNEP_SUCCESS) {
 		error("bnep_setup_decode failed");
 		goto failed;
 	}
 
-	rsp = bnep_setup_chk(dst_role, src_role);
-	if (rsp) {
-		error("benp_setup_chk failed");
-		goto failed;
-	}
-
 	err = nap_create_bridge();
 	if (err < 0) {
 		error("pan: Failed to create bridge: %s (%d)", strerror(-err),
diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index e3a2b89..fe13a5b 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -591,26 +591,6 @@ ssize_t bnep_send_ctrl_rsp(int sk, uint8_t type, uint8_t ctrl, uint16_t resp)
 	return send(sk, &rsp, sizeof(rsp), 0);
 }
 
-uint16_t bnep_setup_chk(uint16_t dst, uint16_t src)
-{
-	/* Allowed PAN Profile scenarios */
-	switch (dst) {
-	case BNEP_SVC_NAP:
-	case BNEP_SVC_GN:
-		if (src == BNEP_SVC_PANU)
-			return 0;
-		return BNEP_CONN_INVALID_SRC;
-	case BNEP_SVC_PANU:
-		if (src == BNEP_SVC_PANU ||  src == BNEP_SVC_GN ||
-							src == BNEP_SVC_NAP)
-			return 0;
-
-		return BNEP_CONN_INVALID_SRC;
-	}
-
-	return BNEP_CONN_INVALID_DST;
-}
-
 uint16_t bnep_setup_decode(struct bnep_setup_conn_req *req, uint16_t *dst,
 								uint16_t *src)
 {
@@ -655,5 +635,20 @@ uint16_t bnep_setup_decode(struct bnep_setup_conn_req *req, uint16_t *dst,
 		return BNEP_CONN_INVALID_SVC;
 	}
 
-	return BNEP_SUCCESS;
+	/* Allowed PAN Profile scenarios */
+	switch (*dst) {
+	case BNEP_SVC_NAP:
+	case BNEP_SVC_GN:
+		if (*src == BNEP_SVC_PANU)
+			return BNEP_SUCCESS;
+		return BNEP_CONN_INVALID_SRC;
+	case BNEP_SVC_PANU:
+		if (*src == BNEP_SVC_PANU || *src == BNEP_SVC_GN ||
+							*src == BNEP_SVC_NAP)
+			return BNEP_SUCCESS;
+
+		return BNEP_CONN_INVALID_SRC;
+	}
+
+	return BNEP_CONN_INVALID_DST;
 }
diff --git a/profiles/network/bnep.h b/profiles/network/bnep.h
index bc43d4f..5aedf38 100644
--- a/profiles/network/bnep.h
+++ b/profiles/network/bnep.h
@@ -46,6 +46,5 @@ int bnep_server_add(int sk, uint16_t dst, char *bridge, char *iface,
 void bnep_server_delete(char *bridge, char *iface, const bdaddr_t *addr);
 
 ssize_t bnep_send_ctrl_rsp(int sk, uint8_t type, uint8_t ctrl, uint16_t resp);
-uint16_t bnep_setup_chk(uint16_t dst_role, uint16_t src_role);
 uint16_t bnep_setup_decode(struct bnep_setup_conn_req *req, uint16_t *dst,
 								uint16_t *src);
diff --git a/profiles/network/server.c b/profiles/network/server.c
index 2b252d9..12266c9 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -323,11 +323,7 @@ static gboolean bnep_setup(GIOChannel *chan,
 		return FALSE;
 
 	rsp = bnep_setup_decode(req, &dst_role, &src_role);
-	if (rsp)
-		goto reply;
-
-	rsp = bnep_setup_chk(dst_role, src_role);
-	if (rsp)
+	if (rsp != BNEP_SUCCESS)
 		goto reply;
 
 	rsp = BNEP_CONN_NOT_ALLOWED;
-- 
2.1.0

