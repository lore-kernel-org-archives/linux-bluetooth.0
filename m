Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC obexd 2/3] gobex: Translate posix error code to proper OBEX response opcode
Date: Fri, 17 Feb 2012 15:11:47 +0200
Message-Id: <1329484308-8417-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1329484308-8417-1-git-send-email-luiz.dentz@gmail.com>
References: <1329484308-8417-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This patch create a map between posix errors code and OBEX response
opcode and use it to generate a proper response in case a transfer
failed instead of always responding with internal error.
---
 gobex/gobex-transfer.c |    6 ++++--
 gobex/gobex.c          |   24 ++++++++++++++++++++++++
 gobex/gobex.h          |    1 +
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
index a779e4f..a02789a 100644
--- a/gobex/gobex-transfer.c
+++ b/gobex/gobex-transfer.c
@@ -501,6 +501,7 @@ static gssize get_get_data(void *buf, gsize len, gpointer user_data)
 	GObexPacket *req, *rsp;
 	GError *err = NULL;
 	gssize ret;
+	guint8 op;
 
 	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", transfer->id);
 
@@ -530,8 +531,9 @@ static gssize get_get_data(void *buf, gsize len, gpointer user_data)
 		return ret;
 	}
 
-	req = g_obex_packet_new(G_OBEX_RSP_INTERNAL_SERVER_ERROR, TRUE,
-							G_OBEX_HDR_INVALID);
+	op = g_obex_errno2rsp(ret);
+
+	req = g_obex_packet_new(op, TRUE, G_OBEX_HDR_INVALID);
 	g_obex_send(transfer->obex, req, NULL);
 
 	err = g_error_new(G_OBEX_ERROR, G_OBEX_ERROR_CANCELLED,
diff --git a/gobex/gobex.c b/gobex/gobex.c
index c1e7dc4..9a505ba 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -1471,3 +1471,27 @@ guint g_obex_move(GObex *obex, const char *name, const char *dest,
 
 	return g_obex_send_req(obex, req, -1, func, user_data, err);
 }
+
+guint8 g_obex_errno2rsp(int err)
+{
+	switch (err) {
+	case 0:
+		return G_OBEX_RSP_SUCCESS;
+	case -EPERM:
+	case -EACCES:
+		return G_OBEX_RSP_FORBIDDEN;
+	case -ENOENT:
+		return G_OBEX_RSP_NOT_FOUND;
+	case -EBADR:
+		return G_OBEX_RSP_BAD_REQUEST;
+	case -EFAULT:
+		return G_OBEX_RSP_SERVICE_UNAVAILABLE;
+	case -EINVAL:
+		return G_OBEX_RSP_NOT_IMPLEMENTED;
+	case -ENOTEMPTY:
+	case -EEXIST:
+		return G_OBEX_RSP_PRECONDITION_FAILED;
+	default:
+		return G_OBEX_RSP_INTERNAL_SERVER_ERROR;
+	}
+}
diff --git a/gobex/gobex.h b/gobex/gobex.h
index 1c47c68..4509528 100644
--- a/gobex/gobex.h
+++ b/gobex/gobex.h
@@ -125,5 +125,6 @@ guint g_obex_get_rsp_pkt(GObex *obex, GObexPacket *rsp,
 gboolean g_obex_cancel_transfer(guint id);
 
 const char *g_obex_strerror(guint8 err_code);
+guint8 g_obex_errno2rsp(int err);
 
 #endif /* __GOBEX_H */
-- 
1.7.7.6

