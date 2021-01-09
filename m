Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1FEC433DB
	for <linux-bluetooth@archiver.kernel.org>; Sat,  9 Jan 2021 18:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5795A2242A
	for <linux-bluetooth@archiver.kernel.org>; Sat,  9 Jan 2021 18:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbhAISTe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 9 Jan 2021 13:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbhAISTe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 9 Jan 2021 13:19:34 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012BBC06179F
        for <linux-bluetooth@vger.kernel.org>; Sat,  9 Jan 2021 10:18:54 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id c124so10318907wma.5
        for <linux-bluetooth@vger.kernel.org>; Sat, 09 Jan 2021 10:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=uc0tt/0pOWH/C8G9WDgbVAEw+51PKmnsm+C0Lo3EB0k=;
        b=QhhJCjm3nMpkfPsRu0zPcmU2DDjsA67nsQamx3f/zEjKaWTcieu4SgBAiTg4fychA1
         PdIirhLbt5oV1ULuzi8K2NzCiwnE4EJVOtIlZR2oDL9m8hQuNGMk9ykP5yDBz2uxnrYJ
         oens7IudPwuthUgnW7IJbkBatUvhi8f8BjXC2wVYV4bybVQhMh5ksUlIKp35nvt7VWWr
         zgvXmpttnFC7LGQ6QrzIkf+iQLpaJz/lQDUq93EdqfQZzeIsICF8nRQaW9M80gSUoyac
         /x+4R72sZXh/GAgB/Vo1ZKINfHSNVIVY98D9huhN0LRU0n/0rPB05rg/yp4vjsiSWHba
         kVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=uc0tt/0pOWH/C8G9WDgbVAEw+51PKmnsm+C0Lo3EB0k=;
        b=p5uM/S6U1fS3Dnh1WBEurrjb8jtZ67BFBqirwS+bs6qU7kDSzSQqnfg/4CwCIDz7ak
         CNg5BeuhZkeSZCei07Chj4Xkd0826Gh6nHYUkHTqtJbR4N64bWE/wRB1c8Ebljppawyi
         ohDggHPy4NWMyshBOLvpeGdHj+xFhi48+NkRA7VJWKL8nyi1jwTTSu8Kc0n6Nj3+CyAu
         oihU7rjFDr7SqkbJg5HGUAcf+deQD8qBWjcG62MqiOPJotPtf9teYitbw2F1u5AemVme
         D25hZT3ZEYx6teFJuKSabYf6EQs5iou5LC/VrV84JXl8jXhRQ7S1+O+vsUQ8rbGzN3D/
         /aRA==
X-Gm-Message-State: AOAM531WRey4JDdKJzsKNh9y2/bh6JASXoVWuQnu6yEMltQxcxyBuTmX
        BBoKy5zztX+ShDKVccEjMl5UgEvQVNVpjg3DyG7XT4ub+Qnzuw==
X-Google-Smtp-Source: ABdhPJyQM7fZ6jez23R2YdHmu7oIDbl+TD5Cb7zlRlZVeRtSTO4EOtqEmMn6uIzfXi07KsngtEfHFMo+uIhAA1Qt1sI=
X-Received: by 2002:a05:600c:21d5:: with SMTP id x21mr8080121wmj.10.1610216332189;
 Sat, 09 Jan 2021 10:18:52 -0800 (PST)
MIME-Version: 1.0
From:   Martin Townsend <mtownsend1973@gmail.com>
Date:   Sat, 9 Jan 2021 18:18:41 +0000
Message-ID: <CABatt_w0CxJGX7Vp+h-hOe3EE0CgjWiprom400iawXJ4BmbURQ@mail.gmail.com>
Subject: bluetoothctl not listing the controller when I disable the HID profiles
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

I've been debugging a problem where my bluetooth device wasn't showing
up in bluetoothctl.  I was building with the following configuration:

--disable-a2dp --disable-avrcp --disable-btpclient --disable-cups
--enable-deprecated --enable-health --disable-hid --disable-hog
--disable-mesh --disable-midi --disable-network --disable-nfc
--disable-obex --enable-client --disable-sap --disable-sixaxis
--enable-systemd --disable-testing --disable-threads --enable-tools
--disable-udev

Basically the stack is running on a very resource constrained MIPS
based board so I'm trying to reduce the stack down to the essential
which is just to read BLE sensors.  But with this configuration
bluetoothctl lists no default controllers.  Now if I enable HID
profiles with
--enable-hid

It works and I can list the controller and connect to a BLE sensor and
perform all the various GATT commands.

Is this expected? I would have thought I could safely disable HID
profiles as I'm not going to be connecting any keyboards or mice.

Bluez stack is 5.54
Kernel is 5.4.76

This was built using Yocto but I'm sure I could get this build a newer
version if you think this has already been fixed.

One thing I've noticed is that when bringing up hci0 when HID is
enabled I get the following

hciconfig hci0 up
[   48.704477][  T140] rtk_btusb: btusb_open start
[   48.713535][  T140] rtk_btusb: btusb_open hdev->promisc ==0
[   48.724586][  T140] rtk_btusb: download_patch start
[   48.734262][  T140] rtk_btusb: chip type value: 0x74
[   48.744098][  T140] rtk_btusb: HCI reset.
[   48.763108][  T140] rtk_btusb: read_ver_rsp->lmp_subver = 0x646b
[   48.775279][  T140] rtk_btusb: read_ver_rsp->hci_rev = 0x999
[   48.786501][  T140] rtk_btusb: patch_entry->lmp_sub = 0x8761
[   48.797712][  T140] rtk_btusb: Firmware already exists
[   48.807889][  T140] rtk_btusb: Rtk patch end 1
[   48.816687][  T140] rtk_btusb: btusb_open set HCI_RUNNING
[   48.827449][  T140] rtk_btcoex: Open BTCOEX
[   48.835745][  T140] rtk_btusb: btusb_open end
[   48.849158][    T3] rtk_btcoex: BTCOEX hci_rev 0x0999
[   48.859302][    T3] rtk_btcoex: BTCOEX lmp_subver 0x646b
Can't init device hci0: Invalid argument (22)

even though there is an error it works!!!

When it's disabled I don't get the error at the end and it doesn't work:

[   44.084337][  T137] rtk_btusb: btusb_open start
[   44.093395][  T137] rtk_btusb: btusb_open hdev->promisc ==0
[   44.104446][  T137] rtk_btusb: download_patch start
[   44.114109][  T137] rtk_btusb: chip type value: 0x74
[   44.123946][  T137] rtk_btusb: HCI reset.
[   44.143090][  T137] rtk_btusb: read_ver_rsp->lmp_subver = 0x8761
[   44.155259][  T137] rtk_btusb: read_ver_rsp->hci_rev = 0xb
[   44.166140][  T137] rtk_btusb: patch_entry->lmp_sub = 0x8761
[   44.177350][  T137] rtk_btusb: load_firmware start
[   44.186843][  T137] rtk_btusb: lmp_version = 0x8761
[   44.196502][  T137] rtk_btusb: config filename rtl8761bu_config
[   44.214206][  T137] LoadPin: mnt_sb lacks block device, treating as: writable
[   44.228442][  T137] LoadPin: enforcement can be disabled.
[   44.240206][  T137] LoadPin: firmware pinned
obj="/lib/firmware/rtl8761bu_config" pid=137 cmdline="hciconfig hci0
up"
[   44.263326][  T137] rtk_btusb: no bdaddr file /opt/bdaddr
[   44.274090][  T137] rtk_btusb: Origin cfg len 6
[   44.283073][  T137] rtk_btusb: 55 ab 23 87 00 00
[   44.292235][  T137] rtk_btusb: New cfg len 6
[   44.300690][  T137] rtk_btusb: 55 ab 23 87 00 00
[   44.312206][  T137] rtk_btusb: fw name is  rtl8761bu_fw
[   44.328515][  T137] rtk_btusb: This is not 8723a, use new patch style!
[   44.341527][  T137] rtk_btusb: rtk_get_eversion: gEVersion 255
[   44.355112][  T137] rtk_btusb: eversion->status = 0x0,
eversion->version = 0x1
[   44.369710][  T137] rtk_btusb: load_firmware: New gEVersion 1
[   44.381110][  T137] rtk_btusb: rtk_get_fw_project_id: opcode 0, len
1, data 14
[   44.395424][  T137] rtk_btusb: lmp_version is 8761, project_id is
8761, match!
[   44.409728][  T137] rtk_btusb: fw_version = 0x999646b
[   44.419731][  T137] rtk_btusb: number_of_total_patch = 2
[   44.430250][  T137] rtk_btusb: chipID 2
[   44.437847][  T137] rtk_btusb: patch_length 0x5024
[   44.447331][  T137] rtk_btusb: start_offset 0x00003780
[   44.457508][  T137] rtk_btusb: Svn version:    23166
[   44.467339][  T137] rtk_btusb: Coexistence: BTCOEX_20190327-0202
[   44.479235][  T137] rtk_btusb: buf_len = 0x502a
[   44.488460][  T137] rtk_btusb: fw: exists, config file: exists
[   44.500037][  T137] rtk_btusb: load_firmware done
[   44.515792][  T137] rtk_btusb: download_data start
[   44.636082][  T137] rtk_btusb: download_data done
[   44.645683][  T137] rtk_btusb: HCI reset.
[   44.665084][  T137] rtk_btusb: read_ver_rsp->lmp_subver = 0x646b
[   44.677260][  T137] rtk_btusb: read_ver_rsp->hci_rev = 0x999
[   44.688487][  T137] rtk_btusb: patch_entry->lmp_sub = 0x8761
[   44.699720][  T137] rtk_btusb: Rtk patch end 0
[   44.708525][  T137] rtk_btusb: btusb_open set HCI_RUNNING
[   44.719288][  T137] rtk_btcoex: Open BTCOEX
[   44.727576][  T137] rtk_btusb: btusb_open end
[   44.741138][   T43] rtk_btcoex: BTCOEX hci_rev 0x0999
[   44.751278][   T43] rtk_btcoex: BTCOEX lmp_subver 0x646b
[   44.782126][   T56] rtk_btusb: btusb_notify: hci0 evt 3

Many Thanks,
Martin.
