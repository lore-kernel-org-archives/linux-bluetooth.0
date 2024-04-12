Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A661550243
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2024 07:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712907057; cv=none; b=AWMIZoFUY5ajL3D+epsboKdMIliTpLeDNjyFMP2FvezTnYs7i8Y7QQw8D4KQ26UNFTqLqI9MRcxZXSOKYLl/1m/+JfpcCpuSB9UJ+dozfKADzEx1p4E+dKmj/P9n+xooRFJIjVxP/T1LxPmzOnu+fllUD5vfekyXZlEqfuA0hEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712907057; c=relaxed/simple;
	bh=ELyJ+CJCoG1IVqX5X75YSbhALkKqT4a5dFGLgQ4/ZnY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VXUCoXf2UnlTOfecQ6Q5FOygn3QUdc+DegjoFYOpcqbpgaglwUcHkGrfed6Su8ITr5gelNcOQPGSwOv1hcJt5itHPUnFAcZcRXDGUEUCEi/j+QzsM/CVr4EHW73dJdoMMA/IsQsSYrn1kvfARlmVUHKGaqhyWK6SDK7wm/mlUNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AORJLYS/; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AORJLYS/"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ece8991654so637070b3a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2024 00:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712907055; x=1713511855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0kD8JSa/wlHNA1KdEJbBxgwZ9LZz09AqTXMn/5iB0iI=;
        b=AORJLYS/dU7fiuNfY1ETrdUwSLycDelJzn+mTsKDfbxyLAJLph9H4SvFMzzPZAaZzd
         zXDOb1GbJ6gGbUo++HWnu3mwBFMod1FhB7zya0NmI6kNi9Of6yA3YGgep1spOmwJdAhK
         SDetk1ghfShTvJRWYQs0wWq/IJuEMrz8JpIWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712907055; x=1713511855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0kD8JSa/wlHNA1KdEJbBxgwZ9LZz09AqTXMn/5iB0iI=;
        b=E4WBtX3Kt480bdKTgAbUhQ0zgVOS3wTi17JY4Huv+6ETMyAXV6ekpBPsU+4KUNhmV3
         dScwxy4aG02PkokLuW2MqYoCZ5LOLPZPs8UIYpJpXBnR00hSoN5SmGmRiR4qj0JxAyPw
         IMwIaTbaKEQ3m2KFSIF1OPzGWbh0ecnvx2br+3KpMRxdnN70AkiEpt3AQy5H5/A5am1l
         5PAY0PP2EynGyHTOCeAD0ntLxdDvOuJYn27Lc1fnBEmCrUKwan7LCngJUjp8sm5kiJmG
         T+ss7lBnWKwVKRIvu7idAtfTMQmnaLs0vohBRKSQixhtJ2+ZePVVSzz+Yguut7+9u/xh
         kyUA==
X-Forwarded-Encrypted: i=1; AJvYcCW0rac0okdobPWBW6pu2LDwrcLhxT3PKKLYqa7ky1zc88I+RPpKvK2Rvq1kHH1DNBjsUA8NE1vQPRl+CUavjULC9fc8dwV2SDcpn0C8pABL
X-Gm-Message-State: AOJu0YzUpOfNuFprtKrJwjbQSmdjgDKhWdNmVpnmOaScqdDFnU0Cx9BX
	+gQE/JLmhqtlyg4GYez1/vpQs6CVzvofEhiMo4/xtZz6iLhMmRTRl5fGsld7NQ==
X-Google-Smtp-Source: AGHT+IH9TJ0GU71I2lqJVSkEubfs2YUSVV/7k6TyMcFaUg5ykPaPZHNJ1QhyNg9VCsr2/J7KXJRL0w==
X-Received: by 2002:a05:6a00:3d44:b0:6ea:e841:5889 with SMTP id lp4-20020a056a003d4400b006eae8415889mr2368095pfb.33.1712907054781;
        Fri, 12 Apr 2024 00:30:54 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:e3c8:6e1:dcfa:3e8c])
        by smtp.gmail.com with ESMTPSA id d6-20020a637346000000b005d3bae243bbsm2149609pgn.4.2024.04.12.00.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 00:30:54 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] bluetooth: mt7921s: Add binding and fixup existing dts
Date: Fri, 12 Apr 2024 15:30:41 +0800
Message-ID: <20240412073046.1192744-1-wenst@chromium.org>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

This is v3 of my MT7921S Bluetooth binding series.

Changes since v2:
- Expand description and commit message to clearly state that WiFi and
  Bluetooth are separate SDIO functions, and that each function should
  be a separate device node, as specified by the MMC binding.
- Change 'additionalProperties' to 'unevaluatedProperties'
- Add missing separating new line
- s/ot/to/

Changes since v1:
- Reworded descriptions in binding
- Moved binding maintainer section before binding description
- Added missing reference to bluetooth-controller.yaml
- Added missing GPIO header to example

This short series adds a binding document for the MT7921S SDIO Bluetooth
controller. The MT7921S is a SDIO-based WiFi/Bluetooth combo. WiFi and
Bluetooth are separate SDIO functions. The chip has extra per-subsystem
reset lines that can reset only WiFi or Bluetooth cores.

Patch 1 documents the SDIO function and the reset line, based on
existing device tree and driver usage. I listed Sean Wang, the original
driver author and maintainer, as the maintainer of the binding.

Patch 2 fixes up the sole existing usage of the compatible string by
making it a proper SDIO function node.

Please take a look. Not sure which tree patch 1 should be merged
through? I suppose with proper acks it could go through the soc/mediatek
tree together with patch 2.


Regards
ChenYu


Chen-Yu Tsai (2):
  dt-bindings: net: bluetooth: Add MediaTek MT7921S SDIO Bluetooth
  arm64: dts: mediatek: mt8183-pico6: Fix bluetooth node

 .../bluetooth/mediatek,mt7921s-bluetooth.yaml | 55 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 .../mediatek/mt8183-kukui-jacuzzi-pico6.dts   |  3 +-
 3 files changed, 58 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-bluetooth.yaml

-- 
2.44.0.683.g7961c838ac-goog

