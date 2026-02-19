Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954782E92BC
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 23:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771542996; cv=none; b=atQRJGiKkjhLV5swNXz8+zZz1oJCHYRhZ8dC6JFVDbNz8iqVGwpwkr6TJxz0R2hMDTnZq2k4bfx/aKci8z/sNIZ9zSQbcsZ0G61A9dOMvzELQo3di9dm3og6pkgicGYUHexhgvQ43Jw4Enyjg4nDiY2h/pndHugNHvF6Wc9USqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771542996; c=relaxed/simple;
	bh=TT2KfFnQtzKOEbg8zbkMHf8b13f8CSixpl51XFpRQhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qa1Y/+o/+lqggpGOhmKAuCPb8ILoLRFsv87tDQBrvfAxpcwJ5ClI0lvdZT/K4+cqgJ5/S2J+lk3vylChirdIfLtnroOCH95C4Vkb2i9z1iYuMkv1QlD/Iin6NB7yWi3b+FibeT7hU/u995Gq69MKsbsJoniveELf3j6OstGGDEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d4be94eeacso1319607a34.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 15:16:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771542994; x=1772147794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZV3jSXI5ldR4jveK2PsLzkMeIX1O0Q5JVn7RfzOo4go=;
        b=Q6iZiPtMSyr1Pu0rVOje0FJ9mawMFv6wFx34KGDNWoxSuuMTSZ0RkGIZu+h6vFOwSG
         oQ41a0ze7N45NAIHrjNTXyvlfOJV+f0W5zG56gNAmy8AuZ/2XXf97Uze1TiniHUovGTK
         jJNc7gx/ZHx0JzMvvN1Z3IxBVZRm6wkotkauWQIMgMDPAxZSBaeUbH2wVZKAxpPHhuwq
         sJzTHqJWAyMnDtHu6uKYS3x9YVCaqg9/7hqTFqvXad51jINfvfQtkoL9hR0Mx9Rp4F9s
         ay9YPyH81/0Ku6wsJ9gWo1r1skZ5IYsHXmEkiSXhF0scGYQPRJ+QbY8MG6vQ7OZdTn4d
         U+tg==
X-Gm-Message-State: AOJu0Yxea+a4eF5erfQGKdkBkK0+ULsm5mnYSAvtEvT1R5/6brBroz+U
	jJd4xg9QmlTMrVgt8OcbFXGDXbjYhJ3cyl61gWVQj2+k3GmIep48/7WS
X-Gm-Gg: AZuq6aJZ2AOtQn1Nb73nW3w5e+axFPFL25UqT8LWarQklSKauiUoRMQY+lsyWhZzi33
	4qlztI/mcrcFXY2tZoNM+5IYoX9Jfq23nfoQNKoCePdQlScwudFbY9EeAH5zgM3WXci3Yt5JoGL
	iqmMtAce0Ch5dJ+apQqUvtDq0oeY0xK6d0Nw3j0kFP19amJ/vXxg1Wqir4venVlDu8pQI25Joxk
	vXAKjcazX7KhkDGJbDWPZW+zzZksU8eKicgESQ1hlgxmv5uhfhWvdnw0z/RMqeAu9wp/58mk6Rr
	Jl053RXjeWcudoPQnFG3hxrAuAgQo2qm6FSAKa2q/UK4u+25qSqyX9JpJtJnvrIViBlJKxxMrrV
	A0WCUBBE2+qIHjujRMQ11XfuUmCWUu2qzy7ZF7dOZyeQo8ffQcs//OQtVgDeeEq/sNEpcBZyb4/
	qE2spq69gKmEtcftQ+ANcHHafhwu51mnJf/IPttEATrLAcqmY=
X-Received: by 2002:a05:6820:a07:b0:674:5dbd:7859 with SMTP id 006d021491bc7-679a74430b4mr3886891eaf.55.1771542994551;
        Thu, 19 Feb 2026 15:16:34 -0800 (PST)
Received: from sean-HP-EliteBook-830-G6.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40eaee45d12sm26719644fac.1.2026.02.19.15.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 15:16:34 -0800 (PST)
From: Sean Wang <sean.wang@kernel.org>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	ulf.hansson@linaro.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 2/4] Bluetooth: btmtk: add MT7902 MCU support
Date: Thu, 19 Feb 2026 17:16:22 -0600
Message-ID: <20260219231624.8226-2-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219231624.8226-1-sean.wang@kernel.org>
References: <20260219231624.8226-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

Add MT7902 device ID and firmware filename to enable MCU firmware
loading.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/btmtk.c | 1 +
 drivers/bluetooth/btmtk.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 14e2f4100806..2507d587f28a 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -1338,6 +1338,7 @@ int btmtk_usb_setup(struct hci_dev *hdev)
 	case 0x7922:
 	case 0x7925:
 	case 0x7961:
+	case 0x7902:
 		btmtk_fw_get_filename(fw_bin_name, sizeof(fw_bin_name), dev_id,
 				      fw_version, fw_flavor);
 
diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
index b9df2b8f0627..adaf385626ee 100644
--- a/drivers/bluetooth/btmtk.h
+++ b/drivers/bluetooth/btmtk.h
@@ -5,6 +5,7 @@
 #define FIRMWARE_MT7663		"mediatek/mt7663pr2h.bin"
 #define FIRMWARE_MT7668		"mediatek/mt7668pr2h.bin"
 #define FIRMWARE_MT7922		"mediatek/BT_RAM_CODE_MT7922_1_1_hdr.bin"
+#define FIRMWARE_MT7902		"mediatek/BT_RAM_CODE_MT7902_1_1_hdr.bin"
 #define FIRMWARE_MT7961		"mediatek/BT_RAM_CODE_MT7961_1_2_hdr.bin"
 #define FIRMWARE_MT7925		"mediatek/mt7925/BT_RAM_CODE_MT7925_1_1_hdr.bin"
 
-- 
2.43.0

