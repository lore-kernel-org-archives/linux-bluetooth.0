Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BDE2DC773
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 21:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760648433; cv=none; b=tOfpfxHNp/iIitg0h0jaZWoQOFH1As8JpMRnfBvd3DsFvXpfmgkJBa8E95hUhuB8sxkRVxEDF+nm6XnE4OhhZKkBBFREOWMpegxfAlgkpHcHYJ1+D82IDRddNbZWDeb5f6+0aJhBMvSC+yF0OkujopKciEvrlOz/yjwUO0q7nb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760648433; c=relaxed/simple;
	bh=gjiiKM3N6T/YDmBEsjnWkymjtix668NAS97cnNaOMZ8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rrlIPYINM7C5L0XxK4V6psA7Wn0KAE+TENWhWGZGX3ItOVPPir9d/6CoPvO4MeMdkRobf4N38Ul1l0Jiqrl3NF9E9FccTNWP97otYPJCGbME61p3st4Rnpc9kODk98+KgbdTEPJsSwXQHK39W/ZRYQyky3qp9W8NAaBpxSd/ksw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AORzSSCy; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AORzSSCy"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-931043679fbso368727241.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 14:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760648430; x=1761253230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JehWMDGwgVRRgmxC5yPf+RbYRdDl7YkMvu8U6uFk79w=;
        b=AORzSSCymGmI8GZ9DxmF3kRayCyFr23aAiYtJM3x5I+KxtvFXZEcbSR0pJARwev6Ed
         wIgAuTP5hJE2smSBmCBumQ01hUh9JzVQpegy14X8Nv/VnGonpsElxbigY+RbVHIfkVwI
         63fjrIMjDrXzhmRPncVn2sI1vJYPx+GZlIsCUZv7x+Ec5WdTPtnzXQjhXCIau40w5jLu
         0CB8HffRgypoQkFPVNJShbKEENQXUd9oZQpwEfjtj1kZANej4p30cKejomtIcm0MYHWZ
         pAJcNJzOT1CNZXfgvwTBFYqk3k8gJIJVjR6BVOB+lZbVY4/I7AONInV4oKl2r5DhsH66
         34ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760648430; x=1761253230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JehWMDGwgVRRgmxC5yPf+RbYRdDl7YkMvu8U6uFk79w=;
        b=LFevbMo5wl6fwxgiSHn/XOg5fbSpMjENFkDtoPr4/ArPHnGWlERSILD85MdEumuGwn
         5EqDa+Yzxk+YdGYCnmDxZVzZL1QO7q2WASPv1jEceeUk3LoAP2VINKLGgsw5qWkJdbQd
         Z31Fuf/Dkc7fqiCwD+FAw7qJmyJLvPzr0eZflSanxWAG/tGo9Dy2vlaVr1Ha9a2Vzcb6
         yXolCrEQJ2E7wlrzJXsVTarZWnw+VPKY8VSz8s+oBkRDW+nrFAGzgaY0l80xOG5fQPP0
         on0QMvJLxWOojxyzaZEIns4JOitm3VBy5dSvpz0ZzxTgstQ5/UHrXn6qaY+E+o9SaV24
         PGtw==
X-Gm-Message-State: AOJu0YylOrbBacrtwOeBjfAH76PVEymWPAI6TFjtQsT+YzMziKwpyAwp
	F/XTC4Wvc3PBrxHJ3FG0HlGIUrhYJQztJ683oLx4B68a5fPfjHjdsAREDin4S9Yt
X-Gm-Gg: ASbGncvggGUoCHlSdOkZPotYAhwe+37EdtWL1/iuvuNQGYl73xIRMXe4nv+4ouZ/h+s
	CbgX2Cw0Xl68E0wGTkN40Y79MGsMp7w1BvuyT4/gJ31TLJKoxsvLxtQqw47zPT5276Aa4YdO0M/
	cfyziAdvMkVBwGNuIVx2BthIthuGr3O6nTEMgdQ7TIn0xwN+KbWJG2ZGVb02ahrpQLBPoglvDIQ
	vAKc1uB6qPxD/Sl1x4PcOTBaHpiP8/imy9X5bEKlhlB/tXgr9JVNwZ+2txRnBcV1Kd3TqySmbvF
	PP3Vtm9RMuaA7JAMas3zw2CYedi01ormqWv86kQwJ45DJW1W6POIOs/mh4t0uQdAL+mR9ycKy3C
	sboiiBfTsBVr7TdvhupaDPK7YAPPT11ZR/Dangb+6uxw3GYCYI4VWBqlN+4F8prKD+7NFohcg1f
	053aM=
X-Google-Smtp-Source: AGHT+IHIhWRIrywzcsNPi3vdHDNqZvtj1HTVlDst6jh25ONpuYL7XVIfh7WfGwt2Napvp6r/R/lB3Q==
X-Received: by 2002:a05:6102:610b:10b0:5d7:ddf6:b3b7 with SMTP id ada2fe7eead31-5d7ddf6b9f2mr595580137.8.1760648429578;
        Thu, 16 Oct 2025 14:00:29 -0700 (PDT)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554d80d9bf0sm6590304e0c.18.2025.10.16.14.00.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 14:00:28 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 02/13] device: Add initial support for setting DEVICE_FLAG_PAST
Date: Thu, 16 Oct 2025 17:00:08 -0400
Message-ID: <20251016210019.191878-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016210019.191878-1-luiz.dentz@gmail.com>
References: <20251016210019.191878-1-luiz.dentz@gmail.com>
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

