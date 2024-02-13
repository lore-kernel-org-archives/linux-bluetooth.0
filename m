Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7823A6166A
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 21:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707859893; cv=none; b=NShA+kI4VDbNW5L04e1sTiccba3rDzGHp3f8TDBgar05pomdVG4CPbIU/dBpJ5+wYZqqwuRi0cbGIwWA4nPfeJaMSlBynekjDx5tW3FiXSysDtfI+j26+2nTUwDVjBpIlHVx8rwntV7P4XEyEFL/4spKT1v44Wp1t0spr3QxisI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707859893; c=relaxed/simple;
	bh=0ezE8PXtVhyp0L547Whh55X+6aNPZPY4Pjtx17BqPcg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pj60g4lxOtzia+LYsnRD15g7JvPbqqgj1S/cy7+/oiI3n/TWwoGa1anPjHVkhJUJEck3Lcyr+88zPea1Mvy5HctsVwXFFLy5ptKxjcnCIT2fng53kFh7tPyNXFgxxwYpMhAEA3ti3vmn91xlpB242wlNITcRSM0QM3rxPch9Z+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X18bLkqA; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X18bLkqA"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4c02af5c0b6so812491e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 13:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707859888; x=1708464688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yo6FeFXVMwW3CPGb3KApxGYh6w0lH/etWU02HFlTsE8=;
        b=X18bLkqAI0TyspxFQrr2vR0O8hZKpd9Alxi80/+wxeP5+QQzv278af+mHZPRRs58ud
         GMUfDcDI9dzKHRKOb+ZtEVvmDGdi8J8h0WUJ8Rh8gNdg1ksIJsplgc/2qx8TeohHSHpS
         19la8zywPY41qp4ecu2W0dFq/DxWQzryiqkRUkT6yLw2kBLsuVvvJDCUT28cIGR5B4l5
         Lnah5AfJAlFXfYDTxkPMh0rRic/KQ5UwI+Ak6HSxn/QsTS6GU5ejbaDKOgULjissHEST
         koUlv/iKekj12tcm9YDVOubdV7v6a4+RV9aORfKjvF7J966gIVvmafOL0Yfpluq4rKjm
         9tqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707859888; x=1708464688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yo6FeFXVMwW3CPGb3KApxGYh6w0lH/etWU02HFlTsE8=;
        b=MMRQr6/QKT7W9GnoLYd6pzKR4bWNmOvbCKnn15F7Oh7hQA+oC7qfyCwgt9f8H6i54C
         re8BK9t0zw5JR83DJASAP1npi7YoH5W9SbOuArjJFJqEojGlCbGiNIec1cWzTmNy9iac
         ZK8wv5+vK9M+YSrN5c2m1Sv5KtXh00jThddktoRaUCUFERB2yogo98+0/3kvS6MEfBLJ
         LaHItopLuqirVYuwjlxrk7kqJk05mDmhzx0o4hSr0udRpUcskYWUzR4e7dquIYcvxV07
         3U6LnI4rL0ibTkbqN87a+Miw2rolZGIIZapLQQ92+C/QLtnQHbVFoEknge8I9Q4vK/GU
         4j0g==
X-Gm-Message-State: AOJu0Yw4gnReAUXYizSV0ufu06VYvWCCB1f4gzVUJiXzkIPcZpnkycSH
	oZboPCBfDIcf3D1egWbMpfsQiLwyb4icE9YGBeZqXrE05qEmPp6BXe0+r8Me
X-Google-Smtp-Source: AGHT+IGavfMu6a+IUTvVmZGwnYu50OiBvaJXuuATG0WLmgc2VpX2m2fgWsgNGMNzXV0BE7dC7ExLCA==
X-Received: by 2002:a1f:db03:0:b0:4c0:75d9:c88d with SMTP id s3-20020a1fdb03000000b004c075d9c88dmr861188vkg.7.1707859888459;
        Tue, 13 Feb 2024 13:31:28 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id z8-20020a056122148800b004c0149262dcsm1049837vkp.4.2024.02.13.13.31.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 13:31:26 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/3] Bluetooth: hci_sync: Add helper functions to manipulate cmd_sync queue
Date: Tue, 13 Feb 2024 16:31:22 -0500
Message-ID: <20240213213123.403654-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213213123.403654-1-luiz.dentz@gmail.com>
References: <20240213213123.403654-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds functions to queue, dequeue and lookup into the cmd_sync
list.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_sync.h |  12 +++
 net/bluetooth/hci_sync.c         | 132 +++++++++++++++++++++++++++++--
 2 files changed, 136 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index ed334c253ebc..4ff4aa68ee19 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -48,6 +48,18 @@ int hci_cmd_sync_submit(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 			void *data, hci_cmd_sync_work_destroy_t destroy);
 int hci_cmd_sync_queue(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 		       void *data, hci_cmd_sync_work_destroy_t destroy);
+struct hci_cmd_sync_work_entry *
+hci_cmd_sync_lookup_entry(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
+			  void *data, hci_cmd_sync_work_destroy_t destroy);
+int hci_cmd_sync_queue_once(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
+			    void *data, hci_cmd_sync_work_destroy_t destroy);
+void hci_cmd_sync_cancel_entry(struct hci_dev *hdev,
+			       struct hci_cmd_sync_work_entry *entry);
+bool hci_cmd_sync_dequeue(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
+			  void *data, hci_cmd_sync_work_destroy_t destroy);
+bool hci_cmd_sync_dequeue_once(struct hci_dev *hdev,
+			      hci_cmd_sync_work_func_t func, void *data,
+			      hci_cmd_sync_work_destroy_t destroy);
 
 int hci_update_eir_sync(struct hci_dev *hdev);
 int hci_update_class_sync(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index e1fdcb3c2706..5b314bf844f8 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -566,6 +566,17 @@ void hci_cmd_sync_init(struct hci_dev *hdev)
 	INIT_DELAYED_WORK(&hdev->adv_instance_expire, adv_timeout_expire);
 }
 
+static void _hci_cmd_sync_cancel_entry(struct hci_dev *hdev,
+				       struct hci_cmd_sync_work_entry *entry,
+				       int err)
+{
+	if (entry->destroy)
+		entry->destroy(hdev, entry->data, err);
+
+	list_del(&entry->list);
+	kfree(entry);
+}
+
 void hci_cmd_sync_clear(struct hci_dev *hdev)
 {
 	struct hci_cmd_sync_work_entry *entry, *tmp;
@@ -574,13 +585,8 @@ void hci_cmd_sync_clear(struct hci_dev *hdev)
 	cancel_work_sync(&hdev->reenable_adv_work);
 
 	mutex_lock(&hdev->cmd_sync_work_lock);
-	list_for_each_entry_safe(entry, tmp, &hdev->cmd_sync_work_list, list) {
-		if (entry->destroy)
-			entry->destroy(hdev, entry->data, -ECANCELED);
-
-		list_del(&entry->list);
-		kfree(entry);
-	}
+	list_for_each_entry_safe(entry, tmp, &hdev->cmd_sync_work_list, list)
+		_hci_cmd_sync_cancel_entry(hdev, entry, -ECANCELED);
 	mutex_unlock(&hdev->cmd_sync_work_lock);
 }
 
@@ -669,6 +675,115 @@ int hci_cmd_sync_queue(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 }
 EXPORT_SYMBOL(hci_cmd_sync_queue);
 
+static struct hci_cmd_sync_work_entry *
+_hci_cmd_sync_lookup_entry(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
+			   void *data, hci_cmd_sync_work_destroy_t destroy)
+{
+	struct hci_cmd_sync_work_entry *entry, *tmp;
+
+	list_for_each_entry_safe(entry, tmp, &hdev->cmd_sync_work_list, list) {
+		if (func && entry->func != func)
+			continue;
+
+		if (data && entry->data != data)
+			continue;
+
+		if (destroy && entry->destroy != destroy)
+			continue;
+
+		return entry;
+	}
+
+	return NULL;
+}
+
+/* Queue HCI command entry once:
+ *
+ * - Lookup if an entry already exist and only if it doesn't creates a new entry
+ *   and queue it.
+ */
+int hci_cmd_sync_queue_once(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
+			    void *data, hci_cmd_sync_work_destroy_t destroy)
+{
+	if (hci_cmd_sync_lookup_entry(hdev, func, data, destroy))
+		return 0;
+
+	return hci_cmd_sync_queue(hdev, func, data, destroy);
+}
+EXPORT_SYMBOL(hci_cmd_sync_queue_once);
+
+/* Lookup HCI command entry:
+ *
+ * - Return first entry that matches by function callback or data or
+ *   destroy callback.
+ */
+struct hci_cmd_sync_work_entry *
+hci_cmd_sync_lookup_entry(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
+			  void *data, hci_cmd_sync_work_destroy_t destroy)
+{
+	struct hci_cmd_sync_work_entry *entry;
+
+	mutex_lock(&hdev->cmd_sync_work_lock);
+	entry = _hci_cmd_sync_lookup_entry(hdev, func, data, destroy);
+	mutex_unlock(&hdev->cmd_sync_work_lock);
+
+	return entry;
+}
+EXPORT_SYMBOL(hci_cmd_sync_lookup_entry);
+
+/* Cancel HCI command entry */
+void hci_cmd_sync_cancel_entry(struct hci_dev *hdev,
+			       struct hci_cmd_sync_work_entry *entry)
+{
+	mutex_lock(&hdev->cmd_sync_work_lock);
+	_hci_cmd_sync_cancel_entry(hdev, entry, -ECANCELED);
+	mutex_unlock(&hdev->cmd_sync_work_lock);
+}
+EXPORT_SYMBOL(hci_cmd_sync_cancel_entry);
+
+/* Dequeue one HCI command entry:
+ *
+ * - Lookup and cancel first entry that matches.
+ */
+bool hci_cmd_sync_dequeue_once(struct hci_dev *hdev,
+			       hci_cmd_sync_work_func_t func,
+			       void *data, hci_cmd_sync_work_destroy_t destroy)
+{
+	struct hci_cmd_sync_work_entry *entry;
+
+	entry = hci_cmd_sync_lookup_entry(hdev, func, data, destroy);
+	if (!entry)
+		return false;
+
+	hci_cmd_sync_cancel_entry(hdev, entry);
+
+	return true;
+}
+EXPORT_SYMBOL(hci_cmd_sync_dequeue_once);
+
+/* Dequeue HCI command entry:
+ *
+ * - Lookup and cancel any entry that matches by function callback or data or
+ *   destroy callback.
+ */
+bool hci_cmd_sync_dequeue(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
+			  void *data, hci_cmd_sync_work_destroy_t destroy)
+{
+	struct hci_cmd_sync_work_entry *entry;
+	bool ret = false;
+
+	mutex_lock(&hdev->cmd_sync_work_lock);
+	while ((entry = _hci_cmd_sync_lookup_entry(hdev, func, data,
+						   destroy))) {
+		_hci_cmd_sync_cancel_entry(hdev, entry, -ECANCELED);
+		ret = true;
+	}
+	mutex_unlock(&hdev->cmd_sync_work_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL(hci_cmd_sync_dequeue);
+
 int hci_update_eir_sync(struct hci_dev *hdev)
 {
 	struct hci_cp_write_eir cp;
@@ -2881,7 +2996,8 @@ int hci_update_passive_scan(struct hci_dev *hdev)
 	    hci_dev_test_flag(hdev, HCI_UNREGISTER))
 		return 0;
 
-	return hci_cmd_sync_queue(hdev, update_passive_scan_sync, NULL, NULL);
+	return hci_cmd_sync_queue_once(hdev, update_passive_scan_sync, NULL,
+				       NULL);
 }
 
 int hci_write_sc_support_sync(struct hci_dev *hdev, u8 val)
-- 
2.43.0

