Return-Path: <SRS0=sF93=VF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF2DC606AF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Jul 2019 13:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC0B72086D
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Jul 2019 13:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n6V03NEG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729745AbfGHNk1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Jul 2019 09:40:27 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:33389 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728846AbfGHNk1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Jul 2019 09:40:27 -0400
Received: by mail-lf1-f51.google.com with SMTP id x3so5037145lfc.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jul 2019 06:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=paTFeQ8z3dZKxGdissMWDM2nvhmh/wBw2HCr38zmcqg=;
        b=n6V03NEG6rY/DkzvWlppHVLvZPIeuKZNqdwMHcDPiyQFdwQCRN6/bYczzFk6BWhmx2
         Kp0xe9/CZ33NlezMntp0D1uQBllw5ixWIne9/h2MPs/YE8PysOafAVI1D7S8kH+NKLvi
         CGZ5sc7LsFad97TNs3+92YiRzcMtH1nAXJj6lzhKGsjvWNOAMKqHkB/JkelzA0h/UjvE
         MIPgGXkvYoab+n/XJ+2cxB5neB7FL98aEAtj1kObeGx1iMB+aixrnLVeD7raq+2RgSAd
         7nPTeaTWAb9tCvywFmPJL6C0mx1AK/ATv22QVdxyWLoIKpvXpERjwI1lXZ/eYP1pgW1O
         zHqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=paTFeQ8z3dZKxGdissMWDM2nvhmh/wBw2HCr38zmcqg=;
        b=oXr9LevO+td8InNM+m1LG8oDP9DFuaWYKvJ3HCzVjfDBSzvY5Bjt/RPI5AVH96NY65
         CFAn+y29SwtBK6E2kfMZ6D9yocW8dwiFWVwTqJGn9gASvOMbWef/3pQdZVzFwMd12Emc
         nRfBRvGOK5p2ibUwBAb9ApuuZyHiYcadZUgN0V58AxDSbveF6JZd8yBLJu7WhG3phSBy
         4pz5nPuzx7+FXvzQlcfkZiUHQwwBP+lszsz88dYARXug5ukj97u2/2S6u2xdAWYnRTUs
         9VOPLUcKSjfnV0asfUTHyX+F0KDGLZB+0PkgwcBeE40gYNfi8E5ODD0ai6W54T78mBTX
         MsTA==
X-Gm-Message-State: APjAAAUfgZsRpJMCIE8VFhf89u5yHGiMCBEycd0FE9lvCP1XugwHtoRz
        opSF5UvM2c5IWxEn45dZgA0=
X-Google-Smtp-Source: APXvYqzyTOjNuIk+HRUZog6Z+FR8VqNNH25iV3bEurF4ThtXXtcw3te8YmmtHTkp8hrq7U+cCNpg2Q==
X-Received: by 2002:a19:c887:: with SMTP id y129mr8834547lff.73.1562593224200;
        Mon, 08 Jul 2019 06:40:24 -0700 (PDT)
Received: from elitebook.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id h1sm2371239lfj.21.2019.07.08.06.40.22
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 06:40:23 -0700 (PDT)
Subject: Re: bluetoothctl: list-attributes doesn't list services from
 example-gatt-server
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <c6e32190-c23d-2311-10f0-b5dcd58784bf@gmail.com>
 <CABBYNZLyutV_DWGfu3OKn0UKaC+VUwpTJej477WP92WQcrPbRA@mail.gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Message-ID: <8bd77610-8baf-66f6-9389-3130dc4213da@gmail.com>
Date:   Mon, 8 Jul 2019 15:40:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <CABBYNZLyutV_DWGfu3OKn0UKaC+VUwpTJej477WP92WQcrPbRA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 08.07.2019 15:19, Luiz Augusto von Dentz wrote:
> On Sun, Jul 7, 2019 at 2:53 PM Rafał Miłecki <zajec5@gmail.com> wrote:
>>
>> Hi,
>>
>> I have 2 notebooks with Bluetooth running bluez 5.30. I called them:
>> 1) "elitebook" with controller 20:16:B9:D8:A9:3B
>> 2) "matebook" with controller 38:BA:F8:3F:7C:A7
>>
>> Normally, when I check elitebook from matebook I get this:
>>
>> [elitebook]# info 20:16:B9:D8:A9:3B
>> Device 20:16:B9:D8:A9:3B (public)
>>           Name: elitebook
>>           Alias: elitebook
>>           Class: 0x001c010c
>>           Icon: computer
>>           Paired: yes
>>           Trusted: yes
>>           Blocked: no
>>           Connected: yes
>>           LegacyPairing: no
>>           UUID: IrMC Sync                 (00001104-0000-1000-8000-00805f9b34fb)
>>           UUID: OBEX Object Push          (00001105-0000-1000-8000-00805f9b34fb)
>>           UUID: OBEX File Transfer        (00001106-0000-1000-8000-00805f9b34fb)
>>           UUID: Headset                   (00001108-0000-1000-8000-00805f9b34fb)
>>           UUID: Audio Source              (0000110a-0000-1000-8000-00805f9b34fb)
>>           UUID: Audio Sink                (0000110b-0000-1000-8000-00805f9b34fb)
>>           UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
>>           UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb)
>>           UUID: Headset AG                (00001112-0000-1000-8000-00805f9b34fb)
>>           UUID: Phonebook Access Server   (0000112f-0000-1000-8000-00805f9b34fb)
>>           UUID: Message Access Server     (00001132-0000-1000-8000-00805f9b34fb)
>>           UUID: Message Notification Se.. (00001133-0000-1000-8000-00805f9b34fb)
>>           UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
>>           UUID: Vendor specific           (00005005-0000-1000-8000-0002ee000001)
>>           Modalias: usb:v1D6Bp0246d0532
>>
>> I decided to test GATT. On elitebook I started:
>> ./test/example-gatt-server
>> and waited to let matebook refresh all info.
>>
>> After that I got:
>>
>> [elitebook]# info 20:16:B9:D8:A9:3B
>> Device 20:16:B9:D8:A9:3B (public)
>>           Name: elitebook
>>           Alias: elitebook
>>           Class: 0x001c010c
>>           Icon: computer
>>           Paired: yes
>>           Trusted: yes
>>           Blocked: no
>>           Connected: yes
>>           LegacyPairing: no
>>           UUID: IrMC Sync                 (00001104-0000-1000-8000-00805f9b34fb)
>>           UUID: OBEX Object Push          (00001105-0000-1000-8000-00805f9b34fb)
>>           UUID: OBEX File Transfer        (00001106-0000-1000-8000-00805f9b34fb)
>>           UUID: Headset                   (00001108-0000-1000-8000-00805f9b34fb)
>>           UUID: Audio Source              (0000110a-0000-1000-8000-00805f9b34fb)
>>           UUID: Audio Sink                (0000110b-0000-1000-8000-00805f9b34fb)
>>           UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
>>           UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb)
>>           UUID: Headset AG                (00001112-0000-1000-8000-00805f9b34fb)
>>           UUID: Phonebook Access Server   (0000112f-0000-1000-8000-00805f9b34fb)
>>           UUID: Message Access Server     (00001132-0000-1000-8000-00805f9b34fb)
>>           UUID: Message Notification Se.. (00001133-0000-1000-8000-00805f9b34fb)
>>           UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
>>           UUID: Heart Rate                (0000180d-0000-1000-8000-00805f9b34fb)
>>           UUID: Battery Service           (0000180f-0000-1000-8000-00805f9b34fb)
>>           UUID: Vendor specific           (00005005-0000-1000-8000-0002ee000001)
>>           UUID: Vendor specific           (12345678-1234-5678-1234-56789abcdef0)
>>           Modalias: usb:v1D6Bp0246d0532
>>
>> That seems all correct for now. Test example-gatt-server registers
>> Heart Rate, Battery & Test services. All of them appeared as expected.
>>
>> My problem is that I can't list GATT attributes. I don't any output.
>> Is there anything I'm doing incorrectly?
>>
>> [elitebook]# menu gatt
>> Menu gatt:
>> Available commands:
>> -------------------
>> list-attributes [dev]                             List attributes
>> select-attribute <attribute/UUID>                 Select attribute
>> attribute-info [attribute/UUID]                   Select attribute
>> read [offset]                                     Read attribute value
>> write <data=xx xx ...> [offset]                   Write attribute value
>> acquire-write                                     Acquire Write file descriptor
>> release-write                                     Release Write file descriptor
>> acquire-notify                                    Acquire Notify file descriptor
>> release-notify                                    Release Notify file descriptor
>> notify <on/off>                                   Notify attribute value
>> register-application [UUID ...]                   Register profile to connect
>> unregister-application                            Unregister profile
>> register-service <UUID>                           Register application service.
>> unregister-service <UUID/object>                  Unregister application service
>> register-includes <UUID>                          Register as Included service in.
>> unregister-includes <Service-UUID><Inc-UUID>      Unregister Included service.
>> register-characteristic <UUID> <Flags=read,write,notify...>  Register application characteristic
>> unregister-characteristic <UUID/object>           Unregister application characteristic
>> register-descriptor <UUID> <Flags=read,write...>  Register application descriptor
>> unregister-descriptor <UUID/object>               Unregister application descriptor
>> back                                              Return to main menu
>> version                                           Display version
>> quit                                              Quit program
>> exit                                              Quit program
>> help                                              Display help about this program
>> export                                            Print evironment variables
>> [elitebook]# list-attributes
>> [elitebook]# list-attributes 20:16:B9:D8:A9:3B
> 
> I guess what you are looking for is list-attributes local though that
> only works for service register by bluetoothctl itself not by other
> applications, those objects are normally accessible to bluetoothd only
> and we don't expose objects from other application.

I'm confused now. I thought I understand the purpose of "menu gatt" +
"list-attributes". I'm not BlueZ expert but it seems to me to be well
capable of accessing GATT of remote devices.

When I connect my Logitech M590 BLE mouse I can use "menu gatt" +
"list-attributes" to access its GATT.

Why accessing GATT of another notebook would be any different? I'm not
sure what I'm missing.

There is an example of me using "bluetoothctl" to access GATT of M590:

[M585/M590]# menu gatt
Menu gatt:
Available commands:
-------------------
list-attributes [dev]                             List attributes
select-attribute <attribute/UUID>                 Select attribute
attribute-info [attribute/UUID]                   Select attribute
read [offset]                                     Read attribute value
write <data=xx xx ...> [offset]                   Write attribute value
acquire-write                                     Acquire Write file descriptor
release-write                                     Release Write file descriptor
acquire-notify                                    Acquire Notify file descriptor
release-notify                                    Release Notify file descriptor
notify <on/off>                                   Notify attribute value
register-application [UUID ...]                   Register profile to connect
unregister-application                            Unregister profile
register-service <UUID>                           Register application service.
unregister-service <UUID/object>                  Unregister application service
register-includes <UUID>                          Register as Included service in.
unregister-includes <Service-UUID><Inc-UUID>      Unregister Included service.
register-characteristic <UUID> <Flags=read,write,notify...>  Register application characteristic
unregister-characteristic <UUID/object>           Unregister application characteristic
register-descriptor <UUID> <Flags=read,write...>  Register application descriptor
unregister-descriptor <UUID/object>               Unregister application descriptor
back                                              Return to main menu
version                                           Display version
quit                                              Quit program
exit                                              Quit program
help                                              Display help about this program
export                                            Print evironment variables

[M585/M590]# list-attributes
Primary Service
         /org/bluez/hci0/dev_FB_F2_B0_6D_C1_6C/service0008
         00001801-0000-1000-8000-00805f9b34fb
         Generic Attribute Profile
Characteristic
         /org/bluez/hci0/dev_FB_F2_B0_6D_C1_6C/service0008/char0009
         00002a05-0000-1000-8000-00805f9b34fb
         Service Changed
Descriptor
         /org/bluez/hci0/dev_FB_F2_B0_6D_C1_6C/service0008/char0009/desc000b
         00002902-0000-1000-8000-00805f9b34fb
         Client Characteristic Configuration
Primary Service
         /org/bluez/hci0/dev_FB_F2_B0_6D_C1_6C/service000c
         0000180a-0000-1000-8000-00805f9b34fb
         Device Information
Characteristic
         /org/bluez/hci0/dev_FB_F2_B0_6D_C1_6C/service000c/char000d
         00002a29-0000-1000-8000-00805f9b34fb
         Manufacturer Name String
Characteristic
         /org/bluez/hci0/dev_FB_F2_B0_6D_C1_6C/service000c/char000f
         00002a24-0000-1000-8000-00805f9b34fb
         Model Number String
Characteristic
         /org/bluez/hci0/dev_FB_F2_B0_6D_C1_6C/service000c/char0011
         00002a25-0000-1000-8000-00805f9b34fb
         Serial Number String
Characteristic
         /org/bluez/hci0/dev_FB_F2_B0_6D_C1_6C/service000c/char0013
         00002a27-0000-1000-8000-00805f9b34fb
         Hardware Revision String
Characteristic
         /org/bluez/hci0/dev_FB_F2_B0_6D_C1_6C/service000c/char0015
         00002a26-0000-1000-8000-00805f9b34fb
         Firmware Revision String
Characteristic
         /org/bluez/hci0/dev_FB_F2_B0_6D_C1_6C/service000c/char0017
         00002a28-0000-1000-8000-00805f9b34fb
         Software Revision String
Characteristic
         /org/bluez/hci0/dev_FB_F2_B0_6D_C1_6C/service000c/char0019
         00002a50-0000-1000-8000-00805f9b34fb
         PnP ID
Primary Service
         /org/bluez/hci0/dev_FB_F2_B0_6D_C1_6C/service003e
         00010000-0000-1000-8000-011f2000046d
         Vendor specific
Characteristic
         /org/bluez/hci0/dev_FB_F2_B0_6D_C1_6C/service003e/char003f
         00010001-0000-1000-8000-011f2000046d
         Vendor specific
Descriptor
         /org/bluez/hci0/dev_FB_F2_B0_6D_C1_6C/service003e/char003f/desc0041
         00002902-0000-1000-8000-00805f9b34fb
         Client Characteristic Configuration

[M585/M590:/service000c/char0019]# select-attribute /org/bluez/hci0/dev_FB_F2_B0_6D_C1_6C/service000c/char0015

[M585/M590:/service000c/char0015]# read
Attempting to read /org/bluez/hci0/dev_FB_F2_B0_6D_C1_6C/service000c/char0015
[CHG] Attribute /org/bluez/hci0/dev_FB_F2_B0_6D_C1_6C/service000c/char0015 Value:
   4d 50 4d 30 35 2e 30 31 5f 30 30 30 36           MPM05.01_0006
   4d 50 4d 30 35 2e 30 31 5f 30 30 30 36           MPM05.01_0006
