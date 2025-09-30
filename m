Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D8330595C
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Sep 2025 14:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759243601; cv=none; b=gwL280d73O8P+muk337GYfRyQheOKkDKY5IZpTDADHra+rUrdkaI0nM4L6cP7643CG+K7RSVdz/iS9ttbdXOw0fYUHOeTbHvEaHH7fPLMpfh6NWkD9uIDF+derM8FTULQxdNiOUZT+Bc9r/Ikgz5j6BbJdD1xeRGZ3g20Ew4pEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759243601; c=relaxed/simple;
	bh=hEmjL2pLRLP8fV874pgyPAYY7dsYFZhWqMMulLDbezk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=N1vsaI+IuFD0DQQ2KJ5e12n4BzQWq5WyM83sM+N58LX2C2xYTcbC/87ctlFr7lcKxDqUu4JZzg8u2O44F+rwgRbl1yCGhVRpvA5Dx8IvdZv1TXLdHmgFt8EyIy819dJnTHPWHDu1GsVdJmmPp7nWSvPARudSbEb4baHHxlslqvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8dMwQSp; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8dMwQSp"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-54bc04b9d07so2597927e0c.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Sep 2025 07:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759243598; x=1759848398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RYc01ibJm6UhHLCWc2tBXOcv8KsVKinMPAdNFo+A8ZM=;
        b=Z8dMwQSpq9eIk08TCvYTdlWdR/ka536cqwkGplbk5zVhcOBGm0LBSb0YliqJmOUc9l
         biQOZIZMof70FvsXBjhgBUWSAXZVv05Vc1EZRrJV+9UrX2l/4Xb0EkkdeHN5G5lBm5XJ
         Lt+3VSGEzPJLbayrcz4R0vTvBA5r266znw4GBdO+BD7Oofwmuva9r44dzbSrt9Nq3uig
         GSEulM/Vz/rRi6a+DSVLJ0qUSx027l/FEvU2qDL/7qUFmAL9p3MRlhzAsedx1TY244bu
         5fpsdzLN4zEQyCyaxZhwOBS5ueOuCFHdnb0gb+mgr+wUM5UHTVlEmv0Mbt4Jq/jBYK3J
         OmWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759243598; x=1759848398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RYc01ibJm6UhHLCWc2tBXOcv8KsVKinMPAdNFo+A8ZM=;
        b=vZbxlX56DJnYI0//t5a3VUFsrvcXfPNBAlel1ty9lxacK2etapk2zPwDpGM9WlsJkJ
         +39ZHQ5QBsYHtwvR+SUEhJZoMkZ12y8R27I8MRH2uVkJS7xZ1x2fb6+hNysLiCNRnBu6
         DHtDDS07dWscTdO3WbyKaF52G5rkdq6y4EJ6kVSSvvSN6d39kBXaOfGzNsHMvQE7/JAN
         qgfEN6r/USwoR1kO3qESwnJjO9+UsDNbbwBOvgdWtgmMKPme00Kq2M7fFdqKimc6W0Ak
         soTQBIemVSoYk0/XzDyxP93HZd3PHgfDH+p2DN9T/A6PB6swTdw0v3GJHzQ/0bfsE5bV
         igkg==
X-Gm-Message-State: AOJu0YyHaaulX7GtRd0sqTLrQaSQQlaeIM6+v2UdPoA5IlHc7TVwe/12
	0/8Pw1KA4aO9jG61oUsnjx0K0NwLNtAPDSOAIRx4PoUEB3zqYG/BU800YEFXeg==
X-Gm-Gg: ASbGncs5OOpEhxFAmBos+mCiCRGTf7PzaGULMBJK5F3OkQJdWeHGvv2XRIESOLEUCF/
	KVqRlH+IbJKtyZG//aFqC6myU3+KuBHwGSWVvFZF4L/OUfpamZ5koGzKe/qjN8wf27CVlZ3q2/y
	47WBLXwfK3reFjNDtwozA5Yxd7VuXr3qBz+weEXHFabeyz6wXAkGsV3r2v+5im7cwEqjdlJzha9
	II4AVnPVx3sw8Fg3/X0WEel1dcUOTDQLpwh7ikfj9hCiTzpaq+YIDQxKh3lzygzAlnhp/pGtoMv
	roekZSRDdQHyAWz7nJuyxzftEo01HX4XSgJ9bOqUsyaJNjffeH04D3gEiytxf7iGuJzPzYusDpR
	vab1ox21HbRJbg8kK/34f0VWYaLEzzm74+bBI9P7i3xWBbdelqGZVD/502erLzta1t1maG7sBmZ
	x82xbXf0pabHI/QWP5K6s7bc2t
X-Google-Smtp-Source: AGHT+IEK9L4MjoqZZoRKYk1ugOjB8d7IvA7iGOe6MXlJGAE70Sjety9MoUdQQ3ZZJ37jRho7uMn7Qw==
X-Received: by 2002:ac5:c7c7:0:b0:54c:da0:f708 with SMTP id 71dfb90a1353d-54c0da10569mr3296670e0c.9.1759243597643;
        Tue, 30 Sep 2025 07:46:37 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54bed8a4e77sm2914671e0c.10.2025.09.30.07.46.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 07:46:36 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] device: Fix privacy
Date: Tue, 30 Sep 2025 10:46:27 -0400
Message-ID: <20250930144627.1676420-1-luiz.dentz@gmail.com>
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

