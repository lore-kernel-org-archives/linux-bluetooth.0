Return-Path: <SRS0=2sDM=QZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8BFC43381
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Feb 2019 15:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 537C620C01
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Feb 2019 15:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732962AbfBRPo7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Feb 2019 10:44:59 -0500
Received: from smtp.radex.nl ([178.250.146.7]:59531 "EHLO radex-web.radex.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730713AbfBRPo7 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Feb 2019 10:44:59 -0500
X-Greylist: delayed 496 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Feb 2019 10:44:58 EST
Received: from [192.168.1.22] (cust-178-250-146-69.breedbanddelft.nl [178.250.146.69])
        by radex-web.radex.nl (Postfix) with ESMTPS id 4278B24061;
        Mon, 18 Feb 2019 16:36:39 +0100 (CET)
Subject: Re: When connecting to NAP bnep0 can not go up
From:   Ferry Toth <ftoth@exalondelft.nl>
To:     linux-bluetooth@vger.kernel.org
References: <27e70326-9ca5-dadc-e2ac-90fc81c1b167@exalondelft.nl>
 <81ee645c-f9ae-f1f2-4c3c-89d55c7ccddf@exalondelft.nl>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Message-ID: <f1dbdbbf-9e8e-ab9e-6079-4f3e60e7e233@exalondelft.nl>
Date:   Mon, 18 Feb 2019 16:36:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <81ee645c-f9ae-f1f2-4c3c-89d55c7ccddf@exalondelft.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Adding Andy, Marcel, Johan to CC

Op 16-02-19 om 18:38 schreef Ferry Toth:
> I'm trying to make a connection from my Edison (linux 4.19) to my android
> phone (nap), but it seems Edison bnep0 gets removed immediately after
> creation. How can help me diagnose this?

Actually, this is using Andy's kernel 4.20 (not 4.19).

I didn't mention that other BT functionality seems to be working fine. 
And building with Yocto Thud (bluez 5.50).

Everything is fairly up-to-date (compared to Edison factory image).

> Initially I tried connman. The bluetooth service appears, but when I 
> try to
> connect I get:
>
> connmanctl> connect bluetooth_43341B001FAC_C462EA01AF74
> Error /net/connman/service/bluetooth_43341B001FAC_C462EA01AF74:
> Input/output error
>
> For testing I switched to the bluez test-network.py script:
>
> root@edison:~# python3 ./test-network.py C4:62:EA:01:AF:74 nap
> Traceback (most recent call last):
>   File "./test-network.py", line 42, in <module>
>     iface = network.Connect(service)
>   File "/usr/lib/python3.5/site-packages/dbus/proxies.py", line 70, in
> __call__
>     return self._proxy_method(*args, **keywords)
>   File "/usr/lib/python3.5/site-packages/dbus/proxies.py", line 145, in
> __call__
>     **keywords)
>   File "/usr/lib/python3.5/site-packages/dbus/connection.py", line 
> 651, in
> call_blocking
>     message, timeout)
> dbus.exceptions.DBusException: org.bluez.Error.Failed: Input/output error
>
> Using btmon to log while running above script:
>
> < ACL Data TX: Handle 12 flags 0x00 dlen 11
> #96 [hci0] 2974.047858
>       Channel: 78 len 7 [PSM 15 mode 0] {chan 0}
>       BNEP: Control (0x01|0)
>          Setup Conn Req (0x01)
>            Size: 0x02
>            Dst: 0x1116(NAP)
>            Src: 0x1115(PANU)
>> HCI Event: Number of Completed Packets (0x13) plen 5
> #97 [hci0] 2974.049982
>         Num handles: 1
>         Handle: 12
>         Count: 2
>> ACL Data RX: Handle 12 flags 0x02 dlen 8
> #98 [hci0] 2974.052464
>       Channel: 64 len 4 [PSM 15 mode 0] {chan 0}
>       BNEP: Control (0x01|0)
>          Setup Conn Rsp (0x02)
>            Rsp msg: Operation Successful(0x0000)
> = bluetoothd: bnep: Could not bring up bnep0: Cannot assign requested
> address(99)
> = bluetoothd: connect failed Input/output error
>
> And logging with udevadm monitor:
> KERNEL add /devices/pci..../serial0-0/bluetooth/hci0/hci0:12 (bluetooth)
> UDEV   add /devices/pci..../serial0-0/bluetooth/hci0/hci0:12 (bluetooth)
> KERNEL add /devices/pci..../serial0-0/bluetooth/hci0/hci0:12/net/bnep0 
> (net)
> KERNEL add
> /devices/pci..../serial0-0/bluetooth/hci0/hci0:12/net/bnep0/queues/rx-0
> (queues)
> KERNEL add
> /devices/pci..../serial0-0/bluetooth/hci0/hci0:12/net/bnep0/queues/tx-0
> (queues)
> KERNEL remove
> /devices/pci..../serial0-0/bluetooth/hci0/hci0:12/net/bnep0/queues/rx-0
> (queues)
> KERNEL[146116.687930] remove
> /devices/pci..../serial0-0/bluetooth/hci0/hci0:12/net/bnep0/queues/tx-0
> (queues)
> KERNEL 
> remove   /devices/pci..../serial0-0/bluetooth/hci0/hci0:12/net/bnep0
> (net)

Note the KERNEL already issues a remove before UDEV add

> UDEV   add      /devices/pci..../serial0-0/bluetooth/hci0/hci0:12/net/bnep0 
>
> (net)
> UDEV   add
> /devices/pci..../serial0-0/bluetooth/hci0/hci0:12/net/bnep0/queues/rx-0
> (queues)
> UDEV   add
> /devices/pci..../serial0-0/bluetooth/hci0/hci0:12/net/bnep0/queues/tx-0
> (queues)
> UDEV   remove
> /devices/pci..../serial0-0/bluetooth/hci0/hci0:12/net/bnep0/queues/rx-0
> (queues)
> UDEV  [146116.776687] remove
> /devices/pci..../serial0-0/bluetooth/hci0/hci0:12/net/bnep0/queues/tx-0
> (queues)
> UDEV   remove   /devices/pci..../serial0-0/bluetooth/hci0/hci0:12/net/bnep0 
>
> (net)
> KERNEL remove   /devices/pci..../serial0-0/bluetooth/hci0/hci0:12
> (bluetooth)
> UDEV   remove   /devices/pci..../serial0-0/bluetooth/hci0/hci0:12
> (bluetooth)
>
> To me it looks like the kernel already removes the bnep0 device, 
> before user
> space can bring it up.
>
> And indeed, doing the same from another computer (Ubuntu linux 4.18) I 
> get
> only the kernel and udev add events, the connection is established and 
> the
> remove events appear only after pressing Ctrl-C
>
> What could this be?
>
>
