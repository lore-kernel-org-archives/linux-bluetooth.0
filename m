Received: from va-2-56.ptr.blmpb.com (va-2-56.ptr.blmpb.com [209.127.231.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBA94307B0
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 07:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790235770; cv=none; b=tPv5582NeBuGuPL9K7mhSxbxKem55eprix7Sb+5+C0hvL4Jkyx5e1teTKko+Lqcz0c/omU7N/7+wVvogTRD9ZQcGjXOD4DOHy1U1eIZkO9IWuF+Bpipc6GXtNvBo7FRLgaPz3LfgWGpEAE6MwPujqdnWXCtj8erSkAbeCoVBrgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790235770; c=relaxed/simple;
	bh=T5YePKTHICCtYtzF62kJRfr2cPAKceA18nP4ZYno6IA=;
	h=Subject:Mime-Version:Content-Type:Message-Id:To:Cc:From:Date; b=tQAEIzGg/BgKTAf6DDwG7mxW6vVrU1tC/qMmKo03XPtZIhb6pBrc+wSV83mUBOhHpGkUUCag1Jzo0K0XB6bOK4FAKx1PoiG147YOiIsq9DSNI7Ay7thLdaRBLGkGeV9ig+Hbf98DYoBHbsiGF44zYo9+fGHEf+bt+W706yEmUNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bedmex.com; spf=none smtp.mailfrom=bedmex.com; dkim=pass (2048-bit key) header.d=bedmex-com.20200927.dkim.feishu.cn header.i=@bedmex-com.20200927.dkim.feishu.cn header.b=ecxEcJ0e; arc=none smtp.client-ip=209.127.231.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bedmex.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bedmex.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bedmex-com.20200927.dkim.feishu.cn header.i=@bedmex-com.20200927.dkim.feishu.cn header.b="ecxEcJ0e"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=bedmex-com.20200927.dkim.feishu.cn; t=1790235760;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=xYBw+ciwzN5UAFisFtBzHtVV9HDzfuM1sLzacSqdMQM=;
 b=ecxEcJ0eTT6VIgCjiy7kRUUV8wer690UTzo6pgjCkqCBDx2UEXIabmbkYp0w96HMqSnojd
 emrYwBm6GWuhcRkyuGEvUKbeEtWmOB9THl6S8ZnGhyvXkNuBuawbQOGNH7jh3tMpo2JWve
 F87eIreSNyChEnrC4y29EpGwXyzHmuNPk3QhFMv0sT5huUE+j1FZuYueIi2DdwtxFnN0J6
 oWb6YhrsKI0TafBP4YxMXQs6aEbbpE8kVc3ko6/x2/m12Md8ynrCvhaug44nwNCotD2QAF
 kwCeeQQ6s2WlvLXBDlbq4Sg2NsPn+YT6xJEaToqVQUz6YgXN214KDaJelr/PzQ==
Content-Transfer-Encoding: 7bit
Subject: [PATCH bluetooth-next v5 0/3] Bluetooth: Add AIC8800D80 SDIO firmware loader and UART HCI
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Yanli Yang <yanli.yang@bedmex.com>
Content-Type: text/plain; charset=UTF-8
Message-Id: <cover.1790235697.git.yanli.yang@bedmex.com>
Received: from [127.0.1.1] ([36.141.79.164]) by smtp.feishu.cn with ESMTPS; Thu, 24 Sep 2026 15:42:36 +0800
X-Lms-Return-Path: <lba+26ab4d46d+538206+vger.kernel.org+yanli.yang@bedmex.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: <marcel@holtmann.org>, <devicetree@vger.kernel.org>, <robh@kernel.org>, 
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, 
	<linux-kernel@vger.kernel.org>, <zhirunliu@aicsemi.com>, 
	<dijiaxu@aicsemi.com>, <chunqiuliu@aicsemi.com>, <liheng.wei@bedmex.com>, 
	<yanli.yang@bedmex.com>
From: "Yanli Yang" <yanli.yang@bedmex.com>
Date: Thu, 24 Sep 2026 15:41:37 +0800

Hi,

This series adds Bluetooth support for the AIC8800D80. SDIO function 1
loads firmware; a serdev UART carries H4 HCI traffic at 1500000 baud with
hardware flow control. The three patches add the AIC vendor prefix, the
Device Tree binding, and the driver with build and maintainer integration.

Changes since v4:
- Use kzalloc_obj(*boot) for the boot state allocation, as requested
  by checkpatch.
- Mark the SDIO system sleep callbacks __maybe_unused for builds
  without CONFIG_PM_SLEEP.

Thanks for the report. kzalloc_obj() is defined in include/linux/slab.h
in the target bluetooth-next tree, and btaic_core.c includes that header.
Therefore, kzalloc_obj(*boot) will not cause an undefined-macro build
failure. It uses GFP_KERNEL by default and also follows checkpatch's
recommendation for this allocation.

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
