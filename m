Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F94E30C626
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Oct 2025 07:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761723866; cv=none; b=mZQBqF0UbH8+xOX4Nzk8dD5mUf0i1TWPgkcDzBvj0sEHWIdBJBvRkQ1tcXXNpmf9JXZ8RAgyImDNhTIiyO1vekr3a+vjCz9Ilj6aCqKyR/pkK7lci4dOz0Uul0gfnv/nTnckNC3FkC3t/FMbbPG1hzGwEsyutIMIhSJPCBnqoyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761723866; c=relaxed/simple;
	bh=pY0T81cY/ChAcS24GMGsbOHLYcZF4AFMPLYAIXZGCkI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CBk6W2XduJx57n1f7pUZz3E0HRdZmqtjUwHROxm0+GU2NaSDyHUkC9MHJRMVs38Nas5adiTf7piGISI8GvpjRyCqc8useHMeOd/x9nsZ7TBRINsCK06Yq2uIRJv2GITRK0UFU4OhzaI3ZQgKnAER3FUcJSmPL2cuEgBG+/WGeRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BSj6HhW8; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BSj6HhW8"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42702037a01so1224629f8f.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Oct 2025 00:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761723861; x=1762328661; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uLoICzRd6+8op0opPDRU9sy/8Q9nUpG50ggkEy9RRTE=;
        b=BSj6HhW8INYMbxccfa1JDSKGDo9B3dRGqdSdGGcbuSfhArUWRuWlEGw+rcHUvFA9la
         8rJr2g1egp4eWyXzF2zPlQKSn+R/3oDX9nBtvpW4AEd3qF6voIQryowaFU00fSt6uoSG
         6wbBbewERXUGewJdJm+AH1ezRhZduqgaf8TarfiDVebgVBPSLrqPDgUD8G15DKcFBxm8
         6hbdcb5x5HCK7H/eQznK9VlZ0gjAxKZ7bUcpoCRs+2fvJVI7XnbVbjzsKu1MqaRpNuKz
         8SnhJKFksdHUpnxwLx8ITByW4HYlGHIJx2NOR4i3tcpoaeTrDbPGcJdVlaMtIJVjV8LV
         +/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761723861; x=1762328661;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uLoICzRd6+8op0opPDRU9sy/8Q9nUpG50ggkEy9RRTE=;
        b=IskXxUoGn50THR4fePhPVYFSAkMaQBSILz1rCRLqRLKEidebO/qmacz8SjqA6SLJP9
         Gqo8Sp3CfxvxUyLCcCvOANPMQP6TNB3yQUxldIA74dgO5WHrt3MqII8Kb1fmguGVChL6
         tx0fpYJzVSZJVITGFInPYX+S78FdlG7N8HrtJLzbDS+BSalanJ+HHbGFQQeTn4jO2lw6
         Ty5OAnNfHqDgFDY2zV9iYg+idU7Qo2OmoOWKF+QrIidtHohQDZL2xgq2dMkrH2G7hLah
         LAlVPF9Wo6MjjLiTInNn4VltU6bxP1zIOMfiTts8PEQaHkg9SEVEL/49hL46cLeEckQX
         izew==
X-Forwarded-Encrypted: i=1; AJvYcCXmlHmiEbaRBg+flyNMV0wJAnerDxGaqz0VMt6rYF2fHTGEhxQtMK4PfJ4gNgZHTAsqMSyIutYus9jYm1TbPz0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7lu77YaW9gikPC5KR/gWIcMJeJvOz1NPVmYpaXUcwkwbKSeb5
	OXBM3Y2cG1G8Wf7QwkNsv29Zpw/aMU8P0stGzQ/2W0hz/02EpTBPxtlDr6RO/d8cFKc=
X-Gm-Gg: ASbGncvgI89AqyimVNEGWoUVb1fnelYeJCGDq6ZEtvD7bIRBQsvEnGEoFvmPKpdRbsW
	wi4QV0amLg6ozvWgf0X5HP0ddKzV2F/TND+tZvvLJUF6qitYzZjh83Jycg2EmKozgsgkW8eD0Ft
	Oh53pfQbVkfOErzUYPbC5dVPpS18A+h2n1cWo8SOAHWm4kz4CHwDmsXSfudNBE5DLQ5f2D3XDsy
	uSVnouHOPeJXTWjUcoTscQAWiVV+rphThUoJizirToevGGb2TpAVwoDGLQWHaTx8gG2BQG1nFo5
	KHJMXu8JQf1rvUGCqCdU5pWK9DQuGNjVds/FoJyJ3N3GgHspqvLKbzQy0VQtfqdsKifneT92tyn
	qcTxUZKHCNIEmYY1vZXNIoFmRjHVaptpm9sYc+juG8eHMHDRJd2W9a5+SZFFMTQ+mXHG/WVfOeB
	KDknmqDOj+AhBGPTTF
X-Google-Smtp-Source: AGHT+IHJ8OyXNXU5WYZsgm92RcYA0HDqcNviK7vtEMfCzdF2ELG82lZGAWMCSxgvENQxff5bDUo60w==
X-Received: by 2002:a05:600c:310f:b0:476:92a4:7dab with SMTP id 5b1f17b1804b1-4771e1ea171mr9824465e9.6.1761723861457;
        Wed, 29 Oct 2025 00:44:21 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d5c9dsm25861146f8f.26.2025.10.29.00.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 00:44:20 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 29 Oct 2025 08:43:57 +0100
Subject: [PATCH v2 07/11] dt-bindings: bluetooth: qcom,wcn6750-bt:
 Deprecate old supplies
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-dt-bindings-qcom-bluetooth-v2-7-dd8709501ea1@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1676;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=pY0T81cY/ChAcS24GMGsbOHLYcZF4AFMPLYAIXZGCkI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAcXFeXM89iSHEA6sSVYxJYG65m3eVtxgMa0Tk
 E64VFrHaB+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQHFxQAKCRDBN2bmhouD
 1x/VD/4yhLx2g9qWjYthtjDOWsvbBp/FsDwphIDzP49bahD893LSah0F709qDfCZsdY2z7OKPZt
 IM89DEIejsZb41xyP/mvqog8a5IYovCi3CkBSyzLONbMloZ5RfFu33zXcx8Sy7lGDSQmawjhw0H
 iDuxkNiwGmziRpwuB7UM2kCK26Qsg/C/GKuYVkVXrPxpaBkC83odqmdc7ws+vXnL3RVXrVsZS8v
 zCB8b2LockxmQ2tHFxaK4g7R2KDw8Xi15fpeScEZVC4eVkLbsUofONi8XiYTHwzMq9tGwgq3Twp
 /ygR5OpzIyZS8sJZGa2Ay4+h9QYE8evEZ8vbJJeu2xNcF+oUKYUOCk8Cn3yL2PNp4sYlCdM0b/Q
 48N/PWe1cMkhP4/aEECgF02kZKzuVlrOwySByLsaiLtEG/a2nRrzu17RrYoMg/M+hFIfZhIZm1V
 pHU1iZCzNHaPwt6FP9Ra3ZNuGoLyPUizOLx/n1xAqylNP/AgD+PbqbsAq76Eag8yKxPc4emqlCq
 0Yefy3j6DCGFYvp3fwLD9jgxSC0mmSfkrb0+DtjHQL3PW84NhUsVwlMH2nNLDBwFTY1sFMwvHVU
 jHdoZZQSAtH3+LTEyYDXciir+WgAD3oqBTMUw8Wb0QE0W27xUd3ia/dbb2I52eLt/sK6oyVnR/T
 HzM+cbO5RVW7zxg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Commit cca4fe34979a ("dt-bindings: bluetooth: Utilize PMU abstraction
for WCN6750") changed the binding to new description with a Power
Management Unit (PMU), thus certain power-controller properties are
considered deprecated and are part of that PMUs binding.

Deprecate them to mark clearly that new PMU-based approach is preferred.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6750-bt.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6750-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6750-bt.yaml
index f11d12c205fa..8606a45ac9b9 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6750-bt.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6750-bt.yaml
@@ -17,26 +17,31 @@ properties:
 
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
 
   vddasd-supply:
     description: VDD_ASD supply regulator handle
+    deprecated: true
 
   vddbtcmx-supply:
     description: VDD_BT_CMX supply regulator handle
 
   vddbtcxmx-supply:
     description: VDD_BT_CXMX supply regulator handle
+    deprecated: true
 
   vddio-supply:
     description: VDD_IO supply regulator handle
+    deprecated: true
 
   vddrfa0p8-supply:
     description: VDD_RFA_0P8 supply regulator handle

-- 
2.48.1

