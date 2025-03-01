Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1F11E3DC8
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Mar 2025 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740844679; cv=pass; b=CoBZYERhDpB+xHlp8JeCMwxub2DcQ6o2Of5B7yu5gE7Ec9UTqH18N8h5f8twpIsP9mg1O/Bdn+0hR6W6paDDsb0Gr4CzZUeNtoKZCQ3nx7GCiEAGWUd3XMEbtlVM86R35DqCGl52aLi2rq27cnbQOm0a7Lr2VcIOLJSwVsHrwK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740844679; c=relaxed/simple;
	bh=O4sl4Z/4gnT5Aq3feJGoYtOmhzErrRmfWG261SLz73Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K7P3xkCWSaB8+ACi7dbIMxMNvYE0dGTQKCekgWmN9cE0thspg3spimpGFHVzK6hJB3g9Muh1LLC4Isx7HQYikOHS9IBbqLDGb0kj2M/QQ47EDlBtw9d3tTxXYmhS+DSy3KeJF71vvr4HkDcHHGdzjDqMznCM7awMNibJKiWDmzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=hvD/ZQOT; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="hvD/ZQOT"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Z4qV61pDRz4BKJ3;
	Sat,  1 Mar 2025 17:57:50 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1740844670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qtZIBLU2MjTHMt/68ts6bDpQp7tO03qDMLBtTCNLe5g=;
	b=hvD/ZQOTrsi/SZHry4YMxT1atYGnrTCAwcayGr8d+KzBNUgCxy+T3AJJaO6NQIGKs8DnEF
	jv/f9tUyRdZ/sS1Vr4rlmMxV9aktcT+LYFFSZxZMASxN0pnpPyK6xNVnEOpdguLZi4mXut
	MXd19eOtI5EtR3QVYKzjfKUUXo6UlNmuDYcO7NLqB27+3YBL/YKWsnvAK02heramUz9fJ6
	Hr4VfCwT3kutIHjXCzGwdO+jtOzDfpTdcrF0+q0MkYkejYLPPcMsEXhamPezObrrq6I8QH
	paBcJ7Z96fCOzGs4I1uc8Pk7V9Lx849VKIbJlyNul+r7cSebOSd2bS0IZkD62Q==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1740844670; a=rsa-sha256;
	cv=none;
	b=BbDB87BJ2vIzGM57OLqGJ/jvfJxAfSg+HGJIjKGk/Gg3/jjGS520Uxe/ge/2XI/dTnIRsG
	iAFQM4EJT3/Fbu+lr+0KORPYjFTORDNkGH3aYn5HOQ92xE1yMaB/v3JGwwyrhwXwxMVQ+2
	HotDszxxvRIkzwLHOAMY6cj6/HXOepVOixPkRxUUINpgkTba6J8rd1Rbrty58Jh+p5PHKr
	1AWnKfyvggL9rx8oVLqBZ28mJAd4GVkyBNu6ghOv20UWnHlnYzhDik6rW0XdKVqsNmOaWh
	07MKwuap4gBxk37BHQ9T7AxKSoOif3/zz+OgwpSXJdMNC3Mif8W/ACP5ZPBlAQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1740844670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qtZIBLU2MjTHMt/68ts6bDpQp7tO03qDMLBtTCNLe5g=;
	b=K7mNfyHVo2/oJ9Zan4JQJweK50WceJ0BAqJNhbQEbdx2TlUUry9+c2xvEeQhLtkVEv1lvO
	ZGwZXCJikvNV4CBMz1JZnYdAQq1yzgvPIImnQkul1kWMQ9qlQsAFpvkGxIRT7GfNMU2MCP
	bAOGOEqOnT8ApEVxK8FigG5cF61vD27//i1nr2yse9FeictKol/AL+jk0GscIUPbSlG/Fr
	iGWSnT8W4L64oXRA2JpjGqMbT2IznmTxtVd81M970ULx7aP9gvIN+dYynA8HYFsbwKu3u4
	0teB4p1OBcyuv6aGV87CIjpLJ6kleC/EaS2tuZlcRzfmDUedTep+l757++Zkgw==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH BlueZ 6/9] shared/bap: make sure ucast client stream is destroyed after releasing
Date: Sat,  1 Mar 2025 17:57:37 +0200
Message-ID: <5f103220d38f8eb549eb41ac971d1f4cf1e684ba.1740844616.git.pav@iki.fi>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740844616.git.pav@iki.fi>
References: <cover.1740844616.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Upper layer as Unicast Client needs to be able to destroy streams when
it wants to reconfigure endpoints.

This does not currently work right, because of Server issued
Releasing->Config (caching) state transitions, which currently cause
streams never enter Idle (so they are never destroyed).

Fix this by considering Releasing->Config as Releasing->Idle->Config.
Also do not make new streams from cached config data as Unicast Client,
and leave all stream configuration to upper layer.
---
 src/shared/bap.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 54c6e8629..4f44db07a 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -1363,6 +1363,31 @@ static void bap_stream_state_changed(struct bt_bap_stream *stream)
 	struct bt_bap *bap = stream->bap;
 	const struct queue_entry *entry;
 
+	switch (stream->ep->old_state) {
+	case BT_ASCS_ASE_STATE_RELEASING:
+		/* After Releasing, Server may either transition to Config or
+		 * Idle. Our Unicast Client streams shall be considered
+		 * destroyed after Releasing, so that upper layer can control
+		 * stream creation. Make the lifecycle management simpler by
+		 * making sure the streams are destroyed by always emitting Idle
+		 * to upper layer after Releasing, even if the remote ASE did
+		 * not go through that state.
+		 */
+		if (stream->client &&
+				stream->ep->state != BT_ASCS_ASE_STATE_IDLE &&
+				(stream->lpac->type & (BT_BAP_SINK |
+							BT_BAP_SOURCE))) {
+			struct bt_bap_endpoint *ep = stream->ep;
+			uint8_t state = ep->state;
+
+			ep->state = BT_ASCS_ASE_STATE_IDLE;
+			bap_stream_state_changed(stream);
+			ep->state = state;
+			return;
+		}
+		break;
+	}
+
 	/* Pre notification updates */
 	switch (stream->ep->state) {
 	case BT_ASCS_ASE_STATE_IDLE:
@@ -4851,7 +4876,8 @@ static void ep_status_config(struct bt_bap *bap, struct bt_bap_endpoint *ep,
 	}
 
 	/* Any previously applied codec configuration may be cached by the
-	 * server.
+	 * server. However, all Unicast Client stream creation shall be left to
+	 * the upper layer.
 	 */
 	if (!ep->stream) {
 		struct match_pac match;
@@ -4866,7 +4892,9 @@ static void ep_status_config(struct bt_bap *bap, struct bt_bap_endpoint *ep,
 		if (!match.lpac || !match.rpac)
 			return;
 
-		bap_stream_new(bap, ep, match.lpac, match.rpac, NULL, true);
+		if (!(match.lpac->type & (BT_BAP_SINK | BT_BAP_SOURCE)))
+			bap_stream_new(bap, ep, match.lpac, match.rpac,
+								NULL, true);
 	}
 
 	if (!ep->stream)
-- 
2.48.1

