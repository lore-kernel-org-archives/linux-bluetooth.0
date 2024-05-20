Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B170D4C66
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 May 2024 15:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716220029; cv=none; b=IAP2tU5+G/7EgiZDTbX27/OjbB8pHpeaSlldjxN+kPyWr7L0vIpnFG3eNvnresWU7XcTzW1Zg8WzcLyTchKZW0mmKA1yvd2kUAl/5jtDzhp+2GJwnmwCLkauRz3bBQkCtTUmHbS7f5j3tBEXhyqVtIkDgiJSdBAGcETtXRZ88aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716220029; c=relaxed/simple;
	bh=1bE7ADOrnLOYw/8S/7BH6tNcWo6OXdZp6OZ7Lt4u9Yo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QYU2Tl9zFANEXnisr/du++uPKS/VON+C4dY5Lo1NtIYLgN/RFvelGJepHPvXEwARhwxlmB6xLY6pZ1e/6zIaQ68IsaONOk7X/J55UMX0cCOcMHMqz72jWs9gRnnM+rWGA5B0Vksg48dFhToX6MCp7OBZKkF0Q2cirgRKZYf3ALs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOjkpwh8; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOjkpwh8"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-47f008106d0so503693137.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 May 2024 08:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716220026; x=1716824826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HctzR0vSFhNabEnPLnyG4bHFcyN+wQkObHnzFVTr5oQ=;
        b=cOjkpwh8N3d1wJ5qj0btFPZIOKwGRCGY2GxOYGrm9xl04Hp11FwOxvyUMZ7rolJ3LC
         BrZzJjkhXJc64JQQBVIoxC5J8aqZYpfExWq2YJ4G437R6EK5SC+CgYWeauXcr30kvAcN
         0jJsi2uQtG0pgViQ4cu7oKs+0iJ/7yE1403iQtWx1fMkKwN0Q6DXR1FbKpb6uNLBM1cD
         rKNOSYh4oRkicL4ZEeNrp4lhiqd7q8YqfD5Ll+Q0rYPHzI1cASxjh367fascMkxiRFa6
         Y0g+eWmCav9JE7wZwBJp0elwsMJtJifL8BsZZRE0yN6mJplJpaOF8Hsw3SYmKYSImBcy
         ig6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716220026; x=1716824826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HctzR0vSFhNabEnPLnyG4bHFcyN+wQkObHnzFVTr5oQ=;
        b=HMvsbb0336NDQcNlWQ4lb5pD0atBIjnpQgyBjtrsG1jG3mfHb0BN19baiyg7pvnkkG
         IzrH0c0Onylql7HcPVLycse7g4I0KnmvueJZyGWw/8ZUW2qXR1vdlZ/NmBokAfJwMUUp
         YjQC3vrsCZsbvbtN0OsCmvGa5592VlR5JepTN2KQXI+Ji/LGzrqkXomED6JxLQnCnYZi
         iDeX6aPetTwrwxseOQN1xYDEMw5MKf81AZ0xt/HZ39fdcB1Dqq/eElG5uFC7LPNVQ5NY
         EfF6sCRWFMLBZYgVGutlVRBsbS+I5Mf3E0RtE1ROBrrE1HXQHEdIhYsSMbPAQa6vzu99
         BvEQ==
X-Gm-Message-State: AOJu0YxUNZ5AtHKXMrEXz/kDbJgNz669O9vQazmrOFy0s5TvzcoGAhna
	TEmGZ8KA29dXoLcsv2eQw70rTzPgFaxZIVGSJnN4aO+X2PCTIagkMJSKrQ==
X-Google-Smtp-Source: AGHT+IEB1BY4m5MEI3Tl0Du5iDauublEePHRP6wc/Gp+63zp1/mf2r2NWg6BmtJsTag/Jf+vcW5zDA==
X-Received: by 2002:a05:6102:442a:b0:47e:ee4d:8431 with SMTP id ada2fe7eead31-48077db71e3mr31495463137.3.1716220025836;
        Mon, 20 May 2024 08:47:05 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4806cb008d2sm3370154137.2.2024.05.20.08.47.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 08:47:04 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/3] device: Add btd_device_get_icon
Date: Mon, 20 May 2024 11:47:01 -0400
Message-ID: <20240520154703.1219758-1-luiz.dentz@gmail.com>
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

