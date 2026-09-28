Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3034BD794
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 15:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790609936; cv=none; b=cQmm0xCW35zVAzkUUrckLeQ3ADJf+RMo3brnDCO+Wl+HRdAsfiy78BJFzLw+jj3WgR6Q0rbqOd2aRPmkONnppyLdg1a0Bm73WOLV6XBCLguMUpP76ChENvA6L9dvTipXmr/TykoDLs3WAugpEbDASO3cACZijBrGQTnJ+stL7vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790609936; c=relaxed/simple;
	bh=vQbgwjl2Lv/6onjSG+rzPCPoufv7tprD55wyPNTjwns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MYpRJSRG+3nk3ETzmwMEJlv5LPJ+kkXIevjVG7B3lkJRZq6wtvRHa2I1JpinKSwYqoWUo9ig1OSsuUgYqGO1++n8pC+qH6CW9+rLUYi1obH2CGBN21lR+0Dn1T3CrtNHeWsG4DmLgCSf0gdi53opPf1rsGX1DPpflssJHWYwPw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=caeAL0Up; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caeAL0Up"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8e6ec4e0bso2767573e87.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 08:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790609932; x=1791214732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vQbgwjl2Lv/6onjSG+rzPCPoufv7tprD55wyPNTjwns=;
        b=caeAL0UpW7q0azF7dpGoItApATAX6L5lMRQ3vu+GMkYt/c3g/GqFOxpYSL+680OqHJ
         SpXx/T73yDqAvawMecyN6fgA7DCOhO73Q+pMnttm1aIFTf05SP1N58Vda6P5eNDO/Md5
         Vqkw2PYsEZhyxqPts83kcuXfc2pHCcuYdyFaDPFKS5LT0zW0A6/5AVrXlwCYD54D2rtR
         kJYubTDgLLlvwZd/4WXvJYmRKOnvq8gXICayJHLz202U5FDvacl5a9By1wL5Q1PWyvSf
         d+q4Zv2xh3fbG1u2VvfyHudhbJqgu317g9djvdkygmSfneaV3oqryVzEBZakd7fqhx0z
         1G8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790609932; x=1791214732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vQbgwjl2Lv/6onjSG+rzPCPoufv7tprD55wyPNTjwns=;
        b=hYTV1N9YcWIuzRYFDkg0FVMARtDs7T/oPMFzxO29w3zQBJUn+VDRVO6nnmLAYycA+W
         Ti63C8zDfPZRQOKMHr+W18lfbJWk19op4LWp84OMby+ww4FWF6zkl0vHPZqzeNPXrbyO
         iWBzAge9sdzJY+Yqd9dBmefeuzpLtanVRTmcbMyOk4lj7Hc5Sr/vi0hd8JTQrCAH+dsT
         9ME2XYshfWtUwE5CP5PJgsZVnjfi8RpvCfPBCLnzUM7d1hzGZwnLdGvR0Iy5p1ubmqgi
         CBLu6OGlMXtmAWZHqNM5rTmNupMRh5Ck7DCIHDP7mlLP3XO6FYuyYPwDYkdpZreR7d9S
         jT0g==
X-Forwarded-Encrypted: i=1; AKwUvBz/aiZPqlGM69DQ7D8wZx67aG7AXo6LCV1ityL3uu60dz4t0/ldaDFKmAl7FOH5yW1T7UlXCP8vuRXkE6Wdl3E=@vger.kernel.org
X-Gm-Message-State: AFq9FYJkH0sETg3b82YLEUED263KjweMd6js/257VKzhegzbDuNvJADj
	0hIJFDEZAensTECkK09vs7e42x3vkWFebumZPXAZUDCSTjwC2G7D4NAgkujnIamwsmo=
X-Gm-Gg: AYBFou24i1YdfFA+hgHaeElcAZE1cgeNvBhrWgvdvOMtwbgTa1DU7OEtx/WENtL2D0S
	PUv2oxR6KNTfj4TI55QWld+0FdPyo6qP9swacYZifanMm1f40FFPOGz0ct7sSZo5LIaAWIHx4xe
	gHtdH4HSCGaP4rfMddfe6r7HIr+V/fVGfxAEVnpYTIB3dI/BAE+WvYemTey/4TAxrDkH6DV7itZ
	AEqPLeOqeiHyn26eTUlvWAqjEca0xlCNMpx3OKqVPchIPecUUdYqj/iXbZQSk17xHUeh7VMLYk0
	yJhWZZavELA9pY8Zwt19B2GHFDFju6cxsIrhhZddDeopTTYqLBDIS9V8n7D1A+3Z8uzPDbqeaRs
	pBeKFAqAHSm1wuFcjSdExnOngVgbC73bMKjVASnMhU3o3f33OlkS178k1A0XB7X4K5AajUZCc8u
	BB5dn3umIoz8fNxWdxmZjapvdvsxsxHGMbzRxLauMHbO8MTj+mv4pAR6FQgiyVrFSCImKdIGrZ3
	LavH0b+wXMtAQfB
X-Received: by 2002:a05:6512:3054:b0:5b8:f52b:8135 with SMTP id 2adb3069b0e04-5b8f52b825fmr1684490e87.17.1790609932127;
        Mon, 28 Sep 2026 08:38:52 -0700 (PDT)
Received: from localhost.localdomain ([80.66.93.148])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b9debb8514sm635867e87.47.2026.09.28.08.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 08:38:51 -0700 (PDT)
From: Maxim Skokov <skokovmaksimevg@gmail.com>
To: luiz.dentz@gmail.com
Cc: marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org,
	mikhail.v.gavrilov@gmail.com
Subject: Re: [PATCH v2] Bluetooth: RFCOMM: free the skb when the DLC has no owner
Date: Mon, 28 Sep 2026 18:38:35 +0300
Message-ID: <20260928153840.366359-1-skokovmaksimevg@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915070119.45143-1-skokovmaksimevg@gmail.com>
References: <20260915070119.45143-1-skokovmaksimevg@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Gentle ping. Mikhail has reviewed it.
