Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0181C43219
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Feb 2022 22:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387146AbiBHWVs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Feb 2022 17:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386663AbiBHVFp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Feb 2022 16:05:45 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77FAC0612B8
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Feb 2022 13:05:43 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id m185so643177iof.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Feb 2022 13:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GJVZMi3Gsv5BJ0mNMhcI2PHhUdygyrhJZtXHgoad0bw=;
        b=gUcr/O+Ky+nxn31adgrSFJw/U0UFYXoKhNuDDJKFDgPIKlrY4fz89zyVAbTREpunEf
         XvgIWqNV/6XBvWEezPPbCKloHLY9JZgxNVXxYjRill95P6EgJI8nZqBnh60ee+cMSR4C
         Vrr6fBjjGrMxD+NCynxRm3qR+N9rjqGVssv9rWeJCtMuk1SzxDzmFTX8yV+UjVtmUaCf
         fgdYAwzpB4I0gJqZeaHU/SOTFRwBRhCVTM7hCBQJFARM55c8wJNmBhZVETO2iif80+/e
         I60SOZ0aaBj4ASLMZCgptZ9XLS7a6DkBJdc2vfzUM7N5u2vMniMufeG2zY5FebvByOBF
         BWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GJVZMi3Gsv5BJ0mNMhcI2PHhUdygyrhJZtXHgoad0bw=;
        b=Bhi9bRNm8EevVboub12jtv1SzoBTN7ZFNJlkUxGVqhc/o8Zzdu1+IYe9KkKweJnOrO
         PYAK9aYzEmEWIC1rRvm9gWj8FR+ESG25KV4wyOHMFPINKMBNc5wzGx5AcvWXgqorK29n
         Cy37oU/Lwj0zUT1i4FVrKSm6RjiInhyZ7eFdHacb2jw+D4Mb7NKjc9KTzgeJbproiSNC
         yC7Be0k6IlfYB6MsjSDU3qWdmRQ2W5s2RtRnU3PdVSFArUeImIziTG5j0sz22aIG2TPY
         pSARFMagYZbzp7pMbmm3di9EhKhFOYT1c/JFO1sXFST85ep53QNjoPb7w06YDDjwmzaz
         f4iA==
X-Gm-Message-State: AOAM5325P7qLTkn8cABkA0jAjTnA8afbDM9vvEMGvqqqgdQPhv2pVDtA
        m9NBdZ0rNhgFQurc86by9dycXFcRJYZ9rQ==
X-Google-Smtp-Source: ABdhPJzT2zgr7TzjvTaz6vMRlWRgzQvfptMbLDWNPJwxKYpzIewfCQXsZz3XHLpX36ntQ56aTnmX/w==
X-Received: by 2002:a02:63ce:: with SMTP id j197mr2721651jac.134.1644354342956;
        Tue, 08 Feb 2022 13:05:42 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id q9sm8376405iop.30.2022.02.08.13.05.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 13:05:42 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] adv_monitor: Fix spamming errors
Date:   Tue,  8 Feb 2022 13:05:41 -0800
Message-Id: <20220208210541.3883437-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If advertising manager is not enabled don't log any error on
btd_adapter_update_found_device, also change
btd_adv_monitor_offload_supported to btd_adv_monitor_offload_enabled
since that is checking if the features has been enabled rather than it
is just supported.

Fixes: https://github.com/bluez/bluez/issues/286
---
 src/adapter.c     | 2 +-
 src/adv_monitor.c | 6 ++----
 src/adv_monitor.h | 2 +-
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index e59b16328..b15b5021f 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -6899,7 +6899,7 @@ void btd_adapter_update_found_device(struct btd_adapter *adapter,
 	bool duplicate = false;
 	struct queue *matched_monitors = NULL;
 
-	if (!btd_adv_monitor_offload_supported(adapter->adv_monitor_manager)) {
+	if (!btd_adv_monitor_offload_enabled(adapter->adv_monitor_manager)) {
 		if (bdaddr_type != BDADDR_BREDR)
 			ad = bt_ad_new_with_data(data_len, data);
 
diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index 602830e30..33f4d9619 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -1844,12 +1844,10 @@ void btd_adv_monitor_manager_destroy(struct btd_adv_monitor_manager *manager)
 	manager_destroy(manager);
 }
 
-bool btd_adv_monitor_offload_supported(struct btd_adv_monitor_manager *manager)
+bool btd_adv_monitor_offload_enabled(struct btd_adv_monitor_manager *manager)
 {
-	if (!manager) {
-		error("Manager is NULL, get offload support failed");
+	if (!manager)
 		return false;
-	}
 
 	return !!(manager->enabled_features &
 				MGMT_ADV_MONITOR_FEATURE_MASK_OR_PATTERNS);
diff --git a/src/adv_monitor.h b/src/adv_monitor.h
index bed6572d0..c6bb8a68a 100644
--- a/src/adv_monitor.h
+++ b/src/adv_monitor.h
@@ -27,7 +27,7 @@ struct btd_adv_monitor_manager *btd_adv_monitor_manager_create(
 						struct mgmt *mgmt);
 void btd_adv_monitor_manager_destroy(struct btd_adv_monitor_manager *manager);
 
-bool btd_adv_monitor_offload_supported(struct btd_adv_monitor_manager *manager);
+bool btd_adv_monitor_offload_enabled(struct btd_adv_monitor_manager *manager);
 
 struct queue *btd_adv_monitor_content_filter(
 				struct btd_adv_monitor_manager *manager,
-- 
2.34.1

