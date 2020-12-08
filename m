Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A931C1B0D9
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Dec 2020 11:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 615F723AA9
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Dec 2020 11:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbgLHLZ6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Dec 2020 06:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729142AbgLHLZ6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Dec 2020 06:25:58 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F49C061749
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Dec 2020 03:25:18 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id n14so16526414iom.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Dec 2020 03:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jJxVW78nwPBqtBq1qImOHhMeKnqFPsa53Uucy8hg3uc=;
        b=TOcj1lVNXIW6jG9ZfBWayDV+LVZ+BtTL7T0qooLcTYop0jKydV6Vrmt/q9ng4GqZ5e
         cb3iWNOoz5VKDNWX7rmcnm93n/ES7AlgMDNP9CSpxdm0HBHD0WX7isajb+GpevtuPTK/
         AYZ1c62KrIbCTAKeC6reNZ6Rjr0pAysvVpeKCDL/L8WLHl9BV9oXx5MUkhoRqvMSYaRa
         fr51FxBgo+dg4j0KfqQeuYyXhEUiT55F2sBVawAynpEyj1viM/s4zOmGo85KqpCsel8Z
         R8dVEMzIW10q44J29Ckp/L9zZAAwcybZbEr1w54zJoq24IHlevYWRyYPEnVhH89QYtmU
         K1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jJxVW78nwPBqtBq1qImOHhMeKnqFPsa53Uucy8hg3uc=;
        b=WVTJbk/M5Dvb/t4usYaQrjtgiUXD3Ilig3oIBAV9C63fGtmSUD9rrwPy6S8b2kKhcA
         fh+0PkR/+huf+54QxM86xs1e2sxrhp846Dw2ZcQTSAUh4LqaY+08dle6fHc4HjwsfhJF
         fJrERKmzW2lUJ3N+7mx76OHvrorCG8UHxIxxKeKIKlgdb5s3gAmLx6nM1Nm8mU26IThY
         eEAxiXBBbrdPhZrRBmHvbYfIYz/lnPUXGlv2aa4ESFdp1j5HD02Q3ZNnEBKo224DRa6Y
         Rzk44UjuygAoXnkiuZbyDTG9njjLiZP6btlRVU/YfJ7YOhCdSPspsubrUOcdm8jCC58N
         VrSQ==
X-Gm-Message-State: AOAM531T0NKlWQp/2mChh160oQSP6vpGnUmJZedgXvt4bwgLE4/XWzOP
        JQ5uMapnzrwMm2VZQ9NC6YpBuGJk08YMamr345Jqm2S3+npdUw==
X-Google-Smtp-Source: ABdhPJzykoeEZIHyEGVNjgMLDh3ZOur/Ibmi0pMBYSES680h721t3ujkTATUysgaKkpJmxQQGm9pGK8ZjlBHMriDE3o=
X-Received: by 2002:a02:aa83:: with SMTP id u3mr26207122jai.38.1607426717648;
 Tue, 08 Dec 2020 03:25:17 -0800 (PST)
MIME-Version: 1.0
References: <CAMxp894ThdL9qxNz49561WrDj3XhWxpFMf+9afMD9WqMbSPBbw@mail.gmail.com>
 <2fb922ffced103ba09571567366968d5462f9267.camel@hadess.net>
 <CAMxp8948=LGwO6NE_oij2WgXxzXCY7nByj_XmmhPZFMiookseA@mail.gmail.com>
 <699f55a2f9d574943af0b5cc80c47d08d48953f7.camel@hadess.net>
 <CAMxp897-xWxkcBfmjdXYUt6i3jLJ5ZJ67Vs8NZ_6ukBL9v+L6Q@mail.gmail.com> <42a369804808a2be8012b950a7db9f6ab8f27936.camel@hadess.net>
In-Reply-To: <42a369804808a2be8012b950a7db9f6ab8f27936.camel@hadess.net>
From:   Lionel Jeanson <lionel.jeanson@gmail.com>
Date:   Tue, 8 Dec 2020 12:25:06 +0100
Message-ID: <CADrX+Xvte7gYi3=SoWiZqhj=-S0N9-tbRqgMDdR=Z0W1yUJzyw@mail.gmail.com>
Subject: Re: sixaxis patch proposal
To:     Bastien Nocera <hadess@hadess.net>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

My bad :

1) connect and pair (OK)

d=C3=A9c. 08 12:14:44 lionelux bluetoothd[16446]: sixaxis: compatible
device connected: Sony PLAYSTATION(R)3 Controller (054C:0268
/sys/devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.0/0003:054C:0268.0010/h=
idraw/hidraw0)
d=C3=A9c. 08 12:14:44 lionelux bluetoothd[16446]:
src/device.c:device_create() dst 44:D8:32:7E:6B:6A
d=C3=A9c. 08 12:14:44 lionelux bluetoothd[16446]: src/device.c:device_new()
address 44:D8:32:7E:6B:6A
d=C3=A9c. 08 12:14:44 lionelux bluetoothd[16446]: src/device.c:device_new()
Creating device /org/bluez/hci0/dev_44_D8_32_7E_6B_6A
d=C3=A9c. 08 12:14:44 lionelux bluetoothd[16446]: sixaxis: setting up new d=
evice
d=C3=A9c. 08 12:14:44 lionelux bluetoothd[16446]:
src/device.c:btd_device_device_set_name()
/org/bluez/hci0/dev_44_D8_32_7E_6B_6A Sony PLAYSTATION(R)3 Controller
d=C3=A9c. 08 12:14:44 lionelux bluetoothd[16446]: src/agent.c:agent_ref()
0x5579c3bc4e70: ref=3D2
d=C3=A9c. 08 12:14:44 lionelux bluetoothd[16446]:
src/agent.c:agent_call_authorize_service() authorize service request
was sent for /org/bluez/hci0/dev_44_D8_32_7E_6B_6A
d=C3=A9c. 08 12:14:47 lionelux bluetoothd[16446]: src/agent.c:agent_ref()
0x5579c3bc4e70: ref=3D3
d=C3=A9c. 08 12:14:47 lionelux bluetoothd[16446]:
src/device.c:btd_device_set_trusted() trusted 1
d=C3=A9c. 08 12:14:47 lionelux bluetoothd[16446]:
src/device.c:btd_device_set_temporary() temporary 0
d=C3=A9c. 08 12:14:47 lionelux bluetoothd[16446]:
src/device.c:device_probe_profiles() Probing profiles for device
44:D8:32:7E:6B:6A
d=C3=A9c. 08 12:14:47 lionelux bluetoothd[16446]:
profiles/input/device.c:input_device_register()
/org/bluez/hci0/dev_44_D8_32_7E_6B_6A
d=C3=A9c. 08 12:14:47 lionelux bluetoothd[16446]:
src/service.c:btd_service_ref() 0x5579c3bca4f0: ref=3D2
d=C3=A9c. 08 12:14:47 lionelux bluetoothd[16446]:
src/service.c:change_state() 0x5579c3bca4f0: device 44:D8:32:7E:6B:6A
profile input-hid state changed: unavailable -> disconnected (0)
d=C3=A9c. 08 12:14:47 lionelux bluetoothd[16446]:
src/device.c:device_svc_resolved()
/org/bluez/hci0/dev_44_D8_32_7E_6B_6A err 0
d=C3=A9c. 08 12:14:47 lionelux bluetoothd[16446]:
plugins/sixaxis.c:agent_auth_cb() remote 44:D8:32:7E:6B:6A old_master
A4:34:D9:3F:36:93 new_master A4:34:D9:3F:36:93
d=C3=A9c. 08 12:14:47 lionelux bluetoothd[16446]: src/agent.c:agent_unref()
0x5579c3bc4e70: ref=3D2
d=C3=A9c. 08 12:14:47 lionelux bluetoothd[16446]: src/agent.c:agent_unref()
0x5579c3bc4e70: ref=3D1
d=C3=A9c. 08 12:14:47 lionelux bluetoothd[16446]:
src/adapter.c:add_whitelist_complete() 44:D8:32:7E:6B:6A added to
kernel whitelist
d=C3=A9c. 08 12:14:47 lionelux bluetoothd[16446]: Set device flags return
status: Unknown Command


2) disconnect and check BT connectivity (OK)

d=C3=A9c. 08 12:14:54 lionelux bluetoothd[16446]:
src/adapter.c:connected_callback() hci0 device 44:D8:32:7E:6B:6A
connected eir_len 5
d=C3=A9c. 08 12:14:54 lionelux bluetoothd[16446]:
src/device.c:device_set_class() /org/bluez/hci0/dev_44_D8_32_7E_6B_6A
0x000508
d=C3=A9c. 08 12:14:54 lionelux bluetoothd[16446]:
profiles/input/server.c:connect_event_cb() Incoming connection from
44:D8:32:7E:6B:6A on PSM 17
d=C3=A9c. 08 12:14:54 lionelux bluetoothd[16446]:
profiles/input/device.c:input_device_set_channel() idev 0x5579c3bcebc0
psm 17
d=C3=A9c. 08 12:14:54 lionelux bluetoothd[16446]:
profiles/input/server.c:confirm_event_cb()
d=C3=A9c. 08 12:14:54 lionelux bluetoothd[16446]:
profiles/input/server.c:connect_event_cb() Incoming connection from
44:D8:32:7E:6B:6A on PSM 19
d=C3=A9c. 08 12:14:54 lionelux bluetoothd[16446]:
profiles/input/device.c:input_device_set_channel() idev 0x5579c3bcebc0
psm 19
d=C3=A9c. 08 12:14:54 lionelux bluetoothd[16446]:
src/service.c:change_state() 0x5579c3bca4f0: device 44:D8:32:7E:6B:6A
profile input-hid state changed: disconnected -> connected (0)
d=C3=A9c. 08 12:14:54 lionelux bluetoothd[16446]:
src/service.c:btd_service_ref() 0x5579c3bca4f0: ref=3D3
d=C3=A9c. 08 12:14:54 lionelux bluetoothd[16446]:
plugins/policy.c:service_cb() Added input-hid reconnect 0


3) reconnect on USB while on (OK)

d=C3=A9c. 08 12:14:57 lionelux bluetoothd[16446]: sixaxis: compatible
device connected: Sony PLAYSTATION(R)3 Controller (054C:0268
/sys/devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.0/0003:054C:0268.0012/h=
idraw/hidraw4)

4) disconnect and turn off (OK)

d=C3=A9c. 08 12:15:11 lionelux bluetoothd[16446]:
profiles/input/device.c:intr_watch_cb() Device 44:D8:32:7E:6B:6A
disconnected
d=C3=A9c. 08 12:15:11 lionelux bluetoothd[16446]:
src/service.c:change_state() 0x5579c3bca4f0: device 44:D8:32:7E:6B:6A
profile input-hid state changed: connected -> disconnected (0)
d=C3=A9c. 08 12:15:11 lionelux bluetoothd[16446]:
profiles/input/device.c:input_device_enter_reconnect_mode()
path=3D/org/bluez/hci0/dev_44_D8_32_7E_6B_6A reconnect_mode=3Ddevice
d=C3=A9c. 08 12:15:11 lionelux bluetoothd[16446]:
profiles/input/device.c:ctrl_watch_cb() Device 44:D8:32:7E:6B:6A
disconnected
d=C3=A9c. 08 12:15:12 lionelux bluetoothd[16446]:
src/adapter.c:dev_disconnected() Device 44:D8:32:7E:6B:6A
disconnected, reason 3
d=C3=A9c. 08 12:15:12 lionelux bluetoothd[16446]:
src/adapter.c:adapter_remove_connection()
d=C3=A9c. 08 12:15:12 lionelux bluetoothd[16446]:
plugins/policy.c:disconnect_cb() reason 3
d=C3=A9c. 08 12:15:12 lionelux bluetoothd[16446]:
src/adapter.c:bonding_attempt_complete() hci0 bdaddr 44:D8:32:7E:6B:6A
type 0 status 0xe
d=C3=A9c. 08 12:15:12 lionelux bluetoothd[16446]:
src/device.c:device_bonding_complete() bonding (nil) status 0x0e
d=C3=A9c. 08 12:15:12 lionelux bluetoothd[16446]:
src/device.c:device_bonding_failed() status 14
d=C3=A9c. 08 12:15:12 lionelux bluetoothd[16446]: src/adapter.c:resume_disc=
overy()

5) reconnect while off (KO)

d=C3=A9c. 08 12:15:14 lionelux bluetoothd[16446]: sixaxis: compatible
device connected: Sony PLAYSTATION(R)3 Controller (054C:0268
/sys/devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.0/0003:054C:0268.0013/h=
idraw/hidraw0)
d=C3=A9c. 08 12:15:14 lionelux bluetoothd[16446]: sixaxis: setting up new d=
evice
d=C3=A9c. 08 12:15:14 lionelux bluetoothd[16446]:
src/device.c:btd_device_set_trusted() trusted 0
d=C3=A9c. 08 12:15:14 lionelux bluetoothd[16446]:
src/device.c:btd_device_set_temporary() temporary 1
d=C3=A9c. 08 12:15:14 lionelux bluetoothd[16446]:
src/adapter.c:remove_whitelist_complete() 44:D8:32:7E:6B:6A removed
from kernel whitelist
d=C3=A9c. 08 12:15:14 lionelux bluetoothd[16446]: src/agent.c:agent_ref()
0x5579c3bc4e70: ref=3D2
d=C3=A9c. 08 12:15:14 lionelux bluetoothd[16446]:
src/agent.c:agent_call_authorize_service() authorize service request
was sent for /org/bluez/hci0/dev_44_D8_32_7E_6B_6A
d=C3=A9c. 08 12:15:44 lionelux bluetoothd[16446]:
plugins/sixaxis.c:agent_auth_cb() Agent replied negatively, removing
temporary device
d=C3=A9c. 08 12:15:44 lionelux bluetoothd[16446]:
src/agent.c:send_cancel_request() Sending Cancel request to :1.174,
/org/bluez/agent
d=C3=A9c. 08 12:15:44 lionelux bluetoothd[16446]: src/agent.c:agent_unref()
0x5579c3bc4e70: ref=3D1
d=C3=A9c. 08 12:15:44 lionelux bluetoothd[16446]:
src/device.c:device_remove() Removing device
/org/bluez/hci0/dev_44_D8_32_7E_6B_6A
d=C3=A9c. 08 12:15:44 lionelux bluetoothd[16446]:
src/service.c:change_state() 0x5579c3bca4f0: device 44:D8:32:7E:6B:6A
profile input-hid state changed: disconnected -> unavailable (0)
d=C3=A9c. 08 12:15:44 lionelux bluetoothd[16446]:
src/service.c:btd_service_unref() 0x5579c3bca4f0: ref=3D2
d=C3=A9c. 08 12:15:44 lionelux bluetoothd[16446]:
profiles/input/device.c:input_device_unregister()
/org/bluez/hci0/dev_44_D8_32_7E_6B_6A
d=C3=A9c. 08 12:15:44 lionelux bluetoothd[16446]:
src/service.c:btd_service_unref() 0x5579c3bca4f0: ref=3D1
d=C3=A9c. 08 12:15:44 lionelux bluetoothd[16446]:
src/service.c:btd_service_unref() 0x5579c3bca4f0: ref=3D0
d=C3=A9c. 08 12:15:44 lionelux bluetoothd[16446]:
src/device.c:btd_device_unref() Freeing device
/org/bluez/hci0/dev_44_D8_32_7E_6B_6A
d=C3=A9c. 08 12:15:44 lionelux bluetoothd[16446]:
src/device.c:device_free() 0x5579c3bc83c0



Le mar. 8 d=C3=A9c. 2020 =C3=A0 11:59, Bastien Nocera <hadess@hadess.net> a=
 =C3=A9crit :
>
> On Tue, 2020-12-08 at 11:46 +0100, Lionel Jeanson wrote:
> > Cleaned known devices.
> > Restart bluetooth service.
> > d=C3=A9c. 08 11:36:11      Plugged sixaxis on USB, new device, pair, ye=
s.
> > Checked that it is working.
> >  d=C3=A9c. 08 11:36:47     Plugged back sixaxis on USB while on, all we=
nt
> > fine.
> > Unplugged.
> > Turned six axis off (long press on PS button).
> > d=C3=A9c. 08 11:37:03      Plugged back in USB -> Authorize service
> > etc...,
> > in bluetoothctl, didn't answer, request canceled     <--- this
> > shouldn't happen
> > Unplugged.
> > d=C3=A9c. 08 11:39:39      Tried to connect using BT, won't connect
> > (normal, it's nor paired anymore)
> >
> >
> > d=C3=A9c. 08 11:36:11 lionelux bluetoothd[8616]: sixaxis: compatible
> > device
> > connected: Sony PLAYSTATION(R)3 Controller (054C:0268
> > /sys/devices/pci0000:00/0000:00:14.0/usb1/1-1/1-
> > 1:1.0/0003:054C:0268.0005/hidraw/hidraw0)
> > d=C3=A9c. 08 11:36:11 lionelux bluetoothd[8616]: sixaxis: setting up ne=
w
> > device
> > d=C3=A9c. 08 11:36:14 lionelux bluetoothd[8616]: Set device flags retur=
n
> > status: Unknown Command
>
> Looks like you didn't enable debug, as we can't see the response from
> the sixaxis plugin. It's supposed to send either:
> "Agent replied negatively, removing temporary device"
> or:
> "remote %s old_master %s new_master %s"
>
