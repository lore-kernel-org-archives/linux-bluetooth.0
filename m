Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FDE59167
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jul 2024 09:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720431584; cv=none; b=ViuMSiakoif7Z6PaeD+hfOORp1QluTuT0/lvQ4ZHHvUb05zZTOYeCHyMEWmuvv1hPgAQp6Vz915RncQ189/RNSQT1FSMcnNVa0mhenTUJ73STyzbWz4B94D+ol3hreU4SYf7pR1h9yjTaId/vEo1UwkXhNz0iBji3MT0iDeGgVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720431584; c=relaxed/simple;
	bh=lnpdHivpa0ZtGALVGMDdo0DO3IUBtoV7QZSuwbPAAcw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lhuLLIQV+PiZuueq+abONoVnk0ESUJ4It3su698LVEnHxyCYsKdHkCelDedkaVJn8KHqUVyEhs7dlsUYgfIclUbtcvIU8FlGcA5b16BQETF1x883PdnKhH77Vrc4MYz5LqSswVDaKqioW5phjLd2sJ08exWyp/b72S5UZOY4LiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=nXfEkCEn; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="nXfEkCEn"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4266ea6a412so523585e9.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jul 2024 02:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720431581; x=1721036381; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ECapj6dpkD5GtOAKeD+vFFeZbzC5454tZ0kmlaK792w=;
        b=nXfEkCEnILM8aD6UpTgrRWkuJbYz3LBDmOKYuYmMTYmwA9OnGYf2Ixycq/M+gurjsP
         UiY+TNweUADEeYsvTQg4P+xGiaxVOOi2z7j4rGpeumki2Er/eqgDEuvTsSRzk7UuVDst
         beIWiitB5QcqyYunIM7AFz/PWsom8/lf/P9vBtfI4PDtkfwEcQ+KsbNm7edNT+QVH3lu
         +K6k63M8gddSnLBujofaVyg1XVk5mBIhkeHiEzsFM/bPT9lrKAiZjVH6kM32J8zPi6TY
         T1sMGeGacXmN2LwPRybDKQfTy9arM+iC7y1cIzfYUNOue9/Bu2EHXkNwKmFIu/+R9XSc
         QB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720431581; x=1721036381;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ECapj6dpkD5GtOAKeD+vFFeZbzC5454tZ0kmlaK792w=;
        b=PVGDdccluQpOWHGtl1qa5tX/xVqOOUrwNSucYb5UacPl2HFW2OluIz1Dc4nVKpnYTA
         p8P7XpxNohg8wu5LHxCWHyPLFsfGJYbZDmpeD2Q6RLTKBrIePLN55PWRAfmpsz7xuPTR
         KCjw6br6v0BgnWGhJehWRneSddiWXlHsYvP4rw2bSSZSOqAe0QcSEswWYDP5DIb0L+wD
         86W+/QPZV7VqSAX2suOa22kEfVytoQ4yBCyt6MQyWNRnXkPX8Vj+OXcDuDi6b1+7a45+
         SVt7pwobWQtH7Gr7UUsVG1ulTTxclGSLJWBs3/IMKfZK8L95AsXv5gzYfHZZJetxodOe
         mKnA==
X-Gm-Message-State: AOJu0YwqZ2MBks4xrQO9ExjAAi4nzLAn+sDp5zAp+BB3ryUS+j33F7lH
	y/NV3JkWscLgp/Sk4qAT2sxQPQNXYMfTDo7+v5dq5lm2gxayWC9uO5g3dMWMg18=
X-Google-Smtp-Source: AGHT+IEuzTgLGeJyUOER4Ji3hFBisvwQmD6StW+8e8J8Hl/ChfbSwRTo4Rds/I6uyNDZXGkyF60HbA==
X-Received: by 2002:a05:6000:124c:b0:367:9718:5792 with SMTP id ffacd0b85a97d-3679dd29597mr7763911f8f.18.1720431580998;
        Mon, 08 Jul 2024 02:39:40 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:a2a3:9ebc:2cb5:a86a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36789fd7a0esm15457779f8f.104.2024.07.08.02.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 02:39:40 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 08 Jul 2024 11:39:24 +0200
Subject: [PATCH v2 1/6] dt-bindings: bluetooth: qualcomm: describe the
 inputs from PMU for wcn7850
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-hci_qca_refactor-v2-1-b6e83b3d1ca5@linaro.org>
References: <20240708-hci_qca_refactor-v2-0-b6e83b3d1ca5@linaro.org>
In-Reply-To: <20240708-hci_qca_refactor-v2-0-b6e83b3d1ca5@linaro.org>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
 Rocky Liao <quic_rjliao@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1853;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=MP5aeVc3EiqpKpqEdBQnkaD+MInTgWkpRAZc9/j+Em8=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBmi7PZ1gZLnoj9ZGg2/29r4glVeiHy2D31Qnvv/
 kD5lvHLGPaJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZouz2QAKCRARpy6gFHHX
 cqpfEADGpP2r9ZG3HoAH6HzLzJrN27ImySZh1xpugf/uqwOFRcW2mgswhGkyiyF8+ofu5vHcbBP
 e1eWJc2j0mCFBMF+hi9T63W/Galia5/N+cvZ4Ow+/HBzOS7y8mCPTBKu3TIm3UBKVKHf+uXejlc
 7JyVxZQVPpOx4NHhaRtgTE+vi4DiEy85lLf+/A9VYwhUMv0nO1HJjRRLaxpDpPvujw7+oXL07SS
 qklrytgDDafxXdKAlwy0vgwTlJABbTElgmveVEV2g52rUVhC5vVeqnzfRCE2Q1LFBUstYwyDBOG
 eArGQL5+5mooMsLHdzxfxo2hYDTw5J7+rtBhfwNvIW+sX/Gh+s0jSgbs5OySc04t6IxVCb4khuC
 A6sANMhDp22xo0fvSr0esYoCJ5scf5nMTPXHeEueRo7N2O2eRx4CDv3V/PeLAW+pEbsX7oFSvSQ
 HXkgxsvu66Wsqqrk39Y09Vng4UT3e5lbSlGTbzzlyLG7Bx/sS5e0yJb11u4AhSUuF7CRwX784Q6
 L6V1nyVw6m1/t3/aTGyyo42Ml/75FKSs//pbH+EuZUdZ8wtG2+sUxwgADfYCEPt1qc2QJWlXIY4
 JFUoLbuRxt9PKONI15HN5zfRGEHsfiWEOsrVotD22q5CdJ+ZGjTILRpfGovXApGqBMZROMl5/mS
 KPuc+wser4EqGfg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Drop the inputs from the host and instead expect the Bluetooth node to
consume the outputs of the internal PMU. This model is closer to reality
than how we represent it now.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml     | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
index 48ac9f10ef05..68c5ed111417 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
@@ -77,6 +77,9 @@ properties:
   vddrfa1p7-supply:
     description: VDD_RFA_1P7 supply regulator handle
 
+  vddrfa1p8-supply:
+    description: VDD_RFA_1P8 supply regulator handle
+
   vddrfa1p2-supply:
     description: VDD_RFA_1P2 supply regulator handle
 
@@ -89,6 +92,12 @@ properties:
   vddasd-supply:
     description: VDD_ASD supply regulator handle
 
+  vddwlcx-supply:
+    description: VDD_WLCX supply regulator handle
+
+  vddwlmx-supply:
+    description: VDD_WLMX supply regulator handle
+
   max-speed:
     description: see Documentation/devicetree/bindings/serial/serial.yaml
 
@@ -179,14 +188,13 @@ allOf:
               - qcom,wcn7850-bt
     then:
       required:
-        - enable-gpios
-        - swctrl-gpios
-        - vddio-supply
+        - vddrfacmn-supply
         - vddaon-supply
-        - vdddig-supply
+        - vddwlcx-supply
+        - vddwlmx-supply
         - vddrfa0p8-supply
         - vddrfa1p2-supply
-        - vddrfa1p9-supply
+        - vddrfa1p8-supply
   - if:
       properties:
         compatible:

-- 
2.43.0

