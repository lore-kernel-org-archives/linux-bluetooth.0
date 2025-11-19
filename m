Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3614730CDBA
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Nov 2025 17:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763573432; cv=none; b=lpBYkWJBus2oi9CTVZ8k06Fa19NdZkUiEfS98ze4noB3DFRa504BUy1V5kxm/DqbK1os5ueDEEGiCpIJRHw/2BePQIgVJ4Z2N3RkUdsIVM4Js9GO3iIMexAyNMld46fFJ6XVGY5By08d240hFoWhqBBLI+i5X4B40FIyyXf7m6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763573432; c=relaxed/simple;
	bh=DulPoKHD+kYa5guw7XEkGvzu8pnfnuu0PPM1s5kskN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uYJEW/ClKVf/NkRD3kjM+YmQ0uRdG293KNspTmTM3LAsuliQAyDp5io/y3bpDJrBOfKnaAOv0YA1wbsXVmSD68WiHdDq67mtyhNXKbfwfcv2HK/ZhZnLtiV9NlD9IrEnG+OFUeSruN5xwQJTtAFu/r2oGxlCyVI7TZKo6aa01Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EmxSzog7; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EmxSzog7"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7a435a3fc57so6762851b3a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Nov 2025 09:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763573428; x=1764178228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TMBoUXycCoalUx2IdYMe60O4++ie5VkCIVBelZSQqfI=;
        b=EmxSzog798Qfj0NotnANKv5JYaZtqe1vtWP9+KsOqQxFZT2hzsuqqW2CQbq9c6tBNg
         1A1/erP461sZyZ5rvIRQCNlmwenODACzdyy5THo4lhD2aJWjtxZsJAoRqkVdWlOyT1Jq
         MNyY3GbJ9KIQhLN0qOI/+7ZWf+kLFdn0BC/5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763573428; x=1764178228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMBoUXycCoalUx2IdYMe60O4++ie5VkCIVBelZSQqfI=;
        b=wo+S9JSkEzYGL26QjCFXkPVLBID9tzgINBAF0rfl8OsglfXwonIGDboZ/fL4ED0oag
         2MG+UX7QZlcwy5JLuP/Ev0cbOgD47MV3WAktE8bavQ4N22d2cTTbBF7QJarvpb/ZibPg
         sHZzqkOdweJ1AvZT8EetJTmAQUsZepoVAEnXp++coqmTNhOiDVqtgPdvjP9N5Dn3NMt1
         OAIl9mpn4fjdmDK202Z4wOINp0xuF5OpxGxP/7KKb97uMeyGFDOfGbMMtfsMuY0Igj7Q
         yNytwMArQez3wmOz+1KSjW+R2qebOHfrOG+7mJD0J5LFy+J9XLvKOfr4X93OEkrthdj+
         YvXA==
X-Forwarded-Encrypted: i=1; AJvYcCWKfuChyY5BSdAZ16O8s6RrqVZdNA03hKSaAdm86LRikKHpkpIqBq3XH/kplj6XiyQzMduIf4to4GzQtQkCAps=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlVWenZeVwF4j5iSXfa3FBBnbfY9BgdkG/+PUIg6C1ry/IEHrH
	1vTf2GOORyhCT44PYXBXKJTdh+LY0ITWsmVsMdVsoRfDboEsPA1zWcSQ1vn3eAUDeg==
X-Gm-Gg: ASbGncuK24SLKqY44nUJVe5DnDkm4mrBiPUt3IAbLzRAWB5kAAWsP1bQVsw8MMo1Y2d
	7cCbgXbB2URNfg4AZCrfIe2JsxeRYwOzeVvt7jwcap+3v8oATYZlFPn5ROMxqpV1hlllgM/jM4B
	e+rhHfiylV/nUW/LAY8XP3P8JCSTnWEyq5GF1Yd/YBseoaVgUMhj81QwZVFb0gG6C9RnGNvBvuh
	lm2aaUSAhdPDsRMPEbCpeeGO7Op4WesYalGvDEE3bBLmTPmW/yxao0vU47ZdqZ4wZ38OWhokseD
	1ZJW6FSSuLLb0I3urUz4gC0ISK45e1yViTGY/SVQrai67NP+QqCH6SbPovt3/Ue0/csntj5UM7f
	IMaSoDUPZyA34R31s4B6V1liKPFdAaPdFexwJ33ErxXjXfC9u68Mf8lm6r0GDD9kclYFsxunMU8
	FIcPpmERuKR1on8oIiRzn8as7AqiWcZIvml2xNqX9L0EHGinfl4JCwahvaqv0XDut3BXQ4Exs=
X-Google-Smtp-Source: AGHT+IFB2YSTkbyEbeQu8O7Mtor+aeK/rpWG1+Is+9xqP/zrbkSWBMOGAREHyl95i2ctzd/T2DJJ7Q==
X-Received: by 2002:aa7:88c9:0:b0:7b8:d12f:90ae with SMTP id d2e1a72fcca58-7c29de3b6f2mr4341114b3a.21.1763573427806;
        Wed, 19 Nov 2025 09:30:27 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:cf0b:c8dd:8f4c:d649])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b92772e713sm19839792b3a.54.2025.11.19.09.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 09:30:27 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: incogcyberpunk@proton.me,
	regressions@lists.linux.dev,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	johan.hedberg@gmail.com,
	sean.wang@mediatek.com,
	Douglas Anderson <dianders@chromium.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2] Bluetooth: btusb: mediatek: Avoid btusb_mtk_claim_iso_intf() NULL deref
Date: Wed, 19 Nov 2025 09:26:42 -0800
Message-ID: <20251119092641.v2.1.I1ae7aebc967e52c7c4be7aa65fbd81736649568a@changeid>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In btusb_mtk_setup(), we set `btmtk_data->isopkt_intf` to:
  usb_ifnum_to_if(data->udev, MTK_ISO_IFNUM)

That function can return NULL in some cases. Even when it returns
NULL, though, we still go on to call btusb_mtk_claim_iso_intf().

As of commit e9087e828827 ("Bluetooth: btusb: mediatek: Add locks for
usb_driver_claim_interface()"), calling btusb_mtk_claim_iso_intf()
when `btmtk_data->isopkt_intf` is NULL will cause a crash because
we'll end up passing a bad pointer to device_lock(). Prior to that
commit we'd pass the NULL pointer directly to
usb_driver_claim_interface() which would detect it and return an
error, which was handled.

Resolve the crash in btusb_mtk_claim_iso_intf() by adding a NULL check
at the start of the function. This makes the code handle a NULL
`btmtk_data->isopkt_intf` the same way it did before the problematic
commit (just with a slight change to the error message printed).

Reported-by: IncogCyberpunk <incogcyberpunk@proton.me>
Closes: http://lore.kernel.org/r/a380d061-479e-4713-bddd-1d6571ca7e86@leemhuis.info
Fixes: e9087e828827 ("Bluetooth: btusb: mediatek: Add locks for usb_driver_claim_interface()")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I have no way to test this commit myself other than to compile it. It
looks fairly straightforward, though, so I'm hopeful it will fix the
problem.

Changes in v2:
- Rebase atop commit 529ac8e706c3 ("Bluetooth: ... mtk iso interface")

 drivers/bluetooth/btusb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index fcc62e2fb641..683ac02e964b 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2751,6 +2751,11 @@ static void btusb_mtk_claim_iso_intf(struct btusb_data *data)
 	if (!btmtk_data)
 		return;
 
+	if (!btmtk_data->isopkt_intf) {
+		bt_dev_err(data->hdev, "Can't claim NULL iso interface");
+		return;
+	}
+
 	/*
 	 * The function usb_driver_claim_interface() is documented to need
 	 * locks held if it's not called from a probe routine. The code here
-- 
2.52.0.rc1.455.g30608eb744-goog

