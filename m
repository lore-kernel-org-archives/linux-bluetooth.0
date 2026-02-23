Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB990364EAD
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Feb 2026 11:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771847674; cv=none; b=i8cunARmObZtTZ6jMplaP+EucD7UIKjXrhKGgH1R0dRdOT3o8LwW/Yj7DiQYUtjDp5Sl/SYbNE4MEO+RVWJzzmRw4rbnfXbCSDeZQenHreagiVHvs9gD9t7ZlcLJKC34jzQ2RIzt6z8OHoy7n3bmGVUc0/5P3zwTUE8s6M0nTYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771847674; c=relaxed/simple;
	bh=3ADRWXv/1WnNGruw8DIjoU0m1gFOqtMRdvhW58J0+fU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OTHHL6euwaY3ZNker+86611K72FsTQEMW3y6xS1gJyM4tfBs5HghXalQsCiID1kOgjS1MHDm9QaaMtII2NjSLj12Kmq6o/AN9jgyy6eAQIven+xW/ArGrr1fuRpsubq51mPpH7whn9TthjrMPKerucOexLPO34DBvf/5o/E/De4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQS+3k8X; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQS+3k8X"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43945763558so2545420f8f.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Feb 2026 03:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771847671; x=1772452471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2y4/fXSvTacfxYjUuGuM/I9b80VjM1rPJJklCOVNYSg=;
        b=JQS+3k8XBhw541HzFta7b/XMeWbqa53Dj/VykX0uIRO/hQObILETDqUz1DmsbpYB8D
         RqLqY5sGRnotCBKoGn8va5YBGUDREkPRVLKXzPhiSMaBo7Ji/dx7Lkz5WSGJAhfB2JSV
         F4FRAYKj1soclPLbsTEauLda62dKuVcOtaSAiPswnYUmAuYcbdPKkTxl//VTBogZLmJd
         wlrIsz/rx9yGc+yuSIVs2hUOvXdfy6xM+eHMGJd1HcYVZMjmFO/AHiK9bh1spunC1eCu
         Hpl+tVJManDkhbgIQ8AsstBIh8RAek/K4WtKtoCbps2IgizGxIID3V1g1+2zi7+8cw9p
         pvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771847671; x=1772452471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2y4/fXSvTacfxYjUuGuM/I9b80VjM1rPJJklCOVNYSg=;
        b=qkcWEl1YPhXfgS/7mNgPW5C2LeaeSSCaaLgNGfCR+JlQRNI8SQoXm3UCWYyHbk3qaW
         e1FJDYsApRpY1rHvqM52/N571/k01qQC1S++3S8ljoWRHejwfezLRg/go7QdaoBqTBXf
         I3OTgCni8ZfJ8CW4r7h9BpAn4v+2lyrJz0hHydgF8h07ukWHre6eZR5uPAUHbfMeDvUB
         vdSiVz107X3W2ZxKwSwwqBlhBezTMvML34caN3dKrub0sDVa7yatleuG85G917FqO2qX
         jpquKu+87VfGr4Rp/gsHXHX/AXugfq3B/4QDdTr7AAiAy+7fiC9YZaftWrFLVNKyYZli
         EbZg==
X-Forwarded-Encrypted: i=1; AJvYcCUJbg3Xe6kCO327crt84gfKKept3LdE3TGYccw+CfqSEOWL5Y/dwdwWW5XZOk/3D67Kez6cv6W9Zc3sIOLeLUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkhBtZXgxM+FLRWFGT7Xyui/Wf68bpMQqYD/PaDJ9XVcI5F7Kj
	61czc5ovmTtO8Q9H7BgtzmYFsICbQg8r3EaXA68wqjEFM2Va/9TPmwjQ
X-Gm-Gg: ATEYQzyvU+F5P0OB36iGn514rbamsCCbbJVU6XZWq/Z/G/BDuAXWPs+TRamRM6th49z
	AZnWxkd/8HTAUZB2wIbvtSc4zxXk/9mcjGP3qL18EdXUL6QBE5tUFm/CnNMSOJW9qtG54NEBpJA
	pnePVQajuRAC7zuT6sFk7KRGjGU4Isx5R9QpBzcF5cW7ryTfGA2yziFnq7fCm2oWX+hdHCz90ve
	MNl4IG4ljrx96bwCka47Xjpfn4uHe7h0I9bzm82XtTPMAT/QlIQoy+tcovrswsPhnsdB7piqZpS
	1QSi24TCzEmqMDHwuSD9sTi74OuLJ8CcXGGmIlXrB8f5J6Ol3Ua5fDhgg6E2ck9L+vn6IfKhNFT
	v83cgWdklqWYIyd0BeuFz/Lc7LLtKpJskkBWlxYm/CKtTzJklMBRYwG5tIgav4QEkDE9ShwL49c
	wq1GC6tKu0dcnHRgb98XTDgAdJSUlfKEwYjsDNjtf9dN6yP+9P47uTXGJhkwjvsH0l+zFommPio
	6r/ZMj0rwLxHuro73QUB/WHuCkMaFOmBYHEDkTk
X-Received: by 2002:a05:6000:420c:b0:435:9d70:f299 with SMTP id ffacd0b85a97d-4396f174178mr13783963f8f.22.1771847671002;
        Mon, 23 Feb 2026 03:54:31 -0800 (PST)
Received: from Lord-Beerus.station (net-188-152-100-94.cust.vodafonedsl.it. [188.152.100.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970c00e8bsm15675668f8f.15.2026.02.23.03.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 03:54:30 -0800 (PST)
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
X-Google-Original-From: Stefano Radaelli <stefano.r@variscite.com>
To: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Cc: pierluigi.p@variscite.com,
	Stefano Radaelli <stefano.r@variscite.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <david@lechnology.com>
Subject: [PATCH v1 2/2] Bluetooth: hci_ll: Add DT property to disable enhanced SCO setup
Date: Mon, 23 Feb 2026 12:52:56 +0100
Message-ID: <998db3667bb97a6908be01912e165d79ba849925.1771847350.git.stefano.r@variscite.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771847350.git.stefano.r@variscite.com>
References: <cover.1771847350.git.stefano.r@variscite.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN quirk was introduced by
commit 05abad857277 ("Bluetooth: HCI: Add
HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN quirk") to handle controllers
that advertise support for the HCI Enhanced Setup Synchronous Connection
command but fail to use it properly with some SCO configurations (e.g.
BT_VOICE_TRANSPARENT/mSBC).

This behavior has been observed on TI controllers used with the
hci_ll driver, where SCO setup can fail unless the enhanced setup path
is avoided.

Add support for the optional DT property "ti,no-enhanced-setup-sync-conn"
and, when present, set HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN during
controller setup, as intended by the quirk documentation.

Signed-off-by: Stefano Radaelli <stefano.r@variscite.com>
---
 drivers/bluetooth/hci_ll.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index 91acf24f1ef5..5f69f0654c19 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -68,6 +68,7 @@ struct ll_device {
 	struct gpio_desc *enable_gpio;
 	struct clk *ext_clk;
 	bdaddr_t bdaddr;
+	bool broken_enhanced_setup;
 };
 
 struct ll_struct {
@@ -656,6 +657,10 @@ static int ll_setup(struct hci_uart *hu)
 			hci_set_quirk(hu->hdev, HCI_QUIRK_INVALID_BDADDR);
 	}
 
+	if (lldev->broken_enhanced_setup)
+		hci_set_quirk(hu->hdev,
+			      HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN);
+
 	/* Operational speed if any */
 	if (hu->oper_speed)
 		speed = hu->oper_speed;
@@ -710,6 +715,10 @@ static int hci_ti_probe(struct serdev_device *serdev)
 	of_property_read_u32(serdev->dev.of_node, "max-speed", &max_speed);
 	hci_uart_set_speeds(hu, 115200, max_speed);
 
+	lldev->broken_enhanced_setup =
+	       of_property_read_bool(serdev->dev.of_node,
+				     "ti,no-enhanced-setup-sync-conn");
+
 	/* optional BD address from nvram */
 	bdaddr_cell = nvmem_cell_get(&serdev->dev, "bd-address");
 	if (IS_ERR(bdaddr_cell)) {
-- 
2.47.3

