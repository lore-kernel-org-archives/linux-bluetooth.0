Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE83C67871
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Oct 2022 22:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbiJXW4l convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Oct 2022 18:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbiJXWz5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Oct 2022 18:55:57 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670CF2D75B
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Oct 2022 14:17:27 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id h10so7301032qvq.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Oct 2022 14:17:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-disposition:message-id
         :mime-version:to:subject:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mzM+CwAn5cD3N4rEl83EcVyjqky3hSmdFB9Yzw3TcHY=;
        b=XjNxf9ncYL85ayAsZ1nMvX8poqzD31aSyf0B+fZPa2DWlJnGmCZ/vTKRGI768iSbUS
         PdPPNuR5ayTGM3PC9giQb2LzjleFOQRubixu0eOCdpFDx/LpcyuB7NgHjtfVxBw67vQq
         ngfn3jDyhAscd56gLkIbxinZsAfFry7kwBYpbJU1aF+4VkkE8N29pZDcN8glTAMV7t9t
         PMNOUovnB0ZGoMZWWgSYGxMGT+Vlon78X1R6wZPv47DEJ4wdgJrmGHkcM8rKH3mS6ktr
         M4rc2OMSyOqn7MvFyJ5Yq6hkfuvBchdb38J9mt+w9xFZLngfgW/frHomHNxrUbYnkUH2
         R00w==
X-Gm-Message-State: ACrzQf2RlmGGWGdJk+CM4jkA7pThAY8LB4ecCEMnWxMbUS4i1NF2J8f7
        m2+MrMq5w0hFVF0cCqK2PqAOQKXPp1tFsOeK
X-Google-Smtp-Source: AMsMyM7gqhJ/FmKPb2zuwUrxsIvOaiIyiq+5MYRaHdLd4pFx7HG4dd/j1amDPohwokpFvLlwjqderQ==
X-Received: by 2002:a05:6214:2467:b0:4ba:f07c:d9f7 with SMTP id im7-20020a056214246700b004baf07cd9f7mr16080215qvb.24.1666645914156;
        Mon, 24 Oct 2022 14:11:54 -0700 (PDT)
Received: from ffortso9 (c-73-238-129-126.hsd1.ct.comcast.net. [73.238.129.126])
        by smtp.gmail.com with ESMTPSA id br17-20020a05620a461100b006e9b3096482sm663962qkb.64.2022.10.24.14.11.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 14:11:53 -0700 (PDT)
Date:   Mon, 24 Oct 2022 17:11:52 -0400
From:   Jack <ostroffjh@users.sourceforge.net>
Subject: [Regression] Cambridge Silicon Radio, Ltd Bluetooth Dongle unusable
 again with kernel 6.0
To:     linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
X-Mailer: Balsa 2.6.4
Message-Id: <RJ4W7HKW.X5Y4H63W.RFY63IY6@7AFBARQQ.HKEIB7DO.6ME2HPJY>
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Cheap USB BT dongles that are bad clones of CSR  "ID 0a12:0001  
Cambridge Silicon Radio, Ltd Bluetooth Dongle (HCI mode)" have had  
historic problems, due to various bad behaviors.  See [Bug 60824]  
[PATCH][regression] Cambridge Silicon Radio, Ltd Bluetooth Dongle  
unusable (https://bugzilla.kernel.org/show_bug.cgi) for more details  
and background.  The patch in that bug was initially mainlined in 5.9,  
and underwent several revisions since then.  It has continued to work  
through all of the 5.19 series, but it does not work with any of the  
6.0 kernels.

I have made three unsuccessful attempts to git bisect using vanilla  
sources.  All settled on totally irrelevant commits.  These have all  
used v6.0-rc1 and v5.19 as the starting bad and good commits.

Having read all the pages on filing a [REGRESSION} bug, I'm a bit  
intimidated to file something without sufficient information to be  
taken seriously, but will do so using this information, if that seems  
the best course of action.

Thanks for any advice, including requests for additional information.

Below is the output from 'dmesg | egrep -iC2 "bt|blue" of a typical  
failed boot.  Note that unplugging and replugging the dongle (sometimes  
two or more times) will sometimes be successful in having it recognized  
and usable.

[    2.284192] usb 1-2: New USB device found, idVendor=0a12,  
idProduct=0001, bcdDevice=88.91
[    2.284925] usb 1-2: New USB device strings: Mfr=0, Product=2,  
SerialNumber=0
[    2.285648] usb 1-2: Product: BT DONGLE10
[    2.416732] usb 1-8: new high-speed USB device number 3 using  
xhci_hcd
[    2.480396] usb 3-2: new low-speed USB device number 3 using xhci_hcd
--
[    3.809944] [drm] GART: num cpu pages 524288, num gpu pages 524288
[    3.810893] [drm] PCIE gen 3 link speeds already enabled
[    3.820930] Bluetooth: Core ver 2.22
[    3.820951] NET: Registered PF_BLUETOOTH protocol family
[    3.820955] Bluetooth: HCI device and connection manager initialized
[    3.820960] Bluetooth: HCI socket layer initialized
[    3.820964] Bluetooth: L2CAP socket layer initialized
[    3.820968] Bluetooth: SCO socket layer initialized
[    3.826636] usbcore: registered new interface driver btusb
[    3.827192] [drm] PCIE GART of 2048M enabled (table at  
0x00000000001D6000).
[    3.827302] radeon 0000:1c:00.0: WB enabled
--
[    3.827320] radeon 0000:1c:00.0: fence driver on ring 4 use gpu addr  
0x0000000040000c10
[    3.827531] radeon 0000:1c:00.0: fence driver on ring 5 use gpu addr  
0x0000000000075a18
[    3.828917] Bluetooth: hci0: CSR: Unbranded CSR clone detected;  
adding workarounds and force-suspending once...
[    3.828925] Bluetooth: hci0: CSR: Couldn't suspend the device for  
our Barrot 8041a02 receive-issue workaround
[    3.828932] Bluetooth: hci0: HCI Delete Stored Link Key command is  
advertised, but not supported.
[    3.828936] Bluetooth: hci0: HCI Set Event Filter command not  
supported.
[    3.840596] sr 5:0:0:0: Attached scsi CD-ROM sr0
[    3.843043] usbcore: registered new interface driver snd-usb-audio
--
[    5.436854] [drm] ib test on ring 5 succeeded
[    5.943391] [drm] ib test on ring 6 succeeded
[    5.996684] Bluetooth: hci0: Opcode 0x c5a failed: -110
[    5.996712] Bluetooth: hci0: command tx timeout
[    6.125712] EXT4-fs (nvme0n1p2): re-mounted. Quota mode: none.
[    6.231315] Adding 15728636k swap on /dev/sda2.  Priority:-2  
extents:1 across:15728636k FS
--
[    7.866607] amdgpu: Virtual CRAT table created for CPU
[    7.866630] amdgpu: Topology: Add CPU node
[    7.957240] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    7.957257] Bluetooth: BNEP filters: protocol multicast
[    7.957272] Bluetooth: BNEP socket layer initialized
[    8.611080] RPC: Registered named UNIX socket transport module.
[    8.611607] RPC: Registered udp transport module.

A successful run produces something like:
[  107.893971] usb 1-2: New USB device found, idVendor=0a12,  
idProduct=0001, bcdDevice=88.91
[  107.893979] usb 1-2: New USB device strings: Mfr=0, Product=2,  
SerialNumber=0
[  107.893982] usb 1-2: Product: BT DONGLE10
[  107.906721] Bluetooth: hci0: CSR: Unbranded CSR clone detected;  
adding workarounds and force-suspending once...
[  107.906731] Bluetooth: hci0: CSR: Couldn't suspend the device for  
our Barrot 8041a02 receive-issue workaround
[  107.906737] Bluetooth: hci0: HCI Delete Stored Link Key command is  
advertised, but not supported.
[  107.906739] Bluetooth: hci0: HCI Read Default Erroneous Data  
Reporting command is advertised, but not supported.
[  107.906741] Bluetooth: hci0: HCI Set Event Filter command not  
supported.
[  108.050825] Bluetooth: RFCOMM TTY layer initialized
[  108.050834] Bluetooth: RFCOMM socket layer initialized
[  108.050842] Bluetooth: RFCOMM ver 1.11
