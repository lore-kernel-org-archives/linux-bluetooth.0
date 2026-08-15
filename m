Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85043B0AC3
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Aug 2026 11:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786791696; cv=none; b=bHjcXj1f0i8NVjywBFAGcCXswTPYEQrFP04tjVTSIZYc9FDisc2RqRIpaIFmIqQT2AEP1MpGIlK6Q29AXNscndDsICSVVYc5AFz8Hi84ZZbniqu0ktebQWLVb6N7+V7JpCaOr96nwgeQy1F+qGzLehYJKHzsxfRqQdTtcGsLaQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786791696; c=relaxed/simple;
	bh=hUrEZHb5J9leLF9C4izObyVHkwOLF5zpgSLXsiveMEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=necJciEGQgjVnVxg8/W02rJLuemPOHSPsvXyEUdmgIFLjQSHzA6bNIL3IM649k0rg6GhfRE9bWJE5UhdRKYgu6fB5F3RbYt73MIe9TKaY1dMbsuPK+DyJeolT6Zza+yrdpwHtup0rLCofhIXHr4j8OK2Tt/xK9Co8yMUKiWqfyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXMk2GiY; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXMk2GiY"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47db714766aso1767755f8f.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Aug 2026 04:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786791693; x=1787396493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3ptK48I+o/8rObdtxGC8ySPWO1bsJQ+ZYfLF90RICns=;
        b=nXMk2GiYPlQ29MxJP93Are/Dtae2JmSmIE7Bx9YaL74Sd9VHWBTNHPJ6sclik2ZUg+
         6oV3hFQQfxThF9sMWclGYJw81URCY4liBg+HRJol7ZuwLNHsFsTZJOnB2HepmRbzPLyF
         vNaZ6PZck8KpfZLiVAbfC7Lb3Z3IvKij0WJBZK0pwht7e9NuJG4pIY1opeSkZAj+GDJU
         RHcu4oaEp3ArdxmFtcAufilWIPIhp9rNl3rYnUF/+dt7M4P0PInQ9hCAln8hhx296TNP
         Ez9ldrilYwjhd7i5qqr6li4C4+Ux2BSAKI5c3T5G6cTl/pQGVrRhwBkHDuVktLeCt+ZU
         7Xsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786791693; x=1787396493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3ptK48I+o/8rObdtxGC8ySPWO1bsJQ+ZYfLF90RICns=;
        b=BlEqsWaih6JtmqcYWJuTNyuZyGIj2FMs2RYc2mnwYosXkPlJutCKwx3xEent/56MS8
         iKnY6PZWTdN2yjPgnLIYYv9VnK1C9Aqef+2JZJGlHNCeQFPqF9W8Lbif3Q+I4oJtRIpw
         ntk8VjQRMubUp5yv5yb/ROwx2UKj3BBQemnFHoNG6fED07DJqZLnFsd49vJAxhQax6Ig
         CRxGAUhSMkDftZbZoG5+6P0cOqAIizSwiZhKYUiHjS6hDiCQ6rSbLYhKD9llVVACR0Od
         PlcG0TGXtzb5Wyw78wGtx1MbtWqEcywIlXfZsB0cFlv92g8WznDz7MSsKyKbSlZ1lviT
         Qckw==
X-Forwarded-Encrypted: i=1; AHgh+RoqlXEzFIvaKwLhul2r9LyboY/M2WgAeDjXVDK8Z5pdlmuKgMuJFznFDVRkkb9Z+umU+OHDYEAzmXEjjvQcafI=@vger.kernel.org
X-Gm-Message-State: AOJu0YziKhipX7yfFjZLfeFsgumuDR/S58VcjdWSiAM7uUMmWEAo/Drn
	mu9nhwVxJbq2JKFanNVuKrJ8ouUZwx5XUp1FLMRiuW8d1PX0dxW1uPo7
X-Gm-Gg: AR+sD105Y+PfioWXNiLxGzkcUyvLW0JsUnYCP5pk3tn6kf3mYXEQc6sHUwiZz+9e+xL
	koCwQfsjxe+C9BNDx7460fw7Xl0+g2NZ+Z/yAT16rMZRlCPRCtpcoIyanEJ90DHwNKFA+/HXNNH
	M+HanEmeE/BI6uhZLVGoedu39fVgF9yCcJZP7XELy9q4kt2bq0F5fY0lKbyEnS2YHw8zvU4/EiB
	r8Z6DMdGftYCiSdSyCc2QRVYJIFFqo7FVQCg9jC1SBEV4C6LvIFwRS54sEC2ZJgWedNQG3HGIVK
	xH0/+HOw5Nwv6D4ZfCnYoMQ/6cvfC4pl+O/J75laOU2tlHajjQqMo26Ykoo9VnS0r8jD3hLuCkJ
	+KfmYPuMbCT+1K4mr+fbpwnynyiBDl1VQ04UzYhdrczjb7mA4MZDMowctBSJBIAMsYGTut1osvO
	2Sjxmit+9ecRe37AuhCt0YyFtjBBhQTuBxvBLAfH8p7tAj2bJwAqA8PhbYxHGCnANp/lXS0Bdxx
	Xz7Sa5lze3rhg==
X-Received: by 2002:a05:600c:4e14:b0:495:3bc6:d381 with SMTP id 5b1f17b1804b1-49987a4f03bmr179458435e9.2.1786791693056;
        Sat, 15 Aug 2026 04:01:33 -0700 (PDT)
Received: from archlinux.tailbe3ea7.ts.net ([185.19.153.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49988b1d8f4sm133728035e9.11.2026.08.15.04.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 04:01:32 -0700 (PDT)
From: Ismail Tarim <ismailtarim7@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: Jing Cai <jing.cai@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Chris Lu <chris.lu@mediatek.com>,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ismail Tarim <ismailtarim7@gmail.com>
Subject: [PATCH 1/2] Bluetooth: btmtk: Fix btmtk_usb_subsys_reset() reporting success on failure
Date: Sat, 15 Aug 2026 14:01:18 +0300
Message-ID: <20260815110119.11301-2-ismailtarim7@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260815110119.11301-1-ismailtarim7@gmail.com>
References: <20260815110119.11301-1-ismailtarim7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btmtk_usb_subsys_reset() validates the subsystem reset by reading the
chip id back. When that read succeeds at the bus level but yields an id
of zero, the reset has demonstrably not taken effect: the function logs
"Can't get device id, subsys reset fail." and then returns the return
value of btmtk_usb_id_get(), which in that case is zero, i.e. success.

btusb_mtk_reset() returns that value unchanged, so its caller cannot
tell a completed reset from a failed one.

Return -ENODEV when the chip id reads back as zero, leaving the existing
MT6639 exemption intact.

Observed on an MT7902 [13d3:3579] where the controller firmware asserts
and the subsequent subsystem reset fails, yet the driver continues as if
the reset had succeeded:

  Bluetooth: hci0: Mediatek coredump end
  Bluetooth: hci0: Can't get device id, subsys reset fail.
  usb 3-10: reset high-speed USB device number 5 using xhci_hcd
  usb 3-10: device descriptor read/64, error -110
  usb usb3-port10: attempt power cycle
  usb usb3-port10: unable to enumerate USB device

Note that this corrects the error reporting only; it does not by itself
make the controller recoverable in the case above.

Fixes: 25b6d7593a3a ("Bluetooth: btmtk: introduce btmtk reset work")
Signed-off-by: Ismail Tarim <ismailtarim7@gmail.com>
---
 drivers/bluetooth/btmtk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 66b346761043..dc702c0a6034 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -968,8 +968,10 @@ int btmtk_usb_subsys_reset(struct hci_dev *hdev, u32 dev_id)
 	}
 
 	err = btmtk_usb_id_get(hdev, 0x70010200, &val);
-	if (err || (!val && dev_id != 0x6639))
+	if (err || (!val && dev_id != 0x6639)) {
 		bt_dev_err(hdev, "Can't get device id, subsys reset fail.");
+		return err ? err : -ENODEV;
+	}
 
 	return err;
 }
-- 
2.55.0

