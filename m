Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414349;
	b=qYcMi+AisS7Yhhju9nxM3gnsO06tThd3Vz735gHP+rxO+ZUcoG0Pyc433Rjp5Xztabw8
	 KcD0Ahpdws00eMBZgCjx9xCOcfUeeQZIAzeHiytguz5L8G47FB3glkC4W+dxrrs3fCSAJ
	 f7Kucrv9N/vNXpcyz4m4n32+P4DyL/rqHMtLxb0Tw761lmAMqEvh5EcMZ2Rx/QCd9ERZi
	 5lpiunSJnTOhJykxQMAB84y0xsHsKpYHv0pmsKCQy+4b7UsJhhDXvQOizrAKLij1xhkeN
	 aUWkpnRYp2oYfqqYGK4lRIBsChLNYIHJAiU6tV9JEhKUgIzRl1P5D2pHEMBU+eJcwKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414349;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5ExTW2XF0lbBjrixeixkx/iXnQf3Iu66Clw/FQQ2wvs=;
	b=Y+G5RatmfdrKspgsB4FAQd36V4jATubmQspRyyAMKLFobfccedmp+KLdsnMOv0OfGarJ
	 37rVZXx/2zAdh6JcewNH4rj5DFxmgSgVsHjaDTPAUs9RfhyK2PTaeBjrYNaXYINlO4MlO
	 S3qey1BkCkvJJb0nGgXURWqCYBWBpDLM12Iih3JzWPuFhon8xrQhtOKzf0azIqPut4SB3
	 Vq5bUxkOssl9kHd77T59XuVr8fGeo/N7rvZ64Wy7FCfRKJjDWIuflZpxCfoyP7uV/WrFw
	 vtK1qIj5XwaCAAaWjpAM2le/m2flWN/PqGNmzFXtv5UytPGDUkkJ35NqcS+09R2o0hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=szLm77Pg;
	arc=none smtp.remote-ip=209.85.222.52
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2BC606A32E
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 16:25:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC2BC606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=szLm77Pg
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-9908c849564so944325241.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 08:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794414348; x=1795019148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5ExTW2XF0lbBjrixeixkx/iXnQf3Iu66Clw/FQQ2wvs=;
        b=szLm77PgeyPky6hNejzMkVP0cDjOs9+rXqCrUTf5cbyyYTXfKcfYzB50AD4mUzmP9C
         LFiwRvETmn+pfinHzj/pVJu24rSLWcDqadFBNrp1/IykbR5qpKaJoUOBw58ROOb7AzdP
         szevg2HnIX0nCab/vIOQvHMfVqkbwXaCQxBalkL70aFEpE/DdmKjlLoNvdZMC/ROc4/T
         5oaevqDVlEuTHPrqAyGFhQOLucUS7twRw5yukxtSrb1MS97o+KzAyRrDZcaNRgszWGTk
         afJaJixCpsjNoeNX6DbUvEIRkVT5qwCdjuPxI2FPEpo7LiuwHJhiJh0nXmlRjhXMfc8c
         qZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794414348; x=1795019148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5ExTW2XF0lbBjrixeixkx/iXnQf3Iu66Clw/FQQ2wvs=;
        b=TzQflPyNNmKvWo3ZiLA6zNGehVxQQ9XYPGLrScNAplgnIjvDbyXhMAB+ysq3rOWKZ1
         dE/DKjM9g77ihBZGraY8vltRIQb3amLeNbbTQLps8z9nREhCNQnsdNvLSkd2CfMv4RhD
         aNPD2Pem0LsY9VC2ds11KmTKhk11xfvxbkB6bDuUx6Ibp5ONRn47dObsqVeDMYlcpIgY
         7LomcwY+cG3GOzv48xrBkSIpm8wDn0BbVXRkKLe1w1xk4NKlx0qc3UWNZLKRCF2iRTNN
         HQTb5A2g6oVWAwWFBwiwjWoXBrug3BIqP4fWpB1lHHP8cMsPYgsC4hCjqKLmg4APtg2I
         QFDw==
X-Gm-Message-State: APuU4Z9lLlp6//r2j2pouMpMe+5QoqK6VVfGVfHJkOIqrhiSl8k2bt2Y
	YkTUMRxrwEwVSup/JXVd3tyPSwF2f5UCLlETZ4v8E/CnmBo8IFNtvfN6gySCbQ==
X-Gm-Gg: AYBFou302WrXSf9w3IDEs2WFp7Pjcv6f4fn2PSMNMQs5WVheKY3g8gMxYUCVRLc5cUg
	4RmrEDi5cPb9PoXPxyFI/FOAHQl9f9RZfdxcpq7TZavtb+/kH2JKNkd9g6OKmGLpy/xzSpNyr6z
	s3rKoutNsPTWFhoMtcc7SvA9HLtUbnuoebKyP7t7JHyPtSrpApcs+yOBs8zEKv1ph/YAkfja/gI
	7vsh68NL+tEkWCcFJKOS2MT8eD6u8S671bjQgghTsU+iEy9DNfsvjagZE9Pr+qyAmfHHhrilZv9
	+53Qs26NghsdUPM9VsCRNQhipEVn/STpRmvFWRxvxds6KRjtA/OSwRkkBYuhfuUUDsdgYws5RXc
	41nsUrWMGwL3Lah3NLnp8qegKkvBbc2OZ8rv4DYOmxx7PzKrPSEI77ktBBN4eV5m5iN+y8nKfkE
	h1if3IGWbzt4m8ZYbPt1yTDl7HxYyKDnbN9hqOZ3HmfEllN03hU0TwrJ7GM/01BTDmbSB947+my
	ydryJ5wFhJNuS48lhJNOcMgRBNV47PhF3fXrlxrQUbYsFybr8y4EWzX7xyuneZz9k5Ek63HRQif
	T3tAf6dSEdGlU2XIBj39UMPL2naxqmY5VQUPVryoKtAyfr0klrzX02bWzn6lyyCaOTxqAYoqT1U
	CD4rZSvPx6EeOpLdwBV+FtliD/N87IQwoP1bPEAuGsu6yRJjLHjls0RhVE8jTCKITwiF3qsXft5
	GB6pQ=
X-Received: by 2002:a05:6102:4bc4:b0:7cc:1045:610 with SMTP id ada2fe7eead31-7d5061a2492mr1006446137.27.1794414347563;
        Wed, 11 Nov 2026 08:25:47 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c200004e7sm4269659241.3.2026.11.11.08.25.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:25:47 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 5/6] doc/functional-bap: Document clearing a cached configuration
Date: Wed, 11 Nov 2026 11:25:21 -0500
Message-ID: <f38481e79b4c9329c7161d5baaf66cfe37a80e9f.1794413813.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794413813.git.luiz.von.dentz@intel.com>
References: <cover.1794413813.git.luiz.von.dentz@intel.com>
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

