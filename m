Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26859C61DA4
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Feb 2023 19:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjBKT4D (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 11 Feb 2023 14:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjBKT4C (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 11 Feb 2023 14:56:02 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373D7166C4
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Feb 2023 11:56:00 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id C3DCE240454
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Feb 2023 20:55:58 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PDhDZ1SWLz9rxL;
        Sat, 11 Feb 2023 20:55:58 +0100 (CET)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 2/2] media: clear the right transport when clearing BAP endpoint
Date:   Sat, 11 Feb 2023 19:55:53 +0000
Message-Id: <f93d483b5deb1628ba822ab752767b17e946d9c8.1676145318.git.pav@iki.fi>
In-Reply-To: <a0b0c0b71c0bbf0e200fd01619901bc5fa00e531.1676145318.git.pav@iki.fi>
References: <a0b0c0b71c0bbf0e200fd01619901bc5fa00e531.1676145318.git.pav@iki.fi>
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
    In principle multiple clients should work, but I don't have equipment
    right now to test streaming for more than one client.

 profiles/audio/media.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 505c4b3a6..3eb038cb7 100644
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
 
@@ -1089,11 +1085,20 @@ static int pac_config(struct bt_bap_stream *stream, struct iovec *cfg,
 static void pac_clear(struct bt_bap_stream *stream, void *user_data)
 {
 	struct media_endpoint *endpoint = user_data;
+	struct media_transport *transport;
+	const char *path;
+
+	path = bt_bap_stream_get_user_data(stream);
+	if (!path)
+		return;
 
-	endpoint->stream = NULL;
+	DBG("endpoint %p path %s", endpoint, path);
 
-	while (endpoint->transports != NULL)
-		clear_configuration(endpoint, endpoint->transports->data);
+	transport = find_transport(endpoint, path);
+	if (transport) {
+		clear_configuration(endpoint, transport);
+		bt_bap_stream_set_user_data(stream, NULL);
+	}
 }
 
 static struct bt_bap_pac_ops pac_ops = {
-- 
2.39.1

