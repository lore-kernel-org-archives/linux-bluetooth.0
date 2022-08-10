Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443AAC00140
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Aug 2022 16:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbiHJQBA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Aug 2022 12:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbiHJQAp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Aug 2022 12:00:45 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84F050716
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Aug 2022 09:00:43 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-32a144ac47fso24991627b3.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Aug 2022 09:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=0PhSYK/43R/qkt5VLzlWhhCNXtXX8neUOcqcH82eZqE=;
        b=U6tbS8HJCKe+Ahc+hmjwexGTLgTuhgBoPE3pgLIEZCq0JjVci0KzJbh6/3ittE0vW+
         PeN/fr24vfh30Je+OPRxXd6asENSTuv+4+ZPrrqmh2qy6o9b9s5dVEVKFWuCv2WFCLSl
         GZ3StdD2oiJMWwuwZ+UMqHmV1s+TE8ZKwGV3AeomnMDYeJfudvpvl0l63pqPCYXUZ+sy
         3gR8IMp2e/QuVy/8zKRXGYlLhh1fc43EZE29j5PdjvE7hfHOIyGwi/nt4fSfcvQ2UK5K
         WUavQb5xVkthlQThybHSONJjLXmMmgdsspQukedYa9zt0UCC1k0gJ/idHb4/tcAv1Hnn
         nDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=0PhSYK/43R/qkt5VLzlWhhCNXtXX8neUOcqcH82eZqE=;
        b=J60gBnsJAiDyjzznafRBbf8FvA0gGZWmgAjsaYj7HeMssd4JpBI1k5bVRB+P7or8Wr
         dlFPDTKAD5MltQG1S5rW5pDJhHoWG3zb7yDk3r2QOMM9GeeEqxggDFU5ScQsvXxY/cbe
         bQkpXbDeyVUNed1Rvc2GnN82uybjXJuMlaoXZTu66kIh2trzEA24TIR27dEePLBovAH/
         1n/2gWX/ThzDGac35hp6igIdwzDZrY/Q7YwqBv6mZr6poREEa6wqQMDHvPoq7glzFpdx
         dKWSmXxS2oqMXM3rL9LtdS4x/Tiqee2ytRhnkRNjKqAqtDQGQqiUQX17bXm3pMFlh+I/
         rOIA==
X-Gm-Message-State: ACgBeo1iM9aHPSqytlq1kdBzo3ZDVKRCBSs5V15TqkVwjmqV2pw+JZby
        RF0N7lCrnOgo9eRFH9iIBBZC2CoE54ZGyw==
X-Google-Smtp-Source: AA6agR5blSAnZ93GUH1oMIz4GRV/sdDeCnQY1mosjsyRBVxDx+1oIT5SvrkCBKRZHu9QALl1BfZcixoicF47XQ==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:1e7:803:63a4:33])
 (user=mmandlik job=sendgmr) by 2002:a25:cf91:0:b0:671:83db:c8f9 with SMTP id
 f139-20020a25cf91000000b0067183dbc8f9mr26387885ybg.535.1660147242999; Wed, 10
 Aug 2022 09:00:42 -0700 (PDT)
Date:   Wed, 10 Aug 2022 09:00:34 -0700
Message-Id: <20220810085753.v5.1.I5622b2a92dca4d2703a0f747e24f3ef19303e6df@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v5 1/5] sysfs: Add attribute info for /sys/devices/.../coredump_disabled
From:   Manish Mandlik <mmandlik@google.com>
To:     Arend van Spriel <aspriel@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Signed-off-by : Manish Mandlik" <mmandlik@google.com>,
        linux-bluetooth@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Won Chung <wonchung@google.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds the specification for /sys/devices/.../coredump_disabled
attribute which allows the userspace to enable/disable devcoredump for a
particular device and drivers can use it to enable/disable functionality
accordingly. It is available when the CONFIG_DEV_COREDUMP is enabled and
driver has implemented the .coredump() callback.

Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Signed-off-by: Manish Mandlik <mmandlik@google.com>
---
Hi Arend, Greg,

The existing /sys/class/devcoredump/disabled provides only a one-way
disable functionality for devcoredump. It also disables the devcoredump
for everyone who is using it.

This and the next patch provides a way to selectively enable/disable the
devcoredump by creating a /sys/devices/.../coredump_disabled sysfs entry.
The userspace can write 0/1 to it to enable/disable devcoredump for that
particular device and drivers can use it accordingly. It will only be
available along with the /sys/devices/.../coredump sysfs entry when the
CONFIG_DEV_COREDUMP is enabled and the driver has implemented the
.coredump() callback.

Please let me know what you think about this.

Thanks,
Manish.

(no changes since v4)

Changes in v4:
- New patch in the series

 Documentation/ABI/testing/sysfs-devices-coredump | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-coredump b/Documentation/ABI/testing/sysfs-devices-coredump
index e459368533a4..4bcfc7dbad67 100644
--- a/Documentation/ABI/testing/sysfs-devices-coredump
+++ b/Documentation/ABI/testing/sysfs-devices-coredump
@@ -8,3 +8,17 @@ Description:
 		file will trigger the .coredump() callback.
 
 		Available when CONFIG_DEV_COREDUMP is enabled.
+
+What:		/sys/devices/.../coredump_disabled
+Date:		July 2022
+Contact:	Manish Mandlik <mmandlik@google.com>
+Description:
+		The /sys/devices/.../coredump_disabled attribute can be used by
+		drivers to selectively enable/disable devcoredump functionality
+		for a device. The userspace can write 0/1 to it to control
+		enabling/disabling of devcoredump for that particular device.
+		This attribute is present only when the device is bound to a
+		driver which implements the .coredump() callback. The attribute
+		is readable and writeable.
+
+		Available when CONFIG_DEV_COREDUMP is enabled.
-- 
2.37.1.559.g78731f0fdb-goog

