Received: from va-2-42.ptr.blmpb.com (va-2-42.ptr.blmpb.com [209.127.231.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897943EBF35
	for <linux-bluetooth@vger.kernel.org>; Sun, 20 Sep 2026 09:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789897847; cv=none; b=K3QW2aV0IGtnBuu9JybEKaHEp38jj4x0Vl+jjfCcfK6jRgQ2rRhtm0bKU3RExVB18tw8L60MNiUYlNKvmflVeMf+kr/2+LmrQlcKwI8+72NKKaztTR0VxIpDo09MW/2PX88a2ZZuCrg73dbMC16l8druk7q9MkwqMKc8Le4j0pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789897847; c=relaxed/simple;
	bh=FxGKFiGA1NYvJbeR/glmcpOryn20NZkLbSjlUmLTYx8=;
	h=To:In-Reply-To:Subject:References:Content-Type:From:Date:
	 Mime-Version:Cc:Message-Id; b=mTY32HjwjchGWRThnctTR5GjfbBap4wIDc0u0YIue1o7h9ottrHoVUxXOrLJlq6gtytM5j4c6s0lzOcYcjCCW7TueS4n4sozY9oMhjTRU5YN7zQxUyqxCoSL46qkpnvng54PEYfk8sd+XGVFAXmnyYwv4fe3oZLZW4KCMMZgkK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bedmex.com; spf=none smtp.mailfrom=bedmex.com; dkim=pass (2048-bit key) header.d=bedmex-com.20200927.dkim.feishu.cn header.i=@bedmex-com.20200927.dkim.feishu.cn header.b=dN9SU2DZ; arc=none smtp.client-ip=209.127.231.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bedmex.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bedmex.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bedmex-com.20200927.dkim.feishu.cn header.i=@bedmex-com.20200927.dkim.feishu.cn header.b="dN9SU2DZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=bedmex-com.20200927.dkim.feishu.cn; t=1789897832;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=AjuyDrWPL4MPoemjbd5vwIdOF5iPGFODtbhkLWhg0+Y=;
 b=dN9SU2DZRj0ZfnkGgwaxOzdHtABoDXHvxur0j+1oU3uLLbbfOxblDJLrFnPJXog4QpAk0k
 NlQjEeUNUzp2b4L47sIqSgMBO6SHAEKmUbklvRtkO99xw8ocVzTL4qLYd3uyZd+8HndHok
 rtqt4J7e7uSOwfcJYSp73Jx9mfAUvZFciRjywG+5CC9n89H00fIRTtlDdvllz8jfREFo0V
 hBlQZr23XSbGBNBLtDBXgA3YntZjKW5RDHBG35/FMOOx4w1uQ/on5doq8M1cv3AY6OJtiy
 5LUWgbGQwuDZl4onQpXuGR/M+7jYcG7cEUfeaPGs33OF7LJHTLAfbom7ZKM1vA==
To: <linux-bluetooth@vger.kernel.org>
X-Original-From: Yanli Yang <yanli.yang@bedmex.com>
In-Reply-To: <cover.1789546358.git.yanli.yang@bedmex.com>
Subject: [RFC PATCH v2 0/3] Bluetooth: Add AIC8800D80 SDIO firmware loader and UART HCI
References: <cover.1789546358.git.yanli.yang@bedmex.com>
X-Mailer: git-send-email 2.34.1
X-Lms-Return-Path: <lba+26aafac66+aa00a6+vger.kernel.org+yanli.yang@bedmex.com>
Content-Type: text/plain; charset=UTF-8
From: "Yanli Yang" <yanli.yang@bedmex.com>
Date: Sun, 20 Sep 2026 17:50:23 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from bmxpxe-virtual-desktop.. ([36.141.79.164]) by smtp.feishu.cn with ESMTPS; Sun, 20 Sep 2026 17:50:29 +0800
Cc: <marcel@holtmann.org>, <devicetree@vger.kernel.org>, <robh@kernel.org>, 
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, 
	<linux-kernel@vger.kernel.org>, <zhirunliu@aicsemi.com>, 
	<dijiaxu@aicsemi.com>, <chunqiuliu@aicsemi.com>, <liheng.wei@bedmex.com>, 
	<yanli.yang@bedmex.com>
Message-Id: <cover.1789897503.git.yanli.yang@bedmex.com>
Content-Transfer-Encoding: 7bit

Hi,

This RFC series adds initial Bluetooth support for the AIC8800D80.
SDIO function 1 loads the Bluetooth firmware; HCI traffic uses a separate
UART interface with H4 framing at 1500000 baud and hardware flow control.

The series adds the AIC vendor prefix, Device Tree bindings for the two
interfaces, and the btaic driver with build and maintainer integration.
The UART node references its SDIO firmware provider through the
aic,firmware-sdio property.

All issues reported by the automated checks on v1 have been addressed.
This version is also regenerated against the latest bluetooth-next master.

Validation status:
- The vendor has confirmed that SDIO firmware loading works.
- UART HCI communication, controller initialization, scanning, pairing,
  connections and data transfer have not yet been validated.
- Suspend/resume and Wi-Fi/Bluetooth coexistence have not been validated.
- No hardware functionality beyond firmware loading is claimed.

This is an RFC for implementation and binding review, not a request for
merging at this stage. Feedback is particularly welcome on the SDIO/UART
split, the firmware-provider association and the device lifetime handling.

The driver requests the following external firmware files:
  aic/aic8800d80/fw_adid_8800d80_u02.bin
  aic/aic8800d80/fw_patch_8800d80_u02.bin
  aic/aic8800d80/fw_patch_table_8800d80_u02.bin
Firmware binaries are not included in this kernel patch series.

Changes in v2:
- Fix the Device Tree schema encoding of the SDIO reg constant.
- Preallocate the SDIO receive buffer used by the interrupt handler.
- Prevent late responses from timed-out SDIO commands from racing the next
  command and its completion state.
- Accept transfers that exactly consume the available SDIO credits.
- Free the UART receive skb only after receive callbacks have stopped.
- Use the fixed baud rate required by the binding.
- Sync the series to bluetooth-next commit 019debf20bfd.

v1: https://lore.kernel.org/linux-bluetooth/cover.1789546358.git.yanli.yang@bedmex.com/

Thanks,
Yanli

Yanli Yang (3):
  dt-bindings: vendor-prefixes: Add AIC Semiconductor
  dt-bindings: net: bluetooth: Add AIC8800D80
  Bluetooth: btaic: Add AIC8800D80 SDIO loader and UART transport

 .../net/bluetooth/aic,aic8800d80-bt.yaml      |  87 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |  11 +
 drivers/bluetooth/Kconfig                     |  16 +
 drivers/bluetooth/Makefile                    |   3 +
 drivers/bluetooth/btaic.h                     |  26 +
 drivers/bluetooth/btaic_core.c                | 180 ++++
 drivers/bluetooth/btaic_sdio.c                | 901 ++++++++++++++++++
 drivers/bluetooth/btaic_uart.c                | 328 +++++++
 9 files changed, 1554 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/aic,aic8800d80-bt.yaml
 create mode 100644 drivers/bluetooth/btaic.h
 create mode 100644 drivers/bluetooth/btaic_core.c
 create mode 100644 drivers/bluetooth/btaic_sdio.c
 create mode 100644 drivers/bluetooth/btaic_uart.c


base-commit: 019debf20bfd648b40ba10377ee0168db5eb241e
-- 
2.34.1
