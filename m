Return-Path: <SRS0=L2xa=NJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02723C0044C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Oct 2018 13:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B0222082D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Oct 2018 13:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njQjjJ3I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B0222082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbeJ2WRJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Oct 2018 18:17:09 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38291 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbeJ2WRJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Oct 2018 18:17:09 -0400
Received: by mail-oi1-f196.google.com with SMTP id v83-v6so1061302oia.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Oct 2018 06:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xSsEVDX6/pEfLhxNTVuUXJHzY9frO+zU0xfSb9/kX1Y=;
        b=njQjjJ3IUBes/62J+x9FvBEphGBT0Oulua4mifoLVUa7II4fdLfV4jb4v9zgZE/akp
         cL1q9LGgYYXGKf3QN7IPXf4iBqgdS5ooYpWLEvQUhWT70XSf+dx30ETdkJBbgXJZ67vk
         PXGpRObddwXBv0hj4EPbY27UtJdN6ZMN2PXApWxL9IDFWyFsOhr5SGFOqIfCNn8DrB5F
         iwVLbpAIleckjiIPMiqBqIEmIpn+j83me/h63gb54bTd2m22vOpn2HGDNB/Cv/4VndHX
         LBc30pzohINlx7n422zAadPweOWRMJif0jKEvrRg/ntbpaVMS4Kkt9JTeYwfmYoGVsaX
         wYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xSsEVDX6/pEfLhxNTVuUXJHzY9frO+zU0xfSb9/kX1Y=;
        b=e5DHEUo6gFThyyM3NOiPM3Svq9gQgAyzHHUr0ZoWETOKD6H7R+sOsW7S7V1ctVhdyc
         W4rgYOIwaXkB8+OgTc6FmBUCJEpvcoNqkaZp06M0PsFfiZ62Ch1Zv88UFMDm6x+Q6uT7
         o06TEQXh1gFKn1payB/dkWS5dmThxTZU9tnQVfTX3lRmGWoiES6V/PIFGRnyTN8PAYMQ
         oAyvN4MUTAwMvksrwmlhXkBcDpE2R5zLQtNl9SdGsf2c68QFC+CkVvYPe53gcU4YurUn
         s7GzA3wi8+/QVkmOEtB1/HZICqQgQcV2EOg8/GcJcY5y3PKQ4M0KJyTZMYJJmDyCUwzA
         kC1Q==
X-Gm-Message-State: AGRZ1gLDk70R926jk+0Uc+mnbyZGVzeWpwTWr8OKz4OhkBs8nO8TqtN2
        jeZLzFlYAB7D1q2fyAZ5RgEWNWacM5XaPBJ4EaV1n/XI
X-Google-Smtp-Source: AJdET5dM0+VWc3xvyofdk4jGHFaf9xjx6mYmILlD0dW2t691xaDdfxQs/iqNCHvAfGdSViW83hrDDyf/Od2mrpRqrsQ=
X-Received: by 2002:aca:bb54:: with SMTP id l81-v6mr7721119oif.153.1540819707666;
 Mon, 29 Oct 2018 06:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <20181025004210.177441-1-yunhanw@google.com> <CALvjcs83c2B0aq7Vz8WU4DC=ikQfB5W_XfYh+S_rkydi=6agMw@mail.gmail.com>
 <CABBYNZ+5i=tv-dcnMr+21D28NZL9ayWVTLkC8DfWQA9jZUWXQg@mail.gmail.com>
 <CALvjcs_-_DuXJWt8zWj4wH32Dz2w41UdPKxfOqQ5ZwA-gqO1mw@mail.gmail.com>
 <CALvjcs_YPhcg4GEVvRrsnS=auzzA_=AxmFt_Nx2UO5Rw1rY0cg@mail.gmail.com>
 <CABBYNZ+YKck9btAU=qkohHT0C__RF-0pf2vK2eF14XB8K6x9WQ@mail.gmail.com>
 <CABBYNZKQ_jFUA7PBuW_oc3eU22SV4hyy4nBeSEDNtWTk+mWhnw@mail.gmail.com>
 <CALvjcs9_ssfyVGjfg8b836_D=poy-W1F16uLNXZ=1_8rAK9b-A@mail.gmail.com>
 <CABBYNZLZEdc7_zd2XcLgvQZZqkFp_Z+xDZdzNHrWx9p6Bm45OQ@mail.gmail.com> <CALvjcs-CTXUNAw_p4rTW6cCeX1LV4Rh5=+eQGAPqTf5L0T827A@mail.gmail.com>
In-Reply-To: <CALvjcs-CTXUNAw_p4rTW6cCeX1LV4Rh5=+eQGAPqTf5L0T827A@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 29 Oct 2018 15:28:15 +0200
Message-ID: <CABBYNZK67PN5v1GSnCP=_RYkAjy+o_vfPHoTOHywOv9_-+xRiw@mail.gmail.com>
Subject: Re: [PATCH] gatt: Fix double att_disconnected issue on disconnection
To:     Yunhan Wang <yunhanw@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Yunhan,
On Fri, Oct 26, 2018 at 5:00 AM Yunhan Wang <yunhanw@google.com> wrote:
>
> Hi, Luiz
>
> On Thu, Oct 25, 2018 at 2:41 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Yunhan,
> > On Fri, Oct 26, 2018 at 12:06 AM Yunhan Wang <yunhanw@google.com> wrote=
:
> > >
> > > Hi, Luiz
> > >
> > > I am using latest bluez master without any change for this issue, I
> > > think I am not missing any changes....The issue is there.
> >
> > Then we have a problem on bt_att, but that is tracking if the handler
> > is removed so I wonder how it is still reproducible for you.
> >
> It is reproducible using real ble dongles, It is also reproducible
> using btvirt.....
> Using btvirt -L -l2  and bluetoothctl
>
> Following the below instructions, when central issue ble disconnection
> to peripheral, the bluetoothd would crash as I show before.
>
> Peripheral:
>
> [bluetooth]# select 00:AA:01:01:00:24
> Controller 00:AA:01:01:00:24 N0001 [default]
> [bluetooth]# system-alias N0001
> Changing N0001 succeeded
> [bluetooth]# power on
> Changing power on succeeded
> [bluetooth]# name N0001
> [bluetooth]# uuids FEAF
> [bluetooth]# discoverable on
> [bluetooth]# back
> [bluetooth]# register-service 0000feaf-0000-1000-8000-00805f9b34fb
> [NEW] Primary Service
> /org/bluez/app/service0x562f48a31860
> 0000feaf-0000-1000-8000-00805f9b34fb
> Nest Labs Inc.
> [/org/bluez/app/service0x562f48a31860] Primary (yes/no): yees
> Invalid option: yees
> [DEL] Primary Service
> /org/bluez/app/service0x562f48a31860
> 0000feaf-0000-1000-8000-00805f9b34fb
> Nest Labs Inc.
> [bluetooth]# register-service 0000feaf-0000-1000-8000-00805f9b34fb
> [NEW] Primary Service
> /org/bluez/app/service0x562f48a34e70
> 0000feaf-0000-1000-8000-00805f9b34fb
> Nest Labs Inc.
> [/org/bluez/app/service0x562f48a34e70] Primary (yes/no): yes
>
> [bluetooth]# register-characteristic
> 18ee2ef5-263d-4559-959f-4f9c429f9d11 read,write
> [NEW] Characteristic
> /org/bluez/app/service0x562f48a34e70/chrc0x562f48a437c0
> 18ee2ef5-263d-4559-959f-4f9c429f9d11
> Vendor specific
> [/org/bluez/app/service0x562f48a34e70/chrc0x562f48a437c0] Enter value: 1
>
> [bluetooth]# register-application
> [CHG] Controller 00:AA:01:01:00:24 UUIDs: 00001800-0000-1000-8000-00805f9=
b34fb
> [CHG] Controller 00:AA:01:01:00:24 UUIDs: 00001801-0000-1000-8000-00805f9=
b34fb
> [CHG] Controller 00:AA:01:01:00:24 UUIDs: 0000110e-0000-1000-8000-00805f9=
b34fb
> [CHG] Controller 00:AA:01:01:00:24 UUIDs: 00001200-0000-1000-8000-00805f9=
b34fb
> [CHG] Controller 00:AA:01:01:00:24 UUIDs: 0000110c-0000-1000-8000-00805f9=
b34fb
> [CHG] Controller 00:AA:01:01:00:24 UUIDs: 0000feaf-0000-1000-8000-00805f9=
b34fb
> Application registered
> [CHG] Controller 00:AA:01:01:00:24 UUIDs: 00001800-0000-1000-8000-00805f9=
b34fb
> [CHG] Controller 00:AA:01:01:00:24 UUIDs: 00001801-0000-1000-8000-00805f9=
b34fb
> [CHG] Controller 00:AA:01:01:00:24 UUIDs: 0000110e-0000-1000-8000-00805f9=
b34fb
> [CHG] Controller 00:AA:01:01:00:24 UUIDs: 00001200-0000-1000-8000-00805f9=
b34fb
> [CHG] Controller 00:AA:01:01:00:24 UUIDs: 0000110c-0000-1000-8000-00805f9=
b34fb
> [CHG] Controller 00:AA:01:01:00:24 UUIDs: 0000feaf-0000-1000-8000-00805f9=
b34fb
> [bluetooth]# back
>
> [bluetooth]# advertise peripheral
> [CHG] Controller 00:AA:01:01:00:24 SupportedInstances: 0x04
> [CHG] Controller 00:AA:01:01:00:24 ActiveInstances: 0x01
> Advertising object registered
> UUID: (FEAF)
> Tx Power: off
> LocalName: N0001
> Apperance: off
> Discoverable: on
> [CHG] Controller 00:AA:01:00:00:23 Powered: yes
> [CHG] Controller 00:AA:01:00:00:23 Discovering: yes
> [CHG] Controller 00:AA:01:00:00:23 Discovering: no
> [CHG] Controller 00:AA:01:00:00:23 Discovering: yes
> [CHG] Device 00:AA:01:00:00:23 Connected: yes
> [NEW] Primary Service
> /org/bluez/hci2/dev_00_AA_01_00_00_23/service0006
> 00001801-0000-1000-8000-00805f9b34fb
> Generic Attribute Profile
> [NEW] Characteristic
> /org/bluez/hci2/dev_00_AA_01_00_00_23/service0006/char0007
> 00002a05-0000-1000-8000-00805f9b34fb
> Service Changed
> [NEW] Descriptor
> /org/bluez/hci2/dev_00_AA_01_00_00_23/service0006/char0007/desc0009
> 00002902-0000-1000-8000-00805f9b34fb
> Client Characteristic Configuration
> [CHG] Device 00:AA:01:00:00:23 ServicesResolved: yes
>
>
> Central:
>
> [bluetooth]# select 00:AA:01:00:00:23
> Discovery stopped
> [bluetooth]# scan on
> Discovery started
> [CHG] Controller 00:AA:01:00:00:23 Discovering: yes
> [bluetooth]# connect 00:AA:01:01:00:24
> Attempting to connect to 00:AA:01:01:00:24
> [CHG] Device 00:AA:01:01:00:24 Connected: yes
> Connection successful
> [CHG] Device 00:AA:01:01:00:24 UUIDs: 00001800-0000-1000-8000-00805f9b34f=
b
> [CHG] Device 00:AA:01:01:00:24 UUIDs: 00001801-0000-1000-8000-00805f9b34f=
b
> [NEW] Primary Service
> /org/bluez/hci1/dev_00_AA_01_01_00_24/service0006
> 00001801-0000-1000-8000-00805f9b34fb
> Generic Attribute Profile
> [NEW] Characteristic
> /org/bluez/hci1/dev_00_AA_01_01_00_24/service0006/char0007
> 00002a05-0000-1000-8000-00805f9b34fb
> Service Changed
> [NEW] Descriptor
> /org/bluez/hci1/dev_00_AA_01_01_00_24/service0006/char0007/desc0009
> 00002902-0000-1000-8000-00805f9b34fb
> Client Characteristic Configuration
> [NEW] Primary Service
> /org/bluez/hci1/dev_00_AA_01_01_00_24/service000d
> 0000feaf-0000-1000-8000-00805f9b34fb
> Nest Labs Inc.
> [NEW] Characteristic
> /org/bluez/hci1/dev_00_AA_01_01_00_24/service000d/char000e
> 18ee2ef5-263d-4559-959f-4f9c429f9d11
> Vendor specific
> [CHG] Device 00:AA:01:01:00:24 UUIDs: 00001800-0000-1000-8000-00805f9b34f=
b
> [CHG] Device 00:AA:01:01:00:24 UUIDs: 00001801-0000-1000-8000-00805f9b34f=
b
> [CHG] Device 00:AA:01:01:00:24 UUIDs: 0000feaf-0000-1000-8000-00805f9b34f=
b
> [CHG] Device 00:AA:01:01:00:24 ServicesResolved: yes
>
> [N0001]# disconnect 00:AA:01:01:00:24
> Attempting to disconnect from 00:AA:01:01:00:24
> [CHG] Device 00:AA:01:01:00:24 ServicesResolved: no
> Successful disconnected

It should be fixed now, the problem was that the bt_gatt_server was
set to NULL already thus the bt_att_unregister_disconnect did nothing,
Ive might have tested a version were I passed bt_att directly but
later I changed to use bt_gatt_server to access the bt_att instance
from btd_device.

>
> > > It is not for chrome os. I am currently trying bring up bluez version
> > > from commit in Jan 19 11:37:07 2018 to latest master in Open weave
> > > project(https://github.com/openweave/openweave-core/blob/master/repos=
.conf),
> > > where we are using BLE for weave pairing in iot products, and create
> > > two GATT characteristics for Tx and Rx and the TCP-like control
> > > protocol  to control BLE packet flow. Periodically I would sync Bluez
> > > revision in openweave against Bluez Upstream.
> >
> > All major mobile OS support LE L2CAP CoC channels, no idea why
> > companies want to keep using GATT for emulating serial like
> > communication special when L2CAP does have support for fragmentation
> > and flow control.
> >
> Yes, L2CAP do have support for fragmentation and flow control, but for
> some platforms, it may not have bluez, and its L2CAP is not good, then
> GATT layer fragmentation and flow control is needed. In addition, the
> L2CAP API is available on neither Android nor iOS when we did this
> implementation in the past...then GATT layer fragmentation and flow
> control is also needed.

Sure, though moving to L2CAP is a lot simpler... anyway it was just a
recommendation given that L2CAP is now supported.

> Thanks
> Best wishes
> Yunhan
> > > Thanks
> > > Best wishes
> > > Yunhan
> > >
> > > On Thu, Oct 25, 2018 at 1:22 PM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > Hi Yunhan,
> > > >
> > > > On Thu, Oct 25, 2018 at 9:24 PM Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > > >
> > > > > Hi Yunhan,
> > > > >
> > > > > We might be better of removing the handler altogether and just le=
ave device.c handler instead then.
> > > > >
> > > > > On Thu, 25 Oct 2018, 20:19 Yunhan Wang, <yunhanw@google.com> wrot=
e:
> > > > >>
> > > > >> Hi, Luiz
> > > > >>
> > > > >> Actually before I submit my patch, I tried your way to unregiste=
r the
> > > > >> handler, it is failing. That is why I use random address check i=
n
> > > > >> btd_gatt_database_att_disconnected to workaround this issue.
> > > > >>
> > > > >> Thanks
> > > > >> Best wishes
> > > > >> Yunhan
> > > > >>
> > > > >>
> > > > >>
> > > > >> On Thu, Oct 25, 2018 at 10:49 AM Yunhan Wang <yunhanw@google.com=
> wrote:
> > > > >> >
> > > > >> > Hi, Luiz
> > > > >> >
> > > > >> > Just have a test with your patch in master branch, both crashe=
s are
> > > > >> > still there, and att_disconnected has been called for two time=
s even
> > > > >> > though unregistering the handler....
> > > >
> > > > Actually you may be missing the following patch:
> > > >
> > > > commit 261cf78db4be79a0f7d44798a57730b159c9be91
> > > > Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > Date:   Mon Oct 23 14:13:59 2017 +0300
> > > >
> > > >     shared/att: Fix crash when calling disconnect handlers
> > > >
> > > > This is quite old btw, what version is Chrome OS shipping?
> > > >
> > > > >> > Thanks
> > > > >> > Best wishes
> > > > >> > Yunhan
> > > > >> >
> > > > >> > Program received signal SIGSEGV, Segmentation fault.
> > > > >> > btd_adapter_find_device (adapter=3D0x72657664612f6372,
> > > > >> > dst=3Ddst@entry=3D0x555555872998, bdaddr_type=3D0 '\000')
> > > > >> >     at bluez/repo/src/adapter.c:845
> > > > >> > 845 list =3D g_slist_find_custom(adapter->devices, &addr,
> > > > >> > (gdb) bt
> > > > >> > #0  btd_adapter_find_device (adapter=3D0x72657664612f6372,
> > > > >> > dst=3Ddst@entry=3D0x555555872998, bdaddr_type=3D0 '\000')
> > > > >> >     at bluez/repo/src/adapter.c:845
> > > > >> > #1  0x00005555555ab890 in att_disconnected (err=3D<optimized o=
ut>,
> > > > >> > user_data=3D0x555555872990)
> > > > >> >     at bluez/repo/src/gatt-database.c:329
> > > > >> > #2  0x00005555555eaba8 in queue_foreach (queue=3D0x55555585de6=
0,
> > > > >> > function=3Dfunction@entry=3D0x5555555ee5f0 <disconn_handler>,
> > > > >> > user_data=3D0x68)
> > > > >> >     at bluez/repo/src/shared/queue.c:220
> > > > >> > #3  0x00005555555ef819 in disconnect_cb (io=3D<optimized out>,
> > > > >> > user_data=3D0x555555869d50)
> > > > >> >     at bluez/repo/src/shared/att.c:592
> > > > >> > #4  0x00005555555f89a3 in watch_callback (channel=3D<optimized=
 out>,
> > > > >> > cond=3D<optimized out>, user_data=3D<optimized out>)
> > > > >> >     at bluez/repo/src/shared/io-glib.c:170
> > > > >> > #5  0x00007ffff7b0fe35 in g_main_context_dispatch () from
> > > > >> > /lib/x86_64-linux-gnu/libglib-2.0.so.0
> > > > >> > #6  0x00007ffff7b10200 in ?? () from /lib/x86_64-linux-gnu/lib=
glib-2.0.so.0
> > > > >> > #7  0x00007ffff7b10512 in g_main_loop_run () from
> > > > >> > /lib/x86_64-linux-gnu/libglib-2.0.so.0
> > > > >> > #8  0x0000555555572238 in main (argc=3D<optimized out>, argv=
=3D<optimized
> > > > >> > out>) at bluez/repo/src/main.c:808
> > > > >> >
> > > > >> >
> > > > >> > Program received signal SIGSEGV, Segmentation fault.
> > > > >> > queue_remove (queue=3D0x30, data=3Ddata@entry=3D0x555555873740=
) at
> > > > >> > bluez/repo/src/shared/queue.c:256
> > > > >> > 256 for (entry =3D queue->head, prev =3D NULL; entry;
> > > > >> > (gdb) bt
> > > > >> > #0  queue_remove (queue=3D0x30, data=3Ddata@entry=3D0x55555587=
3740) at
> > > > >> > bluez/repo/src/shared/queue.c:256
> > > > >> > #1  0x00005555555ab8c5 in att_disconnected (err=3D<optimized o=
ut>,
> > > > >> > user_data=3D0x555555873740)
> > > > >> >     at bluez/repo/src/gatt-database.c:350
> > > > >> > #2  0x00005555555eabb8 in queue_foreach (queue=3D0x55555586e67=
0,
> > > > >> > function=3Dfunction@entry=3D0x5555555ee600 <disconn_handler>,
> > > > >> > user_data=3D0x68)
> > > > >> >     at bluez/repo/src/shared/queue.c:220
> > > > >> > #3  0x00005555555ef829 in disconnect_cb (io=3D<optimized out>,
> > > > >> > user_data=3D0x555555865f50)
> > > > >> >     at bluez/repo/src/shared/att.c:592
> > > > >> > #4  0x00005555555f89b3 in watch_callback (channel=3D<optimized=
 out>,
> > > > >> > cond=3D<optimized out>, user_data=3D<optimized out>)
> > > > >> >     at bluez/repo/src/shared/io-glib.c:170
> > > > >> > #5  0x00007ffff7b0fe35 in g_main_context_dispatch () from
> > > > >> > /lib/x86_64-linux-gnu/libglib-2.0.so.0
> > > > >> > #6  0x00007ffff7b10200 in ?? () from /lib/x86_64-linux-gnu/lib=
glib-2.0.so.0
> > > > >> > #7  0x00007ffff7b10512 in g_main_loop_run () from
> > > > >> > /lib/x86_64-linux-gnu/libglib-2.0.so.0
> > > > >> > #8  0x0000555555572238 in main (argc=3D<optimized out>, argv=
=3D<optimized
> > > > >> > out>) at  bluez/repo/src/main.c:808
> > > > >> > On Thu, Oct 25, 2018 at 2:20 AM Luiz Augusto von Dentz
> > > > >> > <luiz.dentz@gmail.com> wrote:
> > > > >> > >
> > > > >> > > Hi Yunhan,
> > > > >> > >
> > > > >> > > On Thu, Oct 25, 2018 at 4:47 AM Yunhan Wang <yunhanw@google.=
com> wrote:
> > > > >> > > >
> > > > >> > > > Hi, Luiz
> > > > >> > > >
> > > > >> > > > I am observing the multiple crashes when doing BLE disconn=
ection using
> > > > >> > > > latest bluez master..It looks like the two att_disconnect =
are
> > > > >> > > > triggered from your last gatt commit.. Please help take a =
look at this
> > > > >> > > > workaround and comments.. the better solution might be to =
figure out
> > > > >> > > > how to handle the disconnection along with random address =
and public
> > > > >> > > > address together regarding the previous issue, Gatt: Subsc=
riptions are
> > > > >> > > > not cleared after disconnection from a temporary device
> > > > >> > >
> > > > >> > > Ive pushed a similar fix, it should remove the handler befor=
e calling
> > > > >> > > att_disconnected.
> > > > >> > >
> > > > >> > > > Thanks
> > > > >> > > > Best wishes
> > > > >> > > > Yunhan
> > > > >> > > > On Wed, Oct 24, 2018 at 5:42 PM yunhanw <yunhanw@google.co=
m> wrote:
> > > > >> > > > >
> > > > >> > > > > When BLE disconnection happens, att_disconnect is trigge=
red from two locations, the new added location is gatt_server_cleanup, it w=
ould cause several blueetoothd crashes. This bus is introduced from commit =
634f0a6e1125af8d5959bff119d9336a8d81c028, where gatt fix, gatt subscription=
s are not cleared after disconnection from a temporary device with private/=
random address. In order to workaround this issue, btd_gatt_database_att_di=
sconnected can only be triggered when address type is random, and for other=
s, it can continue to use original disconnect code path.
> > > > >> > > > >
> > > > >> > > > >     crash 1
> > > > >> > > > >     Program received signal SIGSEGV, Segmentation fault.
> > > > >> > > > >     queue_remove (queue=3D0x30, data=3Ddata@entry=3D0x55=
5555872a40) at /repo/src/shared/queue.c:256
> > > > >> > > > >     256     for (entry =3D queue->head, prev =3D NULL; e=
ntry;
> > > > >> > > > >     (gdb) backtrace
> > > > >> > > > >         at /bluez/repo/src/gatt-database.c:350
> > > > >> > > > >         at bluez/repo/src/shared/queue.c:220
> > > > >> > > > >         at bluez/repo/src/shared/att.c:592
> > > > >> > > > >         at bluez/repo/src/shared/io-glib.c:170
> > > > >> > > > >
> > > > >> > > > >     crash 2
> > > > >> > > > >         at bluez/repo/src/shared/queue.c:220
> > > > >> > > > >         at bluez/repo/src/shared/att.c:592
> > > > >> > > > >         at bluez/repo/src/shared/io-glib.c:170
> > > > >> > > > >
> > > > >> > > > >     (gdb) print state->db->adapter
> > > > >> > > > >     Cannot access memory at address 0x61672f6269727474
> > > > >> > > > > ---
> > > > >> > > > >  src/gatt-database.c | 2 ++
> > > > >> > > > >  1 file changed, 2 insertions(+)
> > > > >> > > > >
> > > > >> > > > > diff --git a/src/gatt-database.c b/src/gatt-database.c
> > > > >> > > > > index 783b692d5..2f0eb83b5 100644
> > > > >> > > > > --- a/src/gatt-database.c
> > > > >> > > > > +++ b/src/gatt-database.c
> > > > >> > > > > @@ -3365,6 +3365,8 @@ void btd_gatt_database_att_disconn=
ected(struct btd_gatt_database *database,
> > > > >> > > > >
> > > > >> > > > >         addr =3D device_get_address(device);
> > > > >> > > > >         type =3D btd_device_get_bdaddr_type(device);
> > > > >> > > > > +    if (type !=3D BDADDR_LE_RANDOM)
> > > > >> > > > > +        return;
> > > > >> > > > >
> > > > >> > > > >         state =3D find_device_state(database, addr, type=
);
> > > > >> > > > >         if (!state)
> > > > >> > > > > --
> > > > >> > > > > 2.19.1.568.g152ad8e336-goog
> > > > >> > > > >
> > > > >> > >
> > > > >> > >
> > > > >> > >
> > > > >> > > --
> > > > >> > > Luiz Augusto von Dentz
> > > >
> > > >
> > > >
> > > > --
> > > > Luiz Augusto von Dentz
> >
> >
> >
> > --
> > Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
