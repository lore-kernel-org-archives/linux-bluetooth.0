Received: from mailout06.t-online.de (mailout06.t-online.de [194.25.134.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B942D3732
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Dec 2025 09:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.25.134.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766483177; cv=none; b=HOKSh2g+eV6XJ39rt6WapYwLsxtUmbIM+FYhRBCRzrnDUigAJs6snhj6CanNLJft1MuhB3flad+CYZSbhJhPc/Zi7cBf0GuJnIfrKkmEGQbitrH/A4w8BnBxEV8E4wgjMV2STxvvBwElt05FaODtfUWQu9yLO4PjhTLoSWqDJaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766483177; c=relaxed/simple;
	bh=+OJYbTp6+buGXE1OBOn6XlAtb2b1+otvsgPbI9ylpBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hy8H2Jra7tfbSdnP6ReB35KL3UlUQ82SVcyQgGNSWEuCZucbur5NOm9C11PqT0c+PgipJ/1mmjv9YGti+bpvNgfpAEMecOYZVdWzZSIeTM4E5b8xTLAWuToBhj8LDrP4+G543OE5DPevCRa82v+TIiU6O4ckomojdC83IEPeDGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=t-online.de; spf=pass smtp.mailfrom=t-online.de; arc=none smtp.client-ip=194.25.134.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=t-online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-online.de
Received: from fwd88.aul.t-online.de (fwd88.aul.t-online.de [10.223.144.114])
	by mailout06.t-online.de (Postfix) with SMTP id CC076ED0
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Dec 2025 10:45:57 +0100 (CET)
Received: from laptopzilla ([220.97.177.23]) by fwd88.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1vXyxk-26wItM0; Tue, 23 Dec 2025 10:45:53 +0100
From: Frank Tornack <f-tornack@t-online.de>
To: linux-bluetooth@vger.kernel.org
Cc: Frank Tornack <f-tornack@t-online.de>
Subject: [PATCH v2] Bluetooth: btusb: Add support for Quectel NCM865
Date: Tue, 23 Dec 2025 10:45:35 +0100
Message-ID: <20251223094535.91725-1-f-tornack@t-online.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <694a366a.e90a0220.1a6835.f67f@mx.google.com>
References: <694a366a.e90a0220.1a6835.f67f@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1766483153-2B7D6FBE-E6169C26/0/0 CLEAN NORMAL
X-TOI-MSGID: 7d0274c8-23f8-4d61-8b34-fa10863b4092

Add the USB ID 2c7c:0130 for the Quectel NCM865 module to the btusb_device_table. This device is based on the Qualcomm WCN785x (FastConnect 7800) and requires the BTUSB_QCA_WCN6855 flag.

Signed-off-by: Frank Tornack <f-tornack@t-online.de>

v2: Fixed merge conflict with current bluetooth-next HEAD.
---
 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 646de80c7..70feeb9a9 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -172,6 +172,9 @@ static const struct usb_device_id btusb_table[] = {
 	{ USB_DEVICE(0x8087, 0x0a5a),
 	  .driver_info = BTUSB_INTEL_BOOT | BTUSB_BROKEN_ISOC },
 
+	/* Quectel NCM865 */
+	{ USB_DEVICE(0x2c7c, 0x0130), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ }	/* Terminating entry */
 };
 
-- 
2.52.0

