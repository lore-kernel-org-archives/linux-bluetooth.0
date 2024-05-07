Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC7516E89B;
	Tue,  7 May 2024 19:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715109730; cv=none; b=aBUprHEDHq0Ql0D7uXgEd/I9tgzymhrSo6t1+u3+mFafnh6sD56dho7DtCfmPXXbZlDC3rcbuFmhjN4/m1Yj/FfMGXBoZysCykOza1h3Y3mHiVFosxAt5NgM/5EUbPvA/FWhp+8Ix/1m4mc4FvC+3uSM/l902Pyrkj1WTB76IXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715109730; c=relaxed/simple;
	bh=aQ9zB0CP0QI6bN2ZiPhiwNsW9sXlvmMqsyyaMqc13nY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uHe04fzF1DTLY/1SvvHvRY9CtONa/7qaT4BxXXUxs1RNkzb+cW3+W5gEUgSs9ndOVX01DzNGq3o7yjpxRCAxN79J37kyRErbhe8qUqAKZjGuocJR5AnLhgRw+i8QcDorGJf+KdANbjH+FCt/CyasAkcq3Bj7m+bFf+ShkGp4bRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6f0471efe4cso66795a34.1;
        Tue, 07 May 2024 12:22:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715109728; x=1715714528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eyGlXVbcuOBmT6INVyvYbqSZy7NpTaBdxh15HEARP+o=;
        b=EBx62FHebC781rgLp/m27RZ1jC5UYzYCoVXt5TGdYr2du93DR6euCH9Biyd4LAvT4r
         LyRyU+gr8wX15jQ8yAwn0s6dkwkY3hpGUPCbgQLrdWy6GnAeT9OlA2orvtoDJPGtM+pm
         maT92GEPX5Yaju5dI/cUitydG+90MhIJd5cmN3titQXqGpuZOUTxArIuDncrscgt95oc
         FTFIf7QMY/2H801d3202X2qgfqg0yO79NfP3AC6rxBNYuYufWlKXc+FeXulr4x2ky4C3
         g7RjH9KhELdNSD1V1CtDuVJ16ShgPsgRuPLrCpMvGgTW4FezxCsjMGp5r7ppDblgUwsq
         VO5w==
X-Forwarded-Encrypted: i=1; AJvYcCXICL9MIEIEg1dQHk7Scb1EayfA9vvDB/6Q0GhF97ZCfjHMOrzFWyq0z6xbvd4bU3I1jBsRPqXvBddLy7iLNwcpjyst0nfUBah/qcyW
X-Gm-Message-State: AOJu0YxH2Qp/YqZYMeSKNeMvuh3YRXfJ1rWlwP+7u5dlRUO7rtd18aOX
	8hxOPzjay1H+8YGnUnuZwHci9N7LydIkbOTm887Oxoch1R63fbxw
X-Google-Smtp-Source: AGHT+IEpqc15K+aZH7Df8bQldnVSTf8pYsmcQxJbCA3BrQZr5kPInLxof+4kwH5BEOk7Gu+fJGF55A==
X-Received: by 2002:a05:6808:2008:b0:3c8:4964:cc9d with SMTP id 5614622812f47-3c9851ea36amr575921b6e.0.1715109728245;
        Tue, 07 May 2024 12:22:08 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id ec18-20020a056808639200b003c8643f0e5csm1937839oib.16.2024.05.07.12.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 12:22:07 -0700 (PDT)
From: sean.wang@kernel.org
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hao Qin <hao.qin@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v4 3/5] Bluetooth: btusb: mediatek: refactor the function btusb_mtk_reset
Date: Tue,  7 May 2024 12:21:59 -0700
Message-Id: <457c7be3bbbeda1241e097e99056d9c5e2a734bb.1715109394.git.sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <965cd14922aea67e2750ff2c2ecad773f8ba485a.1715109394.git.sean.wang@kernel.org>
References: <965cd14922aea67e2750ff2c2ecad773f8ba485a.1715109394.git.sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hao Qin <hao.qin@mediatek.com>

Extract the function btusb_mtk_subsys_reset from the btusb_mtk_reset
for the future handling of resetting bluetooth controller without
the USB reset.

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Hao Qin <hao.qin@mediatek.com>
---
v3: refine the git message
v4: rebase onto the latest code
---
 drivers/bluetooth/btusb.c | 45 +++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 1603e97f0d7c..76c52f2fe917 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3033,28 +3033,13 @@ static u32 btusb_mtk_reset_done(struct hci_dev *hdev)
 	return val & MTK_BT_RST_DONE;
 }
 
-static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
+static int btusb_mtk_subsys_reset(struct hci_dev *hdev, u32 dev_id)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
-	struct btmediatek_data *mediatek;
 	u32 val;
 	int err;
 
-	/* It's MediaTek specific bluetooth reset mechanism via USB */
-	if (test_and_set_bit(BTUSB_HW_RESET_ACTIVE, &data->flags)) {
-		bt_dev_err(hdev, "last reset failed? Not resetting again");
-		return -EBUSY;
-	}
-
-	err = usb_autopm_get_interface(data->intf);
-	if (err < 0)
-		return err;
-
-	btusb_stop_traffic(data);
-	usb_kill_anchored_urbs(&data->tx_anchor);
-	mediatek = hci_get_priv(hdev);
-
-	if (mediatek->dev_id == 0x7925) {
+	if (dev_id == 0x7925) {
 		btusb_mtk_uhw_reg_read(data, MTK_BT_RESET_REG_CONNV3, &val);
 		val |= (1 << 5);
 		btusb_mtk_uhw_reg_write(data, MTK_BT_RESET_REG_CONNV3, val);
@@ -3098,8 +3083,32 @@ static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
 	if (!val)
 		bt_dev_err(hdev, "Can't get device id, subsys reset fail.");
 
-	usb_queue_reset_device(data->intf);
+	return err;
+}
 
+static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	struct btmediatek_data *mtk_data;
+	int err;
+
+	/* It's MediaTek specific bluetooth reset mechanism via USB */
+	if (test_and_set_bit(BTUSB_HW_RESET_ACTIVE, &data->flags)) {
+		bt_dev_err(hdev, "last reset failed? Not resetting again");
+		return -EBUSY;
+	}
+
+	err = usb_autopm_get_interface(data->intf);
+	if (err < 0)
+		return err;
+
+	btusb_stop_traffic(data);
+	usb_kill_anchored_urbs(&data->tx_anchor);
+	mtk_data = hci_get_priv(hdev);
+
+	err = btusb_mtk_subsys_reset(hdev, mtk_data->dev_id);
+
+	usb_queue_reset_device(data->intf);
 	clear_bit(BTUSB_HW_RESET_ACTIVE, &data->flags);
 
 	return err;
-- 
2.25.1

