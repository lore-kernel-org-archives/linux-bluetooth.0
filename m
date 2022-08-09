Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0813C19F2D
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Aug 2022 15:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239967AbiHIPgC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Aug 2022 11:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242751AbiHIPfq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Aug 2022 11:35:46 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A671C25F6
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Aug 2022 08:35:43 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id f4-20020a056a00228400b0052fdbb301ddso221073pfe.15
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Aug 2022 08:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=f7QNBZGNnK5yYhhuUlGnKKkabxvWElh1Ug+FZ9u2MZY=;
        b=a+U4jExmeiVGPDVS/VtZgtsM5CgcPE/IppJwGzKXGunG6gLctOgbV/HwHLJiW4LqOn
         SkduGFbSnHJrnM0+2DTSS8ITe+UcjruXx4Bf7cg3Or/nalbfUZWrjcLZd1K1j2mZN0qj
         s/W+N9qND8wus4pLak1UdI6s+hBykKIFt5+MAq24nd5cpca/trMgJrihO0Gt94saBY36
         ZRck6GFsg/r6zzlpvVGmXBBlxDAVwjj4A7iEKZs5HihhcXkISZu+lTvgTzrRcu1HLZyv
         V7Wgr65qpvLexzl4CF9YKaczOcHVai9aNfI/agbYm9X+0KtrGKm1F4Y2MQsQSLWeeJuR
         X0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=f7QNBZGNnK5yYhhuUlGnKKkabxvWElh1Ug+FZ9u2MZY=;
        b=W9kmNMjr+f7XnO1ZS65Ic6URLUZAXz4hvJM37hBXyRKVCmPhjdVFW6fCAal/3bvz8o
         Unk60+iFSttFwzXFNdqkLM9oG5bd9m4Dyou1L1+ZSw1O0Ac5S062rxcN/pNmuVylcgVE
         lvyHEQf4FyHfrfNbeAkd2VZjZVZLM8F+dIyUBTVgaBA2RGtXUsvxcusBgjcSwv2m9N1G
         oAW47sfRwe7jGjyOmXYDLVA7U/IyvWAyTuO1T+8d9xJw+LnE4MVSTArze3tcTHLypkQF
         C1pS145z2T99kJ95GwL2rHYai6cjrwGL3rDBP3Jl6At0HrCyha+xvRysehZ2aTgkByZE
         tMvQ==
X-Gm-Message-State: ACgBeo1QsulOAwdg2P/2uwwk2H9bOkq/1vR5iiPJG+psu9IgqYc2QF2E
        5FTvzNlSJzfyayHXwUp+KthP82nx7zsVbw==
X-Google-Smtp-Source: AA6agR7TfjwH/GCmWvBBxw6G0/8wn4UVwrMJS5YLYSlniLXnKBsOpoBoqFMv0wVWEh8/dxTI14GFq1UlYV7LKA==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:91a6:8007:96f6:3fb3])
 (user=mmandlik job=sendgmr) by 2002:a17:90b:394:b0:1f5:90a1:acf0 with SMTP id
 ga20-20020a17090b039400b001f590a1acf0mr21065299pjb.40.1660059343098; Tue, 09
 Aug 2022 08:35:43 -0700 (PDT)
Date:   Tue,  9 Aug 2022 08:35:24 -0700
In-Reply-To: <20220809083112.v4.1.I5622b2a92dca4d2703a0f747e24f3ef19303e6df@changeid>
Message-Id: <20220809083112.v4.2.Ief1110784c6c1c3ac0ee5677c2d28d785af8686d@changeid>
Mime-Version: 1.0
References: <20220809083112.v4.1.I5622b2a92dca4d2703a0f747e24f3ef19303e6df@changeid>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v4 2/5] devcoredump: Add per device sysfs entry to
 enable/disable coredump
From:   Manish Mandlik <mmandlik@google.com>
To:     Arend van Spriel <aspriel@gmail.com>, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Manish Mandlik <mmandlik@google.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Johannes Berg <johannes@sipsolutions.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Won Chung <wonchung@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The /sys/class/devcoredump/disabled provides only one-way disable
functionality. Also, disabling devcoredump using it disables the
devcoredump functionality for everyone who is using it.

Provide a way to selectively enable/disable devcoredump for the device
which is bound to a driver that implements the '.coredump()' callback.

This adds the 'coredump_disabled' driver attribute. When the driver
implements the '.coredump()' callback, 'coredump_disabled' file is added
along with the 'coredump' file in the sysfs folder of the device upon
driver binding. The file is removed when the driver is unbound.

Drivers can use this attribute to enable/disable devcoredump and the
userspace can write 0 or 1 to /sys/devices/.../coredump_disabled sysfs
entry to control enabling/disabling of devcoredump for that device.

Signed-off-by: Manish Mandlik <mmandlik@google.com>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

Changes in v4:
- New patch in the series

 drivers/base/dd.c          | 43 +++++++++++++++++++++++++++++++++++---
 drivers/base/devcoredump.c |  2 +-
 include/linux/device.h     |  4 ++++
 3 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 11b0fb6414d3..c76d1145c6d9 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -426,6 +426,31 @@ static ssize_t coredump_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_WO(coredump);
 
+static ssize_t coredump_disabled_show(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	return scnprintf(buf, 3, "%d\n", dev->coredump_disabled);
+}
+
+static ssize_t coredump_disabled_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t count)
+{
+	long coredump_disabled;
+
+	if (!kstrtol(buf, 10, &coredump_disabled)) {
+		/* Consider any non-zero value as true */
+		if (coredump_disabled)
+			dev->coredump_disabled = true;
+		else
+			dev->coredump_disabled = false;
+	}
+
+	return count;
+}
+static DEVICE_ATTR_RW(coredump_disabled);
+
 static int driver_sysfs_add(struct device *dev)
 {
 	int ret;
@@ -448,9 +473,19 @@ static int driver_sysfs_add(struct device *dev)
 		return 0;
 
 	ret = device_create_file(dev, &dev_attr_coredump);
-	if (!ret)
-		return 0;
+	if (ret)
+		goto rm_driver;
+
+	ret = device_create_file(dev, &dev_attr_coredump_disabled);
+	if (ret)
+		goto rm_coredump;
 
+	return 0;
+
+rm_coredump:
+	device_remove_file(dev, &dev_attr_coredump);
+
+rm_driver:
 	sysfs_remove_link(&dev->kobj, "driver");
 
 rm_dev:
@@ -466,8 +501,10 @@ static void driver_sysfs_remove(struct device *dev)
 	struct device_driver *drv = dev->driver;
 
 	if (drv) {
-		if (drv->coredump)
+		if (drv->coredump) {
+			device_remove_file(dev, &dev_attr_coredump_disabled);
 			device_remove_file(dev, &dev_attr_coredump);
+		}
 		sysfs_remove_link(&drv->p->kobj, kobject_name(&dev->kobj));
 		sysfs_remove_link(&dev->kobj, "driver");
 	}
diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index f4d794d6bb85..c5e9af9f3181 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -255,7 +255,7 @@ void dev_coredumpm(struct device *dev, struct module *owner,
 	struct devcd_entry *devcd;
 	struct device *existing;
 
-	if (devcd_disabled)
+	if (devcd_disabled || dev->coredump_disabled)
 		goto free;
 
 	existing = class_find_device(&devcd_class, NULL, dev,
diff --git a/include/linux/device.h b/include/linux/device.h
index dc941997795c..120dd656f99d 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -469,6 +469,8 @@ struct device_physical_location {
  * 		This identifies the device type and carries type-specific
  * 		information.
  * @mutex:	Mutex to synchronize calls to its driver.
+ * @coredump_disabled: Can be used by drivers to selectively enable/disable the
+ *		coredump for a particular device via sysfs entry.
  * @bus:	Type of bus device is on.
  * @driver:	Which driver has allocated this
  * @platform_data: Platform data specific to the device.
@@ -561,6 +563,8 @@ struct device {
 	const char		*init_name; /* initial name of the device */
 	const struct device_type *type;
 
+	bool			coredump_disabled;
+
 	struct bus_type	*bus;		/* type of bus device is on */
 	struct device_driver *driver;	/* which driver has allocated this
 					   device */
-- 
2.37.1.559.g78731f0fdb-goog

