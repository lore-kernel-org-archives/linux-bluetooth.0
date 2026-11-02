Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793656509;
	b=u0V8EBcK0FK7wBGrbl7IibEcKSgUdQ1N1+2Ljapfquj3u+m+7Ef/4IO4UzYys/SqRnHm
	 in9Ilqi8x2rN4Xgs3dcLmA25Hf/fAoyNvlu0Hs9YaMVxdcEjjvlWt0XL2I2u9et7SG8AR
	 DUA9g/KCHQC+XHjyi87n5ETCuDjLZx1SIVRwX+eRmTepNCvfkJzcyqzW57gl9plcOFDyD
	 OL6FVJmxfGxOOobrRPGKuDLN8ErUo58yHlTkLEmh32d6XDTwg4UQDynk/H4RhFBBxhyst
	 t7x03kIWVTmGNB9L21tzYEXb7SgBxtkqaXLMETH2GaBTp9smO+ddK+HGlcUz89oSV8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793656509;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6ZVut38ouwMV5om1iLjhLyY1lQP7Z+1lr4THlAMblYo=;
	b=MhptTXyqTQnfsFn6CSSgaKItrpOqKgcFS7gIlLIYWqXVHjRxlfXhRBJ5E1I1Vp6B9qvf
	 MlP7RxqSezuNB3mDAk5Pg0Ag5oqBQM79gAFkMSKQa0bHUM+CqoYTyd34Op37/WFZNJsdL
	 to6vviUUZS7hcidmr8dJcXZbzHl0MWJboXbLih/v9g60nEhn6wEw8NWZ5halBq3WxbINn
	 hFPM1s8TVcNdwMaA9zFUpuvX/orbMPAojNAv26zs/khIrip+ea1I9pIXS8aTKqUQZwEs8
	 JlIdcFFkoEwhioxx5m6npfJiTfMzu+Xm7XvFt8xRksP1NiZ6kvRi6yhzpwikabaXdYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GnJexzTN;
	arc=none smtp.remote-ip=209.85.222.49
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2941C606A32D
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 21:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2941C606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GnJexzTN
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-988bb309c2bso2271060241.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 13:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793656508; x=1794261308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6ZVut38ouwMV5om1iLjhLyY1lQP7Z+1lr4THlAMblYo=;
        b=GnJexzTNGWJaNPBWTD6ahBPjkceh9MKtfAV6Ru+EKL6HJunPHgEu9VYVEzJUZvzVga
         Ap3xcuFFgmrPX5NBwp4XfOx++bYCNWgXD6t4Ee1jVfDdGjfdRzI2+26UqtlEs2GaqXZY
         Xt35K5Evw1p217s2qM/j5duWs5ASjOuQNpB/1VarZSTWpSVR++RPbCBsrp7QDr1RIGAh
         qL34acIOVuc1TRT2bqzjPky+079arrBg90g1Qa26t3k+aKtX6aNskIL3/lvmkY1GtQ7p
         NIAbqdc20wn9ZOGBq5vu7f2muq4qgTfxPYlqLBlzaxwzSE1UPbk62B5BzPog9UszInW6
         DYnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793656508; x=1794261308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6ZVut38ouwMV5om1iLjhLyY1lQP7Z+1lr4THlAMblYo=;
        b=zfv5GR2X098BZlcGGtia6bLUNLTfiaQ/zfMVPCFY29chzJgwgzYOlMLatEOWAPgcAb
         R8Nfmyh5EFlyZz6B/evgQ+gkeSDXgvs57JgSN3WZVL5LNd5S2MQosOV2Wor/1vGifyhx
         9nII3Y2ZbTK/W0cIKvguOfU4vWcngNR4UUURhkxeOAv6WNYiwy4GWFpBwtJNpSqP5gLM
         xguCDbrNjbz3VZsbwRm1kepHyWzi6TIzR1pznaJv+c0v6+Ru6F/iZEzOjJW3U3wdVhFe
         2Gb7/JshblFnpiSsNqOkQH0V4g2cfyydpDiDduNi5C9QB36EcsMS2sFu2Yws/r4CuDoc
         pgvw==
X-Gm-Message-State: APuU4Z++oGJjjK9HQqdW3hyrGrLXANOEuEhEieoHdoeq4PE/aLvxQToo
	9BPnte+7o5w5pcE4O2tJ9Dng77aKFx5+Y0svaTkexevsKDtG1XkQUnuXCymCNimH
X-Gm-Gg: AYBFou2mUc/mXuT9hnDKD/rmIgn4HFJhA+15oH2ABAlAipi9F9iyQ3LHjBj0SO6RF74
	tnKvOCtHUxj1kPq53z8OqdPkqMYo8QnMCl0FFWwUlbTnfocO7mibkGNc7r0VlXSIcNRF6u7WeoM
	JNojseBeemUHd7cIj+oAdU4TletrvZk/y7GhFmm7gSgBeKhQ/jGoZM/F+3GfN3jFVfjJSF887S2
	XWX7ISusqTLZ7Ml6WqLgOXc7gNSfSHh5/53q0fFY8yCG/nPNSdOFBvfLDAzxkFHXQ823krk7MME
	L11us00rNid7yxysunlHvrzDX5FtvLwGFjqqaf7v+LIfRqVXalkRe5R9cYNWbL2GdPRSJg9W/DT
	xnGQYqfYNPgUtZ9nQoaI/3xcsqgt+fuZrQfjh/u3XwowoGV15eEk2uKxWZdhMwwqJvA+wPEdGok
	LgGDgNRqR1fVE2RJRre9kqsBn7lGq0dZ1WCKRcX0A5FuWUHUXiBkKewh/MiK4aUpddqJ+InsLhJ
	FqKFy38h77QqJNfWH45p0+jkQyih7gqidby9awyhgK7EB/sP3c+q5CuYf1ss5Eyy25vP78wmIG2
	ss3mlfbuxBYkJGBBJJb1ubRDvXOZNjTyw+69pMRMrqA1RT5YmbHhrguKRXkKAkMLhUKPr+aVj99
	7Jf3nM9BNVEc+XNGfFYTC5KaSkg2JAtA6uBbW6EfhmD84789t+rtNCHWk44UTsPRs5r/Lm5bAkR
	HAkp4XXCBX9UqoJWMYGBQjq4ar
X-Received: by 2002:a05:6102:4426:b0:7b3:32fe:77b6 with SMTP id ada2fe7eead31-7d0728b04d8mr4925641137.3.1793656507963;
        Mon, 02 Nov 2026 13:55:07 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d07738ebf2sm11066184137.1.2026.11.02.13.55.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 13:55:07 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 5/6] transport: Don't set linked transports pending before they are enabled
Date: Mon,  2 Nov 2026 16:54:56 -0500
Message-ID: <20261102215457.2553416-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102215457.2553416-1-luiz.dentz@gmail.com>
References: <20261102215457.2553416-1-luiz.dentz@gmail.com>
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

As a server, when the client enables one ASE of a bidirectional CIS
before the other, the transport of the enabled one becomes pending once
the CIS is established, and so did its link, still in QoS Configured.
An audio server would then acquire the link, which was rejected with
NotAuthorized as a server cannot enable an ASE, or acquire the enabled
one and make the link active along with it:

  bap.c:ep_enable() ep 0x5e382ebaba40 id 0x03 dir 0x02
  transport.c:transport_set_state() fd1: IDLE -> PENDING
  transport.c:transport_set_state() fd0: IDLE -> PENDING
  > org.bluez.MediaTransport1.Acquire fd0
  < org.bluez.Error.NotAuthorized

As a server, only update the state and owner of a link once its stream
is enabled, only make it active along with the transport if it was
given its owner, keep the owner of a link acquired on its own, and
don't set a link that is acquired already back to pending.

A link acquired on its own is also released on its own: don't propagate
the state of the transport to it, nor disable it along with the stream,
or disabling one ASE would stop the other direction as well.

Fixes: 47ba235f5a6f ("profiles: Add initial code for bap plugin")
Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/transport.c | 95 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 92 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index e001f73151d9..c6b675f0b6ec 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -727,6 +727,44 @@ static void media_owner_exit(DBusConnection *connection, void *user_data)
 	media_transport_remove_owner(owner->transport);
 }
 
+static bool bap_link_enabled(struct bt_bap_stream *link)
+{
+	/* A client enables its links along with the stream, while a server
+	 * has to wait for the client to enable each of them.
+	 */
+	if (bt_bap_stream_is_client(link))
+		return true;
+
+	switch (bt_bap_stream_get_state(link)) {
+	case BT_BAP_STREAM_STATE_ENABLING:
+	case BT_BAP_STREAM_STATE_STREAMING:
+		return true;
+	}
+
+	return false;
+}
+
+static bool bap_link_independent(struct bt_bap_stream *link,
+						struct media_owner *owner)
+{
+	struct media_transport *transport;
+
+	/* A server has its links enabled separately by the client, so they
+	 * may have been acquired by a different owner.
+	 */
+	if (bt_bap_stream_is_client(link))
+		return false;
+
+	transport = find_transport_by_bap_stream(link);
+
+	return transport && transport->owner && transport->owner != owner;
+}
+
+static bool match_link_independent(const void *data, const void *user_data)
+{
+	return bap_link_independent((void *)data, (void *)user_data);
+}
+
 static void linked_transport_set_owner(void *data, void *user_data)
 {
 	struct bt_bap_stream *stream = data;
@@ -739,6 +777,19 @@ static void linked_transport_set_owner(void *data, void *user_data)
 		return;
 	}
 
+	/* A link that is not enabled cannot be acquired yet, and once it is
+	 * it will be acquired on its own.
+	 */
+	if (!bap_link_enabled(stream))
+		return;
+
+	/* As a server, links are enabled separately by the client, so a link
+	 * acquired already keeps its own owner.
+	 */
+	if (!bt_bap_stream_is_client(stream) && transport->owner &&
+						transport->owner != owner)
+		return;
+
 	/* If the linked transport already has a different owner (e.g. it
 	 * was Acquired separately), tear it down properly instead of
 	 * silently overwriting it. Otherwise the previous owner is
@@ -2209,6 +2260,7 @@ static guint transport_bap_suspend(struct media_transport *transport,
 	struct bap_transport *bap = transport->data;
 	struct queue *links = bt_bap_stream_io_get_links(bap->stream);
 	bt_bap_stream_func_t func = NULL;
+	bool disable_links;
 	guint id;
 
 	if (!bap->stream)
@@ -2225,7 +2277,13 @@ static guint transport_bap_suspend(struct media_transport *transport,
 
 	bap_update_links(transport);
 
-	id = bt_bap_stream_disable(bap->stream, bap->linked, func, owner);
+	/* Don't disable links acquired on their own, they are disabled
+	 * when they are released.
+	 */
+	disable_links = bap->linked &&
+			!queue_find(links, match_link_independent, owner);
+
+	id = bt_bap_stream_disable(bap->stream, disable_links, func, owner);
 
 	if (bt_bap_stream_get_type(bap->stream) == BT_BAP_STREAM_TYPE_BCAST) {
 		if (transport->owner == owner)
@@ -2262,10 +2320,16 @@ static void transport_bap_cancel(struct media_transport *transport, guint id)
 	bt_bap_stream_cancel(bap->stream, id);
 }
 
+struct link_state {
+	transport_state_t state;
+	struct media_owner *owner;
+};
+
 static void link_set_state(void *data, void *user_data)
 {
 	struct bt_bap_stream *stream = data;
-	transport_state_t state = PTR_TO_UINT(user_data);
+	struct link_state *ls = user_data;
+	transport_state_t state = ls->state;
 	struct media_transport *transport;
 
 	transport = find_transport_by_bap_stream(stream);
@@ -2274,6 +2338,30 @@ static void link_set_state(void *data, void *user_data)
 		return;
 	}
 
+	/* A link acquired on its own keeps its state */
+	if (bap_link_independent(stream, ls->owner))
+		return;
+
+	/* Don't bring back a link that is acquired already */
+	if (state == TRANSPORT_STATE_PENDING &&
+			transport->state >= TRANSPORT_STATE_REQUESTING)
+		return;
+
+	/* A link whose stream is not enabled cannot be acquired */
+	if ((state == TRANSPORT_STATE_PENDING ||
+			state == TRANSPORT_STATE_ACTIVE) &&
+			!bap_link_enabled(stream))
+		return;
+
+	/* As a server, a link only becomes active along with the transport
+	 * if it was given its owner, otherwise it may have been enabled in
+	 * the meantime and has to be acquired on its own.
+	 */
+	if (state == TRANSPORT_STATE_ACTIVE &&
+			!bt_bap_stream_is_client(stream) &&
+			transport->owner != ls->owner)
+		return;
+
 	transport_set_state(transport, state);
 }
 
@@ -2281,13 +2369,14 @@ static void transport_bap_set_state(struct media_transport *transport,
 					transport_state_t state)
 {
 	struct bap_transport *bap = transport->data;
+	struct link_state ls = { state, transport->owner };
 
 	if (!bap->linked || bap->desync)
 		return;
 
 	/* Update links */
 	queue_foreach(bt_bap_stream_io_get_links(bap->stream), link_set_state,
-							UINT_TO_PTR(state));
+									&ls);
 }
 
 static void bap_metadata_changed(struct media_transport *transport)
-- 
2.56.0

