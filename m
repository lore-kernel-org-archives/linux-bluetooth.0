Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A592C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Feb 2022 01:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347073AbiBKBpB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Feb 2022 20:45:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347147AbiBKBoy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Feb 2022 20:44:54 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3133E5FB6
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Feb 2022 17:44:39 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id y6so20737505ybc.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Feb 2022 17:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=pa1Iq9BF31HznkQp1JB6hGHLO0q4q8bgWAUSR26TSbM=;
        b=Nd3yuynncsxKSWNzQrOmSxOacfhfJ6WAF+ruI+gowN5GxVzClcPsLgryZqqkA56I+O
         8Y8Z5E+uhMr2EP+IIH8s+O/BcYa1mXA5qz6EGPJUFQSq6mjZeTgjFojuEoOrhAPTFroV
         gXdoefIFTXF9/2OqfA89I7gxW0QS1oBoT2vCKEx53EkohURb+SjkotB3gjkiklhGnwQW
         3LzmXiBrP7kI1chtAXYmOSjkcJNVI5g+7+zkdFSMwrOS9WFza8tiP3EInjzI+b3ygl3g
         8y/t0V9LwcjP7XE82W0/j5d2jjlKKRt5euhAES4Be+PbM1rEbLzaBNttsdBMiHAAodSS
         eZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=pa1Iq9BF31HznkQp1JB6hGHLO0q4q8bgWAUSR26TSbM=;
        b=UzItX6TPfdLNnypooE8lQV8N588dPTtCKBpOdb54t92oe5yn+Sv9+810ZD/bO3cpAN
         GglMvXNyswe0h93S1nj5MJmP0yRab95yXbzoJGqTAY0gtdkLvyXtXFVO3E6CsfRUSx/o
         PL+NcDVFJv2FFbBl15fso96uOWIKBP1QLAeTYuG74GrJfXcFPjZ8wgvCIz+LmkUe8Pz9
         vYzi/VDdIwjpymBXfN8uDtW8oWhwL6qQE9CgEypZzkr6flIO8aY/EfC5EXuIev61822w
         yLEh31OTyknSfiM2VyvF95qoG5Bp2fBmMCecsXcZGYh6JbnK5aUwaCXv3E7i7MbXaJEw
         c+xA==
X-Gm-Message-State: AOAM5326SvE3kybKmpimmPGSUs1nPtgcZvg2xBHOD5eAkC4eRz9fcUhm
        HA/vVipjL750beeWKVkbAt2F7Vi8xUH4QnnJIl9bVcY5HHB9YuNZ
X-Google-Smtp-Source: ABdhPJyo5W/DfHXn19qu6sPSN04IlhtCipl/QCkzn0+H5L2492keX0vREPpPCQKufJEJiGZVevFkVxFqOCjM///HAnA=
X-Received: by 2002:a25:b706:: with SMTP id t6mr9330641ybj.695.1644543878099;
 Thu, 10 Feb 2022 17:44:38 -0800 (PST)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 10 Feb 2022 18:44:22 -0700
Message-ID: <CAJCQCtSeUtHCgsHXLGrSTWKmyjaQDbDNpP4rb0i+RE+L2FTXSA@mail.gmail.com>
Subject: bug kernel 5.17, qualcom and intel adapters, unable to reliably
 connect to bluetooth devices
To:     Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Since kernel 5.17, some users are seeing problems connecting to
bluetooth devices, the problem doesn't happen with 5.16 series
kernels.

So far two different devices are affected, although it's possible it's
not even device related, but could be the interface between kernel and
user space.

Case 1:

Bus 001 Device 003: ID 0cf3:e301 Qualcomm Atheros Communications

Not seeing anything that stands out in dmesg, bluetoothd -d shows
various curious messages like

bluetoothd[5889]: src/service.c:change_state() 0x7f33becdebc0: device
94:65:2D:DC:F4:A7 profile avrcp-controller state changed: disconnected
-> unavailable (0)
and
bluetoothd[5889]: src/service.c:change_state() 0x7f33becd91e0: device
94:65:2D:DC:F4:A7 profile Hands-Free Voice gateway state changed:
unavailable -> disconnected (0)


Case 2:

Bus 001 Device 005: ID 8087:0aaa Intel Corp. Bluetooth 9460/9560
Jefferson Peak (JfP)
[    5.923865] kernel: Bluetooth: hci0: Found device firmware:
intel/ibt-17-16-1.sfi
[    5.930536] kernel: Bluetooth: hci0: Boot Address: 0x40800
[    5.930539] kernel: Bluetooth: hci0: Firmware Version: 60-44.21
...
[16102.640651] Bluetooth: hci0: unexpected event 0xff length: 5 > 0
[16102.640802] Bluetooth: hci0: Waiting for device to boot
[16102.654712] Bluetooth: hci0: Device booted in 13698 usecs
[16102.654753] Bluetooth: hci0: unexpected event 0xff length: 7 > 0
[16102.655907] Bluetooth: hci0: Found Intel DDC parameters:
intel/ibt-17-16-1.ddc
[16102.657821] Bluetooth: hci0: Applying Intel DDC parameters completed
[16102.658829] Bluetooth: hci0: Firmware revision 0.1 build 60 week 44 2021
[17422.210558] Bluetooth: hci0: command 0x0c03 tx timeout
[17430.338412] Bluetooth: hci0: HCI reset during shutdown failed

[15975.194153] bluetoothd[42895]:
src/adapter.c:device_found_callback() hci0 addr 75:0B:19:0C:47:F6,
rssi -82 flags 0x0000 eir_len 17
[15975.194412] bluetoothd[42895]:
src/adv_monitor.c:btd_adv_monitor_offload_supported() Manager is NULL,
get offload support failed
[15975.194510] bluetoothd[42895]: src/device.c:device_set_legacy() legacy 0
[15975.194599] bluetoothd[42895]:
src/device.c:device_set_rssi_with_delta() rssi -82 delta 1
[15975.194661] bluetoothd[42895]: src/device.c:device_set_flags() flags 26

There are many many of the "Manager is NULL, get offload support
failed" messages in this case. I'm not entirely sure the root causes
are the same for the two cases.

Downstream bug has attachments (dmesg, btmon, lsbsb, journalctl
snippet with bluetoothd in debug, for both)
https://bugzilla.redhat.com/show_bug.cgi?id=2053283

Thanks,

-- 
Chris Murphy
