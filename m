Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBD016EC11;
	Tue,  7 May 2024 19:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715109732; cv=none; b=hE89LkTM5VR7VeP8hwdER5iYiw1Ows+iCBAaV/pvFNiiRdAU0580BlSK0DUzUMtTSDg75iUHr39R9+7mKWtoWtrs2ens+aeHp95pWvVR1quiykU/E6pvcG4YlGcV64DplGag0I/vldXMixb+RjGzqw2I132gbxnrYMruC25D66E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715109732; c=relaxed/simple;
	bh=zeX93PqWQJOMUqO7tMUXpYKyT0p2tqeT0oe7g6GyVJY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=udnTPGixs82Y2o4P7RwSdeKVj/zuUCqNIJO/7qvyBPV63KWDcFasBVqTZDWC4hr7Ty0vbjvP00lF+bREb7numyIJJyRvyhGcUvQxMQG63QuCOUIsDS4nDOgzwFY3tl0XR47akAmv2ZV5V1MHlSJUNJoMzfD4P/4/aVBRfPueDmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5af12f48b72so734988eaf.3;
        Tue, 07 May 2024 12:22:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715109730; x=1715714530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SlonihVk5HXWq/ZpBp4yUpJHwD260ZA8CaexGXiG9rQ=;
        b=let7ueCbXut993voTs7aTJyQF0BFhsIXTmP6vKK1z1iXnavXh2Zfr1rT4/0rD7uFA1
         nY+exWTgzhC5RXa9J9L4sYc+mo2vKiG6+zj4FGylYHzG2mTCUMzaN22yfKnvoqhunRD4
         /VK26KHrn4qplKLusZDymLDzax+o4ShjsXo3XBq3xRE3Juu9WPj4OND5hI6BYggzoKpu
         ljYCFw4k6BpOLAlQJZELGpjKO3D0XIFrBRCjXTd+uLsrA5YQ5U7eWcanHytUpoivKHU9
         pD1OerGFPWwaL3dTwZdQS+JrmVL6WesYMNJAPfefDtyRrm2OyVU8NT0+cVGXYlAUrTxP
         Lepw==
X-Forwarded-Encrypted: i=1; AJvYcCUxdz/IBSZU6Z82NJxb5M6DbHlzolR8w63WP8qwyIcULyc/cbGzDCUvdH9UeSqWxG8HyD5S4833UX/dtrOUiZVXBtb1s+i/2QywywmY
X-Gm-Message-State: AOJu0YyOr8/23rBQR0Zq1phG7w/HZhNqPiRj3W508B8eh9S9UNCtz2Hd
	uiQDm3YKopGaaxHXRc3K41lQXnVyoTNKabEvIoT63NPauODJSCPU
X-Google-Smtp-Source: AGHT+IF9UmOg15I3ALrBE4OUAVGBFCQP5hgkpg6/WXPLKaGBvsjk9953JlxPcrsBGu/BmVmoH76jVw==
X-Received: by 2002:a05:6808:181a:b0:3c8:4de7:6736 with SMTP id 5614622812f47-3c98543850bmr542210b6e.4.1715109729785;
        Tue, 07 May 2024 12:22:09 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id ec18-20020a056808639200b003c8643f0e5csm1937839oib.16.2024.05.07.12.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 12:22:08 -0700 (PDT)
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
Subject: [PATCH v4 4/5] Bluetooth: btusb: mediatek: reset the controller before downloading the fw
Date: Tue,  7 May 2024 12:22:00 -0700
Message-Id: <3c3dfe8efc70af04794035537c7c40a52f2266d5.1715109394.git.sean.wang@kernel.org>
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
---
 drivers/bluetooth/btusb.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 76c52f2fe917..054e8c06bcf3 100644
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

