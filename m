Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22C8C636D4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Feb 2023 22:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjBOW0K (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Feb 2023 17:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjBOW0J (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Feb 2023 17:26:09 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4778637B52
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Feb 2023 14:26:06 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id E3D7F240483
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Feb 2023 23:26:04 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PHCMw1VGcz9rxP;
        Wed, 15 Feb 2023 23:26:04 +0100 (CET)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 2/3] media: look up BAP transports by their associated stream
Date:   Wed, 15 Feb 2023 22:26:01 +0000
Message-Id: <c40f403ee7ceac50609881a44b4a1bbd20338aba.1676499415.git.pav@iki.fi>
In-Reply-To: <f973ae1e4b2c07902f98a6e7776b44bef25670be.1676499415.git.pav@iki.fi>
References: <f973ae1e4b2c07902f98a6e7776b44bef25670be.1676499415.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

To look up transports, use BAP stream pointers associated with them, not
the path strings stored in the stream user data. This makes it clearer
that transports presented to the sound server correspond to the actual
streams.  The Acquire/etc. of BAP transports are already tied to the
associated stream.

This fixes use-after-free crashes in pac_clear.  They occur because the
lifetime of the path string was either that of media transport or media
endpoint, which may be shorter than that of the BAP stream.  In such
case, pac_clear is entered with invalid pointer in stream user data,
leading to crash.  There are a few code paths for this, e.g. making
sound server delay its SetConfiguration response (e.g. gdb breakpoint)
to get dbus timeout, then disconnecting:

ERROR: AddressSanitizer: heap-use-after-free on address XXXX
READ of size 3 at 0x606000031640 thread T0
...
    #4 0x559891 in btd_debug src/log.c:117
    #5 0x46abfd in pac_clear profiles/audio/media.c:1096
    #6 0x79fcaf in bap_stream_clear_cfm src/shared/bap.c:914
    #7 0x7a060d in bap_stream_detach src/shared/bap.c:987
    #8 0x7a25ea in bap_stream_state_changed src/shared/bap.c:1210
    #9 0x7a29cd in stream_set_state src/shared/bap.c:1254
    #10 0x7be824 in stream_foreach_detach src/shared/bap.c:3820
    #11 0x71d15d in queue_foreach src/shared/queue.c:207
    #12 0x7beb98 in bt_bap_detach src/shared/bap.c:3836
    #13 0x5228cb in bap_disconnect profiles/audio/bap.c:1342
    #14 0x63247c in btd_service_disconnect src/service.c:305
freed by thread T0 here:
    #0 0x7f16708b9388 in __interceptor_free.part.0 (/lib64/libasan.so.8+0xb9388)
    #1 0x7f167071b8cc in g_free (/lib64/libglib-2.0.so.0+0x5b8cc)
    #2 0x7047b7 in remove_interface gdbus/object.c:660
    #3 0x70aef6 in g_dbus_unregister_interface gdbus/object.c:1394
    #4 0x47be30 in media_transport_destroy profiles/audio/transport.c:217
    #5 0x464ab9 in endpoint_remove_transport profiles/audio/media.c:270
    #6 0x464d26 in clear_configuration profiles/audio/media.c:292
    #7 0x464e69 in clear_endpoint profiles/audio/media.c:300
    #8 0x46516e in endpoint_reply profiles/audio/media.c:325
...

Fixes: 7b1b1a499cf3 ("media: clear the right transport when clearing BAP endpoint")
---

Notes:
    v2:
    * Change find_transport to find them by stream, not path.
    
    To reproduce with pipewire,
    gdb -p `pidof wireplumber`
    break bluez5-dbus.c:endpoint_set_configuration
    c
    
    and then connect with bluetoothctl to a BAP server, and disconnect after
    NoReply dbus error is received.

 profiles/audio/media.c | 34 +++++++++++-----------------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 479a11db9..b722278ba 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -978,23 +978,20 @@ struct pac_config_data {
 static int transport_cmp(gconstpointer data, gconstpointer user_data)
 {
 	const struct media_transport *transport = data;
-	const char *path = user_data;
 
-	if (g_str_has_prefix(media_transport_get_path((void *)transport), path))
+	if (media_transport_get_stream((void *)transport) == user_data)
 		return 0;
 
 	return -1;
 }
 
 static struct media_transport *find_transport(struct media_endpoint *endpoint,
-						const char *path)
+						void *stream)
 {
 	GSList *match;
 
-	if (!path)
-		return NULL;
-
-	match = g_slist_find_custom(endpoint->transports, path, transport_cmp);
+	match = g_slist_find_custom(endpoint->transports, stream,
+								transport_cmp);
 	if (match == NULL)
 		return NULL;
 
@@ -1022,11 +1019,9 @@ static int pac_config(struct bt_bap_stream *stream, struct iovec *cfg,
 	DBusMessageIter iter;
 	const char *path;
 
-	path = bt_bap_stream_get_user_data(stream);
+	DBG("endpoint %p stream %p", endpoint, stream);
 
-	DBG("endpoint %p path %s", endpoint, path);
-
-	transport = find_transport(endpoint, path);
+	transport = find_transport(endpoint, stream);
 	if (!transport) {
 		struct bt_bap *bap = bt_bap_stream_get_session(stream);
 		struct btd_service *service = bt_bap_get_user_data(bap);
@@ -1046,14 +1041,14 @@ static int pac_config(struct bt_bap_stream *stream, struct iovec *cfg,
 			return -EINVAL;
 		}
 
+		path = bt_bap_stream_get_user_data(stream);
+
 		transport = media_transport_create(device, path, cfg->iov_base,
 							cfg->iov_len, endpoint,
 							stream);
 		if (!transport)
 			return -EINVAL;
 
-		path = media_transport_get_path(transport);
-		bt_bap_stream_set_user_data(stream, (void *)path);
 		endpoint->transports = g_slist_append(endpoint->transports,
 								transport);
 	}
@@ -1087,19 +1082,12 @@ static void pac_clear(struct bt_bap_stream *stream, void *user_data)
 {
 	struct media_endpoint *endpoint = user_data;
 	struct media_transport *transport;
-	const char *path;
-
-	path = bt_bap_stream_get_user_data(stream);
-	if (!path)
-		return;
 
-	DBG("endpoint %p path %s", endpoint, path);
+	DBG("endpoint %p stream %p", endpoint, stream);
 
-	transport = find_transport(endpoint, path);
-	if (transport) {
+	transport = find_transport(endpoint, stream);
+	if (transport)
 		clear_configuration(endpoint, transport);
-		bt_bap_stream_set_user_data(stream, NULL);
-	}
 }
 
 static struct bt_bap_pac_ops pac_ops = {
-- 
2.39.1

