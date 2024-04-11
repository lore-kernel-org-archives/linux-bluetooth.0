Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6CF84E07
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Apr 2024 16:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712853048; cv=none; b=mCDktv6EzqkRH3PE58PERiIZpCS7WULPCM9+m0rLCnS0iyI3RzBELLuE8+omEuDDtbA03fApTDsjtSoji2+b20MRB+yplCyDGzHgBldi69tcqD6a7peB/XEMvbM/a4xQ0sTB9dUlx1vfXuGhgjQxwFnNF+0JLWcVnGrgjAmGHC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712853048; c=relaxed/simple;
	bh=LMFPVJf139a0wduO1eF0t+hakDsuenH9PZx5QV3puXg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJ0KMhYWeXbi76rSZAkDmTELPdm4Vs/4rofFVAvT0t57/JdlS3NXa0QXLMzI6iUA0eRjnKw2idTspVVq2hJkXQ2gVYq62qexy93+AYcfDGF0tPMPTIWKb+Hlxhd8lkgcZFgF042b3NdqU+wT5oQA+6jNl9Jvt3D7NVjQfXa0Q/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fVCMVvLc; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVCMVvLc"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7e7b787142aso1262241.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Apr 2024 09:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712853045; x=1713457845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LIvfY2P2js/Mn1HiN2qEldVKoXzkLk9p7C/LKB+J86c=;
        b=fVCMVvLcR2sB1Duwh9HHFlc0I+d8TbypQBMc2gEHsJmCmEa1K5y0oioone+9IfIluD
         6vrgU4cqdsJG1XRqbfOxEPUtxXaafdSdiGS+TqS3kGiCbabH927yybyLOMnDFnrMTjSY
         Xx42oEDqZg9/YbvQNbDNyTlKOpVXKoG2hPgaHLeA4FmonXgD5phq2/5CYAxklaPik73E
         shnFaOerR5a3Bksd0vwKm89FJx5earv7bgkqLlvpcl5SFsuCZmuXvbnQ5vtJlzdkLp8V
         x62RJT6YRjtXvrqB5oDNNpIUarsmcZlHbo3bCYGyCgRjgglPmHTBTEPNsBNVfFIMj+Y/
         JlIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712853045; x=1713457845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LIvfY2P2js/Mn1HiN2qEldVKoXzkLk9p7C/LKB+J86c=;
        b=LjpLCDPO6UpLBjZIh1Q3SaEhGUg0HViyNWC896X8t/SFDPZEQxQC+LfeO5dFYKDhgx
         +9GqAZEHlutgwdMUe56hXaqlo1F2DXG8Hsd04I/R/Wn5iSy8jbQSm37ITT4s3uJ2SBAL
         /LFaD7f3MuYTGTi74Iamsy7LI/K/lcK8KayubT+92XMowGSazLdoIbkchDBKW6KpoG0q
         zwTX46Dnee7XJxV4TJ4dLsViyFMzzb7fyZqDji4FS3EMD34KOZen06VPc2b5OvkEa58x
         GFAZa1F79Bhp9XUTb/bwZpUahtftMG64dJ8COt9GQ4ePW34gKCVHGrCixyKfPHzM1XUS
         8u+Q==
X-Gm-Message-State: AOJu0Yxdc7yzekMdzl3/QynPvaf7R/YbQfPm3e0O6/oVEhQqDt4aZ/t7
	H7Ev1Ek/orPIQqvFAMNozhlevYV5CmVly2AL+zlHqgeg6ctcxbjOG+EYYA==
X-Google-Smtp-Source: AGHT+IFZzOFCHavsCFoT/8sz9rwYHALaSnzlj4ioyYRTsMsf9ztaP5QkrQafOS8UYQL/QL8uVwqpZQ==
X-Received: by 2002:a05:6102:41ac:b0:47a:2cab:75ad with SMTP id cd44-20020a05610241ac00b0047a2cab75admr452528vsb.14.1712853045445;
        Thu, 11 Apr 2024 09:30:45 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ih12-20020a0561022d0c00b0047a1d8d2230sm294159vsb.2.2024.04.11.09.30.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 09:30:44 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/2] shared/bap: Make bt_bap_select fallback in case of no channel allocation
Date: Thu, 11 Apr 2024 12:30:41 -0400
Message-ID: <20240411163041.130214-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411163041.130214-1-luiz.dentz@gmail.com>
References: <20240411163041.130214-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If channel allocation could not be matched attempt to call .select
without a channel allocation as the device might require a different
matching algorithm.

Fixes: https://github.com/bluez/bluez/issues/793
---
 src/shared/bap.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index b452461ac715..cc1fa1ffbe32 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -5116,6 +5116,7 @@ int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 			void *user_data)
 {
 	const struct queue_entry *lchan, *rchan;
+	int selected = 0;
 
 	if (!lpac || !rpac || !func)
 		return -EINVAL;
@@ -5158,8 +5159,7 @@ int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 						rc->location, &rpac->qos,
 						func, user_data,
 						lpac->user_data);
-			if (count)
-				(*count)++;
+			selected++;
 
 			/* Check if there are any channels left to select */
 			map.count &= ~(map.count & rc->count);
@@ -5175,6 +5175,16 @@ int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 		}
 	}
 
+	/* Fallback to no channel allocation since none could be matched. */
+	if (!selected) {
+		lpac->ops->select(lpac, rpac, 0, &rpac->qos, func, user_data,
+					lpac->user_data);
+		selected++;
+	}
+
+	if (count)
+		*count += selected;
+
 	return 0;
 }
 
-- 
2.44.0

