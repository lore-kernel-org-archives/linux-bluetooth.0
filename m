Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8686AC636CC
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Feb 2023 22:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjBOW0J (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Feb 2023 17:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjBOW0J (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Feb 2023 17:26:09 -0500
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7DB2A153
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Feb 2023 14:26:05 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 6A20B2403B8
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Feb 2023 23:26:04 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PHCMv5VTFz9rxG;
        Wed, 15 Feb 2023 23:26:03 +0100 (CET)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 1/3] audio/transport: add media_transport_get_stream method for transports
Date:   Wed, 15 Feb 2023 22:26:00 +0000
Message-Id: <f973ae1e4b2c07902f98a6e7776b44bef25670be.1676499415.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add a method for getting the audio stream associated with a media
transport.
---

Notes:
    v2: make generic and split out to separate patch

 profiles/audio/transport.c | 18 ++++++++++++++++++
 profiles/audio/transport.h |  1 +
 2 files changed, 19 insertions(+)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 5e057e2a5..912f404e8 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -116,6 +116,8 @@ struct media_transport {
 								guint id);
 	void			(*set_state) (struct media_transport *transport,
 						transport_state_t state);
+	void			*(*get_stream)
+					(struct media_transport *transport);
 	GDestroyNotify		destroy;
 	void			*data;
 };
@@ -1380,6 +1382,13 @@ static void bap_connecting(struct bt_bap_stream *stream, bool state, int fd,
 	bap_update_links(transport);
 }
 
+static void *get_stream_bap(struct media_transport *transport)
+{
+	struct bap_transport *bap = transport->data;
+
+	return bap->stream;
+}
+
 static void free_bap(void *data)
 {
 	struct bap_transport *bap = data;
@@ -1415,6 +1424,7 @@ static int media_transport_init_bap(struct media_transport *transport,
 	transport->suspend = suspend_bap;
 	transport->cancel = cancel_bap;
 	transport->set_state = set_state_bap;
+	transport->get_stream = get_stream_bap;
 	transport->destroy = free_bap;
 
 	return 0;
@@ -1483,6 +1493,14 @@ const char *media_transport_get_path(struct media_transport *transport)
 	return transport->path;
 }
 
+void *media_transport_get_stream(struct media_transport *transport)
+{
+	if (transport->get_stream)
+		return transport->get_stream(transport);
+
+	return NULL;
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

