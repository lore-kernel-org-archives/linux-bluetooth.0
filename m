Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C8E46D2AA
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2026 14:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791296112; cv=none; b=kXv+bRDzF5LFwViwFExDBcSJ7OmLJZOdXmRDRrWGzg2vqOngXB3fEZl/681ly/InuZhzN0Q6HxOlbkN4kIDBcJ0BrsUlQzhlVUxxFJQ3MJaIdm9miYCedhHc6KJh6tGeGZWyT9wxmHiyzIC1wRSrCJJGjpqLOpd81iCLy8vntl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791296112; c=relaxed/simple;
	bh=0Y63/p8hUefnir0qLXYF6rWRyh1p1Yoq6zZj6lxx0To=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=siMEsPs2oNtZGq+TKcCAlT/UoxWaP/LrLGFOEpMwMfJY35chwFj/8h4uvIdPTq6IdBB2wdD2/ckQTOGp5WNqFIpEeAOf6LhRzbSM1VpyVRaPbH4RISK2DgDo6TAeNE0/WNT9GgXMGb6kaZPWY3Jn3wiYsvGNDsG8SHy9wSRYOWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJl9pOaG; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJl9pOaG"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-7c19c6721a3so333703137.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Oct 2026 07:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791296109; x=1791900909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=S5DfRHc2PioX4e6AZizGT+cXgkDWPt03OHbEjOh688w=;
        b=fJl9pOaG1+2vsbrtFL9V4z9/Ti56ihyR5FaagqtnsOL61z8PCMCfQt9eqF888zOEj8
         LLwzGAE0AMMbE3CW19+cnDH3rOvyYOdVX/V/9CFhM1yz66KcvwUYmI5eZVaLyYsjdpKE
         3j2nYrwAg6G7yvu2bb4qsyWGCyT+RmbwUsXMdylTwniM0KTe4esl2yr4KZeu1aBvalDP
         Znca1dX8VpLD2gWaoAHou2M/zV1An2nHRcEVpkE6YFJ5Epc8MWobpjxQ0kUt2WPrQjkP
         NXD0AfMZGfMFeetui8YmDWggf54LvSN3S6aanoeiaHeRFmJ+nt7/4SXfcFrPUU9pEWi2
         6JDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791296109; x=1791900909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=S5DfRHc2PioX4e6AZizGT+cXgkDWPt03OHbEjOh688w=;
        b=XlbL21chBmW0wCtsRkFHr8tDcVV5S104QI1sGJmIXkmAucNWPov1XV+hjnzPzSsoX1
         MHs7OuYDWYsXfg7tpH4NHYcT1kEj6MVl8qEt+RNI5KtFO+RnUm3bxXl2I2DAcweILiKt
         8TfSZZ3onE0alDGEHckJK2GAG2Z0SbxRrzQm0IoByTcUokVMUi6e3heSUXaYHjYrahOj
         76TMalw9Mc+VOwLWWm3akATDTylPfE+Ewj/QwuX+iVZ0leaDcl5rUnpoqsbOs/4k9jE4
         Fn9JrojL5W1WF1RYY/SvxwZfxrDj3XE/4LAs9y5gtSilV3hwFo/zMJvw+4tAvlptb+DB
         prZQ==
X-Gm-Message-State: AFq9FYJlB9emTbRmNNOufJ0MTapTb2InMF8oLZAVAW4KI325pWIhre8A
	P7JDWogg+8Jz1LCFGpRG/vojV1RbDmD8x75zyWnGoKR6U7MBzqQ2IoXY0kU8WeKZ
X-Gm-Gg: AYBFou2Kq5wDeuAjg5E7wLeQcTOUI15m5BuQVotJTitQYcy2CHg7xxiG8U1mnM4MfDE
	raQdORHcaEDky9x0Gp5CLQO+Ld/RA9JpIwWYMJKFEEFhPBhHZpEvsQ5O+lugN7xx9Tu6PCQRGtI
	rMnZgCb4aH1RmUMCc1oaAChRIEKvqV6qr2hfBwErYkOA21V3ULrru8kXGne6osWgfjzvlRVUcZD
	XbVZuDt/2zBooVsHBgtvNDy6IMlxbXa6PxqOWT/23/Ug8jTBALEEONY9w1e7YZtVCorZ2CEIvaU
	IBB6V9y8Szlc5On6KYRDOJE4bEikpTVdC2w+XMhe5P6VDRK/5m0McGf8AikKiHt9Q0T3xVVsmLA
	yDm5HFWFZyfxlMyTUxHKwcNhtm51oi2GzHjRocueBQlIp70pGDAN7/XUMZ+j9WT6nSaM9sSToOo
	U9AEfNlg9wI39LI3gK0v5xXP5JqmzMkC1BscVfsaDn1nGaMQ9OauyzbJUsUPevDTw/cXYsugg6t
	BKOTQ9mr/GacHdKmrqraEZXyzUqeEBxAeRpqhwEc4YtbQstqVPB94P+tKmVERHy
X-Received: by 2002:a05:6102:a54:b0:7c3:978f:c5eb with SMTP id ada2fe7eead31-7c879efbbf5mr425124137.9.1791296109277;
        Tue, 06 Oct 2026 07:15:09 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7c0ff5c49a9sm13235132137.4.2026.10.06.07.15.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 07:15:08 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 1/4] Bluetooth: MGMT: Fix advertising instances with Global Advertising
Date: Tue,  6 Oct 2026 10:14:59 -0400
Message-ID: <20261006141502.3789138-1-luiz.dentz@gmail.com>
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

