Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794429467;
	b=X+wEai/m3Q5WkUvkoNWsFXnesQV9CZ7ijiZlfXAab2XNTAWyb8OouKrQadXGesFZa8hi
	 VqP7KW7EowwfoHBztXCz0dzcdDQ2h/o8iaZpOKHta23Cc7nqwdPJAe5kPEk5T9BgPHyP0
	 v6OLa0gsFUZKWDxspcuq1Fd8uwP9vD3HNXI9Ccl6ZAJQUndh1My2cB6GtGmpMRiDCbjWy
	 6CdmA/KDW3kRV1f/eWv5w6RX7eHVPhSY4RwCmSioqnx/nw4koOHlwhs74qbfZztwCw0nm
	 rgDI2MqbI1iZOUa7mXuZMrFENOAOTlLcH1OoiNsYfIAdC70gX60ckqWEdeP/2Rz0TDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794429467;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XFD9KGI8cw6W7ce/Gvc6DTc1chENiY3sdh6ryJGko38=;
	b=LypifkADeHo2wr9cIl5zWQ8wXiPoZnGbSzW3EVREFx4FZhVI9ftm0AqsN28xjh1Ipzq9
	 ERyPoJiRo8a3NGD70LMKnRxrX3MaTaRqBMPneFJfx+meNaLI4NZ32/lw5Qv0vX+z8ePnt
	 X/4bJULiV5qrGgwFWVpISiv/f11WLC0ToNtRU39Pdi8pymPuYGZfiFDLEomv4u3zQMA48
	 09okmx9AYKNiEt0wmXiC6fBdu56SJfaPxuuz+b48DOxrHpmuy/V0SJ9c+/tAXJTeYX9hD
	 aUvIWk5FoxkpcD83HhNKyKwVBWI5tB6gStoL3zoai4B/yQNcJ85qHEKMV1keuNP3RmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Xt/KxyL3";
	arc=none smtp.remote-ip=209.85.217.47
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09426606A8B2
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 20:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09426606A8B2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xt/KxyL3
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-7cc1cf48a39so1389228137.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 12:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794429466; x=1795034266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XFD9KGI8cw6W7ce/Gvc6DTc1chENiY3sdh6ryJGko38=;
        b=Xt/KxyL3w5KgD5gaqq2y3h6Ej6zKduvJdG3LvJPOlR77HSkyu4KrmuYihPAqE6zOKC
         AZrC1LCil2dzZ0GYKRxxesTauoD27dkeIOqZ6oLSFZ06x/ZMlZ49E0Z8gCwj+zJcXY9Q
         H3SPBZCc9tgkXSUm2lsFzPuu9rnVdUj9XlbXz/n/olwk7RVAbujMeiEFy8qHaohwhpsJ
         nlMc6z6IdVnNfgElmJ03+c9tE1/pQTKWAU+LdUhpen5O6cQAHYSCg4yijpm35tEAyMv9
         etzf57R50Ih469ioSJlyI95msmphrY2C8zBf/Awkebi5v8+OY4fbOrATEVUZbeKoNw4t
         H0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794429466; x=1795034266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=XFD9KGI8cw6W7ce/Gvc6DTc1chENiY3sdh6ryJGko38=;
        b=CScmmSzEVfmEqwOLUINeSSrPPl2vTpsuBN88KqjS7oTUwpw4nTE7lM1yRW6HpMKBzR
         OXns3h6F+o1G6WUyF4yr9erC2P+NWgKJYL3NK+LlGTDx+TBt23yeBvoN2RJglZ6WQY5v
         29LW2VH0+hbrxWmFQLR73UW/OBC49I3S57UOltErmRmvtJafvhzCKHW1n/c6mTaTjjDN
         LTdH1y6DjDb5IC6keoKiu3YZfp0h8Mftjk30gLkYt3iiSWCXCfJS06505JjhOwgZzFKf
         PzaLXP4AZ+qnbdV9YqhJ4lzOxjctg8G+TSmcm6NVNyn3b29E9SFomopNPydVGI1pEDOR
         EVxw==
X-Gm-Message-State: APuU4Z+BPA/agFe7A/NzY4xgN0EcE9IZhSh7tx1vCdL2zSlWx7yMSBNE
	O19+xJ5zCQETCzJQPyYJnFneCkFZvgI3GhQQjTBGzls49BoftlaEmW5eKE4CLw==
X-Gm-Gg: AYBFou352bEOdN5HC3qgqnJKo4QK+7zlU6DUHHST1IRh3kt6atG2OI4kiN71B6J7OkZ
	pigbEi5BIZOlAeGm3k+4OHKmCrGYohcwfLXSFwrMy9VMTnhC46+320JDv9ioUpQwMEPr4UtJTyA
	0gKWcmk7b1Cv2JGrBF85E/49fePsfrNNwskaw4RN+IwtlPe5Kd/7dkobrywwHKICdzw24xcPQNj
	b3yrDjwzZtGcW4sRe300T9CmlZIIQ9uDTlxGqKpBO8UBSFpcwQ4udSTQ0deKKn99SJhQsn9wVuM
	hl2Km10gbsqPysnbxKt954ObaUW/n2CN26RFkz1YbLGpaJz4BLbJY6YpEc5NUarXAw9Y6uydjhd
	Cbf9iKncdVyoh3NlVZR3l3b/V1W6iWz9MweC6kI7eg8UlL15aeX1u+Dn5idVdml+4A0yP7V7m07
	lHc4lML4lFtNqPQSh6YFZbMKcGxbpmB+Ey0EqbXEbFTv4X2zKfO4C5wCr6veStTeEwOO6BaggV7
	0WbkK0c0SecII34Z7muKlE4K7vOg9X0rglzigkwdXn8d9bVmBCV37FNp6J3MV7PBWok7HzNx0Ev
	l0vj+TmpeNLBtiF4mF7cEQJoHZUwgn+PQV7X4F1yBjRsX8PLavPU2E+W/VOZLMCm7cwl2Pu50aC
	sFR8QoTBWDfbVq78u04QAleusGEwin6V9CgpO4a4W4+GujkdGa+zs2YK9DGtatfF5TdPCrSB8m4
	XvaBc=
X-Received: by 2002:a05:6102:374b:b0:7d0:3da9:3e16 with SMTP id ada2fe7eead31-7d4edd09970mr1148220137.3.1794429465787;
        Wed, 11 Nov 2026 12:37:45 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d302359221sm4762571137.6.2026.11.11.12.37.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 12:37:45 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 1/5] shared/bap: Don't disconnect a CIS still configured for a link
Date: Wed, 11 Nov 2026 15:37:22 -0500
Message-ID: <af87abeff291ce358c4f4414c3b1aff9565f0bf2.1794428234.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794428234.git.luiz.von.dentz@intel.com>
References: <cover.1794428234.git.luiz.von.dentz@intel.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When a stream was detached from its CIS, its link was detached as well
if in QoS Configured state, which disconnected the CIS. As a server,
this happened as soon as the client disabled the Source ASE of a
bidirectional CIS, while it may enable the Sink ASE right after over
the same CIS, e.g. when a phone switches a headset from its microphone
to its speaker in a voice call:

  > LE-ACL: Handle 2048 flags 0x02 dlen 10       #1155 18:59:04.179316
        ATT: Write Command (0x52) len 5
          Opcode: Disable (0x05)
            ASE ID: 0x03
  < HCI Command: Disconnect (0x01|0x0006) plen 3 #1157 18:59:04.179773
        Handle: 2304 (LE-CIS)
        Reason: Remote User Terminated Connection (0x13)
  > LE-ACL: Handle 2048 flags 0x02 dlen 17       #1164 18:59:04.201326
        ATT: Write Command (0x52) len 12
          Opcode: Enable (0x03)
            ASE ID: 0x01

The client does not establish the CIS again, so the Sink ASE stayed in
Enabling without a CIS and its transport never became pending, leaving
the speaker silent.

Leave the link attached, so the CIS is only disconnected once no
stream uses it anymore, by the client, or when it is released.

As the IO may then outlive the stream it was created for, its
disconnect handler no longer keeps a pointer to that stream, which may
have been freed, but cleans up every stream using the IO, e.g. moving a
Source ASE releasing to Codec Configured although the Sink ASE also
using the CIS was found first, holding a reference to each of them.

Fixes: b798cec4ca62 ("shared/bap: Add initial code for handling BAP")
Assisted-by: Claude:claude-opus-5-5
---
 src/shared/bap.c | 84 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 59 insertions(+), 25 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 8cb7fb40f16c..37d14bd77c90 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -1564,20 +1564,8 @@ static void bap_stream_update_io_links(struct bt_bap_stream *stream)
 	queue_find(bap->streams, bap_stream_io_link, stream);
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
-	struct bt_bap_stream *link;
 	struct bt_bap_stream_io *io;
 
 	if (!stream->io)
@@ -1588,13 +1576,10 @@ static bool bap_stream_io_detach(struct bt_bap_stream *stream)
 	io = stream->io;
 	stream->io = NULL;
 
-	link = queue_find(stream->links, match_stream_io, io);
-	if (link) {
-		/* Detach link if in QoS state */
-		if (link->ep->state == BT_ASCS_ASE_STATE_QOS)
-			bap_stream_io_detach(link);
-	}
-
+	/* A link keeps the CIS, even in QoS state, as it may be enabled
+	 * next over the same CIS: it is detached in turn when it is
+	 * disabled, released or the CIS is disconnected.
+	 */
 	stream_io_unref(io);
 
 	return true;
@@ -3215,7 +3200,10 @@ static bool bap_stream_io_attach(struct bt_bap_stream *stream, int fd,
 
 	io->connecting = connecting;
 	stream->io = io;
-	io_set_disconnect_handler(io->io, stream_io_disconnected, stream, NULL);
+	/* The IO may outlive the stream it was created for, as long as a
+	 * link uses it, so the handler looks up the stream using it.
+	 */
+	io_set_disconnect_handler(io->io, stream_io_disconnected, io, NULL);
 
 	return true;
 }
@@ -7279,9 +7267,21 @@ bool bt_bap_match_bcast_sink_stream(const void *data, const void *user_data)
 	return stream->lpac->type == BT_BAP_BCAST_SINK;
 }
 
-static bool stream_io_disconnected(struct io *io, void *user_data)
+static void stream_io_collect(void *data, void *user_data)
 {
-	struct bt_bap_stream *stream = user_data;
+	struct bt_bap_stream *stream = data;
+	void **args = user_data;
+
+	if (stream_get_io(stream) == args[0])
+		queue_push_tail(args[1], bt_bap_stream_ref(stream));
+}
+
+static void stream_io_lost(void *data, void *user_data)
+{
+	struct bt_bap_stream *stream = data;
+
+	if (!bap_stream_valid(stream))
+		return;
 
 	DBG(stream->bap, "stream %p io disconnected", stream);
 
@@ -7289,9 +7289,9 @@ static bool stream_io_disconnected(struct io *io, void *user_data)
 	 * and PA Sync have been lost so switch to idle state to cleanup the
 	 * stream.
 	 */
-	if (stream->lpac->type == BT_BAP_BCAST_SINK) {
+	if (stream->lpac && stream->lpac->type == BT_BAP_BCAST_SINK) {
 		stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
-		return false;
+		return;
 	}
 
 	switch (stream->ep->state) {
@@ -7304,8 +7304,42 @@ static bool stream_io_disconnected(struct io *io, void *user_data)
 		stream_set_state(stream, BT_BAP_STREAM_STATE_QOS);
 		break;
 	}
+}
+
+static void stream_io_clear(void *data, void *user_data)
+{
+	struct bt_bap_stream *stream = data;
+
+	if (bap_stream_valid(stream))
+		bt_bap_stream_set_io(stream, -1);
+}
+
+static bool stream_io_disconnected(struct io *io, void *user_data)
+{
+	struct bt_bap_stream_io *sio = user_data;
+	struct bt_bap *bap;
+	struct queue *streams;
+	void *args[2];
+
+	bap = bt_bap_ref_safe(sio->bap);
+	if (!bap)
+		return false;
+
+	/* Every stream using the CIS, e.g. a Sink and a Source ASE sharing
+	 * it, has to be cleaned up, and their state callbacks may release
+	 * them or change their links, so hold a reference to each of them.
+	 */
+	streams = queue_new();
+	args[0] = sio;
+	args[1] = streams;
+	queue_foreach(bap->streams, stream_io_collect, args);
+
+	queue_foreach(streams, stream_io_lost, NULL);
+	queue_foreach(streams, stream_io_clear, NULL);
+
+	queue_destroy(streams, bt_bap_stream_unref);
+	bt_bap_unref(bap);
 
-	bt_bap_stream_set_io(stream, -1);
 	return false;
 }
 
-- 
2.56.0

