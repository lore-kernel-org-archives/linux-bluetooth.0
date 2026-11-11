Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794429479;
	b=DP/i7tumSgI6vgiteLSGvxR/U9pRhaOBOytcqxl8XJJsaflWWqTtWIfwUBNQBGqIZ3vf
	 CvDukUkXgLvXNI7uCGZIcgznfTMdilr0BCj0RjUG0LnpRU1Kj9wpBAQ5r3lsOCLyHWqpM
	 p1gb1TD9/Y62nFIblXfGeg+iR1oSKMQE97qkVgHhBZQUz6ciob3SeDKCwevMj5BhSCeHe
	 abFxeTzYUgPwRd6YRQNFuuTeKTKveokMNkhgIFnfDfmxqkSDqxSznp5nC9vNZ1a2/oFo8
	 jThDR+Nqyk1hz0zbOUhf/SCw/ZnYzLosu0nRiw//HfCp9Dp9D1VseEI6GWFqoY4LZ4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794429479;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=norr/XCWDAzQNfpR5IC8rtPpFqt4FjdeXFpTVgiFjwc=;
	b=noOO+9kfqoroReYEUoEVUhf1hWmOp8aNF4D9VFw9cwg33sg/0F2wFOt8ub0s7zdU3Drd
	 r5m8Ld7Yy126E7K1lI2jNb2Iw0F7sWQiYthzj02DNbB/bMA5mnQ4qnEF1GN/aZJYN3OVE
	 +myd9Dk5E7+r1+QYLGWYcLvdrHSH3byXCRMH3VnqtEjpHUlbPZ8+LhDf75xk952UxMXoJ
	 BmoYNyc1i1zPr4SP1M+pHGNjJT5UoywyesEJcT7aDfXLfF76hkN1mbJKTl7vHaiLj/xSV
	 n7MGERJPuWo+xT+o+SGxvcbEzaRtxhQ/xMih6YlNS/jeJCWbSod23WwgWYXUxe41BSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="CAceGMj/";
	arc=none smtp.remote-ip=209.85.222.53
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788CC60A2630
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 20:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 788CC60A2630
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CAceGMj/
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-99ac154431bso554144241.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 12:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794429478; x=1795034278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=norr/XCWDAzQNfpR5IC8rtPpFqt4FjdeXFpTVgiFjwc=;
        b=CAceGMj/mS1j1RgF0CViXjcuIrjbVXaHH6+pZ0mdLMPqi4Gt2JmcEi2FNml3CQw63n
         pBB/bIP3MHFVJCPkdfogh9h2hDrZZ7vCazXclf2CT/IpV5BCreweS1/Z5Tj9lvibHI+o
         kAZqZjxNo3ICttGWro/yLo/8ZJtrKVslMYt0cMVTwo6+6tv/jiz++7dknxSVskdP9i7S
         XmekaHycOo8cWAKlxK/LvMZwYoP1FC7rsEAJhmNmFCMp/tJ6UKxdb/PtxUEl+c9RGMC+
         lTaTfGiaUT07XEyUiAlFVnKbu2vIYahVJN59ngbzVstDP3rlnLZV5ycD+YurOTHVpSzh
         CDeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794429478; x=1795034278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=norr/XCWDAzQNfpR5IC8rtPpFqt4FjdeXFpTVgiFjwc=;
        b=vX/mNKNaK97GuqUgNvJSoUyMh6U2k+XvZG6FxPRVgj40TphnmJ6hA3d6ldnsmIGo+0
         05IqLhfbeaVQoE9SP2uZUId2RdimRM4SV9ta87E/Lt95W2+kcejYkT+wo0uZJpyzQ0b5
         /9a4lv4N5dX7x5ztmwILr7VFWzWLtYz9m3tvlCCxKCoJ5RL9RW7CQP1jiELKjx3gSl43
         IwtgtngE/eI/Lohf3YlcwCkr2lNTEM+A6IyT9AhBZLkaiRNy1Mdl3vA5fBAUt4CYr1ML
         7j2yg/PdRbUbzHp/IzfTF4pB0SV9TXI+Gqtvx6n7j3pqnVfzytXVeInF/XkJvGphDp2Y
         FQxQ==
X-Gm-Message-State: APuU4Z+DUmJhsWfIKVaHw+CRBYvQ0Rbr6voVM09hXIueg3LYQ2dU6kWw
	YVGCZDPQ3wwJ7x9u8GBsBqWtOlhRPHquEV9MK9MvDbkDvI2dd/7hqER3n23uRw==
X-Gm-Gg: AYBFou1wu9xdPase9Kg5VmmOvRBCy9Bgx1AE6hu2FQMqX3bZQQ1I4O7mKFl8Eh9Cbm3
	75VZTvu3h1fLiY0qtuirf7Ozn+jg/SR7m4PsLsPleyBXiBeXbmPa2W7MZIkt7RQZIFuYUKZnZ85
	5Gq9gIsq2H32+eNKlgdm6JDa1qnahmreuW7OinNFr5ZgLgDPhU4R4Jt5rm5McwIGqF3tXXqaPVD
	oYcK1CTEHdKjlkNsB5MNJej2uvOHvZyFlmXb7XFu0lCiw1qR4lpUfSugz2MCEq/nzgDaznUkZmt
	Uup4mhe6tG0IppL3EyGw1BHx3OGV3tUUfIOhQ+bie3XMWy77npYkoXC9elg1163HLLAq5ARYgNx
	goOTkPS5kUIbFTFNODQtBHqcCFSx/BTLpLJ68c8po03CZWNDjcmvm8nMd9jwEqk6MuL+M8e6nK2
	ollL/jJWYvNGCILxHeZmQPvHs/pWVS1CipD+20Ljiy+DV5gmLGklrkG+lqayi7daeO1dsmaR9jA
	/BrYTo8z3V8jE9SK4UVzz7lH0NHMjHh3ivtLm6zwMyE7cVmY/2doVWY2eHLEjViMDmjoigoGDRe
	8v7h+7VRl8OrHTDIH29tja2ifa7FMvM9jd1AC1x44dldwO40pDVy4OH7Y0EUMNudnISt5dSX0VV
	FNiuWl1GjQCdoYW4U9EULe4n8z/TAla1uDOOGlncOI3B00IchGxHAgeXj61EidlRJ4mX3uBfIcG
	pJN0Q=
X-Received: by 2002:a05:6102:3fab:b0:7a2:7ccd:280d with SMTP id ada2fe7eead31-7d4fb2d9493mr1388700137.8.1794429478195;
        Wed, 11 Nov 2026 12:37:58 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d302359221sm4762571137.6.2026.11.11.12.37.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 12:37:57 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 1/8] transport: Hand the owner over to a link still streaming
Date: Wed, 11 Nov 2026 15:37:35 -0500
Message-ID: <0bc4e142448f50213e08cb6e690c16dc98da92e0.1794428234.git.luiz.von.dentz@intel.com>
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

From: Kannan J <kannan.j@intel.com>

As a server, when the client enables both ASEs of a bidirectional CIS
the audio server acquires one transport and its link gets the same
owner. The client may then disable only one of the ASEs, e.g. the
Source ASE when the microphone is closed, while the Sink ASE keeps
streaming over the same CIS. Removing the owner of the disabled
transport then also cleared it from the link and freed it, and
suspending the transport set the link, no longer owned, to idle as
well:

  bap.c:ascs_ase_cp_write() Receiver Stop Ready
  transport.c:media_transport_remove_owner() fd1 Owner :1.1213
  transport.c:linked_transport_remove_owner() fd0 Owner :1.1213
  transport.c:transport_set_state() fd1: ACTIVE -> IDLE
  transport.c:transport_set_state() fd0: ACTIVE -> IDLE
  > org.bluez.MediaTransport1.Release
  < org.bluez.Error.NotAuthorized

The audio server stopped the stream of the Sink ASE, which kept
receiving data, and acquired it again on its next metadata update.

As a server, when a transport leaves streaming while a link sharing
its owner is still enabled, hand the owner over to the link and only
suspend the transport, so the link keeps its owner and its state.
---
 profiles/audio/transport.c | 54 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 285db0d37554..279e378135ca 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -2431,6 +2431,54 @@ done:
 	return FALSE;
 }
 
+static bool match_link_shares_owner(const void *data, const void *user_data)
+{
+	struct bt_bap_stream *link = (void *)data;
+	struct media_transport *transport;
+
+	if (!bap_link_enabled(link))
+		return false;
+
+	transport = find_transport_by_bap_stream(link);
+
+	return transport && transport->owner == user_data;
+}
+
+/*
+ * As a server, the client disables each ASE of a shared CIS on its own, so a
+ * link still enabled keeps streaming and takes over the owner they shared.
+ */
+static bool bap_handover_owner(struct media_transport *transport)
+{
+	struct bap_transport *bap = transport->data;
+	struct media_owner *owner = transport->owner;
+	struct bt_bap_stream *stream;
+	struct media_transport *link;
+
+	if (!owner || !owner->watch || !bap->linked || bap->desync ||
+				bt_bap_stream_is_client(bap->stream))
+		return false;
+
+	stream = queue_find(bt_bap_stream_io_get_links(bap->stream),
+				match_link_shares_owner, owner);
+	if (!stream)
+		return false;
+
+	link = find_transport_by_bap_stream(stream);
+
+	DBG("Transport %s Owner %s handed over to %s", transport->path,
+						owner->name, link->path);
+
+	transport->owner = NULL;
+	if (owner->transport == transport)
+		owner->transport = link;
+
+	/* The link now has its own owner, so it keeps its state */
+	media_transport_suspend(transport, NULL);
+
+	return true;
+}
+
 static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 				uint8_t new_state, void *user_data)
 {
@@ -2460,7 +2508,8 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 			bap_update_qos(transport);
 		else if (bt_bap_stream_io_dir(stream) != BT_BAP_BCAST_SOURCE)
 			bap_update_bcast_qos(transport);
-		transport_update_playing(transport, FALSE);
+		if (!bap_handover_owner(transport))
+			transport_update_playing(transport, FALSE);
 		return;
 	case BT_BAP_STREAM_STATE_DISABLING:
 		return;
@@ -2480,7 +2529,8 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 	case BT_BAP_STREAM_STATE_RELEASING:
 		if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SINK)
 			return;
-		transport_update_playing(transport, FALSE);
+		if (!bap_handover_owner(transport))
+			transport_update_playing(transport, FALSE);
 		goto done;
 	}
 
-- 
2.56.0

