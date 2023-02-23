Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1121C636D7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Feb 2023 07:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbjBWHvd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Feb 2023 02:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjBWHvc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Feb 2023 02:51:32 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076664AFC2
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Feb 2023 23:51:31 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id j3so5832500wms.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Feb 2023 23:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8i2dM/eSXbY8Y+bbnuweCEYTQdo6HdYQ5SfJBqIX+M8=;
        b=DK52PdRU/IrVA3Xfxw3oTYWe+Qym/Jf/t8J3K3Tdtk6C3XfQFIBF9EZavVz8/fNKUY
         e0jEsPMM1iEbgLQWtgRd8sf4kOh5GdksjZUPl437zIn4kB1Lsxkv5giWPX3JViKdj9OJ
         tq08N0eQgeIhwIHxDxjggJZ8587Oix5XFGt1umtX50lqxJUXLqLy3ToBlasdxzyoaohj
         qbZI9u27VLhcogJV5kyrXlCxg/xrLECRVrNkbcLWKNN/uGw7GnBrOzzO/C+ICYcISbJN
         JTbPlzJxFAuUXj864tWRCZKPd5xy3pD0zH3hBldUf1ytkYtn2vTXlsCPJZpfm7QYcNIG
         H5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8i2dM/eSXbY8Y+bbnuweCEYTQdo6HdYQ5SfJBqIX+M8=;
        b=qxCT7VU/pqE1Em+KD1PTx4yhu0ni0P+2lou/ThJWf4vouG9n1Z7HLMqgeJzMYvpFeP
         XsfqDUYacc+l93JLoOa/7vqA45pZLETjswUYJlw1C/EvrKDc6x1uRJTTnhVBfYSawus4
         IwjBNU3lVjOYimKQkI8T4pnvyXTSHtgvQ3n3yls5HTBkjdy3gzuk8O6za6SdViQx1SHh
         Z4m7uZ6kFYaD3KYNz7EgxJckxSmYQXIrJxdc/sBMKE+4M5wLp8SrK+9mQZGXoRuwfcZD
         +Irt0C5Va596mrB0pBnw3ONGUbJp5nsQZGrgMRYB73E2xUKYqs30q3n8K7Hi4qpmH47T
         69vw==
X-Gm-Message-State: AO0yUKWXbi3nJ9ZELU1Vmj+Fbszk8+Vlc/v9CwGOetJwvoL/8oAqr7e8
        9BKvsAGBb0O4yygYABxikzM=
X-Google-Smtp-Source: AK7set917NpTp3TmfMdgF7I1tyd1hhJOCitke5aa1oLNwDmXSYw31eWySMPifa00naQJXOjBP6N/xQ==
X-Received: by 2002:a05:600c:998:b0:3e2:20c7:6544 with SMTP id w24-20020a05600c099800b003e220c76544mr8304065wmp.19.1677138689148;
        Wed, 22 Feb 2023 23:51:29 -0800 (PST)
Received: from smtpclient.apple ([167.99.200.149])
        by smtp.gmail.com with ESMTPSA id r189-20020a1c2bc6000000b003d9aa76dc6asm2514427wmr.0.2023.02.22.23.51.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Feb 2023 23:51:28 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: Bug/Problem with rtl_bt/rtl8822cs_config.bin
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <7df7bdcad3474791ae69f73f8a761173@realtek.com>
Date:   Thu, 23 Feb 2023 11:51:24 +0400
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Hilda Wu <hildawu@realtek.com>,
        Josh Boyer <jwboyer@kernel.org>,
        Linux Firmware <linux-firmware@kernel.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Vyacheslav <adeep@lexina.in>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9E1F8017-3F54-416D-9BD3-DF2F1C625094@gmail.com>
References: <3B9D4DB2-D2CD-44FE-817A-F6EA8A0AD734@gmail.com>
 <CAFBinCBWyiObgbyuT2Xc=FnoTTTUBu3sePpybdrocVZr7SVDWw@mail.gmail.com>
 <7df7bdcad3474791ae69f73f8a761173@realtek.com>
To:     Max Chou <max.chou@realtek.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Max,

The bug report stimulated Martin=E2=80=99s maintainer memory over =
unfinished improvements
to the Amlogic UART used in the g12a and newer SoC families (we are =
testing with
g12b and sm1 devices) resulting in this series being submitted last =
night:

https://patchwork.kernel.org/project/linux-amlogic/list/?series=3D724172

With those patches applied the boards support stable 1500000 baud rate =
and BT is
working with the latest fw/config files from linux-firmware:

LibreELEC:/ # dmesg | grep Blue
[    6.839950] Bluetooth: Core ver 2.22
[    6.840128] Bluetooth: HCI device and connection manager initialized
[    6.840419] Bluetooth: HCI socket layer initialized
[    6.840437] Bluetooth: L2CAP socket layer initialized
[    6.840740] Bluetooth: SCO socket layer initialized
[    6.874518] Bluetooth: HCI UART driver ver 2.3
[    6.874533] Bluetooth: HCI UART protocol H4 registered
[    6.874619] Bluetooth: HCI UART protocol Three-wire (H5) registered
[    6.874809] Bluetooth: HCI UART protocol Broadcom registered
[    6.874842] Bluetooth: HCI UART protocol QCA registered
[    7.636373] Bluetooth: hci0: RTL: examining hci_ver=3D0a hci_rev=3D000c=
 lmp_ver=3D0a lmp_subver=3D8822
[    7.639863] Bluetooth: hci0: RTL: rom_version status=3D0 version=3D3
[    7.639959] Bluetooth: hci0: RTL: loading rtl_bt/rtl8822cs_fw.bin
[    7.655585] Bluetooth: hci0: RTL: loading rtl_bt/rtl8822cs_config.bin
[    7.697202] Bluetooth: hci0: RTL: cfg_sz 33, total sz 36529
[    8.095507] Bluetooth: hci0: RTL: fw version 0xffb8abd6
[    8.149476] Bluetooth: MGMT ver 1.22

[bluetooth]# show
Controller 68:4E:05:F2:1E:42 (public)
	Name: LibreELEC
	Alias: LibreELEC
	Class: 0x000c0000
	Powered: yes
	Discoverable: no
	DiscoverableTimeout: 0x000000b4
	Pairable: yes
	UUID: A/V Remote Control        =
(0000110e-0000-1000-8000-00805f9b34fb)
	UUID: Audio Source              =
(0000110a-0000-1000-8000-00805f9b34fb)
	UUID: PnP Information           =
(00001200-0000-1000-8000-00805f9b34fb)
	UUID: Audio Sink                =
(0000110b-0000-1000-8000-00805f9b34fb)
	UUID: A/V Remote Control Target =
(0000110c-0000-1000-8000-00805f9b34fb)
	UUID: Generic Access Profile    =
(00001800-0000-1000-8000-00805f9b34fb)
	UUID: Generic Attribute Profile =
(00001801-0000-1000-8000-00805f9b34fb)
	UUID: Device Information        =
(0000180a-0000-1000-8000-00805f9b34fb)
	Modalias: usb:v1D6Bp0246d0542
	Discovering: no
	Roles: central
	Roles: peripheral
Advertising Features:
	ActiveInstances: 0x00 (0)
	SupportedInstances: 0x04 (4)
	SupportedIncludes: tx-power
	SupportedIncludes: appearance
	SupportedIncludes: local-name
	SupportedSecondaryChannels: 1M
	SupportedSecondaryChannels: 2M
	SupportedSecondaryChannels: Coded
[bluetooth]# scan on
Discovery started
[CHG] Controller 68:4E:05:F2:1E:42 Discovering: yes
[NEW] Device 4C:87:5D:89:E8:D6 4C-87-5D-89-E8-D6
[DEL] Device 4C:87:5D:89:E8:D6 4C-87-5D-89-E8-D6
[NEW] Device 5B:34:59:3E:EE:27 5B-34-59-3E-EE-27
[NEW] Device 67:0D:92:0F:99:DB 67-0D-92-0F-99-DB
[DEL] Device 5B:34:59:3E:EE:27 5B-34-59-3E-EE-27
[DEL] Device 67:0D:92:0F:99:DB 67-0D-92-0F-99-DB
[NEW] Device 4F:3B:07:B7:13:9D 4F-3B-07-B7-13-9D
[NEW] Device 43:87:04:F2:86:69 43-87-04-F2-86-69
[CHG] Device 4F:3B:07:B7:13:9D RSSI: -89
[CHG] Device 4F:3B:07:B7:13:9D RSSI: -101
[DEL] Device 4F:3B:07:B7:13:9D 4F-3B-07-B7-13-9D
[DEL] Device 43:87:04:F2:86:69 43-87-04-F2-86-69
[NEW] Device 49:17:FA:07:A1:F9 49-17-FA-07-A1-F9
[NEW] Device 7F:7B:B2:FF:43:27 7F-7B-B2-FF-43-27
[NEW] Device 69:0E:9F:24:06:96 69-0E-9F-24-06-96
[NEW] Device 51:87:CE:DA:B4:41 51-87-CE-DA-B4-41
[DEL] Device 49:17:FA:07:A1:F9 49-17-FA-07-A1-F9
[DEL] Device 7F:7B:B2:FF:43:27 7F-7B-B2-FF-43-27
[DEL] Device 51:87:CE:DA:B4:41 51-87-CE-DA-B4-41
[DEL] Device 69:0E:9F:24:06:96 69-0E-9F-24-06-96

So all appears to be working now.

Thanks to all..

Christian


> On 23 Feb 2023, at 7:24 am, Max Chou <max.chou@realtek.com> wrote:
>=20
> Hi! Christian,
> I just try to test the config file as linux-firmware on one model of =
Chromebook.
> It's able to initialize RTL8822CS Bluetooth controller.
> The issue does not present as your mention on my side.
>=20
> I compare the two config files that you listed.
> The key difference might to impact the initialization are UART baud =
rate and UART flow control as Martin's mention.
> Recommend you to edit the config file to check what is the root cause =
for this issue on your Host.
> Here're the three cases for the config changed, please use hexadecimal =
editor for the three changes. Thanks.
>=20
> 1. Based on the config file of linux-firmware, to edit UART baudrate =
as below.
> Original: 1500000 baud, flow control disabled
> 00000000  55 ab 23 87 1b 00 0c 00  10 02 80 92 04 50 c5 ea
> 00000010  19 e1 1b fd af 5b 01 a4  0b 7a 00 01 37 d9 00 01
> 00000020  0f
>=20
> After: 2000000 baud, flow control disabled
> 00000000  55 ab 23 87 1b 00 0c 00  10 02 50 00 00 50 c5 ea
>                                  ^^^^^^^^^
> 00000010  19 e1 1b fd af 5b 01 a4  0b 7a 00 01 37 d9 00 01
> 00000020  0f
>=20
> 2. Based on the config file of linux-firmware, to edit UART baudrate =
as below.
> Original: 1500000 baud, flow control disabled
> 00000000  55 ab 23 87 1b 00 0c 00  10 02 80 92 04 50 c5 ea
> 00000010  19 e1 1b fd af 5b 01 a4  0b 7a 00 01 37 d9 00 01
> 00000020  0f
>=20
> After: 1500000 baud, flow control enabled
> 00000000  55 ab 23 87 1b 00 0c 00  10 02 80 92 04 50 c5 ea
> 00000010  19 e1 1b fd af 5f 01 a4  0b 7a 00 01 37 d9 00 01
>                     ^^^
> 00000020  0f
>=20
> 3. Based on the config file of linux-firmware, to edit UART baudrate =
as below.
> Original: 1500000 baud, flow control disabled
> 00000000  55 ab 23 87 1b 00 0c 00  10 02 80 92 04 50 c5 ea
> 00000010  19 e1 1b fd af 5b 01 a4  0b 7a 00 01 37 d9 00 01
> 00000020  0f
>=20
> After: 2000000 baud, flow control disabled
> 00000000  55 ab 23 87 1b 00 0c 00  10 02 50 00 00 50 c5 ea
>                                  ^^^^^^^^^
> 00000010  19 e1 1b fd af 5f 01 a4  0b 7a 00 01 37 d9 00 01
>                     ^^^
> 00000020  0f
>=20
> BRs,
> Max
>=20
>=20
>> -----Original Message-----
>> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> Sent: Wednesday, February 22, 2023 5:23 AM
>> To: Christian Hewitt <christianshewitt@gmail.com>
>> Cc: Hilda Wu <hildawu@realtek.com>; Josh Boyer <jwboyer@kernel.org>;
>> Linux Firmware <linux-firmware@kernel.org>; Bluez mailing list
>> <linux-bluetooth@vger.kernel.org>; Vyacheslav <adeep@lexina.in>; Max =
Chou
>> <max.chou@realtek.com>
>> Subject: Re: Bug/Problem with rtl_bt/rtl8822cs_config.bin
>>=20
>>=20
>> External mail.
>>=20
>>=20
>>=20
>> Hi Christian,
>>=20
>> + Max Chou as the author of commit 848fc6164158 ("Bluetooth: hci_h5:
>> btrtl: Add support for RTL8822C")
>>=20
>> On Tue, Feb 21, 2023 at 8:13 AM Christian Hewitt
>> <christianshewitt@gmail.com> wrote:
>> [...]
>>> I can also use the oldest upstream firmware with the Armbian config:
>>>=20
>>> [    7.315358] Bluetooth: hci0: RTL: examining hci_ver=3D0a =
hci_rev=3D000c
>> lmp_ver=3D0a lmp_subver=3D8822
>>> [    7.318754] Bluetooth: hci0: RTL: rom_version status=3D0 =
version=3D3
>>> [    7.318772] Bluetooth: hci0: RTL: loading rtl_bt/rtl8822cs_fw.bin
>>> [    7.319680] Bluetooth: hci0: RTL: loading =
rtl_bt/rtl8822cs_config.bin
>>> [    7.341340] Bluetooth: hci0: RTL: cfg_sz 73, total sz 30817
>>> [    7.612533] Bluetooth: hci0: RTL: fw version 0x05990d54
>>>=20
>>> The config file Armbian are using [0] is sourced from an Amlogic
>>> (Android) BSP repo shared to manufacturer Jethome (Vyacheslav on =
CC).
>>> There is no obvious version info. There are newer (more recently
>>> committed) config files available in updates to the Amlogic repo
>>> (alongside older 0599_0D54 firmware) and all work with any upstream
>> firmware file.
>> I did compare the two config files and they differ in certain areas.
>> - upstream config: 1500000 baud, flow control is disabled
>> - Armbian config: 2000000 baud, flow control is enabled
>>=20
>> Seeing that the Armbian config works with a higher baud rate my guess =
is that
>> there's some issue with flow control instead.
>>=20
>> For those who are interested, here's the raw data provided by the =
rtlfw tool
>> from [0].
>> Armbian (=3D working) config:
>> Signature: 0x8723ab55
>> Data len:  67
>> len=3D16  offset=3D000c,{ 02 50 00 00 50 c5 ea 19 e1 1b fd af 5f 01 =
a4
>> 0b },UART_CONFIG
>> len=3D2   offset=3D01be,{ 1a 19 }
>> len=3D1   offset=3D01bb,{ 3d }
>> len=3D4   offset=3D01c0,{ 10 00 60 01 }
>> len=3D11  offset=3D1000,{ 00 ff 04 5d 00 03 00 ff ff ff ff }
>> len=3D11  offset=3D1040,{ 28 08 30 30 00 ff ff ff ff ff ff }
>> len=3D1   offset=3D01c4,{ 02 }
>>=20
>> upstream (=3D non-working) config:
>> Signature: 0x8723ab55
>> Data len:  27
>> len=3D16  offset=3D000c,{ 02 80 92 04 50 c5 ea 19 e1 1b fd af 5b 01 =
a4
>> 0b },UART_CONFIG
>> len=3D1   offset=3D007a,{ 37 }
>> len=3D1   offset=3D00d9,{ 0f }
>>=20
>> The baud rate is encoded in the first four bytes and can be decoded =
with the
>> help of btrtl_convert_baudrate() from Linux'
>> drivers/bluetooth/btrtl.c
>> Flow control is encoded as BIT(2) in data[12].
>>=20
>> I am hoping that Hilda and/or Max can provide some ideas on how to =
solve
>> this issue.
>>=20
>>=20
>> Best regards,
>> Martin
>>=20
>>=20
>> [0]
>> =
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/tools/rtlfw.c?id=3D=
5d347
>> b54714e0f2d750253be09b68b0c3119dd0a
>>=20
>> ------Please consider the environment before printing this e-mail.

