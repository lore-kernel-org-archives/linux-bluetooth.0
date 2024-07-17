Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFC028DD1
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jul 2024 19:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721245260; cv=none; b=c6jBNRNnf9adyY8rhBU8McwsRe2G+g8+HgwttgRLFhaxtP50a5tGcKHcrOA4wuxKF9erdpp1QHpog472Sx8LYJvaPyquhN3QbouVm7nPWFNir06IUGSBd1C/O/6D80muGvw9vbPNV3+AKsEjyo3RS8hVuJ47dVBevq347Qp8Iog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721245260; c=relaxed/simple;
	bh=/y+3uPIHccYtlLN40n/Fj6suqBQFDf4vdRXQlySZmWw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=L07wT2ipdGc374o+n79RbvWMUA1tur6Fb6dbQ62uloa4WLgJt8EZ1WpOZJcvs+ivofmbyF3BxD+hTwtgwJbod3tio4ev4zTFyb71V/YSNIuatoqRuZaMiPXmn7qh+B3CatJCcBo8f0LdNheSg73oxURvT0uDv4UW5wT/EUhmsUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BkrKqSLB; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkrKqSLB"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4f301629cfaso17806e0c.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jul 2024 12:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721245256; x=1721850056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=EI0Bb4VZG9YK2OXnYCOBiHpBDkZ/ankLiHDKoaSAdlk=;
        b=BkrKqSLBnbRRwRyCAYHOQSfBTw2diwYbXuNh7goIGEt4RbMQGWRjDMXYqx8T9pFnyL
         nJD5L3MHLwrcnCMvMl42PneQ3XsveBK1vvqyxXhDp2h+Cfe9yDHblhXQGHiVNIXM2TR1
         NDScR+9B15FxR9KUyYqcPvk+qTEauYAF5cO8w4nG90aSVCNHaZ7NFqi96arEoRptcin6
         6YopHbbzSZjO4wNZ3+81PAg39CY3oz1BikY01okhXL50Ea42uOpPln/oy2IjpRuBVRIV
         N3Lz42I/Gybv2uc3ANLFZwSxb+3LZ2POrg23vgQSf3aLnq6i4yeAoTDR+8oHa9ydvzPh
         HNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721245256; x=1721850056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EI0Bb4VZG9YK2OXnYCOBiHpBDkZ/ankLiHDKoaSAdlk=;
        b=Ykr5G3eE6iSLjoC/uX6xAFDCPLUbzODWRAu/pbraiKUrHfE/WKH5Xw4NU5AoSYkfw2
         sMhpuecKATAN/1QBFQyYtlk6QarZSrlFItMGb6suTXFNdOsb0jfTsFY8DSXU4jpO3Xil
         sqoDzLKFszOSlv6aM8A3Jn70S2VXatPDTVUsOY8lnQIklmmA0rXKKdxceQqvLTfHQ9rK
         ucMBCnglxCw0unXjUDcd9yhq31i3GCa2p2YARXWQGv7OvntFpzWmppepvmkP2SzJhzFt
         rzyDPTkJzLwGiF+R1fcTT/PXlT4/nuwPqBTWRLHlZOkiL8w0DrvVBfAEFpokNwBEplMn
         nhuA==
X-Gm-Message-State: AOJu0Ywhjyq5m2CKcjCV9lx40fy3TSLcBvgUnoVwJNhVN2uEeDAHR/sq
	zoMiS7s8as9P2kdsVHUFGZoubFP4FgkapUrGhjkKapZra06Cjxsq0cS1BA==
X-Google-Smtp-Source: AGHT+IEXDuHUjYeGKRz1EDhBNM2ZYYjtf2C37pzVuuOZI/xl8K4vPY7fu9mbf62Ndx4Tr0OfhW2glA==
X-Received: by 2002:a05:6122:2a10:b0:4f2:ed80:2a3d with SMTP id 71dfb90a1353d-4f4df89fa6amr3479347e0c.10.1721245255916;
        Wed, 17 Jul 2024 12:40:55 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4f4d72476b9sm554791e0c.55.2024.07.17.12.40.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 12:40:54 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v1] Bluetooth: MGMT: Mark LL Privacy as stable
Date: Wed, 17 Jul 2024 15:40:53 -0400
Message-ID: <20240717194053.889081-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
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
 net/bluetooth/hci_core.c         |   4 +
 net/bluetooth/hci_sync.c         |  44 +++++-----
 net/bluetooth/mgmt.c             | 133 +------------------------------
 5 files changed, 31 insertions(+), 162 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index e372a88e8c3f..d9ee162ebc3b 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -419,7 +419,6 @@ enum {
 	HCI_FORCE_BREDR_SMP,
 	HCI_FORCE_STATIC_ADDR,
 	HCI_LL_RPA_RESOLUTION,
-	HCI_ENABLE_LL_PRIVACY,
 	HCI_CMD_PENDING,
 	HCI_FORCE_NO_MITM,
 	HCI_QUALITY_REPORT,
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 31020891fc68..c263e6affee9 100644
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
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8a4ebd93adfc..1d20569f1cda 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2648,6 +2648,10 @@ int hci_register_dev(struct hci_dev *hdev)
 	if (hdev->wakeup)
 		hdev->conn_flags |= HCI_CONN_FLAG_REMOTE_WAKEUP;
 
+	/* Mark Address Resolution if LL Privacy is supported */
+	if (ll_privacy_capable(hdev))
+		hdev->conn_flags |= HCI_CONN_FLAG_ADDRESS_RESOLUTION;
+
 	hci_sock_dev_event(hdev, HCI_DEV_REG);
 	hci_dev_hold(hdev);
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index a31d39a821f4..fca40fd561fb 100644
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
@@ -3043,7 +3043,7 @@ static int hci_passive_scan_sync(struct hci_dev *hdev)
  * If there are devices to scan:
  *
  * Disable Scanning -> Update Accept List ->
- * use_ll_privacy((Disable Advertising) -> Disable Resolving List ->
+ * ll_privacy_capable((Disable Advertising) -> Disable Resolving List ->
  * Update Resolving List -> Enable Resolving List -> (Enable Advertising)) ->
  * Enable Scanning
  *
@@ -3397,7 +3397,7 @@ int hci_update_name_sync(struct hci_dev *hdev)
  *
  * HCI_SSP_ENABLED(Enable SSP)
  * HCI_LE_ENABLED(Enable LE)
- * HCI_LE_ENABLED(use_ll_privacy(Add local IRK to Resolving List) ->
+ * HCI_LE_ENABLED(ll_privacy_capable(Add local IRK to Resolving List) ->
  * Update adv data)
  * Enable Authentication
  * lmp_bredr_capable(Set Fast Connectable -> Set Scan Type -> Set Class ->
@@ -5315,7 +5315,7 @@ int hci_stop_discovery_sync(struct hci_dev *hdev)
 	}
 
 	/* Resume advertising if it was paused */
-	if (use_ll_privacy(hdev))
+	if (ll_privacy_capable(hdev))
 		hci_resume_advertising_sync(hdev);
 
 	/* No further actions needed for LE-only discovery */
@@ -5824,7 +5824,7 @@ static int hci_active_scan_sync(struct hci_dev *hdev, uint16_t interval)
 
 failed:
 	/* Resume advertising if it was paused */
-	if (use_ll_privacy(hdev))
+	if (ll_privacy_capable(hdev))
 		hci_resume_advertising_sync(hdev);
 
 	/* Resume passive scanning */
@@ -6600,7 +6600,7 @@ int hci_get_random_address(struct hci_dev *hdev, bool require_privacy,
 		/* If Controller supports LL Privacy use own address type is
 		 * 0x03
 		 */
-		if (use_ll_privacy(hdev))
+		if (ll_privacy_capable(hdev))
 			*own_addr_type = ADDR_LE_DEV_RANDOM_RESOLVED;
 		else
 			*own_addr_type = ADDR_LE_DEV_RANDOM;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 40d4887c7f79..2e766b8391f5 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4318,12 +4318,6 @@ static const u8 le_simultaneous_roles_uuid[16] = {
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
@@ -4374,17 +4368,6 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
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
@@ -4441,27 +4424,6 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
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
@@ -4502,16 +4464,6 @@ static int set_zero_key_func(struct sock *sk, struct hci_dev *hdev,
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
@@ -4617,71 +4569,6 @@ static int set_mgmt_mesh_func(struct sock *sk, struct hci_dev *hdev,
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
@@ -4933,7 +4820,6 @@ static const struct mgmt_exp_feature {
 	EXP_FEAT(debug_uuid, set_debug_func),
 #endif
 	EXP_FEAT(mgmt_mesh_uuid, set_mgmt_mesh_func),
-	EXP_FEAT(rpa_resolution_uuid, set_rpa_resolution_func),
 	EXP_FEAT(quality_report_uuid, set_quality_report_func),
 	EXP_FEAT(offload_codecs_uuid, set_offload_codec_func),
 	EXP_FEAT(le_simultaneous_roles_uuid, set_le_simultaneous_roles_func),
@@ -4963,22 +4849,6 @@ static int set_exp_feature(struct sock *sk, struct hci_dev *hdev,
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
@@ -5013,7 +4883,6 @@ static int get_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 		if (!params)
 			goto done;
 
-		supported_flags = get_params_flags(hdev, params);
 		current_flags = params->flags;
 	}
 
@@ -5093,7 +4962,7 @@ static int set_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
-	supported_flags = get_params_flags(hdev, params);
+	supported_flags = hdev->conn_flags;
 
 	if ((supported_flags | current_flags) != supported_flags) {
 		bt_dev_warn(hdev, "Bad flag given (0x%x) vs supported (0x%0x)",
-- 
2.45.2

