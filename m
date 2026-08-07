Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00233369224
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 15:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786115712; cv=none; b=djlY6O3UruY7er9kGBbjMonuSfYfOvnvlOgW6FO1LZfQnm8dlot03jxyGk5KNB2evOrviaMxJManBR7qhzNnfHr3PKZghjyTqjeC2qKWtWYO9jWi+Oc3WsEgfhVQ5It/xhPxSt6e3FqtRGq5x7g0WrAsE/p4fVRAfN7AIa4Wsok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786115712; c=relaxed/simple;
	bh=4TgRja3T20fk4mqkpC+utYixmpcSGpXi3NTzY7Ze7hc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AyrjptX0uZDELRaWSvvsBQ5CHTYyk23yt2A0zUSthT267ahVnIWhhADLBipilKIPZALW29yqYHU0DlAYRS+GungkLJzvDWR4SSiDFuaqnEnNwhuPVTYGRmatrmy7wRKFC04qszUE2QL+VFCLx1smhD0RQH1+15Glg4v4ghi/0CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWpxIaY1; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWpxIaY1"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cacf197759so55242115ad.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Aug 2026 08:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786115710; x=1786720510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oYD8vxjOHGuQyZYPR9PahIsl2VjFcOZPUXc7tvdpKVw=;
        b=iWpxIaY16CKpsWIDDgGqC9gEHRs1BbZDWfyMhFtAiraGfVlbJnQ2Yk4ypl5acwZdo8
         zkeNtBlvX2cV01dx1MBL+IWi2i+RLJpaZb8UvKa9n12tn7ZvEU9+MYBVdTFUn/Y/Z0vp
         rx4KEnU26csSi6HbtOc2GcRCyMW/Is5kAbOX3xYdfqoNBH/tIBrSubkn+4gqlmkC1ZCO
         0J7wkSBsE3FVa+VgbpMcN0zehXsMvOWC19un4ISBNTuAgGRhFE+hcErGhXkLCo2r9oK6
         w2PHapOD0zBeiWh/BV26KZLS8p6rfAE7oAkqGKx1OQVZVZXhmtrnJIeHP5Og0ubiqVN6
         ye3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786115710; x=1786720510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oYD8vxjOHGuQyZYPR9PahIsl2VjFcOZPUXc7tvdpKVw=;
        b=HbdsSJaW8hwjzDZcFOSq/nm44kVNQW4a09ARF0+M11joidA+V8zk6qFGQ7eV2gDR7a
         XvboOEmf0pIdhbjfc1cezlSGcwBT2LDNIUS/ibKMGjUVhDkTJ8yyS/RhLEfitcPLQGWu
         6dKuTOBpW3UfKfhyohtsCuogZDUMMSiAkR1YdYoQ9XtN1/zTAE80TJEPOXS7j/wZQSTo
         4kxdaSWHcP2KqCHHnPyMFu7twsOuYfeNDBfxdiBgbikV3dtGcq2qtUTPDlaEphtRGfqT
         8K9pwvA+x4jSoFd1kuxxPTp2MEAQPqqFdaHjq9juT5LqTclW3AK070QbyD/A417Pt0Zy
         eFSA==
X-Forwarded-Encrypted: i=1; AHgh+Rpw2WoUIt9sYSTHqVb453yC9ErmpbrihaSPQ1jpUccmhyGntHyay/3NMIVzbvZkcPqqjU6LmGcPtyl7IoYjqyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YydgvicPyO60pWLuuahpYXH48D4eCe0kLJmCB3xNuDj+f3up4PV
	TWrUSIO16nO1bTNfhElQK2hS1AvnDAvjQridUJqpCretMBEk8klwAmFg
X-Gm-Gg: AR+sD12UMUIuE42L+76j+N0XSXxlKNzCqT+z+IkppFjxpt1AfQeKqhFrdD1ROIBTSLz
	99Ny+kUxzSpd2edevm0GYLzoRlgY8jSMmZe0HZoEtozd0XF/iEVoYj6d8SrvXOtettmrvJPl+Yv
	rAbPbaTg1TbBNGwBVKdTw3sm6luS/52+xbZlDpHCRwY9ASr4G2/SZFjCaaT5ivDnUSLoFvUz1kP
	y52gzHgfmw3aKCz2uDr1iq/5qbc+LdZBd4fpwITHQF23JjQY1il2cnRUpCcyQZIWG01ZdKFnXgE
	/Y66jrqFWEO+rvFpzAGUjIeDfpAbUz93wRWQQEYVA3xM4Znf0JOFRttlOv6M6sQEhEOH2LC2jFM
	guz5LOaafs+twztodqGS8CL7yt0QPvD8UJd/1hEZAIMof1cW0hCD/fONd3mDcubLm4IainC9qmv
	PujzhWNAyPQEq5KD+cfE1DjM50RCFTMGe4xTYhThblDf+PhA6T80xHd29SjA==
X-Received: by 2002:a17:902:ce0e:b0:2d0:cc92:f7b2 with SMTP id d9443c01a7336-2d294b293d0mr61010985ad.1.1786115710098;
        Fri, 07 Aug 2026 08:15:10 -0700 (PDT)
Received: from lgs.. ([101.76.249.46])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d14ccabdf5sm10829965ad.14.2026.08.07.08.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 08:15:09 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] Bluetooth: btmtksdio: fix usage_count leak when autosuspend_delay is negative
Date: Fri,  7 Aug 2026 23:14:47 +0800
Message-ID: <20260807151447.2530075-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btmtksdio_setup() calls pm_runtime_use_autosuspend() when runtime PM
is supported, but btmtksdio_remove() does not call the matching
pm_runtime_dont_use_autosuspend() when removing the device.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during driver teardown, this reference is not dropped and usage_count
remains unbalanced.

Add the missing pm_runtime_dont_use_autosuspend() call in the remove
path before restoring the runtime PM usage reference.

This issue was found by manual code inspection.

Fixes: 7f3c563c575e ("Bluetooth: btmtksdio: Add runtime PM support to SDIO based Bluetooth")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/bluetooth/btmtksdio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index c6f80c419e90..4e1012e90979 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -1480,6 +1480,9 @@ static void btmtksdio_remove(struct sdio_func *func)
 	if (test_bit(BTMTKSDIO_FUNC_ENABLED, &bdev->tx_state))
 		btmtksdio_close(hdev);
 
+	if (bdev->data->pm_runtime_supported)
+		pm_runtime_dont_use_autosuspend(bdev->dev);
+
 	/* Be consistent the state in btmtksdio_probe */
 	pm_runtime_get_noresume(bdev->dev);
 
-- 
2.43.0

