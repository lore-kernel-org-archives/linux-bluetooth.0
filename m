Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] audio/AVCTP: Fix crash
Date: Tue,  3 Dec 2013 11:36:25 +0200
Message-Id: <1386063385-31263-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The following crash happens because the list l is modified within the
loop so it is no longer safe to call l->next directly:

Invalid read of size 8
   at 0x41F276: pending_create (avctp.c:1491)
   by 0x41F7C0: avctp_send_req.isra.6 (avctp.c:1539)
   by 0x41F887: avctp_passthrough_release (avctp.c:1643)
   by 0x41F9DF: avctp_passthrough_rsp (avctp.c:1698)
   by 0x41E9AC: session_cb (avctp.c:782)
   by 0x31D1647DF5: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3600.3)
   by 0x31D1648147: ??? (in /usr/lib64/libglib-2.0.so.0.3600.3)
   by 0x31D1648549: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3600.3)
   by 0x40A49F: main (main.c:587)
 Address 0x8 is not stack'd, malloc'd or (recently) free'd
---
 profiles/audio/avctp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 4de981c..6669ddc 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -1488,7 +1488,7 @@ static struct avctp_pending_req *pending_create(struct avctp_channel *chan,
 	tmp = g_slist_copy(chan->processed);
 
 	/* Find first unused transaction id */
-	for (l = tmp; l; l = l->next) {
+	for (l = tmp; l; l = g_slist_next(l)) {
 		struct avctp_pending_req *req = l->data;
 
 		if (req->transaction == chan->transaction) {
-- 
1.8.3.1

