Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE6821C197
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Feb 2025 13:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739797855; cv=none; b=g1mgL3bk0wkbGKOlsrOtfGFHO8u+Aa6aNSKtRkGuCr6OdUeZhfPdN1yDDR3yGGtUIlxU4E5jIMqFU9Nul0449wX4QL9PSL15VGc/qw9cBVcz4LC66bOYu0vJsEEAlFPtgqga1o5fAGcduuXbhw7dRoGLIC7EDty6CHN3Q+2LEck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739797855; c=relaxed/simple;
	bh=uCY9e9KeMINOhW33ouVfq4ycoeYgBjRCDndE3HPzB88=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AOVIxiR3367yodxA0tbk+6XFpHQSks6dH2T+4g6XtNtnFx6seLtDsQI+pVaUlH95NsEZy23xclGvTXWR/nJj+B/syzvJ0w8juoziuZeI2hJXpDv/+0HF1DDxPiXgcHvPnc9wwYjwEYUrM3/gPY9xlYxS/jv5pHQvERuFMURVF2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FVBkBxV8; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FVBkBxV8"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43967004304so19840975e9.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Feb 2025 05:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739797852; x=1740402652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwHzAmLrSqkDfiJhE2PccaRiOCG0MeUVQBuDZ6RZB+E=;
        b=FVBkBxV88gZYKzsgq5uvxrM4xw6PfAHE06tmvUmTNAvHwh6/CCnxO3ySaGncFVMuCB
         S5yKGbTYol/fDkQT8S9IEr0mbgca4YBgLgkb6USsBsnfjmKcXO8hDDv4VOk7QKyFCgLo
         6IWdOw8/VMlCG1IPpQrANy3Ga+Mi2y3+bVC05qWODs51DW+5S1bp/ICm7uJj5U3TxDZL
         PHDT82LDnwlnL4/zAZCAKJozlQ1fqq8v49fN+HmpMeaN3QKnk29M6nuGg6v7mlktBhNO
         19rnc/VZKKcDvyB0XJxwyFLT6RaALnBfioJH1V/dP6HSgWq3Gb+l4Q86+0hT/53v4YdI
         oN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739797852; x=1740402652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uwHzAmLrSqkDfiJhE2PccaRiOCG0MeUVQBuDZ6RZB+E=;
        b=BRksTIPqQKY61ikxoIgnwgOVzQqP6nq1qp9yZk3uKjzz212R3umFi20CmUIFC5jSQT
         moYg8guZPKlAfxJVhxgTIsgt/e/LYD5voSCgZvCUR5Z0raUJycf3iH0i/SJSOMMLyqqS
         BGMT6/GllxYeLe71ktl6tqNEpRmR1UZaMDk4E6RMv2OOEJiL2l+UOfHJ9zqPDLycIe/+
         xcsJwKFt/jdD7OpkauNTUMw/xxwPeDh60kveWD07obeXhEgZQHdUxnuWBXrr9rmbXNCW
         ZjPoItnss8Mj0g1XubfDTyVObys1YscLmh1S0ha/x2y92ggvBHJDH3B7YnYacoxbD9Fc
         MgKw==
X-Forwarded-Encrypted: i=1; AJvYcCU9ayF/pcbTBRkdKaBvuEzZeTs2tMYqcrZhYCTRg4F1l+ghWaVNtHzwGuDl9g5Yph7SP2Y+AzbRpslXLxLSn54=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZh1/GMEvL3Ums30w8Ve1oXsHwb0+JsnpU3umKOFgnJYRluXDQ
	5+QjIuqkW9NECAPnJAU+wtowsh9NHDJ7zumAAwjmoEEq9VHQCDIne6SaP3PdeXLfXnsftyZQsGO
	WXqU=
X-Gm-Gg: ASbGncvu31kaBbHKqIHhAOvI4rC0Nzv90B0CVYogUORtryrHMPkiyP3Wmi1nCudyjKH
	QQgydRaAuhHMfvKbqxHZhj8uPh/fLFGsLbDzojFP/NLIfjdjEzmNKNEV4OgVxYaPtoebpWYn6cT
	GhZLCDnHZAla/znmW+LoNZtMjcGYUdIrUnHlC30mU34QgkERraACTJ7RrSLQpwSJEmfGaXlOR/Y
	pBauKC+vA1ZL5TmrlxMf9ZJTkCe9A94NnQ+16kZJMJsdWKaGL3XRF1Mlt0e0c+4txcZGsKROnHx
	3TA18RKqcR2NnmZF/pYEkps+S/G4VfQ23w==
X-Google-Smtp-Source: AGHT+IEzdVQFmkbWUbmE/seeTzjkW4338I7yiIddW6zYM+ZQJt82C26vASmLHvdagkh/RMK7uD5wwA==
X-Received: by 2002:a05:600c:3ca3:b0:439:5f7a:e259 with SMTP id 5b1f17b1804b1-4396e739aa7mr84778275e9.23.1739797851854;
        Mon, 17 Feb 2025 05:10:51 -0800 (PST)
Received: from loic-ThinkPad-T470p.. ([2a01:e0a:82c:5f0:ad62:b2f0:914c:91ae])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258f5fb6sm12043763f8f.44.2025.02.17.05.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 05:10:51 -0800 (PST)
From: Loic Poulain <loic.poulain@linaro.org>
To: amitkumar.karwar@nxp.com,
	marcel@holtmann.org,
	robh@kernel.org,
	krzk+dt@kernel.org
Cc: neeraj.sanjaykale@nxp.com,
	linux-bluetooth@vger.kernel.org,
	devicetree@vger.kernel.org,
	Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH 2/2] dt-bindings: net: bluetooth: nxp: Add wakeup pin properties
Date: Mon, 17 Feb 2025 14:10:46 +0100
Message-Id: <20250217131046.21006-2-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250217131046.21006-1-loic.poulain@linaro.org>
References: <20250217131046.21006-1-loic.poulain@linaro.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NXP bluetooth controller may have GPIO pins used and routed for `WAKE_IN`
and `WAKE_OUT`, such pin info must be known so that the driver is can
configure the controller's firmware accordingly.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 .../bindings/net/bluetooth/nxp,88w8987-bt.yaml       | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
index 0a2d7baf5db3..04f55fac42ce 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
@@ -40,6 +40,16 @@ properties:
       Host-To-Chip power save mechanism is driven by this GPIO
       connected to BT_WAKE_IN pin of the NXP chipset.
 
+  nxp,wakein-pin:
+    $ref: /schemas/types.yaml#/definitions/uint8
+    description:
+      The GPIO number of the NXP chipset used for BT_WAKE_IN.
+
+  nxp,wakeout-pin:
+    $ref: /schemas/types.yaml#/definitions/uint8
+    description:
+      The GPIO number of the NXP chipset used for BT_WAKE_OUT.
+
 required:
   - compatible
 
@@ -54,5 +64,7 @@ examples:
             fw-init-baudrate = <3000000>;
             firmware-name = "uartuart8987_bt_v0.bin";
             device-wakeup-gpios = <&gpio 11 GPIO_ACTIVE_HIGH>;
+            nxp,wakein-pin = /bits/ 8 <18>;
+            nxp,wakeout-pin = /bits/ 8 <19>;
         };
     };
-- 
2.34.1

