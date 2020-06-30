Return-Path: <SRS0=BnFh=AL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D55C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Jun 2020 13:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77DA9206C0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Jun 2020 13:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731182AbgF3Nrv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:47:51 -0400
Received: from mxout03.lancloud.ru ([89.108.73.187]:47062 "EHLO
        mxout03.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgF3Nru (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Jun 2020 09:47:50 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 95A7E2095C12
Received: from LanCloud
Received: from LanCloud
Received: by spb1wst017.omp.ru (Postfix, from userid 10000)
        id 22D52BA1D4B; Tue, 30 Jun 2020 16:47:47 +0300 (MSK)
From:   Denis Grigorev <d.grigorev@omprussia.ru>
To:     <linux-bluetooth@vger.kernel.org>
CC:     <luiz.von.dentz@intel.com>,
        Denis Grigorev <d.grigorev@omprussia.ru>
Subject: [RESEND PATCH BlueZ v3] gobex: Fix segfault caused by interrupted transfer
Date:   Tue, 30 Jun 2020 16:47:31 +0300
Message-ID: <20200630134731.18541-1-d.grigorev@omprussia.ru>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [81.3.167.34]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To LFEX09.lancloud.ru
 (fd00:f066::59)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When a obex transfer is interrupted by a peer in the middle, the response
G_OBEX_RSP_FORBIDDEN comes and the transfer is freed in transfer_complete.
However gobex is still ref'ed and gobex->io continues to be writable,
so write_data() and then g_obex_abort() are called. When the abort response
comes, struct obc_transfer is already freed, which leads to the crash.

Backtrace :
__GI___pthread_mutex_lock (mutex=0x65732f74) at pthread_mutex_lock.c:67
0xecc6eeda in dbus_connection_get_object_path_data () from libdbus-1.so.3
0x000457d4 in g_dbus_emit_property_changed_full () at gdbus/object.c:1794
0x00045868 in g_dbus_emit_property_changed () at gdbus/object.c:1832
0x000367f0 in transfer_set_status () at obexd/client/transfer.c:211
0x0003681e in transfer_set_status () at obexd/client/transfer.c:206
xfer_complete () at obexd/client/transfer.c:672
0x00022df6 in transfer_complete () at gobex/gobex-transfer.c:103
0x00022f44 in transfer_abort_response () at gobex/gobex-transfer.c:124
0x00020a0e in handle_response () at gobex/gobex.c:1128
0x00020dde in incoming_data () at gobex/gobex.c:1373

This commit introduces g_obex_drop_tx_queue(), which will be called if
a transfer error detected. After the tx queue is dropped, obex shuts
down gracefully.
---

Changes in v2 and v3:
- Edit commit message formatting.

 gobex/gobex-transfer.c |  5 +++++
 gobex/gobex.c          | 10 ++++++++++
 gobex/gobex.h          |  1 +
 3 files changed, 16 insertions(+)

diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
index bc9930679..e96e61fbc 100644
--- a/gobex/gobex-transfer.c
+++ b/gobex/gobex-transfer.c
@@ -100,6 +100,11 @@ static void transfer_complete(struct transfer *transfer, GError *err)
 
 	g_obex_debug(G_OBEX_DEBUG_TRANSFER, "transfer %u", id);
 
+	if (err) {
+		/* No further tx must be performed */
+		g_obex_drop_tx_queue(transfer->obex);
+	}
+
 	transfer->complete_func(transfer->obex, err, transfer->user_data);
 	/* Check if the complete_func removed the transfer */
 	if (find_transfer(id) == NULL)
diff --git a/gobex/gobex.c b/gobex/gobex.c
index 77f1aaafd..d68a85eb6 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -521,6 +521,16 @@ static void enable_tx(GObex *obex)
 	obex->write_source = g_io_add_watch(obex->io, cond, write_data, obex);
 }
 
+void g_obex_drop_tx_queue(GObex *obex)
+{
+	struct pending_pkt *p;
+
+	g_obex_debug(G_OBEX_DEBUG_COMMAND, "");
+
+	while ((p = g_queue_pop_head(obex->tx_queue)))
+		pending_pkt_free(p);
+}
+
 static gboolean g_obex_send_internal(GObex *obex, struct pending_pkt *p,
 								GError **err)
 {
diff --git a/gobex/gobex.h b/gobex/gobex.h
index b223a2fac..a94d9246e 100644
--- a/gobex/gobex.h
+++ b/gobex/gobex.h
@@ -63,6 +63,7 @@ gboolean g_obex_remove_request_function(GObex *obex, guint id);
 void g_obex_suspend(GObex *obex);
 void g_obex_resume(GObex *obex);
 gboolean g_obex_srm_active(GObex *obex);
+void g_obex_drop_tx_queue(GObex *obex);
 
 GObex *g_obex_new(GIOChannel *io, GObexTransportType transport_type,
 						gssize rx_mtu, gssize tx_mtu);
-- 
2.17.1

