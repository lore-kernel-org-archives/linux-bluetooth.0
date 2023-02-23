Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA49C61DA4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Feb 2023 14:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbjBWOOg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Feb 2023 09:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbjBWOOf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Feb 2023 09:14:35 -0500
X-Greylist: delayed 486 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Feb 2023 06:14:32 PST
Received: from mx.msync.work (unknown [185.250.0.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9F051F9B
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Feb 2023 06:14:32 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2CA7A63AEA;
        Thu, 23 Feb 2023 14:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1677161184; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         content-transfer-encoding:content-language:in-reply-to:references;
        bh=HvF7fLoYqH61AispaOiD/QsNQeppLUMvZMvgw6BUPso=;
        b=h/urx30ZifTQlTRaCuDMqYZuuGY+Gv8ADRgjwUMeLSkpsdPw/W5rKwWPzt2i3ElYjk3lCq
        itxagL8ocU0MS4PJ2slBjUu09+RtqVvY87BfTUrVWv8oDbmUt2b16Ehrffz9qjI3+YPHQK
        hrXYkpSvT9TEatqLkzUmh4d4IRUtqAruzMmQDJHM6ZGw2CnwRQen8qDBzJuP+vwDRerWUh
        gnKOjBdrOGHPnV7H+7QHzz2xvlmc6wFLyRhii3qwxnzm+UP4EoUjuIo4AZFV1Xa/XeRPyw
        FS3/c6aazJe6Ku/KCJQZV3MWUu3o6t2zHJMNz9iNSUe0vHm2pPYs6qLd+NNcTQ==
Message-ID: <e4404fcb-69f6-b4c0-7683-69101bbeaa96@lexina.in>
Date:   Thu, 23 Feb 2023 17:05:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: Bug/Problem with rtl_bt/rtl8822cs_config.bin
Content-Language: en-US, ru, ru-RU
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Max Chou <max.chou@realtek.com>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Hilda Wu <hildawu@realtek.com>,
        Josh Boyer <jwboyer@kernel.org>,
        Linux Firmware <linux-firmware@kernel.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
References: <3B9D4DB2-D2CD-44FE-817A-F6EA8A0AD734@gmail.com>
 <CAFBinCBWyiObgbyuT2Xc=FnoTTTUBu3sePpybdrocVZr7SVDWw@mail.gmail.com>
 <7df7bdcad3474791ae69f73f8a761173@realtek.com>
 <9E1F8017-3F54-416D-9BD3-DF2F1C625094@gmail.com>
From:   Vyacheslav <adeep@lexina.in>
In-Reply-To: <9E1F8017-3F54-416D-9BD3-DF2F1C625094@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org



On 23/02/2023 10.51, Christian Hewitt wrote:
> Hello Max,
> 
> The bug report stimulated Martin’s maintainer memory over unfinished improvements
> to the Amlogic UART used in the g12a and newer SoC families (we are testing with
> g12b and sm1 devices) resulting in this series being submitted last night:
> 
> https://patchwork.kernel.org/project/linux-amlogic/list/?series=724172

However, this does not fix the problem with rtl8822cs BT on gxl/axg chipsets

> 
> With those patches applied the boards support stable 1500000 baud rate and BT is
> working with the latest fw/config files from linux-firmware:
> 
> LibreELEC:/ # dmesg | grep Blue
> [    6.839950] Bluetooth: Core ver 2.22
> [    6.840128] Bluetooth: HCI device and connection manager initialized
> [    6.840419] Bluetooth: HCI socket layer initialized
> [    6.840437] Bluetooth: L2CAP socket layer initialized
> [    6.840740] Bluetooth: SCO socket layer initialized
> [    6.874518] Bluetooth: HCI UART driver ver 2.3
> [    6.874533] Bluetooth: HCI UART protocol H4 registered
> [    6.874619] Bluetooth: HCI UART protocol Three-wire (H5) registered
> [    6.874809] Bluetooth: HCI UART protocol Broadcom registered
> [    6.874842] Bluetooth: HCI UART protocol QCA registered
> [    7.636373] Bluetooth: hci0: RTL: examining hci_ver=0a hci_rev=000c lmp_ver=0a lmp_subver=8822
> [    7.639863] Bluetooth: hci0: RTL: rom_version status=0 version=3
> [    7.639959] Bluetooth: hci0: RTL: loading rtl_bt/rtl8822cs_fw.bin
> [    7.655585] Bluetooth: hci0: RTL: loading rtl_bt/rtl8822cs_config.bin
> [    7.697202] Bluetooth: hci0: RTL: cfg_sz 33, total sz 36529
> [    8.095507] Bluetooth: hci0: RTL: fw version 0xffb8abd6
> [    8.149476] Bluetooth: MGMT ver 1.22
> 
> [bluetooth]# show
> Controller 68:4E:05:F2:1E:42 (public)
> 	Name: LibreELEC
> 	Alias: LibreELEC
> 	Class: 0x000c0000
> 	Powered: yes
> 	Discoverable: no
> 	DiscoverableTimeout: 0x000000b4
> 	Pairable: yes
> 	UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb)
> 	UUID: Audio Source              (0000110a-0000-1000-8000-00805f9b34fb)
> 	UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
> 	UUID: Audio Sink                (0000110b-0000-1000-8000-00805f9b34fb)
> 	UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
> 	UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
> 	UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
> 	UUID: Device Information        (0000180a-0000-1000-8000-00805f9b34fb)
> 	Modalias: usb:v1D6Bp0246d0542
> 	Discovering: no
> 	Roles: central
> 	Roles: peripheral
> Advertising Features:
> 	ActiveInstances: 0x00 (0)
> 	SupportedInstances: 0x04 (4)
> 	SupportedIncludes: tx-power
> 	SupportedIncludes: appearance
> 	SupportedIncludes: local-name
> 	SupportedSecondaryChannels: 1M
> 	SupportedSecondaryChannels: 2M
> 	SupportedSecondaryChannels: Coded
> [bluetooth]# scan on
> Discovery started
> [CHG] Controller 68:4E:05:F2:1E:42 Discovering: yes
> [NEW] Device 4C:87:5D:89:E8:D6 4C-87-5D-89-E8-D6
> [DEL] Device 4C:87:5D:89:E8:D6 4C-87-5D-89-E8-D6
> [NEW] Device 5B:34:59:3E:EE:27 5B-34-59-3E-EE-27
> [NEW] Device 67:0D:92:0F:99:DB 67-0D-92-0F-99-DB
> [DEL] Device 5B:34:59:3E:EE:27 5B-34-59-3E-EE-27
> [DEL] Device 67:0D:92:0F:99:DB 67-0D-92-0F-99-DB
> [NEW] Device 4F:3B:07:B7:13:9D 4F-3B-07-B7-13-9D
> [NEW] Device 43:87:04:F2:86:69 43-87-04-F2-86-69
> [CHG] Device 4F:3B:07:B7:13:9D RSSI: -89
> [CHG] Device 4F:3B:07:B7:13:9D RSSI: -101
> [DEL] Device 4F:3B:07:B7:13:9D 4F-3B-07-B7-13-9D
> [DEL] Device 43:87:04:F2:86:69 43-87-04-F2-86-69
> [NEW] Device 49:17:FA:07:A1:F9 49-17-FA-07-A1-F9
> [NEW] Device 7F:7B:B2:FF:43:27 7F-7B-B2-FF-43-27
> [NEW] Device 69:0E:9F:24:06:96 69-0E-9F-24-06-96
> [NEW] Device 51:87:CE:DA:B4:41 51-87-CE-DA-B4-41
> [DEL] Device 49:17:FA:07:A1:F9 49-17-FA-07-A1-F9
> [DEL] Device 7F:7B:B2:FF:43:27 7F-7B-B2-FF-43-27
> [DEL] Device 51:87:CE:DA:B4:41 51-87-CE-DA-B4-41
> [DEL] Device 69:0E:9F:24:06:96 69-0E-9F-24-06-96
> 
> So all appears to be working now.
> 
> Thanks to all..
> 
> Christian
> 
> 
>> On 23 Feb 2023, at 7:24 am, Max Chou <max.chou@realtek.com> wrote:
>>
>> Hi! Christian,
>> I just try to test the config file as linux-firmware on one model of Chromebook.
>> It's able to initialize RTL8822CS Bluetooth controller.
>> The issue does not present as your mention on my side.
>>
>> I compare the two config files that you listed.
>> The key difference might to impact the initialization are UART baud rate and UART flow control as Martin's mention.
>> Recommend you to edit the config file to check what is the root cause for this issue on your Host.
>> Here're the three cases for the config changed, please use hexadecimal editor for the three changes. Thanks.
>>
>> 1. Based on the config file of linux-firmware, to edit UART baudrate as below.
>> Original: 1500000 baud, flow control disabled
>> 00000000  55 ab 23 87 1b 00 0c 00  10 02 80 92 04 50 c5 ea
>> 00000010  19 e1 1b fd af 5b 01 a4  0b 7a 00 01 37 d9 00 01
>> 00000020  0f
>>
>> After: 2000000 baud, flow control disabled
>> 00000000  55 ab 23 87 1b 00 0c 00  10 02 50 00 00 50 c5 ea
>>                                   ^^^^^^^^^
>> 00000010  19 e1 1b fd af 5b 01 a4  0b 7a 00 01 37 d9 00 01
>> 00000020  0f
>>
>> 2. Based on the config file of linux-firmware, to edit UART baudrate as below.
>> Original: 1500000 baud, flow control disabled
>> 00000000  55 ab 23 87 1b 00 0c 00  10 02 80 92 04 50 c5 ea
>> 00000010  19 e1 1b fd af 5b 01 a4  0b 7a 00 01 37 d9 00 01
>> 00000020  0f
>>
>> After: 1500000 baud, flow control enabled
>> 00000000  55 ab 23 87 1b 00 0c 00  10 02 80 92 04 50 c5 ea
>> 00000010  19 e1 1b fd af 5f 01 a4  0b 7a 00 01 37 d9 00 01
>>                      ^^^
>> 00000020  0f
>>
>> 3. Based on the config file of linux-firmware, to edit UART baudrate as below.
>> Original: 1500000 baud, flow control disabled
>> 00000000  55 ab 23 87 1b 00 0c 00  10 02 80 92 04 50 c5 ea
>> 00000010  19 e1 1b fd af 5b 01 a4  0b 7a 00 01 37 d9 00 01
>> 00000020  0f
>>
>> After: 2000000 baud, flow control disabled
>> 00000000  55 ab 23 87 1b 00 0c 00  10 02 50 00 00 50 c5 ea
>>                                   ^^^^^^^^^
>> 00000010  19 e1 1b fd af 5f 01 a4  0b 7a 00 01 37 d9 00 01
>>                      ^^^
>> 00000020  0f
>>
>> BRs,
>> Max
>>
>>
>>> -----Original Message-----
>>> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>> Sent: Wednesday, February 22, 2023 5:23 AM
>>> To: Christian Hewitt <christianshewitt@gmail.com>
>>> Cc: Hilda Wu <hildawu@realtek.com>; Josh Boyer <jwboyer@kernel.org>;
>>> Linux Firmware <linux-firmware@kernel.org>; Bluez mailing list
>>> <linux-bluetooth@vger.kernel.org>; Vyacheslav <adeep@lexina.in>; Max Chou
>>> <max.chou@realtek.com>
>>> Subject: Re: Bug/Problem with rtl_bt/rtl8822cs_config.bin
>>>
>>>
>>> External mail.
>>>
>>>
>>>
>>> Hi Christian,
>>>
>>> + Max Chou as the author of commit 848fc6164158 ("Bluetooth: hci_h5:
>>> btrtl: Add support for RTL8822C")
>>>
>>> On Tue, Feb 21, 2023 at 8:13 AM Christian Hewitt
>>> <christianshewitt@gmail.com> wrote:
>>> [...]
>>>> I can also use the oldest upstream firmware with the Armbian config:
>>>>
>>>> [    7.315358] Bluetooth: hci0: RTL: examining hci_ver=0a hci_rev=000c
>>> lmp_ver=0a lmp_subver=8822
>>>> [    7.318754] Bluetooth: hci0: RTL: rom_version status=0 version=3
>>>> [    7.318772] Bluetooth: hci0: RTL: loading rtl_bt/rtl8822cs_fw.bin
>>>> [    7.319680] Bluetooth: hci0: RTL: loading rtl_bt/rtl8822cs_config.bin
>>>> [    7.341340] Bluetooth: hci0: RTL: cfg_sz 73, total sz 30817
>>>> [    7.612533] Bluetooth: hci0: RTL: fw version 0x05990d54
>>>>
>>>> The config file Armbian are using [0] is sourced from an Amlogic
>>>> (Android) BSP repo shared to manufacturer Jethome (Vyacheslav on CC).
>>>> There is no obvious version info. There are newer (more recently
>>>> committed) config files available in updates to the Amlogic repo
>>>> (alongside older 0599_0D54 firmware) and all work with any upstream
>>> firmware file.
>>> I did compare the two config files and they differ in certain areas.
>>> - upstream config: 1500000 baud, flow control is disabled
>>> - Armbian config: 2000000 baud, flow control is enabled
>>>
>>> Seeing that the Armbian config works with a higher baud rate my guess is that
>>> there's some issue with flow control instead.
>>>
>>> For those who are interested, here's the raw data provided by the rtlfw tool
>>> from [0].
>>> Armbian (= working) config:
>>> Signature: 0x8723ab55
>>> Data len:  67
>>> len=16  offset=000c,{ 02 50 00 00 50 c5 ea 19 e1 1b fd af 5f 01 a4
>>> 0b },UART_CONFIG
>>> len=2   offset=01be,{ 1a 19 }
>>> len=1   offset=01bb,{ 3d }
>>> len=4   offset=01c0,{ 10 00 60 01 }
>>> len=11  offset=1000,{ 00 ff 04 5d 00 03 00 ff ff ff ff }
>>> len=11  offset=1040,{ 28 08 30 30 00 ff ff ff ff ff ff }
>>> len=1   offset=01c4,{ 02 }
>>>
>>> upstream (= non-working) config:
>>> Signature: 0x8723ab55
>>> Data len:  27
>>> len=16  offset=000c,{ 02 80 92 04 50 c5 ea 19 e1 1b fd af 5b 01 a4
>>> 0b },UART_CONFIG
>>> len=1   offset=007a,{ 37 }
>>> len=1   offset=00d9,{ 0f }
>>>
>>> The baud rate is encoded in the first four bytes and can be decoded with the
>>> help of btrtl_convert_baudrate() from Linux'
>>> drivers/bluetooth/btrtl.c
>>> Flow control is encoded as BIT(2) in data[12].
>>>
>>> I am hoping that Hilda and/or Max can provide some ideas on how to solve
>>> this issue.
>>>
>>>
>>> Best regards,
>>> Martin
>>>
>>>
>>> [0]
>>> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/tools/rtlfw.c?id=5d347
>>> b54714e0f2d750253be09b68b0c3119dd0a
>>>
>>> ------Please consider the environment before printing this e-mail.
> 
