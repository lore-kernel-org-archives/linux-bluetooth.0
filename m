Return-Path: <SRS0=I8IU=AS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D3AC433E2
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 17:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A089A2073E
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 17:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AD6CoW2U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgGGR3A (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jul 2020 13:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbgGGR27 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jul 2020 13:28:59 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2C3C08C5E1
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2020 10:28:59 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id o22so13750004pjw.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jul 2020 10:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GDk3o4K7Qdy44WeUL6xRZLs/1lKN7Q2+qDuM1ziAKUE=;
        b=AD6CoW2UICDWk/1zx/l6PEom5Vnjn8v6sAqR+Vebu1tpz3GUosmm3pgGhiWnNTMqEn
         m+gTH9ORFg6cG+8B+7LfOi7FXvVjWYao93wjk1OI12A4kbeZrQ1mKBOLdFjwX0/wEq0W
         NkqU+R92VjKbfG/v2osMCZiL9GgHrO1xI5Upo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GDk3o4K7Qdy44WeUL6xRZLs/1lKN7Q2+qDuM1ziAKUE=;
        b=eQ8b95INMZ123O33lKFHSUb81rGXveGKAYPUCYZMyIvpSRTPBFQj0PAQACIry3QLIR
         jYCxzESpsglBgtOMYU/eMOpMbaxO7PJ4mE1TI2ySdtReSLTP1pSN7Z2XaWy8fbPzx6EK
         jn7M7lipXhVANPoarTIh+NtF2IMvTJT2bexzhExJwULL7bWyOvlTnwu7sryvT+FHwdtk
         a4mhomVNDsGgkmPOa9QBNGG/ZxAn+36uUqvy9A8Gs3XXOcw/4NOUHRkFGU1zd5EeldSZ
         gHLLGA8SBAwaYGvfoMgJtn/+tFnshFYfLpKuMAAlJZ3P8k65FkP+i+j/hSuqzLYOzSr1
         PPcw==
X-Gm-Message-State: AOAM530+9iHyUql+AJVajd9D7VIkKLzwdYdpuDGapLURbPBP/yiur9II
        JMRh4OgJ7o7Qrtzd8HJNyeuHU7wmI0o=
X-Google-Smtp-Source: ABdhPJzf226Gragbu1zI/saxunXJOqH4GwQ3BKzo0ajhKJmOD3ROv3HiPeqfCvACm0AL0aY/4IdfFQ==
X-Received: by 2002:a17:902:8d89:: with SMTP id v9mr45486975plo.191.1594142938963;
        Tue, 07 Jul 2020 10:28:58 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id e15sm1414285pgt.17.2020.07.07.10.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 10:28:58 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org, swboyd@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH v5 0/1] power: Emit change uevent when updating sysfs
Date:   Tue,  7 Jul 2020 10:28:43 -0700
Message-Id: <20200707172845.4177903-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


Hi linux-pm,

ChromeOS has a udev rule to chown the `power/wakeup` attribute so that
the power manager can modify it during runtime.

(https://source.chromium.org/chromiumos/chromiumos/codesearch/+/master:src/platform2/power_manager/udev/99-powerd-permissions.rules)

In our automated tests, we found that the `power/wakeup` attributes
weren't being chown-ed for some boards. On investigating, I found that
when the drivers probe and call device_set_wakeup_capable, no uevent was
being emitted for the newly added power/wakeup attribute. This was
manifesting at boot on some boards (Marvell SDIO bluetooth and Broadcom
Serial bluetooth drivers) or during usb disconnects during resume
(Realtek btusb driver with reset resume quirk).

It seems reasonable to me that changes to the attributes of a device
should cause a changed uevent so I have added that here.

Here's an example of the kernel events after toggling the authorized
bit of /sys/bus/usb/devices/1-3/

$ echo 0 > /sys/bus/usb/devices/1-3/authorized
KERNEL[27.357994] remove   /devices/pci0000:00/0000:00:15.0/usb1/1-3/1-3:1.0/bluetooth/hci0/rfkill1 (rfkill)
KERNEL[27.358049] remove   /devices/pci0000:00/0000:00:15.0/usb1/1-3/1-3:1.0/bluetooth/hci0 (bluetooth)
KERNEL[27.358458] remove   /devices/pci0000:00/0000:00:15.0/usb1/1-3/1-3:1.0 (usb)
KERNEL[27.358486] remove   /devices/pci0000:00/0000:00:15.0/usb1/1-3/1-3:1.1 (usb)
KERNEL[27.358529] change   /devices/pci0000:00/0000:00:15.0/usb1/1-3 (usb)

$ echo 1 > /sys/bus/usb/devices/1-3/authorized
KERNEL[36.415749] change   /devices/pci0000:00/0000:00:15.0/usb1/1-3 (usb)
KERNEL[36.415798] add      /devices/pci0000:00/0000:00:15.0/usb1/1-3/1-3:1.0 (usb)
KERNEL[36.417414] add      /devices/pci0000:00/0000:00:15.0/usb1/1-3/1-3:1.0/bluetooth/hci0 (bluetooth)
KERNEL[36.417447] add      /devices/pci0000:00/0000:00:15.0/usb1/1-3/1-3:1.0/bluetooth/hci0/rfkill2 (rfkill)
KERNEL[36.417481] add      /devices/pci0000:00/0000:00:15.0/usb1/1-3/1-3:1.1 (usb)

Series-version 4 update:
Tested again on device and verified it's working as expected:
KERNEL[52.678174] remove   /devices/pci0000:00/0000:00:15.0/usb1/1-3/1-3:1.0/bluetooth/hci0/rfkill2 (rfkill)
KERNEL[52.678211] remove   /devices/pci0000:00/0000:00:15.0/usb1/1-3/1-3:1.0/bluetooth/hci0 (bluetooth)
KERNEL[52.678251] remove   /devices/pci0000:00/0000:00:15.0/usb1/1-3/1-3:1.0 (usb)
KERNEL[52.679721] remove   /devices/pci0000:00/0000:00:15.0/usb1/1-3/1-3:1.1 (usb)
KERNEL[52.679772] change   /devices/pci0000:00/0000:00:15.0/usb1/1-3 (usb)
KERNEL[56.022259] change   /devices/pci0000:00/0000:00:15.0/usb1/1-3 (usb)
KERNEL[56.022306] add      /devices/pci0000:00/0000:00:15.0/usb1/1-3/1-3:1.0 (usb)
KERNEL[56.022488] add      /devices/pci0000:00/0000:00:15.0/usb1/1-3/1-3:1.0/bluetooth/hci0 (bluetooth)
KERNEL[56.022531] add      /devices/pci0000:00/0000:00:15.0/usb1/1-3/1-3:1.0/bluetooth/hci0/rfkill3 (rfkill)
KERNEL[56.023392] add      /devices/pci0000:00/0000:00:15.0/usb1/1-3/1-3:1.1 (usb)

Thanks
Abhishek

Changes in v5:
- Ignore return from kobject_uevent when adding to sysfs

Changes in v4:
- Fix warning where returning from void and tested on device

Changes in v3:
- Simplified error handling

Changes in v2:
- Add newline at end of bt_dev_err

Abhishek Pandit-Subedi (1):
  power: Emit changed uevent on wakeup_sysfs_add/remove

 drivers/base/power/sysfs.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

-- 
2.27.0.212.ge8ba1cc988-goog

