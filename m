Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D7633A6FA
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Nov 2025 16:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763655234; cv=none; b=pRk1daj2VaQGmZHDtupleozT10yZxlkmbWapdnxhQGWnOnq8yCrZeU4MEl2uSkTjoUuDiPu50UKGbdnAyNJb0W8GA5kaPW0T9KA+QbLjbhx5dj1SX+TX6Gc6wMaXj9knP4UN9sN9WB2+yFfoG10rizV4g20M8pmDzXGbL3FhhtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763655234; c=relaxed/simple;
	bh=gN67dPn5HJkDHA9rzNNREU8a/Ke/QYzy2kebu4ZH7qs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GtBHLXDInYUyzhwKHw+iqQMBOBbvDc+w9S6b9Dd1ESooi6btLSSnoi46S8FI5NlACHodVQnqRSiaDRss0ibRX41rX23l1pbiQqLAIq+cKQqW8F+SSn9GPSZzWIAZXw5EBp21LdMVp8YUshd9y7RGZiQYzyGz/VYfc2OvHg/53Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=G2taClqW; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G2taClqW"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b55517e74e3so753321a12.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Nov 2025 08:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763655232; x=1764260032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yaSUH4/iI6K4vkTA9vG1I3sRuhxHn3+OXrhAbv97RTc=;
        b=G2taClqWYtKUSxwEEDx58IeMu9UyMJjgb+yYAadw+ZxMczLRv5arrjbM4DxctarPLv
         Bx/M0GofidmCEXJGRNhp2TpuKOpCbatOpfkW0zRXjqtR5WQkf64+4t/zLnvGLVf4dflf
         490KdbQdGvfagPoI0kKMEna3vIwbieOpXJ47I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763655232; x=1764260032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yaSUH4/iI6K4vkTA9vG1I3sRuhxHn3+OXrhAbv97RTc=;
        b=k75vgyKtsDvzBeqM4YObtgbdMlpyCH278tWYeow3l6kzV160vbHHMx3wcCzhmOHq7M
         ANSONr4aq6aqhJSeeNbCsh80R3bLMQCx8/sw4N0kGh/+YVtyS3OrPbF77C+/ZGlLDmmd
         UBt/o99WntTvCrMe/HquNGgrHERYciOGlOe77HDZp3ZFWBzdLfLqDSy6KCGWVkx7AYIf
         b8egRw25MO4BIYOIyjVIRS79MncJ0fS9JfOu7wWfYj40geQwTXN3LSAbPi8uFEIzFqXm
         EHB5o7tn4+Lc6jzszLriU/B7vzjMmsIq+SsRJEFsl66cBHYX3Vo+TSWBPyZ/Ur6vAdp5
         4mMA==
X-Forwarded-Encrypted: i=1; AJvYcCXP08JlXrTRDpLBtfIbHc3ML1Cn2Hkl3RJbNs8DrNfC+L/G47fQliozW4a0ZlmvQct3fT5aaoQZX5nMtiSdEQw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/+8yeJZBG8IZbo1w8sIdjG+9zqUjAjr35xxd3OUSbk2yMRCKk
	lyW9T86SmG76YeSZaSXHWp0OFM36wsLbVsEkna2QnXj8iUJgY05nHHyt8TM26GtxTA==
X-Gm-Gg: ASbGncupsU+klH5fEpYEN4UK1z8zKHIsZGTOJwIvqcYi9zp/dB+cT2JumMoFzb+NBwM
	OQ+sDBPOlb9WKz81k0x8Hd1xLNAsjP7fidvkQJ7kZLj5mIfRs5XwS+XZhgUWKDBYfqcKicxoVDw
	KgK1X4LTxAz8ZxRI2fglU/FaRftfgb4z7bnhn8VWsP9HVtN8tQk4E66i3cblN18FcbkptV75Q5U
	uUnHsFc1qLFi105kpHwLELeRVY/2ACl8NhQBCAy/AG+MRBFeUCGjNvHPTgdNBx6vKFbRCerRiei
	cm5qNDXhr8+YiiUyIcZbL03GEH+074g2hnlhKL9OErzcj6+nOIQrFQYODeGljp06QnzETlSOMYG
	q3HGOzfpnGabFEedgDJrW+uJLoXvwMxgTtJctXYOBWFxFUqXqowbJ8K3upqkLskkyEqBkYa5JmI
	Rfsl5oytU4u80r4lGReAsIIRhEk2bLo+SKXt0KLnXsYg3wKL7ZaAc3XDMrlkIq5hyEDQ5h69A=
X-Google-Smtp-Source: AGHT+IHXE1Lf/Npuwj0zFjBOEWKicuzA3UumJeheDegj7w9jH2aGLxpoO1AX2E47uPWOL3GSil4eRA==
X-Received: by 2002:a05:7022:b88:b0:11b:9386:826b with SMTP id a92af1059eb24-11c938a5da8mr1482106c88.48.1763655232027;
        Thu, 20 Nov 2025 08:13:52 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:b075:e64a:7168:da0e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a6fc3d0bb6sm14316777eec.2.2025.11.20.08.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 08:13:51 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	regressions@lists.linux.dev,
	incogcyberpunk@proton.me,
	johan.hedberg@gmail.com,
	sean.wang@mediatek.com,
	Douglas Anderson <dianders@chromium.org>,
	stable@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v3] Bluetooth: btusb: mediatek: Avoid btusb_mtk_claim_iso_intf() NULL deref
Date: Thu, 20 Nov 2025 08:12:28 -0800
Message-ID: <20251120081227.v3.1.I1ae7aebc967e52c7c4be7aa65fbd81736649568a@changeid>
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
Cc: stable@vger.kernel.org
Tested-by: IncogCyberpunk <incogcyberpunk@proton.me>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- Added Cc to stable.
- Added IncogCyberpunk Tested-by tag.
- v2: https://patch.msgid.link/20251119092641.v2.1.I1ae7aebc967e52c7c4be7aa65fbd81736649568a@changeid

Changes in v2:
- Rebase atop commit 529ac8e706c3 ("Bluetooth: ... mtk iso interface")
- v1: https://patch.msgid.link/20251119085354.1.I1ae7aebc967e52c7c4be7aa65fbd81736649568a@changeid

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

