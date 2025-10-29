Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B033191B7
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Oct 2025 07:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761723871; cv=none; b=dSaHL5e64hiG5CRRskV8Pyktex9yRKxl4Dl6HBRMgIghml1kQtQpwgOgFCIQX1Rux0goA4t6frnOdlNpFKUPVGoMjrGgw/Q9O6O6l+mQ58LsHlgGVyIdITPn/rh5u2+rXIoeWFfSx1W5fK9YHx19+VeXW/B48R3Kndm3R/wKaMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761723871; c=relaxed/simple;
	bh=IYVuBBwaeQ1PBLKcrd5NHt65uFxyMucqOKrr61RZ2Wg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bFzPZvOaxF6vF+0I2AwKWJ1e/eE1bQAHiRTLRtC0UAM24NHbMe5qMvM50vIQ/NXj2IZl/1UfXij7GDLqWSEsxiaWJhuKhdMVbJXSURnK4Q9RzvVv4DacWjrVHHZNm9dtzgLiXAKDIukNFTqgCFVcwjcrWEStuJiHIJExLqFPc2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i3Rj+kGJ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i3Rj+kGJ"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4271234b49cso910911f8f.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Oct 2025 00:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761723868; x=1762328668; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=56Jo10Sia7JFeNP22R7+UWXRhqXjXhFECcRuC4d49m4=;
        b=i3Rj+kGJXpTtZqwWmQdnqj2joE+I/V/4T7+TMwqynTKmAZ9gizkkT3N0p4p1qzAgcC
         cojK2Zlmi0EU5DCcZBCdsXqHp3YJje3BKSxNBpoX1JJgimefxQf5+V6vmnYMIO4DSL8x
         T9QoC1PY9z9Xd18tCnLPuaS+TnImfaytVtmFDw9QNsXBrHbmJXTUla2DspY/+c+AnzWV
         EYBtv473pJadSVZOHLAwcoV2pdkZjXP4ct0NXKhoDclWTQvEwijVVqYE6rIwDgD/Y8p2
         TYo0OoAhkTr0mchNFEMsT6iIiBHzX/hJCQaXrX/K9m1Y3u2CHmToJBN7c5UWtTDp3OCp
         7QGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761723868; x=1762328668;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=56Jo10Sia7JFeNP22R7+UWXRhqXjXhFECcRuC4d49m4=;
        b=bzBRl+TFh7UnpjI7//gzmwwz4vHfdSb+OkTz/BXx6H+rwu29fVy9aoZk4Am26AnF55
         EHPJbdjdUr33tpSZriMIpTucBvallOgEkzuqX50QH9U7AXBeg5nYC6hYdWClaE02/BvM
         JMU84Vhgg6Ha9kGeONEFl9oPkb7tz5nxNbb5NgdIb3+Xiu2Bxh0eWFqGUkSIta4TqA5t
         sB1tkmKTFAURa6HQyIz5ZyKTVM8UTy80tTpJs+cng8jMt64rRTRprcEedCcDPY3IW6a9
         TvTP6k/+NuB553EFh4PelJT2AqzHfb7XeBNrkiIXzgnrD1NjwYQrxvlw9VhTWoik3Zm1
         0APA==
X-Forwarded-Encrypted: i=1; AJvYcCXmLgrTgdEdE6YuK4TSjuRr1YacBasiAe12aokC0yWN35HzDsB5FjzbcXL65L6Mle5ZrQYG0MukA3XJmFCdqUM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycfs1zKyThwsMYs+oKbmVFGJ7QdoR43lk/Rp+r3mSTvnf7R/eZ
	INiTKojQQNNvXqs4XXVgyMP4unzJP58Aqf3ykDizN7tSQNMgZy4boi8ZCN8L5Unoigo=
X-Gm-Gg: ASbGnctA5fqqza/zeIjbTZC0VSKB2e1BPAo3AEqkwmugu9HGk4H9VJRk0oJVV86PUUO
	nA4gBQc4idZ8faQGgWP1toJEvD+bCXpy87xNkSMr5yJHazwFu+sQXUseioi5bXpoVo7NiD/gqLX
	7bEHhHLw7OIwTQsS+FQp4ITLtRZD8vHoPExqZR9JA8pKtpgf7JPchP810qf4bUEBXjN/Qo/pfqA
	bEaSghrFxO1wL7YtFH0w8ugGaOz8U+dl3Qz0wcWc0bnBPE01tY/zoMR0wR0UdRZ0g8MDGx17vno
	CsdZvwSTELwXE+S+laZRgb78NZ5t+6dcv+FblRPdcAMFBDSy8u3aE0uB1lKH9i6ZdKsgPx6BxLc
	CSnB9HlzOoJaMBDsYwwqdACd6R5bMGagm7E4ml8Sztp/YhN7JfT12k/qbJh4xIUUlFceFqobHNi
	C1V8aXI8sY/qyLAFW5
X-Google-Smtp-Source: AGHT+IHjedGJxFD7dLMl/rvsV3pkJFC7qhdSb+Sc4hQrT3n7oSY5Ppgz4lO64B98FeOT6QXtl65wew==
X-Received: by 2002:a05:6000:4211:b0:429:8d46:fc5e with SMTP id ffacd0b85a97d-429aef890bcmr739869f8f.4.1761723867597;
        Wed, 29 Oct 2025 00:44:27 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d5c9dsm25861146f8f.26.2025.10.29.00.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 00:44:26 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 29 Oct 2025 08:44:01 +0100
Subject: [PATCH v2 11/11] dt-bindings: bluetooth: qcom,wcn7850-bt:
 Deprecate old supplies
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-dt-bindings-qcom-bluetooth-v2-11-dd8709501ea1@linaro.org>
References: <20251029-dt-bindings-qcom-bluetooth-v2-0-dd8709501ea1@linaro.org>
In-Reply-To: <20251029-dt-bindings-qcom-bluetooth-v2-0-dd8709501ea1@linaro.org>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
 Rocky Liao <quic_rjliao@quicinc.com>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1724;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=IYVuBBwaeQ1PBLKcrd5NHt65uFxyMucqOKrr61RZ2Wg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAcXJHi6PDpi9tcb/UVaQyeVu+F4p55yHQBxpa
 CHP1idfosuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQHFyQAKCRDBN2bmhouD
 120fEACIQVZ32STXzRID4r+U1N+GviJ1fbhH3ZTYCf47w4G7D8J/IusF9rmaoqVN+JI4KvTiPSK
 erfG8OpgD1sXUwMe9RWRduwosqbAE499+yIGSZCnjTd66UoyDKi5St5Ww8BkclpGRVIyfRWm4Yp
 f+lRQQDQA7+50gkK8UH2sMsgiBDz6qDYakSmi8Swb+1lOAMoR/fYprYy5XWzLM2TX4uKZPemUdx
 Waldkm2wBIS2OB5XcNyYOyYpUM7lGqUWwpjjUwAHIQBAE2kJhHaw+CnH77XGxE2GJLoa99KJm0j
 fEyHbSWospV4yFiirEyDcUxq7hFL4pwDxAjI7DuihC0JfVML0SRPDePrbRal/EXhIFBeOHPyS0v
 K+gNk8ZH+HOhdr7F21azJrDY/6JQathhFiWnxBuigg9euNDVnvax3KsL+Lt2TtHuv5n6KssX4AX
 UFJ4Ms56rjda4GXAXAyVAH8zwvXtb7hIpkH76Du1q7bHJgVUQg3ylsfNgdx2E9YqPh0OmAWfsg/
 NwD+g2K/ZMFGQf3pMO5Odt8nudMn+xIRYRNJGQTMe0wC8TiB1sksT4AHMOZdOWWSi8J9+N1C3bw
 Dt1dej5woZ6nGPabHmxLdViwkim/QdUu/TbjdkVf8IyUhyzRuYeCbLxF4oWcWstWCvML+3AiivF
 TJTKoQZh7rreepQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Commit bd3f305886ad ("dt-bindings: bluetooth: qualcomm: describe the
inputs from PMU for wcn7850") changed the binding to new description
with a Power Management Unit (PMU), thus certain power-controller
properties are considered deprecated and are part of that PMUs binding.

Deprecate them to mark clearly that new PMU-based approach is preferred.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/net/bluetooth/qcom,wcn7850-bt.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn7850-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn7850-bt.yaml
index bd628e48b4e1..8108ef83e99b 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn7850-bt.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn7850-bt.yaml
@@ -18,20 +18,24 @@ properties:
 
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
 
   vdddig-supply:
     description: VDD_DIG supply regulator handle
+    deprecated: true
 
   vddio-supply:
     description: VDD_IO supply regulator handle
+    deprecated: true
 
   vddrfa0p8-supply:
     description: VDD_RFA_0P8 supply regulator handle
@@ -44,6 +48,7 @@ properties:
 
   vddrfa1p9-supply:
     description: VDD_RFA_1P9 supply regulator handle
+    deprecated: true
 
   vddrfacmn-supply:
     description: VDD_RFA_CMN supply regulator handle

-- 
2.48.1

