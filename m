Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1149B346E77
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 15:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665552; cv=none; b=IoFEJOGwoNeyazZnleOb5ICQ7vn5o2bXdFFizCliKMyr1ghvsRJCCZApYjIR2S5EboUyHCiKwNAm3bKi7mPVGuSFZlK/re2rj1RfNJuVm2NhTM04/WXnJ5PG/qZdAQxNE8UU6KpQ9pGKEUu96WY0vVpHzZe0pSc2589ncriD5d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665552; c=relaxed/simple;
	bh=UBfN91/HRbW/UXVPCVtl45cacT7R2xBycjytHT3dmdQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uo/m5OEhJ+wNeW0VKhosid1rSrHvS/uETz9bcousJPpnrPiuc3bx6D+++TjWnDD9ArG+kK+lm2YVfSlkK2uG2aVDLZ3srQOUK6SOeJCDxa53a4+RsMm2PstNWUGJCpniOAHolQklyf4YG/6rKg58nKGfwbP1J3/N3jTtLFGctSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lSGxemko; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lSGxemko"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47116aaf345so7452565e9.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 08:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761665548; x=1762270348; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3aPxwY3fiYCzcFJL34YSHho9XhA7+ug8K/KRv6Zo21I=;
        b=lSGxemkoiEC+YI39Vr0OJg3VCFAck6Nlfqcis7wNIOMzj06zRLxT5x8coWQpAphEwz
         /zh0FPPI4AkIULUpnF8wPzgDRWlqJM8pcNauGg1AC9Hfz0deT25mwSE3+0Ew9BcAWKlo
         ro6jj6IVBDAEOaxfgbfXhJvbr8DDRytT4Ojl3JA9EpsgVqEPYG7jW9VxT4njprNmC/qy
         MghRAwNfZslBpHvwDgTEyfRiWeffABObXxKViAQTBzA6s3PtcwZi39w28tufK47/skmn
         hfjYT/o10h3/Qs3S0VI5fsazrBmOvQa7c2CURboQdPxBmmviP5Q+a5iXcYQp1Dva6VHd
         SEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761665548; x=1762270348;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3aPxwY3fiYCzcFJL34YSHho9XhA7+ug8K/KRv6Zo21I=;
        b=kyuhtt1FOLcr0dV1iMwd2KRlyMdHBRjU/MPjIc6UrFA/2HoMahRgNJrUd3V9tM41xo
         81LBUXpIX8i3NAtkjPKpwthtRibzpw8cEkRQ6GRoC6X3ivTBBX+tZi9mQryP1hs5aOkK
         DDPTX1zXFAxEWEWb/6braZaDKNeR9Wb+dQ9am1ErSTr6utzeuMQZueXoJrRsLT5xX1mM
         k3I9DSJiu5jDv2c9LVdjqAy/R1qKGSsdStYgBpJWAL4ybJLjCGTmugetT5WyQjIgS1sB
         1PZKGxRi+r+GAhP8pru+7A1essndNRKa9mtMHgrgWur5K7Z2nkRE7xtQk8yHChVrnPSE
         b8yQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUhJNwuAXYusWilPaLS0jgZ9e9hsmtVcAuzceURMOkuQZh/4KdUtxGz/IYou+KtSzrUFLrl2vy/vAgJRWFnsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFPFCc5nP8wWkX7pN3wm9Fcv/BAoHSYmEsns1FBz1fp7IjfjkZ
	fqCdspbSd31HaphBETX1a8zIyvdjzRcu4cKZiDgnDxRDmpP6dwM2HNKufjfWc0jbGGI=
X-Gm-Gg: ASbGnct2s9aMimCTF8bcxfgHUZrVl4BcAj7m2OJpH7Y7pUJLA5Mm5J6KPPviGSKtn8J
	Pr4dUg4wqaHlouQS1FYFzdA/1BLV3ujZK3Jh3ZhsePQWnXHYcg6DY4aqivLk4yW00IrA0cDXh5m
	VmmQsICWZ97BDj3CLRNVhBTymGTxMs0Se3A0IWfGp/H95KfXCTydWcW3HJs7NpynWCvDdGt8P6d
	NXwn0Kxc1u3fyJ373czy4/zNoyd7McWZQS7LS10iCP+A/BeDH12P9e+W2gGgoysQPm6gyYzIziH
	Y3JYvHNvHO/b+RdyumfTQbO7mXIBMQCnOYb02v4IHmKZRAdEQYJTAGlWNn7gJkuboOXOkpVOlUn
	Gk7JDcRnGgQzzalptsd2sV3jeBDqUHS14RqUtMfZvRJ75zLa7kUjO/BgJpsa159vW0Vt6iJeno0
	yzS72pJuhbUJmWAAPo
X-Google-Smtp-Source: AGHT+IESY1LvMUmSYa6iEPzDOlj2RB9OtBjiwB5e1FP1O6UrBdSF4rmg8z/w7e+qYKcERmacRAqj7w==
X-Received: by 2002:a5d:5f82:0:b0:3ee:11d1:29e6 with SMTP id ffacd0b85a97d-429a7eaf9dfmr1840342f8f.6.1761665548161;
        Tue, 28 Oct 2025 08:32:28 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d9e80sm20844417f8f.28.2025.10.28.08.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 08:32:27 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 28 Oct 2025 16:31:59 +0100
Subject: [PATCH 10/12] dt-bindings: bluetooth: qcom,wcn6855-bt: Deprecate
 old supplies
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-dt-bindings-qcom-bluetooth-v1-10-524a978e3cda@linaro.org>
References: <20251028-dt-bindings-qcom-bluetooth-v1-0-524a978e3cda@linaro.org>
In-Reply-To: <20251028-dt-bindings-qcom-bluetooth-v1-0-524a978e3cda@linaro.org>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
 Rocky Liao <quic_rjliao@quicinc.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1767;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=UBfN91/HRbW/UXVPCVtl45cacT7R2xBycjytHT3dmdQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAOH5SFdSc559wOLsoPWW49j0UrUGIkWJsOm7a
 hJRzrMnGEWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQDh+QAKCRDBN2bmhouD
 146yD/4lD0H1gvquzMxqXY7VcBwJZlzlJH/1F+TV1T4fhqSn1Jd3s4WQU+5C6ew9o0LySShF37z
 KgXrYEYhNs/IDiT47GkZkv+dNRiOidBR4RM1PWP0EJSH4kb+68wQlwaMsQeZBQZ7hcsstOUrHpE
 TrlpK3fmgy1oL3YuQjQS7TdZvhnENcSXRbT/bYdgcGb7nGmTn9WK1cYPruCDw6/txiebP5DLLXN
 QEABVFDdtwdwthHNiav3ojtXkoCyER1FzXQ63Tz9XdvWd+48Zkvo0z6eE/YrMdbEtpvxKom8KCH
 fjg6LXsdc6Zd2FebsPFG3BoAy1qX6DyruWxLnrOWpSal0pbj3Yd1G1iulijKO9sgA3GOKGDTthK
 Q2cfQSWIkynvqcZ0P7oDcz7xoJ3zN7sXM0RpH78I4GLgYDv87Hl4SzsfbHiPwlxm6mFgna5tIll
 knRSmmOJoZCnZtyPlzSuUl0Mi/xYnfC1VL1rWgvitUXZhuFynUOQxvk0YPRQPFgOq6jgpjFFCjs
 ohqj/GS/Ccnwhpc3W7DFpkOnEHI5jCeFajkYRVk0zNUITtWgsSvFOykPwmXIurNU0XnwPKnY19R
 iMewGpr5xnDjra7pOidYpRdse/GKs6uwwYOAOCpQ36sUwkF7Cn7/NqjovJFaVgdlU8+ZzdkWCrF
 8WoZG85IL1fUd/g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Commit 5f4f954bba12 ("dt-bindings: bluetooth: bring the HW description
closer to reality for wcn6855") changed the binding to new description
with a Power Management Unit (PMU), thus certain power-controller
properties are considered deprecated and are part of that PMUs binding.

Deprecate them to mark clearly that new PMU-based approach is preferred.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6855-bt.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6855-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6855-bt.yaml
index fcc1df4b8364..9de9d12b6757 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6855-bt.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6855-bt.yaml
@@ -17,11 +17,13 @@ properties:
 
   enable-gpios:
     maxItems: 1
+    deprecated: true
 
   swctrl-gpios:
     maxItems: 1
     description: gpio specifier is used to find status
                  of clock supply to SoC
+    deprecated: true
 
   vddaon-supply:
     description: VDD_AON supply regulator handle
@@ -31,9 +33,11 @@ properties:
 
   vddbtcxmx-supply:
     description: VDD_BT_CXMX supply regulator handle
+    deprecated: true
 
   vddio-supply:
     description: VDD_IO supply regulator handle
+    deprecated: true
 
   vddrfa0p8-supply:
     description: VDD_RFA_0P8 supply regulator handle
@@ -43,6 +47,7 @@ properties:
 
   vddrfa1p7-supply:
     description: VDD_RFA_1P7 supply regulator handle
+    deprecated: true
 
   vddrfa1p8-supply:
     description: VDD_RFA_1P8 supply regulator handle

-- 
2.48.1

