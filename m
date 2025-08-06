Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D63E1FBCB5
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Aug 2025 19:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754509728; cv=none; b=t4NW/l0QSncplGpTCwIyKv2UBqoD/HNaHwNXT2ryoO+209FmMOb9R+iXsg9OCo8Hbv4FFB2MI0zJnGRvlLK5yAlI2+5RLNyF6zbmIlXKCFaRvk4E5fqk55Z+Uf5lB/JaGGnPsYpvKX7HudwjUIrM7x5DvQhK5jPKYSDj9/l+50U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754509728; c=relaxed/simple;
	bh=wEVUJ4UWx58fY/ZhuGvt+bEN9Ky+mytvE7npuCoUjOI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQMpcAfhcDbLgqW0aejI8YBXbV3D2IHHJS1PRmqGp/R6LvI9ikNeGMYlpx9dykomRaOasdXNY8pxq23ALOPWiwkG7bT5N0/6XcXuuAF0tLgum74hNSK8EiN++XZPx93L7mqY1vhdP93hK2FvUIK5pdD7M4GvKUUY95QclFaV7i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aRYhO3Wq; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRYhO3Wq"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4e2b5ffb932so144918137.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Aug 2025 12:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754509725; x=1755114525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N7UmMcj38LFikaOBUHXF7evLLg5flYJOV0VIA/3VgUM=;
        b=aRYhO3WqkAvEpq9BBWWTNna0BRj9DA+j/TWMfeuuGaAHu1egf3CKMa5VbvnmcODgLU
         9fJl4nkp54L3QBNba9tIQsRFQJ29bCr5cXRn6+IKFzYvzrykHnjx65BxiEGR5KX9j0Cp
         6ydWIV88oEjZG0zLkNmWB7kYi/I1zSrUSMHoLNrYfEJdW0WOCgVF6KTDmHgk997fYWcB
         6Ww2544nSeSghrIuF9cbpbPgru4Zf3bmDyOmcleFpRv6cz5oeD5Gl8YgB9f7w2VLpIwU
         9eG8Su3COlgxmmqMwYx4GtMQMkArLjdSrsizBoREliVfNexG8d4Ezj8BHiUXaKfxxOf5
         PiVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754509725; x=1755114525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N7UmMcj38LFikaOBUHXF7evLLg5flYJOV0VIA/3VgUM=;
        b=fcHWS42km3WUk6leo2xg9XAw1t8KR9tMrI2d3+pVraMndCKiK9vXxCxVmF9ojL7NQT
         Tu6QHWNGvcjAoEkmkWTimI0GQ61DUpYwonjBjx/4V3rn/MYzTJUvOmEMMQX2vNv+9HN1
         YSGKo0ndvd3YsQP8VUf0/IDM8Pd5vQgIIGhWeJe563V/QTiXHnV/9n9cER/mz53crZmc
         UtZyplUURdHGOC8C/e/C0KYCcnnVf2FD240Q0eta5KNEzt3HnoIB3XjlKerDq2BRSh5t
         VAFzxdn9vwIb1h50ZAgfmCLgruST+l5qmHMlAs0YIugOvpemqlwJI28NjSm/GlhPP6JA
         hNbA==
X-Gm-Message-State: AOJu0YwHzWxEtUoWxG4QPV4RIWfmX+rFoHhq16rZcdyZ0eYtJB0SIyAU
	T+wQinRbZmvoZcSmAegdyVShfvLcfDkbtkQPiZoPaqwHd6f9ACigJIcHlZ4Z27gI
X-Gm-Gg: ASbGnctywAWQmo9CbzgJc0GMiY8p7CBHTB2QeOvKmkgjHPRTL0yp320DxJRjmK427gZ
	7wpOH+Y2TEv/qTmBrQ/mLXDOi4ItiLuy6LtfX97NhPy5/6+1+jcZjwtAi4DsrjLJ1dmb8hohUxq
	iZX+Gxly2QYLTOM+yRZ3geOvzjJ3u6w9b430ZBhijxfV/kK+KFtckCHUQYnepJBs1MvBQWBjcHd
	oHEoRQrSnCFBWmaeHMq96ABKYUT1/zpDwEmhAFJRyvxG9CE0vcIIqXOyNMtdc0NGBSu9KTs1u/D
	FUNriOpwmVrPWGvHYHiny6Oda6bwzU7o6IEaNE46zbHk4aLsceyg6C2zKbcAB1+U891eNA/ukvp
	jv1XusgIbEjb+ZjG0RSUfcV5clkdlmgyoJj4f7H3pN7rXyiArJJ2+X5a0lDmjEhnk
X-Google-Smtp-Source: AGHT+IE3pTUZq3LnkVqC8ooucYfQfpkoVwbPzcQ6XLHK11c7jqVq4t1h0+KDmxVIWi7+wRhKViBA6Q==
X-Received: by 2002:a05:6102:f9d:b0:4fc:1512:2fec with SMTP id ada2fe7eead31-5037403f85fmr2601224137.26.1754509725372;
        Wed, 06 Aug 2025 12:48:45 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-88d8f324b3csm3607920241.6.2025.08.06.12.48.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 12:48:43 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/2] Bluetooth: hci_core: Fix using ll_privacy_capable for current settings
Date: Wed,  6 Aug 2025 15:48:36 -0400
Message-ID: <20250806194836.291949-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250806194836.291949-1-luiz.dentz@gmail.com>
References: <20250806194836.291949-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

ll_privacy_capable only indicates that the controller supports the
feature but it doesnt' check that LE is enabled so it end up being
marked as active in the current settings when it shouldn't.

Fixes: ad383c2c65a5 ("Bluetooth: hci_sync: Enable advertising when LL privacy is enabled")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h | 1 +
 net/bluetooth/mgmt.c             | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index bc29f2e2e16f..bb30bde6f0e8 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1934,6 +1934,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 			 ((dev)->le_rx_def_phys & HCI_LE_SET_PHY_CODED))
 
 #define ll_privacy_capable(dev) ((dev)->le_features[0] & HCI_LE_LL_PRIVACY)
+#define ll_privacy_enabled(dev) (le_enabled(dev) && ll_privacy_capable(dev))
 
 #define privacy_mode_capable(dev) (ll_privacy_capable(dev) && \
 				   ((dev)->commands[39] & 0x04))
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index c42dffe77daf..3166f5fb876b 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -934,7 +934,7 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	if (sync_recv_enabled(hdev))
 		settings |= MGMT_SETTING_ISO_SYNC_RECEIVER;
 
-	if (ll_privacy_capable(hdev))
+	if (ll_privacy_enabled(hdev))
 		settings |= MGMT_SETTING_LL_PRIVACY;
 
 	return settings;
-- 
2.50.1

