Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622A5EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Sun,  2 Jul 2023 18:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjGBSnK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 2 Jul 2023 14:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjGBSnJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 2 Jul 2023 14:43:09 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBA8C2
        for <linux-bluetooth@vger.kernel.org>; Sun,  2 Jul 2023 11:43:08 -0700 (PDT)
Received: from monolith.lan (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4QvHxR0mMxzyfb;
        Sun,  2 Jul 2023 21:43:07 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1688323387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mh4A48gUpJnKUmnYwhnh69ob228BeUYPDZSKCdVRuXI=;
        b=XcYDSavdelVEgx7/s8TYCes4wt9PXUOZKpbGXwfbSCo+7BaWnrvgCfc+sbXlsrkD35limd
        +8O9LalWBQiljsnp0/jZo34Qn7uepALuXk2eS881jOl0J3vnEQmDWw9YIu8jPefJyIfyfa
        BeUagtjnlxaYDd7f1OQDvbcK32a4k8U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1688323387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mh4A48gUpJnKUmnYwhnh69ob228BeUYPDZSKCdVRuXI=;
        b=d9l/IrjW+dMnALlMcdrPO4Dcmqf6es37sdZlWDQhtE7LjI7jV66u80qJT+Ij+ai5zAI4Jq
        6TWMVzLT8tmgyDmWanNyu3iO6irbX9ttFkkqEngYXLTYGCedtS4V/IJGxIGBVzr6onQPlo
        CmUoOavWpgtI9rSAdU/SjE5pdPZqgm4=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1688323387; a=rsa-sha256; cv=none;
        b=BVKI1PYDKfYrHg1cfop5qOV8hFpW6PwSrLWQ6mEx8O0ZdeRowcXoYKfB2tdvABqJPdAVMD
        3aLPBVwLSXjoI/t/MCThO6eXrUKoVUL2cFAeYoe0xGpCjwuwweAkijT3HEKWjsQgff89gd
        TQMcWSEV19TAL6RP6QfzyVYXeyddcpY=
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 2/2] bap: wait for CIG to become configurable before recreating CIS
Date:   Sun,  2 Jul 2023 21:43:05 +0300
Message-ID: <db38b1f94e45c0be70fcce66590ddbf4dcc705f9.1688323254.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <09443d89e7486d890b346d47ebc5c6a8f5eb30af.1688323254.git.pav@iki.fi>
References: <09443d89e7486d890b346d47ebc5c6a8f5eb30af.1688323254.git.pav@iki.fi>
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
    v2: no changes

 profiles/audio/bap.c | 107 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 97 insertions(+), 10 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 8e2fc1556..d7ce9e038 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -68,6 +68,7 @@ struct bap_ep {
 	GIOChannel *io;
 	unsigned int io_id;
 	bool recreate;
+	bool cig_active;
 	struct iovec *caps;
 	struct iovec *metadata;
 	struct bt_bap_qos qos;
@@ -525,6 +526,7 @@ static void bap_io_close(struct bap_ep *ep)
 
 	g_io_channel_unref(ep->io);
 	ep->io = NULL;
+	ep->cig_active = false;
 }
 
 static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
@@ -988,7 +990,7 @@ drop:
 	g_io_channel_shutdown(io, TRUE, NULL);
 }
 
-static void bap_accept_io(struct bap_data *data, struct bt_bap_stream *stream,
+static void bap_accept_io(struct bap_ep *ep, struct bt_bap_stream *stream,
 							int fd, int defer)
 {
 	char c;
@@ -1025,12 +1027,52 @@ static void bap_accept_io(struct bap_data *data, struct bt_bap_stream *stream,
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
+	return (ep->qos.ucast.cig_id == info->cig) && ep->cig_active;
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
 
@@ -1047,6 +1089,48 @@ static gboolean bap_io_recreate(void *user_data)
 	return FALSE;
 }
 
+static void recreate_cig_ep(void *data, void *match_data)
+{
+	struct bap_ep *ep = (struct bap_ep *)data;
+	struct cig_busy_data *info = match_data;
+
+	if (ep->qos.ucast.cig_id != info->cig || !ep->recreate || ep->io_id)
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
+	info.cig = ep->qos.ucast.cig_id;
+
+	DBG("adapter %p ep %p recreate CIG %d", info.adapter, ep, info.cig);
+
+	if (ep->qos.ucast.cig_id == BT_ISO_QOS_CIG_UNSET) {
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
@@ -1059,10 +1143,8 @@ static gboolean bap_io_disconnected(GIOChannel *io, GIOCondition cond,
 	bap_io_close(ep);
 
 	/* Check if connecting recreate IO */
-	if (ep->recreate) {
-		ep->recreate = false;
-		ep->io_id = g_idle_add(bap_io_recreate, ep);
-	}
+	if (!is_cig_busy(ep->data, ep->qos.ucast.cig_id))
+		recreate_cig(ep);
 
 	return FALSE;
 }
@@ -1087,18 +1169,22 @@ static void bap_connect_io(struct bap_data *data, struct bap_ep *ep,
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
+	if (ep->io || is_cig_busy(data, ep->qos.ucast.cig_id)) {
+		DBG("ep %p stream %p defer %s wait recreate", ep, stream,
+						defer ? "true" : "false");
 		ep->recreate = true;
 		return;
 	}
@@ -1131,6 +1217,7 @@ static void bap_connect_io(struct bap_data *data, struct bap_ep *ep,
 						bap_io_disconnected, ep);
 
 	ep->io = io;
+	ep->cig_active = !defer;
 
 	bt_bap_stream_io_connecting(stream, g_io_channel_unix_get_fd(io));
 }
-- 
2.41.0

