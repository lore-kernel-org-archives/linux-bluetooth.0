Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAEEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 May 2022 23:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359520AbiELXsj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 May 2022 19:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238274AbiELXsi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 May 2022 19:48:38 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDEE880F8
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 May 2022 16:48:37 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id n10so6574302pjh.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 May 2022 16:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KVKWBQbALvHxNistD9xC6wNABHokBOR7u6QCdSS79Sc=;
        b=lYZvchYdVCVX7whkCkAQmFjJfqwiermL1Gf/hq/VxQyzNtiEVq3VhmBi2/EmGyPK8Q
         zQaCi1WgjK7cw9wHTF9oZVL2FPE4spts2s3SCUg85bcfW6d8o3I0LG8Or9vxmdCnGInl
         h9uzQAlDT2j/W5kOKbFZMuAVDb5OdRVZ99gfX3Xke5L+RvKu6hzEWh1+Bnzbu4eSOgLO
         MSN0oT3MG4OYZRoNI1Q1ZVHsmNVfX8IKogYy2TGLDwHs0tEXEmhRzbkAgIPTDa+FXVw7
         HiFaUyKwBm0yeIIEOR8AHw3ezkQWf4Z/qQ+Ih8vBrSoWrVbH9YEh4/u5aD2tDAORxFzv
         5K0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KVKWBQbALvHxNistD9xC6wNABHokBOR7u6QCdSS79Sc=;
        b=lWehfbrT/PE60S1tX+Y3UX4jGobkDQEAZJO37PxXzBMBsM/JK4QdIfmobkLy9AniEe
         DJQdi45g9bn3AbtPyjGFW7swvG7c+HuJkjo61ploprX19H0CA6GfHZXy7Yfncz4eCoy4
         Pnp1DWr23JqnBbVCeJeoPUB5PPsOz6MBc4Ds9almGjWWHY7D7DAK1WHkS1PqYftAlDOZ
         DICsYm8cpJdjujXxF6iWtw8kyRJH8QolxM6+h0iVyC6Le6nkYo+cvPk2LfLmq94jZzeS
         SEKaNMxG2/c+IdJedSoX9JKrYPMfY50+X5ZNJ7fTMrI4UkWt8tqbL72ShRaOEdYhzhJ3
         i9cQ==
X-Gm-Message-State: AOAM531xXv3s57hecbdc3omQZJLXOBtwKyfaQb4U5HWltz9/z7LYP8Pi
        3RFTmNloJXy1LlbNt6z/u3nB7eTKMGs=
X-Google-Smtp-Source: ABdhPJyx4rNgMi9QDLxX8C8ofSaHJpXp804TcuYsF+7lEWrhlovhekVZOVPKcrtfstWRVFrR2hyIgA==
X-Received: by 2002:a17:90b:4c43:b0:1dc:d759:76f2 with SMTP id np3-20020a17090b4c4300b001dcd75976f2mr13525178pjb.191.1652399316873;
        Thu, 12 May 2022 16:48:36 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id im2-20020a170902bb0200b0015e8d4eb1bdsm498173plb.7.2022.05.12.16.48.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 16:48:36 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] device: Fix enabling wake support without RPA Resolution
Date:   Thu, 12 May 2022 16:48:35 -0700
Message-Id: <20220512234835.1042988-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If device uses RPA it shall only enable wakeup if RPA Resolution has
been enabled otherwise it cannot be programmed in the acceptlist which
can cause suspend to fail.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=215768
---
 src/adapter.c | 34 ++++++++++++++++++++++++++++------
 src/adapter.h | 10 ++++++++++
 src/device.c  | 14 ++++++++++++++
 src/device.h  |  1 +
 4 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index db2624c60..f7faaa263 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4761,6 +4761,9 @@ static void load_devices(struct btd_adapter *adapter)
 		if (!device)
 			goto free;
 
+		if (irk_info)
+			device_set_rpa(device, true);
+
 		btd_device_set_temporary(device, false);
 		adapter_add_device(adapter, device);
 
@@ -9569,8 +9572,9 @@ static bool set_blocked_keys(struct btd_adapter *adapter)
 						adapter, NULL);
 }
 
-#define EXP_FEAT(_uuid, _func) \
+#define EXP_FEAT(_flag, _uuid, _func) \
 { \
+	.flag = _flag, \
 	.uuid = _uuid, \
 	.func = _func, \
 }
@@ -9692,15 +9696,18 @@ static void codec_offload_func(struct btd_adapter *adapter, uint8_t action)
 }
 
 static const struct exp_feat {
+	uint32_t flag;
 	const struct mgmt_exp_uuid *uuid;
 	void (*func)(struct btd_adapter *adapter, uint8_t action);
 } exp_table[] = {
-	EXP_FEAT(&debug_uuid, exp_debug_func),
-	EXP_FEAT(&le_simult_central_peripheral_uuid,
+	EXP_FEAT(EXP_FEAT_DEBUG, &debug_uuid, exp_debug_func),
+	EXP_FEAT(EXP_FEAT_LE_SIMULT_ROLES, &le_simult_central_peripheral_uuid,
 		 le_simult_central_peripheral_func),
-	EXP_FEAT(&quality_report_uuid, quality_report_func),
-	EXP_FEAT(&rpa_resolution_uuid, rpa_resolution_func),
-	EXP_FEAT(&codec_offload_uuid, codec_offload_func),
+	EXP_FEAT(EXP_FEAT_BQR, &quality_report_uuid, quality_report_func),
+	EXP_FEAT(EXP_FEAT_RPA_RESOLUTION, &rpa_resolution_uuid,
+		rpa_resolution_func),
+	EXP_FEAT(EXP_FEAT_CODEC_OFFLOAD, &codec_offload_uuid,
+		codec_offload_func),
 };
 
 static void read_exp_features_complete(uint8_t status, uint16_t length,
@@ -10451,3 +10458,18 @@ bool btd_has_kernel_features(uint32_t features)
 {
 	return (kernel_features & features) ? true : false;
 }
+
+bool btd_adapter_has_exp_feature(struct btd_adapter *adapter, uint32_t feature)
+{
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(exp_table); i++) {
+		const struct exp_feat *feat = &exp_table[i];
+
+		if ((feat->flag & feature) && queue_find(adapter->exps, NULL,
+							feat->uuid->val))
+			return true;
+	}
+
+	return false;
+}
diff --git a/src/adapter.h b/src/adapter.h
index 35deb1d11..688ed51c6 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -254,6 +254,16 @@ void btd_adapter_for_each_device(struct btd_adapter *adapter,
 
 bool btd_le_connect_before_pairing(void);
 
+enum experimental_features {
+	EXP_FEAT_DEBUG			= 1 << 0,
+	EXP_FEAT_LE_SIMULT_ROLES	= 1 << 1,
+	EXP_FEAT_BQR			= 1 << 2,
+	EXP_FEAT_RPA_RESOLUTION		= 1 << 3,
+	EXP_FEAT_CODEC_OFFLOAD		= 1 << 4,
+};
+
+bool btd_adapter_has_exp_feature(struct btd_adapter *adapter, uint32_t feature);
+
 enum kernel_features {
 	KERNEL_CONN_CONTROL		= 1 << 0,
 	KERNEL_BLOCKED_KEYS_SUPPORTED	= 1 << 1,
diff --git a/src/device.c b/src/device.c
index b0309a1e7..faf071876 100644
--- a/src/device.c
+++ b/src/device.c
@@ -178,6 +178,7 @@ struct btd_device {
 	uint8_t		conn_bdaddr_type;
 	bdaddr_t	bdaddr;
 	uint8_t		bdaddr_type;
+	bool		rpa;
 	char		*path;
 	bool		bredr;
 	bool		le;
@@ -1449,6 +1450,12 @@ static bool device_get_wake_support(struct btd_device *device)
 
 void device_set_wake_support(struct btd_device *device, bool wake_support)
 {
+	if (device->rpa && !btd_adapter_has_exp_feature(device->adapter,
+						EXP_FEAT_RPA_RESOLUTION)) {
+		warn("Unable to set wake_support without RPA resolution");
+		return;
+	}
+
 	device->wake_support = wake_support;
 
 	/* If wake configuration has not been made yet, set the initial
@@ -4583,11 +4590,18 @@ void device_set_class(struct btd_device *device, uint32_t class)
 						DEVICE_INTERFACE, "Icon");
 }
 
+void device_set_rpa(struct btd_device *device, bool value)
+{
+	device->rpa = value;
+}
+
 void device_update_addr(struct btd_device *device, const bdaddr_t *bdaddr,
 							uint8_t bdaddr_type)
 {
 	bool auto_connect = device->auto_connect;
 
+	device_set_rpa(device, true);
+
 	if (!bacmp(bdaddr, &device->bdaddr) &&
 					bdaddr_type == device->bdaddr_type)
 		return;
diff --git a/src/device.h b/src/device.h
index 9cdc0e68d..5e8d1c3e1 100644
--- a/src/device.h
+++ b/src/device.h
@@ -28,6 +28,7 @@ bool device_name_known(struct btd_device *device);
 bool device_is_name_resolve_allowed(struct btd_device *device);
 void device_name_resolve_fail(struct btd_device *device);
 void device_set_class(struct btd_device *device, uint32_t class);
+void device_set_rpa(struct btd_device *device, bool value);
 void device_update_addr(struct btd_device *device, const bdaddr_t *bdaddr,
 							uint8_t bdaddr_type);
 void device_set_bredr_support(struct btd_device *device);
-- 
2.35.1

