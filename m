Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D66C636CC
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Feb 2023 21:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjBMVYf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Feb 2023 16:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBMVYe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Feb 2023 16:24:34 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7C21EBC3
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Feb 2023 13:24:33 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id DA91A240328
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Feb 2023 22:24:31 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PFy5q18btz9rxH;
        Mon, 13 Feb 2023 22:24:30 +0100 (CET)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] media: fix crash when clearing BAP transport
Date:   Mon, 13 Feb 2023 21:24:29 +0000
Message-Id: <8355ef6eaf7bf6b1d82d03580de9a1d18ed4f152.1676323061.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The BAP stream user data used for transport paths in media.c is set both
in media.c:pac_config and in profiles/bap.c. In the latter, it gets set
to a string owned by bap_ep, whose lifetime can be shorter than that of
the transport.

Under some conditions, bap.c:bap_disconnect is hit while there are
transports and the user data is owned by the endpoint. In this case, the
path string owned by the endpoints gets freed first, and ASAN
use-after-free crash is encountered when clearing the transports.

Fix this by matching the transports by the stream pointer, and not by
the transport/endpoint path.

Fixes: 7b1b1a499cf3 ("media: clear the right transport when clearing BAP endpoint")
---

Notes:
    The v2 version of the patch in commit 7b1b1a499cf334 was buggy, and its
    v3 sent to the list was supposed to replace it. However, I resubmitted
    only that patch and not the full series, which maybe would have been the
    right thing.  Sorry for the mess.

 profiles/audio/media.c     | 21 +++++++++++----------
 profiles/audio/transport.c | 14 ++++++++++++++
 profiles/audio/transport.h |  1 +
 3 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 3eb038cb7..8728b69e0 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1085,19 +1085,20 @@ static int pac_config(struct bt_bap_stream *stream, struct iovec *cfg,
 static void pac_clear(struct bt_bap_stream *stream, void *user_data)
 {
 	struct media_endpoint *endpoint = user_data;
-	struct media_transport *transport;
-	const char *path;
+	GSList *item;
 
-	path = bt_bap_stream_get_user_data(stream);
-	if (!path)
-		return;
+	DBG("endpoint %p stream %p", endpoint, stream);
 
-	DBG("endpoint %p path %s", endpoint, path);
+	item = endpoint->transports;
+	while (item) {
+		struct media_transport *transport = item->data;
 
-	transport = find_transport(endpoint, path);
-	if (transport) {
-		clear_configuration(endpoint, transport);
-		bt_bap_stream_set_user_data(stream, NULL);
+		if (media_transport_get_stream(transport) == stream) {
+			clear_configuration(endpoint, transport);
+			item = endpoint->transports;
+		} else {
+			item = item->next;
+		}
 	}
 }
 
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 5e057e2a5..cd91669c6 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -1483,6 +1483,20 @@ const char *media_transport_get_path(struct media_transport *transport)
 	return transport->path;
 }
 
+void *media_transport_get_stream(struct media_transport *transport)
+{
+	struct bap_transport *bap;
+	const char *uuid;
+
+	uuid = media_endpoint_get_uuid(transport->endpoint);
+	if (strcasecmp(uuid, PAC_SINK_UUID) &&
+			strcasecmp(uuid, PAC_SOURCE_UUID))
+		return NULL;
+
+	bap = transport->data;
+	return bap->stream;
+}
+
 void media_transport_update_delay(struct media_transport *transport,
 							uint16_t delay)
 {
diff --git a/profiles/audio/transport.h b/profiles/audio/transport.h
index 102fc3cf1..5ca9b8f9e 100644
--- a/profiles/audio/transport.h
+++ b/profiles/audio/transport.h
@@ -19,6 +19,7 @@ struct media_transport *media_transport_create(struct btd_device *device,
 
 void media_transport_destroy(struct media_transport *transport);
 const char *media_transport_get_path(struct media_transport *transport);
+void *media_transport_get_stream(struct media_transport *transport);
 struct btd_device *media_transport_get_dev(struct media_transport *transport);
 int8_t media_transport_get_volume(struct media_transport *transport);
 void media_transport_update_delay(struct media_transport *transport,
-- 
2.39.1

