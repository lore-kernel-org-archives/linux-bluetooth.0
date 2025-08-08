Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAE8283FF8
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Aug 2025 18:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754679061; cv=pass; b=MRE96G3S6hvE2wZA2JJhQZ+8aFKFQ8w6WQo7tO6miCJotw7BiB6SD5m74l6XcBAQF1KE3nFo4tXui6APGbJdFc+caz5C9z6z7cLUnX8aWfW1xxADQovBYt3j5Niys/leDbB4OGX3CGbEdA0fafnoZHL2BeO6BklEGlEstLwIQeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754679061; c=relaxed/simple;
	bh=d7tXnlCy+CS4SiRD5tlci9LQjx4E5pl/Md2pHh0xBDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJStrrXzfatgKRwjsigol3cWJyKHFDHvxBTB1YJ5fVFGYtEVFoxWhZj98uM9MuQjsl/lUYN1YveYwWOMj9aDcrOquFiWdkMD7GoaUjWuYSDZ2mBXEwNPpoWqAxX7ueZZmmT4Pcvie2lM1aL+67BUl8VjvUoNYgfQ0y6OyVBM8yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=Bv7RhCtL; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="Bv7RhCtL"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4bzCly1kLXz49QB9;
	Fri,  8 Aug 2025 21:50:54 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1754679054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DFXxWoF5WX4DlfubFEiGrVQrbwZS/xCFtDMOgcdXQM8=;
	b=Bv7RhCtLn095xXOSnoqU3XuyoEFOShkpnf3iPlToecwvlR+m4uYQnwZ80rahPdJ/jBtzk1
	T5i0cvUkZQt+GybhmB3HzkLMwxGm3nVHxdIuouvClem5CTU5SjCemzINPlCBO7IftGAgqO
	UvqV5KzxFiNVtlgTuBx9vgEh/ezSuZ9Tzx2rnGYQR02OipLMtzJE7vnFUhfrm8fCMWr2Nb
	A9fa+wEfwKi9E7NWanC//CxCtZer2amlVcq0HKwRG5PdTo4YJvdTsjwUfUKvY05aSqh5N4
	uOWZwjuMAS3A6+e73d3lNvxA8L28L2l2hhmbFY7L23LpDfwmN/CgvFA+iUyehQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1754679054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DFXxWoF5WX4DlfubFEiGrVQrbwZS/xCFtDMOgcdXQM8=;
	b=qiDEJWNevVObjqJXKyjBOOYUbb7JCFWbR3Ffp0YYMOJqvSCUdd+Y8R5zhnLw0j/IiaaI2M
	xjnB/NLWqliePjQ/JKEdn4v1yaUpEkpOPv+W/9H2RKdwMi8SlIyHRsD3uYSLqYbXmJliFR
	GGNjfluRNEH96Fj/AgI3yZUQVfhBWZyc6Rb5o9wKFquhK3EbEZcTzLKj4CAe55xxYsLmMs
	Xe0eQh3Txm72w3IilupMjIxQMBlH/ZUJcTWLa07NAxSdrvu//v5Fd6/m4C/Gsa/BExKcYM
	VAoa7p6f2oOsOAoNQJjw8R7BPclqp2BwlXSdAmrVBb2iqRWLyWaW2bXgHYbO6w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1754679054; a=rsa-sha256;
	cv=none;
	b=KBzEV+qlJQG22Ma55d5wfueRGyk2NfBcwshe5zxBsjqO7ty+vcvmEs+7GKiiE5tDJrIJj7
	dH9h1hUAaXYNyycliI9rs7s+Oyh4hLytZIBUrrquh7GBX/SSjU3kbAG7G8UsUw3+hRqv8h
	BuQHeusjG/dCdCKcas3yyFcB/3jY/faIKghbyyqbiyAdNxNeeMCn70n8v0kcmtOWXOkv1B
	F6C0YGevFEy+OEVbS/HUk0qcEMTwBAM81y0pIbF8AU837VxGu5snbWevax/nQmfXFea0u5
	6y9eQ9F5EXqUvjUMVgR/qjgaxR98s/jz40cIiYt8AGe7W2fqVOnjPPHkphzWbQ==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 5/7] media: clear transport if reconfiguring in pac_config()
Date: Fri,  8 Aug 2025 21:50:37 +0300
Message-ID: <d19b308c9b5782222607bdf1e025a1a390563901.1754678883.git.pav@iki.fi>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1754678883.git.pav@iki.fi>
References: <cover.1754678883.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are not updating transport->configuration if transport already exists
in pac_config(), so reconfiguration of a stream leaves sound server with
old configuration.

Do this in the same way we do for A2DP: first ClearConfiguration() to
remove old transport, then SetConfiguration() to make new one with the
new settings.
---
 profiles/audio/media.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index a723b311c..24f191a43 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1208,23 +1208,26 @@ static int pac_config(struct bt_bap_stream *stream, struct iovec *cfg,
 	DBG("endpoint %p stream %p", endpoint, stream);
 
 	transport = find_transport(endpoint, stream);
-	if (!transport) {
-		switch (bt_bap_stream_get_type(stream)) {
-		case BT_BAP_STREAM_TYPE_UCAST:
-			transport = pac_ucast_config(stream, cfg, endpoint);
-			break;
-		case BT_BAP_STREAM_TYPE_BCAST:
-			transport = pac_bcast_config(stream, cfg, endpoint);
-			break;
-		}
+	if (transport)
+		clear_configuration(endpoint, transport);
 
-		if (!transport)
-			return -EINVAL;
-
-		endpoint->transports = g_slist_append(endpoint->transports,
-								transport);
+	switch (bt_bap_stream_get_type(stream)) {
+	case BT_BAP_STREAM_TYPE_UCAST:
+		transport = pac_ucast_config(stream, cfg, endpoint);
+		break;
+	case BT_BAP_STREAM_TYPE_BCAST:
+		transport = pac_bcast_config(stream, cfg, endpoint);
+		break;
+	default:
+		transport = NULL;
+		break;
 	}
 
+	if (!transport)
+		return -EINVAL;
+
+	endpoint->transports = g_slist_append(endpoint->transports, transport);
+
 	msg = dbus_message_new_method_call(endpoint->sender, endpoint->path,
 						MEDIA_ENDPOINT_INTERFACE,
 						"SetConfiguration");
-- 
2.50.1

