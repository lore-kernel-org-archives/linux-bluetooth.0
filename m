Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B818815B541;
	Wed, 15 May 2024 23:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715814939; cv=none; b=ZC0aQHr4+wlj/c6XPMR33p463j1VJlGvAXVrCoJ//LXoRqBY0y0WUZUDqgmMSy+c2UlNqYSrQrfI2rF+bE40V9PTJa6/3m2rgrRUEUlbiMPBwCrBol1XO3kFWdkKNCnzK5Upf8Cpa1Ri6SzKNxlZ7OI4NTs5VKX8h5vfs4BYY/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715814939; c=relaxed/simple;
	bh=l7qaEhv18i07jkg7QgeZLvVfGZZI+7PyNiWrqAvRAG8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eso5wLJqYzKaq5HtALesc+WOL83tbu6oBPs1Oe/no8xQH/afRbtrC/3rO7cCwBY7v53FmtZ96/wfNFkt2j/FC5+vD0sVp4V9nMXqtc7G79F53yWl0j3MtOW+jLFfxf/uQptJqByhziiW/e6M6jjHtamJHKyMeuILzmgPYWESnPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c998b36c6bso1208060b6e.3;
        Wed, 15 May 2024 16:15:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715814937; x=1716419737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FFGLv+/W/92QSc/vAIXNlWmURdmlafsCOBe70BkQWmk=;
        b=MMA/FL+uAenozHTrKmLgrwkS5eyzTMkF1yXsGZFSQ09aIaRK2kQA6KTn/FcmVXUjQC
         5LWrO0VvF5YJQdChvRLzam6VBWPivse2YXqz9FLBYanG5dl46nY8zV1/r9H9P9hhg5Gq
         TI5Pw/iZ9hQ73VfTsFdJFtNyUbEHhReigaAoJQ5PmXAa8zs9h1vdSGUB67EXfemnSpgE
         RGHYk9BfA2I1QDzexUm1kgp14YqfLhUQUcW6+i9T9pfu52uwNNSyqWWAbc4t6mGPV+Qt
         TJU73oQmYvuCuSEA5k6iqBu0RXEzShOnuEwAox7bet0KI1dVGAIZ9+RPpd3fGk2X2iFi
         tBOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUU+0eB9WTLv6WR60muFw5RL2CDGC7IpkRUFbMqY+MtVh6R3s2IRGeFmsgeqEArRsWcNcw33vbMyqU+c2gJiGzRNhnmOYSNqoNx8aYj
X-Gm-Message-State: AOJu0YyVXdAZOU/g9bfjePd9NVg3Eo6PI6mSw+BDne1MauU/l19SYOJV
	JFbAWNygHJH6MV7T9TmWfkvBDgHqv7zbDiW7Try5qfHYpl5G1l0U
X-Google-Smtp-Source: AGHT+IGPg0TcyM5FM5P2N8MzncJHqBNaf4XUzVq0k/1hKGGahsM8lm6b1acACn8c1v7G9KBmrprMLQ==
X-Received: by 2002:a05:6830:14cd:b0:6f0:e2aa:ea49 with SMTP id 46e09a7af769-6f0e92ce674mr19960426a34.3.1715814936703;
        Wed, 15 May 2024 16:15:36 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f0ec2e566dsm2032159a34.15.2024.05.15.16.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 16:15:36 -0700 (PDT)
From: sean.wang@kernel.org
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hao Qin <hao.qin@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v5 3/5] Bluetooth: btusb: mediatek: refactor the function btusb_mtk_reset
Date: Wed, 15 May 2024 16:15:19 -0700
Message-Id: <fc7dccf0990d1eda52f7b9ebbe5348e06979107d.1715813148.git.sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ce0337178bf617d52ff320a36837d75bf537df2d.1715813148.git.sean.wang@kernel.org>
References: <ce0337178bf617d52ff320a36837d75bf537df2d.1715813148.git.sean.wang@kernel.org>
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
v5: no change
---
 drivers/bluetooth/btusb.c | 45 +++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 611135d1ce01..602456e94fdb 100644
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

