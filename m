Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495972AF03
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Oct 2025 14:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759328874; cv=none; b=s/UNTI3TcARyo80c8NCydDgdjCsN3/b4i8YMwRHVQVC59i1H+sDFowN0wNCLJdJx2F29Azr2cQzxXghhc5PMx7olRBTgHyLO2kildefanDf4U2utDoeGROzqJ7vezM3tpA9tWzoR/KIxnYFPvNR/whiom4Y4+3phVp3c3w4rymI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759328874; c=relaxed/simple;
	bh=hEmjL2pLRLP8fV874pgyPAYY7dsYFZhWqMMulLDbezk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Hmg/X24zqt1tQYWeOtCiT+E/ltSA5Azf56SHFme5uf4tpRfhi5g7QxzxidvSDNuKdiI8Dhs9qAi2FKr6QXZWlfc/yCpV3SWTxgDiGcfM2L8ZOZeY2E17LDMI/ozdKfAKIa7pEcsWozHRoGsoYJJ6A/IRBADysVEEbxKaGSTfTMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChAopRjY; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChAopRjY"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-8fb58f2b820so4274798241.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Oct 2025 07:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759328870; x=1759933670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RYc01ibJm6UhHLCWc2tBXOcv8KsVKinMPAdNFo+A8ZM=;
        b=ChAopRjYFzk+k/fFXNVTyMnxTLcOXUH0VWd+if3k53vKpEuW+DppsrMCa+wO9qmWdm
         FYHdTn1Azr/pXm3t0PNFWbGPQUBNtPyVo4iKL+q8WUZjvB+XGGTFSi4Q0Bi0EAbaJrFD
         cbnAziktT8Df7QpykjX6IEHv2d1GO+csguPYUIYx1FmSYZRiXug/B9Dfu+z9KfI326d0
         V+w3VLlNezG0NmVkA8HXHNU8h0wDJZHWhAU72rkw2SwcgBHzDpMy8BR6abBKnlVTALIa
         oCCxoDV9uyECTWUjfymCvlpJubr5Ltoap07BU79gGcVSpu31HhHcmXw17XBJrmfqG/2m
         HjIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759328870; x=1759933670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RYc01ibJm6UhHLCWc2tBXOcv8KsVKinMPAdNFo+A8ZM=;
        b=kQ8rNopbnAUHWdMLNKfq9y+ohUBEuotHGkOAcfSJX6HxQDw7X7YZ3Gd0f+DY3k5sTT
         8jywxfbnjZhBoWhNEU5+7ci/aUGNtCvKPh3KLeqX36mMPKsEN8YrnJfE7vfao3QFid96
         +WZ14qOa7JSinoS9/v1lV3O4geStlFowNWboL9SmHAHqQefjYF1TN/myVklHYCuyEWZJ
         aTAW9BImCGjIsdNz6BDAIo/LOBNEzw/xdJsKRt3eTOL34RVpqUiAW2otrRuHuMyxdj1r
         JKT5LOV8e9SXIdTgyj79zrKQIlQ7tgDotE59CqpPmqILFBqVYmZC0czce7hadOzcnhwm
         JVcg==
X-Gm-Message-State: AOJu0YyLQLsazE62ZIhuVMHgbof96nlIjLOFQYWf6ctzTwCM3OFi8Yv0
	mKZ/6fmiTCjO//kbls0c0Egv/sbG5MCX1iPPg7VDuvmAqeTtnJ2z0CcjYrTWrPZy
X-Gm-Gg: ASbGncvjOFkI4B3AIcDk3B4T0qYo/3OkcuZq+5EOp39/ils9X4dk6Flhh/wz1A2A9id
	w5Xh0YD1GEPPfvOga/2Bb1BpmV8bDnDQYY62wHfFKdN85YhsaZJHLi90UD2W+pBPyP/Vjwq28t4
	osrkQJWIyggBAnH0r7P05SjR5Zecah7s44H32KKjfAeTB4v011nmrlQYwcC+M3/GNyK7ccQAdOL
	IzkG6KJND36F5myu6+D6t0aKeT6+rakxOgdgloXLfMBcWG+1dNWl0Z1bUmUsBGXDAJbjewh9GUf
	iBpaoVHJ8QOAD6o0DQznerLm7vO0ad4DX9fC2i5pQPDvefGmW7ZDBSSNbYLio9MCAgwvuU401fJ
	J3GMwiqwLze+Gipm5W9CAhNb5Run9rNlRnv5NNxZf9FFMq7zSTFjjKQowzTXUBOGGEf98BV19Sw
	XgK0zYXDPvX5YMig==
X-Google-Smtp-Source: AGHT+IFEYuBbb7xBaMStACsoKQImg/StN70L5cQe7/n5q8gkbe6/fru8/DRIZoQXQ1+lR1+pSxGvrw==
X-Received: by 2002:a05:6102:b15:b0:522:db47:90ac with SMTP id ada2fe7eead31-5d3fe4fbadcmr1464811137.6.1759328870469;
        Wed, 01 Oct 2025 07:27:50 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-916cff05915sm3571027241.4.2025.10.01.07.27.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 07:27:49 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/2] device: Fix privacy
Date: Wed,  1 Oct 2025 10:27:37 -0400
Message-ID: <20251001142738.17892-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In order for devices to properly be programmed into the adapter
resolving list they need to set the flag DEVICE_FLAG_ADDRESS_RESOLUTION
but that is only done if device_address_is_private return true but
currently it doesn't check the rpa flag which indicates that the address
has been updated to its identity.

While at it this also update the rpa flag to privacy to better indicate
the feature rather than just the address type and then introduces
device_set_privacy/device_get_privacy and replaces the usage of
device_address_is_private with device_get_privacy whenever the features
itself needs to be checked, rather than the current address type in use.

Fixes: https://github.com/bluez/bluez/issues/1079
---
 src/adapter.c |  4 ++--
 src/device.c  | 16 ++++++++++++----
 src/device.h  |  3 ++-
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index dc5ba65d73fa..3afcb9277129 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -5091,7 +5091,7 @@ static void load_devices(struct btd_adapter *adapter)
 			goto free;
 
 		if (irk_info)
-			device_set_rpa(device, true);
+			device_set_privacy(device, true);
 
 		btd_device_set_temporary(device, false);
 		adapter_add_device(adapter, device);
@@ -5752,7 +5752,7 @@ void adapter_set_device_flags(struct btd_adapter *adapter,
 
 	/* Set Address Resolution if it has not been set the flag yet. */
 	if (ll_privacy && btd_opts.defaults.le.addr_resolution &&
-			device_address_is_private(device) &&
+			device_get_privacy(device) &&
 			!(flags & DEVICE_FLAG_ADDRESS_RESOLUTION))
 		flags |= DEVICE_FLAG_ADDRESS_RESOLUTION & supported & ~pending;
 
diff --git a/src/device.c b/src/device.c
index 8b3e78995881..9f0e8e673529 100644
--- a/src/device.c
+++ b/src/device.c
@@ -204,7 +204,7 @@ struct btd_device {
 	uint8_t		conn_bdaddr_type;
 	bdaddr_t	bdaddr;
 	uint8_t		bdaddr_type;
-	bool		rpa;
+	bool		privacy;
 	char		*path;
 	struct btd_bearer *bredr;
 	struct btd_bearer *le;
@@ -4995,9 +4995,17 @@ void device_set_class(struct btd_device *device, uint32_t class)
 						DEVICE_INTERFACE, "Icon");
 }
 
-void device_set_rpa(struct btd_device *device, bool value)
+void device_set_privacy(struct btd_device *device, bool value)
 {
-	device->rpa = value;
+	device->privacy = value;
+}
+
+bool device_get_privacy(struct btd_device *device)
+{
+	if (device->privacy)
+		return true;
+
+	return device_address_is_private(device);
 }
 
 void device_update_addr(struct btd_device *device, const bdaddr_t *bdaddr,
@@ -5005,7 +5013,7 @@ void device_update_addr(struct btd_device *device, const bdaddr_t *bdaddr,
 {
 	bool auto_connect = device->auto_connect;
 
-	device_set_rpa(device, true);
+	device_set_privacy(device, true);
 
 	if (!bacmp(bdaddr, &device->bdaddr) &&
 					bdaddr_type == device->bdaddr_type)
diff --git a/src/device.h b/src/device.h
index 9e7c30ad7186..6fbbdb1f2d28 100644
--- a/src/device.h
+++ b/src/device.h
@@ -29,7 +29,8 @@ bool device_is_name_resolve_allowed(struct btd_device *device);
 void device_name_resolve_fail(struct btd_device *device);
 void device_set_class(struct btd_device *device, uint32_t class);
 bool device_address_is_private(struct btd_device *dev);
-void device_set_rpa(struct btd_device *device, bool value);
+void device_set_privacy(struct btd_device *device, bool value);
+bool device_get_privacy(struct btd_device *device);
 void device_update_addr(struct btd_device *device, const bdaddr_t *bdaddr,
 							uint8_t bdaddr_type);
 void device_set_bredr_support(struct btd_device *device);
-- 
2.51.0

