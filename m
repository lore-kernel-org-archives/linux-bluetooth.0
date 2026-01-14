Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73183A7DF5
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jan 2026 21:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768427397; cv=none; b=c6pi5VFlHUQNnvVnfj4mvdBj6dv/X1X4TFRkxChkFs+6TdeHq+cnu5/ryoUyOszMCT1C9aNm+qYXJwsPSLXEyNTm5LKAhgf7hYnUITMfWSquDjuQgN/e+c06EDYNTHkZPJm6kiONpPeYmYVypI1IUR6ia4/UvkEaY2Yuuvr2zXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768427397; c=relaxed/simple;
	bh=AJvN67tbyquEmRd1X3mtmK2xt6BdlroDYkq1HuYA/Ck=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JU4S06+TCG2UWfc6CLecCEp1jzWHYkhJ81ctn5YMOg0mxzR0v1oXBcPpWTJoW4LCN+tMh41+bZ/O+HonpfRnfqUTqAmwZe6OG3IX1YD8eo/1IOnALVDyCrH/gLKdfoQFXdOqmLexxT8N+/TLpj5oGo5KxCoNnk8vuAGsDcnErj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAr+mKZt; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAr+mKZt"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-93f542917eeso125697241.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jan 2026 13:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768427391; x=1769032191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PIZ7ufn7GteL8sVgPH5w3djHUKocRkbDlNxaXg/UYEI=;
        b=GAr+mKZt4X838HaJfEidNB65BCoTRz2Zy7ZGFqRo/V6vXHucGR0eeL6eR2d7Lk+GpV
         Rd9FR0j6goiQRcyJMkBWVUNsr8g6QPXwPifDKa/cCTvMCF5MwsZlDFSa3PJQDuWl5PeE
         YrIrDx11cFxb7uX6TLj3MWjpBL5acyrs5UQV7lUaqAcXyK+IxjnWnhz7Y3l01n49JGOy
         XCkyKbtTmTkGMitB5husT9WqswiUlg26CGtLXDAAPgSBFljLFsrtdToTi0Lo/VM31HnV
         saba9ALnQCmU5q5/kTW9cvNAOT1DlTqOf/sl0KUnOD4IAh4MYOBNRHD3Yuu6l3VgJsRp
         zC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768427391; x=1769032191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PIZ7ufn7GteL8sVgPH5w3djHUKocRkbDlNxaXg/UYEI=;
        b=bHdW+GTh/8Wtg72gyaLO/TtkO/liprFvArnCYKrCurySyw7dtSAUwiWxoNvzgKrpQ3
         JxifnPObrpgqK2becjc4YDeMtyYA2+yg+X84Dud8VPMah40BlGzUMzMSUl+GtVIO18Gs
         7IUQKTJE1ooUw/hygcaqH0ZSamAujve34HFVrb2bOwACg3Cl/t3NEBNXtpx4To1UCP5j
         pqLA4MLolc9ouAjqqjO1ns2Z8kO5Zm1V1pTYWyrcWhMgAy0AwTytlOMt3HCzB9HrTNdH
         bbb9FX1To3cI15v6DuAm7YXvDg8b2hK74EYYJl+2j0Wp+MJ3OrX30OhEDUSMY4N38kaG
         bzcA==
X-Gm-Message-State: AOJu0Yz7FFyQmHPv5igAiLOvtt5CT4Rfq2K0VK/bBZ881LLNJaVEaumm
	lC9F+/lMNE6d3objAV/CRKyJHLMDQp/bRK51pgYyXv+rKhH0IQ7q/7uUyVsaxA==
X-Gm-Gg: AY/fxX5cvuUq7bBwbIKSze667O+VSmbNLFuMuKTPi5spcmujDlFpLEte9CisFlhTf74
	WLCHwXcomHWvY3DSmqypCdO4kfHYcHwJK+/8HINr8Z8D6pe7YSsDWGM6O24GB0I90QaxPIAR/JA
	4w8J5isNfXXwHqaRqduG8NV2PnKzHd4D20FB4i3YL9IuULvEWtu9HhpKS/FHqtRwX7A91JibJ3M
	RGHcY4z2ILYdgSZJqDu4RMEYFeY85gG/+bUYxGNKm1USUUrq3dTx6u0IDmSa60qmu9IijKycp6u
	RwNcTamxUOAl+a1/kxt2o13Mlb5idAB7Or0/BVaT0AiDYyAn5m1vZj/BFr5Y7E1bkxufuQGG8iF
	98MF7I09iy6BhYB78UYxkUbfmgPqzAIK9omNVMr3NR7dCGsA7Jd4iBCcklQqjAOn1fP90pLbwie
	E76aLLVw2RUGwAuTDJ1v8vVAFAWRd5RYtLXQtzZB9aJiYn1aKFflNFqOb+oWoXllHquMMSh9wva
	M9Jdg==
X-Received: by 2002:a05:6102:8099:b0:5df:b5d4:e45d with SMTP id ada2fe7eead31-5f17f65eb87mr1900265137.33.1768427391360;
        Wed, 14 Jan 2026 13:49:51 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ec772af325sm24985649137.10.2026.01.14.13.49.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 13:49:50 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 4/6] shared/ad: Make bt_ad_has_data return the data
Date: Wed, 14 Jan 2026 16:49:35 -0500
Message-ID: <20260114214938.1417430-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114214938.1417430-1-luiz.dentz@gmail.com>
References: <20260114214938.1417430-1-luiz.dentz@gmail.com>
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

