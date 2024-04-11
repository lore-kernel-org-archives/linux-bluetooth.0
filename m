Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00E813790A
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Apr 2024 18:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712858850; cv=none; b=A5kUErytdYbdSPWALjm88Y6eQHGy+2nXG7A5jdgR4mhhODqv0WO3t1/WytYH9OcenrorHOX4Q0FcPOyXagp57W/DJw7W9wPWUxC5VlgW8J6R5BkkT7QjOeTifJpZkZ5bb3JNKZ54gSmGNv0BxDlgjcufw/5/4A1bhhS4kKN5cFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712858850; c=relaxed/simple;
	bh=LMFPVJf139a0wduO1eF0t+hakDsuenH9PZx5QV3puXg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UqRxNGfbOLuVNzGok/1KI+4h9nah417igWpNfiu4UmJb9U3OeaUONo6l0utOUBvIzwezfcAHZhUCbS+kagEr+F5KkpJDwUoLPY/vUOj/uVi1TCUqJT356kQNyMToPbIhk9vQgLUkE0aTneIedGRiGAqnoFzWt7zOvEAsQUFLWz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKG88hw8; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKG88hw8"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c61486d3fcso25003b6e.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Apr 2024 11:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712858847; x=1713463647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LIvfY2P2js/Mn1HiN2qEldVKoXzkLk9p7C/LKB+J86c=;
        b=RKG88hw8VThW26tknBa18qCCPL9J8Kql0UGWD+WeISq0kRnncKcZaHwqtYId9jnzvK
         t7CWiWW5usxIE3nX+qUZIOdEoEsuVpDvl6P9Jfo/DuyBT8eQnLaD+7YKuAoUyVHXRSgV
         v5XSlXdGp+4pk9zzn8CtuurKEGYYuG54cwT28mnE3xg1mdN+DuZCdKne8NCO4v4fYSXY
         cjNl++igDD3FEQoZuyAlogxX8WASizghM8Uy73f6KBTo4RoZOYFGu3JIA+SKKfn5bZ3m
         9YBKG7ACCNzyuUFwORzLBc8W9Lv62BnahiSMWaRa9qfA9NOBPhL07gnB5M5iGTrU5XWc
         95BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712858847; x=1713463647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LIvfY2P2js/Mn1HiN2qEldVKoXzkLk9p7C/LKB+J86c=;
        b=ZsaecRE0PW1pQD6E6Af7v728yD/HxsJfkUjYB1v52IWOTkbfIJnWZ8EW9gu3gDoBCD
         BZjQpKUj6+HM6NBQRyS42s70tnvPc0pk/RNJIp9XBfb//AUDkCJKSB2491/xhsyTyvhy
         SEbFNUxiSGWl3w2Rg2iPPZBwdzBiHkMesoLssj8QCrxAjexwokLSyIab8ivqBv4QhwqH
         CVXme3S4zrJwPsEnKNpNMs7lA0UFirr76kYzLPL4OBNlh21YZ8LwS3sZZUHtVsJKiupr
         PhFbGAHhlOORGauRoBNNaXBzIcn7S+3pbEx/ifTMs7l61+7Q7kPrrlePpAIQuHhSFjfT
         t0aQ==
X-Gm-Message-State: AOJu0Yz/QiP2nL4MqyWbdWZ06KMM+FDRDhVN6hZcvhOUSwSw4176R5ZR
	JPtyl3fHqwY7rnmdsgZCwNyHOpXeEDp59GI4XziQu08GkpqpplqH46NjXw==
X-Google-Smtp-Source: AGHT+IFrIaYVFNJPaZwOgdoJbectBMSK0wLHZ+EiLyO0xFfEnWryzPLEi+YU1T4XQQyrOaMOT1fNJw==
X-Received: by 2002:a05:6808:982:b0:3c6:998:e304 with SMTP id a2-20020a056808098200b003c60998e304mr430974oic.44.1712858847102;
        Thu, 11 Apr 2024 11:07:27 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id z4-20020ab02244000000b007e7b2f8e0b5sm225711uan.13.2024.04.11.11.07.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 11:07:24 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 2/3] shared/bap: Make bt_bap_select fallback in case of no channel allocation
Date: Thu, 11 Apr 2024 14:07:20 -0400
Message-ID: <20240411180721.157181-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411180721.157181-1-luiz.dentz@gmail.com>
References: <20240411180721.157181-1-luiz.dentz@gmail.com>
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

