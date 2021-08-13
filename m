Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5A1C432BE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D15D060F46
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240516AbhHMMXM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240503AbhHMMXM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:23:12 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D196C061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:22:45 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id gw9-20020a0562140f0900b0035decb1dfecso2022741qvb.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5Bdj2o6ZYeOwYY1a0I0/BvPdA+dHyUHJANEDS/vvIeo=;
        b=b1bSdZ3laxTLyPLCySqp0bYYwSup8v00hy32/XfJVq8FMaIyI4q7IVv57/3H3lirgN
         j9j+bNjzzMFbPSKuSgQ9cZsvggb3CQdxe4U3gJe7hkmK0z/qxfT2JNCZ5+X4edoeCUJo
         fUsr6Jkn68g3IAhsGddKNFLk7FKw/WUw0YBRRa7mkuCJ61WT2J/9F5yOp7Uf8h+ojBbo
         J5p/J4ZoZTzwRR1jgfqcOr4yGUCGZiXwoi7W0bRzucEBRyq/CZjGxJ5Epbtt0n1Phd5X
         zUeTQ3MDVF1V0kds/yt+9bZgUIZngEASj707JGbwPLRJqhZighQt74l/BROYpkxNRr0v
         nXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5Bdj2o6ZYeOwYY1a0I0/BvPdA+dHyUHJANEDS/vvIeo=;
        b=ph04+8VlbXf1IxFi3ysHRoHiJPa7Ej2Ml8APsg6wUUXiQLWcawWO0l2iPl9nT8H2xQ
         85pOLs0x5GlFTNiYGmQ4az7DfQmeCYK3E3ONT5qW5y/SmI001aWAe9IlfBgU5sUpRC5f
         Tat1Fs/wuFXZNACU2dEDVf/uhRypwEI0dVRu1sDQIqrmClzm/YERtT3cEA20of/YZCgD
         tt9zUKsWZ+R1Ulj3HZMihl0fEjSYCBcAjZB3RbSX0MTuPIjSU1cTsmATNdgq/+ETqTpv
         jjr+Kn8Sq545qDBGqyfL7WEma+YSmOzuGDhShxIPrgBCJyiJ6s8HG5vG7X/aXPK9ULZ8
         Og0w==
X-Gm-Message-State: AOAM531mPuKndGeUVGXo75t0CyEx1ArKOsqBB+ML6AlLs4sPRf/VDxBc
        FzeiaDfH/LfnDBySydYs9FHbTkbEyoM9hTRDwfyX8Co/s3+hF9QInUFbPe2FyNQRyKnxysP+RJX
        /tPIInUGXRSZoUVv+esxm0K3QNVwI4WqMNaXabS4b4Izg3L/DX1FH/twj3FpxVK0o3bLZhKrBbu
        8U
X-Google-Smtp-Source: ABdhPJxCJOP7PWN8UT5MOwuDelvKdhkPZy4KCe9FpBGLLblrig8Wed2soFksO81KiCOTl6SgVUsjlnXlhveL
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a05:6214:d0c:: with SMTP id
 12mr2337564qvh.10.1628857364746; Fri, 13 Aug 2021 05:22:44 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:18:37 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.52.If17a35783443b964af0262fd2c31f4c361fe238f@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 52/62] adapter: Inclusive language for device filtering
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

"accept list" and "reject list" are the preferred terms, as reflected
in the BT core spec 5.3, also in
https://specificationrefs.bluetooth.com/language-mapping/Appropriate_Language_Mapping_Table.pdf
---

 src/adapter.c | 18 ++++++++++--------
 src/adapter.h |  4 ++--
 src/device.c  |  6 +++---
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index a23c438f34..3ed785bf08 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4957,7 +4957,7 @@ void adapter_connect_list_remove(struct btd_adapter *adapter,
 	trigger_passive_scanning(adapter);
 }
 
-static void add_whitelist_complete(uint8_t status, uint16_t length,
+static void add_accept_list_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
 	const struct mgmt_rp_add_device *rp = param;
@@ -4988,10 +4988,11 @@ static void add_whitelist_complete(uint8_t status, uint16_t length,
 		return;
 	}
 
-	DBG("%s added to kernel whitelist", addr);
+	DBG("%s added to kernel accept list", addr);
 }
 
-void adapter_whitelist_add(struct btd_adapter *adapter, struct btd_device *dev)
+void adapter_accept_list_add(struct btd_adapter *adapter,
+							struct btd_device *dev)
 {
 	struct mgmt_cp_add_device cp;
 
@@ -5005,10 +5006,10 @@ void adapter_whitelist_add(struct btd_adapter *adapter, struct btd_device *dev)
 
 	mgmt_send(adapter->mgmt, MGMT_OP_ADD_DEVICE,
 				adapter->dev_id, sizeof(cp), &cp,
-				add_whitelist_complete, adapter, NULL);
+				add_accept_list_complete, adapter, NULL);
 }
 
-static void remove_whitelist_complete(uint8_t status, uint16_t length,
+static void remove_accept_list_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
 	const struct mgmt_rp_remove_device *rp = param;
@@ -5027,10 +5028,11 @@ static void remove_whitelist_complete(uint8_t status, uint16_t length,
 		return;
 	}
 
-	DBG("%s removed from kernel whitelist", addr);
+	DBG("%s removed from kernel accept list", addr);
 }
 
-void adapter_whitelist_remove(struct btd_adapter *adapter, struct btd_device *dev)
+void adapter_accept_list_remove(struct btd_adapter *adapter,
+							struct btd_device *dev)
 {
 	struct mgmt_cp_remove_device cp;
 
@@ -5043,7 +5045,7 @@ void adapter_whitelist_remove(struct btd_adapter *adapter, struct btd_device *de
 
 	mgmt_send(adapter->mgmt, MGMT_OP_REMOVE_DEVICE,
 				adapter->dev_id, sizeof(cp), &cp,
-				remove_whitelist_complete, adapter, NULL);
+				remove_accept_list_complete, adapter, NULL);
 }
 
 static void add_device_complete(uint8_t status, uint16_t length,
diff --git a/src/adapter.h b/src/adapter.h
index 60b5e3bcca..19e7cf82ad 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -214,9 +214,9 @@ void adapter_auto_connect_add(struct btd_adapter *adapter,
 					struct btd_device *device);
 void adapter_auto_connect_remove(struct btd_adapter *adapter,
 					struct btd_device *device);
-void adapter_whitelist_add(struct btd_adapter *adapter,
+void adapter_accept_list_add(struct btd_adapter *adapter,
 						struct btd_device *dev);
-void adapter_whitelist_remove(struct btd_adapter *adapter,
+void adapter_accept_list_remove(struct btd_adapter *adapter,
 						struct btd_device *dev);
 
 void btd_adapter_set_oob_handler(struct btd_adapter *adapter,
diff --git a/src/device.c b/src/device.c
index b29aa195d1..4997d6ab6d 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1122,7 +1122,7 @@ static void set_blocked(GDBusPendingPropertySet id, gboolean value, void *data)
 		break;
 	case EINVAL:
 		g_dbus_pending_property_error(id, ERROR_INTERFACE ".Failed",
-					"Kernel lacks blacklist support");
+					"Kernel lacks reject list support");
 		break;
 	default:
 		g_dbus_pending_property_error(id, ERROR_INTERFACE ".Failed",
@@ -5714,7 +5714,7 @@ void btd_device_set_temporary(struct btd_device *device, bool temporary)
 
 	if (temporary) {
 		if (device->bredr)
-			adapter_whitelist_remove(device->adapter, device);
+			adapter_accept_list_remove(device->adapter, device);
 		adapter_connect_list_remove(device->adapter, device);
 		if (device->auto_connect) {
 			device->disable_auto_connect = TRUE;
@@ -5726,7 +5726,7 @@ void btd_device_set_temporary(struct btd_device *device, bool temporary)
 		clear_temporary_timer(device);
 
 	if (device->bredr)
-		adapter_whitelist_add(device->adapter, device);
+		adapter_accept_list_add(device->adapter, device);
 
 	store_device_info(device);
 
-- 
2.33.0.rc1.237.g0d66db33f3-goog

