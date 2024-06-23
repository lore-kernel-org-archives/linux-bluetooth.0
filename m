Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B148183089
	for <linux-bluetooth@vger.kernel.org>; Sun, 23 Jun 2024 17:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719162842; cv=none; b=PitYQnYgZo8AIR/C83lbILBNBBIsxOZOb2GSrEaqs3cTK7zXoUnEmkq0teWUUGh+bFYCy5iTO5r7BmUU1QAXZo5KIHJFd/6CRJFA+JT/BjHnilAzbgivIH8PwZbFCvJEK5o+QdkKbOYDTx/QgX23rGY4K3LwCFTLxcJrGSl6Tl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719162842; c=relaxed/simple;
	bh=wwJ/x5XQ4O8z0BMXu0cwRhaztroWtvuR6Gh0bMKRKps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kBX//oUhE29gbktByMb151Rqk9hbhTU8u2XxC44itINdB1FnK8jeSq1mgt8aajAhWavf8vPhrs+oJ7uZ98OrK+WHDzcTsq2IgfhUrVJ93OoZV5pZKoK/A04/2pj9g6Jt6qbsVpnI5QleooPOeUt7uubK1O4849qcNA0mmwiYeOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xJiiseiW; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xJiiseiW"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3621ac606e1so2680343f8f.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 Jun 2024 10:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719162838; x=1719767638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a/zZtNnC/KzVU1jMIJC4/FDxQCHloTtcrOBctLMG5CU=;
        b=xJiiseiWNVKavH3Mrg54iyLYF/TMIKS9UfXdZBuD6AcQ/Io03eL99ZtTvjDV1c3ECU
         R9dFET+miJaly6QGrc56QHc7YqkU4ffWjZmIiHmDnvVNSeFGWZZic3swGVDherPMAfhc
         BQa18djriw2gowvMYN8BQGfRzdwAqihDthODHuEUBGIxFjovOLZBnFvmG4h/l3keW5nx
         vGyAt1kHicr+VHYBzNI+B9FesOWpNqHBH6bkjfk3vvNBRGhRs6PFu7zXBcjby9nb+H2i
         n/ojCLdr4OxprKRlEoHvJZd3PcyaPSNu1D0VCl2PepJSmJlaNp2zY3HaCUk8eTVwFfIh
         cyUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719162838; x=1719767638;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a/zZtNnC/KzVU1jMIJC4/FDxQCHloTtcrOBctLMG5CU=;
        b=ubK5XH6+mP3vBnX3S8PvHjD8AZGvpaAnWGo3u9GS+xXYOXSVfXlKD1nwiLvIgX/oAz
         Hs9Ue7zrxoNDLYXIOJdRAqWz6XGw+6finFmcixqyVKMaA2jixo2H5puUxO+MCwQU7QAE
         XRvZq6Wy14DQ95e+I8YJ8U+3Vq6/dS+O3S7L7y2bpPgT1Lel/nTUnbL+yc6FjlHfZFWn
         nmYGTXy/gAUqW7hjfJhqMaAPjSfTjFzbCt7peiK4XTFNlaU9P9yFs0cP/47LMseIC0Ns
         xP2YXYI/5t3FFYqASTnmdezE81rJl5e8AR8c030EJ2BihLZ7IKZMoOr4Y2JTKo6FgtHa
         B4PQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQuNB9pbV9U4VJsy0DADRF45UuNelpci3AA0mbC2LuQYbJO77FLKc1CKNKTeajtuACxgoQ+Of6SruHnRU16SYt6T5njVLkm1KKpEYVQOL+
X-Gm-Message-State: AOJu0YwFvOG+GkRfkWk7jK6uJNCJCgYBJFGmfoSNXiokWN+c2MDTR2A3
	GEv7ZXnctSC03aTCHMUqS25oTBNHF5HvYltNcsdFf2d7kBOW/tCHNXoSIIMA4WA=
X-Google-Smtp-Source: AGHT+IEsXcCBagsv8tL9AutPCA7iuhEkYPNHkSumgoYjzJz2RJ7sKny+qlwrzaHOmWv3pbnNRkCa6A==
X-Received: by 2002:a5d:68cd:0:b0:360:38a6:6bd8 with SMTP id ffacd0b85a97d-366e3686fa8mr2576414f8f.20.1719162838394;
        Sun, 23 Jun 2024 10:13:58 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366383f6769sm7908377f8f.5.2024.06.23.10.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 10:13:57 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] Bluetooth: hci: fix build when POWER_SEQUENCING=m
Date: Sun, 23 Jun 2024 19:13:52 +0200
Message-ID: <20240623171352.305053-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BT_HCIUART_QCA, which is a bool and an HCI UART component, uses now
power sequencing, so we need to be sure BT_HCIUART_QCA=y and
POWER_SEQUENCING=m cannot happen:

  /usr/bin/aarch64-linux-gnu-ld: drivers/bluetooth/hci_qca.o: in function `qca_serdev_probe':
  drivers/bluetooth/hci_qca.c:2401:(.text+0xc48): undefined reference to `devm_pwrseq_get'
  /usr/bin/aarch64-linux-gnu-ld: drivers/bluetooth/hci_qca.o: in function `qca_power_shutdown':
  drivers/bluetooth/hci_qca.c:2192:(.text+0x29e8): undefined reference to `pwrseq_power_off'
  /usr/bin/aarch64-linux-gnu-ld: drivers/bluetooth/hci_qca.o: in function `qca_power_on':
  drivers/bluetooth/hci_qca.c:1808:(.text+0x3390): undefined reference to `pwrseq_power_on'

Fixes: 4029dba6b6f1 ("Bluetooth: qca: use the power sequencer for QCA6390")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/bluetooth/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 87484f5de8e3..90a94a111e67 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -105,6 +105,7 @@ config BT_HCIUART
 	tristate "HCI UART driver"
 	depends on SERIAL_DEV_BUS || !SERIAL_DEV_BUS
 	depends on NVMEM || !NVMEM
+	depends on POWER_SEQUENCING || !POWER_SEQUENCING
 	depends on TTY
 	help
 	  Bluetooth HCI UART driver.
-- 
2.43.0

