Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B5C1D54D
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jan 2024 06:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706250908; cv=none; b=PaTktZ9zqn3id7ao3nOpxfdm5EARR3G/OS+5QPzQJNhvoj7D82CmQ6L2Gnp+jgWlaAuDbyFNDozbkM4RSFbOBNSbcc+JunxOGPAf+NhUYdJM7S5HwsDDq3cxqs+580gwLnokoyWcBMOWiaxgj2Jo1ZgEZ7JvNpFEi9P2f/UYTFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706250908; c=relaxed/simple;
	bh=NH2euUCqwPzQ8EOeRcSGE0TtlrdDDvu0F19oCXj/2VM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ngRI9VPqfZ+STPpw8D51+pjkrs/Y26fY/ZjWdFh43wGrcMLaUTDGCJpHi5JBANFXhZwkNuluvLASzOrladA0qOTs8qBU4qSGt0Ld/qmC5Bs2oBF8wMApCrl42HzXqCFtd61djKnCOP5ZhrHo6CHwW5FIK5MUVfWdtb8Qh0lxk30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bxpTrb+M; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bxpTrb+M"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6d9b37f4804so1012597b3a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 22:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706250905; x=1706855705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ySgp2UiszzMfNCnD6O5mfCcxxHNvIaL6WmT8mRfAk0M=;
        b=bxpTrb+MRMOYJIzkdauCkxaRZKK01HcEuQMG3e070C9PhDFEutxkdCGlJK8NSYYFcc
         8vx0bH2a/ZrlIG/rdsbLbIwEhWHY9XZkwA5o9+LvuIc/H8rgRluf5iDRk6Dkovr7gnFH
         xWjfxdQiW1+Om+itQt9LKXpd6ld3gNTjBLfok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706250905; x=1706855705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ySgp2UiszzMfNCnD6O5mfCcxxHNvIaL6WmT8mRfAk0M=;
        b=SO37a4+RT6Fetlds0A7DkNSgaS68PnWf7XMmXHORFV0vBbLgplEaPmOKD34WBhjshQ
         arfaNZHQRQKm6OtWo+5iGkbzlNCPmfmaOOqKy2nQ2PoZgCIa4fvkRzmC+5ds3Uw/UVvh
         yQawI+tFJN0I/HSwF6I1pB9rItd4lmAIXG+mef4UBy+etd7ciDmkYBGBF398Ng0SPpRt
         9p6SMw+uPgwNCsMQKKM7J7B395S/orZ/6GPdVnHdiQK6oge2mh4Wb5bY/scSA/Njp0y/
         MMWQQxvDJwrzkfIsV2DCi8u+cwJFzSvbXH/6XLTl87yi8dfyTSUl1kVuL6jkoOJqJWR6
         pO3g==
X-Gm-Message-State: AOJu0Yw7Q6VzKAdlBo45PJehGN8U39Who7Ek+LPCPsPsf2l6KVUy9Oyn
	HzxZmNf+dHIfD6vSdoqBA1HK07ySqG0pEL3qT9TfpclOpOF+BOPukVgnwXStww==
X-Google-Smtp-Source: AGHT+IF1szoUbF1JDZy6toVdzGRAw8HhVOL8J8FWhgQ/IhKqWQPq084VnvUGMXytbOdxbOyYMcX4MA==
X-Received: by 2002:a05:6a21:3987:b0:19c:53ab:d7d0 with SMTP id ad7-20020a056a21398700b0019c53abd7d0mr684905pzc.50.1706250905647;
        Thu, 25 Jan 2024 22:35:05 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:2614:bbbd:8db2:1f54])
        by smtp.gmail.com with ESMTPSA id ka3-20020a056a00938300b006db13a02921sm488735pfb.183.2024.01.25.22.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 22:35:05 -0800 (PST)
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
Subject: [PATCH v2 0/2] bluetooth: mt7921s: Add binding and fixup existing dts
Date: Fri, 26 Jan 2024 14:34:56 +0800
Message-ID: <20240126063500.2684087-1-wenst@chromium.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

This is v2 of my MT7921S Bluetooth binding series.

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

 .../bluetooth/mediatek,mt7921s-bluetooth.yaml | 53 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 .../mediatek/mt8183-kukui-jacuzzi-pico6.dts   |  3 +-
 3 files changed, 56 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-bluetooth.yaml

-- 
2.43.0.429.g432eaa2c6b-goog

