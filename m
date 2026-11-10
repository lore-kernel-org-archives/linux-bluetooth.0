Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349177;
	b=ix7KlvJ5Igu+WdBhki81+jqRKO+xFOlQWrF9mt+Fk2HiXAdZgzK3xb3slwcsdmhb2Wlr
	 IOlMoAy8J9KIgTEs6UX+9Ekj5qUCvIVG2zethdzhy5X/w63UcuXnMsbx21DzxEjyxnt4p
	 0z7HtPGaTBOqf6kRCsqAS+0dQkulwTFTtu7uUGmMw0rMijpEtMz++Uh1aozxK8sgw/Wjl
	 y4hzfH1pO/+1vdV7IYtJfvqdXWucqkAiu5BPREbEOen0R824Kc99mkRmdXFpNBWmkzCut
	 DaOXMXxvzUVs9alzDarZn46zAI9VQ3NUsW7YsJHDQaw72E3dQ+sT/UK539IxgHm1EJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349177;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nCvzT7O/3sgUBYkfrLguYiL2PInBAxUjdDi7PU7hQSQ=;
	b=0t4Ttu/lsG6CBYJf4MpG/PhWZ85lzpLNVTxHtZxexrGvNF7qy0CwXa8A3nsQbvV6AKzG
	 tjzp2Jjk7PwFMww8x3SH0Bv5Ujo79CzYIith9ZU4wm1HD+waHEpuy0/advnY5a/BqYL3z
	 DcVjYygCpuuEnZbsUpyfZ3nCwJjX1cft+G24DexAnML/rS39Cngl1K1ndzwoPL7yNx7dn
	 VEOEjJ0gAl8ZYo1Y6F6ERkqf6hPC6tzHZSmDrao567F50+znSvmVYBqERzku9xwr9GwJP
	 SlFupMQDmkY15JwqzqRFVQfIoKtktM3yfoWCPRVladvEA0d2x9lqtL98GQ/76+x0bjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=llDeST+p;
	arc=none smtp.remote-ip=209.85.221.179
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF11606A31C
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 22:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CF11606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=llDeST+p
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5ec3561b07dso1797222e0c.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 14:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794349176; x=1794953976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nCvzT7O/3sgUBYkfrLguYiL2PInBAxUjdDi7PU7hQSQ=;
        b=llDeST+ppxfMZARsnsl21zu4qY+mAGHY2hnTeF6y3Nmqp5wyYUmSNnJowq9jugwjw3
         XYc6szRWC8Wv6MmMwis0REtBftbcaOLoc8TuWuZlmMXLB6AW9XcLObGqhxK8MYpyAczP
         ql+SmBN+CrX2GC4Ti6T/x/Xm3Ghqsk9/tVoaIN3D9m4AQQM2IV+kgfni5MBH07x+DXGt
         VMM2r0dSJmbh76CwS2QKZwmDujNNKZE7oAIW0oKlozCDhOBVqD1LLRy/AgNQY4j+8YG6
         oRP0HbD2nfbsAbohBAv1NxQEl5TPXgpK4twXM/WaLrIFZkvPSlO1noX0iBCwOY9+vBR1
         usGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794349176; x=1794953976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=nCvzT7O/3sgUBYkfrLguYiL2PInBAxUjdDi7PU7hQSQ=;
        b=nkKlyCUJjci8l7Etoo3656koGP8aVwzmYk1QY1DwqM4vgDln7CoOakYyhPjTchAFxg
         kFD3N6d7q5mS/0tJxvtlyXN8LrXvIZiL99OmYrp92cXa9+eIxUnk11+ge4dnRAW5y6/7
         9oDWhLmWFL6RnLQWRc2ooGWtFbfOJkqnZZY4RPpAWwo5AO99gEpysHxrYD/hIAG5qnO+
         gbifdT+/gYAs8A9i/gDiI+07PC3G8iQprTDMRPdsgmCCtxOSWV4FcX3cpZ6N8b/LxOjN
         LH6nqf+MlxgYfH2Bece8glA6cvMUvAPtaGgAl4E+fCgXODvTKQVR7K4pnJlepWadhAYC
         KVLQ==
X-Gm-Message-State: APuU4Z8y/CiJCahENwFg53DMbC/5XbvKcMxnH8i7eD8EP16/tbGI5ue2
	bVXixxY3EuNBChsXNIz+kRQwJN6sjRfhc8hX5KPj4elkoipG5cSQlsl3rR7TZg==
X-Gm-Gg: AYBFou0o6w0EB8/8vbWgKGiOkgXFevZaC56hRfARoDpw/B7TyPrfHcse5oMBd3nA9CM
	wZcmpZKuBnzwvpaMY9Pt8yc4fNgboF2Dd3qrXH49CERsMdL7fDERKbRm954/rvasquqMNoXWurz
	AFKRAft7HFVfqxyDMwOCB099YGxgTefS8xwjpA0/YbkEukgNq3hMqPdHMaWeKdhstePUHtIHYY9
	32n2YzvAq4HOEVwG48DmH7MigWUCtW7yWdw4lbE235YtRKBAk9wIw8j34ZN1NHsh1WEBy0avIqO
	JdUEYT402F0Es67EmFGLdlAxnqfBGcxKSf08P/kZr679BgZ/Kf0NplygDO4g2rJEAWyUApOHrrn
	W91Vm32ehCP2prk4sfDGA8WZTizkPf6Fo7SxAWpifhFisGT/iEKxvLe+nxJqsJqFV+fOpsDqTGS
	WLi4UnKg1Zkr+5eVVKaPIis7EnfmZiNK+G5eVcwT8hTNCvNcVIx38vVEBqVVnavkedj83aJPiuT
	SPuxx30ZdL8QnVFhcvW1izzsRYAijtSXuX86v+MmGZRRJ9HFQU+POsuHAzYUyRjUGaPZVsU+oHI
	DWbDQPX8c8Yvh7b2Q8ctI3bOD7DccuWcmX8IWpG7IsQt99RQwJTt/DGQoAdGyyeRSHYXaL4MKM5
	0+CcSJ/J/cKg58YCC9BgySSaqgkRzQijYujtkj2aPYUNzAovVGcnnUoENMvvVYrZlBr0USkstGe
	xxyNk=
X-Received: by 2002:ac5:c919:0:b0:5ed:e8fc:b13c with SMTP id 71dfb90a1353d-5ee1af56c87mr192403e0c.8.1794349176094;
        Tue, 10 Nov 2026 14:19:36 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c58ed55sm2605244e0c.5.2026.11.10.14.19.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 14:19:35 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 4/8] transport: Don't hand the owner over while releasing
Date: Tue, 10 Nov 2026 17:19:13 -0500
Message-ID: <08b31b48642208e419dc10f83f6fad0712ad0579.1794349049.git.luiz.von.dentz@intel.com>
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

As a server, handing the owner over to a link still streaming also
happened when the audio server released the transport. Release sets the
transport to suspending before disabling its ASE, and disabling a Sink
ASE reaches the handover synchronously, before the request of Release
is installed. The handover cleared the owner of the transport, so the
removal of the owner by Release did nothing, and the link, which kept
the owner, was left owned and never moved to idle:

  transport_set_state() fd0: ACTIVE -> SUSPENDING
  bap_handover_owner() fd1 Owner :1.2 handed over to fd0
  transport_set_state() fd1: SUSPENDING -> IDLE

Don't hand the owner over when the transport is being released, as
Release removes the owner itself, nor when the owner has a request
pending, as it would stay with the link although it was made through
the transport, which is the one that completes it.

Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/transport.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index d3aac8ca66bd..f8aba2bc58ff 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -2457,8 +2457,12 @@ static bool bap_handover_owner(struct media_transport *transport)
 	struct bt_bap_stream *stream;
 	struct media_transport *link;
 
-	if (!owner || !owner->watch || !bap->linked || bap->desync ||
-				bt_bap_stream_is_client(bap->stream))
+	/* A pending request is answered through its transport, and a transport
+	 * being released has its owner removed by Release itself.
+	 */
+	if (!owner || owner->pending || !owner->watch || !bap->linked ||
+			bap->desync || bt_bap_stream_is_client(bap->stream) ||
+			transport->state == TRANSPORT_STATE_SUSPENDING)
 		return false;
 
 	stream = queue_find(bt_bap_stream_io_get_links(bap->stream),
-- 
2.56.0

