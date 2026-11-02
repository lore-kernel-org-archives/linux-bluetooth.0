Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793643183;
	b=IQoCvyRj81sT2nZZSatVvob5cIfV5XH3M/03rGXHgbouXQpiyTPvHMHJvHxgxXSFZzhn
	 N8w0PsgXPJRAFQ9GS7E0UMSAVh4Zb5Ipd3gvzei6Vi0IyDMqAqPDKPontF1ice5xQrUrD
	 Hk7O0iWT4cgIOKDWlHaVIcm/66Oio/L897edh+9mOOEYiHuLcr2BgJNeBoKecvBeIvsYY
	 0q4qpl/BZsJyfp7I/cfhaKZabEO2oqnnO9HuNLQAzNUCyQrfoNUSLTpoOiE6pO/nk6hK5
	 jTdGCT/N3wyumLn7/LP8w3ZsH5xlbK8HSwf8GpFRomdO6Ylo3TURQHsO1QHbN9V3Q3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793643183;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6ZVut38ouwMV5om1iLjhLyY1lQP7Z+1lr4THlAMblYo=;
	b=ADsdJGvS3PVmlPqzJEmYYtEvZXTPHM5Iz4u1AiqEZ9OCull+uPaOHOkOCCqOT4a/wf2u
	 kivd0VoENoDRF0nXq0gheP7o85n98zWX4w+8NUoW1KYfcP8Cr/ixBvcThCUlgTrBiCZTf
	 mG13aOw73IueNhzDWplEWBVlJ5FVveBRTPmVEs1mDBLWeatPrT4773R2cmuW3jgIpIlu2
	 SuZJ2sMIr7TlEVFKduj3nn1wR2BypWVnQN2/1Yu3QyxzARxyXJq756xqFotwDnbH9UZUb
	 6Q5lKyKXrNXCHf+oIXtxjgL9LeTAGnYBwCUyFnZ1LljwzM2SAfoVGCbfLDb2yA6DRcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gxphyfhI;
	arc=none smtp.remote-ip=209.85.221.174
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846F9606A32C
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 18:13:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 846F9606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gxphyfhI
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5eab93a9862so548481e0c.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 10:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793643183; x=1794247983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6ZVut38ouwMV5om1iLjhLyY1lQP7Z+1lr4THlAMblYo=;
        b=gxphyfhIPEN5048NRwsRuMTdadlv8z+HagjPhlXBG98flEiwJ7YoVV69f9+PiqVd2V
         HTMRvpl/+/gbJILsJEiSZWIbgxTO3FFRBzR0qzSolAI3UsRjPKW7e9D0Dn0K8BVNs+Jl
         tKx1YbVSkenbwfappyqmDDt4wRbalDVlyziswH6u100ZU010KC1hAHcM/FcV1EL5Ejzt
         sMZdUOBCXoQ54keGbZLNK/4+0YeW0pf6G4TiTur9Q640hHPg3ZEw04JLf9SQ5pEEBtAk
         +xH+sRDn0ZDz3vAMok3qWwiJD2YiqvRaJyGNBzUX4tTSQ6KolHR4KsnEdakfL8zPdC3L
         qp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793643183; x=1794247983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6ZVut38ouwMV5om1iLjhLyY1lQP7Z+1lr4THlAMblYo=;
        b=fwRrO9h6OWK+zhbzKMmx9sFPrQNJjTqI3vyRw6dUPtpydNF4zh7xgDe9vkTL3n6Hgu
         PkfEIrpWoY+Xm+fpLXMaQk+Mp2hJFqvnXbDUTUPM/QFal0VpI4i/OuWmRyrntDcq33LQ
         RsI/edkmg/PqrbR3kOxbpGvDFeKioHSX0mEoOGXhzbUINPGP0GiMH1HBmEGBKpVPge5R
         qxN59IFg37M++8WGPywY6SvZIkpofPemrdflnk+ws2GBuHbqvZGUZa4eMmsn3948iZ/5
         oiytjhw3nYWRW+D9JxIr3iVMOgmxuLUG8ehOu6XchZ0eB4W4flR0Sjm3F6sjUQxTyzsv
         eOZQ==
X-Gm-Message-State: APuU4Z88K9utM2lCGlsEfhYwAz2pvdCEAg7HD9O/01g5KWD1lrPTZzrJ
	hgheeIl1PbfEmiJUc+RnLeQ4NqG/vn/koUXZfaDn9/eQVbjzM8VELbWDhb8XXdxO
X-Gm-Gg: AYBFou2oqcnXR3wJ9Y+/Yd7VqwUAxVt9jKQ1wG736/cj8Z2BJ+NViupdavZvlvZ/HNy
	jGV/DDgX4eNlKETtfWigWxt+0af2zy0p9miNN1VLXzftDVwpu/bNFZP+17kh8B0OMELnCKCNmmG
	iPSytH231z859P+RqppCwv0sj7awde91maXEKtTnfKpCpabSSRPrJMlijMofuOnxWQGd9R/xWL8
	M3Gyvg/EMyIOu9pKOyaCkaMcIpwxkaWaNo1XCr48ZuBqeqjyyinxcmSgnm92kG6sB/N04u8myNw
	YNZ/Hry4F+BnR6LwR43NnBetHLQsoo0iT+BcX2L+KDBRb29x/gzHBA3b1/x0A7Ai6Z2RMQTX1ba
	WcSGFiwed2PGfoBuei2K3VZe77UHyeevoM0SiU1TmUibmwTin4WBvrNhbGTfBBQ/T0gZ7uLA5UR
	e1pDRD1Zh8L99U4gGpYNU8XN0X9qRPJ/d9p5llr+UpLcVOSS3I/la2SGyJHCP8veagXwcIP+Aqa
	wlRgFrj8MRren3rrtnlLYhaHgtFxU7t3w19goNmaHh61QpgJwut2In7zP1xuftOPi8+ebS5NLIs
	jj0eqSoJFzY1Iyjiga7otRixwqjiYcW6ATplnXrPhJs6uFSSNm6GUjA7KUkWsTaFUwoUP19cCO5
	NZvjaxP8b/mIEwjRWcLM3BkH679SDtXLFvM6IUNQqbXdFKopZFLdUbA0O90agq6aZrPvI+9iL4T
	DBHDGz
X-Received: by 2002:a05:6122:3121:b0:5ea:c727:11fa with SMTP id 71dfb90a1353d-5ec68292511mr4475387e0c.0.1793643182480;
        Mon, 02 Nov 2026 10:13:02 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69bf220esm10300208e0c.7.2026.11.02.10.13.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 10:13:02 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 5/6] transport: Don't set linked transports pending before they are enabled
Date: Mon,  2 Nov 2026 13:12:55 -0500
Message-ID: <20261102181256.2321329-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102181256.2321329-1-luiz.dentz@gmail.com>
References: <20261102181256.2321329-1-luiz.dentz@gmail.com>
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

