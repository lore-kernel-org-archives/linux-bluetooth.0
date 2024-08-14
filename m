Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27A63BBCB
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Aug 2024 18:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723661840; cv=none; b=CshdXqAmTwkMgzyEi8iIIt6t3jN0FC1tnhCh9580cScaKeCrGtUSX0R5sgwQbDO03n3O4jZ7JGOg7X0Gep8IzrJ3GKoRV6XH+eChUlJYt7rLnKyEwwSh/UdJPp9a433os7OIDWUOAWTHHHZ6jJ/QhME47L8s0b4vmSS83iaMn0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723661840; c=relaxed/simple;
	bh=RdUYRN6YHoR37RGJXU+bPEQrIz5LtBbf9ft9lMFtN2s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qpNdishkF1byRjX1IwbADbzvRL6I8NP0KVb23jSvCXBPv7XZc2s/nv4nATnSDuocegnOwLgQtyaiyi1hOPqhJccWKNBC8hiGP3Fp0CSML0vnh8J42OE1RYw2evyXEPslIWakMRwdgW8XZ298CXXZBWD3E8j2mt3wJkJ2j1JrOEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcmFsYUH; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcmFsYUH"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6659e81bc68so3462277b3.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Aug 2024 11:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723661837; x=1724266637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gs5hcx50K/4GDfEhlq9Mtn9nrSkclyLWMelqFWjSiOs=;
        b=bcmFsYUHAisyk4Fti0p/ypT3l6mpX3TdncXRsEU6AQpTVxIAyaFIAyTUT8Ndrz/c56
         0WDcU7/43AagBg/28+qD/4ffN7w4+9vVz9kNz1R8eCfvMs0y++I7PsK0lMHGODOWd/nZ
         mQt64fjvA+fFyaKjFkyfuV9tBPFJEVRxzZak1BoXp+xWJ0VrNf9jLBoYUyskQtsMNjEv
         RJf5kXjE9FfeK1fUi+mg5zfGRJN5wm+vDAjI0onoGkTIpQaJMbcNcXBoddqUE/0/gLUg
         S+hFkOcNcvNm8xCv6wdgmnWPkZ/EslGCUsir7mHtAV5EjP1PNTR+k1/taNR0yucbzYXY
         A1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723661837; x=1724266637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gs5hcx50K/4GDfEhlq9Mtn9nrSkclyLWMelqFWjSiOs=;
        b=qaej7255G5trDG6mNFLyITjbaOf7wY+zFXEWU8yKobI/ri6JCOVaKtYF7nbMiulzt3
         tm0aVPZwYo9fPwoF+ciTTyIHD2QJllDyQ24LFpn3cbdwT6h6BB2IsP1ibKmsXUhxqm8Z
         43rz3JlzA1uJLHoswmlquFBTD54gS/wdKv90BhmyC8kmeJDV/Q1B8paKwDhqvnKalrwM
         ueWJ6YtfZCJDGHGsvVnlBO3YFlewkejGVvhbGQ5mIIBSXGsCpoDQxZLpCcjtXdAmDusr
         CQ8HCERG+5MYqHeai3ShYYyNAqmb+OUwIcL4KAfOJfc/CIM912oRqHO+Pc+1faeX7y30
         ioGw==
X-Gm-Message-State: AOJu0Yy1z0o+9c8dm8OTRU7KjtcMhliI5bwTHdyzREF2AadpsUvA3e5D
	kXxUbZKKRHg09jMXIsyN9CCV+4p+Yk5fBfcTS95SXl+uZa7K5CNoX5fsyJtc
X-Google-Smtp-Source: AGHT+IECkZXWS/Pqw3CRObg9AB7+AIx93dwt5zBudzep8Kny5SdyW8RJZqv568DSlhRlHOtIsyEUGQ==
X-Received: by 2002:a05:6902:2507:b0:e0b:ea37:9c36 with SMTP id 3f1490d57ef6-e1155aad738mr3598165276.18.1723661836788;
        Wed, 14 Aug 2024 11:57:16 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e116203d02fsm274037276.48.2024.08.14.11.57.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 11:57:15 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] device: Promote Device.{AdvertisingData, AdvertisingFlags} to stable
Date: Wed, 14 Aug 2024 14:57:13 -0400
Message-ID: <20240814185714.844117-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This promotes AdvertisingData and AdvertisingFlags to stable so they can
be used by upper layers without having to enable experimental.
---
 doc/org.bluez.Device.rst | 8 ++++----
 src/device.c             | 6 ++----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/doc/org.bluez.Device.rst b/doc/org.bluez.Device.rst
index 4fdb31b0acbe..f94fc21296a9 100644
--- a/doc/org.bluez.Device.rst
+++ b/doc/org.bluez.Device.rst
@@ -293,13 +293,13 @@ bool ServicesResolved [readonly]
 
 	Indicate whether or not service discovery has been resolved.
 
-array{byte} AdvertisingFlags [readonly, experimental]
-`````````````````````````````````````````````````````
+array{byte} AdvertisingFlags [readonly]
+```````````````````````````````````````
 
 	The Advertising Data Flags of the remote device.
 
-dict AdvertisingData [readonly, experimental]
-`````````````````````````````````````````````
+dict AdvertisingData [readonly]
+```````````````````````````````
 
 	The Advertising Data of the remote device. Keys are 1 byte AD Type
 	followed by data as byte array.
diff --git a/src/device.c b/src/device.c
index cf7264051ac2..1a5e8a7caa27 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3252,11 +3252,9 @@ static const GDBusPropertyTable device_properties[] = {
 					dev_property_exists_tx_power },
 	{ "ServicesResolved", "b", dev_property_get_svc_resolved, NULL, NULL },
 	{ "AdvertisingFlags", "ay", dev_property_get_flags, NULL,
-					dev_property_flags_exist,
-					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL},
+					dev_property_flags_exist },
 	{ "AdvertisingData", "a{yv}", dev_property_get_advertising_data,
-				NULL, dev_property_advertising_data_exist,
-				G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+				NULL, dev_property_advertising_data_exist },
 	{ "WakeAllowed", "b", dev_property_get_wake_allowed,
 				dev_property_set_wake_allowed,
 				dev_property_wake_allowed_exist },
-- 
2.46.0

