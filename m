Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 14/15] obexd: Fix crash when resetting OPP session without a transfer
Date: Mon, 10 Jun 2013 13:37:09 +0300
Message-Id: <1370860630-30359-14-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1370860630-30359-1-git-send-email-luiz.dentz@gmail.com>
References: <1370860630-30359-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Invalid read of size 8
   at 0x42A570: manager_emit_transfer_completed (manager.c:863)
   by 0x42A76A: os_reset_session (obex.c:206)
   by 0x42A8BB: disconn_func (obex.c:1085)
   by 0x419C55: incoming_data (gobex.c:1224)
   by 0x3F31A47A54: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
   by 0x3F31A47D87: ??? (in /usr/lib64/libglib-2.0.so.0.3400.2)
   by 0x3F31A48181: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3400.2)
   by 0x40DDB2: main (main.c:319)
 Address 0x10 is not stack'd, malloc'd or (recently) free'd

Invalid read of size 1
   at 0x42A231: manager_unregister_transfer (manager.c:672)
   by 0x420F8B: opp_disconnect (opp.c:158)
   by 0x42A8EC: disconn_func (obex.c:1088)
   by 0x419C55: incoming_data (gobex.c:1224)
   by 0x3F31A47A54: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
   by 0x3F31A47D87: ??? (in /usr/lib64/libglib-2.0.so.0.3400.2)
   by 0x3F31A48181: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3400.2)
   by 0x40DDB2: main (main.c:319)
 Address 0x0 is not stack'd, malloc'd or (recently) free'd
---
 obexd/src/manager.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/obexd/src/manager.c b/obexd/src/manager.c
index 6ddee2b..dbfbef8 100644
--- a/obexd/src/manager.c
+++ b/obexd/src/manager.c
@@ -667,7 +667,12 @@ struct obex_transfer *manager_register_transfer(struct obex_session *os)
 
 void manager_unregister_transfer(struct obex_transfer *transfer)
 {
-	struct obex_session *os = transfer->session;
+	struct obex_session *os;
+
+	if (transfer == NULL)
+		return;
+
+	os = transfer->session;
 
 	if (transfer->status == TRANSFER_STATUS_ACTIVE)
 		emit_transfer_completed(transfer, os->offset == os->size);
@@ -860,8 +865,17 @@ void manager_emit_transfer_progress(struct obex_transfer *transfer)
 
 void manager_emit_transfer_completed(struct obex_transfer *transfer)
 {
-	if (transfer->session->object)
-		emit_transfer_completed(transfer, !transfer->session->aborted);
+	struct obex_session *session;
+
+	if (transfer == NULL)
+		return;
+
+	session = transfer->session;
+
+	if (session == NULL || session->object == NULL)
+		return;
+
+	emit_transfer_completed(transfer, !session->aborted);
 }
 
 DBusConnection *manager_dbus_get_connection(void)
-- 
1.8.1.4

