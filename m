Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794587887;
	b=1xv55vh9lPY9Vm6h1ienECYxDjMSkiHg2wU5KE5f+ALdxtSyRf3n/csqqcMn5ia/xNkh
	 WJ8dIZRXR3iBzvVUDESskd/fPsZLQC923Cy53ifYgOLfR65kV4BjYKfpaznCwXP2wZIA3
	 GunsM9gRcdixpXuVDoKNzifjVKE6hDGaAptLbjTCBBvakaWStI1LJ0mc1ykxdBm/12T/X
	 l+kvAW2VKHJdpXdAHq5FVZW+PxNSXBnUqbSZZPGJw31wzDiZ44h3OIvZVeB0VX6mWcwo+
	 At4QJVFMphEGmBvhA77nDV5iHGZhU8XiMiOBhced9YG5zvtQK9KibdjvCErzLiwy4Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587887;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5ExTW2XF0lbBjrixeixkx/iXnQf3Iu66Clw/FQQ2wvs=;
	b=YliL4VgN4hgiyHHBM78DMew0by97/OwrwegFWW77SldOqx4d2CyASF4p3K7G4oqopWbT
	 mJ1KXdKxvi04Qrhzg3LGZQkTxlENwr0e6xIiyOWiNKtfnbM6HGY8My9FpQqrTrSGytiU9
	 KBwpY6MUyDKGw1p6pVwhvpDAeFb8PvdYjc6DVwQYVZRyaYKDl13v64+qoHnqFom/bveGh
	 psVUYSJXHkqytq/l/DcSkqkPe/fWye8t6ZiyNbcS+aFU2EAL25rDGCzpTQqNoWbZruVZ/
	 IybU2M6BPVBXmeZYSUdm3chUGI+nbYPQZl9h01tJE6SR/YDYZm2k192ugzIF6loB9jA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mds7TUOQ;
	arc=none smtp.remote-ip=209.85.217.44
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7127E606A335
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 16:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7127E606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mds7TUOQ
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-745497ac8fcso360737137.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 08:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794587886; x=1795192686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5ExTW2XF0lbBjrixeixkx/iXnQf3Iu66Clw/FQQ2wvs=;
        b=Mds7TUOQGjmqNUSyP+FM5nhAp09huWT2volxQ20+c9oDFgXovWWg9yD3f4Yx0tiMzP
         Qyb06GY8YXdySpOZphXjHKwW5GuaPXuQQndPnuSZ5SrmS+/MrtwfXqf934CHc+tmqZZb
         clY0gPI3TpdjtAb3x0JMYtcVQmLQ3piLxAKdpNgl6ul9nxV1qSWEpTjm1m5+V6kDvdW7
         yrre8tGOS1FNN0R7DEGQZjugugtH7+KqezNb70bFlGMYhDioXKL2CBhPQXDoc+oSGNRH
         x0wUVVhi4enPHVu3kE6Nuo2eswcCd/cB9PlXkDv1WRqmrQsC7fDSu/v2yIE4y+6YN6Aj
         Oh0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794587886; x=1795192686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5ExTW2XF0lbBjrixeixkx/iXnQf3Iu66Clw/FQQ2wvs=;
        b=1F8Tx9SpTMGk6GzL7Z2D780Jl24RbKO1oOWeXSZQ8+uUISiJdRGKGERnqwrwz4vkaK
         bAbEYf2ha5eu3U65aXfJ0NhjvlYoaRcuM5po6onfLCw7x4JGRyeuudF1CV9KNT5fj4OS
         SEGvY0lXvP0vTItIgWLKm0KTc16nyXc/aH6vBlT9QZBRGp0qG2xNH4FvOPFO6AEFhboD
         zmn4TScPl6LorG3P3FRdGilpJ3qYrmz3TTFswQP5xqaaWDFqf8aB6vo6WLBLzxeWFkIR
         QNDO8/560Nig2hv3p6aOyC5Zkh2xURqLncBVVG0O9Ov1CniAwsxrc0y53TltcuVMFKQi
         BUgA==
X-Gm-Message-State: APuU4Z88uXu5w6wFFrCmnpgoJx45hp2KuAvAjaJBY1fVPQ9yUpQMf9mR
	QkvXdNTPZd8/+Bl3fWVqDMtmE3sQIFudBKwURYKvEHkKFs6B9Owv4h6SZwjz2yDSHfg=
X-Gm-Gg: AYBFou3SjyMJdo4VZk8wxwZD5dClxvONyuLwcnlXiV66ZQy9PPot6xjOd9JpGe4X26M
	+3M2v+XdmyqYr0RpofZyuiSsAOYu5KvvpEjCkVnwxjOnOB07RbsAFKX394FwTxVNNhwot8lMqW9
	YlklSEqKDkjKZdGWV+w0MbwiXdWTbBJ4q0bjAFyWkw2D4ORvbvtLbmbdWRPfRQ06cFv72sin4SV
	srk9KLWxma/eNjEGu4AVVPKK1QOhOiU0/O/gYnpXC8w+NM0cL+/Xp2OyasM/UYHhIvTf3hh7SF1
	NeAqU2v1bM+6CiN8p3iXN25lD7smGmTYnoE4LC4ET4sWbl/x8XD8G3569X9tlALVn8VSbuMNjQW
	NMKylGEGLfyZI8KFXCKv2jw9k/1AKBJT9A5iIS/UHsK5Wwl3+SilZHuVYpJx7iLMB8a3ACgyfMi
	1O2iJx7kVBIlD+BE8tBfwkRYwr6+QtZC2u6NGMC+TgSWwfsHD608jD6kOizSyoVV7CqaMLmjXCJ
	jeSyG0znXlvsG3b7uk41CjSwDpGzUapGRvnbOo3w/U6e42AuPBRKu/OvVP6l/h2bsh/E1GYUvSF
	q5AD0vKox/CfLMgUCUReyl8dlg1IKq2tlNA+nrJFu1Gc8vs49r5zFaMlhYJMkqlQ/eobxEYr6CY
	eRH7OiPab9cPu3LL9uQDfTnrl/WrBzrdEAwE2iEcYX6tnJAbAEBhgQcoPJqwikIvXWpxZ3eUtns
	61+vMf1ymRL3U6cJD13vjBYVQS
X-Received: by 2002:a05:6102:644c:b0:7c3:881f:b620 with SMTP id ada2fe7eead31-7d64d7d2e56mr974258137.21.1794587886294;
        Fri, 13 Nov 2026 08:38:06 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c842ac652sm1746701241.10.2026.11.13.08.38.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 08:38:05 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 5/6] doc/functional-bap: Document clearing a cached configuration
Date: Fri, 13 Nov 2026 11:37:57 -0500
Message-ID: <5d6e78d77584a157fd07a2001842edeaff11f322.1794586887.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794586887.git.luiz.von.dentz@intel.com>
References: <cover.1794586887.git.luiz.von.dentz@intel.com>
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

Describe the test where the initiator clears an endpoint twice, the
second time releasing the ASE whose codec configuration the acceptor
cached.

Assisted-by: Claude:claude-opus-5-5
---
 doc/functional-bap.rst | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/doc/functional-bap.rst b/doc/functional-bap.rst
index fc367e0f9181..eb04e6520aa8 100644
--- a/doc/functional-bap.rst
+++ b/doc/functional-bap.rst
@@ -230,6 +230,30 @@ test_bap_unicast_desync
 	single ASE of a CIS, so a failure of that one can be told apart
 	from a failure of the initiator to enable the ASEs separately.
 
+test_bap_unicast_clear_cached
+-----------------------------
+
+:Setup: As above, with both transports created.
+
+:Steps:
+	1. Initiator: ``endpoint.clear <remote PAC Source endpoint>``.
+	2. Initiator: ``endpoint.clear <remote PAC Source endpoint>`` again.
+
+:Expected:
+	1. ``Configuration cleared``, and the initiator removes the transport
+	   of the Source ASE, which the acceptor moves to Codec Configured,
+	   caching its codec configuration.
+	2. ``Configuration cleared``, and the initiator releases the Source
+	   ASE again from Codec Configured, so the acceptor moves it to Idle
+	   and removes its transport. The Sink ASE transports are left in
+	   ``State: idle``.
+
+:Notes: Releasing an ASE in the Codec Configured state is permitted
+	(ASCS Table 3.2, BAP 5.6.6) and is covered by BAP/UCL/SCC/BV-106-C
+	and BV-107-C. Without it, an initiator could not get rid of the
+	codec configuration an acceptor cached, as it no longer has a
+	transport for it.
+
 test_bap_unicast_duplex_enable_one
 ----------------------------------
 
-- 
2.56.0

