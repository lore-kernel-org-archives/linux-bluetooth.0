Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CCD205E11
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Apr 2024 20:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712865793; cv=none; b=pIvukcxjfVNjaCdSv9/rpHlOEik9c/8KxBjTXcwGM+Fm76fnMyCQecUKWPtYViJSiJWYgFHoNj2YawEfRHElpaYzufReNVLi94O2uhoziyhBePU1bcz3J0JCovUwCEHIEirlXkae2sCdb7ixj/z727BMkwDWGsTyl+yOfHiYtX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712865793; c=relaxed/simple;
	bh=LMFPVJf139a0wduO1eF0t+hakDsuenH9PZx5QV3puXg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SIl42f8gPdlcJulMLdibZwd4dfAD7xlGl6a45pt+w0acFcbFuQgERX+px/o/TMKVeDXsDimymULjMUslDZBtl9ZpILZ8FVqg0uZ5r/hXBuKuMRScwfmYsFKcHDoDBTx/JMaZh5BYWHE3uvFYT3yfOscXC6Lpq1komZSmH/Lvq8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fR8xp3qk; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fR8xp3qk"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c5d5de746cso59958b6e.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Apr 2024 13:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712865790; x=1713470590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LIvfY2P2js/Mn1HiN2qEldVKoXzkLk9p7C/LKB+J86c=;
        b=fR8xp3qkHKCk/JV48BT3A7mjghMpUUh4MGfpcPjM+j7R5DRkcxhUmMk6zvowqpvvCJ
         ZjgWZTdA+O6l780Y24dpZqhnfOoD17L0RNcqRxKwsjGUNZLLl2mRCp7io9AAqeRxQDqo
         PwOrKic7uNC/pKzFcpi1UMZDPvwUWqku65D1Oam4yFZdEEY/CtzRKzdPmTNqKNDXsvN6
         A91pZzK+oP1pyIJ83vdUGVz9kbhWRaypET1OGeECoLIxVPIFbv5WiozIPWgc1lJWF6Co
         KzezziCgzKtXsczsky/F+6n+dgzFsBMDGWJ6x10BOgLFfKlbeSRuI5gGxXziEtWwk1lg
         0Tnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712865790; x=1713470590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LIvfY2P2js/Mn1HiN2qEldVKoXzkLk9p7C/LKB+J86c=;
        b=SUzQOgopUqsQ67b/bJYI+faEH8QU5vUB+fL3p5YIUtT/Fh6Yos3QLff5nQnnGLznpc
         Kr3DklCI57I30/E5TTVbfbJsLMTVZJYZGj96PLh8X6R97FSCE4WRgHSGBTATxqGuqNc7
         ORdQtWaWWKEdwnhrd37aDHETGAMAlzGZJOmrdBC+xbEVgHT9HDzJs/xcqO0rFMy9J8IL
         5J3p+E4JyGOzX0KfSOeuV93wm7Mj5DDgcNG5hrGP5Pj4ynYgUDyVl8ANRIOA4sFSotsZ
         RBVsFyMxe9dbvfmkpjXWwjHsXck+i7NXR4CAxkGMiwCX9d76iCBzqzV+GQQb2yeJ0R2T
         0Gyg==
X-Gm-Message-State: AOJu0YyvR8v4aNV6lp8Xip1GOulXIHMxXGUkCawhPtEOUWOaK+Cwr9Ov
	9OzuAhbAIpqChx/27evtdFxkJ3hPx1whm/6IppmOAlLWOwS8Mb2wCj1imA==
X-Google-Smtp-Source: AGHT+IH5W63EMhuyJnBVf+j4ClPFs8CBfRFevIeBsT7qBJ+ZHjTaDYMK/ppsgAhn+mNni++FEuIFXA==
X-Received: by 2002:a05:6808:5d2:b0:3c5:fcf4:2216 with SMTP id d18-20020a05680805d200b003c5fcf42216mr668025oij.13.1712865789882;
        Thu, 11 Apr 2024 13:03:09 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id da2-20020a056130230200b007e6b31e535asm268110uab.29.2024.04.11.13.03.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 13:03:08 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 2/4] shared/bap: Make bt_bap_select fallback in case of no channel allocation
Date: Thu, 11 Apr 2024 16:03:03 -0400
Message-ID: <20240411200305.183703-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411200305.183703-1-luiz.dentz@gmail.com>
References: <20240411200305.183703-1-luiz.dentz@gmail.com>
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

