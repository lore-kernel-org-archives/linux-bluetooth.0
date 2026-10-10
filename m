Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F873C0613
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 03:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791602331; cv=none; b=l8Hd7f5j4Ln2nFbZOq6/Jl+4o3oUw2CCOFCysYPUsE87ObK6//MLW+Xksa9hYVCo5UNt045TtHu6nh0daj8QdARcIrpPZ+9Gc3XRu/4DmFbMpZWydADo6f625FEvZ/X8OsEGg5tfp4lsYWopMxmJsnZwXoAtWUQMcw6n2Py8m5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791602331; c=relaxed/simple;
	bh=QWKyhxDY3ADxqnTv4K9NoUVDs3CREC6jTpXhYKlWoUI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=sM7j7yCyC9GWPB6kKU66WiSYdpGyT5G6H183u90UxYiMyRypeWTQRK5GS02hIxJdK75pEJzoSuyaiaHx+QlWzEg+0xFDkkdwJSYFi/D+ecPbvVSP/q6Ni4pV9+dHydxa7+J6Vvlx+obw/Rdvhl9Mr2QPTxT0GBdMfxwaL2E2cfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPBFkilF; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPBFkilF"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49e71fc84bbso150525e9.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Oct 2026 20:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791602328; x=1792207128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0itSnhKnvRvjXqClnFDxzgVh2Ci5FjExALksthzxrrs=;
        b=cPBFkilFZ/ObmGlpOSieqwrfUPkWEFH89Q8t21i3ZwEbuzlufJkxX8T1lCYYu2jl78
         MIsYEVVnXH+rYpByL9H+ekEdxU7Fi4Km4RhwgXJ5TbP4BXRzYXgMHgN8ej3ny/zzvuef
         mvTA69cZwm5tKfLQF4M3nalILl0/LfOHmUKNiT+wxintgullOerv0s98nBkAzGZQu7Kz
         eBj5cpZx5UXc7mZ8Te6GV9MopFiBxc9hKypujs3FQPS4Qpk2+sk/DAk0RRNsDVznLm9N
         IbPVWYGUSSSLZeNjEYvvKFLNJdhn/31Zdk/9q86DxNrGFnf71h8OaxnvLYg2Mqn3HbMl
         iS2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791602328; x=1792207128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0itSnhKnvRvjXqClnFDxzgVh2Ci5FjExALksthzxrrs=;
        b=Tmn8i+q7kw+A4Qy1vyl3rSVqnTgk8Vz2gxJbebhRDtEaKPTemsYAE/719xynG/DhlU
         /U3XQKV0yfzXzfP13yiwMpUQMxB46MrVjcwH5pAgkaLclhL3/iPCKlw81FAzFFSzoJ+T
         XFFHPfaOW9A43Xyru8L/zQa2OQsepid/ufDCLQlR3yLtnHydK3c0I9JwceXxscMXQ72R
         Phc7hJu5vgxLhSLw4zvKPjYmjx2XJG6OOxBXZddqrMpiTvPYgDutpUUMf85hMaCh7pFJ
         z4tar76MMRaVh6OMPrVuPIyUUOEAqMl388wvAZcqndbl5sXn6J65LJOBqhAiZVWYYLhf
         JiqQ==
X-Gm-Message-State: AFq9FYKhDOwH7U9CgsaOlhpkVnhyo3l94jrbkPBphIYBe8OYRXhYoQnl
	jLr1f49MWC7uf54gUt3fz0qlxVq7/3cvp9TvkcBWUdSRehu8jtAV8vJHejunJkdjWgo=
X-Gm-Gg: AYBFou2/qOgNk72URzTu1t/Hv1Z/LTdDZrlNniDMLLKuFL1HS6OcVp+BgVIGsRF7f07
	LdNnrYMlRg+4++mJeXVbR9dzgzmSzq1qZAtpeoEmVobnZDYOsHdBNyTAjGgAMRUNUqytheewK9i
	VVjHI4SLcbVAHuq+/KaEWK4xNnCrPijQi/MP34tiDKJ1A+cvkeqAFGW6sO1VIjXhizxDzO9m2fF
	NTyBUOBuLZRAx3pkeXVyNmHNaD5kjJWR+5sDDRtClXzunfk9rz2Fibpfg3dZNwdBlqEbMuAj15q
	zwEE9EiY1R2oKzCyHgvtOM106ycFyBQt1TTZs+UrQQsoFDAOTUn9ecdLpRvP88fOUsNUeiXZW7l
	JC+Q5CalUhRg7FBs17zez6it0KnNIGcBTOGIeWlsMEyrwsp3oKaRzs/zkkZZgJWhzwFcPHit04W
	g2BwCJKSj30Z/CrObBOS8rgL2062Ij0YGhXrBGIICVIAo89PPidBWXL1gcL/zGbMCeB7j5NP3ii
	TVxP52T3iCqLz6IO7SnmYrVnI5sX0/SXd4D2324AUkkDW5WEM9UklkCWeE+n/HcHQ==
X-Received: by 2002:a05:600c:1912:b0:4a0:1e9f:64f6 with SMTP id 5b1f17b1804b1-4a18e3ef211mr65515865e9.0.1791602327650;
        Fri, 09 Oct 2026 20:18:47 -0700 (PDT)
Received: from localhost.localdomain ([194.36.104.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf214a1sm112679515e9.7.2026.10.09.20.18.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 20:18:47 -0700 (PDT)
From: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] emulator: Free hooks in btdev_destroy
Date: Sat, 10 Oct 2026 05:18:46 +0200
Message-ID: <20261010031846.2842837-1-yaroslav.voytovych@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hooks added with btdev_add_hook() are only freed by btdev_del_hook(),
so a hook still installed when the device is destroyed is leaked. Five
mgmt-tester cases leave one installed: "Add + Remove Device Nowait -
Success" and the four "Adv. (non-)connectable & connected" cases on the
LE emulator; one l2cap-tester case does too. They pass, but with ASan
the tester exits with status 1 because LeakSanitizer reports, for
mgmt-tester:

  Direct leak of 120 byte(s) in 5 object(s) allocated from:
    #0 in malloc
    #1 in btdev_add_hook emulator/btdev.c:8891

Free the remaining hooks in btdev_destroy().

Fixes: 37199df506f4 ("emulator: Add support for pre/post command/event hooks")
---
 emulator/btdev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index e00f78288..ecc24a72b 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -8424,6 +8424,8 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
 
 void btdev_destroy(struct btdev *btdev)
 {
+	int i;
+
 	if (!btdev)
 		return;
 
@@ -8438,6 +8440,9 @@ void btdev_destroy(struct btdev *btdev)
 	queue_destroy(btdev->le_per_adv, free);
 	queue_destroy(btdev->le_big, le_big_free);
 
+	for (i = 0; i < MAX_HOOK_ENTRIES; i++)
+		free(btdev->hook_list[i]);
+
 	free(btdev);
 }
 

base-commit: 7428ca2df9356363079db0f48412c20cbdb9471f
-- 
2.43.0

