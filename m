Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F0F2848A4
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 21:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760045398; cv=none; b=ONihc/xFC6CcbA/Tby4OlIpoLBG0Ogiiw3QzxFYQ+bZQ2DbuL/bb8G1wrPssyg9L7u1P1tAtyaAhGw7lyiNKtMYbtXZxdtVKqp+hjF7vjJoVr2hS+zA/pYK9vZ4dmKYq1YXsgYZTGvMKzSPxmTIsTeg1hx1uBnTFtUnq43HTb08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760045398; c=relaxed/simple;
	bh=gjiiKM3N6T/YDmBEsjnWkymjtix668NAS97cnNaOMZ8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rxbDaUUUBvzkk9ZUG6NUyAtXGgrIcUMl0vG55KfQuHSxKI+RTyomfyJuWH8QejqJQmsHRWvHRQXh1IH4/dXeA/uHkeaGNQZkb1nj2Nx0t8RYuMYdAEtkfEJxJOsfsbIuWz4iCZYY4heri0Pw/dPmJvv+IP6vRFLVwO2TDZyaF7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFU+7YEv; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFU+7YEv"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-90f5eb2feb8so345925241.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Oct 2025 14:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760045394; x=1760650194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JehWMDGwgVRRgmxC5yPf+RbYRdDl7YkMvu8U6uFk79w=;
        b=JFU+7YEvYXCfN3z4K+UqMRQ9ch21rj21sHotloMOtN+q53r+BJtyXSJztMmewNQ9y2
         34vJqlxrLTvQ38EbRYOP6CWwYEOg2H0mWeBGlXCnaqoRoIxYwENVYmLt0b4FqvseT2Qr
         y/tyRCKJfUgIMWK3rrPjkcI4V0FpUYQMSi5a/hSLE9hWgiLY1QjLp5rQtLIG+oU6EaWw
         IKYxk3FlLnTimXpWDosK+3ncQmVCfOK3vN/QAo2OyU1P4yFEAsWap0fCfINn56J+uz7g
         7k8eCVPx+xXkznPZrXHLI3bQysIEoGajudUd9fCnSUdUzv00fYl4wBevdAQ95M2oCx1c
         UATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760045394; x=1760650194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JehWMDGwgVRRgmxC5yPf+RbYRdDl7YkMvu8U6uFk79w=;
        b=j4ThKLOhUXbS+DOHmfnrDfxd//4+FTWqKu2SN/XJ+fOj13Qym5FN2gl2Dsi20MmZnw
         sH5OMuQ+cH1GaOJiBzQn9zUzgwNPiY+6h8dd0Zo/Q4Qm/0fvjxnUYxk0/9oc2D6oYApb
         fDNIwUbA4KF/vz5D+oTIHAPcm41JXQmd7yeysEL7bxgJmQVRM0lOPZO1m9WFki/xmndN
         Et0YoJgUWKkKF1M+M1i0L4OwE/mO5JVk8N6qqdXFtLpS5BchGAYeVpprSnqlkBnVAI0k
         LlIfbdL1uldmvFLsq0Wbxu4wthDfasJPCWC+7pUs6u8TV9jnjbLRzasEuGKmw2FHGOmf
         w7eg==
X-Gm-Message-State: AOJu0YxzfgCzXX+2RGlkfTiMZ/msk32OTAOUVC4nAsqZnAzO/5Ba9gVH
	A2/jO8slNH4now02VLKG+HqFPb9fYVhefxgqjeLdEND5teuhAJhbxtFr5FgOAHMU
X-Gm-Gg: ASbGncs6zWbduD65zGwYCNEYgEZ7en5lzKgXcNpBE/vBQgmuZ6fsYRobvmV5h56iEp8
	B8fvrS898YPjNV9XqxDfI/fQXpDJ/Qu6Xd7XIt2fPy5tPoJuxzMQEK1UEnMsWQZNBJbhIv2Ugne
	AFupzp0fNlvojitBea1I+ulWIetKz0tSpwVZ5wld4Qaqlt7PvGytpK3PZecVbknmHZKxrCuDdFW
	6DXfvZGE04yZSi/HE86BJwD7aWgnbMzNCpZ/awwY10NzZMJBzgbXv5JEcg8IDrMtDuG9rWk+nKt
	Yv9ogc7uZrdsaI3+y5SiZzNe5Oqo1qEiRMADl42gGnJP+b9Rjg/2GuqKqSFc4nPlH+ShQ+0nEvF
	YafP759rT9TTl02XIMPY3I2eTa4N4uIXNc3VB2Mb3OjAWW2RzsFrg+JUXPG+KeVBuOZJeERq3AG
	Fy0Fh0EV8060WwLhcNnHwMxQyh
X-Google-Smtp-Source: AGHT+IFuTo7H1DL+wa4HaaagyvNWlU3wRlLW72nUvR+2CqwRmuxysSrQuUSKiWfjtNhH/eJHSkfTFQ==
X-Received: by 2002:a05:6102:4a8b:b0:5d5:f6ae:38bd with SMTP id ada2fe7eead31-5d5f6ae3b59mr1382448137.38.1760045394133;
        Thu, 09 Oct 2025 14:29:54 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554d7f01e3fsm211224e0c.7.2025.10.09.14.29.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 14:29:53 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 06/13] device: Add initial support for setting DEVICE_FLAG_PAST
Date: Thu,  9 Oct 2025 17:29:24 -0400
Message-ID: <20251009212931.445719-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009212931.445719-1-luiz.dentz@gmail.com>
References: <20251009212931.445719-1-luiz.dentz@gmail.com>
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
 src/device.c  | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 src/device.h  |  3 +++
 4 files changed, 74 insertions(+), 9 deletions(-)

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
index 8d74ae0ea0ff..3e907858b9d3 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1733,6 +1733,53 @@ void device_set_wake_allowed(struct btd_device *device, bool wake_allowed,
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

