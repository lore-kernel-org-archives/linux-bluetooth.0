Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.69.30.187
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794096301;
	b=DLByyk/7dL+tauoMzcAa0v0NMTtKyQ3x/XDDAjt+OUJle0AQmtderA8BV+gd935ZZ5WE
	 d/CluZnAcJ7Xtfdfpk7MkwhGUE57DzzictMGh6HJMogxn/HP9QKre9oMmr3yxuQ+/kXgj
	 pT/4GLc42YDto9+uqGml8+hXkeKvxzig94qCOeNy0Vprh0CjWQojuDk5jzDz2cytsZvxc
	 bIgflBtOLVDgsoCP2rVtTLLpEDUJIWUxDxPeBDvlSWqWve4wBpHX6cNa9Cc4aeFomfmdH
	 /1eeaZ6mIbPR2hcMDDziV8P6A2R0AXlRZTH8Q+uqF9YJqXoWKWf3nGYFVQjJfdhirTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794096301;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding;
	bh=LmZxkVpHpG5gwGpw1CjPnOAKtcfXo0x6WpaFvpVN4Lc=;
	b=ffMwyS9QhKuYdOdVwfR6Qqrw82H4WqpZSRSrMR5H4gwuhmw4+UYouOlURJlbQJNhTDP7
	 XGfcGCNw0FKHUak5avRBQzByeT+c+A1oQnAlVSEnPzVBeLBluArhicSBEgk4mCgoYMslK
	 r+sH+u1CfO4Nl1MEEf8yQoxKolP6FKZ+eZfIwDjW20WoXc/eU7dLS+L2FefFkcPggZXVx
	 7U5gkrlZtKCZL+YtJt9Sm+Te10bbdkdNLNpUWULoDEjBBzklQwDDhv9Ckl2QkWOXMxX4E
	 DnfyM/TVUlZJdGy6uhVSlgxolw++ej5ofl7KOMThDzXYt9Guaf+uEpWf6qSL/pyaEEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=freenixos.com;
	spf=pass smtp.mailfrom=freenixos.com;
	dkim=pass header.d=freenixos.com header.i=@freenixos.com header.a=rsa-sha256 header.s=mail header.b=SY2u16Qi;
	arc=none smtp.remote-ip=54.69.30.187
Received: from mail.freenixos.com (mail.freenixos.com [54.69.30.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7E0606A326;
	Sun,  8 Nov 2026 00:05:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D7E0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=freenixos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freenixos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=freenixos.com header.i=@freenixos.com header.a=rsa-sha256 header.s=mail header.b=SY2u16Qi
From: Hex Lindqvist <hex@freenixos.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freenixos.com;
	s=mail; t=1794096293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LmZxkVpHpG5gwGpw1CjPnOAKtcfXo0x6WpaFvpVN4Lc=;
	b=SY2u16Qif3NCKwyC/rOUUlvu5lrSx1etUWHWVVnAQsyKb/adNhX6vjgv2ES6iKzGwoGf9J
	OMM3kqN+5RolkzNhcgrWP60GuZc+/pJZp0ZCH/l7CmqaKTfd/AmpBqMF4TL9aKCNNKxK+m
	n6YTGMzRgHjHILOfJofX4sGzhyMxyPfxnuaiIS/u83eV4s3OV+10J27y5P70ynRQ/7rPqa
	5aimE81XuTud2Nyz9e+OOk7RQuodKuPMRsFHK0SS+EDMRm+5M5gVZx7rOb/o+sOotiW4oe
	ABzvdiuPZOdlTwCkbCdIYVHVVZuf3EC4/ILx4wuYCC3lKs7nIBa7RrTv1hsP/w==
To: Bartosz Golaszewski <brgl@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	linux-bluetooth@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] Bluetooth: qca: Disable SoC debug logging for WCN3990
Date: Sat,  7 Nov 2026 16:04:49 -0800
Message-ID: <20261108000449.2664455-1-hex@freenixos.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unless the host turns it off, the WCN3990 firmware sends debug logs to
the host as ACL packets on handle 0x2EDC. hci_qca passes them on as
diagnostic packets, which the core copies to the monitor socket and then
frees, so nothing appears in the kernel log. btmon shows them as:

  = Vendor Diagnostic (len 492)                      [hci0] 0.761331
          dc 2e e8 01 e4 01 03 00 0a ff 10 04 01 00 55 53
  = Vendor Diagnostic (len 481)                     [hci0] 11.334015
          dc 2e dd 01 d9 01 04 00 0a ff 10 04 01 00 51 d3

On a OnePlus 6T (SoC version 0x40010214, ROM version 0x0201) that is a
packet of about 490 bytes every seven to ten seconds, for as long as the
controller is up.

The driver already turns this logging off after the firmware download
for WCN3950 and WCN3991. Do the same for WCN3990.

Tested on a OnePlus 6T with two builds of crbtfw21.tlv. With the one
from the OnePlus firmware, BTFM.CHE.2.1.4.c2-00002-QCACHROMZ-2.184841.1,
no diagnostic packets arrive any more. The one from linux-firmware,
BTFM.CHE.2.1.3.c7-00024-QCACHROM-1, also accepts the command.

An AI assistant helped find and test this change and drafted this
message.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Hex Lindqvist <hex@freenixos.com>
---
Changes in v2:
- Say that nothing is logged, add a btmon excerpt and name the two
  crbtfw21.tlv builds (Paul)
- Add Reviewed-by tags; no code change

v1: https://lore.kernel.org/r/20261105201952.1556185-1-hex@freenixos.com

 drivers/bluetooth/btqca.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 60735b70d89a..1db2cc626def 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -944,6 +944,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	case QCA_QCA2066:
 	case QCA_QCA6390:
 	case QCA_WCN3950:
+	case QCA_WCN3990:
 	case QCA_WCN3991:
 	case QCA_WCN6750:
 	case QCA_WCN6855:

base-commit: ebdfe8561b5496b7eafedccd13a000a7261bc52b
-- 
2.56.0

