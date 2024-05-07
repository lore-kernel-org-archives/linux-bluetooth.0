Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5149C16F0DF;
	Tue,  7 May 2024 19:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715109733; cv=none; b=QzvIkiFHiqPJaFRfk7nQG9YCOWdn3AStbNY+o7F9JlA4a89cdImYQK+AeRjzu2shTtaECycpGK6GPvTsPzCR+cJH+s8qB/rWlXGy3Cns8FaEAAFLz7Z8j2dwGiwoUS/2msVuLqnz+cAo4KJNenxYYIEeWM4a1JSK1Ae81kyXUHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715109733; c=relaxed/simple;
	bh=t3anCqoQvYawKfAJbp+mSiJnVoopchGAQ15If8ihT9A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N1YM5XMdSQpXtK412plbt35bYWD8J5FDYYPMAPAD3TbbH+OBsKrHEyoMXSQB4zUXDVoWltKBTtHeNkHKf9SbVNXjACponA3TCJA2pjZPACD6y1ox7LSTgEP1YscDpQvKRsI65S+ZjojE4XeLV0DgOZrDE69o9t7EcBwwgkqiRZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6ea0a6856d7so194684a34.1;
        Tue, 07 May 2024 12:22:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715109731; x=1715714531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ToNbBgB0lLDuXRtTbvd57CqqqGRtlld+OojUmDuwhxc=;
        b=EX1pYKfUgxomkYtL7nu2rsUmJJfEG/z+iR5zfCupC3EIxU8YYkF+4K3mbiC9m0NcVz
         Tvpc2VN+A/lsTTGATKbyS2wyzWeYURVCrLB5FCYKPAoPQPSq+Vh/UqqG/t8786chAoKN
         s3glmEUN4xQ2gmLy/fcY7R25ygC0j+ZPhhiGVpJ09KJU2afO84EqiwbYFVBftOz76EZa
         IRZM1UtUqNt7uOiWvWKhK6OjcmIUfUnEyG71B6k2uQhsyJTulWqfKHzD3bfEDKO78OiD
         R60u4Ji3GFfY33gpax35Z1LQnN7MunJck6zjYwtv1A/0lsI5w9ucUsHvBV/6USDB14yl
         c56w==
X-Forwarded-Encrypted: i=1; AJvYcCWX24lMdz8pJJSAnl4tTZNTMPFHn9ooQdEyhr6/Fw0SXGdnLqqkc0SDn3uZXeiTCj9+kPGl6+zwkTsGW1xyB9KVyjsIxbRs/5aj6CxF
X-Gm-Message-State: AOJu0YxNOu0VyIDIPlKU/Lne5N0Su4E/M3zrLi0Q5nO+jLig63wECN5T
	wB+ojAN8LtYilWC+B44sTZv8kxGZcUal9RfavvAbb14/JBg4gMPj
X-Google-Smtp-Source: AGHT+IF01EcqeEosejqPrZMGtaa/ozo1Yp4hkp6Himg1Sj+DlBjL0oa9WOSi3FgmAGqaf3rlpay/lg==
X-Received: by 2002:a05:6808:1a21:b0:3c8:49d6:2df0 with SMTP id 5614622812f47-3c9851ea375mr670264b6e.0.1715109731470;
        Tue, 07 May 2024 12:22:11 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id ec18-20020a056808639200b003c8643f0e5csm1937839oib.16.2024.05.07.12.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 12:22:10 -0700 (PDT)
From: sean.wang@kernel.org
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hao Qin <hao.qin@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v4 5/5] Bluetooth: btusb: mediatek: add MT7922 subsystem reset
Date: Tue,  7 May 2024 12:22:01 -0700
Message-Id: <346166eebadac93848e733277e164d5ce4c1d8c2.1715109394.git.sean.wang@kernel.org>
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

Add the support of MT7922 bluetooth subsystem reset that was called the
auto revert to self-recover from the fatal error in the controller like
the host encounters HCI cmd timeout or the controller crashes.

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Hao Qin <hao.qin@mediatek.com>
---
v3: split from the v2 to make the patch do one thing in a patch.
v4: rebase onto the latest code
---
 drivers/bluetooth/btusb.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 054e8c06bcf3..a70a5e12912b 100644
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

