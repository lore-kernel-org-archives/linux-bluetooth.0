Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ECD15B97E;
	Wed, 15 May 2024 23:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715814941; cv=none; b=aAnGzowI+pmYjcHa8tBLmQDfuRHhYDweh4Aa/zSrAZn0VBFxAH/GpqUKKDkerCisUa5e0JrBJyNECzboBVJGmoNcN13tsuEPgBmw03VY4qkk45wzQ+7C6yfAFnVp1UC1DHl2cD+2uls1BN3TqYnoNfsre/oK9V7tq9qBAwuXs2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715814941; c=relaxed/simple;
	bh=J8svAqNhHH545H/TdjwK4kk3WFNcNp93EwVHK7qP0ko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ezRx2R+bi7rnOWX46DXbTYae/oZQ1Thd5jq236aNOYgOOh/Q/7AvX+29TNTdRkMATN15u7n06C3HKPEONrL6HquRHIB2zB5OhVYFB3jM9V78IssD35t6n0uTp998Mw2cWSxZNzXRcafKouLzbqaeNQIor6tnnFLuQlO/E27vJ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6f0e6a32754so18760a34.0;
        Wed, 15 May 2024 16:15:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715814939; x=1716419739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2gZhkoZh+996W2MlO/z0y0kus/aLno+FBdFhG28ujRw=;
        b=sIAK6EBoPk3H0Tqz9qoQb9F13HX+HHApmwLL5JvMU00+KrbIhlQXKC8RzCVTgLZ8MK
         g93XmmPtaiOORc0MTx1akSTia01fQoV5Y3fplKouzh17+C5XLe3Gp0LmbyQuOQtw/kqZ
         RKejCxTj9i++b8c+x4mzrXMfOnTUswr7bT00rMLV/9kGoE9FVbepgPQAVfPF5wPxOZ0s
         we7TUFlmAfSYtuhtsZdO/IUyCA0YVxMX4A0A0j2veFTipRe6s5OPaRV5n5Rz4FgnFIQ8
         IqmEXDTeZzn307bnTm6zgrMDfMX+tfcVj2/7y7UA9c8BzZwhLCdYcHFaFyg52iTPLORt
         Xu+w==
X-Forwarded-Encrypted: i=1; AJvYcCVMsnNz97/vZ0zA/GcOtnEbD/Sxw1e3il9iJi3vWN3nGTPREqILgeZvlAdtoM1OCLAjsIaEwFtQOFInQGFUqAPkv7/sTi8JeCc2ical
X-Gm-Message-State: AOJu0YyTDmwvsoU9oMJHrtlFUoym4gMq7d97wke0cs1aX4aQOGT/bX1+
	6+OivHui6EzD5TI0oaJxgGGOVSeQfQF5ih/5Wm+cHWH9GJJ37hea
X-Google-Smtp-Source: AGHT+IF0POBtkQziU+q0qOxtQZ52Him+GxehNpFjP35Htw+MWHS2pgEhKry+qlvjd5BNWQnU4udiGA==
X-Received: by 2002:a9d:400c:0:b0:6f0:52fb:c693 with SMTP id 46e09a7af769-6f0e90f24camr18546313a34.1.1715814938820;
        Wed, 15 May 2024 16:15:38 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f0ec2e566dsm2032159a34.15.2024.05.15.16.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 16:15:37 -0700 (PDT)
From: sean.wang@kernel.org
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hao Qin <hao.qin@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v5 4/5] Bluetooth: btusb: mediatek: reset the controller before downloading the fw
Date: Wed, 15 May 2024 16:15:20 -0700
Message-Id: <38805679fd6abf8fec46224fa8edb81152adb6dc.1715813148.git.sean.wang@kernel.org>
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

Reset the controller before downloading the firmware to improve its
reliability. This includes situations like cold or warm reboots, ensuring
the controller is in its initial state before starting the firmware
download.

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Co-developed-by: Chris Lu <chris.lu@mediatek.com>
Signed-off-by: Chris Lu <chris.lu@mediatek.com>
Signed-off-by: Hao Qin <hao.qin@mediatek.com>
---
v3: split from the v2 to make the patch do one thing in a patch and ensure
    the reset the controller only when we actually need it to avoid the
    regression on the time spent in opening the controller.
v4: rebase onto the latest code
v5: no change
---
 drivers/bluetooth/btusb.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 602456e94fdb..ddd5ca7596e5 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3175,6 +3175,13 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
 	case 0x7922:
 	case 0x7961:
 	case 0x7925:
+		/* Reset the device to ensure it's in the initial state before
+		 * downloading the firmware to ensure.
+		 */
+
+		if (!test_bit(BTUSB_FIRMWARE_LOADED, &data->flags))
+			btusb_mtk_subsys_reset(hdev, dev_id);
+
 		btmtk_fw_get_filename(fw_bin_name, sizeof(fw_bin_name), dev_id,
 				      fw_version, fw_flavor);
 
@@ -3182,9 +3189,12 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
 						btusb_mtk_hci_wmt_sync);
 		if (err < 0) {
 			bt_dev_err(hdev, "Failed to set up firmware (%d)", err);
+			clear_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
 			return err;
 		}
 
+		set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
+
 		/* It's Device EndPoint Reset Option Register */
 		btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, MTK_EP_RST_IN_OUT_OPT);
 
-- 
2.25.1

