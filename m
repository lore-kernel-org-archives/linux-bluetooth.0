Return-Path: <SRS0=BC7s=QX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543CCC43381
	for <linux-bluetooth@archiver.kernel.org>; Sat, 16 Feb 2019 15:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18D0222A3
	for <linux-bluetooth@archiver.kernel.org>; Sat, 16 Feb 2019 15:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="sTrFeAAn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbfBPP7O (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 16 Feb 2019 10:59:14 -0500
Received: from cpsmtpb-ews07.kpnxchange.com ([213.75.39.10]:57633 "EHLO
        cpsmtpb-ews07.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727151AbfBPP7O (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 16 Feb 2019 10:59:14 -0500
X-Greylist: delayed 781 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Feb 2019 10:58:52 EST
Received: from cpsps-ews16.kpnxchange.com ([10.94.84.197]) by cpsmtpb-ews07.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Sat, 16 Feb 2019 16:45:50 +0100
X-Brand: /q/rzKX13g==
X-KPN-SpamVerdict: e1=0;e2=0;e3=0;e4=(e4=10;e1=10;e2=11;e3=10);EVW:Whi
        te;BM:NotScanned;FinalVerdict:Clean
X-CMAE-Analysis: v=2.3 cv=P9LreRIu c=1 sm=1 tr=0
         a=aUEkS+vox6QZufw8YjIg5Q==:117 a=WlLoZYvoDPkrvwfrrc3pQQ==:17
         a=IkcTkHD0fZMA:10 a=CFTnQlWoA9kA:10 a=MlH_b6sBIylOUtBgE8EA:9
         a=P02q-LbC7AcKt7Ge:21 a=3zVQZvEJ6Ab60jIw:21 a=QEXdDO2ut3YA:10
         a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-CM-AcctID: kpn@feedback.cloudmark.com
Received: from CPSMTPM-TLF104.kpnxchange.com ([195.121.3.7]) by cpsps-ews16.kpnxchange.com with Microsoft SMTPSVC(8.5.9600.16384);
         Sat, 16 Feb 2019 16:45:50 +0100
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; d=telfort.nl; s=telfort01;
        c=relaxed/relaxed; t=1550331950;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=CUu/Ny3JVxYeYD6nR7VQ6sbUnVuiTfRWn261BFdrJGI=;
        b=sTrFeAAnMrijndtZfNfk9s9uJWcm73s72TgLojluaAeu6oC+WZXmrgALeAM58wl0w7rtUnYQVPt
        5KXo1lFD/OrqCTLc8htkLRofek5Ef79QL97rcI0hZgohqeDZrcanfTvMk/DnJJHBNNtYazjJIUxAc
        chJfqWNgS1zAw/Za9iE=
Received: from [192.168.188.20] ([145.132.48.198]) by CPSMTPM-TLF104.kpnxchange.com over TLS secured channel with Microsoft SMTPSVC(7.5.7601.17514);
         Sat, 16 Feb 2019 16:45:50 +0100
Subject: When connecting to NAP bnep0 can not go up
From:   Ferry Toth <ftoth@exalondelft.nl>
To:     linux-bluetooth@vger.kernel.org
References: <27e70326-9ca5-dadc-e2ac-90fc81c1b167@exalondelft.nl>
Message-ID: <a776f208-7ca7-3eb5-adce-5756b838a4de@exalondelft.nl>
Date:   Sat, 16 Feb 2019 16:45:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <27e70326-9ca5-dadc-e2ac-90fc81c1b167@exalondelft.nl>
X-OriginalArrivalTime: 16 Feb 2019 15:45:50.0495 (UTC) FILETIME=[B12D12F0:01D4C60E]
X-RcptDomain: vger.kernel.org
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I'm trying to make a connection from my Edison (linux 4.19) to my android
phone (nap), but it seems Edison bnep0 gets removed immediately after
creation. How can help me diagnose this?

Initially I tried connman. The bluetooth service appears, but when I try to
connect I get:

connmanctl> connect bluetooth_43341B001FAC_C462EA01AF74
Error /net/connman/service/bluetooth_43341B001FAC_C462EA01AF74:
Input/output error

For testing I switched to the bluez test-network.py script:

root@edison:~# python3 ./test-network.py C4:62:EA:01:AF:74 nap
Traceback (most recent call last):
   File "./test-network.py", line 42, in <module>
     iface = network.Connect(service)
   File "/usr/lib/python3.5/site-packages/dbus/proxies.py", line 70, in
__call__
     return self._proxy_method(*args, **keywords)
   File "/usr/lib/python3.5/site-packages/dbus/proxies.py", line 145, in
__call__
     **keywords)
   File "/usr/lib/python3.5/site-packages/dbus/connection.py", line 651, in
call_blocking
     message, timeout)
dbus.exceptions.DBusException: org.bluez.Error.Failed: Input/output error

Using btmon to log while running above script:

< ACL Data TX: Handle 12 flags 0x00 dlen 11
#96 [hci0] 2974.047858
       Channel: 78 len 7 [PSM 15 mode 0] {chan 0}
       BNEP: Control (0x01|0)
          Setup Conn Req (0x01)
            Size: 0x02
            Dst: 0x1116(NAP)
            Src: 0x1115(PANU)
 > HCI Event: Number of Completed Packets (0x13) plen 5
#97 [hci0] 2974.049982
         Num handles: 1
         Handle: 12
         Count: 2
 > ACL Data RX: Handle 12 flags 0x02 dlen 8
#98 [hci0] 2974.052464
       Channel: 64 len 4 [PSM 15 mode 0] {chan 0}
       BNEP: Control (0x01|0)
          Setup Conn Rsp (0x02)
            Rsp msg: Operation Successful(0x0000)
= bluetoothd: bnep: Could not bring up bnep0: Cannot assign requested
address(99)
= bluetoothd: connect failed Input/output error

And logging with udevadm monitor:
KERNEL add /devices/pci..../serial0-0/bluetooth/hci0/hci0:12 (bluetooth)
UDEV   add /devices/pci..../serial0-0/bluetooth/hci0/hci0:12 (bluetooth)
KERNEL add /devices/pci..../serial0-0/bluetooth/hci0/hci0:12/net/bnep0 (net)
KERNEL add
/devices/pci..../serial0-0/bluetooth/hci0/hci0:12/net/bnep0/queues/rx-0
(queues)
KERNEL add
/devices/pci..../serial0-0/bluetooth/hci0/hci0:12/net/bnep0/queues/tx-0
(queues)
KERNEL remove
/devices/pci..../serial0-0/bluetooth/hci0/hci0:12/net/bnep0/queues/rx-0
(queues)
KERNEL[146116.687930] remove
/devices/pci..../serial0-0/bluetooth/hci0/hci0:12/net/bnep0/queues/tx-0
(queues)
KERNEL remove   /devices/pci..../serial0-0/bluetooth/hci0/hci0:12/net/bnep0
(net)
UDEV   add      /devices/pci..../serial0-0/bluetooth/hci0/hci0:12/net/bnep0
(net)
UDEV   add
/devices/pci..../serial0-0/bluetooth/hci0/hci0:12/net/bnep0/queues/rx-0
(queues)
UDEV   add
/devices/pci..../serial0-0/bluetooth/hci0/hci0:12/net/bnep0/queues/tx-0
(queues)
UDEV   remove
/devices/pci..../serial0-0/bluetooth/hci0/hci0:12/net/bnep0/queues/rx-0
(queues)
UDEV  [146116.776687] remove
/devices/pci..../serial0-0/bluetooth/hci0/hci0:12/net/bnep0/queues/tx-0
(queues)
UDEV   remove   /devices/pci..../serial0-0/bluetooth/hci0/hci0:12/net/bnep0
(net)
KERNEL remove   /devices/pci..../serial0-0/bluetooth/hci0/hci0:12
(bluetooth)
UDEV   remove   /devices/pci..../serial0-0/bluetooth/hci0/hci0:12
(bluetooth)

To me it looks like the kernel already removes the bnep0 device, before 
user
space can bring it up.

And indeed, doing the same from another computer (Ubuntu linux 4.18) I get
only the kernel and udev add events, the connection is established and the
remove events appear only after pressing Ctrl-C

What could this be?

