Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161DB417BE0
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2026 02:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788230014; cv=none; b=u2ymsd7bBAW+3EvwHnWx5tg7f3ZLSsu2b4KBgo4cBSSiKxkh/p7arfgrlw3SgZ7auev0K3/RA5rWtQms2f20xHDQiXUiyw/gAA4djtwh6PMeLg8l60EuQ0F5mh51D+6DzF+jZ8Rv4q2KU6FeRSao0IYG8FZUQW3zZzXGt/HlxEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788230014; c=relaxed/simple;
	bh=7zvXv2dF/rt84/+WLBvB9wFqWDLTCFcd3fwCRPfFGGM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rEgXHEgulqWR61DQ/SbT47MbV5NYniRfPQvyDZhZBb53PeW4ZvIXyh8XL59AYcRYLXOFz1Bv6kWAtKSnd4NyILlEWNBt9UDMVtHY9ZtyQ4ev9YGFEnqgQmCcbRmPQFMjRan6ySAn5ROvZJ+JZFnoO+hwaPZtWGxt/Y9ocQLqdaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com; dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b=zWKekOV9; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b="zWKekOV9"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ca7c1176317so3612322a12.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 19:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=synaptics-corp-partner-google-com.20251104.gappssmtp.com; s=20251104; t=1788230011; x=1788834811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sXWMem3KWnB4LNCEveQl9AbeMx+XsbNgDR8AdypxgbU=;
        b=zWKekOV9Jtgx7b7UtWT/0vTeiciq41iIsNkEroAWKVNx+hetSfUfQa4gDZgcIineyH
         kPDRVJVvuAQbVMxWw1yKdtCFXymI117SBYak60hJalk5I2mJVT17+nF9mnNP45CalVz7
         Tk6bpZM0/woWqsDEBxoTm5YjGzagYAwWd4fK13M9UO1+REtt+f0ON+y9YjCwlL5oEtm+
         CgIbhkjJD06Os/VzDZYGdKhZWQKfF7Ek8SLVhe+TYDP9VnmW9beMKRNX30hLblbxXZx7
         Iv7uhc8Q3gGICjaecLp5TJSD0k59RLukvz6DLGYh+oOckSOVpw0MI2MhQfm4KsVcR3rZ
         j6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788230011; x=1788834811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sXWMem3KWnB4LNCEveQl9AbeMx+XsbNgDR8AdypxgbU=;
        b=AOaj7jDNv9Gh8Gc0XurEu00CKbZg2vOI2nUEUxsdMECMwpjogsdQBvxRWPBRT2tDzJ
         qiJIXHd3qjoG6oSsHBk4nEXBKLWIuZquvVr+DG5fr+TzP2r7jDTB2h3jJNCpXtaBJx7n
         I8795fVBfJi2capVAaoW5brWzLs5WWQY8NHRBIegg5pdKPtBquMEb7WvnLW68/rezzmh
         LepOWk6KJz/G3ClABmJ04gXjQSdKTtLhtUUlDJBWmDcJr0+Tf4LL5RU3BJ20HVtUN4Sp
         jsglh0dNsBBibaGuuuvhNLWiaUbmIQMga4Bty9aahNSt7AWq5HTgzcFNVn41wXx/zCc4
         wN5g==
X-Gm-Message-State: AFuF++lVT52jKwrXwDg1rmDLYYyDFUMZmj37lZdPd5y3dYf+OvTAp30j
	5d6+ApxwST/9kJ1oWNFcVfTHFo7seQaaF3yFvfJNE34n8Esc+/ijB1BeQVHHETZ5EndRyyyYBMX
	WTmKlDvg=
X-Gm-Gg: AR+sD13IEoea8qpx4CIlIBAf1pSgH3a8rcy6CW/oUbWmLwqeP04LoZUMHZOJQ7sC+Xc
	GFY+JBOu9nY2ANqQ6zSdw6Or5zY/STLtk2Rrj0e8E0g5AA0oFlcDXVMvcP2rREZ5QSw0/H4Pa4C
	1njZAW4krH+DSXzkomeKpzrSs6QfHpvQOKj3oEqzKWGZN6EM8zLdRBt60SXubhZaTCZPZReeflp
	rao18bI9Z8LY1PyzVphkxsZCR+qTy8Xk5Lgiwl3wdNWnyBODuYkkveMo5d0fnekIVVy+wmCxAwG
	us1NtlZrlv4lzuTMGt8D8xSWPSYoi96VPCiEaMWChpLDoJvmmLt46TYMLvL1EXH6hs54+aLHQqt
	UM8L93uxTZ6mKOXuuoKueQxDVUvXMw9vySLUeLWzOW8FmSHOk+WlLL20uxuq8q7rTxP8v8ptlNy
	t7b56xvdfFYSBQFv+B6+Wynv8sO4YL4a6gwiNL1+MDYM3Hm7ur8gTa5ROrGXHjiHVjZyWxqsFc6
	h2lxU6e12/goMvM0Xj5BJ6bErhSRwbmmdR8JCuvb82ZsIi6H8E7LHaKiCXBkoD35XkyON1YjEla
	WvDglw==
X-Received: by 2002:a05:6a20:918c:b0:3d0:ba81:79b1 with SMTP id adf61e73a8af0-3d26277130fmr45092724637.0.1788230011288;
        Mon, 31 Aug 2026 19:33:31 -0700 (PDT)
Received: from bt-tpe-server.synaptics-inc.local (59-124-75-166.hinet-ip.hinet.net. [59.124.75.166])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1f3312270sm5005565a12.11.2026.08.31.19.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 19:33:29 -0700 (PDT)
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
Subject: [PATCH v2 1/2] Bluetooth: dt-bindings: net: bluetooth: add BCM4384
Date: Tue,  1 Sep 2026 10:32:59 +0800
Message-Id: <20260901023300.1382808-2-andy.chang@synaptics.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260901023300.1382808-1-andy.chang@synaptics.corp-partner.google.com>
References: <20260827110242.1203546-2-andy.chang@synaptics.corp-partner.google.com>
 <20260901023300.1382808-1-andy.chang@synaptics.corp-partner.google.com>
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
Changes in v2:
 - Add an explaination for why a fallback compatible is not suitable.
 
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

