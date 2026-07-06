Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617D23B1EFE;
	Mon,  6 Jul 2026 17:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358846; cv=none; b=TBqghH8199Yx1KlMxCFdOPJehIHp92hYpePa6fFFQnaWekNbDsji4Ei3/Bvd+xvnCf46kFokGEgdbWzTgN71fbpqi+rtbADfEmfWoHVKluvZw4jxG9Tgwver///NoYepX3uGqCnVswgohgzQXyEZWpkKbi/lXxjiocvWC9wud5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358846; c=relaxed/simple;
	bh=DIcPgbrEJz5BYjvlk6j1aB/9gcZjOaZgBL/8SSMWLps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W1TiAYfqZ5tl0YriT22uaA8qyEyW89Nl8gBNzN+IYyavB5B5KrW8dzr3cVVwHpHqFId6B8NxZaqy0+38b/CW/jZeDP7UVKB8Zh6waHf7m1XG9O3NEVlX90IbfrZ83uufeMrX2DQzfu6FZxDmS9bH6QEU11h+oLb6ud3PlQu0xDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BoYcUPvo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BoYcUPvo"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25DECC2BCF7;
	Mon,  6 Jul 2026 17:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783358846;
	bh=DIcPgbrEJz5BYjvlk6j1aB/9gcZjOaZgBL/8SSMWLps=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BoYcUPvouDb94AZrLsWlzO6YVFEgVbXy+TJKbF5feBBfQT1GllNxGMFRdKpt0eFHn
	 yl+Fd4VzZjZi9J/SqpLxMW0Vqdo8MruMqawWS33gAsjkfo6bNxlJlEdRCoR8EVO1EM
	 yndtphC2l/v2VPK77ptVjxcjpkAkGBTLYbBzWFVkPResKBkiXHKFFjc6o7LbuL2cOR
	 F4kOOXMQo6W9/IMMtwIXeZcMBvy7miJWwl5/wlZSDi4KXwlWv7OxIe+BjfyB2lrHhQ
	 iWETFoiQ2WXaBM/4KBFParDBzwUbj/QHfrnMjRk2Ly0KGP3aAZBLqehDA+WWdnw8h1
	 VhNmubq/mG0Aw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3C9C44500;
	Mon,  6 Jul 2026 17:27:26 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Mon, 06 Jul 2026 21:26:22 +0400
Subject: [PATCH v4 6/6] MAINTAINERS: Add entry for Qualcomm IPQ5018
 Bluetooth driver
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-ipq5018-bluetooth-v4-6-350262a30959@outlook.com>
References: <20260706-ipq5018-bluetooth-v4-0-350262a30959@outlook.com>
In-Reply-To: <20260706-ipq5018-bluetooth-v4-0-350262a30959@outlook.com>
To: Bartosz Golaszewski <brgl@kernel.org>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 George Moussalem <george.moussalem@outlook.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783358843; l=976;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=fusdp9JpTX7vO3BYR/LY+GGHauTOjlTp30gMmTqFQZk=;
 b=5v0IEiybgFFGnLpsFG0Ksr4J6prLoXu88B1GDtJUIjZ68VyjzMFi0lfeXr/kqcXuXMAxwyNvm
 7wQ9V0Cps0kArmKByuYBuxchb5zNs9/1t81GzLSgakyxBk15bWLs2a7
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

From: George Moussalem <george.moussalem@outlook.com>

Add maintainers entry for Qualcomm IPQ5018 Bluetooth driver.

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0b9d7c8276ac..60f7251d1a16 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22289,6 +22289,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/regulator/vqmmc-ipq4019-regulator.yaml
 F:	drivers/regulator/vqmmc-ipq4019-regulator.c
 
+QUALCOMM IPQ5018 BLUETOOTH DRIVER
+M:	George Moussalem <george.moussalem@outlook.com>
+L:	linux-bluetooth@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/bluetooth/qcom,ipq5018-bt.yaml
+F:	drivers/bluetooth/btqcomipc.c
+
 QUALCOMM IRIS VIDEO ACCELERATOR DRIVER
 M:	Vikash Garodia <vikash.garodia@oss.qualcomm.com>
 M:	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>

-- 
2.53.0


