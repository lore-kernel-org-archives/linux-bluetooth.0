Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AD256741
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 13:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707832671; cv=none; b=tkibxjUNi4x7hK0LxfXNmAfe+43b6HA8UQ4ccdizcvoLen9vfvzxGPdCDRKCTBDacYbm/S3DuMVPT5OxHhoE13nxOqyr6+BS/xKA2jWt9ez/B+2Ozx6piWv/F+8jKYLX3XxbWUnGCwB0vAlSXLfPoazTSj9aR8FPlgWaiPGBOHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707832671; c=relaxed/simple;
	bh=vHuWy/mRLSq/hAr8cCSDfTqK/A9V5ZUYfIkguwywZ64=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=MKcGNncCgB1n3YDKVxmy1OGgLKlC96pAbJxGsl1OAQ8N2nheOpEnQmC4YCFwCqQV4/TjP7HGMUUTcE9BQBIQAKODCMF4+Gfif7M/xQkr/DsqoovyoM40xARa64RwBCaFqRAMdVQCTsPufptX15QmtdXuF9E91TdEKuNiXZuCVpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4Wz6mDN; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4Wz6mDN"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4c081a16e6dso543172e0c.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 05:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707832668; x=1708437468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=t6PQWUPGn05DAKpKjXotRLmV9N90UuFa9ReL2mkfGmE=;
        b=O4Wz6mDNHAhhmQF6+43bZje+hH7TROi/K8+RN67hh7HyVnmsmcCF/PdxJCfopwGmi0
         kHG9ShwDQv259gcbw00O2OlnS7yLj3EMzycTeCOIgR3XIJKokx3xZNeVvQBdTOgG83kG
         INjrMGCDsRNMmphIMlEAr4lZut9EIdTG40+qZeYGvPJWuUp47ZtLG5KWLEyrt3s9ncrp
         fmO0xXc9pqjJlwx7LRDfXyVRtE0SHawI7tWAXn85KmMs8wJ9JrNsrR1AO8sqlDVgIlGY
         P/j679KRycSVJXRRIM6Dyw6A0c0DS1+2Aw9zc/3gz3VwTvxXFvMgS1W2h10s2xIxLv/J
         4HoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707832668; x=1708437468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t6PQWUPGn05DAKpKjXotRLmV9N90UuFa9ReL2mkfGmE=;
        b=lcn6fkd92019SG0VC00GzJGfppSf+RfWRW25e87ux1J9+aKchplahLey/KyLyWV0Jl
         mcKA+c5zOqwXC3ePBYkC01aApgse1eXxCo8hH9I13uhs9ArmCkwpH0MXz+lG3Qt7zpRC
         LZvPRYKz7uInGSsQDIwIkcYAD3Mj1nbdQactmTXnST6xCdX+ckiV1zU1dNBjBoCOobyP
         iXxvorpf/AzsqDIB8jrZEqAEB+DqvJIIjgyrr9Mcn+IHlsajUz1Lgys6GDfKqjc+9Ulh
         Mi5ozCc1ook+fcF6dtJswDOg1bXB+tOt88nqSUhcfyRmWChGG6MOafKRay387dlVzUKT
         NEow==
X-Gm-Message-State: AOJu0Yz26DJokgj891gxn/OP1YSJT6fnu7LBKYS5VAya6mACQt3EhW9C
	V8rmevbXbK4o0j0SItolEoFGkMvt6fv0BwwIuU3wflL5yatv9krZXcl4rkK5
X-Google-Smtp-Source: AGHT+IGxdAVv2X08ggInxW+QcN4l0XCGd+IEnA+IL1Nw6x7njXc7as9FqlPhQLs+o73YwxH1NAMS3g==
X-Received: by 2002:a1f:6dc1:0:b0:4c0:254f:75d5 with SMTP id i184-20020a1f6dc1000000b004c0254f75d5mr5824715vkc.10.1707832668065;
        Tue, 13 Feb 2024 05:57:48 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id u16-20020a056122061000b004bd912e07acsm942589vkp.31.2024.02.13.05.57.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 05:57:47 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RESEND v1] Bluetooth: hci_sync: Add hci_cmd_sync_queue_once
Date: Tue, 13 Feb 2024 08:57:46 -0500
Message-ID: <20240213135746.82167-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds hci_cmd_sync_queue_once which can be used for callback that
shall be schedule only once.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_sync.h |  5 +++
 net/bluetooth/hci_sync.c         | 56 +++++++++++++++++++++++++++-----
 2 files changed, 53 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index ed334c253ebc..3f9db5930530 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -48,6 +48,11 @@ int hci_cmd_sync_submit(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 			void *data, hci_cmd_sync_work_destroy_t destroy);
 int hci_cmd_sync_queue(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 		       void *data, hci_cmd_sync_work_destroy_t destroy);
+bool hci_cmd_sync_lookup(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
+			 void *data, hci_cmd_sync_work_destroy_t destroy,
+			 bool cancel);
+int hci_cmd_sync_queue_once(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
+			    void *data, hci_cmd_sync_work_destroy_t destroy);
 
 int hci_update_eir_sync(struct hci_dev *hdev);
 int hci_update_class_sync(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index e1fdcb3c2706..8746cfadd529 100644
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
 
@@ -669,6 +675,39 @@ int hci_cmd_sync_queue(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 }
 EXPORT_SYMBOL(hci_cmd_sync_queue);
 
+bool hci_cmd_sync_lookup(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
+			 void *data, hci_cmd_sync_work_destroy_t destroy,
+			 bool cancel)
+{
+	struct hci_cmd_sync_work_entry *entry, *tmp;
+
+	mutex_lock(&hdev->cmd_sync_work_lock);
+	list_for_each_entry_safe(entry, tmp, &hdev->cmd_sync_work_list, list) {
+		if (entry->func == func && entry->data == data &&
+		    entry->destroy == destroy) {
+			if (cancel)
+				_hci_cmd_sync_cancel_entry(hdev, entry,
+							   -ECANCELED);
+			mutex_unlock(&hdev->cmd_sync_work_lock);
+			return true;
+		}
+	}
+	mutex_unlock(&hdev->cmd_sync_work_lock);
+
+	return false;
+}
+EXPORT_SYMBOL(hci_cmd_sync_lookup);
+
+int hci_cmd_sync_queue_once(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
+			    void *data, hci_cmd_sync_work_destroy_t destroy)
+{
+	if (hci_cmd_sync_lookup(hdev, func, data, destroy, false))
+		return 0;
+
+	return hci_cmd_sync_queue(hdev, func, data, destroy);
+}
+EXPORT_SYMBOL(hci_cmd_sync_queue_once);
+
 int hci_update_eir_sync(struct hci_dev *hdev)
 {
 	struct hci_cp_write_eir cp;
@@ -2881,7 +2920,8 @@ int hci_update_passive_scan(struct hci_dev *hdev)
 	    hci_dev_test_flag(hdev, HCI_UNREGISTER))
 		return 0;
 
-	return hci_cmd_sync_queue(hdev, update_passive_scan_sync, NULL, NULL);
+	return hci_cmd_sync_queue_once(hdev, update_passive_scan_sync, NULL,
+				       NULL);
 }
 
 int hci_write_sc_support_sync(struct hci_dev *hdev, u8 val)
-- 
2.43.0

