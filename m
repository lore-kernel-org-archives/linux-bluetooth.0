Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C9C155308
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Apr 2024 20:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712177618; cv=none; b=JnwmD66+JvFB5HMnMiBiw6QRZrcxVCkdAZUQ2bXlIjDw37ezIRe+plWncfFQKR3xnz5gRLiMTb+whodeOuUZg+DbotecLpn/X1ZKaKUqUhEfczTyDBidB5l9g/jPwAkRDqKntVMSDI9y7/djK49PWHECAG1e2tnWEasjaIdJDMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712177618; c=relaxed/simple;
	bh=9HzVdjQZeDaERvS+O8hLDO0TuDAcN+qO3qghclcDs8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J1LaXb0baEGAjLvHMCS5PamS5ZjZtSBcLYK4LHAbEfwIqF2cdLvyzxe2wH9T91ULdjtVy7vKWnh+j3uD/upYzfK1cJTyRXpEfEhLwMBPny/zvNxCqDiQY+yeRUFoYqILLfIBjrnVPgwkG7/E+UaQ773/fMUyxairAGhWYZLpR8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1r7oWor; arc=none smtp.client-ip=209.85.210.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1r7oWor"
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-6e9e46f1e03so192239a34.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Apr 2024 13:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712177615; x=1712782415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZM7NYmbNFGuuitsr2GdTxedOdMGe12XpriNd7vDP4o=;
        b=Q1r7oWorwPQdNBvPobrD9kw5bOoKo0laju3SYTez6A+iCvoXyxlXQIWS0iUublrme6
         vYrZU/ZqtgDjqpLDIHbkwaBlDWoOhFwFTq1nO8NZEigJMMjIEKK2M7wJCdB9sigVvn0g
         ELCBquC9NilCSEpTcbqix+7k/vGD3Ez8MPZrCcITSX327q8NlQqf8NhfJFnjJ+9bjyG3
         O2kVGsbI3OIESqWod/4TWdxOB5WglJ6rzXgeetl5szn6BiNJ6vmoGsSnkNeYqD1qOGY/
         X5mcXiI3/VSmJ7bFkGZ06ph/WhH0om7ZHS46kZrfUrp8ccIpk6uTZlLJ2J3rRaj4Ur43
         y+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712177615; x=1712782415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZM7NYmbNFGuuitsr2GdTxedOdMGe12XpriNd7vDP4o=;
        b=FLyFx12BppjBIs1Y6Yzegt42RpISxjvXoCB7GSWYHmb/84DjNtG73gdfE75XVTyxsK
         OFCyePdJdUf2kHYoxfM38K1Go4sBpbqgyHh/0dbT8pxKY5DIFiJ32mQzPqiGqfPQSzg4
         zyCeRrEsJRO46rWqLfhScKnLBTUQA46zWBVJpi62fx4IZUDUCbIuBv0LGozPgk9qe4A6
         +fwTdbdDlV8UqBiObID+7caIMSsIcb0o+akJnbfnXuD1f1acweOIQIwJvocBVt71/gTc
         /bOUtNcNqh+CpyuNYGnnIjGlIkNhaSxK9Jkc/1RAY1Sj46BzUp2nVbIv0P1afi9GnHTK
         NDDw==
X-Gm-Message-State: AOJu0YxjzIbBQ2RAcVkRfIglDdKiXS4/q+KHc2RZbj5fIC5+rbIh/l1W
	1Tvt9JeNdAEumFxSJ/uxjB4MTSl13INl2iy31Ft0KtrEingkl63bA7xpyG4KuvC9TQ==
X-Google-Smtp-Source: AGHT+IGzije+nTunwXRBOZFa2YRF73aWn38Y2H4HbWJfeOGf5+k+dcv6TLL10l1jInRG7L3ITI78AQ==
X-Received: by 2002:a05:6830:348f:b0:6e6:ae37:3287 with SMTP id c15-20020a056830348f00b006e6ae373287mr520739otu.11.1712177615634;
        Wed, 03 Apr 2024 13:53:35 -0700 (PDT)
Received: from angua.lan ([2600:3c0a:e002:7f00::1001])
        by smtp.gmail.com with ESMTPSA id i18-20020a63cd12000000b005e438ea2a5asm12159259pgg.53.2024.04.03.13.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 13:53:35 -0700 (PDT)
From: Dimitris <dimitris.on.linux@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dimitris <dimitris.on.linux@gmail.com>
Subject: [PATCH BlueZ 1/1] Revert "device: Consider service state on device_is_connected"
Date: Wed,  3 Apr 2024 13:52:52 -0700
Message-ID: <20240403205252.71978-2-dimitris.on.linux@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403205252.71978-1-dimitris.on.linux@gmail.com>
References: <20240403205252.71978-1-dimitris.on.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 44d3f67277f83983e1e9697eda7b9aeb40ca231d.
---
 src/device.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/src/device.c b/src/device.c
index 5e74633c6..de5f94c7d 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3273,11 +3273,7 @@ uint8_t btd_device_get_bdaddr_type(struct btd_device *dev)
 
 bool btd_device_is_connected(struct btd_device *dev)
 {
-	if (dev->bredr_state.connected || dev->le_state.connected)
-		return true;
-
-	return find_service_with_state(dev->services,
-						BTD_SERVICE_STATE_CONNECTED);
+	return dev->bredr_state.connected || dev->le_state.connected;
 }
 
 static void clear_temporary_timer(struct btd_device *dev)
-- 
2.44.0

