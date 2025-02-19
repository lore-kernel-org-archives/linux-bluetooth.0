Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D245A1DF754
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Feb 2025 09:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739956521; cv=none; b=sONvYPJ3P02FdNbZi7yNE1M6kMFGNAyo4Lw9vJNdN2ohttgVrEegbuJ2Pgz0MgjrWlYSsXkSlOcljmMUPoLQ0NXam+VIg7Z4NwYZNgLznkEmq1p5midTcsOTQpnk9gcLJXyfGnLkPt4ZiLpRaCc+oWAJl69PHZEAH+MyVBQu7zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739956521; c=relaxed/simple;
	bh=7M5vaBKRmbFv54lQBepxKee9UxF0v+gnGJ6vjUmU3rE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h6gti574aKOGOM+nIsIdzp8eP/e6cXNDUVN+dK9PTegU1iuyEGHrLG5wSN5I41RKElcWC1Bz63AeEqPQK2RDF7x2s1mLjwD64CoeD6ABq1n1s2VGj2gC35qNgN5f12C3fBQteGIspI5wYaq0zQnZgKed1uOdY5Rw5k6T3u+A1PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eWSU3gOK; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eWSU3gOK"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4398e3dfc66so22942095e9.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Feb 2025 01:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739956518; x=1740561318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sHWfwds5aVkw0kQ5g8ONjBeQJWS59dXEyJJMcYY6+5A=;
        b=eWSU3gOKMxiUQu4FFXo0Lav9y9oV+JQ4Yxxsbk92VP8LqNtYk3WNrLU24kduop5Ifl
         k/YSyyQazkLeQMWSiISP4exnqtXc05+35wlIRfgBvZqd332eTHd3+kGX7nPqAUqwDVCT
         gPgiiP/RL+hHxGhIuSuvcAjhR1TmQtwfBMt2eLWQg7SYyF0mTNUELGvy3SFc/TiuZuhD
         YCj7ZKBKAWczNMuXr4AnfabYoy8iGSRQYx6fWhYVBSAgj1pP3HpoMAVzSMqQvCcEJhbl
         qKUkgI5rWVf8iO3wsTKGDeycKXtL4KL5Har/py1zDuLNb1MBKaq0fFD1G2WjX+itTQ7q
         oGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739956518; x=1740561318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sHWfwds5aVkw0kQ5g8ONjBeQJWS59dXEyJJMcYY6+5A=;
        b=SBlG+vY/hz7c9WGBZTRVrTdjST6SrJXWifSfwe6/LYqo35lvfxGPIeVmnIk+ASVbUO
         yiRCsveeX5QAr/Aisfcna8MYA78H5BwcesSXVezVC4n9ANLdFgNHqf0HUODnq31ExSw7
         xYjIvcYwzgDum+NhV1JH8C7OZrgfdZLvLkVYyuERhnRk+LxA90hcAPNII3p4LFtfTnzF
         hqBSIB0OrYJRAq+5FouPGhamQs6JjpOvyLfrxq3c+0BY4CT3cU21o4oSJEHQXutE+wUA
         a2e2Cpkm+4JEIl6DviXvL8fPPFVMC1ow6fpn6dcJQ7dQdg8/BmWlZWqEuf4C9LLmDA0N
         XwUA==
X-Gm-Message-State: AOJu0Yxk1x7R4uEwvSenS8cCx+toN9GLe9wzTOF2BtqB1Mux3ofDUqo8
	vTzAbUJ+ddVcCSZfVD5T/F8jFhrp3tzHsVvlnnqDR3NEbYAtBFRZC/fASTyoEhE=
X-Gm-Gg: ASbGnctMC9pBxdq+4/h2Lw1cNCMU+bJhBFGxV5B+vWDxvxn8thTPyHLWKgY2maowcR2
	kJglefA8xoQqJ5ezIiSkYXdtp+lqIuLKRtDa/cqUWbpj6VxZ0Fka9ZCSTOxzfNs5TQmeyHoG24v
	L29td8R02zgX+KdbgGiUxLyThwHkhSsLGmjTkomGvLGUv6vEZX45SfeXFNz08eO0HxYwMsvmch2
	nqQk8zYTNlvZzp2KtO7WbuA5SyVEgwoiU3RdHjYQwbobmfAZnspmS07tgdYHFMvhRL0Ms+paubq
	cgT3vkznHZPLN+w3igTj5W4yCS1Ig7iVyw==
X-Google-Smtp-Source: AGHT+IHmVnWJxCNrFshS3rKCtRUdy5fE100UpPcTP+EPSzVv4YkSljr0sSRgMFyS9Vhd/OYskNUhGw==
X-Received: by 2002:a05:600c:3596:b0:439:9496:17df with SMTP id 5b1f17b1804b1-43999da1338mr22734005e9.13.1739956518120;
        Wed, 19 Feb 2025 01:15:18 -0800 (PST)
Received: from loic-ThinkPad-T470p.. ([2a01:e0a:82c:5f0:ad62:b2f0:914c:91ae])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43987088ecbsm75404005e9.31.2025.02.19.01.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 01:15:17 -0800 (PST)
From: Loic Poulain <loic.poulain@linaro.org>
To: marcel@holtmann.org,
	neeraj.sanjaykale@nxp.com,
	robh@kernel.org,
	krzk+dt@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	devicetree@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH v2 2/2] dt-bindings: net: bluetooth: nxp: Add wakeup pin properties
Date: Wed, 19 Feb 2025 10:15:12 +0100
Message-Id: <20250219091512.290231-2-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219091512.290231-1-loic.poulain@linaro.org>
References: <20250219091512.290231-1-loic.poulain@linaro.org>
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
 v2: No change

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

