Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35B22F7443
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 20:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761338453; cv=none; b=cvyYnhXAAOC6/sd032Sjr2+6sFK99zVXdSBNuIQYwCgCcCcEVWFguBok8bzgNqn70lyPadMJKhLCxafAfR/RVdaZ/0YJGP3hHGXtysZUR0xxBvhc3dSVEOabtNwWeBbJLQMfYU4SJZLiD8z8Zg8uq7odsQfoQKUf8rtgdRmXt2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761338453; c=relaxed/simple;
	bh=MfFsGSKqohU58UyHZwtmLTCoe21B5CD4fYgOBHAv0jo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=m39/Eqrf+YeXOnKPJtqv9rSrMOzzxf7Zaad9z5BWyOs6rBYdYG2Vu9F1yzwNHyHPQ/M36qfk3EXquqLm3a/fiocgJ7fCiOLaD81dpAJNrGra09d5jHkcsJCXppkKlVBs2tl9+2BaoyaO2jV3YuAt9ynRU7nw5LnAmkb8fTguf54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQddVy6M; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQddVy6M"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5db39d2ce9fso1004684137.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 13:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761338450; x=1761943250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AaQs2gkA3InXTxB0CGeA1xc5687ISwd7kKiMgJHlCPA=;
        b=mQddVy6MQe5BXeFhKAt8HgOQVLm9fOMdwv5FaZCtUEGfMhj7Un0Av+DtH4S+iVpUW9
         lKNDfkb7aTyb9RUP3QQZxIIL3cZxCU9fVYips7F16AaMrWKxcw1L0QZYPMxElAmaLXd/
         MzwpgdC+Av4tEjLE5uFr/8AtIa2370v/hBpjllqFPEBVB+Q8JGQ/h5rZTmeLG19UFq7h
         YpDXvYno1ZlBjZLRDCF2ughnJx5axQbf3mND6z7JW9Xmjc0XQkGvY2flm3loEtQ/ue53
         h8otx/RCirrNJAXnH0FYRnxG0QnOeuzAEQBZ6A2xlXiSQavMAXPxe4xnVnDR73XSH/V3
         uXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761338450; x=1761943250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AaQs2gkA3InXTxB0CGeA1xc5687ISwd7kKiMgJHlCPA=;
        b=RWzD9qxhUKO/36a4QWD99IhGNGninUetS3Atwe7XXjXnX82xxQcjUhixajJru6En/e
         wTBG+G4g35t6+PsY30Hf7cuhFsXz8GLaqCwzU8TmNhE/lzzNd1+Ktw4cYN+/fkUKLq4d
         ogbEZ66EbGqR/DTimQXanish47CdBBJtdraMwSbKNkb5mzItVKSOM7uerO+5/RyzTLWH
         vKJHNFT5sm7vsXLZr+Jv29hc9xXR5byxwZsy0A0M4xL/03ixiPyZXblR39hlEZ/ldbvZ
         rW0R3pRdYVpgNEKuxxaH9TSSl3NQ0bJ+f+QGeH4Q7O+GQ1L4Izy/AMmqRl8KgDQ7R4q7
         2HYw==
X-Gm-Message-State: AOJu0YxXPvhcKRnI+nkGMFiZ7XfvooisBWBOcKrW//VkYP6hFCoeQtlT
	7w0fU1/5ek+WQd4timl7V+C1Jze1rnBgFU7v0YSsSr7BeuiPK40XU8wkmouH2A==
X-Gm-Gg: ASbGnctkLBvrREOOD19BNLoela2YKkdZoKdymDsrQRD/zLIzbCMOMualvxhbcFYxsqd
	iph4YNbygEoMx2y9xmqpnQISanIpqUVlGbdt9iSkdjlJZk9V/UoJJTSvj5PVI/t4xXPW7qoaDlY
	WHGS0fUTLaDq0AP2iMTLka7RWI4ll2uoXy0O53d+J1/uAizEldaXOatwd0zGfuFE98+QwehUh1T
	fS6exjI6JIa2fJIU7mrsouDmM41/8eU4hCS2GCM3RKyg39TfyGlOP2ig2uo1w8ZdVBp7yHTfy2H
	ItqDMFJMTnNSFPgyvx5XKNrBF79OPfMx4H/lcduYBIeoCG7WQHz/hgp/fbMwpqDrpPVmB2QUlzj
	/YUNGX1blA2TT8B3km2AUSH2CbZT4Q7V9EM4n4wb0MrzR/DXDkaSiM0rgX/6DHYYdgYNGjOJEK4
	U/0jii/JnSpRLd2g==
X-Google-Smtp-Source: AGHT+IE3+pIlEKq2X4G5wIYWlmTWCUo/eWBQDgjwogIsPO5CgpKDIbVl7Kbq9gu16ba8cYACX0VRSQ==
X-Received: by 2002:a05:6102:8392:20b0:5db:26e6:68b5 with SMTP id ada2fe7eead31-5db2e5b4d56mr1886793137.43.1761338450139;
        Fri, 24 Oct 2025 13:40:50 -0700 (PDT)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-557ddb2f98asm73501e0c.10.2025.10.24.13.40.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 13:40:49 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 01/12] device: Add initial support for setting DEVICE_FLAG_PAST
Date: Fri, 24 Oct 2025 16:40:28 -0400
Message-ID: <20251024204039.693918-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces device_set_past_support which can be used by drivers
to indicate that DEVICE_FLAG_PAST shall be changed.
---
 src/adapter.c | 31 +++++++++++++++++++++++--------
 src/adapter.h |  2 +-
 src/device.c  | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 src/device.h  |  3 +++
 4 files changed, 77 insertions(+), 9 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 1ee2f3a08164..4452034630f8 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -5640,6 +5640,8 @@ static void add_device_complete(uint8_t status, uint16_t length,
 	struct btd_adapter *adapter = user_data;
 	struct btd_device *dev;
 	char addr[18];
+	uint32_t flags;
+
 
 	if (length < sizeof(*rp)) {
 		btd_error(adapter->dev_id,
@@ -5669,8 +5671,7 @@ static void add_device_complete(uint8_t status, uint16_t length,
 	DBG("%s (%u) added to kernel connect list", addr, rp->addr.type);
 
 	if (btd_opts.device_privacy) {
-		uint32_t flags = btd_device_get_current_flags(dev);
-
+		flags = btd_device_get_current_flags(dev);
 		/* Set Device Privacy Mode if it has not set the flag yet. */
 		if (!(flags & DEVICE_FLAG_DEVICE_PRIVACY)) {
 			/* Include the pending flags, or they may get
@@ -5682,8 +5683,18 @@ static void add_device_complete(uint8_t status, uint16_t length,
 						DEVICE_FLAG_DEVICE_PRIVACY,
 						set_device_privacy_complete,
 						dev);
+			return;
 		}
 	}
+
+	/* Check if any flag was marked as pending before ADD_DEVICE
+	 * complete then set it now
+	 */
+	flags = btd_device_get_pending_flags(dev);
+	if (flags)
+		adapter_set_device_flags(adapter, dev, flags,
+						set_device_privacy_complete,
+						dev);
 }
 
 void adapter_auto_connect_add(struct btd_adapter *adapter,
@@ -5725,7 +5736,7 @@ void adapter_auto_connect_add(struct btd_adapter *adapter,
 	adapter->connect_list = g_slist_append(adapter->connect_list, device);
 }
 
-void adapter_set_device_flags(struct btd_adapter *adapter,
+int adapter_set_device_flags(struct btd_adapter *adapter,
 				struct btd_device *device, uint32_t flags,
 				mgmt_request_func_t func, void *user_data)
 {
@@ -5737,14 +5748,15 @@ void adapter_set_device_flags(struct btd_adapter *adapter,
 	uint8_t bdaddr_type;
 	bool ll_privacy = btd_adapter_has_settings(adapter,
 						MGMT_SETTING_LL_PRIVACY);
+	unsigned int id;
 
 	if (!btd_has_kernel_features(KERNEL_CONN_CONTROL) ||
-				(supported | flags) != supported)
-		return;
+			(supported && (supported | flags) != supported))
+		return -EINVAL;
 
 	/* Check if changing flags are pending */
 	if ((current ^ flags) == (flags & pending))
-		return;
+		return -EINPROGRESS;
 
 	/* Set Device Privacy Mode if it has not set the flag yet. */
 	if (btd_opts.device_privacy && !(flags & DEVICE_FLAG_DEVICE_PRIVACY))
@@ -5764,9 +5776,12 @@ void adapter_set_device_flags(struct btd_adapter *adapter,
 	cp.addr.type = bdaddr_type;
 	cp.current_flags = cpu_to_le32(flags);
 
-	if (mgmt_send(adapter->mgmt, MGMT_OP_SET_DEVICE_FLAGS, adapter->dev_id,
-		  sizeof(cp), &cp, func, user_data, NULL))
+	id = mgmt_send(adapter->mgmt, MGMT_OP_SET_DEVICE_FLAGS, adapter->dev_id,
+			  sizeof(cp), &cp, func, user_data, NULL);
+	if (id != 0)
 		btd_device_set_pending_flags(device, flags);
+
+	return id == 0 ? -EBUSY : 0;
 }
 
 static void device_flags_changed_callback(uint16_t index, uint16_t length,
diff --git a/src/adapter.h b/src/adapter.h
index ad81a10b1bb1..dd0c90d9cb3a 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -237,7 +237,7 @@ void adapter_connect_list_remove(struct btd_adapter *adapter,
 typedef void (*adapter_set_device_flags_func_t)(uint8_t status, uint16_t length,
 						const void *param,
 						void *user_data);
-void adapter_set_device_flags(struct btd_adapter *adapter,
+int adapter_set_device_flags(struct btd_adapter *adapter,
 				struct btd_device *device, uint32_t flags,
 				adapter_set_device_flags_func_t func,
 				void *user_data);
diff --git a/src/device.c b/src/device.c
index 8d74ae0ea0ff..91b6cc0c65ea 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1733,6 +1733,56 @@ void device_set_wake_allowed(struct btd_device *device, bool wake_allowed,
 					set_wake_allowed_complete, device);
 }
 
+static void set_past_complete(uint8_t status, uint16_t length,
+					 const void *param, void *user_data)
+{
+	const struct mgmt_rp_set_device_flags *rp = param;
+	struct btd_device *dev = user_data;
+
+	if (status != MGMT_STATUS_SUCCESS) {
+		error("Set device flags return status: %s",
+					mgmt_errstr(status));
+		return;
+	}
+
+	if (length < sizeof(*rp)) {
+		error("Too small Set Device Flags complete event: %d", length);
+		return;
+	}
+
+	btd_device_flags_changed(dev, dev->supported_flags, dev->pending_flags);
+}
+
+void device_set_past_support(struct btd_device *device, bool value)
+{
+	uint32_t flags;
+	int err;
+
+	if (!device)
+		return;
+
+	if (btd_device_flags_enabled(device, DEVICE_FLAG_PAST) == value)
+		return;
+
+	DBG("value %s", value ? "true" : "false");
+
+	flags = device->current_flags;
+
+	/* Include the pending flags, or they may get overwritten. */
+	flags |= device->pending_flags;
+
+	if (value)
+		flags |= DEVICE_FLAG_PAST;
+	else
+		flags &= ~DEVICE_FLAG_PAST;
+
+	err = adapter_set_device_flags(device->adapter, device, flags,
+					set_past_complete, device);
+
+	if (err)
+		error("Failed to set past support: %s", strerror(-err));
+}
+
 static gboolean
 dev_property_get_wake_allowed(const GDBusPropertyTable *property,
 			     DBusMessageIter *iter, void *data)
diff --git a/src/device.h b/src/device.h
index 9ff9cdfefc28..6ed8affa0d4a 100644
--- a/src/device.h
+++ b/src/device.h
@@ -158,6 +158,9 @@ void device_set_wake_support(struct btd_device *device, bool wake_support);
 void device_set_wake_override(struct btd_device *device, bool wake_override);
 void device_set_wake_allowed(struct btd_device *device, bool wake_allowed,
 			     guint32 id);
+
+void device_set_past_support(struct btd_device *device, bool value);
+
 void device_set_refresh_discovery(struct btd_device *dev, bool refresh);
 
 typedef void (*disconnect_watch) (struct btd_device *device, gboolean removal,
-- 
2.51.0

