Received: from mail-ua2-f41.google.com (mail-ua2-f41.google.com [74.125.226.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1BC37106E
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Oct 2026 19:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791230402; cv=none; b=sT9F7pRxk0W5Zjx1wmeNZoMQEwi55mEa5uAHrFylWY9c5YdfpC697Jdk5pozu6Kzt/AGpa1FVa/YuNWdBTBw21WuVVv0Qhz/QOvrB5wNWGQgRTCDlXI/2PVjVs/r1/i+1EW9RVnPWqCGE6CyLQzOLAOqlpPqQqUfNzwmEuRkgOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791230402; c=relaxed/simple;
	bh=0Y63/p8hUefnir0qLXYF6rWRyh1p1Yoq6zZj6lxx0To=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=IEZpeyYFbiL2V41zqaFk0L19sjCJVXMdLe4DEsplpz/c9S3jNj3pJ1ovowYITKzpePOkCJl/OMlo2DIxpVDNeCSckGEkBrLbokPzfnFnZ7MU9hHdutdEACTlUwUkGI1JI9PwVCwNgcDFI99PvLLIWygSQOLltyhFmkolMRR5fQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krtk5YTN; arc=none smtp.client-ip=74.125.226.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krtk5YTN"
Received: by mail-ua2-f41.google.com with SMTP id a1e0cc1a2514c-98a811d2f51so1206944241.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Oct 2026 12:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791230398; x=1791835198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=S5DfRHc2PioX4e6AZizGT+cXgkDWPt03OHbEjOh688w=;
        b=krtk5YTNnXYpmOayzCDYJfPGKLUfAee4wj8ur9Yevd2Vvk9iPiZQkpoWoQKSKS47Co
         RSoZJ3rUjB5m9MZVFaTj7ijvdwXxD4bGmW/ikJaDGL68EEEiJdSol9dsiFSx+pLLHF0w
         hTE74qh389UNOf+Wj7D4RCb+AavXOmdFdwdYOUCCgyGwm44/j/9w4PccafrdVsPcqf/F
         MpuTqtwcLsk7oAdi5uK9zvKDTmcKmjq7NNwJRBfwGv8ltUtFGarVaUUrDq9XSiiwPIt6
         nmMHANe6p7CWjc/RFzW5aB28u7GwZ/4ZvKzzXRNKkppDe3CgusZvN2QFlmfsKVTgmDOi
         EI2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791230398; x=1791835198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=S5DfRHc2PioX4e6AZizGT+cXgkDWPt03OHbEjOh688w=;
        b=pHCCuOlTSb+dhgfU2f0pntWKqKS30smxYs/plc6e7joKyv8VX6MwUtXHmPckvPiAJg
         lwcPJ8ZGyE0PMO/rDbXwWt/YjoygNd0XgczZfyCYKRbPKjp7RX5BObWwepNqRC5SjjNa
         7Ea/9F18qbg9vdb0qoMIGOBwgaaqeyDmMYa3N5wZjXZ2xEeA3QpjbGps5gCe97KchtyX
         I1+vnNHaRPzzKHXfYozp/86dnRGofHI58t3uosz2wSnrfxK8cFhy71KoOrDaCPFYHtk3
         TFlNDWMn3OxCpcB9xHawo8+AUjKoDehsJng7OiJrZ5dn1AbRY/HHJnZHdYfQgheMhpnt
         Tlog==
X-Gm-Message-State: AFq9FYKZoDo5iDjFJzSgMAi3kzS47BUGg5yetsjZJlzVqI8mdS2MoTSe
	uoGCbvvUDQrN/5zeFvaJF0y++qGsUhsqvB/CKxASj4YjHY87hKoQ6t6LJd/Zk3t3
X-Gm-Gg: AYBFou3rHJGAwxjevOiXP19VclVDuzZBGxaF7K/Rk6yPzgPVcq/hA2sNukOO6I64tiT
	9bY//akUMc47dRD4rJeNQMvYlY1XxPn1nsTgF+flO3Kc0oD/TXU12h+hjRIP7lyrs1SFS8tEbDS
	n8cFNz9EXwq+9Jqbg4DrqvZ82UwnAKY+uFgSj8beAsFPNAAFcR4aGtPgd7d5XJkBhSJlD/BLJlU
	F8x9JLNsLfFOssg0kihIarLkMYwb/iHz9wti9DRxjdGeUu/HanVSCjkBPlYRqRCORyuMungPDnI
	mTJCICgACoK6KNHyDvcl77x93hthVUAYZdAX9m9dTwVlEHmnCQYohDBHT3d1yr3LnCXEGySrKNU
	jr5Q/5V0sFJVtAUW2PvXfJbD81tj1tE0cG7ZYnmfMloVxYbKKfhHXXdifD+Ru0uw0ppcahIpjwD
	8bVTlXF1y09N+EAIUE17u6SAnPKOglQIgdAskUyx7w+q5rN3SHSQFO9nFNyhzTWsQ5twCDdefMe
	zu54FemReroilHIKtbC5j8R1hRHLlRHBM7ea45FYnjMefwHNq8lDkMaAuMjp8be
X-Received: by 2002:a05:6102:50a7:b0:7b4:879c:bb76 with SMTP id ada2fe7eead31-7c0f4884519mr3405026137.21.1791230398488;
        Mon, 05 Oct 2026 12:59:58 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7c0ffaeb6d0sm11197180137.6.2026.10.05.12.59.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 12:59:57 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/4] Bluetooth: MGMT: Fix advertising instances with Global Advertising
Date: Mon,  5 Oct 2026 15:59:45 -0400
Message-ID: <20261005195948.3616794-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Global Advertising, enabled with MGMT_OP_SET_ADVERTISING, uses instance
0 and with extended advertising it has its own advertising set, but
instances were still being treated as if they shared the same set:

 - Add Advertising and Add Extended Advertising Data would return
   success without ever enabling the instance.
 - Removing the last instance would disable all advertising sets,
   stopping Global Advertising while leaving its setting enabled.
 - Disabling Global Advertising would disable all sets, including
   active instances.

Fix this by only overriding instances that share the advertising set of
Global Advertising, and by tracking HCI_LE_ADV_0 rather than HCI_LE_ADV
to determine the state of Global Advertising, which is now also cleared
when all advertising sets are disabled.

Fixes: 0d92808024b4 ("Bluetooth: HCI: Fix tracking of advertisement set/instance 0x00")
Assisted-by: OpenCode:claude-opus-5.5
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_sync.h |  1 +
 net/bluetooth/hci_event.c        |  8 ++-
 net/bluetooth/hci_sync.c         |  2 +-
 net/bluetooth/mgmt.c             | 83 +++++++++++++++++++++++++++-----
 4 files changed, 81 insertions(+), 13 deletions(-)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index a6579a868678..59cb918d1405 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -122,6 +122,7 @@ int hci_disable_per_advertising_sync(struct hci_dev *hdev, u8 instance);
 int hci_remove_advertising_sync(struct hci_dev *hdev, struct sock *sk,
 				u8 instance, bool force);
 int hci_disable_advertising_sync(struct hci_dev *hdev);
+int hci_disable_ext_adv_legacy_instance_sync(struct hci_dev *hdev);
 int hci_clear_adv_instance_sync(struct hci_dev *hdev, struct sock *sk,
 				u8 instance, bool force);
 int hci_update_passive_scan_sync(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a3359aaad001..2c8f6f22a4ee 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1686,8 +1686,12 @@ static u8 hci_cc_le_set_ext_adv_enable(struct hci_dev *hdev, void *data,
 				hci_dev_clear_flag(hdev, HCI_LE_ADV_0);
 
 			/* If just one instance was disabled check if there are
-			 * any other instance enabled before clearing HCI_LE_ADV
+			 * any other instance enabled, including instance 0,
+			 * before clearing HCI_LE_ADV
 			 */
+			if (hci_dev_test_flag(hdev, HCI_LE_ADV_0))
+				goto unlock;
+
 			list_for_each_entry_safe(adv, n, &hdev->adv_instances,
 						 list) {
 				if (adv->enabled)
@@ -1698,6 +1702,8 @@ static u8 hci_cc_le_set_ext_adv_enable(struct hci_dev *hdev, void *data,
 			list_for_each_entry_safe(adv, n, &hdev->adv_instances,
 						 list)
 				adv->enabled = false;
+
+			hci_dev_clear_flag(hdev, HCI_LE_ADV_0);
 		}
 
 		hci_dev_clear_flag(hdev, HCI_LE_ADV);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 1fe11d3ef1aa..19917aa49cb2 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1156,7 +1156,7 @@ int hci_update_random_address_sync(struct hci_dev *hdev, bool require_privacy,
 	return 0;
 }
 
-static int hci_disable_ext_adv_legacy_instance_sync(struct hci_dev *hdev)
+int hci_disable_ext_adv_legacy_instance_sync(struct hci_dev *hdev)
 {
 	struct hci_cp_le_set_ext_adv_enable *cp;
 	struct hci_cp_ext_adv_set *set;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index aea3482e3893..106b35c88c98 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6546,7 +6546,12 @@ static void set_advertising_complete(struct hci_dev *hdev, void *data, int err)
 		return;
 	}
 
-	if (hci_dev_test_flag(hdev, HCI_LE_ADV))
+	/* With extended advertising global advertising (instance 0) has its
+	 * own advertising set so only consider its state, other instances may
+	 * still be enabled.
+	 */
+	if (ext_adv_capable(hdev) ? hci_dev_test_flag(hdev, HCI_LE_ADV_0) :
+				    hci_dev_test_flag(hdev, HCI_LE_ADV))
 		hci_dev_set_flag(hdev, HCI_ADVERTISING);
 	else
 		hci_dev_clear_flag(hdev, HCI_ADVERTISING);
@@ -6566,6 +6571,34 @@ static void set_advertising_complete(struct hci_dev *hdev, void *data, int err)
 	    list_empty(&hdev->adv_instances))
 		return;
 
+	/* With extended advertising instances are not overridden by global
+	 * advertising, except the ones sharing its set, so only (re)start the
+	 * instances that are not already enabled.
+	 *
+	 * Lookup instances by identifier while holding hdev->lock since the
+	 * list may change while waiting for the HCI commands to complete.
+	 */
+	if (ext_adv_capable(hdev)) {
+		u16 i;
+
+		for (i = 1; i <= hdev->le_num_of_adv_sets + 1; i++) {
+			bool enabled;
+
+			hci_dev_lock(hdev);
+			adv_instance = hci_find_adv_instance(hdev, i);
+			enabled = !adv_instance || adv_instance->enabled;
+			hci_dev_unlock(hdev);
+
+			if (enabled)
+				continue;
+
+			err = hci_schedule_adv_instance_sync(hdev, i, true);
+			enable_advertising_instance(hdev, err);
+		}
+
+		return;
+	}
+
 	instance = hdev->cur_adv_instance;
 	if (!instance) {
 		adv_instance = list_first_entry_or_null(&hdev->adv_instances,
@@ -6621,6 +6654,11 @@ static int set_adv_sync(struct hci_dev *hdev, void *data)
 			hci_update_scan_rsp_data_sync(hdev, 0x00);
 			hci_enable_advertising_sync(hdev);
 		}
+	} else if (ext_adv_capable(hdev)) {
+		/* Only disable global advertising (instance 0) leaving other
+		 * instances untouched.
+		 */
+		hci_disable_ext_adv_legacy_instance_sync(hdev);
 	} else {
 		hci_disable_advertising_sync(hdev);
 	}
@@ -8952,6 +8990,21 @@ static bool adv_busy(struct hci_dev *hdev)
 	return pending_find(MGMT_OP_SET_LE, hdev);
 }
 
+/* Global advertising, enabled with MGMT_OP_SET_ADVERTISING, uses instance 0
+ * and takes precedence over any instance that would share its advertising
+ * set: with legacy advertising there is only a single set so all instances
+ * are overridden, whereas with extended advertising only an instance using
+ * handle 0x00 is.
+ */
+static bool adv_overridden_by_global(struct hci_dev *hdev,
+				     struct adv_info *adv)
+{
+	if (!hci_dev_test_flag(hdev, HCI_ADVERTISING))
+		return false;
+
+	return !ext_adv_capable(hdev) || !adv->handle;
+}
+
 static void add_adv_complete(struct hci_dev *hdev, struct sock *sk, u8 instance,
 			     int err)
 {
@@ -9113,12 +9166,12 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 		schedule_instance = cp->instance;
 	}
 
-	/* If the HCI_ADVERTISING flag is set or the device isn't powered or
-	 * there is no instance to be advertised then we have no HCI
-	 * communication to make. Simply return.
+	/* If the instance is overridden by global advertising or the device
+	 * isn't powered or there is no instance to be advertised then we have
+	 * no HCI communication to make. Simply return.
 	 */
 	if (!hdev_is_powered(hdev) ||
-	    hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
+	    adv_overridden_by_global(hdev, adv) ||
 	    !schedule_instance) {
 		rp.instance = cp->instance;
 		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
@@ -9293,8 +9346,11 @@ static int add_ext_adv_params(struct sock *sk, struct hci_dev *hdev,
 		goto unlock;
 	}
 
-	/* Submit request for advertising params if ext adv available */
-	if (ext_adv_capable(hdev)) {
+	/* Submit request for advertising params if ext adv available, unless
+	 * the set is in use by global advertising in which case the params
+	 * will be programmed once the instance is scheduled.
+	 */
+	if (ext_adv_capable(hdev) && !adv_overridden_by_global(hdev, adv)) {
 		cmd = mgmt_pending_new(sk, MGMT_OP_ADD_EXT_ADV_PARAMS, hdev,
 				       data, data_len);
 		if (!cmd) {
@@ -9444,11 +9500,12 @@ static int add_ext_adv_data(struct sock *sk, struct hci_dev *hdev, void *data,
 		schedule_instance = cp->instance;
 	}
 
-	/* If the HCI_ADVERTISING flag is set or there is no instance to
-	 * be advertised then we have no HCI communication to make.
+	/* If the instance is overridden by global advertising or there is no
+	 * instance to be advertised then we have no HCI communication to make.
 	 * Simply return.
 	 */
-	if (hci_dev_test_flag(hdev, HCI_ADVERTISING) || !schedule_instance) {
+	if (adv_overridden_by_global(hdev, adv_instance) ||
+	    !schedule_instance) {
 		if (adv_instance->pending) {
 			mgmt_advertising_added(sk, hdev, cp->instance);
 			adv_instance->pending = false;
@@ -9524,7 +9581,11 @@ static int remove_advertising_sync(struct hci_dev *hdev, void *data)
 	if (err)
 		return err;
 
-	if (list_empty(&hdev->adv_instances))
+	/* Don't disable advertising if global advertising (instance 0) is
+	 * enabled since it is not affected by removing instances.
+	 */
+	if (list_empty(&hdev->adv_instances) &&
+	    !hci_dev_test_flag(hdev, HCI_ADVERTISING))
 		err = hci_disable_advertising_sync(hdev);
 
 	return err;
-- 
2.55.0

