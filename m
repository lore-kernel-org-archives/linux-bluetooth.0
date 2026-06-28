Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C20352034;
	Sun, 28 Jun 2026 09:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782640514; cv=none; b=Pn9wCrOPZdiXNRg2DQtyauWTgqjDcFsJ+KSn/BlK4Vd8XLHxXOTdAjfOUo+z3Tvjlk8hmRtEHOS/QvYwhBWuYDQ9Iy8lZcpGJPqKvatX3cgxouugaB8U2lNrggIErmxJo9LFUcBVD05xgvnV1mgp/0JfANlsapZJ3GeHnPRAwh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782640514; c=relaxed/simple;
	bh=KwXU34U7lkBFGRunkbLBHnejKOoCC44ouuTRRvYLj1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tzUi9yGPIQzmtXf09ZcWBms05GUNN7DBm84bsoXDZngkZowWXsxIG7jm1G+0L9jlryayzcG3EJwuaiw5tOCHGLo81+jwk6eYLS9a04FjCQY9eKXmW6LjLV40CbEEHkrqti3cS+0FqtR2PmSueWjxKbAKXOyBFoU2o0BinuRTG0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=whynothugo.nl; spf=pass smtp.mailfrom=whynothugo.nl; dkim=pass (2048-bit key) header.d=whynothugo.nl header.i=@whynothugo.nl header.b=EwecCdH2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RxOVRsXB; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=whynothugo.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=whynothugo.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=whynothugo.nl header.i=@whynothugo.nl header.b="EwecCdH2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RxOVRsXB"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3EACD1400094;
	Sun, 28 Jun 2026 05:55:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sun, 28 Jun 2026 05:55:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=whynothugo.nl;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1782640512; x=
	1782726912; bh=aRNkgvuJXgHJarZYFLFpx6L64G5fFQsUS34rwINejWs=; b=E
	wecCdH2qni321fVD2t9dS3FTC7nldKEQeZ7p9oKyWMT+sv2qJJKVwCgb8Itv2RZe
	DYUT+79o8JGQurFejYHvS6oTgcyv3Kl/ri3QO4u+Rd5OuVqufbkrhQkUOECI1ZIT
	GArT+j5LPss3XkYqO0XscIGfMGQLHcPM2ULvE0p16FL1bNYgesLjZEaxLj5QkuUA
	lGH89D569gi266RttOjt0H/0Hm8APct+LTncQ8UHNmBaEP2lsn84XO+7DEsjVlph
	tDx+ittGidvybnhT7KGqbHwRpsIgRtu5CTwILUqwcnb0uignx5ddzFqD2AuZlUaI
	awuyS/d91J2uIGwOB0Zrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1782640512; x=1782726912; bh=a
	RNkgvuJXgHJarZYFLFpx6L64G5fFQsUS34rwINejWs=; b=RxOVRsXBjXVYfsdho
	OUt8L1RJXKKDefw3uNYiHq0T5Mxr3q4t9Xvl5ssh7KYp7UAbemwWlHelF+h937Xk
	EVCGmACFkwsVh1tKGNm31CR8uLC5FbERVm63WwjStXHG/Cs5W5FuoH6GLtemU1sp
	q6B7KUJwuAiRxqqfVBtp70Mem7rQSlkmiajPp3xtr8v7L9foR2h/WiprCQenankz
	hqs4JYPxDEL+M0gyCkMTy+qqSNFSl/nCyH4+4Jm6mwR4rgezXWw7+4dKrzmloBTF
	//2hWTpLAdf1PzmIYONQBgHJk5RrGsTAogXIZxlxTXx8Ndp2bW0jQy3plPK52wNH
	OcwEg==
X-ME-Sender: <xms:gO9Aas3qMlAkOEbMkSBDDVUpfdGL5bRki-lXiZT0Hkfg3lQcYpbjPQ>
    <xme:gO9AatGeoPgWu1ptL5c2r3txxyURUw0pUHJgtte-nI6Qk0fqdNaK-jSeKRFI0b--R
    rHmsR7n6wF7wsXso5cXECElWIiHsnjo3jMbMkzw9RyCKlbwx1WjXpo>
X-ME-Received: <xmr:gO9AavvNf2W-HkqSz6oGx4ITFu1JG7VBuxFAyoSEK8BKliGYEAO8-WEs7srKb_yZruWTTrMQ438FPnivcCU>
X-ME-Proxy-Cause: dmFkZTGdMjVpEsMG4j5KNhV2XTmz0z9tEqBHC46+V8A9v3IDZq6M+ryLs1cV77162xPX1E
    bT9wrj0nuGJEvsArcdWLS1rdd4CMhymiFoaQI75Dpg3FLTwDDpToyhvk9iXY4PLRjmSdH5
    xPzt3wI/PF0R8CVOMOKAZ2EiMtlsq80gtmfJZrK8V8KUJt+iikD7ycHyFhrFmYnIlg6k7q
    opXe5glztr4YSYAS5PMTVipt9YWb5d3xq4ir0rj+M3OB0GdC1owmCvKaqrIL8yYK7EzEA+
    +vaKiBNuQecECF0ZTagkFyMjex8yuzLL/4QC5rIzjzuyUarsk+svd6+9CalHu+ICmJXWAg
    AUjbR0rzqjtG83VvJxNkZeeVmpEBOjwBo8/z5SuQ8EwsT4vGQk7Z5sFeVF9xCHcX/ORj8W
    d9mUPfL4XloO2xnO/Zwg3+gQRu98Y47qhhps9IMfm7PGm+3aQs0nevH0vHAFE7QqGO8Ehl
    19MkZUjNpcqPHzaGP3A+k3LouMUx/gKt3qNL49S1UKsTEmxfxGrfSTP+loJd57Hgj+daye
    IO/6CY7ThHxEcibnvBNjjG8Rkl0znjxAL0bKAbIdV0V1TyOnHVmEV5EO3wC+gOJpr2OWja
    vsYhSkFxo+A3+GLrr4ioIcqLg1h+ax+BKHl4DHblLAOaPIgJX0JMCKkYA20g
X-ME-Proxy: <xmx:gO9AaopGUFqUMgLy5GaT0bO4PL_-BXhEMLIjGXaWCyjSTpgNk4K9pw>
    <xmx:gO9AauXGQNBZfy5E2l2n8WV61CgAulVgpds5xSl1kZGAYu-RC13Niw>
    <xmx:gO9Aao3z2jGBAUC6bsLk7nhJutp40EBP_Jlk9bYKSU4VMc3MPJVgVg>
    <xmx:gO9AarukVLTvOJsIQMELAvCVGJvg-5fVSkK0TI4tRLp_iT_YOrfCvA>
    <xmx:gO9AatmwCRY6TnzdGW-auV1HhhJYcNnhsCqMH7-8H4HCNbyccSznRfs1>
Feedback-ID: ib8c04050:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Jun 2026 05:55:10 -0400 (EDT)
From: Hugo Osvaldo Barrera <hugo@whynothugo.nl>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	linux-bluetooth@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hugo Osvaldo Barrera <hugo@whynothugo.nl>
Subject: [PATCH 2/2] dt-bindings: bluetooth: broadcom: add BCM43752
Date: Sun, 28 Jun 2026 11:55:00 +0200
Message-ID: <20260628095500.29810-2-hugo@whynothugo.nl>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260628095500.29810-1-hugo@whynothugo.nl>
References: <20260628095500.29810-1-hugo@whynothugo.nl>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the compatible string for BCM43752.

Signed-off-by: Hugo Osvaldo Barrera <hugo@whynothugo.nl>
---
 .../devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml
index 95501e858e6f..04e8a968548d 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml
@@ -29,6 +29,7 @@ properties:
           - brcm,bcm43438-bt
           - brcm,bcm4345c5
           - brcm,bcm43540-bt
+          - brcm,bcm43752-bt
           - brcm,bcm4335a0
           - brcm,bcm4349-bt
           - cypress,cyw4373a0-bt
-- 
2.54.0


