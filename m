Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AFD25E44E
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Oct 2025 14:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759328876; cv=none; b=UfbZHiWNPDWFMYBf8xLZDk0PaQYOUMNihGMqEeVtyCoz71seBqdVGqESh/2ew3L9PVyY5uqXhvEjPTmHsq50lVEPwTAJHP1dzqXJZGoTCRRs0sm+/AkG80GAS/nrVfpLRc/h6Nn3O1yj5OG8VDZUGzGhOxWnNEtEbS7oA9bMQVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759328876; c=relaxed/simple;
	bh=7aD3+Ev4nkH8BHWlhYv2U9Pkor0n3pG8KS+JxAYvASo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O3f7gPzj6QF1haxVP0sRrG+PJ79e6ryGRtU8ybePBfeRa5FkAnlD4IF/2WDwk1DjRUN7YrAhQlD9ZU1gkhk0heMfnwGKuGDe2oLEfe2QW2opLvBa5PtcIoo6sFcDhcI6KuF5vtgwGah7eqon+FLUMWz44WwXNQJZQoaJKp76s7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ei/55y8s; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ei/55y8s"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-892196f0471so2665088241.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Oct 2025 07:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759328873; x=1759933673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ziUdwzlPfH9YjrLvariCcq+i27mZYCkjS8MI2cJXYVs=;
        b=ei/55y8sVYehNsHqaQdP6onpm9GgTKfnGvnR07civakhZriVtWq20baFraBpGbyaPu
         Cy4IgDCoswQ9lJes3cvOfZfQAxbXS70gK4+nP/NR1kYLGOOfvi5h62USL0x00Kp3FTuo
         x8+PPsiiqbVrDa5IKUYCabZda0j9MgahskrM8pOoJctkPD95o+eM7Nc3zACrV78ynunK
         znN0hk048qFMLQ0KijlyCjsA96B9i5XyWd8Tdipen0Pd1Hk1DhMMlDTC5aUq3zrzUOAd
         BiLeLRbo54U7T01UybCCRljSlcuJ8yL6hJ6UHvh3JzQyP/eo790rVVhaKgig0SojxDoH
         cpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759328873; x=1759933673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ziUdwzlPfH9YjrLvariCcq+i27mZYCkjS8MI2cJXYVs=;
        b=nCbA7uGO8mz8t4WVpFxHehPW8dD3FjKOUzQTTzZWytGHEr12E/5bQp9BAiMHg/O0i3
         w1LxiXWvwPMu5Z5KAaw161iB2pCySTffSkyIadypx6B7fLnD3X/q74wRBxq+9Xh1SiQa
         Zfl5DqUDC+yLjw537iaFF2VD56rur6ffW4XwBq9ikTwtQ0tKdI2Pakx1VtRVxlnfFJI0
         TU2TzWdOpt4t48+7Ly+Jxm0Ap1UBFxuP+plifLLZou8N6qzkBQzrI0YCGbo99B9YC2uE
         fCoqjR3MwjX4Aj+mRHeeTIYi89ABCvqkx2owt6bQHr+PnjIa+Pw3/0hMCLqxh8+V9w+4
         pRqg==
X-Gm-Message-State: AOJu0YztzEis4kLbTRbpHrbwnC8ltgjE+VtbG+TV03z367NjwtSTuwNp
	Ivnew71dwPDaLhJSyU+AJjBE4HB5P+/RfRJ3j/KvL44Bbn0g6bTQRX3CCW2+Gh9E
X-Gm-Gg: ASbGncv/WwHYa1Cv0dkqXByBwkwGu9BvrCswr3SlFE1Eeq+UhKZ+ZsBw20SzAvKZ2yM
	rKb8jAvV3sn49dPPju6hyLKDAjRx+0hdXEkDIbLYl+GwXviAv4XEULCh3Z6A6OA30AwryrgDehB
	DacnUSPR+pjh+2ngxjSQb+UI3g8S6CGF7PrAvy+iSQzH45ZSGOjTJ4eOIBnq4w2HDGmuNAjGqcF
	Q94ceREdZNhWvwhy90osRilNzpf6aWFFFAYJjY13PQKeKzF+3Z/osnHyzaI95fupv6Gxc67L3NQ
	8E93lSf9C9C5wS2wK5eatUTXJOiloi2iw7BIQ7nd8nDZzaVmgSrgG6Kwb9c3nRUlRKakBCvyCoy
	CTNR+8tUqKlziakzdW8oF9Z0+9WPiDt6Jpw33uHft+WZtMYVdIxGho/ftRBrxfM7XhDI8yq2/an
	3nAYKbukWIesTxlA==
X-Google-Smtp-Source: AGHT+IEfzJHkx9MPgHJ/sQnaIGX2WylPrScECIYtAg7XsUlFrnEqs4Ap0V2V4S2td+LCPz0kngRMzQ==
X-Received: by 2002:a05:6102:32cf:b0:523:22e2:e894 with SMTP id ada2fe7eead31-5d3fe6cfdefmr1534997137.28.1759328873319;
        Wed, 01 Oct 2025 07:27:53 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-916cff05915sm3571027241.4.2025.10.01.07.27.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 07:27:51 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/2] core: Fix not resolving addresses
Date: Wed,  1 Oct 2025 10:27:38 -0400
Message-ID: <20251001142738.17892-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001142738.17892-1-luiz.dentz@gmail.com>
References: <20251001142738.17892-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When using the likes of btd_adapter_get_device the address can sometimes
be the so called RPA which needs to be resolved in order to avoid
creating duplicated objects of the same device.

Note that normally the RPA are resolved in the kernel but there are
instances like BASS Add Source that may attempt to add a device direcly,
bypassing the GAP layer.
---
 src/adapter.c |  4 ++--
 src/device.c  | 53 ++++++++++++++++++++++++++++++++++++++++++++++++---
 src/device.h  |  5 +++--
 3 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 3afcb9277129..1ee2f3a08164 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -5091,7 +5091,7 @@ static void load_devices(struct btd_adapter *adapter)
 			goto free;
 
 		if (irk_info)
-			device_set_privacy(device, true);
+			device_set_privacy(device, true, irk_info->val);
 
 		btd_device_set_temporary(device, false);
 		adapter_add_device(adapter, device);
@@ -9024,7 +9024,7 @@ static void new_irk_callback(uint16_t index, uint16_t length,
 		return;
 	}
 
-	device_update_addr(device, &addr->bdaddr, addr->type);
+	device_update_addr(device, &addr->bdaddr, addr->type, irk->val);
 
 	if (duplicate)
 		device_merge_duplicate(device, duplicate);
diff --git a/src/device.c b/src/device.c
index 9f0e8e673529..8d74ae0ea0ff 100644
--- a/src/device.c
+++ b/src/device.c
@@ -205,6 +205,7 @@ struct btd_device {
 	bdaddr_t	bdaddr;
 	uint8_t		bdaddr_type;
 	bool		privacy;
+	uint8_t		*irk;
 	char		*path;
 	struct btd_bearer *bredr;
 	struct btd_bearer *le;
@@ -4995,9 +4996,17 @@ void device_set_class(struct btd_device *device, uint32_t class)
 						DEVICE_INTERFACE, "Icon");
 }
 
-void device_set_privacy(struct btd_device *device, bool value)
+void device_set_privacy(struct btd_device *device, bool value,
+					const uint8_t *irk)
 {
 	device->privacy = value;
+
+	free(device->irk);
+
+	if (irk)
+		device->irk = util_memdup(irk, 16);
+	else
+		device->irk = NULL;
 }
 
 bool device_get_privacy(struct btd_device *device)
@@ -5009,11 +5018,11 @@ bool device_get_privacy(struct btd_device *device)
 }
 
 void device_update_addr(struct btd_device *device, const bdaddr_t *bdaddr,
-							uint8_t bdaddr_type)
+				uint8_t bdaddr_type, const uint8_t *irk)
 {
 	bool auto_connect = device->auto_connect;
 
-	device_set_privacy(device, true);
+	device_set_privacy(device, true, irk);
 
 	if (!bacmp(bdaddr, &device->bdaddr) &&
 					bdaddr_type == device->bdaddr_type)
@@ -5347,6 +5356,39 @@ static bool addr_is_public(uint8_t addr_type)
 	return false;
 }
 
+static bool addr_is_resolvable(const bdaddr_t *bdaddr, uint8_t addr_type)
+{
+	if (addr_type != BDADDR_LE_RANDOM)
+		return false;
+
+	switch (bdaddr->b[5] >> 6) {
+	case 0x01:	/* Private resolvable */
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool device_irk_cmp(const struct btd_device *device,
+				const struct device_addr_type *addr)
+{
+	struct bt_crypto *crypto;
+	uint8_t hash[3];
+
+	if (!device->irk)
+		return false;
+
+	crypto = bt_crypto_new();
+	if (!crypto)
+		return false;
+
+	bt_crypto_ah(crypto, device->irk, addr->bdaddr.b + 3, hash);
+
+	bt_crypto_unref(crypto);
+
+	return !memcmp(addr, hash, 3);
+}
+
 int device_addr_type_cmp(gconstpointer a, gconstpointer b)
 {
 	const struct btd_device *dev = a;
@@ -5375,8 +5417,13 @@ int device_addr_type_cmp(gconstpointer a, gconstpointer b)
 		return -1;
 
 	if (addr->bdaddr_type != dev->bdaddr_type) {
+		if (dev->privacy && addr_is_resolvable(&addr->bdaddr,
+							addr->bdaddr_type))
+			return device_irk_cmp(dev, addr);
+
 		if (addr->bdaddr_type == dev->conn_bdaddr_type)
 			return bacmp(&dev->conn_bdaddr, &addr->bdaddr);
+
 		return -1;
 	}
 
diff --git a/src/device.h b/src/device.h
index 6fbbdb1f2d28..9ff9cdfefc28 100644
--- a/src/device.h
+++ b/src/device.h
@@ -29,10 +29,11 @@ bool device_is_name_resolve_allowed(struct btd_device *device);
 void device_name_resolve_fail(struct btd_device *device);
 void device_set_class(struct btd_device *device, uint32_t class);
 bool device_address_is_private(struct btd_device *dev);
-void device_set_privacy(struct btd_device *device, bool value);
+void device_set_privacy(struct btd_device *device, bool value,
+					const uint8_t *irk);
 bool device_get_privacy(struct btd_device *device);
 void device_update_addr(struct btd_device *device, const bdaddr_t *bdaddr,
-							uint8_t bdaddr_type);
+				uint8_t bdaddr_type, const uint8_t *irk);
 void device_set_bredr_support(struct btd_device *device);
 void device_set_le_support(struct btd_device *device, uint8_t bdaddr_type);
 void device_update_last_seen(struct btd_device *device, uint8_t bdaddr_type,
-- 
2.51.0

