Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118E9476040
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2026 08:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788253046; cv=none; b=TZQq/k7q3C9QaO5n1Soj1jeOPwhgI5st95mLSQIWRsAdX45obI/ZaEeJCyflRN5V16XfAlfLvYcAxgXn5wDy5bV0c+26AWkLfPpR/SG8Qb+gvdvASogP1mu2x0pOd91ZGDRVqL4toF942x1VbB+5HDQiX4hIl8Cd+JJ32hIZ3ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788253046; c=relaxed/simple;
	bh=5EN9gj1NuJxJzKBR19pdp2IOB3VptHKZV61+tHNfah0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DD3mckUz2ckYFW9MBpuyXsNw/Gwz2VmL3vP4aCvTXDCt23udgfP4ykU/jKfdHH9Q9VIraUPh5VVFY9TCF3AfCfvDznZve/5W+/aPvv3QL/RvQwpIcouMgX4/019dgVHRhxHk8Ppm3VfuJD3pJHVr2QqayuFlHLDYzJF1PIwVM5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com; dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b=G14ku1Yf; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b="G14ku1Yf"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38511175ad3so4621769a91.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Sep 2026 01:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=synaptics-corp-partner-google-com.20251104.gappssmtp.com; s=20251104; t=1788253044; x=1788857844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5xzW0n7QNW4SkJResUk2G1u5HyRDJbdbqCtfNYhy8Ys=;
        b=G14ku1Yf3V9slbi7Vn7zwcbtsjmNoXVWhuSJaR8eJeWqciMo/BCjZZSgGGVSQkFPqk
         zKlnmWsdFmti6YN630HHzMgMYpdQaAcZvWN+fW6ABcLv/qoamp5dQf+Vro+53GBZQkj+
         z/KhEtV+UVwFt4UrOprFJbtjmmLY9Vc2pCl5hCWI7mLGTo7bZoMSbfu4rlA83CH5rcKw
         rFVZKQMdqoxtsVXRTePYXmiaPvyI2A41fGyfGqd8V5NWaqv560td1N9jPhc95cIJQCRE
         2mlAR+AYoFOxRglEzpeRFGZkmjO2PBlQUSgufl6gOqiSegfNzKn//pn+4b9aJwLvJqiB
         TEMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788253044; x=1788857844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5xzW0n7QNW4SkJResUk2G1u5HyRDJbdbqCtfNYhy8Ys=;
        b=Nczf8h17jNbAA87EFD4J/cvziW66yxk08yxritKteZBSKAZS2ECudykK3FMEmJ4viP
         mFzyOLC4uAtA5RG4MJWt0TgXVSGbLJC0ozEHi1W31x4467+0MqDqwz0PeRa2j6fCEbU9
         /DoI8vPOChsTIRT6/gNJayaMrHiNZqz/9Rrdgn/AcueYkRFQaBQul/laS3yMGEBykPSm
         PMlj7yF4JQ6nYxZb+38dr5t1o1mGwLKmag+EodntEYesoQDiArmzMRcRcP11eJgHFgUd
         C/ia6l4/cBc3xr1vpz/ZEjhuO8OeN0hYXhvq0kjrW0IbiPu9pGCWYk8xVdeMcxu9pIqn
         wAAA==
X-Gm-Message-State: AFuF++mOubSqyfcgcvCwpHo1qBSVF7ile7c+j/ihg50ECo5ukk5fqHip
	1kTYG2jG/nE9igDEV2qtamypEwnTH1hFDT8QTUHqoKZak+I5eGg8qdmBwg4nNVH9bF5ws5abLKK
	ck0hU
X-Gm-Gg: AYBFou0nEb1YP6uo8el1aXyb4ALsaOD9oceQtEu2UGtnJwWQbHH6WSXvgJVxnZ8xPo0
	AJzjZRuq+Ix7xfVhpWeUl1twGokkqgpjE05I4zKTJS7Jn3s0DTaxILW6+qjuWtVO8L1Qeh3lJ+A
	AvQcOWDi3xNkPZOh0ZXXc6dbmdzJdfLvLSsb2qA3bjuHD9v6vdoNE1mVkzu1WQVkjrt+QUZHo4Y
	2zfNfkwnkwxKdCwrQwn8YY05ZIWHtItB/T4zA1UEd7jWAeafBPwyZkjTH7pL88M8HgNFKPP4osp
	YeCM+AWuHfH5aSA0MPrO0iEb60Jk2th1+Nog1mLoIMDjuwYh+Yng+CsJ1mXoNnreyo3G8d9Hini
	xM18uQl3jH7a1JA7EnhacwHTUrSN6QzB2xS9juW2UOd8wUNMvdJmcEp8VfWoo1ljp007y5dZ+bG
	FNI8TrM9RuAA0//YDTqsP6Ruh8WSd9j2yE1tzCeODqNmpxc6mY9pTLCz1p3iHZC5djpKpKRvwou
	hsCNgMuz1TnRENFFSLKtWp3HkN3lUaiNEctAKUFBpFztsDf7Y0nl+3k6LGUKmOJJjvZ+kInN5PH
	yvFebQ==
X-Received: by 2002:a17:90a:d887:b0:398:b71e:60c1 with SMTP id 98e67ed59e1d1-39907df015amr9550349a91.12.1788253044304;
        Tue, 01 Sep 2026 01:57:24 -0700 (PDT)
Received: from bt-tpe-server.synaptics-inc.local (59-124-75-166.hinet-ip.hinet.net. [59.124.75.166])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990bcf6800sm5934432a91.3.2026.09.01.01.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 01:57:23 -0700 (PDT)
From: Andy Chang <andy.chang@synaptics.corp-partner.google.com>
To: linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>,
	linux-kernel@vger.kernel.org,
	Andy Chang <andy.chang@synaptics.corp-partner.google.com>
Subject: [PATCH v3 1/2] Bluetooth: dt-bindings: net: bluetooth: add BCM4384
Date: Tue,  1 Sep 2026 16:57:01 +0800
Message-Id: <20260901085702.1515378-2-andy.chang@synaptics.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260901085702.1515378-1-andy.chang@synaptics.corp-partner.google.com>
References: <20260901023300.1382808-2-andy.chang@synaptics.corp-partner.google.com>
 <20260901085702.1515378-1-andy.chang@synaptics.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the brcm,bcm4384-bt compatible string to support the
Synaptics BCM4384 Bluetooth controller.

A fallback compatible is not suitable here because the BCM4384
controller requires a dedicated firmware patch file (.hcd) matching
its specific hardware ID and revision.

Falling back to an existing compatible would cause the driver to
request the wrong firmware binary and fail the controller
initialization.

Signed-off-by: Andy Chang <andy.chang@synaptics.corp-partner.google.com>
---
Changes in v3:
 - Fix typo and GitLint failure.

 .../devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml
index 95501e858e6f..612d21123aaa 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml
@@ -31,6 +31,7 @@ properties:
           - brcm,bcm43540-bt
           - brcm,bcm4335a0
           - brcm,bcm4349-bt
+          - brcm,bcm4384-bt
           - cypress,cyw4373a0-bt
           - infineon,cyw55572-bt
 
-- 
2.25.1

