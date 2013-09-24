Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH BlueZ 2/2] gobex: Revert g_obex_pending_req_abort to static pending_req_abort
Date: Tue, 24 Sep 2013 17:47:16 +0300
Message-Id: <1380034036-25143-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1380034036-25143-1-git-send-email-luiz.dentz@gmail.com>
References: <1380034036-25143-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This reverts the changes introduced in
9095deb82572112fc0870095bf2222964610eafe that made pending_req_abort
public which is not necessary considering g_obex_cancel_req can do the
same and is safe to call even if the request is not pending.
---
 gobex/gobex.c | 4 ++--
 gobex/gobex.h | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/gobex/gobex.c b/gobex/gobex.c
index deeab40..8c08b1e 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -685,7 +685,7 @@ static int pending_pkt_cmp(gconstpointer a, gconstpointer b)
 	return (p->id - id);
 }
 
-gboolean g_obex_pending_req_abort(GObex *obex, GError **err)
+static gboolean pending_req_abort(GObex *obex, GError **err)
 {
 	struct pending_pkt *p = obex->pending_req;
 	GObexPacket *req;
@@ -729,7 +729,7 @@ gboolean g_obex_cancel_req(GObex *obex, guint req_id, gboolean remove_callback)
 	struct pending_pkt *p;
 
 	if (obex->pending_req && obex->pending_req->id == req_id) {
-		if (!g_obex_pending_req_abort(obex, NULL)) {
+		if (!pending_req_abort(obex, NULL)) {
 			p = obex->pending_req;
 			obex->pending_req = NULL;
 			goto immediate_completion;
diff --git a/gobex/gobex.h b/gobex/gobex.h
index 3ac7b13..76a224e 100644
--- a/gobex/gobex.h
+++ b/gobex/gobex.h
@@ -50,8 +50,6 @@ guint g_obex_send_req(GObex *obex, GObexPacket *req, int timeout,
 gboolean g_obex_cancel_req(GObex *obex, guint req_id,
 						gboolean remove_callback);
 
-gboolean g_obex_pending_req_abort(GObex *obex, GError **err);
-
 gboolean g_obex_send_rsp(GObex *obex, guint8 rspcode, GError **err,
 						guint8 first_hdr_type, ...);
 
-- 
1.8.3.1

