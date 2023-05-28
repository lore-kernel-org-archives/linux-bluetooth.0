Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCA3C7EE2E
	for <linux-bluetooth@archiver.kernel.org>; Sun, 28 May 2023 17:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjE1Rkg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 28 May 2023 13:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjE1Rkf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 28 May 2023 13:40:35 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CDFA2
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 May 2023 10:40:33 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 67B6C240101
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 May 2023 19:40:32 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4QTmCM6d1rz9rxL;
        Sun, 28 May 2023 19:40:31 +0200 (CEST)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/2] bap: wait for CIG to become configurable before recreating CIS
Date:   Sun, 28 May 2023 17:40:30 +0000
Message-Id: <2bb40ab76caccdc01f15d2befc7e5a625b2922d0.1685284537.git.pav@iki.fi>
In-Reply-To: <bc567c4cb647d89e2e76568583716b4e44092519.1685284537.git.pav@iki.fi>
References: <bc567c4cb647d89e2e76568583716b4e44092519.1685284537.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

ISO sockets cannot be reconnected before all sockets in the same CIG
have been closed, if the CIG was previously active.

Keep track which endpoints have active CIG, and postpone connecting CIS
until their CIG is no longer active.

This addresses getting EBUSY from connect() when multiple CIS in the
same CIG move streaming -> qos at the same time, which disconnects CIS
and recreates them.  The EBUSY originates from COMMAND_DISALLOWED
response to Set CIG Parameters.

This requires the kernel side do the Disconnect CIS / Remove CIG / Set
CIG Parameters HCI command steps in the right order, when all old
sockets are closed first before connecting new ones.
---

Notes:
    I sent a patchset that fixes also the kernel issues. With this BlueZ
    patchset and the kernel patchset, disabling and re-enabling ASEs with
    Intel AX210 + Samsung Galaxy Buds2 Pro works. Sound server can also now
    release and reacquire the sinks normally, fixing
    https://github.com/bluez/bluez/issues/516
    
    Current bluetooth-next kernel does not guarantee correct ordering of the
    operations when the socket operations are done fast, and looking at this
    found a few other problems with doing the Set CIG Parameters and Create
    CIS commands.
    
    I get the wrong ordering of Remove CIG / Set CIG Parameters when
    doing this with Intel AX210 + Samsung Galaxy Buds2 Pro.
    
    I tried to write reconnect tests to iso-tester to reproduce this, but
    the required timing to trigger it wasn't easy to do, so the test doesn't
    hit this condition. It however uncovered issues in handling of Create
    CIS.

 profiles/audio/bap.c | 107 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 97 insertions(+), 10 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 1a543a9ce..063da0786 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -66,6 +66,7 @@ struct bap_ep {
 	GIOChannel *io;
 	unsigned int io_id;
 	bool recreate;
+	bool cig_active;
 	struct iovec *caps;
 	struct iovec *metadata;
 	struct bt_bap_qos qos;
@@ -428,6 +429,7 @@ static void bap_io_close(struct bap_ep *ep)
 
 	g_io_channel_unref(ep->io);
 	ep->io = NULL;
+	ep->cig_active = false;
 }
 
 static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
@@ -794,7 +796,7 @@ drop:
 	g_io_channel_shutdown(io, TRUE, NULL);
 }
 
-static void bap_accept_io(struct bap_data *data, struct bt_bap_stream *stream,
+static void bap_accept_io(struct bap_ep *ep, struct bt_bap_stream *stream,
 							int fd, int defer)
 {
 	char c;
@@ -831,12 +833,52 @@ static void bap_accept_io(struct bap_data *data, struct bt_bap_stream *stream,
 		}
 	}
 
+	ep->cig_active = true;
+
 	return;
 
 fail:
 	close(fd);
 }
 
+struct cig_busy_data {
+	struct btd_adapter *adapter;
+	uint8_t cig;
+};
+
+static bool cig_busy_ep(const void *data, const void *match_data)
+{
+	const struct bap_ep *ep = data;
+	const struct cig_busy_data *info = match_data;
+
+	return (ep->qos.cig_id == info->cig) && ep->cig_active;
+}
+
+static bool cig_busy_session(const void *data, const void *match_data)
+{
+	const struct bap_data *session = data;
+	const struct cig_busy_data *info = match_data;
+
+	if (device_get_adapter(session->device) != info->adapter)
+		return false;
+
+	return queue_find(session->snks, cig_busy_ep, match_data) ||
+			queue_find(session->srcs, cig_busy_ep, match_data);
+}
+
+static bool is_cig_busy(struct bap_data *data, uint8_t cig)
+{
+	struct cig_busy_data info;
+
+	if (cig == BT_ISO_QOS_CIG_UNSET)
+		return false;
+
+	info.adapter = device_get_adapter(data->device);
+	info.cig = cig;
+
+	return queue_find(sessions, cig_busy_session, &info);
+}
+
 static void bap_create_io(struct bap_data *data, struct bap_ep *ep,
 				struct bt_bap_stream *stream, int defer);
 
@@ -853,6 +895,48 @@ static gboolean bap_io_recreate(void *user_data)
 	return FALSE;
 }
 
+static void recreate_cig_ep(void *data, void *match_data)
+{
+	struct bap_ep *ep = (struct bap_ep *)data;
+	struct cig_busy_data *info = match_data;
+
+	if (ep->qos.cig_id != info->cig || !ep->recreate || ep->io_id)
+		return;
+
+	ep->recreate = false;
+	ep->io_id = g_idle_add(bap_io_recreate, ep);
+}
+
+static void recreate_cig_session(void *data, void *match_data)
+{
+	struct bap_data *session = data;
+	struct cig_busy_data *info = match_data;
+
+	if (device_get_adapter(session->device) != info->adapter)
+		return;
+
+	queue_foreach(session->snks, recreate_cig_ep, match_data);
+	queue_foreach(session->srcs, recreate_cig_ep, match_data);
+}
+
+static void recreate_cig(struct bap_ep *ep)
+{
+	struct bap_data *data = ep->data;
+	struct cig_busy_data info;
+
+	info.adapter = device_get_adapter(data->device);
+	info.cig = ep->qos.cig_id;
+
+	DBG("adapter %p ep %p recreate CIG %d", info.adapter, ep, info.cig);
+
+	if (ep->qos.cig_id == BT_ISO_QOS_CIG_UNSET) {
+		recreate_cig_ep(ep, &info);
+		return;
+	}
+
+	queue_foreach(sessions, recreate_cig_session, &info);
+}
+
 static gboolean bap_io_disconnected(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
@@ -865,10 +949,8 @@ static gboolean bap_io_disconnected(GIOChannel *io, GIOCondition cond,
 	bap_io_close(ep);
 
 	/* Check if connecting recreate IO */
-	if (ep->recreate) {
-		ep->recreate = false;
-		ep->io_id = g_idle_add(bap_io_recreate, ep);
-	}
+	if (!is_cig_busy(ep->data, ep->qos.cig_id))
+		recreate_cig(ep);
 
 	return FALSE;
 }
@@ -893,18 +975,22 @@ static void bap_connect_io(struct bap_data *data, struct bap_ep *ep,
 	int fd;
 
 	/* If IO already set skip creating it again */
-	if (bt_bap_stream_get_io(stream))
+	if (bt_bap_stream_get_io(stream)) {
+		DBG("ep %p stream %p has existing io", ep, stream);
 		return;
+	}
 
 	if (bt_bap_stream_io_is_connecting(stream, &fd)) {
-		bap_accept_io(data, stream, fd, defer);
+		bap_accept_io(ep, stream, fd, defer);
 		return;
 	}
 
-	/* If IO channel still up wait for it to be disconnected and then
-	 * recreate.
+	/* If IO channel still up or CIG is busy, wait for it to be
+	 * disconnected and then recreate.
 	 */
-	if (ep->io) {
+	if (ep->io || is_cig_busy(data, ep->qos.cig_id)) {
+		DBG("ep %p stream %p defer %s wait recreate", ep, stream,
+						defer ? "true" : "false");
 		ep->recreate = true;
 		return;
 	}
@@ -937,6 +1023,7 @@ static void bap_connect_io(struct bap_data *data, struct bap_ep *ep,
 						bap_io_disconnected, ep);
 
 	ep->io = io;
+	ep->cig_active = !defer;
 
 	bt_bap_stream_io_connecting(stream, g_io_channel_unix_get_fd(io));
 }
-- 
2.40.1

