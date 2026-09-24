Received: from va-2-53.ptr.blmpb.com (va-2-53.ptr.blmpb.com [209.127.231.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7EF2E7396
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 03:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790221074; cv=none; b=q1w4eTg8Sui3zn8cYVjtd0HZ81YhO3ufwnx+jaTCrFV0FSEK8vcSUJiOrmUmlF54znHV7QPZOvfoz7Wjm65mTToYk9IVIVHSEfvXyuDTb4YAeHQpUlAvHktiYj5KheKeEMJnFX2ioIGL7HwcK0Ir1tWWi0vKWEteK3tJV+IXpU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790221074; c=relaxed/simple;
	bh=5EU0bxSVGEegkWQ4PGJYE9ZPbgd+GZOqVY4jGV+GMNs=;
	h=Subject:Message-Id:Mime-Version:Content-Type:To:Cc:From:Date; b=pk0ULRh5y2XuNUST9Y770/dVlDxebYuHLKR5VhD7ACGuiGPSmnikHubFSTtI/pBxxvGpEmfFnNz2tK4NoIjs8UG78zwFacWoyYsANiGihTOqWtZzhHpBJ8Kb1DBSS5JvGUE2N6nAjdJxlTw8bdikCfAGbfm7APD7piyPXIlQDZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bedmex.com; spf=none smtp.mailfrom=bedmex.com; dkim=pass (2048-bit key) header.d=bedmex-com.20200927.dkim.feishu.cn header.i=@bedmex-com.20200927.dkim.feishu.cn header.b=SsMpFqbA; arc=none smtp.client-ip=209.127.231.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bedmex.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bedmex.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bedmex-com.20200927.dkim.feishu.cn header.i=@bedmex-com.20200927.dkim.feishu.cn header.b="SsMpFqbA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=bedmex-com.20200927.dkim.feishu.cn; t=1790221067;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=XC5ewBJozY41JAb1LkITeeeHNvXRSoM4Q7N7Vn8kgrg=;
 b=SsMpFqbAfVRmDOzorraAB+MsHvqBWhX+ntVpgmCIxyUnmiiFej4R9aGBopSYoVN8SMKW6I
 cnSVVg4H58RffU/QhvyVprJWL9eZR3vLYbloMfcZBd7iI+xnrVc+1axhU8EKFo1/6mJEzQ
 Ij04GjUARBlbk3yM0IGocAp8NU9JTBtzmLdySsVH60Fu8S1XX+pM9pwnHWB0qdaZUEXbnD
 BXtTFdqfIrTR4mLN0oGKC+zVSyYZZATltHHsxmhNqZxmR0Y82TSCDxWDot3TcgQhMgqHEf
 dT49AVR2txPTRDmBReV2qvn5WBFuX26ENRC7V/GRhXifleSvNRs1hKANIkEFng==
Content-Transfer-Encoding: 7bit
Subject: [PATCH bluetooth-next v4 0/3] Bluetooth: Add AIC8800D80 SDIO firmware loader and UART HCI
Message-Id: <179022103315.2.2907053891316619435.btaic-v4-cover@bedmex.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from [127.0.1.1] ([36.141.79.164]) by smtp.feishu.cn with ESMTPS; Thu, 24 Sep 2026 11:37:44 +0800
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+26ab49b09+8e6ea3+vger.kernel.org+yanli.yang@bedmex.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: <marcel@holtmann.org>, <devicetree@vger.kernel.org>, <robh@kernel.org>, 
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, 
	<linux-kernel@vger.kernel.org>, <zhirunliu@aicsemi.com>, 
	<dijiaxu@aicsemi.com>, <chunqiuliu@aicsemi.com>, <liheng.wei@bedmex.com>, 
	<yanli.yang@bedmex.com>
From: "Yanli Yang" <yanli.yang@bedmex.com>
Date: Thu, 24 Sep 2026 11:34:10 +0800
X-Original-From: Yanli Yang <yanli.yang@bedmex.com>

Hi,

This series adds Bluetooth support for the AIC8800D80. SDIO function 1
loads firmware; a serdev UART carries H4 HCI traffic at 1500000 baud with
hardware flow control. The three patches add the AIC vendor prefix, the
Device Tree binding, and the driver with build and maintainer integration.

Changes since v3:
- Clear uart->rx_skb when serdev_device_open() or baudrate setup fails.
  RX may have started before open returns; the HCI core does not call the
  driver's close callback after an open failure. The buffer remains
  reachable and would be freed on removal, so the issue is stale RX state
  and retained memory after a failed open, rather than necessarily a
  permanent leak. serdev_device_open() can also enable the controller and
  then roll back after a runtime PM failure.
- Adjust the binding's SDIO reg constraint and use kzalloc() for the boot
  state allocation in the target tree.

Review of the other reported findings:
- The TX/RX IPC layouts are intentionally asymmetric, as in the AIC BSP.
  TX has a 4-byte dummy word before the message ID; RX has a 4-byte pattern
  after param_len. The BSP RX path casts the buffer at offset 4 to
  struct ipc_e2a_msg. Accordingly, the RX response ID is at frame offset 4
  and param_len at offset 10. The reported firmware-loading layout mismatch
  is a false positive.
- In this target tree h4_recv_buf() takes struct hci_uart * and forwards
  hu->hdev to h4_recv_skb(). The driver sets uart->hu.hdev before
  hci_register_dev(), so passing &uart->hu is type-correct. Commit
  b489556a856d ("Bluetooth: fix corruption in h4_recv_buf() after cleanup")
  changed this API; the reported type mismatch refers to the older API.
- If skb_cow_head() fails, aic_bt_send_frame() returns the error without
  consuming the skb. hci_send_frame() frees the skb when ->send() returns
  an error; freeing it in the driver would cause a double free. The
  reported skb leak is a false positive.
- sdio_bus_probe() releases the MMC host before the driver probe, and
  aic_bt_sdio_hw_init() releases it before firmware loading. No
  request_firmware() call holds the MMC host or AIC command locks. The
  command path also releases the host before waiting for IRQ completion.
  Synchronous firmware loading may delay probe, but the reported SDIO
  deadlock does not apply.

The bluez.test.bot mgmt-tester and mesh-tester failures also reproduce
with unrelated patches and appear to be CI test failures. The GitLint
failure is caused by the automatically generated "create mode" line for
the DT binding path.

Validation: The vendor has confirmed SDIO firmware loading. UART HCI
communication, controller initialization, scanning, pairing, connections,
data transfer, suspend/resume, and Wi-Fi/Bluetooth coexistence have not
been validated on hardware. The external firmware files are not included
in this series.

Thanks,
Yanli

Yanli Yang (3):
  dt-bindings: vendor-prefixes: Add AIC Semiconductor
  dt-bindings: net: bluetooth: Add AIC8800D80
  Bluetooth: btaic: Add AIC8800D80 SDIO loader and UART transport

 .../net/bluetooth/aic,aic8800d80-bt.yaml      |  84 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |  11 +
 drivers/bluetooth/Kconfig                     |  16 +
 drivers/bluetooth/Makefile                    |   3 +
 drivers/bluetooth/btaic.h                     |  26 +
 drivers/bluetooth/btaic_core.c                | 180 ++++
 drivers/bluetooth/btaic_sdio.c                | 901 ++++++++++++++++++
 drivers/bluetooth/btaic_uart.c                | 337 +++++++
 9 files changed, 1560 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/aic,aic8800d80-bt.yaml
 create mode 100644 drivers/bluetooth/btaic.h
 create mode 100644 drivers/bluetooth/btaic_core.c
 create mode 100644 drivers/bluetooth/btaic_sdio.c
 create mode 100644 drivers/bluetooth/btaic_uart.c

-- 
2.34.1
