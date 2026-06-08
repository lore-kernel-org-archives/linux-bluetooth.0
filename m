Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B245F25782A
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 11:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780917638; cv=none; b=ZF+KvTs9I27ycCzP/ImTFQrwPCMiL3gqLlVDoNn34bbCmTuzvxICGmtt9H+SU5fwiCF3wRKMY+P5PvdkKpnbHoYFUe/OJLP9EYF5WowYeQWIt0Udc0bMZGaew3Vc61f0tObMb+oWTMsUCbC0xa07rtxdaImbZjK+vLuyOZadvZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780917638; c=relaxed/simple;
	bh=m4zhwM36PJ9sxJ4e5ZOUq2QIB/YL6VSaJl7IeFjUM9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oPyckRO+phUtPc1zM7esy6cocKTJwPD5NELf4EKXsnwUQ/YwuqtJuVnltCd1lxs/knPvIjMJmLjdk/9unI2++Q/Lzk3ynAHwEFcTDBEFPZHwFJxDAQCunEOFe7FIh4xP8ep1s1cU2MTnVv4xeScahdA9kyolBJu6dGPRB4Ts2sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=Plrq6JZA; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="Plrq6JZA"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490ae94a89eso34509785e9.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 04:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1780917635; x=1781522435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k/B1LxvX9nP/MbBQXWJTrJg8EbOk8suOHKeCfP94cqg=;
        b=Plrq6JZAPN66TjLJ48lIHNotTBi+qa4MVlsL2EenaOjLqcNI2TV1KfgzZyPJsAzF4z
         YaaTRgR3u5is64GZ0pYcuSJ+NwDfxEb0dvk86TtYCdxE3g2b+zi8IxgGXtecmxtd2U/L
         WK4hR/f+tSvaVKNEi58l4IuXMnqLR0e0z3I7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780917635; x=1781522435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/B1LxvX9nP/MbBQXWJTrJg8EbOk8suOHKeCfP94cqg=;
        b=JTnZ/slVS2JlyQ/TmOGm7KV2lHKIcGzyYuTR1dWAsSN//NGTp+fG8R0ysOJ5MN7fSv
         2t82alIQASKn6+8iUuqX9tWPPvdRm7bVFyZ8qM9GyvuPWOOWprF2izrXNQtcYtqTx3UA
         mGT8BCL57xU7rZcZ8c5W35g7RS2+FXlmDCgxdi7IwTE4UgOvleNUDM02h7ZauIjFvqwO
         E5VxejdJ/YmYnZ41P0oDtTbQa+9H3E7pzCgVMkLWpYsK5RStl9qthPkSr4dqMh3eavzo
         5K2wiYxkPP/qzq2x5WDbBLMxtQfyDNM4+XRhTWg3zcjBjY8Q4DUprP3AtMmfC/JPStcf
         TDrw==
X-Gm-Message-State: AOJu0YykkLLkyVwhQutj6nwDMPoBu9l87hL0OL1GV8jsG6EwkIlHyLUN
	7TG/P7uznBr0NYd0rCxRrj4FIx4YkqY6in3JmEzi5vfaCw+adc9WdCXDOEzfeUYO0ItLc5QlrFz
	HVxD+
X-Gm-Gg: Acq92OGhKj0t2m3knQei9N47DpQygn4mJs1in89dtkXFGWQkm8p7SUEEH2QiNHXU0Ux
	IG/8/W12pa1HsH2ogCcel79XoU0KsnwDgb1o1//ZEBd3VUF4WX07xJXym2nKHN2Cg4afprdBp9z
	ZeXe2HsyZY+xyYmeOU/fCyId2V41H29dDWUePkeeli3ZyMMq9CL8mrAaqN32WM9u7793lIs1hSC
	f/B54ZD2Z2Oy9NTYHT5M8jJ7EQImjNhu1VetegOekeHWnnAG5CK86Pw+FRQBFXmihXJOdmobeMD
	aD7mQ8NjGlrIp6hjYOEyl7ZLYVgQEHSuNGKuwfUjSsHgbGfhvoVHNm1Jncd23cR+ykYxdxXu0pj
	Z0eMs6iMPvyPoHYPtOXRIen2JSi4CdgfQqTJYm9f/4e44yMrbDy3JxPHOqG6RtOLdM4tInrqJ7G
	QHCM/a5RlEOBhClwVY1xdU+0E+wNSvbOH+SyNbhwmFIr1MgyR5lqxM2w==
X-Received: by 2002:a05:600c:3f1b:b0:490:c0d8:d517 with SMTP id 5b1f17b1804b1-490c2598543mr245664575e9.3.1780917635060;
        Mon, 08 Jun 2026 04:20:35 -0700 (PDT)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:2869:769f:34b:70a7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3b5b82sm418558465e9.1.2026.06.08.04.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 04:20:34 -0700 (PDT)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ] bap: Fix CCC value for ASE control point
Date: Mon,  8 Jun 2026 13:20:28 +0200
Message-ID: <20260608112028.3686726-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

WriteWithoutResponse was missing
---
 src/shared/bap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 8fc2fb14d..968b85730 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -3776,6 +3776,7 @@ static struct bt_ascs *ascs_new(struct gatt_db *db)
 					&uuid,
 					BT_ATT_PERM_WRITE,
 					BT_GATT_CHRC_PROP_WRITE |
+					BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP |
 					BT_GATT_CHRC_PROP_NOTIFY,
 					NULL, ascs_ase_cp_write,
 					ascs);
-- 
2.43.0

