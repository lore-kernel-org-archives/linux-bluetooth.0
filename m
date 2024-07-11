Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8AA16EB4B
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jul 2024 19:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720725907; cv=none; b=mhMXjn9mQUdtWndeJ5+zNairptGu9YtLPCLGjOunAbzCNfTaEiO777f41nFXx1eLF3Cz32LWvyLNs0r3216KnNrZ5bXE+/ZQWBu17bh02obOH2tMLpJI3rfkH9OYXp+PUA43hLX39UljpkUau+04v8Tt4dbDhMrUPkaW4DsVAgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720725907; c=relaxed/simple;
	bh=G3XwxIHfWw9Kf0a5n3vTOHuDKf1mQF34bD0Fhmu4ldw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=NzolaZVlXG2AFBJ02IrNI+4xUDfRfVw0Xy2xvaBMxDMoI24mg/BMlAqy9oD5e6ZkVQLGVHyKTGXgV1DY2SWOW6s8NJd1pFktDWXaTVTsPRozlMPoE9eJrlHyGEvh9y16gNG8/B6oNkVdsN81PDNd0p4uyf6fO1GuTuz6LsfxWkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lL3BoJjc; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lL3BoJjc"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-48ffe7f4767so431731137.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jul 2024 12:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720725904; x=1721330704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SPIsCOVeycMx6Fd6I5tWkYv1kbYQI7Pebla43RD97Po=;
        b=lL3BoJjcPA3yYqC6Bzoz/E1bmd0YAFA+npX3SPqXfBPqgcp0QTEjYsx0MERKTM1Q79
         rD7o6WGsBAL+R/q0eR+RXr7nnxvfmXaz0+PznUOj4OcgUh422XKcb0Yfl9h06JYhtN7J
         wTC3q56AlkODe/ty2kx6HgkCseiaDPn2IjLJYCOiHwLqoJN74904vVTCYKV8XkY6ZKO5
         0biiuqjhoX7p4p6IVEHMVrJlL1e1EsS0b/MivHBQh7aPEjgHdpc2oD+pQ2FOI1FoRUGT
         gj07B0GF1qpekDAHCUC0AZtuxtzwUO/Iy/6A8DpDRR1F99fkMfAQQEc35Vb4RmKI3EbW
         9+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720725904; x=1721330704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SPIsCOVeycMx6Fd6I5tWkYv1kbYQI7Pebla43RD97Po=;
        b=DKzDrXmjDCh6neoKRkoaw+f5VukLGCGMoTnjzNXY/KVSbhE8YIrbLSlbxFVghN4tbA
         rn/ftuUNmwoy6rB82oAj0OtXuOORBXioLfMERWIKItvuBYD3ExfGKl3LiVyzbjysK+wn
         p8XZP5rS+kkTQXiDZvChzXbfyWBXORr4F/HP9d4PMJ0Uw2wkj2/0+INLhT68f2DQEC7O
         D48xDHR0diH36B+8vA4HAkmZWv6JJ01OpMuGoqocbxbG6oC2KbOIVXSmmsnPweUaLGh8
         fbX2ZAHSi18d2ZDqTohCRxeZlANAA7qjRun0ifDcRssGeAYgYm6m9/5rnON+J2wn5CUK
         CKFA==
X-Gm-Message-State: AOJu0YwiTC7qYPhDXLzD7gAbY5DcbX9yX1ZsDhk8zs3glyIPVJQM2IYz
	ZnreOUw1JYpYGJxHk76qlfDMRyWIYmTKjSKe2cgDRi/BOOKDvZpIV7TgM0G0
X-Google-Smtp-Source: AGHT+IGaRuTcoFCf+FLb23GoDkRXVr1bxjQ1E4KWMSqaACzZ4K1WK4/kmKDBxGnjOAWx3700anGW3g==
X-Received: by 2002:a05:6102:b12:b0:48f:4857:18f5 with SMTP id ada2fe7eead31-49032132d11mr9348073137.20.1720725903634;
        Thu, 11 Jul 2024 12:25:03 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4903171b2b8sm1314037137.30.2024.07.11.12.25.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 12:25:02 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] device: Fix overwritting current_flags
Date: Thu, 11 Jul 2024 15:25:01 -0400
Message-ID: <20240711192501.3699613-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

MGMT Set Device Flags overwrites the current_flags so only the last
flags set this way would remain active which can be seem in the
following sequence when LL Privacy is enabled:

@ MGMT Command: Set Device Flags (0x0050) plen 11
        LE Address: CF:AC:A6:79:3D:B9 (Static)
        Current Flags: 0x00000001
          Remote Wakeup
@ MGMT Event: Command Complete (0x0001) plen 10
      Set Device Flags (0x0050) plen 7
        Status: Success (0x00)
        LE Address: CF:AC:A6:79:3D:B9 (Static)
@ MGMT Command: Set Device Flags (0x0050) plen 11
        LE Address: CF:AC:A6:79:3D:B9 (Static)
        Current Flags: 0x00000002
          Device Privacy Mode
@ MGMT Event: Command Complete (0x0001) plen 10
      Set Device Flags (0x0050) plen 7
        Status: Success (0x00)
        LE Address: CF:AC:A6:79:3D:B9 (Static)

In order to do this properly the code needs to track the pending_flags
being set and also call btd_device_flags_changed whenever a change is
complete since that event is not generated when MGMT_OP_SET_DEVICE_FLAGS
is sent by bluetoothd itself.
---
 src/adapter.c | 20 +++++++++++++++++---
 src/device.c  | 20 +++++++++++++++++++-
 src/device.h  |  2 ++
 3 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index bb49a1ecad23..85ddfc16568f 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -5569,6 +5569,7 @@ void adapter_accept_list_remove(struct btd_adapter *adapter,
 static void set_device_privacy_complete(uint8_t status, uint16_t length,
 					 const void *param, void *user_data)
 {
+	struct btd_device *dev = user_data;
 	const struct mgmt_rp_set_device_flags *rp = param;
 
 	if (status != MGMT_STATUS_SUCCESS) {
@@ -5581,6 +5582,9 @@ static void set_device_privacy_complete(uint8_t status, uint16_t length,
 		error("Too small Set Device Flags complete event: %d", length);
 		return;
 	}
+
+	btd_device_flags_changed(dev, btd_device_get_supported_flags(dev),
+					btd_device_get_pending_flags(dev));
 }
 
 static void add_device_complete(uint8_t status, uint16_t length,
@@ -5626,7 +5630,7 @@ static void add_device_complete(uint8_t status, uint16_t length,
 			adapter_set_device_flags(adapter, dev, flags |
 						DEVICE_FLAG_DEVICE_PRIVACY,
 						set_device_privacy_complete,
-						NULL);
+						dev);
 		}
 	}
 }
@@ -5676,6 +5680,7 @@ void adapter_set_device_flags(struct btd_adapter *adapter,
 {
 	struct mgmt_cp_set_device_flags cp;
 	uint32_t supported = btd_device_get_supported_flags(device);
+	uint32_t pending = btd_device_get_pending_flags(device);
 	const bdaddr_t *bdaddr;
 	uint8_t bdaddr_type;
 
@@ -5683,6 +5688,14 @@ void adapter_set_device_flags(struct btd_adapter *adapter,
 				(supported | flags) != supported)
 		return;
 
+	/* Check if changing flags are pending */
+	if (flags == (flags & pending))
+		return;
+
+	/* Set Device Privacy Mode if it has not set the flag yet. */
+	if (btd_opts.device_privacy && !(flags & DEVICE_FLAG_DEVICE_PRIVACY))
+		flags |= DEVICE_FLAG_DEVICE_PRIVACY & supported & ~pending;
+
 	bdaddr = device_get_address(device);
 	bdaddr_type = btd_device_get_bdaddr_type(device);
 
@@ -5691,8 +5704,9 @@ void adapter_set_device_flags(struct btd_adapter *adapter,
 	cp.addr.type = bdaddr_type;
 	cp.current_flags = cpu_to_le32(flags);
 
-	mgmt_send(adapter->mgmt, MGMT_OP_SET_DEVICE_FLAGS, adapter->dev_id,
-		  sizeof(cp), &cp, func, user_data, NULL);
+	if (mgmt_send(adapter->mgmt, MGMT_OP_SET_DEVICE_FLAGS, adapter->dev_id,
+		  sizeof(cp), &cp, func, user_data, NULL))
+		btd_device_set_pending_flags(device, flags);
 }
 
 static void device_flags_changed_callback(uint16_t index, uint16_t length,
diff --git a/src/device.c b/src/device.c
index 097b1fbba37d..a1dc0750ca41 100644
--- a/src/device.c
+++ b/src/device.c
@@ -214,6 +214,7 @@ struct btd_device {
 	GDBusPendingPropertySet wake_id;
 
 	uint32_t	supported_flags;
+	uint32_t	pending_flags;
 	uint32_t	current_flags;
 	GSList		*svc_callbacks;
 	GSList		*eir_uuids;
@@ -1569,7 +1570,7 @@ static void set_wake_allowed_complete(uint8_t status, uint16_t length,
 		return;
 	}
 
-	device_set_wake_allowed_complete(dev);
+	btd_device_flags_changed(dev, dev->supported_flags, dev->pending_flags);
 }
 
 void device_set_wake_allowed(struct btd_device *device, bool wake_allowed,
@@ -7243,6 +7244,22 @@ uint32_t btd_device_get_supported_flags(struct btd_device *dev)
 	return dev->supported_flags;
 }
 
+void btd_device_set_pending_flags(struct btd_device *dev, uint32_t flags)
+{
+	if (!dev)
+		return;
+
+	dev->pending_flags = flags;
+}
+
+uint32_t btd_device_get_pending_flags(struct btd_device *dev)
+{
+	if (!dev)
+		return 0;
+
+	return dev->pending_flags;
+}
+
 /* This event is sent immediately after add device on all mgmt sockets.
  * Afterwards, it is only sent to mgmt sockets other than the one which called
  * set_device_flags.
@@ -7255,6 +7272,7 @@ void btd_device_flags_changed(struct btd_device *dev, uint32_t supported_flags,
 
 	dev->supported_flags = supported_flags;
 	dev->current_flags = current_flags;
+	dev->pending_flags = 0;
 
 	if (!changed_flags)
 		return;
diff --git a/src/device.h b/src/device.h
index 0794f92d0178..3742f6028040 100644
--- a/src/device.h
+++ b/src/device.h
@@ -191,6 +191,8 @@ int btd_device_connect_services(struct btd_device *dev, GSList *services);
 
 uint32_t btd_device_get_current_flags(struct btd_device *dev);
 uint32_t btd_device_get_supported_flags(struct btd_device *dev);
+uint32_t btd_device_get_pending_flags(struct btd_device *dev);
+void btd_device_set_pending_flags(struct btd_device *dev, uint32_t flags);
 void btd_device_flags_changed(struct btd_device *dev, uint32_t supported_flags,
 			      uint32_t current_flags);
 
-- 
2.45.2

