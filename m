Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349176;
	b=foA8jPRnPHqy+Gcxq4Fha/CNP5zCqz3smjBkgygDJen9qYLo2b9J0inTi7k8DiUPLztm
	 eomC2ss+L8lHWLHLyJAe0hXAL6ehY9/sFRf93JQ96wQp2pmhOuBgTRJUK4eRoVjszuZGB
	 8Lpq7YS7kRCyUygbQnAYIbL+E9cVyvF2VUFk5cS0Lby1HU3V6JzK11Q1qvWBW38Y7NQFS
	 Zt6aw1rAU93RtzfhLCmna+s/Syre9isNFNrXz2eMfzvoudLgegTKkz1uC4izj1EPGtPul
	 4PGpJUJrrtvJ1ESOme7L56rVlHd1yEDrSv/6w01O6Rh4RwSx9jhZompwRpXzs84wkvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349176;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xJB7WIdP2kEQdw7J9pRpF4/Z3R+XBh03b1UfVkjGyWA=;
	b=FRkJsDCQIoSbmecf+/2hHSOa32s8sdT6bk7VRvCAUmXdxSHjffw8uXKuJyxTeNvxA09n
	 D0Mt68quKVSdOoiQAT/iijyG3gFzNFrWh40FSaoPIujf6RmeKQqDkkCkEBDhh/vCzSgF7
	 6TfL/toVDaXcM66CrNYGLqfle2eSdyTMzG0dZmQDBv6SqK+wKIhcdKrhE8ahawWnZiavz
	 Os4EgHJQNz728pLTgI3k8lKqhyWrCVgrAARTiuJPoovWCndACz/EZTb8xCzSFpa08AbG3
	 k0VNApzZXkiLT2AFAcIt++OLrDFMwEWWs+pn5KTW7+GZgrcYENsqWSCnDim2vpLurwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z21XI3QS;
	arc=none smtp.remote-ip=209.85.221.173
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81D6606A325
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 22:19:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A81D6606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z21XI3QS
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5ec690faf85so852059e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 14:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794349175; x=1794953975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xJB7WIdP2kEQdw7J9pRpF4/Z3R+XBh03b1UfVkjGyWA=;
        b=z21XI3QSekN07T3FIkEgqiJj/4rXACh8cIpDRrooLEXKMO8fn6/e3sjNQyS9GvU1Wj
         d0jFWA9Ukz5tRLhmk4u4u2OVpVXiftmnccavb1J89TTxE/sRqpkoy4Z1o4b1yR/kWD52
         aEMJyQxcHfCRYONPB+V2UauFyzR1SEOOBmZIekiKQKA1mIWX4AL+ifr6Yy9J8TlTk35B
         L3SKQBpA8q+jYYxis/b6yCpQMdLCYaiFqeG83/cePZRsnepK9uCobl8Hya28Yp52/pHZ
         g1EaObQvqvHpMO1ohUz7NluM+mxnZwNocsBoKMVoFB1brLgnrZR3GRbyT79sm/fHZtxy
         Nl4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794349175; x=1794953975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xJB7WIdP2kEQdw7J9pRpF4/Z3R+XBh03b1UfVkjGyWA=;
        b=SIdYDORRZsoj19nWuaGcJ6Z68uHj5LICMXaErxl1kvAUpLyS3f4xYS3LP6lJk0Lnun
         rCBoU7Mw7hKlk06c6Rkk8XpLw5cuCXfwZZ21FS9VdSyFYo+dlNSMZgLl5Rer4B6Zd4Oj
         u10UbWQQH48GiXtXUsQ49CxbanXryFpU6BV/Y7jTgUqmbFTkU2zJLc0T6XV1JtcdzW6y
         +3qW/fZb1JH7XzHsMduPrQAg16e6exotqVdFIxNrwUKbNRCl8+q0x0Gd5dR6QwWPXTuq
         N20nZbtxBD123gczr6Up12zSFxaPGNgDaSr0VlakOuRiBtCgkQjCIa4ioAa68LmFGHWc
         kWPg==
X-Gm-Message-State: APuU4Z/iR2GI96q8lOwzHdnnXBu0LCCAOvw6a7KMX9FkXQGotCH9155V
	Gqww8pE7NzBlNaqe3ybM1+I/xkFGixY+NZ5sZ4UlOyXw5d+pT3cO4x5i2DmWzw==
X-Gm-Gg: AYBFou0gtb1MGRTL1Ga5HJnPgjGwrdLjJWtSomc2BpOC6pXMk+DjDTlYW3M7zJ6RyGh
	cRkwkyOfb0DGWuVKU0oIue0KOzXvxWXQIV5UociR7iTg5xh0o6WLFbDoPYeLDhFokZbW9hSvvE/
	otvlJiI2CiETEF6y5wZdjp7YatmSqxa7jMyaNR6WRYb9wGCJvMfITTHgMZ/w7wrfxYUW4OsNvzu
	bjg2EnsgPtVx1eU+qAuzJME0R5mOcVeeZfWxGSsg4abXMvZPRk686aW/8gMX7x7Gf20k4FsOCNy
	E1Nt4a1wvaupNKfjBX6WGIMOSXDL5IhuVyjZOodwZ+2nj6GX0Z/HnjEf9rS1WY3acHi0MH1C2U+
	3oWDzSvrz4GCrLBR1g5rkzYIpLin6srMBUNTzYp2v/n+ghWZeegex0EmnAoVawoq9c+usXGRjgc
	gOw10gwkmK//807QPBXqt0NAmjkoSyqZdp0lLJDJ5WKoRbMguBK5Rfmiwl2qT2MIuGfBr4C6PG+
	9mOE3ugJMTOn+LKAR7hKVNzP4zhn1oxyG/5/c/DdHEwzKtGUavxr46dHH1C5nx5xDiW4wrL5V+m
	SgkJiRvBS27cGWssXjSf9proYsNEdEXp1EaJn5UFubOGkbXFzHA36Pfc2c3znXmBwGHPiYbQfYx
	J/HVxxrcJbIKEjZdp0fqNfaciao8c/r3cf82b/CMjic3kF/jOmiT9CILPtK5I2yrqa2Uu7XWgVi
	C0AcM=
X-Received: by 2002:a05:6122:1dab:b0:5bd:aba5:3830 with SMTP id 71dfb90a1353d-5ee1bf5fa76mr150609e0c.0.1794349174662;
        Tue, 10 Nov 2026 14:19:34 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c58ed55sm2605244e0c.5.2026.11.10.14.19.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 14:19:33 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/8] transport: Clear the owner of desynchronized links when removing it
Date: Tue, 10 Nov 2026 17:19:12 -0500
Message-ID: <17af9d8a3cdc45ea05bc4dd8f69d8cd0e0dfb8f1.1794349049.git.luiz.von.dentz@intel.com>
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

The links of a transport are given its owner when it is acquired while
synchronized, but removing the owner only cleared them if the transport
was still synchronized. Setting Desynchronized in between left the links
with a pointer to the owner that was freed, which is used when the link
is freed in turn:

  media_request_reply() transport.c:282
  media_transport_remove_owner() transport.c:389
  media_transport_free() transport.c:1854

Clear the links that share the owner being removed regardless of
Desynchronized, as linked_transport_remove_owner() only does it for the
ones that actually have it.

Fixes: 1db06505df5a ("audio: Add ability to desynchronized linked transport")
Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/transport.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 39378ca19815..d3aac8ca66bd 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -370,7 +370,10 @@ static void transport_bap_remove_owner(struct media_transport *transport,
 {
 	struct bap_transport *bap = transport->data;
 
-	if (bap && bap->linked && !bap->desync)
+	/* Also when desynchronized, as the links may have been given the owner
+	 * before, and the owner is about to be freed.
+	 */
+	if (bap && bap->linked)
 		queue_foreach(bt_bap_stream_io_get_links(bap->stream),
 				linked_transport_remove_owner, owner);
 }
-- 
2.56.0

