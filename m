Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3F3199A2;
	Tue,  4 Jun 2024 22:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717541232; cv=none; b=FdTQyDT5R4qV7tPq0/aIrsq6Cuno20LLkk0dTLusHSxpOKpLBGygZ1Cv+hJNU15oMFKTTXecLZyBPBq5fjaYTNT0d/c7BL8KFXnAXaz8Hyoo5abHZ/PI5M4vTqJOHEu1NXvmoVortNCLx1y8T3Dme97C4Z8XyA35zPvpPlInOsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717541232; c=relaxed/simple;
	bh=METrmPAcmPUSVMdkuOu50QlHO7y+R7/Qwombe0cCN/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hBfnByFfYYbhyd9lziO0SFIcCE43jc2BqbRzxnszLYzpP6sp4hh0wthpc1tNNXB97W4hPFp3wGU2K7/SlW5pU6LTjFWl44XHqD2+ivyNgUuHfJdZ0V/U86NOnOVTssVvsMDIvmavKNcdx5mNNi4zF/0a8bF0t4peKxWrA3IE+M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3d1fd5fd4e9so184671b6e.1;
        Tue, 04 Jun 2024 15:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717541229; x=1718146029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3D09rwq099rXAFTrCTUTJ+my0BjE9qWUOio5w9f6c2g=;
        b=DJNIUA2IjEFokZX2qRjZGfI3pWAOZGc13VLjftBebXhz4R4K3+L2Npzo9xvMfN3wnP
         QExy9F7wuYeAGkvFG86Snz05l1RXEM8BjzPdjGsFc4mRk4JBkb9Wuzlx+QG1PclKiYMx
         qH18l0QlKwrKYzcrCJUGf2fpobQosAMKnR0icSpofhAUjxRYgBU5MuFpFYomK9tSqueF
         vVXHPVuRyTdH7T0CgHIaxCrp0fpSVREodI8vWSQqcePTsXvhpqPsvRf5KUQRs7Txzvny
         hmWP24Sd7tkwbJ8oQGfVcnzzIZjTePggepy4L1ZTfv90lR0ZK4WIByWi1xQrEZAOnTwL
         SJiw==
X-Forwarded-Encrypted: i=1; AJvYcCX3SgW9upQ4IARvuJ79+l5aQueIC/BQQy5Khg5z7j8QhY0XjaCIFpt3yYU3Szvk9DS0D7PO6//v1fN2dkcBWKqQSYKA+BVZdC7u5V12
X-Gm-Message-State: AOJu0YxJIGWi8D7tsH5qX0IkcRiHLXYV2JDPen+u/pNmwTwqv6d3LYv7
	1deyeCQ1q5tS//bpv/8oMGIiXtGpW3ybPws0zrOj3rnK/1ssv8Sv
X-Google-Smtp-Source: AGHT+IFFjZn5VUCIfKrOqhS1vAjSWJAr8KWnPs723c+O2GD3GNi8hUtWTao+vLFexfJb+mZ73Cbm4w==
X-Received: by 2002:a05:6830:4520:b0:6f9:37d8:c057 with SMTP id 46e09a7af769-6f94384edcamr706008a34.3.1717541228779;
        Tue, 04 Jun 2024 15:47:08 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f93b4a3e00sm478529a34.50.2024.06.04.15.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 15:47:08 -0700 (PDT)
From: sean.wang@kernel.org
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 2/2] Bluetooth: btusb: mediatek: return error code for failed register access
Date: Tue,  4 Jun 2024 15:47:00 -0700
Message-Id: <7673d4432c2ba07ad3d38f9c483862b77b1db211.1717540338.git.sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <8f809ae0094c89ed99efb4074472edd119db8ec1.1717540338.git.sean.wang@kernel.org>
References: <8f809ae0094c89ed99efb4074472edd119db8ec1.1717540338.git.sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

Update the code to immediately return an error code if accessing a
related register fails. This ensures that our desired logic for
subsequent register operations is maintained and allows us to promptly
catch any unexpected errors.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/btusb.c | 116 ++++++++++++++++++++++++++++----------
 1 file changed, 85 insertions(+), 31 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index fcdd660add19..e862e4648082 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3037,47 +3037,96 @@ static int btusb_mtk_subsys_reset(struct hci_dev *hdev, u32 dev_id)
 	int err;
 
 	if (dev_id == 0x7922) {
-		btusb_mtk_uhw_reg_read(data, MTK_BT_SUBSYS_RST, &val);
+		err = btusb_mtk_uhw_reg_read(data, MTK_BT_SUBSYS_RST, &val);
+		if (err < 0)
+			return err;
 		val |= 0x00002020;
-		btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, val);
-		btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, 0x00010001);
-		btusb_mtk_uhw_reg_read(data, MTK_BT_SUBSYS_RST, &val);
+		err = btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, val);
+		if (err < 0)
+			return err;
+		err = btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, 0x00010001);
+		if (err < 0)
+			return err;
+		err = btusb_mtk_uhw_reg_read(data, MTK_BT_SUBSYS_RST, &val);
+		if (err < 0)
+			return err;
 		val |= BIT(0);
-		btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, val);
+		err = btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, val);
+		if (err < 0)
+			return err;
 		msleep(100);
 	} else if (dev_id == 0x7925) {
-		btusb_mtk_uhw_reg_read(data, MTK_BT_RESET_REG_CONNV3, &val);
+		err = btusb_mtk_uhw_reg_read(data, MTK_BT_RESET_REG_CONNV3, &val);
+		if (err < 0)
+			return err;
 		val |= (1 << 5);
-		btusb_mtk_uhw_reg_write(data, MTK_BT_RESET_REG_CONNV3, val);
-		btusb_mtk_uhw_reg_read(data, MTK_BT_RESET_REG_CONNV3, &val);
+		err = btusb_mtk_uhw_reg_write(data, MTK_BT_RESET_REG_CONNV3, val);
+		if (err < 0)
+			return err;
+		err = btusb_mtk_uhw_reg_read(data, MTK_BT_RESET_REG_CONNV3, &val);
+		if (err < 0)
+			return err;
 		val &= 0xFFFF00FF;
 		val |= (1 << 13);
-		btusb_mtk_uhw_reg_write(data, MTK_BT_RESET_REG_CONNV3, val);
-		btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, 0x00010001);
-		btusb_mtk_uhw_reg_read(data, MTK_BT_RESET_REG_CONNV3, &val);
+		err = btusb_mtk_uhw_reg_write(data, MTK_BT_RESET_REG_CONNV3, val);
+		if (err < 0)
+			return err;
+		err = btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, 0x00010001);
+		if (err < 0)
+			return err;
+		err = btusb_mtk_uhw_reg_read(data, MTK_BT_RESET_REG_CONNV3, &val);
+		if (err < 0)
+			return err;
 		val |= (1 << 0);
-		btusb_mtk_uhw_reg_write(data, MTK_BT_RESET_REG_CONNV3, val);
-		btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT, 0x000000FF);
-		btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT, &val);
-		btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT1, 0x000000FF);
-		btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT1, &val);
+		err = btusb_mtk_uhw_reg_write(data, MTK_BT_RESET_REG_CONNV3, val);
+		if (err < 0)
+			return err;
+		err = btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT, 0x000000FF);
+		if (err < 0)
+			return err;
+		err = btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT, &val);
+		if (err < 0)
+			return err;
+		err = btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT1, 0x000000FF);
+		if (err < 0)
+			return err;
+		err = btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT1, &val);
+		if (err < 0)
+			return err;
 		msleep(100);
 	} else {
 		/* It's Device EndPoint Reset Option Register */
 		bt_dev_dbg(hdev, "Initiating reset mechanism via uhw");
-		btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, MTK_EP_RST_IN_OUT_OPT);
-		btusb_mtk_uhw_reg_read(data, MTK_BT_WDT_STATUS, &val);
-
+		err = btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, MTK_EP_RST_IN_OUT_OPT);
+		if (err < 0)
+			return err;
+		err = btusb_mtk_uhw_reg_read(data, MTK_BT_WDT_STATUS, &val);
+		if (err < 0)
+			return err;
 		/* Reset the bluetooth chip via USB interface. */
-		btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, 1);
-		btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT, 0x000000FF);
-		btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT, &val);
-		btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT1, 0x000000FF);
-		btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT1, &val);
+		err = btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, 1);
+		if (err < 0)
+			return err;
+		err = btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT, 0x000000FF);
+		if (err < 0)
+			return err;
+		err = btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT, &val);
+		if (err < 0)
+			return err;
+		err = btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT1, 0x000000FF);
+		if (err < 0)
+			return err;
+		err = btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT1, &val);
+		if (err < 0)
+			return err;
 		/* MT7921 need to delay 20ms between toggle reset bit */
 		msleep(20);
-		btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, 0);
-		btusb_mtk_uhw_reg_read(data, MTK_BT_SUBSYS_RST, &val);
+		err = btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, 0);
+		if (err < 0)
+			return err;
+		err = btusb_mtk_uhw_reg_read(data, MTK_BT_SUBSYS_RST, &val);
+		if (err < 0)
+			return err;
 	}
 
 	err = readx_poll_timeout(btusb_mtk_reset_done, hdev, val,
@@ -3085,11 +3134,14 @@ static int btusb_mtk_subsys_reset(struct hci_dev *hdev, u32 dev_id)
 	if (err < 0)
 		bt_dev_err(hdev, "Reset timeout");
 
-	if (dev_id == 0x7922)
-		btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT, 0x000000FF);
+	if (dev_id == 0x7922) {
+		err = btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT, 0x000000FF);
+		if (err < 0)
+			return err;
+	}
 
-	btusb_mtk_id_get(data, 0x70010200, &val);
-	if (!val)
+	err = btusb_mtk_id_get(data, 0x70010200, &val);
+	if (err < 0 || !val)
 		bt_dev_err(hdev, "Can't get device id, subsys reset fail.");
 
 	return err;
@@ -3205,7 +3257,9 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
 		set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
 
 		/* It's Device EndPoint Reset Option Register */
-		btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, MTK_EP_RST_IN_OUT_OPT);
+		err = btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, MTK_EP_RST_IN_OUT_OPT);
+		if (err < 0)
+			return err;
 
 		/* Enable Bluetooth protocol */
 		param = 1;
-- 
2.25.1

