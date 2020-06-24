Return-Path: <SRS0=JtDF=AF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031F1C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Jun 2020 21:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDB602072E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Jun 2020 21:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nGg2gjeB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389254AbgFXVGY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Jun 2020 17:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387853AbgFXVGX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Jun 2020 17:06:23 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9A3C061573
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jun 2020 14:06:23 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id d4so2053816pgk.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jun 2020 14:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2MJjDisSYsFLi9xjpuxw/vmSuouvLE6xSiePJnwRksg=;
        b=nGg2gjeBPhPwU7thZ1v6JzWty3y8rRAI/iIlXN0JlQmZd1dX6Taavm70RQncr/FVmX
         IlFoXu2K3JqzWg6Ejw0e4HbVfWsQpgjWv1qYxIw5YiQraZTpAQ58NssIb/+GUnyUzA8L
         5Q/WN5nncXm7ARdnvhcEtDn54pJv/0PFKq+IY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2MJjDisSYsFLi9xjpuxw/vmSuouvLE6xSiePJnwRksg=;
        b=qZBbLax67HwCpz8HNcKXmBVdeTuWAyggz9YOqK9XJSlxbF5m4RvvUdr1PWON2S5tOH
         bNO/cvhsLXJ8IhtlUQt1/R3J1a7kWrpMM3LkiuO/7Kfe9HuHpXoR8zDcseKdM4xRXUK9
         28FZoc9fyOt9uzxeJkoD1J0qlkU8C4kX3ZNQDKiwAezOAtG3tjzbV+rCaQ29tmPPphHE
         TaR+/f80DVrC3JhdoAps1MCt7JzVeYDFqH0uB7zMloqsh5AEG4ZE6QqqS+Tjmn14O2sa
         fCa/SVUj9pewEQ0cDSjQ640ZJQlrhOE+ClFpD69EUuSxDm9W0lxRzaX+F1ZBMT9hA86B
         OMHQ==
X-Gm-Message-State: AOAM533uiiDT/QtQNFR5GJqxu301LiGJZDqBRR3GPf9XeA++5DxXE8I8
        sIeBzE9xRy9fADl0XO9M4iPrdA==
X-Google-Smtp-Source: ABdhPJwnLertNgi8e0ErMQYUFVupWeSlyxCkLSLR+LP5JzpyPFSxudWYnPgOS2GT8jLpWRLkG7r9/g==
X-Received: by 2002:a62:4d46:: with SMTP id a67mr14170483pfb.290.1593032783177;
        Wed, 24 Jun 2020 14:06:23 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id y9sm442927pfn.84.2020.06.24.14.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 14:06:22 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     linux-pm@vger.kernel.org
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        rafael.j.wysocki@intel.com, swboyd@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 0/1] power: Emit change uevent when updating sysfs
Date:   Wed, 24 Jun 2020 14:06:15 -0700
Message-Id: <20200624210616.28477-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
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

Thanks
Abhishek


Abhishek Pandit-Subedi (1):
  power: Emit changed uevent on wakeup_sysfs_add/remove

 drivers/base/power/sysfs.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

-- 
2.27.0.111.gc72c7da667-goog

