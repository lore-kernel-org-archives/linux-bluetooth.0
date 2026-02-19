Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FFC72631
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 23:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771542995; cv=none; b=Ai+yK7bgzakD/Ko5gsJ3jmAPYLzjnG7t39X23oqn1KwEkdpVgvjA36AsPbTDQHfYccJL06xPj0FEnYUp+USCKqlTMGiIQoAZz7ZSs1smVQUXVWMLA1mWbk4hT2LKQLouxVq2Sxg3v2DYlrfG+hHdvExk1df/zE130Z17do9GEps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771542995; c=relaxed/simple;
	bh=4EJuWggC5ynHFxILfFhxbh5SNzmvaoGDjGWGAhL/olg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WvIvGZDcCCoJoMo2Jz/6PCR6BSZ12pXtRFCrrVFrse/u6TZLR+L6Uo/gBVCJpGsJrzCpqAfRjnTb9kCYIziKTlOd9a1Rxs4syid3uJ77zAiblVxV2kMBRKP21PeGAAntnfd2punWCZ/dxrtHitBARNmVRVRM83D+alqrRZvWjaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-40427db1300so880278fac.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 15:16:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771542993; x=1772147793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOpRViDdy95oUvtjIbD1yNnLGcXCFi8ZfYmxd9/IW/Q=;
        b=mmDKjrTFd4DWqSiEEtqv1bhLEU0RKDgEBfm05SU55wDUN0+W2kbDbHdU7WqNEhk/56
         6C0yI7Fla/pc4GHMUEURMDYiwMZhv6a2lL8SHtAwJua94k2AmPSaK9abydGFpLWHvhDd
         4CMYLV1du1KNJEhn1nyzZb+nFNQF7d6/0mzstepfcgvJNgFbIQyseqIgVNN05/d+1jND
         vUWPlfMDvBmH3XUS0rbGxMhKAlWDFctKyr49+INOMz6g0EzODWgUbNVoxZVfkvTD7vFW
         mz1z8Ee9QhTM1GEkEXKOBdOC2p/3UJZjrpnZcTCoOoscjT8HPhbKHRnMczfNIBuY4hTe
         LGTQ==
X-Gm-Message-State: AOJu0YxeEEIDQc0jot7nkF5SinypWHRw15rdDkWSI73VwDlXWBDj5n4d
	bhEU1iPGNzMB5+HuUJObDUJDpaYaLvGXtjaIo5sS9qUpUMydIOVPVKy1
X-Gm-Gg: AZuq6aInzVdLGAyB/QUKGUIcFGjnD4gfDMKo9j1qFMOS9KQQ/qehDBuOqZkqPorVZn2
	qAjc7JNx7UCHzYTCfNC1TVXTvi96DZMRmiZpXGixsq95CnuzrbitsoLAWDTGZdr0hvuFUZL4CEM
	zSxalE55MvhNuGuht7El4GIZbIQDhA7HwOSjC7j7SMELzJR1ItBxPNs63NsbkbuBXIUm/HLYi46
	0oPu/1QSZj73NhO7UIy0dl9X1tzVp+TmAWUhT84uSul5Jm/+H9z9B6nu0JQpCdd6ks77xwVfc4v
	+D+tN+Lzxpt2rTw0mYGBJZ6mWX163Q5oa/7kprvNBtzOAHuh8SGr4sQMInLHA+pNX4gBPfH+D5W
	BYl4lShPCPJ+gccvhhMeAgIWIanwOrqRGSh9iC0MVrQ01mbZ8iB7Lv/AyNRrr+LuEh/1gs8INZd
	CBjRdhqUsH/yoRrkTawvoGsmCa0Xc6C5Tfmdp72VJ+xr1xxJ8=
X-Received: by 2002:a05:6870:1405:b0:40e:9550:3242 with SMTP id 586e51a60fabf-40eeea800famr13275159fac.16.1771542992946;
        Thu, 19 Feb 2026 15:16:32 -0800 (PST)
Received: from sean-HP-EliteBook-830-G6.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40eaee45d12sm26719644fac.1.2026.02.19.15.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 15:16:32 -0800 (PST)
From: Sean Wang <sean.wang@kernel.org>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	ulf.hansson@linaro.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 1/4] mmc: sdio: add MediaTek MT7902 SDIO device ID
Date: Thu, 19 Feb 2026 17:16:21 -0600
Message-ID: <20260219231624.8226-1-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

Add SDIO device ID (0x790a) for MediaTek MT7902 to sdio_ids.h.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 include/linux/mmc/sdio_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index 673cbdf43453..97cc834fb3d5 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -112,6 +112,7 @@
 #define SDIO_DEVICE_ID_MEDIATEK_MT7663		0x7663
 #define SDIO_DEVICE_ID_MEDIATEK_MT7668		0x7668
 #define SDIO_DEVICE_ID_MEDIATEK_MT7961		0x7961
+#define SDIO_DEVICE_ID_MEDIATEK_MT7902		0x790a
 
 #define SDIO_VENDOR_ID_MICROCHIP_WILC		0x0296
 #define SDIO_DEVICE_ID_MICROCHIP_WILC1000	0x5347
-- 
2.43.0

