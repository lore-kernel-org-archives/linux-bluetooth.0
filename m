Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF9B15CD46;
	Wed, 15 May 2024 23:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715814943; cv=none; b=F6RAzSkOlXxfx0jGxBmKmZBYNSq86kg9pKqoU2uwdXiPzDmAhyzOAW5irVuGB/BdqWRVC1u5cbjalvw+b0A2TFCpQZ14Gf1KJhYf7uhwloAdvc3xDLao3G0e/P3kH8e4sdrQgOkGOIvKMChfF5FbRS95Qq0o39152dwW3UU435M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715814943; c=relaxed/simple;
	bh=Jp3BgbsRv61fdluoqzPcfIEveCnVhqg8xF3iPZw2188=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iG0aKf3dT4HNVIhMuwyR6KWMOP+7Le0BsF/gXWsDDWaBGcvv5xNEELH9suM5n9Pqy4aR3IsnrB5iyNZVwh1dNswTs6y2dGRQ4RZedICgAHE821T8zx+0USoxA94zCjv02lNOUVVMUQI3phcPE5fjzRdwfoVPUcJLmqBli14x0fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c998b36c6bso1208073b6e.3;
        Wed, 15 May 2024 16:15:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715814941; x=1716419741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ze1QygMwN68meqo9PDmwz469IrrkJxaffJS5Hm7aDfQ=;
        b=p/1DFGmnDUJn2dxuWA/VA4gbpJX0Q3UajADBE2wcWF/CGcB33g6FcgJQSkpjYI8bOl
         vgC9tcKQ3LT+ZclLD2LV40KiVBCjk5vo1Kq0QGysfLSQVBLprKrkOafmCYR43gmViQlE
         12miX+dJMqZoLGg8XCYxIMiC16QsKCwd7GhJhdZD20FmZfBXAD64c1/x93N4aTevjxaO
         7dXvoI00kKBgAQrl6jbf06ijwQ/hHqnq9hctXXjEjyZRTgLTMABfCF2/X4XNf8d/KfL/
         TVHRj6E/kw8BhQIhyPhv1DWu9/jG8Tl+mBC7xwba6CyVaRBmSmk/o6cmqKRsuxAs5WtD
         T4sA==
X-Forwarded-Encrypted: i=1; AJvYcCVchA+hcKpXZmISWS5ht3g2t5Tsaqzz9zHSnshF2YvjwI9M2PEABlKtW5tZOjgntlZpQiapAWdHKTYs77IUZQaGT626npPIYMkthRU6
X-Gm-Message-State: AOJu0YwF6F24yrdG/WyJuo0xz4J5pZ+FwTcqplJ5ADoADrKXmw9thB+d
	fPV+yMg1sXvV/v0WtMzz37Cvdm0iQrYMT+ES6t3JLvv/RTKGU+T2
X-Google-Smtp-Source: AGHT+IFeY6IBOmS16l1KarBie8GoRXUZtYtFiMESabNjNgeh9/aF2ykz5OpkEZWWolf+VV2rf5fl6g==
X-Received: by 2002:a4a:de14:0:b0:5b2:7aa7:7b29 with SMTP id 006d021491bc7-5b28193d5e7mr17763186eaf.1.1715814940930;
        Wed, 15 May 2024 16:15:40 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f0ec2e566dsm2032159a34.15.2024.05.15.16.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 16:15:40 -0700 (PDT)
From: sean.wang@kernel.org
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hao Qin <hao.qin@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v5 5/5] Bluetooth: btusb: mediatek: add MT7922 subsystem reset
Date: Wed, 15 May 2024 16:15:21 -0700
Message-Id: <90f8b0663933990ed1bf47dd6698d8ff69f1a948.1715813148.git.sean.wang@kernel.org>
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

Add the support of MT7922 bluetooth subsystem reset that was called the
auto revert to self-recover from the fatal error in the controller like
the host encounters HCI cmd timeout or the controller crashes.

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Hao Qin <hao.qin@mediatek.com>
---
v3: split from the v2 to make the patch do one thing in a patch.
v4: rebase onto the latest code
v5: no change
---
 drivers/bluetooth/btusb.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index ddd5ca7596e5..79aefdb3324d 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3039,7 +3039,16 @@ static int btusb_mtk_subsys_reset(struct hci_dev *hdev, u32 dev_id)
 	u32 val;
 	int err;
 
-	if (dev_id == 0x7925) {
+	if (dev_id == 0x7922) {
+		btusb_mtk_uhw_reg_read(data, MTK_BT_SUBSYS_RST, &val);
+		val |= 0x00002020;
+		btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, val);
+		btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, 0x00010001);
+		btusb_mtk_uhw_reg_read(data, MTK_BT_SUBSYS_RST, &val);
+		val |= BIT(0);
+		btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, val);
+		msleep(100);
+	} else if (dev_id == 0x7925) {
 		btusb_mtk_uhw_reg_read(data, MTK_BT_RESET_REG_CONNV3, &val);
 		val |= (1 << 5);
 		btusb_mtk_uhw_reg_write(data, MTK_BT_RESET_REG_CONNV3, val);
@@ -3079,6 +3088,9 @@ static int btusb_mtk_subsys_reset(struct hci_dev *hdev, u32 dev_id)
 	if (err < 0)
 		bt_dev_err(hdev, "Reset timeout");
 
+	if (dev_id == 0x7922)
+		btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT, 0x000000FF);
+
 	btusb_mtk_id_get(data, 0x70010200, &val);
 	if (!val)
 		bt_dev_err(hdev, "Can't get device id, subsys reset fail.");
-- 
2.25.1

