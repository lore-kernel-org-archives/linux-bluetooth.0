Return-Path: <SRS0=7efI=RN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C123C43381
	for <linux-bluetooth@archiver.kernel.org>; Sun, 10 Mar 2019 13:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D734E206DF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 10 Mar 2019 13:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="MXCpEM5I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfCJNIn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 10 Mar 2019 09:08:43 -0400
Received: from cpsmtpb-ews09.kpnxchange.com ([213.75.39.14]:63425 "EHLO
        cpsmtpb-ews09.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726000AbfCJNIn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 10 Mar 2019 09:08:43 -0400
Received: from cpsps-ews18.kpnxchange.com ([10.94.84.184]) by cpsmtpb-ews09.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Sun, 10 Mar 2019 14:08:17 +0100
X-Brand: +YTO/YbK+g==
X-KPN-SpamVerdict: e1=0;e2=0;e3=0;e4=(e4=10;e1=10;e3=10;e2=11);EVW:Whi
        te;BM:NotScanned;FinalVerdict:Clean
X-CMAE-Analysis: v=2.3 cv=L/7MvNb8 c=1 sm=1 tr=0
         a=aUEkS+vox6QZufw8YjIg5Q==:117 a=WlLoZYvoDPkrvwfrrc3pQQ==:17
         a=IkcTkHD0fZMA:10 a=NTGMnVQrEZIA:10 a=9uZ1ClE2CK9A1V3RO80A:9
         a=58EeHWXWheks6R-w:21 a=sf6XDCSIgmi99_UK:21 a=QEXdDO2ut3YA:10
X-CM-AcctID: kpn@feedback.cloudmark.com
Received: from CPSMTPM-TLF104.kpnxchange.com ([195.121.3.7]) by cpsps-ews18.kpnxchange.com with Microsoft SMTPSVC(8.5.9600.16384);
         Sun, 10 Mar 2019 14:08:17 +0100
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; d=telfort.nl; s=telfort01;
        c=relaxed/relaxed; t=1552223297;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=xCa+B1P+j9IqZ9y7OeVuHPnFHf6OJSQ21sPrBY8xsy0=;
        b=MXCpEM5ILf5LDj7V0aAePqh5LE98i40UnaXHqzC+9ptWhapW31E4EQkBZg6IYbiHcI7BurMZmKs
        kq9gaJ7IXWUgbBLQKH+KXNCgPAve9yuWsh8W8bzXzXShxwluisk/Ccl3x3F5BbZG2IdT9YlBNdeVe
        1tRd/U9TvB6ig840JG0=
Received: from [192.168.188.20] ([145.132.48.198]) by CPSMTPM-TLF104.kpnxchange.com over TLS secured channel with Microsoft SMTPSVC(7.5.7601.17514);
         Sun, 10 Mar 2019 14:08:17 +0100
Subject: Re: When connecting to NAP bnep0 can not go up
From:   Ferry Toth <ftoth@exalondelft.nl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <27e70326-9ca5-dadc-e2ac-90fc81c1b167@exalondelft.nl>
 <81ee645c-f9ae-f1f2-4c3c-89d55c7ccddf@exalondelft.nl>
 <f1dbdbbf-9e8e-ab9e-6079-4f3e60e7e233@exalondelft.nl>
 <84f08287-fb56-638a-f19c-73b779a4f620@exalondelft.nl>
Message-ID: <fee778ee-8955-11a4-f2f4-c859f484e967@exalondelft.nl>
Date:   Sun, 10 Mar 2019 14:08:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <84f08287-fb56-638a-f19c-73b779a4f620@exalondelft.nl>
X-OriginalArrivalTime: 10 Mar 2019 13:08:17.0927 (UTC) FILETIME=[54182970:01D4D742]
X-RcptDomain: vger.kernel.org
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


Op 24-02-19 om 18:13 schreef Ferry Toth:
> Marcel,
>
> Op 18-02-19 om 16:36 schreef Ferry Toth:
>> Adding Andy, Marcel, Johan to CC
>>
>> Op 16-02-19 om 18:38 schreef Ferry Toth:
>>> I'm trying to make a connection from my Edison (linux 4.19) to my 
>>> android
>>> phone (nap), but it seems Edison bnep0 gets removed immediately after
>>> creation. How can help me diagnose this?
>>
>> Actually, this is using Andy's kernel 4.20 (not 4.19).
>>
>> I didn't mention that other BT functionality seems to be working 
>> fine. And building with Yocto Thud (bluez 5.50).
>>
>> Everything is fairly up-to-date (compared to Edison factory image).
>>
>>> Initially I tried connman. The bluetooth service appears, but when I 
>>> try to
>>> connect I get:
>>>
>>> connmanctl> connect bluetooth_43341B001FAC_C462EA01AF74
>>> Error /net/connman/service/bluetooth_43341B001FAC_C462EA01AF74:
>>> Input/output error
>>>
>>> For testing I switched to the bluez test-network.py script:
>>>
>>> root@edison:~# python3 ./test-network.py C4:62:EA:01:AF:74 nap
>>> Traceback (most recent call last):
>>>   File "./test-network.py", line 42, in <module>
>>>     iface = network.Connect(service)
>>>   File "/usr/lib/python3.5/site-packages/dbus/proxies.py", line 70, in
>>> __call__
>>>     return self._proxy_method(*args, **keywords)
>>>   File "/usr/lib/python3.5/site-packages/dbus/proxies.py", line 145, in
>>> __call__
>>>     **keywords)
>>>   File "/usr/lib/python3.5/site-packages/dbus/connection.py", line 
>>> 651, in
>>> call_blocking
>>>     message, timeout)
>>> dbus.exceptions.DBusException: org.bluez.Error.Failed: Input/output 
>>> error
>>>
>>> Using btmon to log while running above script:
>>>
>>> < ACL Data TX: Handle 12 flags 0x00 dlen 11
>>> #96 [hci0] 2974.047858
>>>       Channel: 78 len 7 [PSM 15 mode 0] {chan 0}
>>>       BNEP: Control (0x01|0)
>>>          Setup Conn Req (0x01)
>>>            Size: 0x02
>>>            Dst: 0x1116(NAP)
>>>            Src: 0x1115(PANU)
>>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>> #97 [hci0] 2974.049982
>>>         Num handles: 1
>>>         Handle: 12
>>>         Count: 2
>>>> ACL Data RX: Handle 12 flags 0x02 dlen 8
>>> #98 [hci0] 2974.052464
>>>       Channel: 64 len 4 [PSM 15 mode 0] {chan 0}
>>>       BNEP: Control (0x01|0)
>>>          Setup Conn Rsp (0x02)
>>>            Rsp msg: Operation Successful(0x0000)
>>> = bluetoothd: bnep: Could not bring up bnep0: Cannot assign requested
>>> address(99)
>>> = bluetoothd: connect failed Input/output error
>>>
>>> And logging with udevadm monitor:
>>> KERNEL add /devices/pci..../serial0-0/bluetooth/hci0/hci0:12 
>>> (bluetooth)
>>> UDEV   add /devices/pci..../serial0-0/bluetooth/hci0/hci0:12 
>>> (bluetooth)
>>> KERNEL add 
>>> /devices/pci..../serial0-0/bluetooth/hci0/hci0:12/net/bnep0 (net)
>>> KERNEL add
>>> /devices/pci..../serial0-0/bluetooth/hci0/hci0:12/net/bnep0/queues/rx-0
>>> (queues)
>>> KERNEL add
>>> /devices/pci..../serial0-0/bluetooth/hci0/hci0:12/net/bnep0/queues/tx-0
>>> (queues)
>>> KERNEL remove
>>> /devices/pci..../serial0-0/bluetooth/hci0/hci0:12/net/bnep0/queues/rx-0
>>> (queues)
>>> KERNEL[146116.687930] remove
>>> /devices/pci..../serial0-0/bluetooth/hci0/hci0:12/net/bnep0/queues/tx-0
>>> (queues)
>>> KERNEL 
>>> remove   /devices/pci..../serial0-0/bluetooth/hci0/hci0:12/net/bnep0
>>> (net)
>>
>> Note the KERNEL already issues a remove before UDEV add
>>
>>> UDEV   add      /devices/pci..../serial0-0/bluetooth/hci0/hci0:12/net/bnep0 
>>>
>>> (net)
>>> UDEV   add
>>> /devices/pci..../serial0-0/bluetooth/hci0/hci0:12/net/bnep0/queues/rx-0
>>> (queues)
>>> UDEV   add
>>> /devices/pci..../serial0-0/bluetooth/hci0/hci0:12/net/bnep0/queues/tx-0
>>> (queues)
>>> UDEV   remove
>>> /devices/pci..../serial0-0/bluetooth/hci0/hci0:12/net/bnep0/queues/rx-0
>>> (queues)
>>> UDEV  [146116.776687] remove
>>> /devices/pci..../serial0-0/bluetooth/hci0/hci0:12/net/bnep0/queues/tx-0
>>> (queues)
>>> UDEV   remove   /devices/pci..../serial0-0/bluetooth/hci0/hci0:12/net/bnep0 
>>>
>>> (net)
>>> KERNEL remove   /devices/pci..../serial0-0/bluetooth/hci0/hci0:12
>>> (bluetooth)
>>> UDEV   remove   /devices/pci..../serial0-0/bluetooth/hci0/hci0:12
>>> (bluetooth)
>>>
>>> To me it looks like the kernel already removes the bnep0 device, 
>>> before user
>>> space can bring it up.
>>>
>>> And indeed, doing the same from another computer (Ubuntu linux 4.18) 
>>> I get
>>> only the kernel and udev add events, the connection is established 
>>> and the
>>> remove events appear only after pressing Ctrl-C
>>>
>>> What could this be?
>>>
> To check my kernel configuration I now added btusb kernel module, no 
> other changes. Then I attach:
>
> root@edison:~# lsusb
> ..
> Bus 001 Device 004: ID 050d:0131 Belkin Components Bluetooth Device 
> with trace filter
>
> ..
>
> Which gives me 2 bt controllers. The Edison uses btbcm:
>
>
> root@edison:~# journalctl -b 0 | grep -i bcm
> Jan 25 21:13:35 edison kernel: Bluetooth: hci0: BCM: chip id 82
> Jan 25 21:13:35 edison kernel: Bluetooth: hci0: BCM: features 0x2f
> Jan 25 21:13:35 edison kernel: Bluetooth: hci0: BCM43341B0
> Jan 25 21:13:35 edison kernel: Bluetooth: hci0: BCM43341B0 
> (002.001.014) build 0000
>
> Jan 25 21:13:36 edison kernel: Bluetooth: hci0: BCM43341B0 
> (002.001.014) build 0176
>
>
> Connman shows now 2 bt controllers, on using btbcm and one using 
> btusb. Connecting using btusb using the Belkin works fine.
>
>
> Connecting and disconnecting while watching with udevadm monitor:
>
> (BTUSB connect)
>
> KERNEL[11332.104716] add 
> /devices/pci0000:00/0000:00:11.0/dwc3.0.auto/xhci-hcd.1.auto/usb1/1-1/1-1.4/1-1.4:1.0/bluetooth/hci1/hci1:12 
> (bluetooth)
> UDEV  [11332.114629] add      " (bluetooth)
> KERNEL[11332.432039] add      "/net/bnep0 (net)
> KERNEL[11332.432255] add      "/net/bnep0/queues/rx-0 (queues)
> KERNEL[11332.432431] add      "/net/bnep0/queues/tx-0 (queues)
> UDEV  [11332.489620] add      "/net/bnep0 (net)
> UDEV  [11332.506436] add      "/net/bnep0/queues/rx-0 (queues)
> UDEV  [11332.517584] add      "/net/bnep0/queues/tx-0 (queues)
>
> (BTUSB disconnect)
>
> KERNEL[11351.254976] remove   "/net/bnep0/queues/rx-0 (queues)
> KERNEL[11351.255204] remove   "/net/bnep0/queues/tx-0 (queues)
> KERNEL[11351.255483] remove   "/net/bnep0 (net)
> UDEV  [11351.268731] remove   "/net/bnep0/queues/rx-0 (queues)
> UDEV  [11351.270734] remove   "/net/bnep0/queues/tx-0 (queues)
> UDEV  [11351.285370] remove   "/net/bnep0 (net)
> KERNEL[11353.494377] remove   " (bluetooth)
> UDEV  [11353.498291] remove   " (bluetooth)
>
> (BTBCM connect)
>
> KERNEL[11368.188073] add 
> /devices/pci0000:00/0000:00:04.1/serial0/serial0-0/bluetooth/hci0/hci0:12 
> (bluetooth)
> UDEV  [11368.194174] add      " (bluetooth)
> KERNEL[11368.292190] add      "/net/bnep0 (net)
> KERNEL[11368.292411] add      "/net/bnep0/queues/rx-0 (queues)
> KERNEL[11368.292588] add      "/net/bnep0/queues/tx-0 (queues)
> KERNEL[11368.299872] remove   "/net/bnep0/queues/rx-0 (queues)
> KERNEL[11368.301253] remove   "/net/bnep0/queues/tx-0 (queues)
> KERNEL[11368.302775] remove   "/net/bnep0 (net)
> UDEV  [11368.359215] add      "/net/bnep0 (net)
> UDEV  [11368.373121] add      "/net/bnep0/queues/rx-0 (queues)
> UDEV  [11368.381030] remove   "/net/bnep0/queues/rx-0 (queues)
> UDEV  [11368.387723] add      "/net/bnep0/queues/tx-0 (queues)
> UDEV  [11368.388807] remove   "/net/bnep0/queues/tx-0 (queues)
> UDEV  [11368.395210] remove   "/net/bnep0 (net)
> KERNEL[11370.651209] remove   " (bluetooth)
> UDEV  [11370.655569] remove   " (bluetooth)
>
>
> Using btmon is still see for BTBCM:
>
> = bluetoothd: bnep: Could not bring up bnep0: Cannot assign requested 
> address(99)
> = bluetoothd: connect failed Input/output error
>
> And for BSUSB:
>
> = bluetoothd: bnep0 connected
>
>
> Is there something wrong with the btbcm driver?
>
Solved this, thanks Andy Shevchenko.

It appears on Edison (and some other BT devices too), bd_addr is not 
stored in OTP. For instance on Edison it is stored in a partition on the 
eMMC (/factory). The bcm driver (BCM43341B0) bases the default bd_addr 
on the chip (43:34:1B:00:1F:AC), which is fine for most BT services, but 
apparently not for pan/nap. It seems like the bnep device is created and 
then immediately removed again. The only thing missing is error handling 
of this case.

Using the bdaddr tool to set the address makes connman connect to 
bluetooth service without problems. This is a little inconvenient as it 
requires restarting bluetoothd.

Is there any other, better way to set the bd_addr for bluetooth devices 
without OTP?

