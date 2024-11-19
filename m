Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C2413C83D
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Nov 2024 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732034258; cv=none; b=iKsmsHdDI5nhIAUlLMYDcFcR+CbbtFaQhfR2f/ErOT1zobflPPypMOjZzqfgz0lEdJ2e/gXm0aydu5Kbs8GkldxjvBwl9pojakVXICQR5t4B8jhTzj50a/LvCdNeVOs1CUwit4GICd92e9AX6V5FXIvfeDDtldnDVqv3HJZcUFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732034258; c=relaxed/simple;
	bh=4mAdIHasTa0M/Z4A2+Vr4fJzlXo3fURmQd33BVPkmmU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=VRcTX92MEcfYs1coqDoAMMYRe+Gq+xRyLyD+Hl5sYOFx+G76jgiif3VpAfBQMK5jbjlFmMuVkJmOasxH0psYwV8/uM9PEpdSrdGCqah52DB/YhAYkMYAxCO7BS2GYx82YC0MdXrPbUv923/YC8ihI2xwyL+xz9WY2LBgrlF5EgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEp4NiB4; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEp4NiB4"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-857004f7846so1011410241.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Nov 2024 08:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732034255; x=1732639055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IR0HL+1n5dfggbHGIivUvRuUdxexR6Csn+7bcVkbIHM=;
        b=nEp4NiB482IA0vqtvYDsSi1dVVVkjRGBg8DpRcFbfMBBxpqREmvsHD2LZl9qLY1pjO
         wre7m7cEsiaiMlif/Px+OdPU/bDxoLQw8Xygs0NBNgRwjvo7dErY+8RfaxORpufxnShP
         plqfsqgjXRTGn/gPekY5W9za9uXfKQ9B9uIFdFNA+m+EZP652SsZgJsrREZsnmvRJiHW
         UqQ4T/AkX81WVYPWF+i4m5pJAg8qUfpIxFzMhziUmpeiUmQ8Ps4yeSF04xdVdi6ilKeJ
         3bVmodXRqvn6Odvp/boD4l4VyQzsD7f7zERLOWSNx7YZGg58QESzaYn6IkbKDcrWIP/4
         Yfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732034255; x=1732639055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IR0HL+1n5dfggbHGIivUvRuUdxexR6Csn+7bcVkbIHM=;
        b=XDvVqab5cEc8SPTjU755maEWvSb+dqM2uEbYTpmwro9cC3GgQY8oqXGEwgk2ewUsL/
         koJaNCbbaUAmJySSWo7/03ZU84Gf/pCTkzZZModM/YntGYPgtcKBqhtdK0WNpsWfKF7H
         jkIgNwg3nEldknyVlS3t2RhyDUR630q1qW3UugLU1w9yRaG1HuYQqZXWHisTNPYhXX38
         XhiF5dFVMojw8T1iGRwwqxt9k8prfjTeyFijFtmFw/xEeAYdkwQ/h3eShflH/60slJxl
         r2/huUGuYkHFM16qTxOICo2WeVYy9UVWFoyYzGg+RbxR6N9bF8UG4+l5o66RloXzagk8
         gu4Q==
X-Gm-Message-State: AOJu0Yzi3v3D8qMUwuzpqQYC+5PHBIW+b6e+O4YObyr6i6Ysd1P8CJOJ
	wsRkrgLEKAreq7iWJPcGipv+9+P2Qq2wsSBm4e7tvB7ogkh4+ZiBHSPQNg==
X-Google-Smtp-Source: AGHT+IGgy9Ts1tTbh8HkMFFZM8Gmppys+nEopRER4F/aGlOw5eLDDN12Q9/R537WACWsPVwuyNeTzA==
X-Received: by 2002:a05:6102:38d3:b0:4a4:94f3:7de4 with SMTP id ada2fe7eead31-4ad62d19b6fmr12956655137.22.1732034255365;
        Tue, 19 Nov 2024 08:37:35 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4ad64bfdaf7sm1501457137.6.2024.11.19.08.37.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 08:37:33 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] shared/att: Fix failing to set security level
Date: Tue, 19 Nov 2024 11:37:31 -0500
Message-ID: <20241119163731.2767660-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

bt_att_chan_set_security attempts to set BT_SECURITY without first
checking what is the current security level which may cause errors
since the kernel does actually return -EINVAL when the security doesn't
change.
---
 src/shared/att.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/att.c b/src/shared/att.c
index 4a406f4b91a4..dabbdb4315eb 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -727,6 +727,9 @@ static bool bt_att_chan_set_security(struct bt_att_chan *chan, int level)
 {
 	struct bt_security sec;
 
+	if (level == bt_att_chan_get_security(chan))
+		return true;
+
 	if (chan->type == BT_ATT_LOCAL) {
 		chan->sec_level = level;
 		return true;
-- 
2.47.0

