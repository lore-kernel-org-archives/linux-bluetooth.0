Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D3CC19F2D
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Aug 2022 15:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242888AbiHIPgB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Aug 2022 11:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbiHIPfm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Aug 2022 11:35:42 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF2A25F6
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Aug 2022 08:35:40 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31f3959ba41so103755737b3.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Aug 2022 08:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=9waxFKEckRsksR/CxnLtO8m90vPWn0K31uAAo7MYkNw=;
        b=QtfuSAE6stzliaPoJKxzJzaBikU713Hfx91gcTP2JzAGReZCY+d6FvciQFr5T7EcPU
         tENWbnTjdO+QBSjAZdWGcReGy5kgvh8UZz26/Bl1N+WUyA9kZgl6A51S6D8WqASaHPKb
         q6XARQyIhZGlYcNTSXLJD4DvaPQh74RVK9rv5PaA95BKemlPUTI7MEKh7efCsfZvxeNT
         2p5Vzaaj+vce1ZTc/jtHDfwlMC/zakzGKSOR12ae8FdKvI4jSvBQD0TxFmKxnlTP6u89
         Sb+QojnyTfAQunzgPFb8MBGv+0eqTSX19ejWXkw3JUAxQ/ubzf5Hk23cvoulwuVrymMz
         rGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=9waxFKEckRsksR/CxnLtO8m90vPWn0K31uAAo7MYkNw=;
        b=Pfb++7321Drk/tWW2jxnyoDl/VemCPlXR15PS+rdC7wHhPDnJDbtgv6M3q+4x3vs7P
         ey6i/R+hGFBZtrQpY/EFeVu0YCoBBF2zuWaRgCtOb3tC3m0CPHEublPMf/kgJIfsWDEY
         QWMJ1gQrbZ19IqAG7c7zCYGNygC2Y3LottIgRNqli33YYUHjSpPjqQ8AiYikbiA6KFSu
         V99LdvatCjK/T+pHoSvjdwyAt/IqxLF9Gbfv/Dut8wIX5JRfOy4Ubt4RJwzn9/owWLgX
         DvUu0PlZiUvD24UMtxKvMoM/2FaBPx2m6N8lMDniJWyLZXUWaGEeJQu/G3671Nvuxncm
         e8kg==
X-Gm-Message-State: ACgBeo2bg8VIomvWEBursLGDFKk7bkPpEghIB/i5s7F5NyAPnDWpNUMb
        i+9i0nSdwzqwPDhF29wM0UxkmhehIKU1/g==
X-Google-Smtp-Source: AA6agR6CcpP+mKN5E/cFGHb+4J+Pm/JesWcckehq4kilzJQLP38zePk0Sw8neW18CYPxoUtN/s9IMsWXuB/qlg==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:91a6:8007:96f6:3fb3])
 (user=mmandlik job=sendgmr) by 2002:a81:9245:0:b0:31f:4e3e:363d with SMTP id
 j66-20020a819245000000b0031f4e3e363dmr23716836ywg.119.1660059340189; Tue, 09
 Aug 2022 08:35:40 -0700 (PDT)
Date:   Tue,  9 Aug 2022 08:35:23 -0700
Message-Id: <20220809083112.v4.1.I5622b2a92dca4d2703a0f747e24f3ef19303e6df@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v4 1/5] sysfs: Add attribute info for /sys/devices/.../coredump_disabled
From:   Manish Mandlik <mmandlik@google.com>
To:     Arend van Spriel <aspriel@gmail.com>, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Manish Mandlik <mmandlik@google.com>,
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

Signed-off-by: Manish Mandlik <mmandlik@google.com>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---
Hi Arend,

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

