Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922111CAA86
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Feb 2025 17:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738430959; cv=none; b=SLyFCZM7Lxjld5khlaFAzJahsy1+KFIiaVoORwvrNJFmi71NG6LtG1nWIZqbqZNdX3G7eQNMBXXj/Mi82TpRhbuW0vVPnKtpD9SVELh3d/D3/WF3pzhxoik03okMVnOvMUQjALSmb1K+kl87jICNr45jtf+Ru9U5hiDbFhe5sHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738430959; c=relaxed/simple;
	bh=/d/geU3OxC4Nkibrq9A3Ew2gwBiXmZo2CHTH+6Gy0Vc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aRTD3LbDBJ9INGfMLPkGuBNrzaG0gcPoUGKaPM5YnJNtzjxhJa90mLKYy+9CvVZeqJRh1uj+fSREF2yRLZZSbnInXCd2IThA24J/MSDNMenuttJYbw8jp0rjCqBQ/sU2VgeLom0wDe5QDoNpcwpW7W2M3WwHbTzEcjkG+G7/q80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EEB+hGJG; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EEB+hGJG"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30795988ebeso28041421fa.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 01 Feb 2025 09:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738430955; x=1739035755; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Dk7ljpeNS9WkTUfxOFg/JBajDxdcbPw39k3Tq9ImKI=;
        b=EEB+hGJG23MUswaLIHug+zBcLaUI7FgHBF7+31DvCX+D+AsY+l2aEyGy9Id1ZVruIA
         O9ljf+Bh/HRUstbg27Zm4m15lPZ0Uimkri7CYLVsOiYF31OTark2MDaWoecwS6eWpIMS
         Je0MCtBtgxgx/xwOgIgHk54XMUTKKLu8oJTt8x0esWnzo7QmEBm08HZyIE6onfVMgUJF
         x7YzxvFv650YA/qvjF9v45MHUdVkIgAqGmLzJ6lIhaUv4buLAqDXsEtkXmATkZfkf2Gf
         UdK8rVJe/DHJDFYd6UcitkcUDmfi2IpCosIpA57V/Kh5AXDLdl9nbYEMo/914o6Cb2Dd
         zysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738430955; x=1739035755;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Dk7ljpeNS9WkTUfxOFg/JBajDxdcbPw39k3Tq9ImKI=;
        b=OJEtMDUsHfJWfm+w+Bug1xhQ82QeQtUHog41u6YKUtcEpRa5LR353BRaKtWjadOzI/
         zc6lFA7hIpSoQjPWpRbarYYh3j5MV91FG0zQe8jWc4XSaIXELx2vimddR3kotNvVwwE3
         zamI9NREoOmRmSqTe8kRlwHPEsnDKtoS91HSVcn8VJzhSCnfALS77XCSVfkXjgEIWswZ
         jNYVF/SAk6pD93RuS2bKgURGus1TXfzx4ht47otcLOROoR+QwqjZY0gUp/SCJqeDsBtp
         PkobKP7t1BpgZIaAjOUv4t/UAWxJk6Ude/wUFSBlefsfdoVkj2ghWxfmyLVfd8IE/cFs
         VnZg==
X-Gm-Message-State: AOJu0YxPXmudSHX/pA2IRe6/1QOsRmKoR8xKYGC4tWAm2JpPN+BhvAtZ
	UYGr35pIvWdQ3vFfbpTZZNgLbpWxdh1Kujay7rl/mVZJwzJ1xAkTkylnxrpyhpeO+p4/xX7ukpo
	hUVaZ7g==
X-Gm-Gg: ASbGncum8405AIPOYEDyuMqcOBDUSfHmxuE/2gFn+3sV/kt6vKErnDgwZzMLMbdn2xg
	xva4HjArctiLApfpXFynqNQIRV25XG4Iz6R7qxSjq7Ybtha4y0dBL5Keie5+sh4VDK7ilORu7Dl
	FvTfqa+x8Ulq6GlpF+UJm0TdWFx+SeUy0og8bhs3N5ZY7Td6knWwGq8bDmLXaOJFIUORHCqYAM/
	C2vKj7fzcsvzR4I8hNj7sOtXo713wNwJrRwt62OZTFe+91AGIZy/TY2czxpLXO8VOeCptm+o+Ld
	cGtq+www/EMh+HcFcb4nU94=
X-Google-Smtp-Source: AGHT+IFQxLdgqV1VuCmiSKzy7E+QXwyUiqyAdxyDy1lhNZkJAj2DiV+iFyftVtLTyzS01O4ux7Ueig==
X-Received: by 2002:a05:651c:504:b0:2ff:a7c1:8c2e with SMTP id 38308e7fff4ca-3079694dd06mr58095141fa.28.1738430954016;
        Sat, 01 Feb 2025 09:29:14 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-307a3099ec4sm8852161fa.48.2025.02.01.09.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 09:29:12 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 01 Feb 2025 19:29:07 +0200
Subject: [PATCH v2 1/6] dt-bindings: net: bluetooth: qualcomm: document
 WCN3950
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250201-rb1-bt-v2-1-fd44011749bb@linaro.org>
References: <20250201-rb1-bt-v2-0-fd44011749bb@linaro.org>
In-Reply-To: <20250201-rb1-bt-v2-0-fd44011749bb@linaro.org>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
 Rocky Liao <quic_rjliao@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1201;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=/d/geU3OxC4Nkibrq9A3Ew2gwBiXmZo2CHTH+6Gy0Vc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnnlnldnpgRM0nW8PS6YIAuy4YhrJbX7cj6BYnO
 B5keQ6cZ2SJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ55Z5QAKCRCLPIo+Aiko
 1V2rCACNDKB2CIDYU4QR8+Ha7egrR/zbrKOgsECRWLewOohyIlcnXo6fluZVPXOuLXYY/fixjks
 YgDHawSRviONkIGOwNgN4/X+UCdXiu7KSuw6enXbGQaQEVBNtibf5gAkitbd2CmwxNa0ED+aNOq
 Wjcl3CC2MDkrUxnPnitHOBYvSIbUtSQSMbKXZrkm1khH4ueV0Rwao6VnvUdXJ/YMmlxdOqItlYm
 UxNJWpp7RiUl14118a+TgBlJAYgSAuzn7XE8P4seuArTn6vGNDLp7wCJQLAFHN8W3B2QGFkv0q1
 uJxif8MdAL/sz/wvo29d22rFhq+dzE4wKfBkmf1E7Srwwr59
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

WCN3950 is another member of the WiFi/BT WCN39xx family of the chips. It
requires different firmware, so document it as a new compat string.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
index a72152f7e29b490003114dae1e36df85cba384df..6353a336f382e4dd689d1f50a624079aa83b2ffa 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
@@ -19,6 +19,7 @@ properties:
       - qcom,qca2066-bt
       - qcom,qca6174-bt
       - qcom,qca9377-bt
+      - qcom,wcn3950-bt
       - qcom,wcn3988-bt
       - qcom,wcn3990-bt
       - qcom,wcn3991-bt
@@ -138,6 +139,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,wcn3950-bt
               - qcom,wcn3988-bt
               - qcom,wcn3990-bt
               - qcom,wcn3991-bt

-- 
2.39.5

