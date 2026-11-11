Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794429477;
	b=NuoDvzJaXatEeAADzSGs2zknMtiYZeIIeXSTStVIQ9QsSd8goMHh7xMIfu7DVp0wGO9a
	 kTwfICDAlxKh+atCbIFCV43zVoC2rse5+M8vZcpbSMnGdxUIV9pbby1ykn4tZ0UFlNvWp
	 4owTY0AgB/NZTJu3BeykrrmlYGw0CshbWfb4mm9SXinHIpQizDstJi0js5RMrV4oVtb9z
	 wZeID/OvbswpJcqxJJCOPtFnd9PZO37Cz9HGv+F3HiAKshhfTCDa4x0LD0+7EvXclCp0K
	 D993DRKjiS6Y8dn7PEC9NEcOkGSzFiScjn/5LDgJu7BSj5ZJM/j5Fe/8cSz4u99AbUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794429477;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5ExTW2XF0lbBjrixeixkx/iXnQf3Iu66Clw/FQQ2wvs=;
	b=kEmyjy2G42td8s+Vi7RqeplUKIKCEe7oMxa81iZTayvXb4p9o43L1NKbfyjR6//byW1d
	 hVaXoz5aPoQhfbPsxDzQZM4TX2wgNQ3g1O7DFkuENHZw3+OiiiQ8jIwX9V5Ab9Z/ilO2v
	 VsX6b574/wy/QNw8tVpWqgQQSaacjVRybxhm8TwqmdobrRIiDwIEvUoZjoGqdpDyDwQ/C
	 51kF4pbefyA4lOXnBhIhNxIKZsknygZHPuxEEcznM6ZRTL1yPm6Ov4RJ4t0UpD4wdlvcI
	 1dZWdB4i4qQkIBmaJVdgPOrhqubkjP0EYoB01yiVltV1X4cncMUDmZ7LbP5RZXhtS1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GOydbHa0;
	arc=none smtp.remote-ip=209.85.221.177
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE67960A261A
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 20:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE67960A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GOydbHa0
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5eafb65e169so1894606e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 12:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794429476; x=1795034276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5ExTW2XF0lbBjrixeixkx/iXnQf3Iu66Clw/FQQ2wvs=;
        b=GOydbHa0a1gsJNAeLiRJUUqdXFR0L+Dai3g3cBX15HGJ+p62Rb734ywVfjHlPCFKlT
         BIK1ZbcDYihN8dyNm3bBBp9ogV9cuZsggGYU7eOpMZiKGPOaUG17XbTviaacxQk/bGTq
         ejFDJsHIhDEtqSY4Kci38UsmlNHAqI7hZvQD2jun8UwxuCRyksBfTTAINr2RCk4lrBYf
         jgKgatxB7eaQFMp67cYcK09/5psR88i1U0aRowdVHCkwPWo0lY6SZUGIbdErQY2PjrKK
         iiG1gys5aFg2rzHwgxdFYfbZPSQvnrbW3a0H9l1VzscTkrgPGnqEJ6LE6dgHlhD6+Sa6
         nBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794429476; x=1795034276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5ExTW2XF0lbBjrixeixkx/iXnQf3Iu66Clw/FQQ2wvs=;
        b=K0Pa/QVUUMVEJh8fGpaCgomsjJ6LKpyRXNr6D9ZOPKqH+2llL42AIbBgziqVM8P7vc
         hgo2Nt/3JHVVd2By7MEATa17uCcKamA2QmkWvtTrVgUat3FVzQYLMqsprimhGmHURAwF
         ZIx9KLKWxG98dKrbmmvLa0m3gKlGGYQVfge+VENO8vgUCWiX2pcFfkM9SYK2WY5NB2Cg
         4yrLy4G3mqvYioqy2tXL5fSbc/LIxdrN+ng32Csam3MmjxwGI3kEQFIFH36erLhNMsER
         5ggfj2lUhSH9Nd4SZlxzSd/RP/PLF/fkINrqEbQUbFVjuV2GJYD4e+EN1RkOCxN6rZWn
         dHcA==
X-Gm-Message-State: APuU4Z+CJAW5fqdKSp3KcGaHM23kYLtOZbQXT3CKHBPh5Ksym5OOMhyv
	9b+wSpMae0G1WJSrhuqNG3ajpaM64pvsn51TfpBEjmuA4+q/cp6ChpfGnH3u8g==
X-Gm-Gg: AYBFou2jFEcXm/ul+c+BokX+zQjwwqD2UooxPN1oKknMnKyh6VBx9Bk/4nkPJb8Ka5H
	pDRJ6/P/i3GWTB3OfIcZ+e147dlLHhb6IhkqUnTaKv15RHbjRfteFG46g0hFWZ2C/Zd/1Z5Dnic
	GFh33mc7JJ+tMaxuG2AXl/0CdYVVVCr30h8a7DCTsavjX9zE3BTBvueQIZC2dRVP1RelzPRm4iQ
	wQeGMf3Ihz9iJd7YD8nume/p/YlBaA9FPGUWhW9CYPek3A21sf7oJnvBIiNjeyrS/m5DmlNcjdd
	v8xx0Zzg/UC5Ha37NLoYWWhyxWkKf8nqHDpJB6y40pyDzFYjtqIVkPtQkEAfj9RUSNd+FJEJHgq
	g4J+Ih7II4a0rwj4kn/WukEe32WUyxUvONZvQFsHSnPSAYrofrt/nnEp5Cbra2b194GpSqDtFJ7
	eHgcEWqEeP5tZbZOWz0vuMKYQHwbRpavgUuVTINw15gEM++tzH9nVBDU3hK8/XdhZiABqkvARTp
	cmlGi9vv9nl5nrgUfwZMoqSCFIs6eBdGInhzgD4Md2O1sCQczvt9QmNntjAaguz0i0cHNfQtty6
	ecIPZwaG0zluvzGgWzSOU+gYmxODXdL2RUD8hqYEd5tsepnNS1Vff+4WZ6heGtarwwzYrrO+28S
	5X+az8s+w+dKeFmEL/rvOeh0hiS3fPsKGRY99kSj4koZDj2hIQIqjy8WFle6VzuSPFtXncrwmfN
	XElks=
X-Received: by 2002:a05:6102:3c90:b0:7cc:226a:f977 with SMTP id ada2fe7eead31-7d5061b8f92mr1496357137.36.1794429475741;
        Wed, 11 Nov 2026 12:37:55 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d302359221sm4762571137.6.2026.11.11.12.37.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 12:37:54 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 5/6] doc/functional-bap: Document clearing a cached configuration
Date: Wed, 11 Nov 2026 15:37:32 -0500
Message-ID: <e1e4f723d0a169b2703c626bc03a925491007e7f.1794428234.git.luiz.von.dentz@intel.com>
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

