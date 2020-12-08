Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D910C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Dec 2020 12:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1E2E23A54
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Dec 2020 12:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbgLHMU5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Dec 2020 07:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgLHMU5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Dec 2020 07:20:57 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13528C061749
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Dec 2020 04:20:11 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id q137so16688990iod.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Dec 2020 04:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jDIaSrypTTjdRvpwGm7iCmeEKGJLUkAzaVSgirFv8lA=;
        b=RaWHA/c5UlUdismaM+/mOAuZqnC7GU06hCoQIFloGOSk7R+ttzMNDq8a1Y/3IFRXt7
         vQW1NizO16Z2TE70oOMjHqRN1VezJnhmM1vrC/XadEgYMov6x0Wi6XSpddq31x83Sq++
         m04qpDezYtFccRMqKOFWgaeE4OOi3KXHvwf0So9QIgFnhQUc1XT+KEJluCF4l2v05aD/
         SSJI7T36le8P0U5ZBxOVdDXJwWBY1nr09Z+JJlJkTTTpbYMLE+0rksGwblj64sv3iqHa
         KomypRa3kA7ANSwaANYjnKAMAdI5mxUxS92Xsm+Zs5UJK6FONu9n9s4PbSNW7DKdOiWI
         U02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jDIaSrypTTjdRvpwGm7iCmeEKGJLUkAzaVSgirFv8lA=;
        b=SjVYbI63p76wgJctVcftVISXll2i/BYDayudF7Go8oKVuYo5UnnFhxe5mYoPZkU35J
         q24jnYoyedgwmpZn3AuFGuvwRWTiIooZcsyi/0P0d3QjdRmkvd2J9HAgQb0oqxYRbgWo
         UuiEM3o6cgkHCaHD9JI20clafV/NloleDFXBGuanoWhpMAdHW9KNg3U4aiPTRumiBgzx
         Vg5YkF+JlR8g2T4jnRprLiudWzqh4Kr0FidWwutP19LTkMlQYr2MTPtf2WowBSimavIn
         4Au6xGTQxJxTPH3lBALNUYr87sjV6DO8N3j0pFDB8TnYRm6PMSWnefCtvMLFwq1kdXFt
         x4RA==
X-Gm-Message-State: AOAM533VgwJidDb2S/bC9o7Wiux9kM91AX82U+1rUfXXLh+bBuxVU+wR
        EKDB7Ah1F/tiY3k1iT5hSwxQHchd/qGc9pPwUzo=
X-Google-Smtp-Source: ABdhPJzRDmFGBL/10ncwk60kwnCwMK3eZ99M5vys9Xy/dFxgor9IOqnbWXPy3OHfJdGFc5wtwFwvmtS2j0g34Xyat1Y=
X-Received: by 2002:a6b:7717:: with SMTP id n23mr5255058iom.73.1607430010281;
 Tue, 08 Dec 2020 04:20:10 -0800 (PST)
MIME-Version: 1.0
References: <CAMxp894ThdL9qxNz49561WrDj3XhWxpFMf+9afMD9WqMbSPBbw@mail.gmail.com>
 <2fb922ffced103ba09571567366968d5462f9267.camel@hadess.net>
 <CAMxp8948=LGwO6NE_oij2WgXxzXCY7nByj_XmmhPZFMiookseA@mail.gmail.com>
 <699f55a2f9d574943af0b5cc80c47d08d48953f7.camel@hadess.net>
 <CAMxp897-xWxkcBfmjdXYUt6i3jLJ5ZJ67Vs8NZ_6ukBL9v+L6Q@mail.gmail.com>
 <42a369804808a2be8012b950a7db9f6ab8f27936.camel@hadess.net>
 <CADrX+XvHL76f8mT29MO8xUGwKzhjeZTXqiSUAQnR5_JrCZ65_Q@mail.gmail.com>
 <e0087211e96b5f687401cba75e501cbffb9bf4c1.camel@hadess.net> <CADrX+Xtq=cCudHvKZG1=WdwM-vinPegXWTd-JdvpiLk4GykfbQ@mail.gmail.com>
In-Reply-To: <CADrX+Xtq=cCudHvKZG1=WdwM-vinPegXWTd-JdvpiLk4GykfbQ@mail.gmail.com>
From:   Lionel Jeanson <lionel.jeanson@gmail.com>
Date:   Tue, 8 Dec 2020 13:19:59 +0100
Message-ID: <CADrX+Xs5z7gg0XZ3HY8rxK4dvg558HfnqyViFEL1oYPJT6OAmQ@mail.gmail.com>
Subject: Re: sixaxis patch proposal
To:     Bastien Nocera <hadess@hadess.net>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

ok, restarting :

1) after connect to USB and pair :

lionel@lionelux:~$ bluetoothctl info 44:D8:32:7E:6B:6A
Device 44:D8:32:7E:6B:6A (public)
Name: Sony PLAYSTATION(R)3 Controller
Alias: Sony PLAYSTATION(R)3 Controller
Paired: no
Trusted: yes
Blocked: no
Connected: no
WakeAllowed: no
LegacyPairing: no
UUID: Human Interface Device... (00001124-0000-1000-8000-00805f9b34fb)
Modalias: usb:v054Cp0268d0000



2) disconnect USB and connect BT

lionel@lionelux:~$ bluetoothctl info 44:D8:32:7E:6B:6A
Device 44:D8:32:7E:6B:6A (public)
Name: Sony PLAYSTATION(R)3 Controller
Alias: Sony PLAYSTATION(R)3 Controller
Class: 0x00000508
Icon: input-gaming
Paired: no
Trusted: yes
Blocked: no
Connected: yes
WakeAllowed: no
LegacyPairing: no
UUID: Human Interface Device... (00001124-0000-1000-8000-00805f9b34fb)
Modalias: usb:v054Cp0268d0000


3) disconnect BT from BT Manager (no more long press on sixaxis, using
only computer BT manager)

lionel@lionelux:~$ bluetoothctl info 44:D8:32:7E:6B:6A
Device 44:D8:32:7E:6B:6A (public)
Name: Sony PLAYSTATION(R)3 Controller
Alias: Sony PLAYSTATION(R)3 Controller
Class: 0x00000508
Icon: input-gaming
Paired: no
Trusted: yes
Blocked: no
Connected: no
WakeAllowed: no
LegacyPairing: no
UUID: Human Interface Device... (00001124-0000-1000-8000-00805f9b34fb)
Modalias: usb:v054Cp0268d0000

4) connect to USB while off :

d=C3=A9c. 08 13:10:38 lionelux bluetoothd[20928]: sixaxis: compatible
device connected: Sony PLAYSTATION(R)3 Controller (054C:0268
/sys/devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.0/0003:054C:0268.001A/h=
idraw/hidraw0)
d=C3=A9c. 08 13:10:38 lionelux bluetoothd[20928]: sixaxis: setting up new d=
evice
d=C3=A9c. 08 13:10:38 lionelux bluetoothd[20928]:
src/device.c:btd_device_set_trusted() trusted 0
d=C3=A9c. 08 13:10:38 lionelux bluetoothd[20928]:
src/device.c:btd_device_set_temporary() temporary 1
d=C3=A9c. 08 13:10:38 lionelux bluetoothd[20928]:
src/adapter.c:remove_whitelist_complete() 44:D8:32:7E:6B:6A removed
from kernel whitelist
d=C3=A9c. 08 13:10:38 lionelux bluetoothd[20928]: src/agent.c:agent_ref()
0x56294fe6a950: ref=3D2
d=C3=A9c. 08 13:10:38 lionelux bluetoothd[20928]:
src/agent.c:agent_call_authorize_service() authorize service request
was sent for /org/bluez/hci0/dev_44_D8_32_7E_6B_6A

lionel@lionelux:~$ bluetoothctl info 44:D8:32:7E:6B:6A
Device 44:D8:32:7E:6B:6A (public)
Name: Sony PLAYSTATION(R)3 Controller
Alias: Sony PLAYSTATION(R)3 Controller
Class: 0x00000508
Icon: input-gaming
Paired: no
Trusted: no
Blocked: no
Connected: no
WakeAllowed: no
LegacyPairing: no
UUID: Human Interface Device... (00001124-0000-1000-8000-00805f9b34fb)
Modalias: usb:v054Cp0268d0000


5) didn't accept new service, disconnect from USB

lionel@lionelux:~$ bluetoothctl info 44:D8:32:7E:6B:6A
Device 44:D8:32:7E:6B:6A not available



4') redoing step 4) but with my proposed patch : works as expected

d=C3=A9c. 08 13:14:25 lionelux bluetoothd[22191]: sixaxis: compatible
device connected: Sony PLAYSTATION(R)3 Controller (054C:0268
/sys/devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.0/0003:054C:0268.001D/h=
idraw/hidraw0)
d=C3=A9c. 08 13:14:25 lionelux bluetoothd[22191]:
plugins/sixaxis.c:setup_device() device 44:D8:32:7E:6B:6A already
known, skipping


Le mar. 8 d=C3=A9c. 2020 =C3=A0 13:16, Lionel Jeanson <lionel.jeanson@gmail=
.com> a =C3=A9crit :
>
> ok, restarting :
>
> 1) after connect to USB and pair :
>
> lionel@lionelux:~$ bluetoothctl info 44:D8:32:7E:6B:6A
> Device 44:D8:32:7E:6B:6A (public)
> Name: Sony PLAYSTATION(R)3 Controller
> Alias: Sony PLAYSTATION(R)3 Controller
> Paired: no
> Trusted: yes
> Blocked: no
> Connected: no
> WakeAllowed: no
> LegacyPairing: no
> UUID: Human Interface Device... (00001124-0000-1000-8000-00805f9b34fb)
> Modalias: usb:v054Cp0268d0000
>
>
>
> 2) disconnect USB and connect BT
>
> lionel@lionelux:~$ bluetoothctl info 44:D8:32:7E:6B:6A
> Device 44:D8:32:7E:6B:6A (public)
> Name: Sony PLAYSTATION(R)3 Controller
> Alias: Sony PLAYSTATION(R)3 Controller
> Class: 0x00000508
> Icon: input-gaming
> Paired: no
> Trusted: yes
> Blocked: no
> Connected: yes
> WakeAllowed: no
> LegacyPairing: no
> UUID: Human Interface Device... (00001124-0000-1000-8000-00805f9b34fb)
> Modalias: usb:v054Cp0268d0000
>
>
> 3) disconnect BT from BT Manager (no more long press on sixaxis, using on=
ly computer BT manager)
>
> lionel@lionelux:~$ bluetoothctl info 44:D8:32:7E:6B:6A
> Device 44:D8:32:7E:6B:6A (public)
> Name: Sony PLAYSTATION(R)3 Controller
> Alias: Sony PLAYSTATION(R)3 Controller
> Class: 0x00000508
> Icon: input-gaming
> Paired: no
> Trusted: yes
> Blocked: no
> Connected: no
> WakeAllowed: no
> LegacyPairing: no
> UUID: Human Interface Device... (00001124-0000-1000-8000-00805f9b34fb)
> Modalias: usb:v054Cp0268d0000
>
> 4) connect to USB while off :
>
> d=C3=A9c. 08 13:10:38 lionelux bluetoothd[20928]: sixaxis: compatible dev=
ice connected: Sony PLAYSTATION(R)3 Controller (054C:0268 /sys/devices/pci0=
000:00/0000:00:14.0/usb1/1-1/1-1:1.0/0003:054C:0268.001A/hidraw/hidraw0)
> d=C3=A9c. 08 13:10:38 lionelux bluetoothd[20928]: sixaxis: setting up new=
 device
> d=C3=A9c. 08 13:10:38 lionelux bluetoothd[20928]: src/device.c:btd_device=
_set_trusted() trusted 0
> d=C3=A9c. 08 13:10:38 lionelux bluetoothd[20928]: src/device.c:btd_device=
_set_temporary() temporary 1
> d=C3=A9c. 08 13:10:38 lionelux bluetoothd[20928]: src/adapter.c:remove_wh=
itelist_complete() 44:D8:32:7E:6B:6A removed from kernel whitelist
> d=C3=A9c. 08 13:10:38 lionelux bluetoothd[20928]: src/agent.c:agent_ref()=
 0x56294fe6a950: ref=3D2
> d=C3=A9c. 08 13:10:38 lionelux bluetoothd[20928]: src/agent.c:agent_call_=
authorize_service() authorize service request was sent for /org/bluez/hci0/=
dev_44_D8_32_7E_6B_6A
>
> lionel@lionelux:~$ bluetoothctl info 44:D8:32:7E:6B:6A
> Device 44:D8:32:7E:6B:6A (public)
> Name: Sony PLAYSTATION(R)3 Controller
> Alias: Sony PLAYSTATION(R)3 Controller
> Class: 0x00000508
> Icon: input-gaming
> Paired: no
> Trusted: no
> Blocked: no
> Connected: no
> WakeAllowed: no
> LegacyPairing: no
> UUID: Human Interface Device... (00001124-0000-1000-8000-00805f9b34fb)
> Modalias: usb:v054Cp0268d0000
>
>
> 5) didn't accept new service, disconnect from USB
>
> lionel@lionelux:~$ bluetoothctl info 44:D8:32:7E:6B:6A
> Device 44:D8:32:7E:6B:6A not available
>
>
>
> 4') redoing step 4) but with my proposed patch : works as expected
>
> d=C3=A9c. 08 13:14:25 lionelux bluetoothd[22191]: sixaxis: compatible dev=
ice connected: Sony PLAYSTATION(R)3 Controller (054C:0268 /sys/devices/pci0=
000:00/0000:00:14.0/usb1/1-1/1-1:1.0/0003:054C:0268.001D/hidraw/hidraw0)
> d=C3=A9c. 08 13:14:25 lionelux bluetoothd[22191]: plugins/sixaxis.c:setup=
_device() device 44:D8:32:7E:6B:6A already known, skipping
>
>
>
>
>
> Le mar. 8 d=C3=A9c. 2020 =C3=A0 12:29, Bastien Nocera <hadess@hadess.net>=
 a =C3=A9crit :
>>
>> On Tue, 2020-12-08 at 12:21 +0100, Lionel Jeanson wrote:
>> > My bad :
>> >
>> >
>> > 1) connect and pair :
>> >
>> >
>> > d=C3=A9c. 08 12:14:44 lionelux bluetoothd[16446]: sixaxis: compatible
>> > device connected: Sony PLAYSTATION(R)3 Controller (054C:0268
>> > /sys/devices/pci0000:00/0000:00:14.0/usb1/1-1/1-
>> > 1:1.0/0003:054C:0268.0010/hidraw/hidraw0)
>> > d=C3=A9c. 08 12:14:44 lionelux bluetoothd[16446]:
>> > src/device.c:device_create() dst 44:D8:32:7E:6B:6A
>> > d=C3=A9c. 08 12:14:44 lionelux bluetoothd[16446]:
>> > src/device.c:device_new() address 44:D8:32:7E:6B:6A
>> > d=C3=A9c. 08 12:14:44 lionelux bluetoothd[16446]:
>> > src/device.c:device_new() Creating device
>> > /org/bluez/hci0/dev_44_D8_32_7E_6B_6A
>> > d=C3=A9c. 08 12:14:44 lionelux bluetoothd[16446]: sixaxis: setting up =
new
>> > device
>> > d=C3=A9c. 08 12:14:44 lionelux bluetoothd[16446]:
>> > src/device.c:btd_device_device_set_name()
>> > /org/bluez/hci0/dev_44_D8_32_7E_6B_6A Sony PLAYSTATION(R)3 Controller
>> > d=C3=A9c. 08 12:14:44 lionelux bluetoothd[16446]: src/agent.c:agent_re=
f()
>> > 0x5579c3bc4e70: ref=3D2
>> > d=C3=A9c. 08 12:14:44 lionelux bluetoothd[16446]:
>> > src/agent.c:agent_call_authorize_service() authorize service request
>> > was sent for /org/bluez/hci0/dev_44_D8_32_7E_6B_6A
>> > d=C3=A9c. 08 12:14:47 lionelux bluetoothd[16446]: src/agent.c:agent_re=
f()
>> > 0x5579c3bc4e70: ref=3D3
>> > d=C3=A9c. 08 12:14:47 lionelux bluetoothd[16446]:
>> > src/device.c:btd_device_set_trusted() trusted 1
>> > d=C3=A9c. 08 12:14:47 lionelux bluetoothd[16446]:
>> > src/device.c:btd_device_set_temporary() temporary 0
>> > d=C3=A9c. 08 12:14:47 lionelux bluetoothd[16446]:
>> > src/device.c:device_probe_profiles() Probing profiles for device
>> > 44:D8:32:7E:6B:6A
>> > d=C3=A9c. 08 12:14:47 lionelux bluetoothd[16446]:
>> > profiles/input/device.c:input_device_register()
>> > /org/bluez/hci0/dev_44_D8_32_7E_6B_6A
>> > d=C3=A9c. 08 12:14:47 lionelux bluetoothd[16446]:
>> > src/service.c:btd_service_ref() 0x5579c3bca4f0: ref=3D2
>> > d=C3=A9c. 08 12:14:47 lionelux bluetoothd[16446]:
>> > src/service.c:change_state() 0x5579c3bca4f0: device 44:D8:32:7E:6B:6A
>> > profile input-hid state changed: unavailable -> disconnected (0)
>> > d=C3=A9c. 08 12:14:47 lionelux bluetoothd[16446]:
>> > src/device.c:device_svc_resolved()
>> > /org/bluez/hci0/dev_44_D8_32_7E_6B_6A err 0
>> > d=C3=A9c. 08 12:14:47 lionelux bluetoothd[16446]:
>> > plugins/sixaxis.c:agent_auth_cb() remote 44:D8:32:7E:6B:6A old_master
>> > A4:34:D9:3F:36:93 new_master A4:34:D9:3F:36:93
>> > d=C3=A9c. 08 12:14:47 lionelux bluetoothd[16446]:
>> > src/agent.c:agent_unref() 0x5579c3bc4e70: ref=3D2
>> > d=C3=A9c. 08 12:14:47 lionelux bluetoothd[16446]:
>> > src/agent.c:agent_unref() 0x5579c3bc4e70: ref=3D1
>> > d=C3=A9c. 08 12:14:47 lionelux bluetoothd[16446]:
>> > src/adapter.c:add_whitelist_complete() 44:D8:32:7E:6B:6A added to
>> > kernel whitelist
>> > d=C3=A9c. 08 12:14:47 lionelux bluetoothd[16446]: Set device flags ret=
urn
>> > status: Unknown Command
>>
>> What's the output of:
>> bluetoothctl info for the device after this?
>>
>> Also, long-pressing the PS button on PS3 joypads will start a new one-
>> time pairing, making the device visible. I don't think that's what you
>> want to do.
>>
>> The only way to turn off the joypad is to "disconnect" from it via
>> Bluetooth, IIRC.
>>
