Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4517D34573C
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 15:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665549; cv=none; b=lMimTV9N/27sHEu0qvnBkA7WqOWvgb52TeEB6cOzhpLI9bU7+SXyyw33bKH4Ed0G2dWqMDKfteallq5GE0rR3F9lxv9obQaBdEudK0aK6vkw8+KXOtwsE6e5eEdLVIdwIT4xFwLdi0ahk+KeMhgsy28THnRjgBUzx1YTsqeGnI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665549; c=relaxed/simple;
	bh=OjZW5uejf3ZWGtawvAcAlIoLoAV164WILRLn03rqCF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mp6H8z8Itth6uE7U3kADJbFpQOxNqBgqF79kOFQs5iKKCZYGLhy/w65nfhc1cahhgysFXQO87x6cT8g/WwlXJIPc55s4tST2bBNTrcy96pNZkiteX9wuhDVEd5KwA7vVfcJDh78YZyWhx9xkFrFgR4B9gFPoXXn80SEWwt7hZnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r/y45dgS; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r/y45dgS"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-475daf41e47so3156045e9.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 08:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761665545; x=1762270345; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fbnBeYVg7wXGjqQGKh8N4e7KhogHLg2bpjk9l88AgZs=;
        b=r/y45dgSPaakR/3de0yxx0JVwq/doq863evYAN5EFFhpPpbKxRY1epGImzNkdNbTES
         0s2L0HBJVZWxazOJ8kjNoV4NyZ3VqCauNyy6w0K4TamzUIHgjn+KfnqQfNKrAHb3DRlJ
         k6GvMuvp4JkEjECVy+sz2vTuTx/Kte2dNQHLw67VGGCPBX9E/nRj7vYH5qI1o8GwUJAg
         wepOrzgeZYf26TneJMad/Vvc4L1Ac+LtzlRxLkDdFMh26AwvDCmhyjJ4TeuOwrPfzVbZ
         RS4ZxpCh7JQjk7Kb03wd2PiQvrO6ORNVFNiO0ln6ntKoy/LLkUArdfQkcLa+QPBlGXJ/
         rOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761665545; x=1762270345;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fbnBeYVg7wXGjqQGKh8N4e7KhogHLg2bpjk9l88AgZs=;
        b=cBCGGB8fRnO9QUgeY3Ih9sOTyTGDhvG5q/N9Ev68ta/ZeWZKpP6qpvAYz2K1ocxUzm
         EY7jnK4XAc4UbaJw6skvfy3RkqURGXnpNdSjBn7dMKG2PK7Mt/pY6VPMkIjM/zC/95gm
         eImpTAKdE/WjR0XUBbfGbzcByepeDliWzwjeN4JGr78Gffdq0Yku6jIVzFtxsogAHZVH
         olOQolqRgZMkxdBNeSCDpeMaTyhv9ZR17pGti8jzzdjTzfYpUOUzP+duFT8rTqDMbzYU
         OSmr9/nIR6xioD+5M6sNBxfGofgW9R3sNbIkJ+XEYgmuu/JZ0G6kc1tt1O+dg0OvPwaK
         Jjiw==
X-Forwarded-Encrypted: i=1; AJvYcCVjNukD1j/8sh02A5sxeAItRGLDM5gQCFgWNbKY6nMTBkN055OS2pyjzFx8z/13kCFBKkOHBKXNhfRXEUS+0CU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx17P7N6bU2Yrsx6oSmGfRxZa+PxITW3yOqJypb5pA0oR4kcrlk
	tMXCILCGhqtw9PD4tt9zEquGDqLqfk+GTJ0wKiSOCej7Dzs3H8sHoSuMyiGY8uFM5Fo=
X-Gm-Gg: ASbGncvvYpWaDSj3Yk5c8cxspIF4lLt4BG3ArZ63esWeCT5esIGsT6/yR1q82kJTw72
	WBcym+id07Fei8YuEMk9AbRadCmwi7kpDywa5EcaM3fU6vRoWqT7ov/4VLeb4SO9tPTSCpzIk14
	pXqVzbw5vaQzcQzEGAALwuajsqoT2g++yeQUEP1ZEp6sh7aFQXsrjB6H+481LFgO4GLr7Bwpppa
	QK7Uh06WyCXn9khcX7yBX6rD4RPT/5b8xhaM2jJ6OSHmpgcBnictYolJlWQVMcpJ67ugfG1EGzM
	+a26W0lAzMeeNf92ps1jIfhGueW+0Fk0gzarNSpNkP8GrW5ncgydKzkXY/7hS78OeAf4DQdV/va
	8inCxfNZZlYX2u/jfrzYAaGxY5/huDmm9CkZHvQLUnQGQaHSOFoci6S+ZMuH1PBvfFTPijHYxAX
	6XToi7bOVAyFSBsW7U
X-Google-Smtp-Source: AGHT+IFc/KbNZXBVLLRrq1nNAEGx1PhxaoJhex1nKZ9oKjz6FReNRaImuUafAZVh8OWGPHfRw6fCxg==
X-Received: by 2002:a05:600c:1d1c:b0:46f:da97:91cc with SMTP id 5b1f17b1804b1-47717e589b9mr18853825e9.6.1761665545340;
        Tue, 28 Oct 2025 08:32:25 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d9e80sm20844417f8f.28.2025.10.28.08.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 08:32:24 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 28 Oct 2025 16:31:57 +0100
Subject: [PATCH 08/12] dt-bindings: bluetooth: qcom,wcn6750-bt: Deprecate
 old supplies
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-dt-bindings-qcom-bluetooth-v1-8-524a978e3cda@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1676;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=OjZW5uejf3ZWGtawvAcAlIoLoAV164WILRLn03rqCF4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAOH3C4atKvMyP5rKezX8SPnbw9nJ0BikbPbxh
 1pXxCTi70+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQDh9wAKCRDBN2bmhouD
 12Y7D/9IvftSt2JFfA6Xv85e6zWO9VBwxsV1sQUDc4bZ7avvgk5TDmRVa1i7W6ADSEEXfZ92zhw
 pwOz8WSX4ThTVepTjy5YApWl1yLGFTUrrRY777RcUyXaROdGdpGpCUo2Y1MoH6THi1eaG4gcBRP
 q3A0/adL/Ni9K4svMbuoqZYTCNGTt6Dx8S8/spYoZBRSqD02JQMBI1xQ9Co8qm+0W7BZMrb/H2R
 /dIK4gvgIYEDwlBURQxIpsSsQutj5xrYCozSdC+yA4c4MHNuFM3z/G7akdhoZx31xkLf+MOJglw
 9Brrqd4s6O4m4zx97nMH9+ij/wXjrLNZcxwJvW6p/HwcBYU5GrLaYMpsmehhBThS5ergGI1ZeKQ
 UzdZ48hXRO2xZH/Xae25vOmstcP9n9WPkmAH5ZZfKv8pCyEZ+yEhhu7W/Li7nNnZfWxGXEvH6mN
 Efwy9aeYweCUvXdeCtDQ4eOLNyfTDv6DP7C1kdDV/o6P6t+ccUo0AQKgc/+HLhGzB6iCHRdJAUT
 8QhrVQIj9oqOKOzZRr5YqMfA+UreG1ilvCSiL24qnDLsFS+wha/Z/E7T0el+Ml6f6KbiUk/xIII
 uEb3kGFS7q2rK0XkPc01U4o4A9gB95Vm3cb0ciHgV66Y45yqP/LbZF49wGlDvzPwfiNDRi/pnKH
 YZGCcKDKiwcCJQA==
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
index d26ee82993d8..f3a0c1b54cf8 100644
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

