Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7757B6D1A0
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Dec 2023 20:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRUzluUH"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5916c6b2e0fso3886eaf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Dec 2023 12:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702587367; x=1703192167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bTEneyeVAZkpPv7iM5dhXKZa7bmviESzAdvweEGWs8s=;
        b=cRUzluUHaZ7ds3iBv+3PtXLb6bT7t29vy0EohBeE3J8RdNPCl182dzsiM3sHyjZTAK
         s2PmTONeDC3u56jH2q0RFNpnCCt+Cue1EIlTn+JOi82QEdDDRk7YknFOO6UEyAvjXjGD
         u2AnomZm2ZG0BZSK65MUhIYvsc9t8kkegti/GXuhJX+jQ1o2JAjysoeargFAfiolildJ
         IzlSj6ntvTIdW7i2VwQgTfgdZxizN/q+4efkndVxO5TRPIdWYTwk+gPDh4KhN3qmlIe7
         IeMEQZYeTUklejzp59M5cAAQ43gyszH/MygMtO2Sbbg+WLvPN+H6SVtEu2hXF0yk5UFC
         245A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702587367; x=1703192167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bTEneyeVAZkpPv7iM5dhXKZa7bmviESzAdvweEGWs8s=;
        b=QvmSB0wMVefdtTpUGE+LSjEqIu5z2TJB0SCNQnOVyrucEDo3cVy18PxjfEDzHJX0GW
         gnc8jLU7EtdqOLEjQh4PrQx1S8sDozb85jlAFjjMBePpU5J7yCPIKaniHZIbClLPGiGg
         q3szCx6xOMy4FqZULGGx9Sk3gXQbfzCeluQGsz/YSEbZgN2/OJg1GlkxjR8DObq0ltLK
         oSGY4BMoY4I7rCe5tvXZw21xiJgpcUE2wOpeLdwRlUwFLcyWbJdUzbpTu6Bs6Mi2v4Tj
         Jp6eWkMq7t6J1zLPP2zStymPdePAb1IMKYb3ZjhyMXswBt4xP/1ugVmbo1Ay95uqWaoA
         XOUQ==
X-Gm-Message-State: AOJu0Yze+q8R3e4LI8bXnWsMKWNbjKxVBJNqbIE6lBRb9oTPAX/jCo4O
	ebG/NlCigGFjaSOPnyDsdwey4CaOS3c=
X-Google-Smtp-Source: AGHT+IGi/C7XZsjHh8KxIVJtwZY/fCJZqiUdaaMQpmB4x0+SfiUKaO5jueTDlYti5eN/aFtUorT5ZA==
X-Received: by 2002:a4a:92dd:0:b0:58e:1c47:6325 with SMTP id j29-20020a4a92dd000000b0058e1c476325mr6809954ooh.19.1702587366924;
        Thu, 14 Dec 2023 12:56:06 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id m20-20020a4a2414000000b005902a5bc3easm3658057oof.22.2023.12.14.12.56.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 12:56:05 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 5/6] shared/bap: Fix stream IO linking
Date: Thu, 14 Dec 2023 15:55:55 -0500
Message-ID: <20231214205556.1320286-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214205556.1320286-1-luiz.dentz@gmail.com>
References: <20231214205556.1320286-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

IO linking shall only be possible once, for the oposite direction as ISO
channels are bidirection, and not many times as that means multiplexing
would be used which is done within the transport payload, so this get rid
of queue links list and just use single link point instead.
---
 profiles/audio/media.c     |   6 +-
 profiles/audio/transport.c |  43 +++++++----
 src/shared/bap.c           | 146 +++++++++++--------------------------
 src/shared/bap.h           |   2 +-
 4 files changed, 74 insertions(+), 123 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index b17c555b63e4..1faa1c28969f 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -921,7 +921,7 @@ done:
 }
 
 static int pac_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
-			uint32_t chan_alloc, struct bt_bap_pac_qos *qos,
+			uint32_t location, struct bt_bap_pac_qos *qos,
 			bt_bap_pac_select_t cb, void *cb_data, void *user_data)
 {
 	struct media_endpoint *endpoint = user_data;
@@ -969,9 +969,9 @@ static int pac_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 		g_dbus_dict_append_entry(&dict, "Locations", DBUS_TYPE_UINT32,
 									&loc);
 
-	if (chan_alloc)
+	if (location)
 		g_dbus_dict_append_entry(&dict, "ChannelAllocation",
-					 DBUS_TYPE_UINT32, &chan_alloc);
+					DBUS_TYPE_UINT32, &location);
 
 	if (metadata) {
 		key = "Metadata";
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 23ea267f6446..e2073451cc7a 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -312,9 +312,12 @@ static void media_transport_remove_owner(struct media_transport *transport)
 		media_request_reply(owner->pending, EIO);
 
 	transport->owner = NULL;
-	if (bap->linked)
-		queue_foreach(bt_bap_stream_io_get_links(bap->stream),
-				linked_transport_remove_owner, owner);
+	if (bap->linked) {
+		struct bt_bap_stream *link;
+
+		link = bt_bap_stream_io_get_link(bap->stream);
+		linked_transport_remove_owner(link, owner);
+	}
 
 	if (owner->watch)
 		g_dbus_remove_watch(btd_get_dbus_connection(), owner->watch);
@@ -496,9 +499,12 @@ static void media_transport_set_owner(struct media_transport *transport,
 	DBG("Transport %s Owner %s", transport->path, owner->name);
 	transport->owner = owner;
 
-	if (bap->linked)
-		queue_foreach(bt_bap_stream_io_get_links(bap->stream),
-				linked_transport_set_owner, owner);
+	if (bap->linked) {
+		struct bt_bap_stream *link;
+
+		link = bt_bap_stream_io_get_link(bap->stream);
+		linked_transport_set_owner(link, owner);
+	}
 
 	owner->transport = transport;
 	owner->watch = g_dbus_add_disconnect_watch(btd_get_dbus_connection(),
@@ -962,12 +968,15 @@ static gboolean links_exists(const GDBusPropertyTable *property, void *data)
 	return bap->linked;
 }
 
-static void append_links(void *data, void *user_data)
+static void append_link(void *data, void *user_data)
 {
 	struct bt_bap_stream *stream = data;
 	DBusMessageIter *array = user_data;
 	struct media_transport *transport;
 
+	if (!stream)
+		return;
+
 	transport = find_transport_by_bap_stream(stream);
 	if (!transport) {
 		error("Unable to find transport");
@@ -983,14 +992,14 @@ static gboolean get_links(const GDBusPropertyTable *property,
 {
 	struct media_transport *transport = data;
 	struct bap_transport *bap = transport->data;
-	struct queue *links = bt_bap_stream_io_get_links(bap->stream);
+	struct bt_bap_stream *link = bt_bap_stream_io_get_link(bap->stream);
 	DBusMessageIter array;
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
 					DBUS_TYPE_OBJECT_PATH_AS_STRING,
 					&array);
 
-	queue_foreach(links, append_links, &array);
+	append_link(link, &array);
 
 	dbus_message_iter_close_container(iter, &array);
 
@@ -1280,15 +1289,15 @@ static bool match_link_transport(const void *data, const void *user_data)
 static void bap_update_links(const struct media_transport *transport)
 {
 	struct bap_transport *bap = transport->data;
-	struct queue *links = bt_bap_stream_io_get_links(bap->stream);
+	struct bt_bap_stream *link = bt_bap_stream_io_get_link(bap->stream);
 
-	if (bap->linked == !queue_isempty(links))
+	if (bap->linked == (!!link))
 		return;
 
-	bap->linked = !queue_isempty(links);
+	bap->linked = link ? true : false;
 
 	/* Check if the links transport has been create yet */
-	if (bap->linked && !queue_find(links, match_link_transport, NULL)) {
+	if (bap->linked && !match_link_transport(link, NULL)) {
 		bap->linked = false;
 		return;
 	}
@@ -1456,13 +1465,15 @@ static void set_state_bap(struct media_transport *transport,
 					transport_state_t state)
 {
 	struct bap_transport *bap = transport->data;
+	struct bt_bap_stream *link;
 
 	if (!bap->linked)
 		return;
 
-	/* Update links */
-	queue_foreach(bt_bap_stream_io_get_links(bap->stream), link_set_state,
-							UINT_TO_PTR(state));
+	link = bt_bap_stream_io_get_link(bap->stream);
+
+	/* Update link */
+	link_set_state(link, UINT_TO_PTR(state));
 }
 
 static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
diff --git a/src/shared/bap.c b/src/shared/bap.c
index af2cc1ef1eb0..078d308dc4c2 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -222,7 +222,7 @@ struct bt_bap_stream {
 	struct iovec *cc;
 	struct iovec *meta;
 	struct bt_bap_qos qos;
-	struct queue *links;
+	struct bt_bap_stream *link;
 	struct bt_bap_stream_io *io;
 	bool client;
 	void *user_data;
@@ -1010,14 +1010,6 @@ static void stream_io_unref(struct bt_bap_stream_io *io)
 	stream_io_free(io);
 }
 
-static void bap_stream_unlink(void *data, void *user_data)
-{
-	struct bt_bap_stream *link = data;
-	struct bt_bap_stream *stream = user_data;
-
-	queue_remove(link->links, stream);
-}
-
 static void bap_stream_free(void *data)
 {
 	struct bt_bap_stream *stream = data;
@@ -1025,8 +1017,9 @@ static void bap_stream_free(void *data)
 	if (stream->ep)
 		stream->ep->stream = NULL;
 
-	queue_foreach(stream->links, bap_stream_unlink, stream);
-	queue_destroy(stream->links, NULL);
+	if (stream->link)
+		stream->link->link = NULL;
+
 	stream_io_unref(stream->io);
 	util_iov_free(stream->cc, 1);
 	util_iov_free(stream->meta, 1);
@@ -1050,12 +1043,12 @@ static void bap_stream_detach(struct bt_bap_stream *stream)
 	bap_stream_free(stream);
 }
 
-static void bap_stream_io_link(void *data, void *user_data)
+static bool bap_stream_io_link(const void *data, const void *user_data)
 {
-	struct bt_bap_stream *stream = data;
-	struct bt_bap_stream *link = user_data;
+	struct bt_bap_stream *stream = (void *)data;
+	struct bt_bap_stream *link = (void *)user_data;
 
-	bt_bap_stream_io_link(stream, link);
+	return !bt_bap_stream_io_link(stream, link);
 }
 
 static void bap_stream_update_io_links(struct bt_bap_stream *stream)
@@ -1064,7 +1057,7 @@ static void bap_stream_update_io_links(struct bt_bap_stream *stream)
 
 	DBG(bap, "stream %p", stream);
 
-	queue_foreach(bap->streams, bap_stream_io_link, stream);
+	queue_find(bap->streams, bap_stream_io_link, stream);
 }
 
 static struct bt_bap_stream_io *stream_io_ref(struct bt_bap_stream_io *io)
@@ -1095,31 +1088,18 @@ static struct bt_bap_stream_io *stream_io_new(struct bt_bap *bap, int fd)
 	return stream_io_ref(sio);
 }
 
-static void stream_find_io(void *data, void *user_data)
-{
-	struct bt_bap_stream *stream = data;
-	struct bt_bap_stream_io **io = user_data;
-
-	if (*io)
-		return;
-
-	*io = stream->io;
-}
-
 static struct bt_bap_stream_io *stream_get_io(struct bt_bap_stream *stream)
 {
-	struct bt_bap_stream_io *io;
-
 	if (!stream)
 		return NULL;
 
 	if (stream->io)
 		return stream->io;
 
-	io = NULL;
-	queue_foreach(stream->links, stream_find_io, &io);
+	if (stream->link)
+		return stream->link->io;
 
-	return io;
+	return NULL;
 }
 
 static bool stream_io_disconnected(struct io *io, void *user_data);
@@ -1157,17 +1137,6 @@ static bool bap_stream_io_attach(struct bt_bap_stream *stream, int fd,
 	return true;
 }
 
-static bool match_stream_io(const void *data, const void *user_data)
-{
-	const struct bt_bap_stream *stream = data;
-	const struct bt_bap_stream_io *io = user_data;
-
-	if (!stream->io)
-		return false;
-
-	return stream->io == io;
-}
-
 static bool bap_stream_io_detach(struct bt_bap_stream *stream)
 {
 	struct bt_bap_stream *link;
@@ -1181,7 +1150,7 @@ static bool bap_stream_io_detach(struct bt_bap_stream *stream)
 	io = stream->io;
 	stream->io = NULL;
 
-	link = queue_find(stream->links, match_stream_io, io);
+	link = stream->link;
 	if (link) {
 		/* Detach link if in QoS state */
 		if (link->ep->state == BT_ASCS_ASE_STATE_QOS)
@@ -2485,14 +2454,15 @@ static struct bt_bap_pac *bap_pac_new(struct bt_bap_db *bdb, const char *name,
 	pac->bdb = bdb;
 	pac->name = name ? strdup(name) : NULL;
 	pac->type = type;
+
 	if (codec)
 		pac->codec = *codec;
 
-	bap_pac_merge(pac, data, metadata);
-
 	if (qos)
 		pac->qos = *qos;
 
+	bap_pac_merge(pac, data, metadata);
+
 	return pac;
 }
 
@@ -4945,14 +4915,6 @@ static int bap_stream_metadata(struct bt_bap_stream *stream, uint8_t op,
 	return req->id;
 }
 
-static void bap_stream_enable_link(void *data, void *user_data)
-{
-	struct bt_bap_stream *stream = data;
-	struct iovec *metadata = user_data;
-
-	bap_stream_metadata(stream, BT_ASCS_ENABLE, metadata, NULL, NULL);
-}
-
 unsigned int bt_bap_stream_enable(struct bt_bap_stream *stream,
 					bool enable_links,
 					struct iovec *metadata,
@@ -4974,7 +4936,9 @@ unsigned int bt_bap_stream_enable(struct bt_bap_stream *stream,
 		if (!ret || !enable_links)
 			return ret;
 
-		queue_foreach(stream->links, bap_stream_enable_link, metadata);
+		if (stream->link)
+			bap_stream_metadata(stream->link, BT_ASCS_ENABLE,
+						metadata, NULL, NULL);
 		break;
 	case BT_BAP_STREAM_TYPE_BCAST:
 		if (!bt_bap_stream_io_dir(stream))
@@ -5037,26 +5001,6 @@ unsigned int bt_bap_stream_start(struct bt_bap_stream *stream,
 	return 0;
 }
 
-static void bap_stream_disable_link(void *data, void *user_data)
-{
-	struct bt_bap_stream *stream = data;
-	struct bt_bap_req *req;
-	struct iovec iov;
-	struct bt_ascs_disable disable;
-
-	memset(&disable, 0, sizeof(disable));
-
-	disable.ase = stream->ep->id;
-
-	iov.iov_base = &disable;
-	iov.iov_len = sizeof(disable);
-
-	req = bap_req_new(stream, BT_ASCS_DISABLE, &iov, 1, NULL, NULL);
-
-	if (!bap_queue_req(stream->bap, req))
-		bap_req_free(req);
-}
-
 unsigned int bt_bap_stream_disable(struct bt_bap_stream *stream,
 					bool disable_links,
 					bt_bap_stream_func_t func,
@@ -5092,8 +5036,7 @@ unsigned int bt_bap_stream_disable(struct bt_bap_stream *stream,
 		}
 
 		if (disable_links)
-			queue_foreach(stream->links, bap_stream_disable_link,
-							NULL);
+			bt_bap_stream_disable(stream->link, false, NULL, NULL);
 
 		return req->id;
 
@@ -5300,7 +5243,8 @@ bool bt_bap_stream_set_io(struct bt_bap_stream *stream, int fd)
 
 	bap_stream_set_io(stream, INT_TO_PTR(fd));
 
-	queue_foreach(stream->links, bap_stream_set_io, INT_TO_PTR(fd));
+	if (stream->link)
+		bap_stream_set_io(stream, INT_TO_PTR(fd));
 
 	return true;
 }
@@ -5353,22 +5297,17 @@ int bt_bap_stream_io_link(struct bt_bap_stream *stream,
 	if (!stream || !link || stream == link)
 		return -EINVAL;
 
-	if (queue_find(stream->links, NULL, link))
+	if (stream->link || link->link)
 		return -EALREADY;
 
 	if (stream->client != link->client ||
 			stream->qos.ucast.cig_id != link->qos.ucast.cig_id ||
-			stream->qos.ucast.cis_id != link->qos.ucast.cis_id)
+			stream->qos.ucast.cis_id != link->qos.ucast.cis_id ||
+			stream->ep->dir == link->ep->dir)
 		return -EINVAL;
 
-	if (!stream->links)
-		stream->links = queue_new();
-
-	if (!link->links)
-		link->links = queue_new();
-
-	queue_push_tail(stream->links, link);
-	queue_push_tail(link->links, stream);
+	stream->link = link;
+	link->link = stream;
 
 	/* Link IOs if already set on stream/link */
 	if (stream->io && !link->io)
@@ -5381,12 +5320,12 @@ int bt_bap_stream_io_link(struct bt_bap_stream *stream,
 	return 0;
 }
 
-struct queue *bt_bap_stream_io_get_links(struct bt_bap_stream *stream)
+struct bt_bap_stream *bt_bap_stream_io_get_link(struct bt_bap_stream *stream)
 {
 	if (!stream)
 		return NULL;
 
-	return stream->links;
+	return stream->link;
 }
 
 static void bap_stream_get_in_qos(void *data, void *user_data)
@@ -5394,6 +5333,9 @@ static void bap_stream_get_in_qos(void *data, void *user_data)
 	struct bt_bap_stream *stream = data;
 	struct bt_bap_qos **qos = user_data;
 
+	if (!stream)
+		return;
+
 	if (!qos || *qos || stream->ep->dir != BT_BAP_SOURCE ||
 				!stream->qos.ucast.io_qos.sdu)
 		return;
@@ -5406,6 +5348,9 @@ static void bap_stream_get_out_qos(void *data, void *user_data)
 	struct bt_bap_stream *stream = data;
 	struct bt_bap_qos **qos = user_data;
 
+	if (!stream)
+		return;
+
 	if (!qos || *qos || stream->ep->dir != BT_BAP_SINK ||
 				!stream->qos.ucast.io_qos.sdu)
 		return;
@@ -5423,11 +5368,11 @@ bool bt_bap_stream_io_get_qos(struct bt_bap_stream *stream,
 	switch (stream->ep->dir) {
 	case BT_BAP_SOURCE:
 		bap_stream_get_in_qos(stream, in);
-		queue_foreach(stream->links, bap_stream_get_out_qos, out);
+		bap_stream_get_out_qos(stream->link, out);
 		break;
 	case BT_BAP_SINK:
 		bap_stream_get_out_qos(stream, out);
-		queue_foreach(stream->links, bap_stream_get_in_qos, in);
+		bap_stream_get_in_qos(stream->link, in);
 		break;
 	default:
 		return false;
@@ -5438,14 +5383,6 @@ bool bt_bap_stream_io_get_qos(struct bt_bap_stream *stream,
 	return in && out;
 }
 
-static void bap_stream_get_dir(void *data, void *user_data)
-{
-	struct bt_bap_stream *stream = data;
-	uint8_t *dir = user_data;
-
-	*dir |= stream->ep->dir;
-}
-
 uint8_t bt_bap_stream_io_dir(struct bt_bap_stream *stream)
 {
 	uint8_t dir;
@@ -5455,7 +5392,8 @@ uint8_t bt_bap_stream_io_dir(struct bt_bap_stream *stream)
 
 	dir = stream->ep->dir;
 
-	queue_foreach(stream->links, bap_stream_get_dir, &dir);
+	if (stream->link)
+		dir |= stream->link->ep->dir;
 
 	return dir;
 }
@@ -5466,6 +5404,9 @@ static void bap_stream_io_connecting(void *data, void *user_data)
 	int fd = PTR_TO_INT(user_data);
 	const struct queue_entry *entry;
 
+	if (!stream)
+		return;
+
 	if (fd >= 0)
 		bap_stream_io_attach(stream, fd, true);
 	else
@@ -5487,8 +5428,7 @@ int bt_bap_stream_io_connecting(struct bt_bap_stream *stream, int fd)
 		return -EINVAL;
 
 	bap_stream_io_connecting(stream, INT_TO_PTR(fd));
-
-	queue_foreach(stream->links, bap_stream_io_connecting, INT_TO_PTR(fd));
+	bap_stream_io_connecting(stream->link, INT_TO_PTR(fd));
 
 	return 0;
 }
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 9be198cec72c..51edc08ab1ac 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -303,7 +303,7 @@ int bt_bap_stream_cancel(struct bt_bap_stream *stream, unsigned int id);
 
 int bt_bap_stream_io_link(struct bt_bap_stream *stream,
 					struct bt_bap_stream *link);
-struct queue *bt_bap_stream_io_get_links(struct bt_bap_stream *stream);
+struct bt_bap_stream *bt_bap_stream_io_get_link(struct bt_bap_stream *stream);
 bool bt_bap_stream_io_get_qos(struct bt_bap_stream *stream,
 					struct bt_bap_qos **in,
 					struct bt_bap_qos **out);
-- 
2.43.0

