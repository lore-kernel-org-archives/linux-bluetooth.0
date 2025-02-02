Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5631D7998
	for <linux-bluetooth@vger.kernel.org>; Sun,  2 Feb 2025 12:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738498569; cv=none; b=H9aNSUBmRbgJViFecyaqSNViGjRAGeP9BuUOtr+Uii2odBW6OSyyuGc5wBiDuAm/IxteduENynozbaPKmocBsSd/MOwXOFkRxBrQaXzbMXfPrVUnqrIFFFS7gDdikoBdwlnQrNFx66a+k/YVZFj3T/0PmZ6n9XxCU09sHoYPsls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738498569; c=relaxed/simple;
	bh=/d/geU3OxC4Nkibrq9A3Ew2gwBiXmZo2CHTH+6Gy0Vc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EG4jkhCu3v7FMuH144sfJG+mh7yFdo37nZpE8cnp3fResEO3qtqrdKFSwDLht/9WDd+DLhYFTbDBdzlL8+om/bi063VsUAYCI266kp3/ch7iN8cdyd7m5Y+5tIuO4tri0960kvHQ9ndV5lkwrpadzawcwVd1SG/reSLsv5yhWJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JL4GkBxB; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JL4GkBxB"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-543d8badc30so3633386e87.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 02 Feb 2025 04:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738498566; x=1739103366; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Dk7ljpeNS9WkTUfxOFg/JBajDxdcbPw39k3Tq9ImKI=;
        b=JL4GkBxBbSlI0/wHjLKBhSuaSJ7t9Q5DiBXxkc2u7JVhuPzfIJmz+/8PyI8M9iPwmw
         mONIP0VSf14x83Fa0R+DdYEtJjFgaXA79df7H4YznQbYSNhFy6QUBzVNQ/GWuIdMBJjy
         Lbly12zucWNvw46adQ8K1j8i/GgK+It/NmHP53rNrno1VwHFbynshx5hmUq8ejmzTj9v
         F1qVnuLWZCEcU2LyXAJWgIb3DEHNPwNNHt/nWF3NCNyEyeWwKV1whoMLY8Do+16UBgIA
         GYrj/9yRNeX52FeeXe3/Pu9f6c4BLj2cJvmoD/VD1wXTHToADggvtH4uMBOMkDlrqeUf
         EukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738498566; x=1739103366;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Dk7ljpeNS9WkTUfxOFg/JBajDxdcbPw39k3Tq9ImKI=;
        b=le5dRliiaqS+ZYdkbPyslvH5PtT4H5vf8hS+1i/K0rMAMIB+Tj8OoFqWtFvIhUHxnY
         V59rZxqX2/0yu16pEfk+d7qOyUBUuZ74ubB2ysRGRN/bR5z/iCCX2fpYDZ2pY8JetG7e
         YISKTlOvKHme9FOv+tZTsGAvHFbxNrASAI+8C3xd+mZJI/Oe0Q1wToLXyamuynfKtjyO
         w8LzSW15/5X4bqDMa7UIGMKSp6PjDBmknnlLW/rkmwfqIf75Uuj8Vpczc5aMqLYvgq4b
         7DlAohWAx4A3+R6zsJcDazUFizI0vEi5ydkY6VNrIuwJlu2XxZQ9vG6WmkFmoVjbB90u
         mGCQ==
X-Gm-Message-State: AOJu0Yx1hR1S5LfHrzU14+aaJmtuhsy6diiu7IJBXTgSzBD6jsrWR8ez
	x7Zk1gVOvsn9w2ARa0RoC8VYPtGLdj7AE9fDBsnkjWf+Xvf69NGp4KxGIusfeADuGl0otM3wnpQ
	TMtB8Kl9G
X-Gm-Gg: ASbGncvlBF2OQQMmUvP6f5cnyJVZgb8iHhpNqWIo/VpyXCDUL0gnnTBEFNLhV+9G9LQ
	of/AoRUkqsRFYerud4C72A2fLZvNaJBePPxOb1ac57x9xXkB4Oqf3ktYXNzrsHdxgFYrj1SYKT3
	Fed4JxtArMH/jv8WYcUMIZR+dVTbr0Dda0lXYqlnMkCYjqehe2zmv2eSjItLAlPluV/yAje/hxm
	yMfwz/THOihvmBPl/oo6F3uVIJx0jzDU1N5A5Rf9of3m9/Spqpoz6L19z9yCFOzyhRnPudculTC
	fWhn6PP6X6Jh1l8bIdxpUy8=
X-Google-Smtp-Source: AGHT+IGP98WumGAvva+L5oENy7ZtjMAo+pqO/eBrk6bMfEKIlWE1R/0IRGd/QpefZzWafsWgZy/y2w==
X-Received: by 2002:a05:6512:32c3:b0:541:1c49:26a with SMTP id 2adb3069b0e04-543e4c41038mr6109076e87.43.1738498566072;
        Sun, 02 Feb 2025 04:16:06 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543ebeb0a4esm950663e87.114.2025.02.02.04.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2025 04:16:04 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 02 Feb 2025 14:15:57 +0200
Subject: [PATCH v3 1/6] dt-bindings: net: bluetooth: qualcomm: document
 WCN3950
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250202-rb1-bt-v3-1-6797a4467ced@linaro.org>
References: <20250202-rb1-bt-v3-0-6797a4467ced@linaro.org>
In-Reply-To: <20250202-rb1-bt-v3-0-6797a4467ced@linaro.org>
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
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnn2IBFNJQoyc6Q4TD+Kypa+h8oMgJ1mr88BTN7
 iUCRw7nItiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ59iAQAKCRCLPIo+Aiko
 1dQvCACSiRQJBXKmOxljdACfeKHT2m75Y5VpbZRWKMkcI4H0buAMvopgfIgG9wPFTf/dek+VG6p
 lqKqBfxIV+KU99Dcb7wxL0JW5UBsMx23ADuVZLjUmdCSJq+tSakpNlbdkmaeXyV/PNUD/ULwhyZ
 MGX56kw39F9vBS3TgKHbv7ncPOqS1mNm006aKml/MWzxKqFLXt6mlofqI7V/K82io+gfHeSK9am
 Rnln3hHL6poko2ReUQcMCvpYBAcF7RmwaYk9th1OWVNRCsz9QpGgjdzztVW0T5JFUbjNWxd5VvI
 hen+Oa3myvAKVNmTcGGAZt6U1MMoI4lAB/6hVDsISJPP0Mgz
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

