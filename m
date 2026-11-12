Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794507280;
	b=RxSi2bhO/nPk9QTnzYnR6GYjXF6+bJcu6JxuDfdtcVnGtMEaItbl9rdHfjKUreLBLX2O
	 +SMoPj9+1i+FnlT7xTAhsQt5T7fH/MY8h7bigWv9Bo7dVXb6bP4CWmdBaUrYpkmoKRLa6
	 Qw5LXJQBl2whTG86AVAI0K9P0DjGLd1JPwi7BlYd2+TaHKCSMfL2iwRU9EYjCRvTn+ZjM
	 +icweBcNDOqyYLCuKHFifwdibrcHZYXTFl7DmOjFT3s8pKLV2rDMCFExiptkH4Y7rtRJS
	 fnzu+FA5xf4xt4KneL1nAvIBgDfp9e1vvg7r+7w/eR0iYf/imDEcrPBsF7aSEvEroNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794507280;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5ExTW2XF0lbBjrixeixkx/iXnQf3Iu66Clw/FQQ2wvs=;
	b=d4wNeRJctZMBjtJkjPx68Wa2zAQO12gWJwUKRPdJevUHsPc08GvC/pGF5OL9537SxmY+
	 BuaNBCv56mEIZIYaM7g0ZK/6U3yOpUHsdaOnibamTLtIs6DJB7PG0rOb2fqNMmdU6NrDD
	 SLa7m79fg0n7JCxxOyjSk533uPOonDSRxRYGLyVoL2zE4JSPovFLP1lYq4DnKDa+RNw+M
	 l5ao56dN9SJtvbAq8g4DSjcmrua8wiExaiWTmDTBumb4qJCc0Cj7f4HYFZqTboAGzTj0J
	 tA4+imsKkDmyLVHjezooPP2MY/QjhOMBCnb+2HbTbYqMEAxTsfF3mPLLXpUwdlnIgtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TqvBdPww;
	arc=none smtp.remote-ip=209.85.222.49
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579FF606A331
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 18:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 579FF606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TqvBdPww
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-9851592ada1so55798241.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 10:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794507279; x=1795112079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5ExTW2XF0lbBjrixeixkx/iXnQf3Iu66Clw/FQQ2wvs=;
        b=TqvBdPww4MhnamttmjFVbdjBtVEyb8DFZuFYjucw6gI8wpzuVkrkwTVwd56V3cWpGW
         LhJ1Huf+dF+bhD8+EDBHyvg8m0nD7pE2OmHl2k0rMi+iMgCALwQ3iNfOrSfTPuErtvlc
         HakK5FtZjtiBdObfaAYerD5TMXEODegfRCvtoOhMC8api+Kro1pCXvYz7SoFomF4tGoY
         abwd9gqiD00I5enBkPOAGRBBy3m5KpZDcyLjlbUaWJOWSUYkZtxM7DKC63wBEXKkADHZ
         lG3HAs/6lNVCF232/Z5uBku4neEUIESk0IlfdqmGDdUNE22LhWZ+BD/R+zM13ok0WrOU
         bbAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794507279; x=1795112079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5ExTW2XF0lbBjrixeixkx/iXnQf3Iu66Clw/FQQ2wvs=;
        b=ZE1HUd4t5IMknNDFf3HdtACm05Qt20POJPOSbB82giTDwxOcMvxn3Ic2HKpeDGkuxJ
         JgSsJRgahXwAYYeIvPD8qjOUlDKJj4AW9hUbWbmzsDw67PagmbTPYOEya3mTTsDR8pxp
         WIIzkAQwaN3vU+TmQN3Dfb6h8JWQ6+Cz4NFkQU+Ytk61zmN6VVEgRDBH6zx574X8IwO3
         bZFRlV5soAnxwz3VezfkEYkefLsfQvtkryiCHopGcxsB5eapuAGS8CtSt1vMI4HGXat0
         2NZzpwrwg4m/TXBctBW0vd30fJb30Op1dFnL86MCs4hkAxhoM4cK5kumyx1HWrqFInL+
         Me4A==
X-Gm-Message-State: APuU4Z9QJljuAdAkePF2G9GvyKHyQI+RimWcatokUSO/he2EikpvTZ8P
	nOK3AwTJocJ/kmKdMTqr2tbD/4I1vRPd6/vQ14fNlQuDq/nET0PVl/UhMedz+g==
X-Gm-Gg: AYBFou14+ehMTpNsRMxR8ifcPG+MnB3AjRaRYD7DqyueDP/ui/eFPDpxe4aqrR4Vx5N
	KDK+C0FG/vkKjoALPctJmIHYHEuqkMrExvnV2T8BqIvTw6aNqQRXSwSdl8sX49PlBtB/L+Gft9W
	z3UhIVpNhL0H77Qje4xEgBlMDz5frAiPappIUEFEisyApqSvSa/sEAFy3iihBzv9i2CZHe5cCBl
	lF9nBX2yj4DgvTWNZPcifl9LDnfGfvUajre1V1G5bf/kygCXSM0clU3CAIEx/eCMtPzXgMU8xBE
	ttdmKMXqq6lddu3qIGj0Tj5tl47Ac1Qo8KnU5B6yIOgPUY/sRcZ4ynhmlRUuGjFkKLAhxSVn7AS
	o8/+vVZCdfUPShZvbkL0Zgwudk6c8FcVA47QSSqXszoMRknkVTq8jLtEoL02O1VbLgR4zSbQgAa
	eFuWfkYrrhBnNwt2O4d69xl/smwdrzOKjsSkQIKXt8jQGrnCTZyHy+rLOnsdCCdYQXnnfo7q5DI
	YfDEWEqFbL6PQYJCA6d9wuSJvwt+pw5Kfhs/2ObSnXtdxpsfkGld3pV/a0C3sxOweMbhUyb6cFs
	FxiEgnM1c0K+2dUUV61EmfUsAptH3sD4HwE32yA8hsWgfif+2Ur5Xt39Q86IIe5f7lwJpDVUTP+
	aqINrSpXJXWe18/G8FI7AslvLnI8sPBJZII1By9p7nwpgQlOcwxMpDO0x4hElrjvKGGbcczt8VH
	pqBfNvoXWUFu75Omsnsfl8mPqZ
X-Received: by 2002:a05:6102:32d1:b0:7c3:a6f0:99cb with SMTP id ada2fe7eead31-7d64db100cbmr711137.33.1794507279421;
        Thu, 12 Nov 2026 10:14:39 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d64c1b33eesm178749137.2.2026.11.12.10.14.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 10:14:38 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 5/6] doc/functional-bap: Document clearing a cached configuration
Date: Thu, 12 Nov 2026 13:14:30 -0500
Message-ID: <58959d386b3510668043b393074e097f773e09af.1794504552.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794504552.git.luiz.von.dentz@intel.com>
References: <cover.1794504552.git.luiz.von.dentz@intel.com>
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

