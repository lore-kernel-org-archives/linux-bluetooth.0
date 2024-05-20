Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECDF137C21
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 May 2024 18:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716228885; cv=none; b=azdTzdV2AWULNnX94VsvGWUDF7Tw4G3FQTXvDCfZkkB7Nzjp/XsHibXuwJdODY9LgRmbED+XS61WRTqiFaSZZR2xAOTbToPS0F8b41YBBJizqb0OszWX0u2pq3MHQKaxzUi7PXL/jD6MMZfxjndVg9pBhIM8ZKPjO5t0UV4AAsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716228885; c=relaxed/simple;
	bh=1bE7ADOrnLOYw/8S/7BH6tNcWo6OXdZp6OZ7Lt4u9Yo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=X4jiZrPJy3RYMAZsvAKg0Cmay1Uu5wk/fDJfKIjAHg0rnaKQwXKGyW1UYH027AYXp/HM7+BKNXsMpG23kt/i9ZyE/JJjeBtpliQ2FoWDTQpPKOv9RRrdL9Zo43VIltWHay3IMAUF+U+TeSqad6ZUpYoWQ+JMyqjUyXiDdFDry28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAfS3sEI; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAfS3sEI"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-47f03844ea3so581734137.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 May 2024 11:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716228882; x=1716833682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HctzR0vSFhNabEnPLnyG4bHFcyN+wQkObHnzFVTr5oQ=;
        b=WAfS3sEIWoZkCHmBKRz893R6AAhE9g+xh7CTlTsHoHnM/FmR2mrR+mClxi+BjGaOnk
         R0QwVAUE7Xoe1jjaZwS+bOSs8RbtKu7GvoTipsnuSjV52c7+KN7R4km+hjXqGIAt6H8Q
         ZYBef54nShpWbmR8WrRGnpU4sjKnpIOJDpVEYT97p+huB/XZitQ5SqL39EFJUgo6cCFq
         WFvF5zhXeausvOYCK6G2xWPH4qVPr+U5f1YPDS0QJW7kskCA7msQWpH7XW9oxo8lcJJ+
         tnUq2lWk+ZHb4V4zFU9Sls5JiMXexECetgszMakzoARolxv2/QsEwHm72zfFNavRQaPZ
         /aqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716228882; x=1716833682;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HctzR0vSFhNabEnPLnyG4bHFcyN+wQkObHnzFVTr5oQ=;
        b=N8AAvyYzLeGutX4UyolwaR0nwxib0vhPtAa11BGfDCVrF2/2LUUHeOqS9iRSxPLsBL
         ksz+BOoWueaIxsbLlMxx4owkv+leExHhAurp5Ijed+FTSp98na+/lM8PCigzVvBlQqHO
         G1t+Ny54hnOctH7yT1/cKmgVc5PqfFQu/8nh4Dne9W+rJInEqFfvrhvGiCzi+dCUj9hd
         6FdS83y+pQ5RLTZLAkzO3SlYiDVe5KWeYw59QFxl1x9SKgllJUtcjkcCaneiqFdHka8I
         +pkpd8EKrRmJ89kXOYiP1jMZxr6zdiZMfFEZCBDoWh3rr92j2+ODsFRqyrba5h+IOtg8
         V5qA==
X-Gm-Message-State: AOJu0Yw3l8gLLOwwZohn7kkG2Vy5NU98TlW0WA41NCWYFKJNTTImWa3x
	TXz9U4LIbJToXgnICQpsq7ZSSRYK+0uiLz92iP5D7k2P/F6O9gW752FQiA==
X-Google-Smtp-Source: AGHT+IHH0pnyQvnhgSzSTEk+8st3ZyP3RoM7q5O9ljK+VVsqsTz5wJgBlFyzN36Fs7EWDrIi1arIIg==
X-Received: by 2002:a05:6102:c86:b0:47e:f116:4535 with SMTP id ada2fe7eead31-48077dca716mr30628588137.8.1716228881233;
        Mon, 20 May 2024 11:14:41 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-7f9000e33fesm3232549241.39.2024.05.20.11.14.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 11:14:40 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/3] device: Add btd_device_get_icon
Date: Mon, 20 May 2024 14:14:37 -0400
Message-ID: <20240520181439.1407634-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds btd_device_get_icon which can be used to retriev the icon
string of a device object.
---
 src/device.c | 12 +++++-------
 src/device.h |  1 +
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/src/device.c b/src/device.c
index 79d8bb7ebc9b..620bbd55ebad 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1052,16 +1052,14 @@ static gboolean dev_property_get_appearance(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
-static const char *get_icon(const GDBusPropertyTable *property, void *data)
+const char *btd_device_get_icon(struct btd_device *device)
 {
-	struct btd_device *device = data;
 	const char *icon = NULL;
-	uint16_t appearance;
 
 	if (device->class != 0)
 		icon = class_to_icon(device->class);
-	else if (get_appearance(property, data, &appearance))
-		icon = gap_appearance_to_icon(appearance);
+	else if (device->appearance != 0)
+		icon = gap_appearance_to_icon(device->appearance);
 
 	return icon;
 }
@@ -1069,7 +1067,7 @@ static const char *get_icon(const GDBusPropertyTable *property, void *data)
 static gboolean dev_property_exists_icon(
 			const GDBusPropertyTable *property, void *data)
 {
-	return get_icon(property, data) != NULL;
+	return btd_device_get_icon(data) != NULL;
 }
 
 static gboolean dev_property_get_icon(const GDBusPropertyTable *property,
@@ -1077,7 +1075,7 @@ static gboolean dev_property_get_icon(const GDBusPropertyTable *property,
 {
 	const char *icon;
 
-	icon = get_icon(property, data);
+	icon = btd_device_get_icon(data);
 	if (icon == NULL)
 		return FALSE;
 
diff --git a/src/device.h b/src/device.h
index 1a9f7e72a00f..a2b7bb15d200 100644
--- a/src/device.h
+++ b/src/device.h
@@ -41,6 +41,7 @@ uint16_t btd_device_get_vendor(struct btd_device *device);
 uint16_t btd_device_get_vendor_src(struct btd_device *device);
 uint16_t btd_device_get_product(struct btd_device *device);
 uint16_t btd_device_get_version(struct btd_device *device);
+const char *btd_device_get_icon(struct btd_device *device);
 void device_remove_bonding(struct btd_device *device, uint8_t bdaddr_type);
 void device_remove(struct btd_device *device, gboolean remove_stored);
 int device_address_cmp(gconstpointer a, gconstpointer b);
-- 
2.45.1

