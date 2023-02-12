Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85970C636D7
	for <linux-bluetooth@archiver.kernel.org>; Sun, 12 Feb 2023 14:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjBLOAu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 12 Feb 2023 09:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBLOAt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 12 Feb 2023 09:00:49 -0500
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CA9359B
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Feb 2023 06:00:47 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 28F6924005D
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Feb 2023 15:00:46 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PF8JF4XRWz9rxD;
        Sun, 12 Feb 2023 15:00:45 +0100 (CET)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3] media: clear the right transport when clearing BAP endpoint
Date:   Sun, 12 Feb 2023 14:00:43 +0000
Message-Id: <e15e60d7941eba174cf306b45c80bc53435554b0.1676210275.git.pav@iki.fi>
In-Reply-To: <f93d483b5deb1628ba822ab752767b17e946d9c8.1676145318.git.pav@iki.fi>
References: <f93d483b5deb1628ba822ab752767b17e946d9c8.1676145318.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Each configured BAP stream is associated with a transport, and only that
transport should be cleared when the stream's configuration is cleared.

This is required for multiple BAP clients to use the same Media1
endpoint, which is what we should aim for to follow the spirit in which
the endpoints work in ASCS.  Sound servers generally can handle this,
since the *Configuration calls provide the transport paths, and for
different clients they are associated with different devices.
---

Notes:
    v3:
    * Match transports based on stream, not path.
    
      The path in bt_bap_stream user data is set to endpoint path on
      config, and may be freed too early, if endpoint is freed before
      clearing the PAC, as happens in bap.c:bap_disconnect
    
    In principle multiple clients should work, but I don't have equipment
    right now to test streaming for more than one client.

 profiles/audio/media.c     | 20 +++++++++++++-------
 profiles/audio/transport.c | 13 +++++++++++++
 profiles/audio/transport.h |  1 +
 3 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 505c4b3a6..8728b69e0 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -86,7 +86,6 @@ struct endpoint_request {
 struct media_endpoint {
 	struct a2dp_sep		*sep;
 	struct bt_bap_pac	*pac;
-	void			*stream;
 	char			*sender;	/* Endpoint DBus bus id */
 	char			*path;		/* Endpoint object path */
 	char			*uuid;		/* Endpoint property UUID */
@@ -1007,9 +1006,6 @@ static void pac_config_cb(struct media_endpoint *endpoint, void *ret, int size,
 	struct pac_config_data *data = user_data;
 	gboolean *ret_value = ret;
 
-	if (ret_value)
-		endpoint->stream = data->stream;
-
 	data->cb(data->stream, ret_value ? 0 : -EINVAL);
 }
 
@@ -1089,11 +1085,21 @@ static int pac_config(struct bt_bap_stream *stream, struct iovec *cfg,
 static void pac_clear(struct bt_bap_stream *stream, void *user_data)
 {
 	struct media_endpoint *endpoint = user_data;
+	GSList *item;
 
-	endpoint->stream = NULL;
+	DBG("endpoint %p stream %p", endpoint, stream);
 
-	while (endpoint->transports != NULL)
-		clear_configuration(endpoint, endpoint->transports->data);
+	item = endpoint->transports;
+	while (item) {
+		struct media_transport *transport = item->data;
+
+		if (media_transport_get_stream(transport) == stream) {
+			clear_configuration(endpoint, transport);
+			item = endpoint->transports;
+		} else {
+			item = item->next;
+		}
+	}
 }
 
 static struct bt_bap_pac_ops pac_ops = {
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 5e057e2a5..b7aa5107b 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -1483,6 +1483,19 @@ const char *media_transport_get_path(struct media_transport *transport)
 	return transport->path;
 }
 
+void *media_transport_get_stream(struct media_transport *transport)
+{
+	struct bap_transport *bap;
+	const char *uuid;
+
+	uuid = media_endpoint_get_uuid(transport->endpoint);
+	if (strcasecmp(uuid, PAC_SINK_UUID) && strcasecmp(uuid, PAC_SOURCE_UUID))
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

