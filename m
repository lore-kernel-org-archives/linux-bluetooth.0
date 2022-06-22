Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD049C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jun 2022 20:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377110AbiFVUIP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Jun 2022 16:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377053AbiFVUIL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Jun 2022 16:08:11 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474E92FE7B
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jun 2022 13:08:09 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id g4so17247808lfv.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jun 2022 13:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZMTRNKyoIFjrGLh5LZl280W6Caedspq3IyF/8bZep8w=;
        b=HP68uulhGEjF1++TYNaHFVg/8H+d4aDqf+Oeruyx7lrE35bvzjW63sYatJNOdLb5Ss
         7xmCLxvINg8b01A3n1v0iMnO2ZVMEZEAvmE8qouUEWxTur84cS2RgQuNAFFzd2ZyjneM
         uW7hzSjQdFtRpHGoxZ08zstgHsej8ZUEv//N7ufoC/iEtuccvxKf5WuS4vS+ObTA3qzX
         CqgLb4I/wCXuzQk3gDb/Sy9FdQ9mw1oUIvLmP3nlkmE6Pt9WJN8zhtIxV4i8QPbEjxB2
         rh+UOzR34EuQLPHu1jBmx8XWS6agRFDjVZnWRj6Ua1Gp/WOVcfpVdZ54MWUiii1Go/AY
         FY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZMTRNKyoIFjrGLh5LZl280W6Caedspq3IyF/8bZep8w=;
        b=Cw28/yA9a1paNDirtc67BCmu+UFPvQj4P4L10JW6UwioouCIuFv31my9lTZpXJ6Smq
         utnefD677ceUZAWtJ6jmxudMJEM2Cnvq2Q6o7i4EB0gznZNwkLG+z08MZqBo5TsXvCvS
         yX1PhUn7oJxTf1nmbjY+lkBNXSeGWpDAfzTc2LoK7+WIk2O6zkfKJOWt4/1bBWWYeViC
         1CyBV2sdp5gsoiivtJFLujAIpL8DvGZ8/tZ6zDqWwEY8jtNZJS0HwdetObgoxh1R1AOr
         fY9+0L1s4DITgcy2OWpxNXJ6I6NVLiuBZfVI7cvwvo05JhOxZendEaYF0Yy0lPAqEHxw
         AxjA==
X-Gm-Message-State: AJIora9OlObU91x/hMaRfLLst7tfaUcHr0qxdjzQyXKR5KarmC28NiB6
        HlbVDSuBM8aJh+/lmY6muB2l3ZULZGN0531pqFaQJHwg59N4/g==
X-Google-Smtp-Source: AGRyM1tN+mhXQAtAGs3mebaIRn2W4chLs7tTT+4Nb8Mb/kE69GYhyVUVXYKF611Gw+2LndwKXxuHvxIJU5QgBz8SY2A=
X-Received: by 2002:a05:6512:11c8:b0:47f:9e6d:6050 with SMTP id
 h8-20020a05651211c800b0047f9e6d6050mr1818162lfr.251.1655928487381; Wed, 22
 Jun 2022 13:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220621134818.11515-1-wangyouwan@uniontech.com>
 <CABBYNZ+dnTPvOSzPEPNFJQqBaFF9+F5jfhFj9gUf5sAA06kEGQ@mail.gmail.com> <tencent_6B5C18C2035497666D06DB0C@qq.com>
In-Reply-To: <tencent_6B5C18C2035497666D06DB0C@qq.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 22 Jun 2022 13:07:55 -0700
Message-ID: <CABBYNZLWV9kxEQ50cwmEK5Mpp=LhX8+7Ywmj22K3EBHq6CduxQ@mail.gmail.com>
Subject: Re: [PATCH] device: Fix timeout=1 to remove the device immediately
To:     =?UTF-8?B?546L5pyJ5LiH?= <wangyouwan@uniontech.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Tue, Jun 21, 2022 at 6:38 PM =E7=8E=8B=E6=9C=89=E4=B8=87 <wangyouwan@uni=
ontech.com> wrote:
>
> thank you!
> This modification is consistent with my code
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=3D5ebc2b5a3=
e48dbe67a2d315979b096a1b4d1eb99
>
> Here are my steps, I found that it takes two times to remove the connecte=
d device
> When removing for the first time btd_adapter_remove_device(dev->adapter, =
dev) func will not be called
>
> [bluetooth]# connect 40:EF:4C:0C:11:F0
> Attempting to connect to 40:EF:4C:0C:11:F0
> [CHG] Device 40:EF:4C:0C:11:F0 Connected: yes
> Connection successful
> [CHG] Device 40:EF:4C:0C:11:F0 ServicesResolved: yes
> [UFO]# remove 40:EF:4C:0C:11:F0
> [CHG] Device 40:EF:4C:0C:11:F0 ServicesResolved: no
> Device has been removed
> [CHG] Device 40:EF:4C:0C:11:F0 Connected: no
> [bluetooth]# info 40:EF:4C:0C:11:F0
> Device 40:EF:4C:0C:11:F0 (public)
>         Name: UFO
>         Alias: UFO
>         Class: 0x00240418
>         Icon: audio-headphones
>         Paired: yes
>         Trusted: no
>         Blocked: no
>         Connected: no
>         LegacyPairing: no
>         UUID: Headset                   (00001108-0000-1000-8000-00805f9b=
34fb)
>         UUID: Audio Sink                (0000110b-0000-1000-8000-00805f9b=
34fb)
>         UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b=
34fb)
>         UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b=
34fb)
>         UUID: Handsfree                 (0000111e-0000-1000-8000-00805f9b=
34fb)
>         UUID: Phonebook Access Server   (0000112f-0000-1000-8000-00805f9b=
34fb)
> [bluetooth]#
>
> 6=E6=9C=88 20 15:05:41 uos-PC bluetoothd[10094]: src/device.c:btd_device_=
set_temporary() temporary 1
> 6=E6=9C=88 20 15:05:41 uos-PC bluetoothd[10094]: src/service.c:change_sta=
te() 0x558c37a84200: device 40:EF:4C:0C:11:F0 profile avrcp-controller stat=
e changed: connected -> disconnecting (0)
> 6=E6=9C=88 20 15:05:41 uos-PC bluetoothd[10094]: profiles/audio/avrcp.c:a=
vrcp_disconnect() path /org/bluez/hci0/dev_40_EF_4C_0C_11_F0
> 6=E6=9C=88 20 15:05:41 uos-PC bluetoothd[10094]: src/service.c:change_sta=
te() 0x558c37aaeac0: device 40:EF:4C:0C:11:F0 profile audio-avrcp-target st=
ate changed: connected -> disconnected (0)
> 6=E6=9C=88 20 15:05:41 uos-PC bluetoothd[10094]: src/service.c:change_sta=
te() 0x558c37a84200: device 40:EF:4C:0C:11:F0 profile avrcp-controller stat=
e changed: disconnecting -> disconnected (0)
> 6=E6=9C=88 20 15:05:41 uos-PC bluetoothd[10094]: profiles/audio/avrcp.c:c=
ontroller_destroy() 0x558c37a4e600
> 6=E6=9C=88 20 15:05:41 uos-PC bluetoothd[10094]: profiles/audio/avrcp.c:t=
arget_destroy() 0x558c37a47e20
> 6=E6=9C=88 20 15:05:41 uos-PC bluetoothd[10094]: profiles/audio/avctp.c:a=
vctp_set_state() AVCTP Disconnected
> 6=E6=9C=88 20 15:05:41 uos-PC bluetoothd[10094]: profiles/audio/avctp.c:a=
vctp_disconnected() AVCTP: closing uinput for 40:EF:4C:0C:11:F0
> 6=E6=9C=88 20 15:05:41 uos-PC bluetoothd[10094]: src/service.c:change_sta=
te() 0x558c37aaeb30: device 40:EF:4C:0C:11:F0 profile a2dp-sink state chang=
ed: connected -> disconnecting (0)
> 6=E6=9C=88 20 15:05:41 uos-PC bluetoothd[10094]: profiles/audio/a2dp.c:a2=
dp_sink_disconnect() path /org/bluez/hci0/dev_40_EF_4C_0C_11_F0
> 6=E6=9C=88 20 15:05:41 uos-PC bluetoothd[10094]: src/service.c:change_sta=
te() 0x558c37a80790: device 40:EF:4C:0C:11:F0 profile Hands-Free Voice gate=
way state changed: connected -> disconnecting (0)
> 6=E6=9C=88 20 15:05:41 uos-PC bluetoothd[10094]: src/service.c:change_sta=
te() 0x558c37a869e0: device 40:EF:4C:0C:11:F0 profile Phone Book Access sta=
te changed: connected -> disconnecting (0)
> 6=E6=9C=88 20 15:05:41 uos-PC bluetoothd[10094]: src/adapter.c:remove_acc=
ept_list_complete() 40:EF:4C:0C:11:F0 removed from kernel accept list
> 6=E6=9C=88 20 15:05:41 uos-PC bluetoothd[10094]: src/service.c:change_sta=
te() 0x558c37a869e0: device 40:EF:4C:0C:11:F0 profile Phone Book Access sta=
te changed: disconnecting -> disconnected (0)
> 6=E6=9C=88 20 15:05:41 uos-PC bluetoothd[10094]: src/service.c:btd_servic=
e_unref() 0x558c37a869e0: ref=3D1
> 6=E6=9C=88 20 15:05:41 uos-PC bluetoothd[10094]: src/service.c:change_sta=
te() 0x558c37a80790: device 40:EF:4C:0C:11:F0 profile Hands-Free Voice gate=
way state changed: disconnecting -> disconnected (0)
> 6=E6=9C=88 20 15:05:41 uos-PC bluetoothd[10094]: src/service.c:btd_servic=
e_unref() 0x558c37a80790: ref=3D2
> 6=E6=9C=88 20 15:05:41 uos-PC bluetoothd[10094]: profiles/audio/avdtp.c:s=
ession_cb()
> 6=E6=9C=88 20 15:05:41 uos-PC bluetoothd[10094]: profiles/audio/avdtp.c:a=
vdtp_parse_resp() CLOSE request succeeded
> 6=E6=9C=88 20 15:05:41 uos-PC bluetoothd[10094]: profiles/audio/avdtp.c:a=
vdtp_sep_set_state() stream state changed: STREAMING -> CLOSING
> 6=E6=9C=88 20 15:05:41 uos-PC bluetoothd[10094]: profiles/audio/a2dp.c:cl=
ose_cfm() Source 0x558c37a73050: Close_Cfm
> 6=E6=9C=88 20 15:05:41 uos-PC bluetoothd[10094]: profiles/audio/avdtp.c:a=
vdtp_sep_set_state() stream state changed: CLOSING -> IDLE
> 6=E6=9C=88 20 15:05:41 uos-PC bluetoothd[10094]: profiles/audio/transport=
.c:media_transport_remove_owner() Transport /org/bluez/hci0/dev_40_EF_4C_0C=
_11_F0/sep1/fd10 Owner :1.1779
> 6=E6=9C=88 20 15:05:41 uos-PC bluetoothd[10094]: profiles/audio/transport=
.c:media_owner_free() Owner :1.1779
> 6=E6=9C=88 20 15:05:41 uos-PC bluetoothd[10094]: profiles/audio/transport=
.c:transport_set_state() State changed /org/bluez/hci0/dev_40_EF_4C_0C_11_F=
0/sep1/fd10: TRANSPORT_STATE_ACTIVE -> TRANSPORT_STATE_IDLE
> 6=E6=9C=88 20 15:05:41 uos-PC bluetoothd[10094]: profiles/audio/a2dp.c:a2=
dp_sep_unlock() SEP 0x558c37a73050 unlocked
> 6=E6=9C=88 20 15:05:41 uos-PC bluetoothd[10094]: profiles/audio/avdtp.c:a=
vdtp_unref() 0x558c37a61720: ref=3D1
> 6=E6=9C=88 20 15:05:41 uos-PC bluetoothd[10094]: src/service.c:change_sta=
te() 0x558c37aaeb30: device 40:EF:4C:0C:11:F0 profile a2dp-sink state chang=
ed: disconnecting -> disconnected (0)
> 6=E6=9C=88 20 15:05:41 uos-PC bluetoothd[10094]: profiles/audio/avdtp.c:a=
vdtp_unref() 0x558c37a61720: ref=3D0
> 6=E6=9C=88 20 15:05:41 uos-PC bluetoothd[10094]: profiles/audio/avdtp.c:a=
vdtp_ref() 0x558c37a61720: ref=3D1
> 6=E6=9C=88 20 15:05:41 uos-PC bluetoothd[10094]: profiles/audio/avdtp.c:s=
et_disconnect_timer() timeout 0
> 6=E6=9C=88 20 15:05:41 uos-PC bluetoothd[10094]: profiles/audio/avdtp.c:a=
vdtp_ref() 0x558c37a61720: ref=3D2
> 6=E6=9C=88 20 15:05:41 uos-PC bluetoothd[10094]: profiles/audio/avdtp.c:c=
onnection_lost() Disconnected from 40:EF:4C:0C:11:F0
> 6=E6=9C=88 20 15:05:41 uos-PC bluetoothd[10094]: profiles/audio/sink.c:si=
nk_set_state() State changed /org/bluez/hci0/dev_40_EF_4C_0C_11_F0: SINK_ST=
ATE_PLAYING -> SINK_STATE_DISCONNECTED
> 6=E6=9C=88 20 15:05:41 uos-PC bluetoothd[10094]: profiles/audio/a2dp.c:ch=
annel_remove() chan 0x558c37a4e530
> 6=E6=9C=88 20 15:05:41 uos-PC bluetoothd[10094]: profiles/audio/avdtp.c:a=
vdtp_unref() 0x558c37a61720: ref=3D1
> 6=E6=9C=88 20 15:05:41 uos-PC bluetoothd[10094]: profiles/audio/avdtp.c:a=
vdtp_unref() 0x558c37a61720: ref=3D0
> 6=E6=9C=88 20 15:05:41 uos-PC bluetoothd[10094]: profiles/audio/avdtp.c:a=
vdtp_free() 0x558c37a61720
> 6=E6=9C=88 20 15:05:44 uos-PC bluetoothd[10094]: src/adapter.c:dev_discon=
nected() Device 40:EF:4C:0C:11:F0 disconnected, reason 2
> 6=E6=9C=88 20 15:05:44 uos-PC bluetoothd[10094]: src/adapter.c:adapter_re=
move_connection()
> 6=E6=9C=88 20 15:05:44 uos-PC bluetoothd[10094]: plugins/policy.c:disconn=
ect_cb() reason 2
> 6=E6=9C=88 20 15:05:44 uos-PC bluetoothd[10094]: src/adapter.c:bonding_at=
tempt_complete() hci0 bdaddr 40:EF:4C:0C:11:F0 type 0 status 0xe
> 6=E6=9C=88 20 15:05:44 uos-PC bluetoothd[10094]: src/device.c:device_bond=
ing_complete() bonding (nil) status 0x0e
> 6=E6=9C=88 20 15:05:44 uos-PC bluetoothd[10094]: src/device.c:device_bond=
ing_failed() status 14
> 6=E6=9C=88 20 15:05:44 uos-PC bluetoothd[10094]: src/adapter.c:resume_dis=
covery()
>
>
> [bluetooth]#=E3=80=80remove 40:EF:4C:0C:11:F0
>
> 6=E6=9C=88 20 15:08:32 uos-PC bluetoothd[10094]: src/device.c:device_remo=
ve() Removing device /org/bluez/hci0/dev_40_EF_4C_0C_11_F0
> 6=E6=9C=88 20 15:08:32 uos-PC bluetoothd[10094]: src/service.c:change_sta=
te() 0x558c37a84200: device 40:EF:4C:0C:11:F0 profile avrcp-controller stat=
e changed: disconnected -> unavailable (0)
> 6=E6=9C=88 20 15:08:32 uos-PC bluetoothd[10094]: profiles/audio/control.c=
:path_unregister() Unregistered interface org.bluez.MediaControl1 on path /=
org/bluez/hci0/dev_40_EF_4C_0C_11_F0
> 6=E6=9C=88 20 15:08:32 uos-PC bluetoothd[10094]: src/service.c:btd_servic=
e_unref() 0x558c37aaeac0: ref=3D1
> 6=E6=9C=88 20 15:08:32 uos-PC bluetoothd[10094]: src/service.c:btd_servic=
e_unref() 0x558c37a84200: ref=3D1
> 6=E6=9C=88 20 15:08:32 uos-PC bluetoothd[10094]: src/service.c:btd_servic=
e_unref() 0x558c37a84200: ref=3D0
> 6=E6=9C=88 20 15:08:32 uos-PC bluetoothd[10094]: src/service.c:change_sta=
te() 0x558c37aaeac0: device 40:EF:4C:0C:11:F0 profile audio-avrcp-target st=
ate changed: disconnected -> unavailable (0)
> 6=E6=9C=88 20 15:08:32 uos-PC bluetoothd[10094]: src/service.c:btd_servic=
e_unref() 0x558c37aaeac0: ref=3D0
> 6=E6=9C=88 20 15:08:32 uos-PC bluetoothd[10094]: src/service.c:change_sta=
te() 0x558c37aaeb30: device 40:EF:4C:0C:11:F0 profile a2dp-sink state chang=
ed: disconnected -> unavailable (0)
> 6=E6=9C=88 20 15:08:32 uos-PC bluetoothd[10094]: src/service.c:btd_servic=
e_unref() 0x558c37aaeb30: ref=3D2
> 6=E6=9C=88 20 15:08:32 uos-PC bluetoothd[10094]: profiles/audio/sink.c:si=
nk_unregister() /org/bluez/hci0/dev_40_EF_4C_0C_11_F0
> 6=E6=9C=88 20 15:08:32 uos-PC bluetoothd[10094]: src/service.c:btd_servic=
e_unref() 0x558c37aaeb30: ref=3D1
> 6=E6=9C=88 20 15:08:32 uos-PC bluetoothd[10094]: src/service.c:btd_servic=
e_unref() 0x558c37aaeb30: ref=3D0
> 6=E6=9C=88 20 15:08:32 uos-PC bluetoothd[10094]: src/service.c:change_sta=
te() 0x558c37a80790: device 40:EF:4C:0C:11:F0 profile Hands-Free Voice gate=
way state changed: disconnected -> unavailable (0)
> 6=E6=9C=88 20 15:08:32 uos-PC bluetoothd[10094]: src/service.c:btd_servic=
e_unref() 0x558c37a80790: ref=3D1
> 6=E6=9C=88 20 15:08:32 uos-PC bluetoothd[10094]: src/profile.c:ext_device=
_remove() Hands-Free Voice gateway
> 6=E6=9C=88 20 15:08:32 uos-PC bluetoothd[10094]: src/service.c:btd_servic=
e_unref() 0x558c37a80790: ref=3D0
> 6=E6=9C=88 20 15:08:32 uos-PC bluetoothd[10094]: src/service.c:change_sta=
te() 0x558c37a869e0: device 40:EF:4C:0C:11:F0 profile Phone Book Access sta=
te changed: disconnected -> unavailable (0)
> 6=E6=9C=88 20 15:08:32 uos-PC bluetoothd[10094]: src/profile.c:ext_device=
_remove() Phone Book Access
> 6=E6=9C=88 20 15:08:32 uos-PC bluetoothd[10094]: src/service.c:btd_servic=
e_unref() 0x558c37a869e0: ref=3D0
> 6=E6=9C=88 20 15:08:32 uos-PC bluetoothd[10094]: src/device.c:btd_device_=
unref() Freeing device /org/bluez/hci0/dev_40_EF_4C_0C_11_F0
> 6=E6=9C=88 20 15:08:32 uos-PC bluetoothd[10094]: src/device.c:device_free=
() 0x558c37a93860

How about the following fix:

https://patchwork.kernel.org/project/bluetooth/patch/20220622190053.2605233=
-1-luiz.dentz@gmail.com/

> ------------------ Original ------------------
> From:  "Luiz Augusto von Dentz"<luiz.dentz@gmail.com>;
> Date:  Wed, Jun 22, 2022 02:39 AM
> To:  "Youwan Wang"<wangyouwan@uniontech.com>;
> Cc:  "linux-bluetooth@vger.kernel.org"<linux-bluetooth@vger.kernel.org>;
> Subject:  Re: [PATCH] device: Fix timeout=3D1 to remove the device immedi=
ately
>
> Hi Youwan,
>
> On Tue, Jun 21, 2022 at 6:55 AM Youwan Wang <wangyouwan@uniontech.com> wr=
ote:
> >
> > =E3=80=80When I use bluetoothctl to remove a device,
> > =E3=80=80I find that the device has not been deleted.
> >
> > =E3=80=80static void set_temporary_timer(device, 0)
> > =E3=80=80{
> >      ......
> >         if (!timeout)
> >                 return;
> > =E3=80=80=E3=80=80 ......
> > =E3=80=80 }
> >
> > =E3=80=80=E3=80=80Now I want to delete the connected device
> >     when call remove.
> > =E3=80=80=E3=80=80I don't know whether this modification is
> >     feasible, please give me some suggestions.
> > ---
> >  src/device.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/src/device.c b/src/device.c
> > index 7b451e458..d38ad74fc 100644
> > --- a/src/device.c
> > +++ b/src/device.c
> > @@ -3159,7 +3159,7 @@ void device_remove_connection(struct btd_device *=
device, uint8_t bdaddr_type)
> >                                                 DEVICE_INTERFACE, "Conn=
ected");
> >
> >         if (remove_device)
> > -               set_temporary_timer(device, 0);
> > +               set_temporary_timer(device, 1);
> >  }
>
> Don't think this is right, in fact the original code could have been
> clearer since all we want is to call clear_temporary_timeout thus why
> we passed 0, perhaps you are after the following fix:
>
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=3D5ebc2b5a3=
e48dbe67a2d315979b096a1b4d1eb99
>
> >  guint device_add_disconnect_watch(struct btd_device *device,
> > --
> > 2.20.1
> >
> >
> >
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
