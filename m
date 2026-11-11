Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414337;
	b=E9ooMbZdGe2CBN0gD4B9wet0yU+FkC2hOgr6LqYgCkMcNJaivbTgK8xvlrTNov8kyGXR
	 s6TMZLPHuC2ZbdpKx7Xf/6391/eoy6XZbHmxkAZY18U/O37gSKAODzRZqqO859MfRagZo
	 9gHnn0gTmOzeE5jgh1E93Gw73ViKQBW08BBt8cOELnbxv1/0OnBDi+N9K+AJniKSaYUjO
	 3CilN/qHaxsh0o1tCvIpwX1WuZeuNG9vyx7JvmFAcI6oNwx53ysEqmahy7EQyPEXlYOK3
	 AmfEb8oqQ6/SIP4ixOxCPpo14ELiYdJZKBuQOEyNBTjuz/lypy6Ga5NKKc+snTCuZrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414337;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XFD9KGI8cw6W7ce/Gvc6DTc1chENiY3sdh6ryJGko38=;
	b=lDaLyLhBGRLprurGYSfENBZeWDGJc/BznawNyl86uBdDownS1IsbqiBXhwhRFlRGBBEB
	 WweqlP41XxAHuaTxm1rdpOdHGLJGbPgqj5/yjvgktGpZs51dFfzBIu8pXu4Jg5sZkv/Yw
	 stbw3eGCE8oB8wBHXC3RwUftbSDNTFHyNw06s4ESG85trVnJLtMs4dv1hGRd+GwoiBZvo
	 q1tL8weLxEHqfmgUlf8Bnb0OXL317Xn8sBpxH4ucsaLFlNope+/qY21LDqljUpkNDuSQp
	 HqKOVZZPYzzYZ+eHS1ZlmlPXqmd9CNV9aBV8ugnBQJR1DQUPq6ANdVEWNwwyNWNzl3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hl6oOmvo;
	arc=none smtp.remote-ip=209.85.217.49
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B85B606A324
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 16:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B85B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hl6oOmvo
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-7cc91ddf447so1329623137.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 08:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794414336; x=1795019136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XFD9KGI8cw6W7ce/Gvc6DTc1chENiY3sdh6ryJGko38=;
        b=hl6oOmvojX9zBI4jXASmrZwXcd9adT67dVlsFTEUFTt64srPZFXkOc6O5BE+mEQO/4
         3C1zzUMjCjK5c6sxQDjyovKoLDsVFEFPguQbSJSykmGlkIIWu+BVu36Hdg60uv7F/D/R
         TMeeBywQ7wfVne72VKeK1+a70ZM0ndkW//UccYj23TLvtnPZheo0n8v7G6mhT9Mdzegv
         dgQ0/Z/bx70PGrOl3RoIJt27n3UDEVP381n/6aCZNKV/goorfhGD9m1feWe4d3LTw7iw
         SjduQjkvBJVZ5i8iDio8II4ofi0ZPrEUmveIqv8XllIABLhXY2oRUaACJHz2eybzgSiz
         GDew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794414336; x=1795019136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=XFD9KGI8cw6W7ce/Gvc6DTc1chENiY3sdh6ryJGko38=;
        b=rgKAJSUWsfUi3sm0K4yzkvN2NbYATJJIXvCKcIbWLe/FwpkCmZnRDVR5ofBj6WMKAC
         YFJJS668qQ+w6Q3w3nJ6Vsf5+jdfzn6rdVjjy6W7Ye/vyWbrK5vQ1npNnbO8qmie5+zz
         WA/MOoYGEIp+yuFs/4YeQ8sLqiyHp6gK+GfzfMZvUnUkE9d0oQV5f6/elliB5E85AHbY
         y0OuAiJ49rs6LuL6MZJss8gyjQ3Yfz+Lk22U4Q8+HcrRY9uxPUY6owV+1EujwVNroaBu
         Rm5vREBgb+yGDQXAxMbEW/j+EvLiE1Sk7gsDsayfTeA/wiWIA7JDWiZOZyad/IhzmWkV
         tFBg==
X-Gm-Message-State: APuU4Z+SCrh83cN+AKrTccj/caH6OGyUm3R7zMDGFAYQh6TuscxDHtx7
	sU7h5OS+wNRK2M2sUUvUpWGuvFLtTPYgtCj+YxOGG4uZnRR4zyVXVF1tz/JiLA==
X-Gm-Gg: AYBFou2MakY//wUh374hyQM7PxOBeBhsfqKY1ygCYGKw7sXqZ5w/ZjaopcY8jWEQ2M4
	KIhNabqQZMXoeG506PN043+ysN5wftMfzCVuQ6g22dzBehxXy+1UrR248wvCJKlpBDbhuta0KuO
	va0IzlqR7R+W7YaKCEtAbZFJxbjJ3tZX1jWZ6wCecb6aSiAQqqkKS8M+Xb49L2OYnLnlHGV9Oan
	Op0u+CvBiuNedkKRasRR+44WAgFuG3+jhfIhH9p3Sqhfr2M3ebhJYYH97sGhA4uw1N27Zbob/tU
	SfKUCunnrVZGrtrB+8BF6D8UPVHQxnMCg0wLrcLR2spS7m53gJCnBEHOQLExGhmntK6uovp3U6Y
	1nTtn+I9EwCUeRTFouIFavDQvE3f++JahcTp+3JqgdZiJ2fGUZAwfdc53qcI0GgAV1+8xeHfk8P
	MBmayvEYGlbLipOMpnnSebHkd+ads6B6tGVl5MUUuSILJBpjiZvoPPbIFOR3EeCTG95RbmZlxFj
	wRNQyoKeLC6WUqLT0WLD/lo7dnCsfMS7mSZkTa3i6dGxjseV5ffp32lokyS1Hpy4ALIR/C3+4so
	B42unlJ/1EFi2gDI7t2s8drbghDBLWbSfvCVtcnBEDnWINskV9+EDgeLFQDLTiWDsZcL4JeO5XC
	/RbU+AJCbaFmB/DOe1nmlVl8AXJcH6T1uJ9oLuC6VMqi+LIYW7pyiGE4eJNTqu+/WKr6FD6F7vb
	QAfych
X-Received: by 2002:a05:6102:604c:b0:7d0:3ed0:c61c with SMTP id ada2fe7eead31-7d4fb298d1bmr886011137.16.1794414335875;
        Wed, 11 Nov 2026 08:25:35 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c200004e7sm4269659241.3.2026.11.11.08.25.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:25:35 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/4] shared/bap: Don't disconnect a CIS still configured for a link
Date: Wed, 11 Nov 2026 11:25:12 -0500
Message-ID: <af87abeff291ce358c4f4414c3b1aff9565f0bf2.1794414122.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794414122.git.luiz.von.dentz@intel.com>
References: <cover.1794414122.git.luiz.von.dentz@intel.com>
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

