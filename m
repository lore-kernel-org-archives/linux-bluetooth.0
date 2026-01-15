Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279BC327C1C
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 20:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768510464; cv=none; b=lqKYbBzePy3RHCBJ9lX79R41stNMgaD9B1x2urdr3FQT7gqcCWb4eCupgb6nxCUrgrJP9KZflOwnDtjW9lnzKLQxkKe2X7riTbKPYc5HpqzN8HFXIan3wQ3gWWMLforO25RRjwBpJNbQuhDcii1iaNanE8xBEJ3jdgKwi60WwG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768510464; c=relaxed/simple;
	bh=AJvN67tbyquEmRd1X3mtmK2xt6BdlroDYkq1HuYA/Ck=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tN4DiB69fDrjc9DTtMcmDx7rTOlk2FxL7cVgFw4KCytUgj76OR+8Ce+caS89pZKuIJK8dckpeghxKnyEplJ81U48m8zi3gBRnDsiFSUmWwKv5lD1sYwBiCmuhnxXQ4ZC9zTRK8P6dFGE4qTUCjNTywFVorDyEAKjX8561fcrOaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ap3TAyAc; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ap3TAyAc"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-563686cba0aso477636e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 12:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768510462; x=1769115262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PIZ7ufn7GteL8sVgPH5w3djHUKocRkbDlNxaXg/UYEI=;
        b=ap3TAyAcYIwNlp1oGRRWvfwBlphYnMPDZ9cjCorU5x54O+qHdSCz1/Uc/RlHtpcJlj
         Mt/xUYA0NsgTHyRhkhKpiW9ZmlTkb2R4lgy5p6NpLbSebXZ/sF4FbWhN0rKtkafHw3JL
         cAa7r8AP8MYSd6dv3nVsSK661R99PFmWveKS895hJBl09A+ctHwOb9qeJkX9Pk1GOhGh
         xHCT20Ha5/2XMhBMgziQgOGjxJqxKQViHW5PZfmOH6Wn5fa4Y1Jlf6twfDwqweAik0FT
         VIfE9V5abmR6Kmow54cnCkA9FxxqXoOzj1W7HOgULcPZd7IPn+e0tfpMYbjvMv0n0qv6
         6oTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768510462; x=1769115262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PIZ7ufn7GteL8sVgPH5w3djHUKocRkbDlNxaXg/UYEI=;
        b=teV/rpVCzHDZt1iwcOWlyy2nKIUq8LIsdisIQX+lB8EzVfNmWMdGWqkTvZeXiVz5oy
         ZGcxeUH0QO2KcDvMla4lBgwceMkOcYV3UDuJuyQNjc2lznEGWBOgxpnrWATf7QaRBjbn
         2mHNpVSxS7vK1NX3f5Bd2A6Ojp1JiZuzA8fMJ6IUFNWP4q9QzJLHRgEqUZ5pam3HaIYv
         sDtw7KHLIuDdNJnjgv3VooMHEeolrNMW6pR0vRNYcYJPPkuU89bTBfVPTBad8KArI6UJ
         rKC35/y6jIfCS3HxHSspKp5Qo9maO8LzKBbNSSObBEwYq+wVHRD44emxo8kSowOAR0HL
         WgPA==
X-Gm-Message-State: AOJu0YxQkX/C2DN9EelMukhr6EykrKz5mcr0QeZ50BxBbZUkhI6NgRhU
	Ivxs67kxfCjox2IWB/Eg4U48bLMPByw0p/BkyfXCJibYzUfB+jkqiW4m7PQCxv5X
X-Gm-Gg: AY/fxX6MyCPt5705qSrh0Hq3DKKRvFZRKrlABDLG/2QCZMnBUnZIWS+pf2uwkyUwA6z
	/+0jY7/v3vqsYMBgMDjmlmyeDLj+dmBdQIlEVd5luW/3WOUhAUDg6OdVV9zG2aNSEwMUokFNdqd
	cwIGeNFx9nHF6ToKL2Id2nuS7EotGmQDP2TFLPQ9Jhm8/LYGSGLg5V513CGTMbm3MVbikW5QUNi
	TYUInLeuIa1vYyA3Uz5uwNqK3UGslNiXFAjrZ7YsSZPPnDX3471EWItUEgjynDj2qGYcdlKAG1l
	RNK8od42a8mAudGBaNIlnHgl43zd+VF+ikIZ0UQam2Ja4eRQqe9kAzIoW9lh1ZLHy5zRdmiux3Y
	mLUVBrGvHWj+ebKzU5yOD/0TC7mXe4SezVaqUjo6sA7s+/bYH4lM30+eVZvaPp1PLQtgNDjuoKa
	WBiMfbvyI4Xd5Nv43Ja//U+VWliIzYYfsS4KHTLERP/Z8/M9DfUH4razeumH8yFNegE5kIdHlBK
	CiwJw==
X-Received: by 2002:a05:6122:3c4c:b0:55b:aab:95e8 with SMTP id 71dfb90a1353d-563b5be1bc0mr490458e0c.9.1768510461817;
        Thu, 15 Jan 2026 12:54:21 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-563b6ffda3csm167159e0c.7.2026.01.15.12.54.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 12:54:21 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 4/6] shared/ad: Make bt_ad_has_data return the data
Date: Thu, 15 Jan 2026 15:54:05 -0500
Message-ID: <20260115205408.1554101-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115205408.1554101-1-luiz.dentz@gmail.com>
References: <20260115205408.1554101-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes bt_ad_has_data return the data found rather then true of
false.
---
 src/device.c    | 2 +-
 src/shared/ad.c | 9 +++++----
 src/shared/ad.h | 3 ++-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/src/device.c b/src/device.c
index 0842becde195..af8df5f29b97 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1616,7 +1616,7 @@ dev_property_advertising_data_exist(const GDBusPropertyTable *property,
 {
 	struct btd_device *device = data;
 
-	return bt_ad_has_data(device->ad, NULL);
+	return bt_ad_has_data(device->ad, NULL) ? TRUE : FALSE;
 }
 
 static bool device_get_wake_support(struct btd_device *device)
diff --git a/src/shared/ad.c b/src/shared/ad.c
index 9e21cbf61a29..ac238014bcea 100644
--- a/src/shared/ad.c
+++ b/src/shared/ad.c
@@ -1229,6 +1229,9 @@ static bool data_match(const void *data, const void *user_data)
 	const struct bt_ad_data *d1 = data;
 	const struct bt_ad_data *d2 = user_data;
 
+	if (!d2)
+		return true;
+
 	if (d1->type != d2->type)
 		return false;
 
@@ -1241,14 +1244,12 @@ static bool data_match(const void *data, const void *user_data)
 	return !memcmp(d1->data, d2->data, d1->len);
 }
 
-bool bt_ad_has_data(struct bt_ad *ad, const struct bt_ad_data *data)
+struct bt_ad_data *bt_ad_has_data(struct bt_ad *ad,
+					const struct bt_ad_data *data)
 {
 	if (!ad)
 		return false;
 
-	if (!data)
-		return !queue_isempty(ad->data);
-
 	return queue_find(ad->data, data_match, data);
 }
 
diff --git a/src/shared/ad.h b/src/shared/ad.h
index 7c5d94db0458..71be8727b372 100644
--- a/src/shared/ad.h
+++ b/src/shared/ad.h
@@ -174,7 +174,8 @@ void bt_ad_clear_flags(struct bt_ad *ad);
 
 bool bt_ad_add_data(struct bt_ad *ad, uint8_t type, void *data, size_t len);
 
-bool bt_ad_has_data(struct bt_ad *ad, const struct bt_ad_data *data);
+struct bt_ad_data *bt_ad_has_data(struct bt_ad *ad,
+					const struct bt_ad_data *data);
 
 void bt_ad_foreach_data(struct bt_ad *ad, bt_ad_func_t func, void *user_data);
 
-- 
2.52.0

