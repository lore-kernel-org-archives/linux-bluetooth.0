Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349162;
	b=2WHl7Fxbw308EtZngwKZGzNIgk5Pi3HhzMeGvkqdqihyzu1jR7mrfy1muWX5zwTuQcZZ
	 xQdo19YIEOkXY+9ea5SQTVE8yK60mvWCLe3AZUDlRuSLGtiM5V2z+bWG6VKC3asaUzKAx
	 LBXbxAtsuemNOjtbdKQxTdMtg7BqyGT4P/QSAhDtUjCSu3UYeqa3AcgcwsTtNMd+TO17u
	 3TRi3yZ5xHRj0Tuzh4ETlAFHAqDMNh4a8oFUKvpw403CWSQBz1sl62NbEXMoUbye89tkv
	 I+ZoWmfissci5I3UCCowWU7Ta+1ETRgt35HaOZT1g1iiCBD53v1nVKGAHyzRlsjvthA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349162;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ypQP58dGdZwAUZWvo5YvBVsCzrtheMxnmOc7XIigqec=;
	b=z/ovVXRvrzhpxZ2RtcJuwF0iFLyjbDKMlsWY/yfPouuzkcXY+cPJpeQKrJmoYUZ9YotZ
	 46wRcciUF2tjXzoZZRPWj3sh4GKtrSmoKMsUK3zYkYueJ0PQxMlai/X6PthYDTmvYWYDW
	 UdlEbG9PqzLjfkELYF44Mh5gV1Em7rJNCN1q3JybRbvh/WHPmvMaFeWIkIYgtr5VSY3nn
	 7teqjIMKMpy2jKfz2u4SSuPTZstxQ11LpCh/xFPPxD0vFemrwCJoPwVXBG9Jcbek+E0rh
	 vCNmQCwjG/G3HEfHk1mQV6eNu7+Us/DwYeZxmTeHPnC5ZJquC8beN4f8Dzdf71OWrYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d+sP4ztn;
	arc=none smtp.remote-ip=209.85.221.180
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1887E606A321
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 22:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1887E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d+sP4ztn
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5eafaeb8684so834349e0c.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 14:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794349161; x=1794953961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ypQP58dGdZwAUZWvo5YvBVsCzrtheMxnmOc7XIigqec=;
        b=d+sP4ztn5R8/wyS8aAFuMVoBsAy3pjqxgjYqMJpuorjK4OFxZFpCjZAe2rY3Vugvq+
         +VUzkQMecuXzDanygNz8F+/v4qEBDosLjy/UwYjMrpO98iG/H/CFIqxzOVYH3/lrf1Nc
         SrS3XNG/rBMAGsv/lW2pNChSaMHAAcMEKjnABcHlxf1kb1Oz8d96nEMq9yP8KmrnKQMo
         88aLqKemdMW6FlFw5pT3ze5/MnESYS/2FImRqNuXajswSZys+DiT4BjvR3nt1R00Nxi3
         rzVuffZyswjxlbf/w2AlL2b+ySaxgCs8e9rCiuaj/cV4Om8EEcgHy3fwSUz494qcCMa9
         iE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794349161; x=1794953961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ypQP58dGdZwAUZWvo5YvBVsCzrtheMxnmOc7XIigqec=;
        b=mOzOAh0u7W/zBp0R8Mtk3hE42VDRBJYVnTOWPsWJCur79QTeZTTnkhnX+HGvWvUL7A
         jQV2QdhK5ojerf9X6QDW78gyBY+JG+tW4ML07KIUOy6AcjW1Ft5A5bDsS/C16Lk8dLc8
         hAUDRutm7y73OZDxrAbSPkHmr0DdThmt630jI4CFtIDDdKgUuvIukzUUNgwhIjRI8Wkt
         EboxjJ9XLtP0yDksn7IbHpPz76qQJbvitgtHefBgnLT5+Thc4hkkAN8UULXW22Xys9+j
         OBtoyHvYnW8v5GpFvDVxtfjcxWvKukVriM188IOVzR3HktgfEiBCWyu+7CsnbCbkaZ4G
         P/Mg==
X-Gm-Message-State: APuU4Z9tmOvwcuTvBLfG1twvBMZo5A0tsGXCNrHjeG1wuA5yEcY75Aac
	ejDG5KSh+XzbwcoozG0w4yHkHNpnCQTxl2AlqHraCYz3mSCKGxbVfidByYwZ0g==
X-Gm-Gg: AYBFou0LTJmqgUnKs5N9b8fZW98odQjkBoV/JtmfZvMI5aGvIIZ5NxLaFkal+ILqixv
	f5iwQicJ3G+i5ozO17MkzN+Lv4P9O3N8MkugcKysFIS96mfnf2CjD0C8a53721Ozr3lN6Xe5Tfo
	oxngnftAg46kaSVmJGyqYzIIow3/yKSBAHPFl8kqtklMZZpUHD+u5xWaVyXnT1LS85KkmdFjThv
	3x0qXWMrhJgXzjgbK+bn7UmejlVwD3h2yHeMhflBcAadMR+z2gkw09uNgXtyrEHUuq8Io/GvPL/
	xsOqOijv0YZnTLo3DXph9hJFpBsfmzk4aV29IrBiSSfX3qhQa2LPcAa7luif3ARDhSJGbx4LjBg
	K5gMK3ZNlsk7CHplIpqiUWU9QrNfFk9LnLbRnmKTs2BExprwV7N/1AGM4BGmSAjY9znbQUYfsND
	h8apUJhpN28zqU1LYGvAXg9sNWm6hDj3SD2P8iyrhvue86HRs21cntO5OUwnV8E+H2oh+vocACx
	93FwSYVxdO5F4yPEI6TCyaqX3/evIqBD+EOmVzSmfHrDWkD7qJWyUFfq+8DPnzGrOUvEemYIadi
	5ByDz7S2H9CoUKMzh2b3qVMEIhmBmEVJqyx2HpBuNPrPmXQV9azXnHqVHirq7xhK0KTIGKpQ6kC
	GZ9brKIsh3E+q7+JzGVUn0h45pqM24mFPGMOd92yvLvjXcpgSVhKCvS7XwPCg/iplcv/xiaOWCo
	+jSd1khyQQOpOkGnGB5RAz9q9/
X-Received: by 2002:a05:6122:32c9:b0:5e9:6d96:a910 with SMTP id 71dfb90a1353d-5ee1c2a4ef8mr123834e0c.3.1794349160879;
        Tue, 10 Nov 2026 14:19:20 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c58ed55sm2605244e0c.5.2026.11.10.14.19.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 14:19:20 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/4] shared/bap: Don't disconnect a CIS still configured for a link
Date: Tue, 10 Nov 2026 17:18:59 -0500
Message-ID: <cf1162f2dff21a8b179eacec6f6e3d385dfd8a28.1794349049.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794349049.git.luiz.von.dentz@intel.com>
References: <cover.1794349049.git.luiz.von.dentz@intel.com>
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
index 8cb7fb40f16c..dd4e9e775bb0 100644
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
+	if (stream->io == args[0])
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

