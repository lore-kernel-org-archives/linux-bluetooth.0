Return-Path: <SRS0=q/Kg=T6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4570C072B1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 May 2019 07:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B3824CF2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 May 2019 07:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nk8rJ6c5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbfE3HNJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 May 2019 03:13:09 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:41587 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfE3HNJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 May 2019 03:13:09 -0400
Received: by mail-wr1-f52.google.com with SMTP id c2so3385326wrm.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 May 2019 00:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=MKjVGyabzuki/BqIiR1UgYwtSFFY5Gg2HPwlD42IOPI=;
        b=Nk8rJ6c51Zuj9m5JksAZDLlMh+l3WFF5YkjQd0cJdLkEUjfS7jO/8pI1PtfBdI2xiQ
         yDqZ2cQd1FC3+Wom9GZSj2hHRd9LhWdbjlA4k30DPCiCwB5FI1fijPdRx4+NdROwcr0s
         Fl4iNSCR+ZPs2aMMfMcLOMW4bVKiRU/KURF6Jpu0Oy/3En4yZN1H/dJXpbEFgRVEt+b3
         NHwCsdS9NlnMM4xoRtlNTYv/qOB9n0xAAQhP2C09u0AFmG8LvgkkXXeQLVA+VAL12lXn
         ZwrfDrJzlhyz73kNEZTUsosWAe2S2jy1y5+TZ0ss6sSTPTj2dm0EbumRM046aLWiWM7o
         ndvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=MKjVGyabzuki/BqIiR1UgYwtSFFY5Gg2HPwlD42IOPI=;
        b=mVJ0i+Oq2pq33LrsJYSSUVXEN/nujwKU0jslHVG0Q0KGGI5XbcIB16V3X2o7I6vvSw
         M+NO9RN3M9eIPR5U2k7Bsepmoj3mTFwNqidkYZbwNpFSsKBqU4Li7hr/HQDmuLanKdOP
         o6VKUkzG4ZWMWA3YZy2xTs452NmNboYfTd2aYJDzQwmz5cdeWka7fdywFRe5tJxsx23e
         nzPUjh6vU7RWQ/gMswJzzyL5gIzt8iIiiJE44cs2+IYvGFbj4v1GjtUC0N5Co1kDuBCa
         5ZPhanHpW3C0DGevb3AuJD0ycfpphqBM0XKEi0DFGnefdVZegRDgVlPvGdZi90IJ1ilP
         YTOw==
X-Gm-Message-State: APjAAAX88mYM+6daeq5sieUEKhac2TuaG2HValIUFGQbAyaHehgC9rQ9
        mHlYRi6Ba88SDoPXDdWEX/6R8hzGThw=
X-Google-Smtp-Source: APXvYqzc+cGUi8rGrvJzjG7xMJYHf8/T7PyfODO9yr/G9jHg3xtrUhPtpn9ZKulfqb0bhUwiiXnzAg==
X-Received: by 2002:adf:f38a:: with SMTP id m10mr1457726wro.81.1559200386422;
        Thu, 30 May 2019 00:13:06 -0700 (PDT)
Received: from [192.168.1.10] (93-34-147-76.ip50.fastwebnet.it. [93.34.147.76])
        by smtp.gmail.com with ESMTPSA id a2sm4212597wrg.69.2019.05.30.00.13.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 00:13:05 -0700 (PDT)
Subject: Re: Problems with bluez
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <f61b05a1-3e87-d09e-6892-ac1999dc6abd@gmail.com>
 <CABBYNZL8JopSfd4AYyYHLAHLzaSNuGPmHbMSOF9wbeNo_QwOLg@mail.gmail.com>
 <1a6318a2-1aef-a322-fe7e-d40848424f19@gmail.com>
 <CABBYNZ+WGZuOV1_m8ShopNrh24x_EpkbjCjEMjGKrfr3fw0WPA@mail.gmail.com>
From:   Matteo Formigli <matteo.formigli@gmail.com>
Message-ID: <06ca0e35-0940-707a-9f32-485d482cfdc9@gmail.com>
Date:   Thu, 30 May 2019 09:13:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+WGZuOV1_m8ShopNrh24x_EpkbjCjEMjGKrfr3fw0WPA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi!

As I promised the following is the output of the sudo btmon -t:


Bluetooth monitor ver 5.37
= New Index: 2C:33:7A:F2:01:56 (BR/EDR,USB,hci0)         [hci0] 
09:05:50.702817
= Open Index: 2C:33:7A:F2:01:56                          [hci0] 
09:05:50.702817
= Index Info: 2C:33:7A:F2:01:56 (Broadcom Corporation)   [hci0] 
09:05:50.702817
< HCI Command: Create Connection (0x01|0x0005) plen 13   [hci0] 
09:07:08.192394
         Address: CD:AF:51:0C:34:BF (OUI CD-AF-51)
         Packet type: 0xcc18
           DM1 may be used
           DH1 may be used
           DM3 may be used
           DH3 may be used
           DM5 may be used
           DH5 may be used
         Page scan repetition mode: R2 (0x02)
         Page scan mode: Mandatory (0x00)
         Clock offset: 0x0000
         Role switch: Allow slave (0x01)
 > HCI Event: Command Status (0x0f) plen 4                [hci0] 
09:07:08.193165
       Create Connection (0x01|0x0005) ncmd 1
         Status: Success (0x00)
 > HCI Event: Connect Complete (0x03) plen 11             [hci0] 
09:07:38.841272
         Status: LMP Response Timeout / LL Response Timeout (0x22)
         Handle: 12
         Address: CD:AF:51:0C:34:BF (OUI CD-AF-51)
         Link type: ACL (0x01)
         Encryption: Disabled (0x00)
@ Connect Failed: CD:AF:51:0C:34:BF (0) status 0x08
< HCI Command: LE Set Random Add.. (0x08|0x0005) plen 6  [hci0] 
09:08:08.321207
         Address: 17:0A:49:B4:38:4A (Non-Resolvable)
 > HCI Event: Command Complete (0x0e) plen 4              [hci0] 
09:08:08.322317
       LE Set Random Address (0x08|0x0005) ncmd 1
         Status: Success (0x00)
< HCI Command: LE Set Scan Param.. (0x08|0x000b) plen 7  [hci0] 
09:08:08.322367
         Type: Active (0x01)
         Interval: 11.250 msec (0x0012)
         Window: 11.250 msec (0x0012)
         Own address type: Random (0x01)
         Filter policy: Accept all advertisement (0x00)
 > HCI Event: Command Complete (0x0e) plen 4              [hci0] 
09:08:08.323311
       LE Set Scan Parameters (0x08|0x000b) ncmd 1
         Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2   [hci0] 
09:08:08.323344
         Scanning: Enabled (0x01)
         Filter duplicates: Enabled (0x01)
 > HCI Event: Command Complete (0x0e) plen 4              [hci0] 
09:08:08.324311
       LE Set Scan Enable (0x08|0x000c) ncmd 1
         Status: Success (0x00)
@ Discovering: 0x01 (7)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2   [hci0] 
09:08:13.460023
         Scanning: Disabled (0x00)
         Filter duplicates: Disabled (0x00)
 > HCI Event: Command Complete (0x0e) plen 4              [hci0] 
09:08:13.462277
       LE Set Scan Enable (0x08|0x000c) ncmd 1
         Status: Success (0x00)
< HCI Command: Inquiry (0x01|0x0001) plen 5              [hci0] 
09:08:13.462302
         Access code: 0x9e8b33 (General Inquiry)
         Length: 5.12s (0x04)
         Num responses: 0
 > HCI Event: Command Status (0x0f) plen 4                [hci0] 
09:08:13.468275
       Inquiry (0x01|0x0001) ncmd 1
         Status: Success (0x00)
 > HCI Event: Inquiry Complete (0x01) plen 1              [hci0] 
09:08:18.591332
         Status: Success (0x00)
@ Discovering: 0x00 (7)
< HCI Command: LE Set Random Add.. (0x08|0x0005) plen 6  [hci0] 
09:08:24.326331
         Address: 3C:0B:A7:7E:04:DA (Non-Resolvable)
 > HCI Event: Command Complete (0x0e) plen 4              [hci0] 
09:08:24.327311
       LE Set Random Address (0x08|0x0005) ncmd 1
         Status: Success (0x00)
< HCI Command: LE Set Scan Param.. (0x08|0x000b) plen 7  [hci0] 
09:08:24.327329
         Type: Active (0x01)
         Interval: 11.250 msec (0x0012)
         Window: 11.250 msec (0x0012)
         Own address type: Random (0x01)
         Filter policy: Accept all advertisement (0x00)
 > HCI Event: Command Complete (0x0e) plen 4              [hci0] 
09:08:24.328350
       LE Set Scan Parameters (0x08|0x000b) ncmd 1
         Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2   [hci0] 
09:08:24.328381
         Scanning: Enabled (0x01)
         Filter duplicates: Enabled (0x01)
 > HCI Event: Command Complete (0x0e) plen 4              [hci0] 
09:08:24.329293
       LE Set Scan Enable (0x08|0x000c) ncmd 1
         Status: Success (0x00)
@ Discovering: 0x01 (7)


Thanks in advance,

Matteo

Il 29/05/19 14:22, Luiz Augusto von Dentz ha scritto:
> Hi Matteo,
>
> On Tue, May 28, 2019 at 11:10 PM Matteo Formigli
> <matteo.formigli@gmail.com> wrote:
>> Hi Luiz!
>>
>> First, thanks for your answer! For now I can't upgrade my ubuntu, but I
>> already tried to upgrade bluez launching classic shell commands such as
>> apt-get update, upgrade and dist-upgrade. But bluez remains at version
>> 5.37. I have to tell you that I tried to uninstall bluez and than
>> reinstall it. It was a gamble and maybe it went wrong, but I'm not sure.
>>
>> About the logs and the HCI traces I don't have knowledge to provide you
>> what you want on my own. Can you tell me what commands i have to put in
>> the terminal?
> 5.37 is quite old so there is a high risk there something new, like
> LE/GATT connection, that happens to be unstable at that point. You can
> use btmon to collect the the HCI traces:
>
>> sudo btmon -t
> You can also check the daemon logs with:
>
>> sudo journalctl --unit=bluetooth.service
>> Thanks in advance for your help!
>>
>> Matteo
>>
>> Il 28/05/19 20:54, Luiz Augusto von Dentz ha scritto:
>>> Hi Matteo,
>>>
>>> On Tue, May 28, 2019 at 9:38 PM Matteo Formigli
>>> <matteo.formigli@gmail.com> wrote:
>>>> Hi all!
>>>>
>>>>
>>>> I am using Ubuntu 16.04 and there is no way to make the bluetooth work.
>>>> Every time I try to pair to my bluetooth headset bluez crashes. I really
>>>> don't know where to start solving this problem and I really hope that
>>>> someone on this list can help me.
>>> Maybe it would help if you update your version of BlueZ, or better yet
>>> update your ubuntu, if that still doesn't work then we may have a look
>>> at some logs and HCI traces.
>>>
>>>> Thanks in advance for your help!
>>>>
>>>> Matteo
>>>>
>>>> P.s. The following is the output of the dpkg --status of the bluez packgage
>>>>
>>>> :~$ dpkg --status bluez
>>>> Package: bluez
>>>> Status: install ok installed
>>>> Priority: optional
>>>> Section: admin
>>>> Installed-Size: 4119
>>>> Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
>>>> Architecture: amd64
>>>> Multi-Arch: foreign
>>>> Version: 5.37-0ubuntu5.1
>>>> Replaces: bluez-alsa, bluez-audio (<= 3.36-3), bluez-input,
>>>> bluez-network, bluez-serial, bluez-utils (<= 3.36-3), udev (<< 170-1)
>>>> Depends: libc6 (>= 2.15), libdbus-1-3 (>= 1.9.14), libglib2.0-0 (>=
>>>> 2.31.8), libreadline6 (>= 6.0), libudev1 (>= 196), init-system-helpers
>>>> (>= 1.18~), lsb-base (>= 4.1+Debian11ubuntu7), kmod, udev (>= 170-1), dbus
>>>> Breaks: udev (<< 170-1)
>>>> Conflicts: bluez-alsa, bluez-audio (<= 3.36-3), bluez-utils (<= 3.36-3)
>>>> Conffiles:
>>>>     /etc/bluetooth/input.conf
>>>>     /etc/bluetooth/main.conf
>>>>     /etc/bluetooth/network.conf
>>>>     /etc/bluetooth/proximity.conf
>>>>     /etc/dbus-1/system.d/bluetooth.conf
>>>>     /etc/init.d/bluetooth
>>>>     /etc/init/bluetooth.conf
>>>> Description: Bluetooth tools and daemons
>>>>     This package contains tools and system daemons for using Bluetooth
>>>> devices.
>>>>     .
>>>>     BlueZ is the official Linux Bluetooth protocol stack. It is an Open
>>>> Source
>>>>     project distributed under GNU General Public License (GPL).
>>>> Homepage: http://www.bluez.org
>>>> Original-Maintainer: Debian Bluetooth Maintainers
>>>> <pkg-bluetooth-maintainers@lists.alioth.deb
>>>>
>
>
