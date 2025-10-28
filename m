Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCE334888A
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 15:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665554; cv=none; b=hID5JkBS2shXPpARJgogB1E2lzgWk+E5IJTUet2H0af7RGrB4f5DIqlJtn2Bog/JoQlCIrr1zPqcXEIp7cEoCSzWIaVcz+yqFl8syqB89dYmLwk4EJLJvJjZaGIs54/7zodSx5eVH72zJnXdyYtqsJGjW+OueRQZE83+SRy+Idk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665554; c=relaxed/simple;
	bh=zSukNZlJ7MIqdyaMWhjsK/r7+F8I2VhKVYJCKLETVDw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DJn7F46hMmuNlm4lEoSDZ8nabs5wOqrNLnVyuSg/tfLqDGHshTXoCZzyM+mHlCGUW1+LXPEiRlSIge+IHjZWU4C4w0OD/0872WPzuNW5TVgKvaOoWhdgw4dnZtDIo59TeFCdmz2Sgp8ZqfRrfeMRpfYv5eOPIHe0dDGXEw9OvGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nAOQ6GX0; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nAOQ6GX0"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47116aaf345so7452635e9.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 08:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761665551; x=1762270351; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2LZwNoJWwYkaKmAAehgehdzMFy99KMCq/sPgFndgvoQ=;
        b=nAOQ6GX0sobwU81e4+wMBIccAfq9QxROtuHTTa/40R3kqljfXzowxKHZ5y56O3oBU5
         6CP/PnQl3fbeEBaF7YL1f2O87EJWDfYIcCmqNiCrnIsb60jYiqZjhyRCYuYBNqHs5vpH
         9RvZBk7HZOxxRD+x0m0e8Qv8UZpJ4JM72lVkbnErQ2uFRbSMLaUwcXTxJI6ODmuhQNoO
         XoVfSkgiAj8iu42pmP1Ub4ydVfAUZKkr8QIksfP9u18ZzOqNuglJoAMavmGKU20XRx5N
         gg+pdT/M0BfRNM514+2zmoMuR5o62S/6CgTjXR//EunljM8NACZeop0KWJQgxlySXZJH
         1sXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761665551; x=1762270351;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2LZwNoJWwYkaKmAAehgehdzMFy99KMCq/sPgFndgvoQ=;
        b=H+31O/VKnIUtvMYTjoZsj4kxfBbfhLKsRQ75pyp4meSaPAgT7lEgRG4KX0ndU9WCqh
         /KCeYPrP49LlspXWouInxCCXsRM+T4NUxXDFT013nyni2GIqfysiw+BnzA7M+JoXXiJS
         OV8iTQWMu67cy0UGV+tLi8AMf9pL8zwC+NWETCC35KpJJ8dnzXAjoc5kCRv/oJNHK7ws
         VeGzE+GqmWO01QO6/YwaKV2FDLl2wmNCdVpNB5+XtFpOhbOjTHPVTo4CWh+QxQ7MjJrE
         X0lesX0WZw5MFTaIo9/fw5DxeBbuB8hNW6WJhjwQg6CjTOjaLYCTO4F3Z97ijT2i5R67
         qSkg==
X-Forwarded-Encrypted: i=1; AJvYcCVLEk8cxJFAcslBa07qFnQ9wlg+WdSbbzGPObtX0qobGUlVatsKd/DUA5y/q7DXTPfcEzOr4d3c8HCkVlzQSNE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2c/NACFomAprzz9jCfTaRAekgwZnqIf+BQu313liPWowjxJPG
	OjNtYH3cmbj61bxsaexR1FDmdPpoUmBqKJRIVQbf3u7XqIXqhGutFJN8YwyApZNPr4c=
X-Gm-Gg: ASbGnctVNukslAqnwYXvBigHqqG3/kgl2BawTBwLK6m6rnA7Kvxz81ktQUF4uYvzY60
	SmvxEMjOD22MKeT3/KAkIltKPJpFNJ9k4gDJ5Kx54EGa7PBZulMlpdVbzo/A2rkDolXRlKRxd6H
	51ZKJaJRuCM5dWET7jvkfEuxF0URR/U6ac5wXapt2eqJEYQ+Zw0w5W9VpT+W58eNg5Fi1yM1LKi
	zBqgcOQO1y4uGSKYZbKUzPWrReN2CtWg4yAG9yBYDTcY1zuBRxcHNP5FJ/xefjNtZ6rFV4ysnM2
	4bjPqvhIZa9qvBMmfsbbeXtFwYzbuumkhM3hm3ntlGHU/82YvK7MtOW6T/++fDJxbGstoy+YftC
	SWpMWm6vcVPNe89RtUiOzYNAKdgq3A8sozUiid9qoM+CyobTL4t46xnulTWyRzdRxpy+6VEb1Kz
	gyIROmEvFb7Kpl9HG4wuSxJp0CowE=
X-Google-Smtp-Source: AGHT+IGVE3B2QRjpTEh5wr1vPtOo1EljFcIgnH5xAZBrUlCMOJ0sPgHl+FMB8DiEmz2qJn5TRoBcsg==
X-Received: by 2002:a05:600c:314c:b0:476:84e9:b552 with SMTP id 5b1f17b1804b1-47717e42d94mr18438835e9.4.1761665551119;
        Tue, 28 Oct 2025 08:32:31 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d9e80sm20844417f8f.28.2025.10.28.08.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 08:32:30 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 28 Oct 2025 16:32:01 +0100
Subject: [PATCH 12/12] dt-bindings: bluetooth: qcom,wcn7850-bt: Deprecate
 old supplies
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-dt-bindings-qcom-bluetooth-v1-12-524a978e3cda@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1727;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=zSukNZlJ7MIqdyaMWhjsK/r7+F8I2VhKVYJCKLETVDw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAOH7qJ7gAnazlmEVmSQT2tl9Ov0fW8LBbuH92
 j+nTnI5/1yJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQDh+wAKCRDBN2bmhouD
 1+RrD/4lCI9nI3gLTpbmLlCCHv8SmzZIwl9uEqBvUPhzDRA8WaZJh/ZEp2TgoALquJUW/C5CS0G
 SaKnKiFSqrO3SCWCiLEus1feRx/7VQdes6ITSWyfgbkZassgogbBFzLCUAlhaFKvrw9FytIgx+P
 Lc9xiiVK8wKORsFckj99TmPGm2M6GWhVMChKwkJ4EkNFBEZIm/g5fxsppVngkr9tDvut1uRezt+
 7DKogdmfYCNSnSnbovMt09FsU2VyxOoAQxFAEt7btdo1L2srZA1aI5XxLKdvTH84j8Yh3L10Gxu
 F1Aj/dKG82PBM1uhew9QrBwjf0zhPZhsuVk4eis/WqRb75e9qa1z4VSWgYmGd2Gt/Ep09aOWDaJ
 3a06SoGgrxePjYcwyvon09LIZv+2Oj42QQiZN5Ub0C74TFp62062edF2GgxpEJbxTPDuRQXleYW
 W9zFdPR6HfBzgC6hriu2hKUS9An1JBNnUS0BWxp+6UNoyc64ko6i9wfos5qqFa/p4XEyuofNGNX
 aVMzg+iFOWgaf6dCnetMW1S2+agDvSSyaMalD0GVuX9Sf0SNgD2iV1/BIPVW75dskYIrVhtV4bU
 w7gg0tg/b/wXTFp4IEXXJH452bxAbovmd5OsZ7WZC4HAGjLRxsxr+vY24j+WsTJ4AlbFlaYpvu4
 hFA+1fgm6I8+uaQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Commit bd3f305886ad ("dt-bindings: bluetooth: qualcomm: describe the
inputs from PMU for wcn7850") changed the binding to new description
with a Power Management Unit (PMU), thus certain power-controller
properties are considered deprecated and are part of that PMUs binding.

Deprecate them to mark clearly that new PMU-based approach is preferred.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/net/bluetooth/qcom,wcn7850-bt.yaml         | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn7850-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn7850-bt.yaml
index d2a1477380eb..418a06ff0353 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn7850-bt.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn7850-bt.yaml
@@ -17,19 +17,25 @@ properties:
 
   enable-gpios:
     maxItems: 1
+    deprecated: true
 
   swctrl-gpios:
     maxItems: 1
     description: gpio specifier is used to find status
                  of clock supply to SoC
+    deprecated: true
+
   vddaon-supply:
     description: VDD_AON supply regulator handle
 
   vddio-supply:
     description: VDD_IO supply regulator handle
+    deprecated: true
 
   vdddig-supply:
     description: VDD_DIG supply regulator handle
+    deprecated: true
+
   vddrfa0p8-supply:
     description: VDD_RFA_0P8 supply regulator handle
 
@@ -41,6 +47,7 @@ properties:
 
   vddrfa1p9-supply:
     description: VDD_RFA_1P9 supply regulator handle
+    deprecated: true
 
   vddrfacmn-supply:
     description: VDD_RFA_CMN supply regulator handle

-- 
2.48.1

