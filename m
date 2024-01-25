Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4BF1BF3B
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 09:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706176375; cv=none; b=dLxhVGCraYJDJwLxg0TyDh2JoOezWHfxTI84CoHXg/NxKS3eD9iN15tApjJxfwoft5FSJNSSypM1RB4CmN6dkc94lw4+vbmFGHOmQNwqt9Z6m6082M0F5oDv562h3IA+xadiQkebUW/dyUe4UIv1YfENfQaopyqhr1SlVbaxgRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706176375; c=relaxed/simple;
	bh=XatOHzq29LsC83znhYX78FEz2oNmHm7UJXjjb9haMQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BHAXClqnykk7jl0AUxE2LMVtmTeiyuvfT8ASeyjIGH+0oa3XwdWgsA6zQClCtZbFxK68233L7LJCyOug8C3H6ZwDYo5UrNYwjfUTxCVePaJjuaCqrZIhl+dn1J9TMEfORjdzdIjKu2FjyS1YxRauELMvJRcPKWhIKSZNDc73nJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VrBgbijP; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VrBgbijP"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6dd72c4eb4aso2523195b3a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 01:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706176373; x=1706781173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8NO/Zc4uKraRuME+gHTfVr/GjjhDqS6UPAwJbWwu/3s=;
        b=VrBgbijP/5MAQDib7gL96LnQ3b7I4AEn12KKUjTeXvVObvXFGicU2eZeIkcxsiRbi2
         ZlBrp/5Pz9x8WFB1OoVxzlUs0jyTmj06YPlPrVYGHic6mEZOQMLa1ccGEgkazfccU2Wt
         Aka7bOrR0eSYBUpP/u8jLvAjuqCrXiUeXQNSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706176373; x=1706781173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8NO/Zc4uKraRuME+gHTfVr/GjjhDqS6UPAwJbWwu/3s=;
        b=wpEEW3P6jAGjv2Z9MEsxQiGR4c7t67P3WEROu0ddQeyQyOPUfqEaerZwxDL8JIQiAY
         sXNqs4xuHPanovN82yHE3aTJxLDX3DrtkMf0u8OC1bpLY8M9tOUkYt3uDP5vEzf4BSP1
         8QP9oyfGi8w9WkSWPPz+56ha0FotlVZR5v+uhX5Nhgdc/7dtYXhXjo65nxnjygRfhFFm
         xRrGT3ciEmOxytOPCAPjyN4woyIm+SVTwbd3dvyzVtSjklnrczAxi7gdYwdH+D6z1fXI
         SOv2l0V+4gE91t9fqFGxcWHsnByPqMVX7axvMbAbAYgN6P+VPbL5PQ76RrfvmYAktlSX
         0YKw==
X-Gm-Message-State: AOJu0Yyh0DKP52PoaNM6B8DX1jDniQR6dkJcwJdwguZjK5R1krXArSd/
	3pVyeleXbk2jV5+1wmuZeOzcNeg/Kh1TuwyjDp51NhJjJ9hnBRdtX/ct4wkwsQ==
X-Google-Smtp-Source: AGHT+IFz5roRh966c3riGPD3IUjKL6oQhDWhSIiqYZQ6AAZe7dRuh8xja37v3AWjFcAW8gI3Ezje+g==
X-Received: by 2002:a05:6a00:1955:b0:6dd:c1b4:5e61 with SMTP id s21-20020a056a00195500b006ddc1b45e61mr366982pfk.69.1706176373418;
        Thu, 25 Jan 2024 01:52:53 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:7fb6:ed02:1c59:9f9c])
        by smtp.gmail.com with ESMTPSA id gu15-20020a056a004e4f00b006dd8a4bbbc7sm3228275pfb.101.2024.01.25.01.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 01:52:53 -0800 (PST)
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
Subject: [PATCH 0/2] bluetooth: mt7921s: Add binding and fixup existing dts
Date: Thu, 25 Jan 2024 17:52:36 +0800
Message-ID: <20240125095240.2308340-1-wenst@chromium.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

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

 .../bluetooth/mediatek,mt7921s-bluetooth.yaml | 49 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 .../mediatek/mt8183-kukui-jacuzzi-pico6.dts   |  3 +-
 3 files changed, 52 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-bluetooth.yaml

-- 
2.43.0.429.g432eaa2c6b-goog

