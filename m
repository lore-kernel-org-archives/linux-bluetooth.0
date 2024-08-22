Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ED517965E
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Aug 2024 20:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724360127; cv=none; b=dwHkeV4V00BhS7DVCFt+9xSMb5vty9XDEr1DwQ5pHFGrYbOWmyO8F1NfQxxpbNbz6LMw04Q0orXnwutmTjil69Ky2p2qIH0Y7mR4g792JCWJYymeOyWCi82FvTxTAQYa3gL33/myIVKVxetld+AJCYSauhXhImg81vHFKvsyc/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724360127; c=relaxed/simple;
	bh=DpJ3WYWfhpNhsmRh9LuuQO1N2/grSVoeNf8/dEZ9zXA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=b4LqC2SaMxvFdFw+sjuxGHD9OwVi7mOlGXmwmqOXbV5gX2D2VXU/xt85J889DeoO1yIwC+NCFpqoTAnp2PhjASmaDzRwsS07YIn7jwCc93CO23jjze59dgw3ZwwQvgzee6OQ42BNM+dBVlnXr63uw2Ed8xIqhJLF9R5APN9t4dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aK66Yc5o; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aK66Yc5o"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-842f00b72e4so361129241.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Aug 2024 13:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724360124; x=1724964924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6EGV8H07f7plRZOSoVEDHYu1Xj3g82zjpjj+7j8aVcQ=;
        b=aK66Yc5ou8cKvgkzIUxXULATI+FnGsBb0I2ktblM/XXcce21sHp8SzSPXgNR4ElKKv
         CWbOY9oYPjFv3pti5FOu0Zik9fp6GgdUmMkTnQld4eCGGL0AfJa2Vp/BMP91hT5vrfpt
         UJpOLxpx7j52QdRA5Y+Dg6R1Ju+4cZ5rsgXL1/GpUH6wlsB+nLXdg2BTTx3rieoDDVLv
         NF0GLnm/uOiiZmROTfmmkNHHfSi2n5wHuYSHKQ5Wjsh8VB5Uj0sny6eJANrIBS8wE0Og
         0yrxELBxw++Svl5RjcQUiPFuwRd0lsdc8HGh3XMrL526KVm4v4/JmLGtVlIiJnk81cxs
         NziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724360124; x=1724964924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6EGV8H07f7plRZOSoVEDHYu1Xj3g82zjpjj+7j8aVcQ=;
        b=tF3MYJHbTr6YAHHP81lT4B61xkNngMaJxNYYVSgPAkdcv7ORg/FvfqRx1EJCW6raxL
         wYYYYZvLEkBs7ZMKy4C/7kCQADqaNm8T/epyhWxXtz7apaWdEFIJGM1tZ8zdaCdCgzTw
         7yAnZg43X+shA2VnAGu332Qzm+hTAV1uaBBnWTv2Y60rSXGa1FB6/ffOklPQDHH5VSh0
         kf69pmTcFJ3KBng2KhYu0JakmNhoirwfy4TrqNsTN5hxNXVUQi1o6S0liqYcTc0FX5Gq
         1nIrAhCBLD392tpYoa04yuAk5lKdRTBjYt5qxOwFC0A422QW0otkI5msdufCBqDUyi6e
         kxgw==
X-Gm-Message-State: AOJu0YxVFdL296hBWET0Xb0q8pnaYblsEMDj7/sMRnlGo21xY81EVVIc
	l09fmltE/JzVMge8V2Sb1QxfQMpzF4220v5DqDqjIL6EVhwWLYxOr8jIwg==
X-Google-Smtp-Source: AGHT+IFV9qeYQHooYCaKIliMm2QeZQtg/fyjc30hgma/RXC7NDrdjtoznybgKmwlkdfy4yRkcT86Yw==
X-Received: by 2002:a05:6102:3053:b0:493:ddd1:d7fc with SMTP id ada2fe7eead31-498f455980fmr278177137.11.1724360123787;
        Thu, 22 Aug 2024 13:55:23 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-844ce5090bbsm285065241.20.2024.08.22.13.55.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 13:55:22 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: MGMT: Mark LL Privacy as stable
Date: Thu, 22 Aug 2024 16:55:21 -0400
Message-ID: <20240822205521.587196-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This marks LL Privacy as stable by removing its experimental UUID and
move its functionality to Device Flag (HCI_CONN_FLAG_ADDRESS_RESOLUTION)
which can be set by MGMT Device Set Flags so userspace retain control of
the feature.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h      |   1 -
 include/net/bluetooth/hci_core.h |  11 +--
 net/bluetooth/hci_sync.c         |  48 ++++++-----
 net/bluetooth/mgmt.c             | 133 +------------------------------
 4 files changed, 31 insertions(+), 162 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index bab1e3d7452a..81108e4a0c9f 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -422,7 +422,6 @@ enum {
 	HCI_FORCE_BREDR_SMP,
 	HCI_FORCE_STATIC_ADDR,
 	HCI_LL_RPA_RESOLUTION,
-	HCI_ENABLE_LL_PRIVACY,
 	HCI_CMD_PENDING,
 	HCI_FORCE_NO_MITM,
 	HCI_QUALITY_REPORT,
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e449dba698f3..54ad0f50c01c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -157,8 +157,9 @@ struct bdaddr_list_with_irk {
 
 /* Bitmask of connection flags */
 enum hci_conn_flags {
-	HCI_CONN_FLAG_REMOTE_WAKEUP = 1,
-	HCI_CONN_FLAG_DEVICE_PRIVACY = 2,
+	HCI_CONN_FLAG_REMOTE_WAKEUP = BIT(0),
+	HCI_CONN_FLAG_DEVICE_PRIVACY = BIT(1),
+	HCI_CONN_FLAG_ADDRESS_RESOLUTION = BIT(2),
 };
 typedef u8 hci_conn_flags_t;
 
@@ -1852,11 +1853,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 
 #define ll_privacy_capable(dev) ((dev)->le_features[0] & HCI_LE_LL_PRIVACY)
 
-/* Use LL Privacy based address resolution if supported */
-#define use_ll_privacy(dev) (ll_privacy_capable(dev) && \
-			     hci_dev_test_flag(dev, HCI_ENABLE_LL_PRIVACY))
-
-#define privacy_mode_capable(dev) (use_ll_privacy(dev) && \
+#define privacy_mode_capable(dev) (ll_privacy_capable(dev) && \
 				   (hdev->commands[39] & 0x04))
 
 #define read_key_size_capable(dev) \
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index e79cd40bd079..3be51b3f6510 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1023,7 +1023,7 @@ int hci_update_random_address_sync(struct hci_dev *hdev, bool require_privacy,
 		/* If Controller supports LL Privacy use own address type is
 		 * 0x03
 		 */
-		if (use_ll_privacy(hdev))
+		if (ll_privacy_capable(hdev))
 			*own_addr_type = ADDR_LE_DEV_RANDOM_RESOLVED;
 		else
 			*own_addr_type = ADDR_LE_DEV_RANDOM;
@@ -2119,7 +2119,7 @@ static int hci_le_set_scan_enable_sync(struct hci_dev *hdev, u8 val,
 
 static int hci_le_set_addr_resolution_enable_sync(struct hci_dev *hdev, u8 val)
 {
-	if (!use_ll_privacy(hdev))
+	if (!ll_privacy_capable(hdev))
 		return 0;
 
 	/* If controller is not/already resolving we are done. */
@@ -2211,7 +2211,7 @@ static int hci_le_del_resolve_list_sync(struct hci_dev *hdev,
 	struct hci_cp_le_del_from_resolv_list cp;
 	struct bdaddr_list_with_irk *entry;
 
-	if (!use_ll_privacy(hdev))
+	if (!ll_privacy_capable(hdev))
 		return 0;
 
 	/* Check if the IRK has been programmed */
@@ -2276,7 +2276,7 @@ static int hci_le_add_resolve_list_sync(struct hci_dev *hdev,
 	struct bdaddr_list_with_irk *entry;
 	struct hci_conn_params *p;
 
-	if (!use_ll_privacy(hdev))
+	if (!ll_privacy_capable(hdev))
 		return 0;
 
 	/* Attempt to program local identity address, type and irk if params is
@@ -2289,7 +2289,8 @@ static int hci_le_add_resolve_list_sync(struct hci_dev *hdev,
 		hci_copy_identity_address(hdev, &cp.bdaddr, &cp.bdaddr_type);
 		memcpy(cp.peer_irk, hdev->irk, 16);
 		goto done;
-	}
+	} else if (!(params->flags & HCI_CONN_FLAG_ADDRESS_RESOLUTION))
+		return 0;
 
 	irk = hci_find_irk_by_addr(hdev, &params->addr, params->addr_type);
 	if (!irk)
@@ -2336,6 +2337,10 @@ static int hci_le_set_privacy_mode_sync(struct hci_dev *hdev,
 	struct hci_cp_le_set_privacy_mode cp;
 	struct smp_irk *irk;
 
+	if (!ll_privacy_capable(hdev) ||
+	    !(params->flags & HCI_CONN_FLAG_ADDRESS_RESOLUTION))
+		return 0;
+
 	/* If device privacy mode has already been set there is nothing to do */
 	if (params->privacy_mode == HCI_DEVICE_PRIVACY)
 		return 0;
@@ -2385,11 +2390,6 @@ static int hci_le_add_accept_list_sync(struct hci_dev *hdev,
 	if (*num_entries >= hdev->le_accept_list_size)
 		return -ENOSPC;
 
-	/* Accept list can not be used with RPAs */
-	if (!use_ll_privacy(hdev) &&
-	    hci_find_irk_by_addr(hdev, &params->addr, params->addr_type))
-		return -EINVAL;
-
 	/* Attempt to program the device in the resolving list first to avoid
 	 * having to rollback in case it fails since the resolving list is
 	 * dynamic it can probably be smaller than the accept list.
@@ -2524,7 +2524,7 @@ static int hci_pause_addr_resolution(struct hci_dev *hdev)
 {
 	int err;
 
-	if (!use_ll_privacy(hdev))
+	if (!ll_privacy_capable(hdev))
 		return 0;
 
 	if (!hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION))
@@ -2628,12 +2628,12 @@ static int hci_le_clear_accept_list_sync(struct hci_dev *hdev)
  *
  * Update is done using the following sequence:
  *
- * use_ll_privacy((Disable Advertising) -> Disable Resolving List) ->
+ * ll_privacy_capable((Disable Advertising) -> Disable Resolving List) ->
  * Remove Devices From Accept List ->
- * (has IRK && use_ll_privacy(Remove Devices From Resolving List))->
+ * (has IRK && ll_privacy_capable(Remove Devices From Resolving List))->
  * Add Devices to Accept List ->
- * (has IRK && use_ll_privacy(Remove Devices From Resolving List)) ->
- * use_ll_privacy(Enable Resolving List -> (Enable Advertising)) ->
+ * (has IRK && ll_privacy_capable(Remove Devices From Resolving List)) ->
+ * ll_privacy_capable(Enable Resolving List -> (Enable Advertising)) ->
  * Enable Scanning
  *
  * In case of failure advertising shall be restored to its original state and
@@ -2654,7 +2654,7 @@ static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
 	/* Pause advertising if resolving list can be used as controllers
 	 * cannot accept resolving list modifications while advertising.
 	 */
-	if (use_ll_privacy(hdev)) {
+	if (ll_privacy_capable(hdev)) {
 		err = hci_pause_advertising_sync(hdev);
 		if (err) {
 			bt_dev_err(hdev, "pause advertising failed: %d", err);
@@ -2799,7 +2799,7 @@ static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
 		bt_dev_err(hdev, "Unable to enable LL privacy: %d", err);
 
 	/* Resume advertising if it was paused */
-	if (use_ll_privacy(hdev))
+	if (ll_privacy_capable(hdev))
 		hci_resume_advertising_sync(hdev);
 
 	/* Select filter policy to use accept list */
@@ -3057,7 +3057,7 @@ static int hci_passive_scan_sync(struct hci_dev *hdev)
  * If there are devices to scan:
  *
  * Disable Scanning -> Update Accept List ->
- * use_ll_privacy((Disable Advertising) -> Disable Resolving List ->
+ * ll_privacy_capable((Disable Advertising) -> Disable Resolving List ->
  * Update Resolving List -> Enable Resolving List -> (Enable Advertising)) ->
  * Enable Scanning
  *
@@ -3411,7 +3411,7 @@ int hci_update_name_sync(struct hci_dev *hdev)
  *
  * HCI_SSP_ENABLED(Enable SSP)
  * HCI_LE_ENABLED(Enable LE)
- * HCI_LE_ENABLED(use_ll_privacy(Add local IRK to Resolving List) ->
+ * HCI_LE_ENABLED(ll_privacy_capable(Add local IRK to Resolving List) ->
  * Update adv data)
  * Enable Authentication
  * lmp_bredr_capable(Set Fast Connectable -> Set Scan Type -> Set Class ->
@@ -4186,6 +4186,10 @@ static int hci_le_set_event_mask_sync(struct hci_dev *hdev)
 	if (use_enhanced_conn_complete(hdev))
 		events[1] |= 0x02;	/* LE Enhanced Connection Complete */
 
+	/* Mark Address Resolution if LL Privacy is supported */
+	if (ll_privacy_capable(hdev))
+		hdev->conn_flags |= HCI_CONN_FLAG_ADDRESS_RESOLUTION;
+
 	/* If the controller supports Extended Scanner Filter
 	 * Policies, enable the corresponding event.
 	 */
@@ -5329,7 +5333,7 @@ int hci_stop_discovery_sync(struct hci_dev *hdev)
 	}
 
 	/* Resume advertising if it was paused */
-	if (use_ll_privacy(hdev))
+	if (ll_privacy_capable(hdev))
 		hci_resume_advertising_sync(hdev);
 
 	/* No further actions needed for LE-only discovery */
@@ -5838,7 +5842,7 @@ static int hci_active_scan_sync(struct hci_dev *hdev, uint16_t interval)
 
 failed:
 	/* Resume advertising if it was paused */
-	if (use_ll_privacy(hdev))
+	if (ll_privacy_capable(hdev))
 		hci_resume_advertising_sync(hdev);
 
 	/* Resume passive scanning */
@@ -6614,7 +6618,7 @@ int hci_get_random_address(struct hci_dev *hdev, bool require_privacy,
 		/* If Controller supports LL Privacy use own address type is
 		 * 0x03
 		 */
-		if (use_ll_privacy(hdev))
+		if (ll_privacy_capable(hdev))
 			*own_addr_type = ADDR_LE_DEV_RANDOM_RESOLVED;
 		else
 			*own_addr_type = ADDR_LE_DEV_RANDOM;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index fdfe9675535d..86c245cf8f9f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4322,12 +4322,6 @@ static const u8 le_simultaneous_roles_uuid[16] = {
 	0x96, 0x46, 0xc0, 0x42, 0xb5, 0x10, 0x1b, 0x67,
 };
 
-/* 15c0a148-c273-11ea-b3de-0242ac130004 */
-static const u8 rpa_resolution_uuid[16] = {
-	0x04, 0x00, 0x13, 0xac, 0x42, 0x02, 0xde, 0xb3,
-	0xea, 0x11, 0x73, 0xc2, 0x48, 0xa1, 0xc0, 0x15,
-};
-
 /* 6fbaf188-05e0-496a-9885-d6ddfdb4e03e */
 static const u8 iso_socket_uuid[16] = {
 	0x3e, 0xe0, 0xb4, 0xfd, 0xdd, 0xd6, 0x85, 0x98,
@@ -4378,17 +4372,6 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 		idx++;
 	}
 
-	if (hdev && ll_privacy_capable(hdev)) {
-		if (hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY))
-			flags = BIT(0) | BIT(1);
-		else
-			flags = BIT(1);
-
-		memcpy(rp->features[idx].uuid, rpa_resolution_uuid, 16);
-		rp->features[idx].flags = cpu_to_le32(flags);
-		idx++;
-	}
-
 	if (hdev && (aosp_has_quality_report(hdev) ||
 		     hdev->set_quality_report)) {
 		if (hci_dev_test_flag(hdev, HCI_QUALITY_REPORT))
@@ -4445,27 +4428,6 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 	return status;
 }
 
-static int exp_ll_privacy_feature_changed(bool enabled, struct hci_dev *hdev,
-					  struct sock *skip)
-{
-	struct mgmt_ev_exp_feature_changed ev;
-
-	memset(&ev, 0, sizeof(ev));
-	memcpy(ev.uuid, rpa_resolution_uuid, 16);
-	ev.flags = cpu_to_le32((enabled ? BIT(0) : 0) | BIT(1));
-
-	// Do we need to be atomic with the conn_flags?
-	if (enabled && privacy_mode_capable(hdev))
-		hdev->conn_flags |= HCI_CONN_FLAG_DEVICE_PRIVACY;
-	else
-		hdev->conn_flags &= ~HCI_CONN_FLAG_DEVICE_PRIVACY;
-
-	return mgmt_limited_event(MGMT_EV_EXP_FEATURE_CHANGED, hdev,
-				  &ev, sizeof(ev),
-				  HCI_MGMT_EXP_FEATURE_EVENTS, skip);
-
-}
-
 static int exp_feature_changed(struct hci_dev *hdev, const u8 *uuid,
 			       bool enabled, struct sock *skip)
 {
@@ -4506,16 +4468,6 @@ static int set_zero_key_func(struct sock *sk, struct hci_dev *hdev,
 	}
 #endif
 
-	if (hdev && use_ll_privacy(hdev) && !hdev_is_powered(hdev)) {
-		bool changed;
-
-		changed = hci_dev_test_and_clear_flag(hdev,
-						      HCI_ENABLE_LL_PRIVACY);
-		if (changed)
-			exp_feature_changed(hdev, rpa_resolution_uuid, false,
-					    sk);
-	}
-
 	hci_sock_set_flag(sk, HCI_MGMT_EXP_FEATURE_EVENTS);
 
 	return mgmt_cmd_complete(sk, hdev ? hdev->id : MGMT_INDEX_NONE,
@@ -4621,71 +4573,6 @@ static int set_mgmt_mesh_func(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
-static int set_rpa_resolution_func(struct sock *sk, struct hci_dev *hdev,
-				   struct mgmt_cp_set_exp_feature *cp,
-				   u16 data_len)
-{
-	struct mgmt_rp_set_exp_feature rp;
-	bool val, changed;
-	int err;
-	u32 flags;
-
-	/* Command requires to use the controller index */
-	if (!hdev)
-		return mgmt_cmd_status(sk, MGMT_INDEX_NONE,
-				       MGMT_OP_SET_EXP_FEATURE,
-				       MGMT_STATUS_INVALID_INDEX);
-
-	/* Changes can only be made when controller is powered down */
-	if (hdev_is_powered(hdev))
-		return mgmt_cmd_status(sk, hdev->id,
-				       MGMT_OP_SET_EXP_FEATURE,
-				       MGMT_STATUS_REJECTED);
-
-	/* Parameters are limited to a single octet */
-	if (data_len != MGMT_SET_EXP_FEATURE_SIZE + 1)
-		return mgmt_cmd_status(sk, hdev->id,
-				       MGMT_OP_SET_EXP_FEATURE,
-				       MGMT_STATUS_INVALID_PARAMS);
-
-	/* Only boolean on/off is supported */
-	if (cp->param[0] != 0x00 && cp->param[0] != 0x01)
-		return mgmt_cmd_status(sk, hdev->id,
-				       MGMT_OP_SET_EXP_FEATURE,
-				       MGMT_STATUS_INVALID_PARAMS);
-
-	val = !!cp->param[0];
-
-	if (val) {
-		changed = !hci_dev_test_and_set_flag(hdev,
-						     HCI_ENABLE_LL_PRIVACY);
-		hci_dev_clear_flag(hdev, HCI_ADVERTISING);
-
-		/* Enable LL privacy + supported settings changed */
-		flags = BIT(0) | BIT(1);
-	} else {
-		changed = hci_dev_test_and_clear_flag(hdev,
-						      HCI_ENABLE_LL_PRIVACY);
-
-		/* Disable LL privacy + supported settings changed */
-		flags = BIT(1);
-	}
-
-	memcpy(rp.uuid, rpa_resolution_uuid, 16);
-	rp.flags = cpu_to_le32(flags);
-
-	hci_sock_set_flag(sk, HCI_MGMT_EXP_FEATURE_EVENTS);
-
-	err = mgmt_cmd_complete(sk, hdev->id,
-				MGMT_OP_SET_EXP_FEATURE, 0,
-				&rp, sizeof(rp));
-
-	if (changed)
-		exp_ll_privacy_feature_changed(val, hdev, sk);
-
-	return err;
-}
-
 static int set_quality_report_func(struct sock *sk, struct hci_dev *hdev,
 				   struct mgmt_cp_set_exp_feature *cp,
 				   u16 data_len)
@@ -4937,7 +4824,6 @@ static const struct mgmt_exp_feature {
 	EXP_FEAT(debug_uuid, set_debug_func),
 #endif
 	EXP_FEAT(mgmt_mesh_uuid, set_mgmt_mesh_func),
-	EXP_FEAT(rpa_resolution_uuid, set_rpa_resolution_func),
 	EXP_FEAT(quality_report_uuid, set_quality_report_func),
 	EXP_FEAT(offload_codecs_uuid, set_offload_codec_func),
 	EXP_FEAT(le_simultaneous_roles_uuid, set_le_simultaneous_roles_func),
@@ -4967,22 +4853,6 @@ static int set_exp_feature(struct sock *sk, struct hci_dev *hdev,
 			       MGMT_STATUS_NOT_SUPPORTED);
 }
 
-static u32 get_params_flags(struct hci_dev *hdev,
-			    struct hci_conn_params *params)
-{
-	u32 flags = hdev->conn_flags;
-
-	/* Devices using RPAs can only be programmed in the acceptlist if
-	 * LL Privacy has been enable otherwise they cannot mark
-	 * HCI_CONN_FLAG_REMOTE_WAKEUP.
-	 */
-	if ((flags & HCI_CONN_FLAG_REMOTE_WAKEUP) && !use_ll_privacy(hdev) &&
-	    hci_find_irk_by_addr(hdev, &params->addr, params->addr_type))
-		flags &= ~HCI_CONN_FLAG_REMOTE_WAKEUP;
-
-	return flags;
-}
-
 static int get_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 			    u16 data_len)
 {
@@ -5017,7 +4887,6 @@ static int get_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 		if (!params)
 			goto done;
 
-		supported_flags = get_params_flags(hdev, params);
 		current_flags = params->flags;
 	}
 
@@ -5097,7 +4966,7 @@ static int set_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
-	supported_flags = get_params_flags(hdev, params);
+	supported_flags = hdev->conn_flags;
 
 	if ((supported_flags | current_flags) != supported_flags) {
 		bt_dev_warn(hdev, "Bad flag given (0x%x) vs supported (0x%0x)",
-- 
2.46.0

