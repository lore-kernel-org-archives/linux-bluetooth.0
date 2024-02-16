Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD96613B28A
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Feb 2024 20:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708115597; cv=none; b=B2X3Uo5sGBKylm6TnznrLhYFXIP9/wBfU8/8KZ56c1GnNux2gpXp3CNTuvhrQFYx3g8aOUxGk93/u42bcDNb0rCpVze1Tc3deiq+4KRZFIZGAja7sPuA+dnIze/7uh6Kl825oHLKYEnZNY37w34/j3p9hl6tZVdY1QyTD8Ts2No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708115597; c=relaxed/simple;
	bh=2ltRDktWv/9W2XdsRxj5VGYiomy6evtqamrK4xBuy4U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rt/Vjch4GjERmtPRUBTj3Y4cRyVf53tvZv4/iR+XUy/s4OcFKyn08Ny8J1kNgno+kq85THwfuuI9xNJiXmatucPDlcMDZ4k2aQ3mMlF2/hC/1yKQh+0Svh47T08H6fI+UT6YFwuVeZUgbR3qmuMuIAjWy4x/F5bM/Es2QfJZeu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=y6k7gcJp; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="y6k7gcJp"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-411de7c6b3dso18844465e9.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Feb 2024 12:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708115594; x=1708720394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ck620ZgSsNsz/9RxF9gWPnIMgXNLaJ0oGJUqb+80gj0=;
        b=y6k7gcJpn+XZ7AWF0/XvQ4Q96VAarA6gk2frrhD65tMM3JI9chOvKebMHaLmx4VQiy
         6SyTWxxIavK/cq/ZWOWDmyNL8aQ7ZpAPOS+QbbNjvv6lwYLullK5EHPYW1rKz2HeEuGE
         REY6g/xSFDyFDikTpkIhvvvaIdB0KTc1IDerWBG62xuN5qmk0Gw7GuMS30WD1arpBHQ+
         JSLKA/Tl4G0zDeSEZkjdyoNdLLpHpJbJYiZI8QvQgWXBs0A/7+pCBR98BsTT077hmART
         8mZxoDeB7vnlYJILMdHv6J8oSe44huKkGYx14nIb0jVR6QEyPfLq6FnBSjhLdqnIPFUI
         e7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708115594; x=1708720394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ck620ZgSsNsz/9RxF9gWPnIMgXNLaJ0oGJUqb+80gj0=;
        b=gX3vgAir5vE9VRjT/KxVh0NwFkRmUH+rzirT3+qjetHa700doDq9DyJkvwIbkIVCy9
         fiIwNjPxCaC/vFkTYlOw9yhKRk02E5p3br6DX7itDJyAE8XWEE6bHSpeZdqsYRtDL4b1
         Ya002UcCzp70J1idHopU4ZcDiM1whwqrDThv93Ubf6sBa9ZR2UW8BNTO0lOdaJ9FCRIn
         8y7+bxGGEBs13z+E2l8VeAZ48VEkh9jsbUkVpMKkhamW0G7JDP6Dp40Ssl8hpC98BMLJ
         S/Zfho0q9YCMEfVxe5TY6oe8W6ZFRlGm2dsxntyjwioaLOkZlUajjwOz8HdEB49flJBu
         VdEQ==
X-Gm-Message-State: AOJu0Yylthu5tTTdTsWWDLmVrDMhGOdqzhTNmCLFP1J59EkIf2FtaIQh
	G939GmC8FO3QCtHtHoJu1YeMWyyJi8ahrf5RncLgLNWOPk+VxH1R2CnsffyrP/k=
X-Google-Smtp-Source: AGHT+IFWK3RiERh4OJ6PyhlMX4HmF3lfvM2tBpYy/a0m9DxHn1nwJ9Sx7MIneHFQhvuUZ8wTNDj2GA==
X-Received: by 2002:a05:600c:1389:b0:40e:dbdf:9fb4 with SMTP id u9-20020a05600c138900b0040edbdf9fb4mr4364542wmf.23.1708115593893;
        Fri, 16 Feb 2024 12:33:13 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7758:12d:16:5f19])
        by smtp.gmail.com with ESMTPSA id m5-20020a05600c4f4500b0041253d0acd6sm1420528wmq.47.2024.02.16.12.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 12:33:13 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Saravana Kannan <saravanak@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v5 02/18] arm64: defconfig: enable ath12k as a module
Date: Fri, 16 Feb 2024 21:31:59 +0100
Message-Id: <20240216203215.40870-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240216203215.40870-1-brgl@bgdev.pl>
References: <20240216203215.40870-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Build the ath12k driver as a module for arm64 default config.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index b8adb28185ad..23d6bb156cbc 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -409,6 +409,7 @@ CONFIG_WCN36XX=m
 CONFIG_ATH11K=m
 CONFIG_ATH11K_AHB=m
 CONFIG_ATH11K_PCI=m
+CONFIG_ATH12K=m
 CONFIG_BRCMFMAC=m
 CONFIG_MWIFIEX=m
 CONFIG_MWIFIEX_SDIO=m
-- 
2.40.1

