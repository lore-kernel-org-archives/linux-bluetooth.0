Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B001716B739
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jun 2024 08:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718179340; cv=none; b=D6KeVp4uhjL4s9Aaeiatqo3gEUTp01HOSM++hBvOUKM83jhu6juHs8gR7s+chFPuQX/QMtMSNJUAGfzfjzyCt/xB6hjYdCsD2wwH5zmXBI840X32iOXZnk+pn+dJr9VK4AL9C56DUgO5liI80a/eTi5K3vooHpAO8S5udurP1Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718179340; c=relaxed/simple;
	bh=s3mfIsukRZmgouUhCyn9Wd/i7okI8+3DBaijsAj2WU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=onzVQXXQlji633bbp9qtqvmJ/wNFpx0mce6Ea5YV73ir1IdtVD6uJc0t4CMJi2IfBzX/1+AHmzkBwU82NHp5Ol10TmA7eQ0XEcfW0vhjRO0TGYKX9ks2iUCjBw75LKH+t9qnzPuWRptNE8jvAgHhgve4sy9mfSNRwpSOqTvLURo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=MoeWCxca; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="MoeWCxca"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-35f23f3da44so2817230f8f.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jun 2024 01:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718179337; x=1718784137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8ksBSyA+j9QPSkEsVDee/zoG9hDnAPGUv/QuDtN8Vy0=;
        b=MoeWCxcaJfh4knync7Fc5ivflDbf+9FUEE4rB9Ur7qKbL8a94cOa+R9bXm5ThhCHJO
         gCCH9S+Z9MK+HaXEqOQ5yHiwlN1P6itZ/HCXwFWuZISe9hz8k2MYUE9NZbvOlxBvpFgk
         4hTdEom3Tts/IGl/qct4vm7zZyaeC2khtddA4LoOdDjRr2rIvkjd0rwHGALNTkO60e8D
         S7301X071GmGv2MQGLP8xMty8r4p/PadhvwT+J103O0s6gSHECateWf07JHyJqB4RZ0q
         wYhIk7ZL3cMCjYvZ/X/C58tEJA3Ndaa6/kFXlksEzBjgrxoEnfz3vmRyzYnySSHSf796
         1QlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718179337; x=1718784137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ksBSyA+j9QPSkEsVDee/zoG9hDnAPGUv/QuDtN8Vy0=;
        b=Lssts6FX7OVNefJByKhmpT+LtmIHt8fzxQ1MmSXDIeVXHQbQ9TEFlucmmaO2OzfzM/
         jFv5SLQ3ct8uIeWdELegSiNZzbG9zQnZq8YMpbWKvOhrj0NbdAGD+ewmPEVm/tYMbsTT
         UwU9L1KqiubPbpDY9ATScbJ8irzRRVJfU8Uv1Wg14VgoZ6PLz8KYA7XX5ww6RbJMiuMN
         KQCkrqx936FO2Qn4PBsNTzTeriVWEqauibCevOJWnAA3b3xUuwuy/Jl4p3+54HM4cwTe
         +FA9wvcSSqqFfCbg66Z9+uP/FK9bRaaVjAeataoZcbuTpvbzgOXvAcob6yjMC2u1T1u+
         F71A==
X-Gm-Message-State: AOJu0YzP2xNGDHOy5JhTAx4t6lLEL3S8QVWLmEf2SvjwSiCBY13O/3S/
	Gs4VZSHYj9rgIRLSZjdhUqtvp3j8KE1gefmhXI5dpueHCqXn6a97Rsv+CRHwZd0=
X-Google-Smtp-Source: AGHT+IFXYFUX0JPIwmj9Dya04E+MPasUBHNXYfyKZZbDpuWUHf5YESL4MGY5Xiz2kjIyRyPElOx9vw==
X-Received: by 2002:a5d:6a8c:0:b0:35f:1cbe:2e2f with SMTP id ffacd0b85a97d-35fe8917f56mr730173f8f.47.1718179336991;
        Wed, 12 Jun 2024 01:02:16 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:8d3:3800:a172:4e8b:453e:2f03])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f24c7a9c8sm7452585f8f.78.2024.06.12.01.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 01:02:16 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v9 0/2] Bluetooth: qca: use the power sequencing subsystem in hci_qca
Date: Wed, 12 Jun 2024 10:01:48 +0200
Message-ID: <20240612080150.18375-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Here are the dt-bindings and the hci_qca patches split out of the larger
power sequencing series. They target the Bluetooth subsystem but depend
on the following immutable tag:

    https://lore.kernel.org/lkml/20240612075829.18241-1-brgl@bgdev.pl/

Please consider picking them up into your tree, they were reviewed and
thoroughly tested.

Changelog:

Since v8:
- split out the Bluetooth patches into their own series
- Link to v8: https://lore.kernel.org/r/20240528-pwrseq-v8-0-d354d52b763c@linaro.org

Since v7:
- added DTS changes for sm8650-hdk
- added circular dependency detection for pwrseq units
- fixed a KASAN reported use-after-free error in remove path
- improve Kconfig descriptions
- fix typos in bindings and Kconfig
- fixed issues reported by smatch
- fix the unbind path in PCI pwrctl
- lots of minor improvements to the pwrseq core

Since v6:
- kernel doc fixes
- drop myself from the DT bindings maintainers list for ath12k
- wait until the PCI bridge device is fully added before creating the
  PCI pwrctl platform devices for its sub-nodes, otherwise we may see
  sysfs and procfs attribute failures (due to duplication, we're
  basically trying to probe the same device twice at the same time)
- I kept the regulators for QCA6390's ath11k as required as they only
  apply to this specific Qualcomm package

Since v5:
- unify the approach to modelling the WCN WLAN/BT chips by always exposing
  the PMU node on the device tree and making the WLAN and BT nodes become
  consumers of its power outputs; this includes a major rework of the DT
  sources, bindings and driver code; there's no more a separate PCI
  pwrctl driver for WCN7850, instead its power-up sequence was moved
  into the pwrseq driver common for all WCN chips
- don't set load_uA from new regulator consumers
- fix reported kerneldoc issues
- drop voltage ranges for PMU outputs from DT
- many minor tweaks and reworks

v1: Original RFC:

https://lore.kernel.org/lkml/20240104130123.37115-1-brgl@bgdev.pl/T/

v2: First real patch series (should have been PATCH v2) adding what I
    referred to back then as PCI power sequencing:

https://lore.kernel.org/linux-arm-kernel/2024021413-grumbling-unlivable-c145@gregkh/T/

v3: RFC for the DT representation of the PMU supplying the WLAN and BT
    modules inside the QCA6391 package (was largely separate from the
    series but probably should have been called PATCH or RFC v3):

https://lore.kernel.org/all/CAMRc=Mc+GNoi57eTQg71DXkQKjdaoAmCpB=h2ndEpGnmdhVV-Q@mail.gmail.com/T/

v4: Second attempt at the full series with changed scope (introduction of
    the pwrseq subsystem, should have been RFC v4)

https://lore.kernel.org/lkml/20240201155532.49707-1-brgl@bgdev.pl/T/

v5: Two different ways of handling QCA6390 and WCN7850:

https://lore.kernel.org/lkml/20240216203215.40870-1-brgl@bgdev.pl/

Bartosz Golaszewski (2):
  dt-bindings: net: bluetooth: qualcomm: describe regulators for QCA6390
  Bluetooth: qca: use the power sequencer for QCA6390

 .../net/bluetooth/qualcomm-bluetooth.yaml     | 17 +++++
 drivers/bluetooth/hci_qca.c                   | 74 +++++++++++++++----
 2 files changed, 76 insertions(+), 15 deletions(-)

-- 
2.40.1

