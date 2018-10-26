Return-Path: <SRS0=luki=NG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0BDC46475
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Oct 2018 02:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A05E2083E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Oct 2018 02:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jCvlP8cP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A05E2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbeJZKfL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Oct 2018 06:35:11 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:55483 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbeJZKfL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Oct 2018 06:35:11 -0400
Received: by mail-it1-f194.google.com with SMTP id c23-v6so3965551itd.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Oct 2018 19:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pXh6Mxp533h5X3LRYNfD1G7VAr8EhHEGN2VxipgXdCM=;
        b=jCvlP8cPqGCI+nOXyHqyqkfpBYTEGg3fdqN307f4q2IKiNTOO35WFLGQU5XLUypXvV
         m8YcBfzFVEo5MOJ3RdvH7tyCka5KIWpyrE21RY8KgSeLkJWGwTaSmUOh1vBuvAWvbm/m
         unyruMvQ2zFxbf9mEWlSVAS5OiMbCDmv7/VSO98hbSvlT8fO4VbubwTH/4rn+yibmOw1
         1Ylse/ScXyt0fPTNbPWDnPjBIHWq3tv7O1dr2+VCSJzoaOTauTvGPJC0py3LprHLU6AP
         Ab3K3BeTvNcE/cB+fbckSSm2yIMU7+O0gyuyOM+tUe0RrRqV5YMuseSvFNSCFCxKUBfy
         e7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pXh6Mxp533h5X3LRYNfD1G7VAr8EhHEGN2VxipgXdCM=;
        b=OFFgfVgrFnEx9YpVxvjA3ohYqXRHuy8My/pV5LkYwI4AhGYkmVtuPMCpFvKCVP6DH8
         Eq0tMlJilrkrdNqibrTm6YwN2cmAS/pUGuCU/S+6lSK7x6way4GmNkeD+IceAWRoujq2
         5gQ0ZMpT7jccdbymoMvjGfzckbsUakrFp7r30Ib1GlNCwiC/K336ONxHTgdtM9PN9DWB
         erRJdHnw+9sFn5RyXna1STR9ROk3U/KCnPGqs8z87P7yjCnkiTXtIQk0Deoz++iWroIw
         03t95oI4zef/ucMcT0GcNflc9hjIqmw8xntEdhS7P3Rq79HcADj06u9GUwH0G1Gjczo6
         QXTQ==
X-Gm-Message-State: AGRZ1gI+2zp7galRolYHBWKx6atXzwl2stgpM0QJq8LxsIMBg96Ij0+e
        g1611xP0wyLf3O/Elc5KctEwLwKuIu1Rs962yYgo8A==
X-Google-Smtp-Source: AJdET5cAZcrP7gXr1kksqolUnnJ8rfj7+OoGpG56Kk+06H+mzowohiStbPayIw33AzXs8l5pNvWBpImkpkkymKIh1Cs=
X-Received: by 2002:a24:81d7:: with SMTP id q206-v6mr2436582itd.94.1540519206695;
 Thu, 25 Oct 2018 19:00:06 -0700 (PDT)
MIME-Version: 1.0
References: <20181025004210.177441-1-yunhanw@google.com> <CALvjcs83c2B0aq7Vz8WU4DC=ikQfB5W_XfYh+S_rkydi=6agMw@mail.gmail.com>
 <CABBYNZ+5i=tv-dcnMr+21D28NZL9ayWVTLkC8DfWQA9jZUWXQg@mail.gmail.com>
 <CALvjcs_-_DuXJWt8zWj4wH32Dz2w41UdPKxfOqQ5ZwA-gqO1mw@mail.gmail.com>
 <CALvjcs_YPhcg4GEVvRrsnS=auzzA_=AxmFt_Nx2UO5Rw1rY0cg@mail.gmail.com>
 <CABBYNZ+YKck9btAU=qkohHT0C__RF-0pf2vK2eF14XB8K6x9WQ@mail.gmail.com>
 <CABBYNZKQ_jFUA7PBuW_oc3eU22SV4hyy4nBeSEDNtWTk+mWhnw@mail.gmail.com>
 <CALvjcs9_ssfyVGjfg8b836_D=poy-W1F16uLNXZ=1_8rAK9b-A@mail.gmail.com> <CABBYNZLZEdc7_zd2XcLgvQZZqkFp_Z+xDZdzNHrWx9p6Bm45OQ@mail.gmail.com>
In-Reply-To: <CABBYNZLZEdc7_zd2XcLgvQZZqkFp_Z+xDZdzNHrWx9p6Bm45OQ@mail.gmail.com>
From:   Yunhan Wang <yunhanw@google.com>
Date:   Thu, 25 Oct 2018 18:59:55 -0700
Message-ID: <CALvjcs-CTXUNAw_p4rTW6cCeX1LV4Rh5=+eQGAPqTf5L0T827A@mail.gmail.com>
Subject: Re: [PATCH] gatt: Fix double att_disconnected issue on disconnection
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi, Luiz

On Thu, Oct 25, 2018 at 2:41 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Yunhan,
> On Fri, Oct 26, 2018 at 12:06 AM Yunhan Wang <yunhanw@google.com> wrote:
> >
> > Hi, Luiz
> >
> > I am using latest bluez master without any change for this issue, I
> > think I am not missing any changes....The issue is there.
>
> Then we have a problem on bt_att, but that is tracking if the handler
> is removed so I wonder how it is still reproducible for you.
>
It is reproducible using real ble dongles, It is also reproducible
using btvirt.....
Using btvirt -L -l2  and bluetoothctl

Following the below instructions, when central issue ble disconnection
to peripheral, the bluetoothd would crash as I show before.

Peripheral:

[bluetooth]# select 00:AA:01:01:00:24
Controller 00:AA:01:01:00:24 N0001 [default]
[bluetooth]# system-alias N0001
Changing N0001 succeeded
[bluetooth]# power on
Changing power on succeeded
[bluetooth]# name N0001
[bluetooth]# uuids FEAF
[bluetooth]# discoverable on
[bluetooth]# back
[bluetooth]# register-service 0000feaf-0000-1000-8000-00805f9b34fb
[NEW] Primary Service
/org/bluez/app/service0x562f48a31860
0000feaf-0000-1000-8000-00805f9b34fb
Nest Labs Inc.
[/org/bluez/app/service0x562f48a31860] Primary (yes/no): yees
Invalid option: yees
[DEL] Primary Service
/org/bluez/app/service0x562f48a31860
0000feaf-0000-1000-8000-00805f9b34fb
Nest Labs Inc.
[bluetooth]# register-service 0000feaf-0000-1000-8000-00805f9b34fb
[NEW] Primary Service
/org/bluez/app/service0x562f48a34e70
0000feaf-0000-1000-8000-00805f9b34fb
Nest Labs Inc.
[/org/bluez/app/service0x562f48a34e70] Primary (yes/no): yes

[bluetooth]# register-characteristic
18ee2ef5-263d-4559-959f-4f9c429f9d11 read,write
[NEW] Characteristic
/org/bluez/app/service0x562f48a34e70/chrc0x562f48a437c0
18ee2ef5-263d-4559-959f-4f9c429f9d11
Vendor specific
[/org/bluez/app/service0x562f48a34e70/chrc0x562f48a437c0] Enter value: 1

[bluetooth]# register-application
[CHG] Controller 00:AA:01:01:00:24 UUIDs: 00001800-0000-1000-8000-00805f9b3=
4fb
[CHG] Controller 00:AA:01:01:00:24 UUIDs: 00001801-0000-1000-8000-00805f9b3=
4fb
[CHG] Controller 00:AA:01:01:00:24 UUIDs: 0000110e-0000-1000-8000-00805f9b3=
4fb
[CHG] Controller 00:AA:01:01:00:24 UUIDs: 00001200-0000-1000-8000-00805f9b3=
4fb
[CHG] Controller 00:AA:01:01:00:24 UUIDs: 0000110c-0000-1000-8000-00805f9b3=
4fb
[CHG] Controller 00:AA:01:01:00:24 UUIDs: 0000feaf-0000-1000-8000-00805f9b3=
4fb
Application registered
[CHG] Controller 00:AA:01:01:00:24 UUIDs: 00001800-0000-1000-8000-00805f9b3=
4fb
[CHG] Controller 00:AA:01:01:00:24 UUIDs: 00001801-0000-1000-8000-00805f9b3=
4fb
[CHG] Controller 00:AA:01:01:00:24 UUIDs: 0000110e-0000-1000-8000-00805f9b3=
4fb
[CHG] Controller 00:AA:01:01:00:24 UUIDs: 00001200-0000-1000-8000-00805f9b3=
4fb
[CHG] Controller 00:AA:01:01:00:24 UUIDs: 0000110c-0000-1000-8000-00805f9b3=
4fb
[CHG] Controller 00:AA:01:01:00:24 UUIDs: 0000feaf-0000-1000-8000-00805f9b3=
4fb
[bluetooth]# back

[bluetooth]# advertise peripheral
[CHG] Controller 00:AA:01:01:00:24 SupportedInstances: 0x04
[CHG] Controller 00:AA:01:01:00:24 ActiveInstances: 0x01
Advertising object registered
UUID: (FEAF)
Tx Power: off
LocalName: N0001
Apperance: off
Discoverable: on
[CHG] Controller 00:AA:01:00:00:23 Powered: yes
[CHG] Controller 00:AA:01:00:00:23 Discovering: yes
[CHG] Controller 00:AA:01:00:00:23 Discovering: no
[CHG] Controller 00:AA:01:00:00:23 Discovering: yes
[CHG] Device 00:AA:01:00:00:23 Connected: yes
[NEW] Primary Service
/org/bluez/hci2/dev_00_AA_01_00_00_23/service0006
00001801-0000-1000-8000-00805f9b34fb
Generic Attribute Profile
[NEW] Characteristic
/org/bluez/hci2/dev_00_AA_01_00_00_23/service0006/char0007
00002a05-0000-1000-8000-00805f9b34fb
Service Changed
[NEW] Descriptor
/org/bluez/hci2/dev_00_AA_01_00_00_23/service0006/char0007/desc0009
00002902-0000-1000-8000-00805f9b34fb
Client Characteristic Configuration
[CHG] Device 00:AA:01:00:00:23 ServicesResolved: yes


Central:

[bluetooth]# select 00:AA:01:00:00:23
Discovery stopped
[bluetooth]# scan on
Discovery started
[CHG] Controller 00:AA:01:00:00:23 Discovering: yes
[bluetooth]# connect 00:AA:01:01:00:24
Attempting to connect to 00:AA:01:01:00:24
[CHG] Device 00:AA:01:01:00:24 Connected: yes
Connection successful
[CHG] Device 00:AA:01:01:00:24 UUIDs: 00001800-0000-1000-8000-00805f9b34fb
[CHG] Device 00:AA:01:01:00:24 UUIDs: 00001801-0000-1000-8000-00805f9b34fb
[NEW] Primary Service
/org/bluez/hci1/dev_00_AA_01_01_00_24/service0006
00001801-0000-1000-8000-00805f9b34fb
Generic Attribute Profile
[NEW] Characteristic
/org/bluez/hci1/dev_00_AA_01_01_00_24/service0006/char0007
00002a05-0000-1000-8000-00805f9b34fb
Service Changed
[NEW] Descriptor
/org/bluez/hci1/dev_00_AA_01_01_00_24/service0006/char0007/desc0009
00002902-0000-1000-8000-00805f9b34fb
Client Characteristic Configuration
[NEW] Primary Service
/org/bluez/hci1/dev_00_AA_01_01_00_24/service000d
0000feaf-0000-1000-8000-00805f9b34fb
Nest Labs Inc.
[NEW] Characteristic
/org/bluez/hci1/dev_00_AA_01_01_00_24/service000d/char000e
18ee2ef5-263d-4559-959f-4f9c429f9d11
Vendor specific
[CHG] Device 00:AA:01:01:00:24 UUIDs: 00001800-0000-1000-8000-00805f9b34fb
[CHG] Device 00:AA:01:01:00:24 UUIDs: 00001801-0000-1000-8000-00805f9b34fb
[CHG] Device 00:AA:01:01:00:24 UUIDs: 0000feaf-0000-1000-8000-00805f9b34fb
[CHG] Device 00:AA:01:01:00:24 ServicesResolved: yes

[N0001]# disconnect 00:AA:01:01:00:24
Attempting to disconnect from 00:AA:01:01:00:24
[CHG] Device 00:AA:01:01:00:24 ServicesResolved: no
Successful disconnected


> > It is not for chrome os. I am currently trying bring up bluez version
> > from commit in Jan 19 11:37:07 2018 to latest master in Open weave
> > project(https://github.com/openweave/openweave-core/blob/master/repos.c=
onf),
> > where we are using BLE for weave pairing in iot products, and create
> > two GATT characteristics for Tx and Rx and the TCP-like control
> > protocol  to control BLE packet flow. Periodically I would sync Bluez
> > revision in openweave against Bluez Upstream.
>
> All major mobile OS support LE L2CAP CoC channels, no idea why
> companies want to keep using GATT for emulating serial like
> communication special when L2CAP does have support for fragmentation
> and flow control.
>
Yes, L2CAP do have support for fragmentation and flow control, but for
some platforms, it may not have bluez, and its L2CAP is not good, then
GATT layer fragmentation and flow control is needed. In addition, the
L2CAP API is available on neither Android nor iOS when we did this
implementation in the past...then GATT layer fragmentation and flow
control is also needed.

Thanks
Best wishes
Yunhan
> > Thanks
> > Best wishes
> > Yunhan
> >
> > On Thu, Oct 25, 2018 at 1:22 PM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Yunhan,
> > >
> > > On Thu, Oct 25, 2018 at 9:24 PM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > Hi Yunhan,
> > > >
> > > > We might be better of removing the handler altogether and just leav=
e device.c handler instead then.
> > > >
> > > > On Thu, 25 Oct 2018, 20:19 Yunhan Wang, <yunhanw@google.com> wrote:
> > > >>
> > > >> Hi, Luiz
> > > >>
> > > >> Actually before I submit my patch, I tried your way to unregister =
the
> > > >> handler, it is failing. That is why I use random address check in
> > > >> btd_gatt_database_att_disconnected to workaround this issue.
> > > >>
> > > >> Thanks
> > > >> Best wishes
> > > >> Yunhan
> > > >>
> > > >>
> > > >>
> > > >> On Thu, Oct 25, 2018 at 10:49 AM Yunhan Wang <yunhanw@google.com> =
wrote:
> > > >> >
> > > >> > Hi, Luiz
> > > >> >
> > > >> > Just have a test with your patch in master branch, both crashes =
are
> > > >> > still there, and att_disconnected has been called for two times =
even
> > > >> > though unregistering the handler....
> > >
> > > Actually you may be missing the following patch:
> > >
> > > commit 261cf78db4be79a0f7d44798a57730b159c9be91
> > > Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > Date:   Mon Oct 23 14:13:59 2017 +0300
> > >
> > >     shared/att: Fix crash when calling disconnect handlers
> > >
> > > This is quite old btw, what version is Chrome OS shipping?
> > >
> > > >> > Thanks
> > > >> > Best wishes
> > > >> > Yunhan
> > > >> >
> > > >> > Program received signal SIGSEGV, Segmentation fault.
> > > >> > btd_adapter_find_device (adapter=3D0x72657664612f6372,
> > > >> > dst=3Ddst@entry=3D0x555555872998, bdaddr_type=3D0 '\000')
> > > >> >     at bluez/repo/src/adapter.c:845
> > > >> > 845 list =3D g_slist_find_custom(adapter->devices, &addr,
> > > >> > (gdb) bt
> > > >> > #0  btd_adapter_find_device (adapter=3D0x72657664612f6372,
> > > >> > dst=3Ddst@entry=3D0x555555872998, bdaddr_type=3D0 '\000')
> > > >> >     at bluez/repo/src/adapter.c:845
> > > >> > #1  0x00005555555ab890 in att_disconnected (err=3D<optimized out=
>,
> > > >> > user_data=3D0x555555872990)
> > > >> >     at bluez/repo/src/gatt-database.c:329
> > > >> > #2  0x00005555555eaba8 in queue_foreach (queue=3D0x55555585de60,
> > > >> > function=3Dfunction@entry=3D0x5555555ee5f0 <disconn_handler>,
> > > >> > user_data=3D0x68)
> > > >> >     at bluez/repo/src/shared/queue.c:220
> > > >> > #3  0x00005555555ef819 in disconnect_cb (io=3D<optimized out>,
> > > >> > user_data=3D0x555555869d50)
> > > >> >     at bluez/repo/src/shared/att.c:592
> > > >> > #4  0x00005555555f89a3 in watch_callback (channel=3D<optimized o=
ut>,
> > > >> > cond=3D<optimized out>, user_data=3D<optimized out>)
> > > >> >     at bluez/repo/src/shared/io-glib.c:170
> > > >> > #5  0x00007ffff7b0fe35 in g_main_context_dispatch () from
> > > >> > /lib/x86_64-linux-gnu/libglib-2.0.so.0
> > > >> > #6  0x00007ffff7b10200 in ?? () from /lib/x86_64-linux-gnu/libgl=
ib-2.0.so.0
> > > >> > #7  0x00007ffff7b10512 in g_main_loop_run () from
> > > >> > /lib/x86_64-linux-gnu/libglib-2.0.so.0
> > > >> > #8  0x0000555555572238 in main (argc=3D<optimized out>, argv=3D<=
optimized
> > > >> > out>) at bluez/repo/src/main.c:808
> > > >> >
> > > >> >
> > > >> > Program received signal SIGSEGV, Segmentation fault.
> > > >> > queue_remove (queue=3D0x30, data=3Ddata@entry=3D0x555555873740) =
at
> > > >> > bluez/repo/src/shared/queue.c:256
> > > >> > 256 for (entry =3D queue->head, prev =3D NULL; entry;
> > > >> > (gdb) bt
> > > >> > #0  queue_remove (queue=3D0x30, data=3Ddata@entry=3D0x5555558737=
40) at
> > > >> > bluez/repo/src/shared/queue.c:256
> > > >> > #1  0x00005555555ab8c5 in att_disconnected (err=3D<optimized out=
>,
> > > >> > user_data=3D0x555555873740)
> > > >> >     at bluez/repo/src/gatt-database.c:350
> > > >> > #2  0x00005555555eabb8 in queue_foreach (queue=3D0x55555586e670,
> > > >> > function=3Dfunction@entry=3D0x5555555ee600 <disconn_handler>,
> > > >> > user_data=3D0x68)
> > > >> >     at bluez/repo/src/shared/queue.c:220
> > > >> > #3  0x00005555555ef829 in disconnect_cb (io=3D<optimized out>,
> > > >> > user_data=3D0x555555865f50)
> > > >> >     at bluez/repo/src/shared/att.c:592
> > > >> > #4  0x00005555555f89b3 in watch_callback (channel=3D<optimized o=
ut>,
> > > >> > cond=3D<optimized out>, user_data=3D<optimized out>)
> > > >> >     at bluez/repo/src/shared/io-glib.c:170
> > > >> > #5  0x00007ffff7b0fe35 in g_main_context_dispatch () from
> > > >> > /lib/x86_64-linux-gnu/libglib-2.0.so.0
> > > >> > #6  0x00007ffff7b10200 in ?? () from /lib/x86_64-linux-gnu/libgl=
ib-2.0.so.0
> > > >> > #7  0x00007ffff7b10512 in g_main_loop_run () from
> > > >> > /lib/x86_64-linux-gnu/libglib-2.0.so.0
> > > >> > #8  0x0000555555572238 in main (argc=3D<optimized out>, argv=3D<=
optimized
> > > >> > out>) at  bluez/repo/src/main.c:808
> > > >> > On Thu, Oct 25, 2018 at 2:20 AM Luiz Augusto von Dentz
> > > >> > <luiz.dentz@gmail.com> wrote:
> > > >> > >
> > > >> > > Hi Yunhan,
> > > >> > >
> > > >> > > On Thu, Oct 25, 2018 at 4:47 AM Yunhan Wang <yunhanw@google.co=
m> wrote:
> > > >> > > >
> > > >> > > > Hi, Luiz
> > > >> > > >
> > > >> > > > I am observing the multiple crashes when doing BLE disconnec=
tion using
> > > >> > > > latest bluez master..It looks like the two att_disconnect ar=
e
> > > >> > > > triggered from your last gatt commit.. Please help take a lo=
ok at this
> > > >> > > > workaround and comments.. the better solution might be to fi=
gure out
> > > >> > > > how to handle the disconnection along with random address an=
d public
> > > >> > > > address together regarding the previous issue, Gatt: Subscri=
ptions are
> > > >> > > > not cleared after disconnection from a temporary device
> > > >> > >
> > > >> > > Ive pushed a similar fix, it should remove the handler before =
calling
> > > >> > > att_disconnected.
> > > >> > >
> > > >> > > > Thanks
> > > >> > > > Best wishes
> > > >> > > > Yunhan
> > > >> > > > On Wed, Oct 24, 2018 at 5:42 PM yunhanw <yunhanw@google.com>=
 wrote:
> > > >> > > > >
> > > >> > > > > When BLE disconnection happens, att_disconnect is triggere=
d from two locations, the new added location is gatt_server_cleanup, it wou=
ld cause several blueetoothd crashes. This bus is introduced from commit 63=
4f0a6e1125af8d5959bff119d9336a8d81c028, where gatt fix, gatt subscriptions =
are not cleared after disconnection from a temporary device with private/ra=
ndom address. In order to workaround this issue, btd_gatt_database_att_disc=
onnected can only be triggered when address type is random, and for others,=
 it can continue to use original disconnect code path.
> > > >> > > > >
> > > >> > > > >     crash 1
> > > >> > > > >     Program received signal SIGSEGV, Segmentation fault.
> > > >> > > > >     queue_remove (queue=3D0x30, data=3Ddata@entry=3D0x5555=
55872a40) at /repo/src/shared/queue.c:256
> > > >> > > > >     256     for (entry =3D queue->head, prev =3D NULL; ent=
ry;
> > > >> > > > >     (gdb) backtrace
> > > >> > > > >         at /bluez/repo/src/gatt-database.c:350
> > > >> > > > >         at bluez/repo/src/shared/queue.c:220
> > > >> > > > >         at bluez/repo/src/shared/att.c:592
> > > >> > > > >         at bluez/repo/src/shared/io-glib.c:170
> > > >> > > > >
> > > >> > > > >     crash 2
> > > >> > > > >         at bluez/repo/src/shared/queue.c:220
> > > >> > > > >         at bluez/repo/src/shared/att.c:592
> > > >> > > > >         at bluez/repo/src/shared/io-glib.c:170
> > > >> > > > >
> > > >> > > > >     (gdb) print state->db->adapter
> > > >> > > > >     Cannot access memory at address 0x61672f6269727474
> > > >> > > > > ---
> > > >> > > > >  src/gatt-database.c | 2 ++
> > > >> > > > >  1 file changed, 2 insertions(+)
> > > >> > > > >
> > > >> > > > > diff --git a/src/gatt-database.c b/src/gatt-database.c
> > > >> > > > > index 783b692d5..2f0eb83b5 100644
> > > >> > > > > --- a/src/gatt-database.c
> > > >> > > > > +++ b/src/gatt-database.c
> > > >> > > > > @@ -3365,6 +3365,8 @@ void btd_gatt_database_att_disconnec=
ted(struct btd_gatt_database *database,
> > > >> > > > >
> > > >> > > > >         addr =3D device_get_address(device);
> > > >> > > > >         type =3D btd_device_get_bdaddr_type(device);
> > > >> > > > > +    if (type !=3D BDADDR_LE_RANDOM)
> > > >> > > > > +        return;
> > > >> > > > >
> > > >> > > > >         state =3D find_device_state(database, addr, type);
> > > >> > > > >         if (!state)
> > > >> > > > > --
> > > >> > > > > 2.19.1.568.g152ad8e336-goog
> > > >> > > > >
> > > >> > >
> > > >> > >
> > > >> > >
> > > >> > > --
> > > >> > > Luiz Augusto von Dentz
> > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz
