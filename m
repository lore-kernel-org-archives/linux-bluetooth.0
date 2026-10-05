Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4585449502C
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Oct 2026 17:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791222752; cv=none; b=VRNQot4+re3lFyDlf37TGgK2wBpAKsF8WVKDY1YtQExOokaA50TvvesfspeS7fIhYqDWPfN1ratKmsZ8Bg20v0c88mDfwQpWlaPE1zZ2RADxzvxoxElbyA//kgnC+BX8y1lAqRVw1ytjjlRkIMfdzOyxDUJaqGrhcxZlfybAZps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791222752; c=relaxed/simple;
	bh=0Y63/p8hUefnir0qLXYF6rWRyh1p1Yoq6zZj6lxx0To=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Q+7IxCLJeaVeKkij4+4o2Msw77b/AtPymXHjSA+GsLUkxom1Ex3hURXBhVoIElBLHiJE5q1aj44GktRdIlKeMJHhpHF3zQOK8FAvBQrerpsXXZbM4pztcBBtwdyttdTTrq9Y+b3s4ITk/2ZUx7yHziLYPwDqdzIMxU/08J7+prk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2VS21vX; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2VS21vX"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-98c7ad684d3so667004241.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Oct 2026 10:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791222749; x=1791827549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=S5DfRHc2PioX4e6AZizGT+cXgkDWPt03OHbEjOh688w=;
        b=P2VS21vX1+Jy8imeEGRCVHNdCBv0J1HX9VizId46cOXBPHAMYAtI9b2wXBJ86/Di2b
         TMos9freO0fMf1cye6k7ud7iM3fIRpi7E38RMBBl7zxdMUkjHm/c64OFNXwwnNwSEOdV
         aQXptHYCggmjgkvlqHzACENTbZLDdy7UGsMWPyojzih0PhQgl62tOE3vAjjIrqN1qwX1
         Pw7pwIEEZX/p81M/ySFaN+o+LeIR8rEQyFkq7w4PRzaCwIXd20O1B2cuJrBmZPaGUnVR
         jhsC93frQVawFjMCfu6WB7chUZbbq8SWJBaNXlSV2pDXY7Mv9YNSXqigRZV6pJsAvqke
         ldhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791222749; x=1791827549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=S5DfRHc2PioX4e6AZizGT+cXgkDWPt03OHbEjOh688w=;
        b=0+lSzqWbU9OhMq9A1NYBNdDUjkJDeDEoqQyBfTWYLqnOQU4F1ykx8qoZtT1/8P9yQc
         aPmnhSiHm9XerPbxWOGMFEbMhDa/vpmksyNql5VCgefm3OPTRa8PSTlPf8cENgh94jJt
         c+T4F7MW0EcHYDeRFHM3i4lVm3zkMP4Q64eZVSs6r2TSJv9+1pddbotWw9RJoJeXCWYj
         JhADoPT4sqk4YIdtmz8xv7jkwh8J8d/MgwIcjLVBKLyKn6coaQ4+IJBi4dgOWByCBj9s
         s6QEwzrJfrV/CXfYhhzxohKTdsf97XZIgtpdHoYnO88r3a3MOeu4Zp1qJxsxiOtxbNeX
         7KtQ==
X-Gm-Message-State: AFq9FYJSvMfeZoFRgSCWuto1pwX2W4nb4noSqwjPSYNehSE1PNknhxBM
	HTT2kUzZ1uXpQqXLlrxne83Znkp8gqOIbGuzp//cNw6+1yAgu2ihe3sOZXqx054f
X-Gm-Gg: AYBFou0ksXgXaRVJMC7NafLkHSQr9epUi13v3/VndPMFu1/v+gFSQsqhwe1Gp5IUtNT
	Mrp7RlKXLTVSYCRAA5A/LJvZRskYLoaN+It2Qhiu5H06JQlYz7gdYdWV+z3YxARaqejzmf01hY/
	uOT1HHeB43S/Q1q6nxcOBTTjwvo7+5mczzxNcmziO4nHgvsxC7M6xl3cuhrJmCHrJt8vvx59Z2G
	OmLcU9kMbN4c6tJqMPr/LnJnKJ672O3+c5H4VkjUgW1Lcx4XLoesv1+SsqtBJO9ByRBJPS1pmgd
	i7kg9Xs3t25FEuUITxeq4HIM/pzmtzYiqRZAbwDS1uXwyxUnVn/ez8wEc60VnAPL2sS+Dabnyvh
	b6XUfWM7+SZbITjJU6Yj8VKGUWphGpwhNnkudcePMtglCobULL6pDBTUQVwXPTE08GMZgmHGjoT
	PiCn+7xjnpV32TrwqBBwgYGbqJFBXtCbiW8W7xaNsXAEvrQy1660nBGFWDJxmX7d+GoBeLZyFrb
	zg9rbsPFpS94F0JFDYohk3XCot2RT2IadWOKeGge+olvKbFwYZ/vSrCJwmJCvaMqhAsoPuL+Qs=
X-Received: by 2002:a05:6122:508:b0:5d1:dd67:3a02 with SMTP id 71dfb90a1353d-5de6b0c1a6bmr2636771e0c.10.1791222748990;
        Mon, 05 Oct 2026 10:52:28 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5e54eee558bsm25655e0c.7.2026.10.05.10.52.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 10:52:28 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/4] Bluetooth: MGMT: Fix advertising instances with Global Advertising
Date: Mon,  5 Oct 2026 13:52:16 -0400
Message-ID: <20261005175219.3547838-1-luiz.dentz@gmail.com>
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

