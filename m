Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D42214D456
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Apr 2024 13:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712842778; cv=none; b=h/3EAEpDSGDLg7O4rw0A8lLTS13KEeDcsnrS95DBF0Kqcn6Ie3O6qWJdjtXuR98TwFrmoIYPHEan5gAich3munbPdL4o5VE9TVMs4hY2NKvyv4GgrcrD/zws00efKd9fUBpm0oi0TZqpngoR1trSJadABCgWJET9B0RIWpkHN9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712842778; c=relaxed/simple;
	bh=uGW8/FMRWXjE/nAQfYCQHNRcHQmpZXnzVrVpRregbSk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mAOEBCQUEdtoQ7hUeL/afLvz4wPml0XbA9dfD5fwTVLxtPm+wauN9CRFQyjZfOLvqPUCu82l+xsiP/pW+pQ37KJdVyxPbuKhTrClnZXpiW0rZJv1oaWjOguBDUWYc0T1mxlm76KUs1gWFGRmTro9zsolbGHARy9ptuMj4Iz60uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USnvDfIE; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USnvDfIE"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7e6cbbc20deso1429271241.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Apr 2024 06:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712842775; x=1713447575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mEicXI2HW1zpP9FBpdDgWncBq7v9rc6WBL/5xRW3AEY=;
        b=USnvDfIEDZXuxLzJnA4FyKAKdNrs9o4JdhOZ1yTpfXH6yCfrWqz3peLusqpYgC5ipJ
         3oLGlWu0IvXZmBwd9iRNwZA1+E7koDCJsF8sDIG7pDiNZ6WvmY4LW9IaAV1+9psf080F
         AtQguOqFIkTpGZEaq5FzJ0wvGoUA9L3K4uR1zjKxpJRNTZGlc0w6y2o+O94K2tepDFVK
         lvHKuwLPID0tMEQTJBkvmKL3NMh3uRJcLNZHHhWXUA3c3ZmR9Jk4GfahDHDdo5pTuv6J
         dgLQqh5n4yNuihfoR1W/u+Pjv8rcLderH0Y1AGin12hbKjGhESayzKHlFrKtE7BWto/Q
         Crng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712842775; x=1713447575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mEicXI2HW1zpP9FBpdDgWncBq7v9rc6WBL/5xRW3AEY=;
        b=iaPqSxD5nSSSa1aZFRVWab10eHrgCsYAd/bqlI4tDSH9ggFo/H5AYSUYn43ksRP1pE
         wbOYXQIiNkFZ7mQek0QN+WeYDLWHaFZ5xcd+WhowcsImgcecV7YAtxxsjzY1L/gCZwxm
         SvphUtBnULAbDfVRkllOu7h1fewodBnu8B81LHfIAU1ap6q6ADZ7pzvEtHqOHuQlznCl
         Z0HHqRahRWupI2iTT/C16lk6BhLsjnm3w1u0EzclDr2ue0AGQLgCazKol0FwX2h+6wh6
         FR9TEAElV7u1DCwV6z1oxZNz8kHUUKSCJiw4ZXzhbNvoDDbQQMiRZnGXp4O0byDYKMst
         Ysbg==
X-Gm-Message-State: AOJu0YzrmFE0vvFa9z68L1comevBsfwSvktOwWCnyX3A27kLKSgBoeID
	FkJbg4Os2WbAjOFmph33j1sg9/DnJ0uoVOLVe9zuUM89yfvZGU756mgW5Q==
X-Google-Smtp-Source: AGHT+IH7xFlWt/oi6NX9Cu71gT0K2odltgngCXR5nAKrsKjIGp0q6YU51Ewg1aY3xw/tKiEhubgH6g==
X-Received: by 2002:a05:6102:2ad3:b0:47a:38b0:79f0 with SMTP id eh19-20020a0561022ad300b0047a38b079f0mr1649087vsb.14.1712842774960;
        Thu, 11 Apr 2024 06:39:34 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id dd2-20020a056102568200b0046d2de55f2csm217918vsb.15.2024.04.11.06.39.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 06:39:33 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] shared/bap: Make bt_bap_select fallback in case of no channel allocation
Date: Thu, 11 Apr 2024 09:39:30 -0400
Message-ID: <20240411133930.96265-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411133930.96265-1-luiz.dentz@gmail.com>
References: <20240411133930.96265-1-luiz.dentz@gmail.com>
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
index b452461ac715..5368115565fa 100644
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
+		*count = selected;
+
 	return 0;
 }
 
-- 
2.44.0

