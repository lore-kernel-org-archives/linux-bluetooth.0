Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9943E49C7;
	Thu, 20 Aug 2026 09:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787217564; cv=none; b=Qtpq4k+4sV8T58/uBVSx9Ri6OzNlTvqGheDMPf8upkeJb/Uvu2/7EI49sgOnozXW5VnQcNn1Zi8jCe4pH/qVMNGR0DNHajmgdJDzJ4lnnmUhQzLUVTUpDqBJNse8TQB/xP8HlQCIlgLXdwLvA6b4D0dfEHirzYkZeebz/bQaRfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787217564; c=relaxed/simple;
	bh=mbW2BIMMfVGSsldSCbqG5lvosCYbDbmQRjQmZXfih54=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DgiitC9Dgy204gLaMQM6J61W0Er+GbA4RrOEJnUIiJwazQqM09X8+qVy46T4vHIFzeJQQPPdV9L8gXU1+aetu8/X+WO95HsVtd3ABWkBrTa4v97T+nLisddqi/a1cIPSOZELDIs2KAi1qoOn1dsDq1UAwRLtt0DbeVW2K4MJGc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=VF3x00Za; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="VF3x00Za"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787217526;
	bh=3zpUkUlVsO35ZlDot63p91o0zUDXl0jQpg3ZCLVGlI8=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=VF3x00ZaSVgKTskAXh6MWQKuP0Ff4/3Y/XoQF0RVUoqfHNuuJSaNqbfogz+zitoas
	 AYqVcafu6nsBTuSiggT3c6BI0OSzJKIpy77JvV1ZcFl774qD1xjR7jDeQpdBun68l7
	 /qwegoyLVbcRS2BOTtKy8k54HpwzO7GYMGnxZLx8=
X-QQ-mid: zesmtpgz4t1787217520t1d6ae224
X-QQ-Originating-IP: BAEvVQstqlpOZwMBF6qcoX2Opdj6hRo/Vjp7XeSXScQ=
Received: from [10.10.7.64] ( [1.202.39.170])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 20 Aug 2026 17:18:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7165249167432056427
From: ZhaoJinming <zhaojinming@uniontech.com>
Date: Thu, 20 Aug 2026 17:17:38 +0800
Subject: [PATCH 1/3] Bluetooth: btintel_pcie: Fix off-by-one bounds checks
 in synchronous paths
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-btintel_pcie_bounds_fixes-v1-1-c9dcd1ac8bf6@uniontech.com>
References: <20260820-btintel_pcie_bounds_fixes-v1-0-c9dcd1ac8bf6@uniontech.com>
In-Reply-To: <20260820-btintel_pcie_bounds_fixes-v1-0-c9dcd1ac8bf6@uniontech.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Marcel Holtmann <marcel@holtmann.org>, Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: OCbhq8eaXCOaRGjSbYeD6ORsoIaYZ35rtU/emSJF5+KfHgxvZ2o4NiOE
	nsqHT5CAWyQT3NnWJ//bl15zrMTrnFvE3M6rrie/A0XlwP6RjpoNbNaypcBUtJu6AdZl5Ak
	+0IN6pYD3lfk4JtmQ72szwWlsKZwgGiUJuA7yXWDrA8nMHlXrFJoFu85AaQQBY5lJTjGm9G
	ThF0KOlS3ztTpJ1GePP4qJvAUjhtJKSQsCuX1FgI1FXFra7LVcmBF4rSrc3QSCgIuk2fFzs
	/nEB2YrNC0DM66FdKHFTaf7Wl/BMr01EzioGq13w3aqekVX8mrMznOgRztrrcGrXMsI8YZd
	70kGMrwxMeirfT4We5PZDWILZDDNIG0EClJeIgxSmo7+igeGXsoMj513nvE9Ps0U6FL0OX6
	SD8xVek/HKukvuMkacpxIfh6Rr1QVzJ5CDCDeW0+z0TkLnE9GxkKfc77BomtpVzQ+9OdBGa
	4JU0gtsCC6rnsfqS76RBgJ6VfkeBlR0E/Gya0uhwawFaFcDrYgz6ogrQCFaWYrm389qZylF
	EISdQ8c8sxa8Ott+qTt+4JVfHNneXi5p+erPT9xKYal3fF8qVh1E5JGAgBWdsXQkkXxZ1kY
	JAUq8z5R8sQ8sPscTwv/9FoW1xPPUbT3nLunaptiuYLpAav9w0SuRgPIt3LAaP0OdR+OUxT
	8loFvj8gDsy2KsgRSm+KElLj39J5T9djioMxmpEoO5nGxJfthuRCmIMqS4Ywrr/My8bCgyA
	uS2L3IRiPXsT41kbbq4+QeLhLOZoJTiQ+QWqeOZtJc8CsaRRkhglJAVDWHDV0P4EGBuL1Im
	7krz6L8iRgN15NtHKPxiXh0D5o6rM1IUML9xKCRJPZ2ejrQE765ZNeteA+usWCQ2OuJJ30q
	4Uk/vdqm4QGYf8Wmc23bwhQyvx+PhLS9+ghiNK1Oe3vxsrzFQ4R6kg7RFtutTjp7q+1xLzD
	WXaHmOghNXZSb7szcAfpFp49fHxTamMAHR+MEMmhBePzo4xQMJhz8bD2W5Wp+33Z6CEnQbe
	ArWvu42PutMJnvKz3LGB31Li9dK+R1e08H8qBUQQ==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

Fix two off-by-one errors where '>' should have been '>=' when
checking array indices against queue count:

1. btintel_pcie_send_sync(): tfd_index from tr_hia is used to index
   txq->tfds[] and txq->bufs[]. When tfd_index == txq->count (32),
   btintel_pcie_prepare_tx() writes past the end of both arrays.

2. btintel_pcie_submit_rx(): frbd_index from tr_hia is used to index
   rxq->frbds[] and rxq->bufs[]. When frbd_index == rxq->count (64),
   btintel_pcie_prepare_rx() writes past the end of both arrays.

Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe transport")
Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
---
 drivers/bluetooth/btintel_pcie.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 2b7231be5973d399f7f2fde344032b2f3e394365..fe50c5699e12ef3819577e0f0bd1b79d4340bd9e 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -401,7 +401,7 @@ static int btintel_pcie_send_sync(struct btintel_pcie_data *data,
 
 	tfd_index = data->ia.tr_hia[BTINTEL_PCIE_TXQ_NUM];
 
-	if (tfd_index > txq->count)
+	if (tfd_index >= txq->count)
 		return -ERANGE;
 
 	/* Firmware raises alive interrupt on HCI_OP_RESET or
@@ -502,7 +502,7 @@ static int btintel_pcie_submit_rx(struct btintel_pcie_data *data)
 
 	frbd_index = data->ia.tr_hia[BTINTEL_PCIE_RXQ_NUM];
 
-	if (frbd_index > rxq->count)
+	if (frbd_index >= rxq->count)
 		return -ERANGE;
 
 	/* Prepare for RX submit. It updates the FRBD with the address of DMA

-- 
2.51.0

