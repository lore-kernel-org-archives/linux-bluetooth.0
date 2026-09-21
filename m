Received: from va-2-48.ptr.blmpb.com (va-2-48.ptr.blmpb.com [209.127.231.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3513BBFDA
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 07:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789975556; cv=none; b=pzP1xWLy/1AndHB1BlFcnVYhZzRscLHF1PsvSNASEW4CFILJq8yLqCkEAKVAJU4/wwV7pXXdYqtgf+2a4tCOeX9J+iEpJ7xlIeR8fodRwSof3QsqfNYelCohr+wXIYgpQpXU43wgtfHK6oKM4DOBSDOCo11Ae0s+W9dT6e9pCYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789975556; c=relaxed/simple;
	bh=nzM5gTO1GWA2m5Kh+9CvHaWUY8268pOWjAQZIm4uRck=;
	h=To:Message-Id:Content-Type:Cc:From:Date:Mime-Version:Subject:
	 References:In-Reply-To; b=ar/jIqXmByfRuuBfwl20PP7o7NsZKaoSDk1hrC3r8a98+G9aLS02VzObfAe1ye9Ric35JEqJqEMlFdPvu/IMtr0bu65lIIPZRtF1bmP6zMqRJb7V0LyfdgGgVAiQnAt1eWQy1D9rCmal4iIXBNwBO3ch9biUrNGWIox5IDeFNR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bedmex.com; spf=none smtp.mailfrom=bedmex.com; dkim=pass (2048-bit key) header.d=bedmex-com.20200927.dkim.feishu.cn header.i=@bedmex-com.20200927.dkim.feishu.cn header.b=KhQZcEL4; arc=none smtp.client-ip=209.127.231.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bedmex.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bedmex.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bedmex-com.20200927.dkim.feishu.cn header.i=@bedmex-com.20200927.dkim.feishu.cn header.b="KhQZcEL4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=bedmex-com.20200927.dkim.feishu.cn; t=1789975548;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=IfqQTnorIK/Xbqjew44KxdBihBD+avY1O83tMYUbxbs=;
 b=KhQZcEL4Eja+Z9BnuQVDFCmu7JhzeVFg9Y1nv6Iadx1/TGMr1W4f52ZxHP+z/AM9H+5s5D
 y6GvPU0Kj//OMdQR1ye8LkZ7YIQbbPH6jVeiUXWUtb/eeiCCyltI8Q2+jdZLcy/xyFlFlv
 Sk/ITibQF28ju8552rDKWeNYd5gy1/m3DaJ+RSAwsONuEzs8hDXWBJpcA8FkANhGmKOm7G
 TmdP8XI9g98HRH5vO3slNs+oUNC+PAWsyEhgedqOwKzRfnCFu6UdOB5AwmMwUIAe9Wxhz2
 786wHWVgUNRgrgZKQd/jjJTQNHRe7hYot2N07FyqLtJ5D583U7Xk8WgDy09QfA==
To: <linux-bluetooth@vger.kernel.org>
Message-Id: <cover.1789974593.git.yanli.yang@bedmex.com>
X-Mailer: git-send-email 2.34.1
Received: from bmxpxe-virtual-desktop.. ([36.141.79.164]) by smtp.feishu.cn with ESMTPS; Mon, 21 Sep 2026 15:25:45 +0800
Content-Type: text/plain; charset=UTF-8
Cc: <marcel@holtmann.org>, <devicetree@vger.kernel.org>, <robh@kernel.org>, 
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, 
	<linux-kernel@vger.kernel.org>, <zhirunliu@aicsemi.com>, 
	<dijiaxu@aicsemi.com>, <chunqiuliu@aicsemi.com>, <liheng.wei@bedmex.com>, 
	<yanli.yang@bedmex.com>
From: "Yanli Yang" <yanli.yang@bedmex.com>
Date: Mon, 21 Sep 2026 15:25:40 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Yanli Yang <yanli.yang@bedmex.com>
Subject: [RFC PATCH v3 0/3] Bluetooth: Add AIC8800D80 support
References: <cover.1789897503.git.yanli.yang@bedmex.com>
X-Lms-Return-Path: <lba+26ab0dbfa+2be2e0+vger.kernel.org+yanli.yang@bedmex.com>
In-Reply-To: <cover.1789897503.git.yanli.yang@bedmex.com>
Content-Transfer-Encoding: 7bit

Hi,

This RFC series adds initial Bluetooth support for the AIC8800D80.
SDIO function 1 loads the Bluetooth firmware; HCI traffic uses a separate
UART interface with H4 framing at 1500000 baud and hardware flow control.

The series adds the AIC vendor prefix, Device Tree bindings for the two
interfaces, and the btaic driver with build and maintainer integration.
The UART node references its SDIO firmware provider through the
aic,firmware-sdio property.

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

Changes in v3:
- Express the SDIO reg constraint using an items list.
- Drop the max-speed property because the driver selects the fixed
  1500000 baud rate based on the compatible string.
- Update MAINTAINERS in each patch that adds new files.
- Use the Bluetooth subject prefix for all patches.

The BlueZ GitLint check may flag the auto-generated "create mode" summary
line for the binding path as exceeding 80 columns. No source or commit
message line is involved.

Changes in v2:
- Preallocate the SDIO receive buffer used by the interrupt handler.
- Prevent late responses from timed-out SDIO commands from racing the next
  command and its completion state.
- Accept transfers that exactly consume the available SDIO credits.
- Free the UART receive skb only after receive callbacks have stopped.
- Use the fixed baud rate required by the controller.
- Sync the series to bluetooth-next commit 019debf20bfd.

v2: https://lore.kernel.org/linux-bluetooth/cover.1789897503.git.yanli.yang@bedmex.com/
v1: https://lore.kernel.org/linux-bluetooth/cover.1789546358.git.yanli.yang@bedmex.com/

Thanks,
Yanli

Yanli Yang (3):
  Bluetooth: dt-bindings: Add AIC vendor prefix
  Bluetooth: dt-bindings: Add AIC8800D80
  Bluetooth: btaic: Add AIC8800D80 support

 .../net/bluetooth/aic,aic8800d80-bt.yaml      |  83 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |  11 +
 drivers/bluetooth/Kconfig                     |  16 +
 drivers/bluetooth/Makefile                    |   3 +
 drivers/bluetooth/btaic.h                     |  26 +
 drivers/bluetooth/btaic_core.c                | 180 ++++
 drivers/bluetooth/btaic_sdio.c                | 901 ++++++++++++++++++
 drivers/bluetooth/btaic_uart.c                | 328 +++++++
 9 files changed, 1550 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/aic,aic8800d80-bt.yaml
 create mode 100644 drivers/bluetooth/btaic.h
 create mode 100644 drivers/bluetooth/btaic_core.c
 create mode 100644 drivers/bluetooth/btaic_sdio.c
 create mode 100644 drivers/bluetooth/btaic_uart.c


base-commit: 019debf20bfd648b40ba10377ee0168db5eb241e
-- 
2.34.1
