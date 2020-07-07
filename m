Return-Path: <SRS0=I8IU=AS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBB0C433E1
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 15:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A07420578
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 15:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZENk32FX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgGGPtQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbgGGPtP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jul 2020 11:49:15 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E8EC08C5E1
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2020 08:49:15 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id cv18so1050095pjb.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jul 2020 08:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QIa6nXktLNxV0OJGlYLuHe4XdRrUEelYZWVni//KxsU=;
        b=ZENk32FXh9uVqWbCNy26QjHPUtixN1Mj5Z4BllFM9EXpZrcM4xdZqepp2x8GHb8w4T
         xo+RKmHHP+GwBykMt+Ngp2u909P+u+/8U/5gapxacqAu1AL5+7MgPlSJ+wWGl7sbiXea
         yH4t7ZL3ssoXqvdaICXTKyOhKS5BbWelsOIbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QIa6nXktLNxV0OJGlYLuHe4XdRrUEelYZWVni//KxsU=;
        b=aOxS8rAojxmNZMJj3unVGFRj2kHv8ndmoRy1WXWVFG95XET5h/TPjndMLG4p2NFLFq
         /REHTj/GxAvQHkzQdKNRDm3o3Z/d+uDJxMpbb1mdKwRmO5i+uwqfkssWKrHiMVlEl5ug
         mTLL0ke4/qqos7JdUnIbI0NvgGqmwitTBOnJsT0/bNqGQcx4KBXPv+tIcaAIiRJg1OQX
         73oMYQdKeFOtKWFwS9Qb/BQmX9Z7lBqvv/EVKJmNpJQZixl0uuiD+KvJlc5wMrPBwLeu
         mjrZ6pPbWXBMi4jaiSCB2UIegrKCk17+7nODPcc0amrKaqLYcjgYMW4TfNVICWQ6GmBU
         jGZg==
X-Gm-Message-State: AOAM5315WCcrE2zDUW17WFLiFli0ww/rOcp3bE67LjegJrIGwEQ8csch
        uy1zE3QhQZouyPb8uiHmQ5rApw==
X-Google-Smtp-Source: ABdhPJz9iHG+DFuUyYcBIjr3vVuYxa0ZU2rFQLx+SaJILKp2THWi5NfPgogurVf9a1QeoPIhrUJUuA==
X-Received: by 2002:a17:90a:67c7:: with SMTP id g7mr4910530pjm.165.1594136954819;
        Tue, 07 Jul 2020 08:49:14 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id t5sm1360194pgl.38.2020.07.07.08.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 08:49:14 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        rafael.j.wysocki@intel.com, swboyd@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH v3 1/1] power: Emit changed uevent on wakeup_sysfs_add/remove
Date:   Tue,  7 Jul 2020 08:49:05 -0700
Message-Id: <20200707084857.v3.1.I51f5a0be89595b73c4dc17e6cf4cc6f26dc7f2fc@changeid>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
In-Reply-To: <20200707154905.2763616-1-abhishekpandit@chromium.org>
References: <20200707154905.2763616-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Udev rules that depend on the power/wakeup attribute don't get triggered
correctly if device_set_wakeup_capable is called after the device is
created. This can happen for several reasons (driver sets wakeup after
device is created, wakeup is changed on parent device, etc) and it seems
reasonable to emit a changed event when adding or removing attributes on
the device.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

Changes in v3:
- Simplified error handling

Changes in v2:
- Add newline at end of bt_dev_err

 drivers/base/power/sysfs.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index 24d25cf8ab1487..04c82373c8f240 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* sysfs entries for device PM */
 #include <linux/device.h>
+#include <linux/kobject.h>
 #include <linux/string.h>
 #include <linux/export.h>
 #include <linux/pm_qos.h>
@@ -739,12 +740,18 @@ int dpm_sysfs_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
 
 int wakeup_sysfs_add(struct device *dev)
 {
-	return sysfs_merge_group(&dev->kobj, &pm_wakeup_attr_group);
+	int ret = sysfs_merge_group(&dev->kobj, &pm_wakeup_attr_group);
+
+	if (ret)
+		return ret;
+
+	return kobject_uevent(&dev->kobj, KOBJ_CHANGE);
 }
 
 void wakeup_sysfs_remove(struct device *dev)
 {
 	sysfs_unmerge_group(&dev->kobj, &pm_wakeup_attr_group);
+	return kobject_uevent(&dev->kobj, KOBJ_CHANGE);
 }
 
 int pm_qos_sysfs_add_resume_latency(struct device *dev)
-- 
2.27.0.212.ge8ba1cc988-goog

