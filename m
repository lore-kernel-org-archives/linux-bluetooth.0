Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF00736494F
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2026 15:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788361853; cv=none; b=OKBkeIx+ih0cyS6hiQlRoYNDOox3xhhRNg+okMIkkYrJpgsLDfPcAx3DK/VYQvFv5kqRg9PvnQbC7br21tBG3bhJ80ZE66j2Hcv3ecGZ/dtxpLvXEwVgw6K6ygF8C7KRsxFGz+vvRQ4lOJ9WSlI2aqsJqQIEZxpcjuKvyAGbbUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788361853; c=relaxed/simple;
	bh=xI11dgfqqzrHDY01o4bvdkAofYrHWyVxbY/cuV0BN0M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ghbEIm58EYIkFWDKFUBUn3kZvvb4Rdtzmi0wwllP+2NgPQl5UY+paHXN0BOSRCW5vXWLXNaN3X3UxMpRTKYhduK7lnxOySDZHim8a+qD52N29ChUFeQdDaZY21f6rR669UHcOyN5iCG/Ug1spuNXjYM8NrdjKEMK1VIXd3ouGw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNp60ttx; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNp60ttx"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-97ccaa61510so316778241.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Sep 2026 08:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788361849; x=1788966649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=soHDOb/lqvgb8NX6QgWHKUWd67efo3peVslnmBaKkso=;
        b=iNp60ttxbbCOCwibmedJRPsRQxrv+eHT9jNSG/3DZG2x9qEdB1dMaewdgE+ehQfkDg
         RQjp1uTH1s+cDnhL3vKjZuNMY9rniYq/GfwwvT4D1VPNDwoqAJPjTGKRSz/jnW9DQnDp
         j9Gny/hjNzF2o8hLF6skfQFljgbgsop+NBVB32kkKXtNco9zBC6sPKn2BmSa90QEw3sy
         kaE/7AU2OpyiHZFQEosfynFjwwjap2yJ86Dc3PEZjF95HbP15tdcVgqUUH3jozvMSNf5
         jeKZ3iPHCjqKbn6ZTEtSoOxGKHDnxkITCfGnyutycvNMUHD4W7a3EdMhlWlxu4cFfJV0
         qweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788361849; x=1788966649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=soHDOb/lqvgb8NX6QgWHKUWd67efo3peVslnmBaKkso=;
        b=B3BuR+1jnsPygLkSoylfMLTODpxBkTs6omF9hD4aW4cdDRoea0DUY6WMYDyHzoMc1v
         gsEfinq1RXlxP8Y/JfQ+J12s8GXWLnevPvnov5Gl1VhCSu//zu37rQoNxuTnqW3xhYMG
         qbS4mFAizz+rtapt7QPeqTTzkGS+YhMylN2gz6d/JOnXN4ln0CVM3qTQwqQeWSYL/Bev
         7sxcEXtl2ZoWm6xBwgkKJAFBKfFkOreUTxijWjysZ8xsGxdhR8YIWagiwMKo3KS/CdMY
         09ngWMp6A4y4cui5zg5USHW3Sa2yn3yjP38IEn2KbI46qjuleJy9OAkJkXhW+TEp+PZR
         O5+Q==
X-Gm-Message-State: AFuF++kRqyAg4Ws1WmgK05Q5IFluyOl5maRewo3wBLiNE+G6E/NY+Ijg
	PtLWStwbEoBOEvsc04OJbvBRz49KQMAAaMjnKva1m9GzHlaucjW/2+VeMsmlorLVdBd8Dw==
X-Gm-Gg: AYBFou3sDcsW1K4hBljwfl2eIqRgpSJAF0Ks+A/+I+pqc5B/xsNHsITAUKRIGYRIEjI
	4WzwWAie8oyeIUMHiyyGyIaOF6ftLib1cIOhzR84vwF2II7qUBtXmWyAPXjdvtJiXse6pLDBhlz
	5oi1LXLYj3eY5+el3hKmkmyelpvv7TF3f/xaaSW8MA8WNKdzIQ1SMYQaQrWX/Ovj1VjsKnOpAIz
	XX/DRSlE/WISaHZq/PHjumyPQe51R0uiRbFX6KqPPideflDAkJ5IWwTJ5zGcFgKRF0prRN2Vvpb
	TtbPULG766NDnRmZRTG1pOrEkTQj2DkzYDGoXbEdKuPFr/WLisnkMZIXnPEB+RGv7rL+KNI80dP
	Q7E5TDR1loCe18beTr21tLKIW2mCnHb4cnP97IfWuWxgU0omR19sCkMPlUXjAOe5ATsmprma6Ac
	YGN9mjfeN2Dgv9xHkKOS7YG72cKE+sS7IzoTxdI1OvyHMoOU+7lIGtrYOOrqBj/esM6VNBs3xL+
	vSoMDAVLhKaap4woOx0RL40le7xPQGMiaHrKYuaH/NaDZRbjTY1P4g=
X-Received: by 2002:a05:6102:1589:b0:786:77e2:d8fa with SMTP id ada2fe7eead31-78a1f1f11a5mr1703002137.5.1788361849376;
        Wed, 02 Sep 2026 08:10:49 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9807764dec9sm462410241.12.2026.09.02.08.10.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 08:10:48 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_sync: Fix not setting CE length on LE Set Default Rate
Date: Wed,  2 Sep 2026 11:10:39 -0400
Message-ID: <20260902151039.1583493-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

hci_le_set_def_rate_sync() left min_ce_len and max_ce_len zeroed by the
memset, but the connection event length recommended in requests by a
Peripheral has a valid range of 0x0001 to 0x7CFF (Time = N * 125 us,
Time Range: 0.125 ms to 3.999875 s), so 0x0000 is invalid.

Set both to the minimum valid value.

Fixes: 2f8784cfe8a9 ("Bluetooth: Add support for Shorter Connection Interval (SCI) feature")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 24eeb76f7207..334e5ebb26ee 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4797,6 +4797,13 @@ static int hci_le_set_def_rate_sync(struct hci_dev *hdev)
 	cp.cont_num = cpu_to_le16(0x0001);
 	cp.supv_timeout = cpu_to_le16(0x000c);	/* 120 ms */
 
+	/* The connection event length recommended in requests by a Peripheral
+	 * uses units of 125 us with a valid range of 0x0001 to 0x7CFF
+	 * (0.125 ms to 3.999875 s), so use the minimum as the default.
+	 */
+	cp.min_ce_len = cpu_to_le16(0x0001);
+	cp.max_ce_len = cpu_to_le16(0x0001);
+
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_DEF_RATE,
 				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
 }
-- 
2.54.0

