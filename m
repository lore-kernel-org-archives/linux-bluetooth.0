Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D21F15958A
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Aug 2024 20:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724100789; cv=none; b=pRWqCDB179UUW55Hg8iFjT3DtzST780vjX2bk4NfcGnzqBOyloiD3bPUJGynw6+sQXFtvWkqGigTGew5HrtOdyh9sEwJQ0HCCfwhrTIU5kMKhiKFpAvBnBGHqpZ9CRbHPioKZBg4s2pi/FJRm99lyvwKf1xiHqkQ/49MMi18FQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724100789; c=relaxed/simple;
	bh=bLpDOyVokrPaezJe8X7NGkIgzqAVumMBbGxLDLqCyaM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DJc+YD12a92jNyxsM54V4Mr2X6I3KHpORxr2l4zFUz+pFdxc+gNmto9d28srxQQQ5XWduQl295TFLjO+Vpb70w4CM098SNIlmpDeAKnSJX+MK9nBZOj8WdqNrkkXehiULff9oJgO4tDamGNENL/pOZXLucHhpfmBXFe/uKJRbrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLUdwerp; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLUdwerp"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4f6e36ea1ebso1574489e0c.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Aug 2024 13:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724100786; x=1724705586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7sqZsEDPGsUzK05lHRMK23xTV6lURBucq3CEq/C5814=;
        b=ZLUdwerp6vCtonwaUpPCXMNGT2Fs0MUxVCUdAD9zyT/TIa+cSkgKwqFy8tHgf/nBT+
         qTVCSyF5Lm2YuLEvjLv93N6zzvt1V4JNo5ae8mqwU5ON5ld5rj1S/Z8zLPDK/p6xAKgZ
         pBRHBiRZeFV7sOogGQ4vUIN7Onp2SHCq6LhNPqiRNR960EMNV5Bp2wjRQK7WoQQrVyO5
         wjbflWGtK3MvKXDLISFBcKwUE87XHtodHWVfZOuDrsROGlkjqlLYpJFJy2VLZI9ruzQh
         H0TceKHEKk21+dmzIXiuhBA5V6EP+xn2YFv6h6lZDbiVtJIm0q13JLt90QOyP42oUXSH
         88Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724100786; x=1724705586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7sqZsEDPGsUzK05lHRMK23xTV6lURBucq3CEq/C5814=;
        b=Gd9lp74gDV9yGQ+VPLNxcZAU0INCb/T8T7XHctn+0mDtWTOmIwFrpDPh/vB82ajp6P
         RIq2jFdZ4ZK8b7g931+fcNePLNHrxYeyoTxvxAdiH28yzrgqKoRgAVOMPi7XNVJfyEBe
         grV7gmT4vQLt68mv3d4kybRu0NlThTbHJjUOB277FbhiGhB+y/nw4H4QRXU4S7kEGDT0
         I583fJ6M/NmCuQjBcfhuT2hY5JzwLdPAsbyPwkNSBSiw0RtHPzFVYkohgi7XygnRgqUO
         8mX1VpDseqvf+SxZIiyeWBexWOpMi3ikHaEbIRP3V45UiJYoURFsIzOa4OWv9mQ4I+rR
         CIsQ==
X-Gm-Message-State: AOJu0YyT3+4xh3NvN/quw8CXI9zmpwzwXg2XdGh8zpD6sBdb+TkoHduu
	/CMXdArsWyGA/rDe8UQuX6EOzV4ROIj3002/xpnM+Y5EzRt3fbdpLZOB9A==
X-Google-Smtp-Source: AGHT+IGCckv3BMGeuXOMOlEU+9Y4g1Kdp0Zbk8zRV9WFRhs9W20P3eepqbnqOQWTmp0aYScGXFeE1w==
X-Received: by 2002:a05:6122:2013:b0:4ef:5744:46a with SMTP id 71dfb90a1353d-4fcd89fd752mr482819e0c.1.1724100786351;
        Mon, 19 Aug 2024 13:53:06 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4fc5b9cb136sm1155049e0c.50.2024.08.19.13.53.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 13:53:05 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] hog-lib: Fix calling bt_uhid_destroy with invalid instance
Date: Mon, 19 Aug 2024 16:53:03 -0400
Message-ID: <20240819205304.60594-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the hog->uhid cannot be created then it is pointless to call
bt_uhid_destroy as it will likely just produce bogus output as in:

https://github.com/bluez/bluez/issues/529#issuecomment-2297350805
---
 profiles/input/hog-lib.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index 1b4aca07486b..729603702e5f 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -830,14 +830,16 @@ static void uhid_destroy(struct bt_hog *hog, bool force)
 {
 	int err;
 
+	if (!hog->uhid)
+		return;
+
+	bt_uhid_unregister_all(hog->uhid);
+
 	err = bt_uhid_destroy(hog->uhid, force);
 	if (err < 0) {
 		error("bt_uhid_destroy: %s", strerror(-err));
 		return;
 	}
-
-	if (bt_uhid_created(hog->uhid))
-		bt_uhid_unregister_all(hog->uhid);
 }
 
 static void set_report(struct uhid_event *ev, void *user_data)
-- 
2.46.0

