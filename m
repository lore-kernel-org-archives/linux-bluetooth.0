Return-Path: <SRS0=qOEI=NK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16008C2BC61
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Oct 2018 15:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC4E2082D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Oct 2018 15:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fKUPJNri"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BC4E2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbeJ3X4b (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Oct 2018 19:56:31 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:54120 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbeJ3X4b (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Oct 2018 19:56:31 -0400
Received: by mail-it1-f195.google.com with SMTP id f16-v6so6525977ita.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Oct 2018 08:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dAE2fcLcPVNMYK61p8wQ08m44JZwu7YUE2DODrSA5cs=;
        b=fKUPJNriRJ0+8Gze0L6pKqSELYXUw2iPV4tBFHEKlBsUxfEtUbRZ+6wMmbTK6aKbD3
         XUW5dcUbWtg3qKeImA6Q8IaQI5zhI9SPdyYTWkuLZQcKSB2J93rrhVuxNO+7gYzHY3I9
         IMpIzq0kqeoPP2dQhxwxRAv+VXwMWN7qkPXsBY++FRKoBkvGogSYWmTbse5rwj7hSuZp
         RVm490mjxvW6Wp+r4rFsiUf4WH6F1vrDp+NrpC0nl6rSNd7W4sAg/bg+09HkHeB5osQ2
         6tzIv3oZ0XxRMFoZif1DL2U8rCzpHciAcBu6AwEcuP1OsYw6TEF/TTcMuM36MeELbmNZ
         3Yiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dAE2fcLcPVNMYK61p8wQ08m44JZwu7YUE2DODrSA5cs=;
        b=SB7q5sBQNtvrrttBJUc78T//Y43eMyJJ7dyxJI1hGo9Dh32/cAwCs1WXuxBCinDFID
         DUnt1SAD8gVp6pf2nGxobzFC0XQjGS+q93pL/VscszbuI9i3I/X7kEq/FnnnCaUnbiIi
         EjsuAULcEZzjH67jffrnb1XDcGQcECt2HrXdJkn3drsDHZwX7X9v4OL8ZeVRCmg0PUd2
         vrkk2CKgm9WEJJZ+lrMzys6XunpmXCxhBQi0zAjBgJtP8u6EZ0dgqpoHjzxkUUnTs+Ng
         xiPh11trTGCIRJyLO1KElypbjTXBjqp2Z4zIMIZguwAHPYXsj7l/i9PvOSu9CMsjbEGX
         I02A==
X-Gm-Message-State: AGRZ1gL4vxwWR6tmutElomZo/qwakuT34GSclnVq+RJtVaHO+dWQIorX
        49Xlt6/kEv1SwticSCOlQi7aYuay5NiyYnJzUhd9Iw==
X-Google-Smtp-Source: AJdET5fwWovgRRqyPDtWSSJk1dLLK40pibjLDKAKgga/H5LBSS7AwuWvAgjtKv0nIt6nqC2AEB+qNLMhwp9Xyk9QV7A=
X-Received: by 2002:a02:1649:: with SMTP id a70-v6mr13703546jaa.128.1540911760052;
 Tue, 30 Oct 2018 08:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <20181025004210.177441-1-yunhanw@google.com> <CALvjcs83c2B0aq7Vz8WU4DC=ikQfB5W_XfYh+S_rkydi=6agMw@mail.gmail.com>
 <CABBYNZ+5i=tv-dcnMr+21D28NZL9ayWVTLkC8DfWQA9jZUWXQg@mail.gmail.com>
 <CALvjcs_-_DuXJWt8zWj4wH32Dz2w41UdPKxfOqQ5ZwA-gqO1mw@mail.gmail.com>
 <CALvjcs_YPhcg4GEVvRrsnS=auzzA_=AxmFt_Nx2UO5Rw1rY0cg@mail.gmail.com>
 <CABBYNZ+YKck9btAU=qkohHT0C__RF-0pf2vK2eF14XB8K6x9WQ@mail.gmail.com>
 <CABBYNZKQ_jFUA7PBuW_oc3eU22SV4hyy4nBeSEDNtWTk+mWhnw@mail.gmail.com>
 <CALvjcs9_ssfyVGjfg8b836_D=poy-W1F16uLNXZ=1_8rAK9b-A@mail.gmail.com>
 <CABBYNZLZEdc7_zd2XcLgvQZZqkFp_Z+xDZdzNHrWx9p6Bm45OQ@mail.gmail.com>
 <CALvjcs-CTXUNAw_p4rTW6cCeX1LV4Rh5=+eQGAPqTf5L0T827A@mail.gmail.com>
 <CABBYNZK67PN5v1GSnCP=_RYkAjy+o_vfPHoTOHywOv9_-+xRiw@mail.gmail.com>
 <CALvjcs-XMCMQh=Xz2jXYJZO0b0b4MCFWegn_hKmtNHwor+8eUg@mail.gmail.com>
 <CALvjcs-J4gpmvdLk4n6uOKGDiJYQSGs6vQjYSnOWmuDDd9UyGg@mail.gmail.com> <CABBYNZLd_ms7SbjEx2t_a52KVwBDVJMhVhv8YXM=Dvw8tq5WjA@mail.gmail.com>
In-Reply-To: <CABBYNZLd_ms7SbjEx2t_a52KVwBDVJMhVhv8YXM=Dvw8tq5WjA@mail.gmail.com>
From:   Yunhan Wang <yunhanw@google.com>
Date:   Tue, 30 Oct 2018 08:02:27 -0700
Message-ID: <CALvjcs9OH3sH+mMyfrxAVROesF=Ok1i2n9J7QR45OBAzP2OE8g@mail.gmail.com>
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
On Tue, Oct 30, 2018 at 5:52 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Yunhan,
>
> On Tue, Oct 30, 2018 at 9:21 AM Yunhan Wang <yunhanw@google.com> wrote:
> >
> > Hi, Luiz
> >
> > I am still seeing the bluetoothd crash when disconnect happens on this
> > issue. Here I reproduce using btvirt and add characteristic with
> > indicate in ble peripheral, put notify on for this characteristic in
> > ble central
> > crash is as below:
> >
> > #0  __memcmp_sse4_1 () at ../sysdeps/x86_64/multiarch/memcmp-sse4.S:943
> > #1  0x00005555555cfd3a in bacmp (ba2=3D0x7fffffffdfe9, ba1=3D0xb) at
> > bluez/repo/lib/bluetooth.h:317
> > #2  device_addr_type_cmp (a=3D0x0, b=3D0x7fffffffdfe9) at
> > /bluez/repo/src/device.c:4216
> > #3  0x00007ffff7b2e3d1 in g_slist_find_custom () from
> > /lib/x86_64-linux-gnu/libglib-2.0.so.0
> > #4  0x00005555555bcf18 in btd_adapter_find_device (adapter=3D<optimized
> > out>, dst=3Ddst@entry=3D0x555555876038, bdaddr_type=3D<optimized out>)
> >     at bluez/repo/src/adapter.c:845
> > #5  0x00005555555ab89e in att_disconnected (err=3D<optimized out>,
> > user_data=3D0x555555876030)
> >     at bluez/repo/src/gatt-database.c:329
> > #6  0x00005555555eabb8 in queue_foreach (queue=3D0x555555874460,
> > function=3Dfunction@entry=3D0x5555555ee600 <disconn_handler>,
> > user_data=3D0x68)
> >     at bluez/repo/src/shared/queue.c:220
> > #7  0x00005555555ef829 in disconnect_cb (io=3D<optimized out>,
> > user_data=3D0x5555558742a0)
> >     at /bluez/repo/src/shared/att.c:592
> > #8  0x00005555555f89b3 in watch_callback (channel=3D<optimized out>,
> > cond=3D<optimized out>, user_data=3D<optimized out>)
> >     at /bluez/repo/src/shared/io-glib.c:170
> > #9  0x00007ffff7b0fe35 in g_main_context_dispatch () from
> > /lib/x86_64-linux-gnu/libglib-2.0.so.0
> > #10 0x00007ffff7b10200 in ?? () from /lib/x86_64-linux-gnu/libglib-2.0.=
so.0
> > #11 0x00007ffff7b10512 in g_main_loop_run () from
> > /lib/x86_64-linux-gnu/libglib-2.0.so.0
> > #12 0x0000555555572238 in main (argc=3D<optimized out>, argv=3D<optimiz=
ed
> > out>) at /bluez/repo/src/main.c:808
> >
> > Peripheral:
> >
> > [bluetooth]# select 00:AA:01:01:00:24
> > Controller 00:AA:01:01:00:24 N0001 [default]
> > [bluetooth]# system-alias N0001
> > Changing N0001 succeeded
> > [bluetooth]# power on
> > Changing power on succeeded
> > [bluetooth]# name N0001
> > [bluetooth]# uuids FEAF
> > [bluetooth]# discoverable on
>
> Hmm, are you connecting over BR/EDR, normally you would need to
> advertise in order to connect? I guess I haven't tried that, but at
> least with LE Im pretty sure it doesn't crash anymore, it is worth
> checking if it is not connecting on multiple bearers at the same time
> though.
>
No, I am not connecting over BR/EDR, i am only using LE. I am
consistently reproducing this issue using btvirt using the
instructions here, the additional thing I have done is to add
characteristic with indicate and notify on, without this additional
setting, you will not see the crash.

> > [bluetooth]# back
> > [bluetooth]# register-service 0000feaf-0000-1000-8000-00805f9b34fb
> > [NEW] Primary Service
> > /org/bluez/app/service0x562f48a31860
> > 0000feaf-0000-1000-8000-00805f9b34fb
> > Nest Labs Inc.
> > [/org/bluez/app/service0x562f48a31860] Primary (yes/no): yees
> > Invalid option: yees
> > [DEL] Primary Service
> > /org/bluez/app/service0x562f48a31860
> > 0000feaf-0000-1000-8000-00805f9b34fb
> > Nest Labs Inc.
> > [bluetooth]# register-service 0000feaf-0000-1000-8000-00805f9b34fb
> > [NEW] Primary Service
> > /org/bluez/app/service0x562f48a34e70
> > 0000feaf-0000-1000-8000-00805f9b34fb
> > Nest Labs Inc.
> > [/org/bluez/app/service0x562f48a34e70] Primary (yes/no): yes
> >
> > [bluetooth]# register-characteristic
> > 18ee2ef5-263d-4559-959f-4f9c429f9d11 read,indicate
> > [NEW] Characteristic
> > /org/bluez/app/service0x562f48a34e70/chrc0x562f48a437c0
> > 18ee2ef5-263d-4559-959f-4f9c429f9d11
> > Vendor specific
> > [/org/bluez/app/service0x562f48a34e70/chrc0x562f48a437c0] Enter value: =
1
> >
Indicate is here

> > [bluetooth]# register-application
> > [CHG] Controller 00:AA:01:01:00:24 UUIDs: 00001800-0000-1000-8000-00805=
f9b34fb
> > [CHG] Controller 00:AA:01:01:00:24 UUIDs: 00001801-0000-1000-8000-00805=
f9b34fb
> > [CHG] Controller 00:AA:01:01:00:24 UUIDs: 0000110e-0000-1000-8000-00805=
f9b34fb
> > [CHG] Controller 00:AA:01:01:00:24 UUIDs: 00001200-0000-1000-8000-00805=
f9b34fb
> > [CHG] Controller 00:AA:01:01:00:24 UUIDs: 0000110c-0000-1000-8000-00805=
f9b34fb
> > [CHG] Controller 00:AA:01:01:00:24 UUIDs: 0000feaf-0000-1000-8000-00805=
f9b34fb
> > Application registered
> > [CHG] Controller 00:AA:01:01:00:24 UUIDs: 00001800-0000-1000-8000-00805=
f9b34fb
> > [CHG] Controller 00:AA:01:01:00:24 UUIDs: 00001801-0000-1000-8000-00805=
f9b34fb
> > [CHG] Controller 00:AA:01:01:00:24 UUIDs: 0000110e-0000-1000-8000-00805=
f9b34fb
> > [CHG] Controller 00:AA:01:01:00:24 UUIDs: 00001200-0000-1000-8000-00805=
f9b34fb
> > [CHG] Controller 00:AA:01:01:00:24 UUIDs: 0000110c-0000-1000-8000-00805=
f9b34fb
> > [CHG] Controller 00:AA:01:01:00:24 UUIDs: 0000feaf-0000-1000-8000-00805=
f9b34fb
> > [bluetooth]# back
> >
> > [bluetooth]# advertise peripheral
> > [CHG] Controller 00:AA:01:01:00:24 SupportedInstances: 0x04
> > [CHG] Controller 00:AA:01:01:00:24 ActiveInstances: 0x01
> > Advertising object registered
advertise peripheral is here

> > UUID: (FEAF)
> > Tx Power: off
> > LocalName: N0001
> > Apperance: off
> > Discoverable: on
> > [CHG] Controller 00:AA:01:00:00:23 Powered: yes
> > [CHG] Controller 00:AA:01:00:00:23 Discovering: yes
> > [CHG] Controller 00:AA:01:00:00:23 Discovering: no
> > [CHG] Controller 00:AA:01:00:00:23 Discovering: yes
> > [CHG] Device 00:AA:01:00:00:23 Connected: yes
> > [NEW] Primary Service
> > /org/bluez/hci2/dev_00_AA_01_00_00_23/service0006
> > 00001801-0000-1000-8000-00805f9b34fb
> > Generic Attribute Profile
> > [NEW] Characteristic
> > /org/bluez/hci2/dev_00_AA_01_00_00_23/service0006/char0007
> > 00002a05-0000-1000-8000-00805f9b34fb
> > Service Changed
> > [NEW] Descriptor
> > /org/bluez/hci2/dev_00_AA_01_00_00_23/service0006/char0007/desc0009
> > 00002902-0000-1000-8000-00805f9b34fb
> > Client Characteristic Configuration
> > [CHG] Device 00:AA:01:00:00:23 ServicesResolved: yes
> >
> >
> > Central:
> >
> > [bluetooth]# select 00:AA:01:00:00:23
> > Discovery stopped
> > [bluetooth]# scan on
> > Discovery started
> > [CHG] Controller 00:AA:01:00:00:23 Discovering: yes
> > [bluetooth]# connect 00:AA:01:01:00:24
> > Attempting to connect to 00:AA:01:01:00:24
> > [CHG] Device 00:AA:01:01:00:24 Connected: yes
> > Connection successful
> > [CHG] Device 00:AA:01:01:00:24 UUIDs: 00001800-0000-1000-8000-00805f9b3=
4fb
> > [CHG] Device 00:AA:01:01:00:24 UUIDs: 00001801-0000-1000-8000-00805f9b3=
4fb
> > [NEW] Primary Service
> > /org/bluez/hci1/dev_00_AA_01_01_00_24/service0006
> > 00001801-0000-1000-8000-00805f9b34fb
> > Generic Attribute Profile
> > [NEW] Characteristic
> > /org/bluez/hci1/dev_00_AA_01_01_00_24/service0006/char0007
> > 00002a05-0000-1000-8000-00805f9b34fb
> > Service Changed
> > [NEW] Descriptor
> > /org/bluez/hci1/dev_00_AA_01_01_00_24/service0006/char0007/desc0009
> > 00002902-0000-1000-8000-00805f9b34fb
> > Client Characteristic Configuration
> > [NEW] Primary Service
> > /org/bluez/hci1/dev_00_AA_01_01_00_24/service000d
> > 0000feaf-0000-1000-8000-00805f9b34fb
> > Nest Labs Inc.
> > [NEW] Characteristic
> > /org/bluez/hci1/dev_00_AA_01_01_00_24/service000d/char000e
> > 18ee2ef5-263d-4559-959f-4f9c429f9d11
> > Vendor specific
> > [CHG] Device 00:AA:01:01:00:24 UUIDs: 00001800-0000-1000-8000-00805f9b3=
4fb
> > [CHG] Device 00:AA:01:01:00:24 UUIDs: 00001801-0000-1000-8000-00805f9b3=
4fb
> > [CHG] Device 00:AA:01:01:00:24 UUIDs: 0000feaf-0000-1000-8000-00805f9b3=
4fb
> > [CHG] Device 00:AA:01:01:00:24 ServicesResolved: yes
> >
> > [N0001]# select-attribute 00002a05-0000-1000-8000-00805f9b34fb
> > [CHG] Device 00:AA:01:01:00:24 RSSI: 127
> > [CHG] Device 00:AA:01:01:00:24 AdvertisingFlags:
> >   06                                               .
> > [N0001:/service0006/char0007]# notify on
> > [CHG] Attribute
> > /org/bluez/hci1/dev_00_AA_01_01_00_24/service0006/char0007 Notifying:
> > yes
> > Notify started
notify on is here
> >
> >
> > [N0001]# disconnect 00:AA:01:01:00:24
> > Attempting to disconnect from 00:AA:01:01:00:24
> > [CHG] Device 00:AA:01:01:00:24 ServicesResolved: no
> > Successful disconnected
>
> After this all I got was:
>
> bluetoothd[31908]: src/gatt-client.c:btd_gatt_client_disconnected()
> Device disconnected. Cleaning up.
> bluetoothd[31908]: src/device.c:att_disconnected_cb() Automatic
> connection disabled
> bluetoothd[31908]: src/gatt-database.c:btd_gatt_database_att_disconnected=
()
> bluetoothd[31908]: src/gatt-database.c:att_disconnected()
> bluetoothd[31908]: attrib/gattrib.c:g_attrib_unref() 0x99b3ba0: g_attrib_=
unref=3D0
>
Have you setup =E2=80=98indicate=E2=80=99 and =E2=80=98notify on =E2=80=98 =
in your steps?

Thanks
Best wishes
Yunhan
> >
> > Thanks
> > Best wishes
> > Yunhan
> > On Mon, Oct 29, 2018 at 1:05 PM Yunhan Wang <yunhanw@google.com> wrote:
> > >
> > > Hi, Luiz
> > >
> > > Great, thanks. It is working now.
> > >
> > > Best wishes
> > > Yunhan
> > > On Mon, Oct 29, 2018 at 6:28 AM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > Hi Yunhan,
> > > > On Fri, Oct 26, 2018 at 5:00 AM Yunhan Wang <yunhanw@google.com> wr=
ote:
> > > > >
> > > > > Hi, Luiz
> > > > >
> > > > > On Thu, Oct 25, 2018 at 2:41 PM Luiz Augusto von Dentz
> > > > > <luiz.dentz@gmail.com> wrote:
> > > > > >
> > > > > > Hi Yunhan,
> > > > > > On Fri, Oct 26, 2018 at 12:06 AM Yunhan Wang <yunhanw@google.co=
m> wrote:
> > > > > > >
> > > > > > > Hi, Luiz
> > > > > > >
> > > > > > > I am using latest bluez master without any change for this is=
sue, I
> > > > > > > think I am not missing any changes....The issue is there.
> > > > > >
> > > > > > Then we have a problem on bt_att, but that is tracking if the h=
andler
> > > > > > is removed so I wonder how it is still reproducible for you.
> > > > > >
> > > > > It is reproducible using real ble dongles, It is also reproducibl=
e
> > > > > using btvirt.....
> > > > > Using btvirt -L -l2  and bluetoothctl
> > > > >
> > > > > Following the below instructions, when central issue ble disconne=
ction
> > > > > to peripheral, the bluetoothd would crash as I show before.
> > > > >
> > > > > Peripheral:
> > > > >
> > > > > [bluetooth]# select 00:AA:01:01:00:24
> > > > > Controller 00:AA:01:01:00:24 N0001 [default]
> > > > > [bluetooth]# system-alias N0001
> > > > > Changing N0001 succeeded
> > > > > [bluetooth]# power on
> > > > > Changing power on succeeded
> > > > > [bluetooth]# name N0001
> > > > > [bluetooth]# uuids FEAF
> > > > > [bluetooth]# discoverable on
> > > > > [bluetooth]# back
> > > > > [bluetooth]# register-service 0000feaf-0000-1000-8000-00805f9b34f=
b
> > > > > [NEW] Primary Service
> > > > > /org/bluez/app/service0x562f48a31860
> > > > > 0000feaf-0000-1000-8000-00805f9b34fb
> > > > > Nest Labs Inc.
> > > > > [/org/bluez/app/service0x562f48a31860] Primary (yes/no): yees
> > > > > Invalid option: yees
> > > > > [DEL] Primary Service
> > > > > /org/bluez/app/service0x562f48a31860
> > > > > 0000feaf-0000-1000-8000-00805f9b34fb
> > > > > Nest Labs Inc.
> > > > > [bluetooth]# register-service 0000feaf-0000-1000-8000-00805f9b34f=
b
> > > > > [NEW] Primary Service
> > > > > /org/bluez/app/service0x562f48a34e70
> > > > > 0000feaf-0000-1000-8000-00805f9b34fb
> > > > > Nest Labs Inc.
> > > > > [/org/bluez/app/service0x562f48a34e70] Primary (yes/no): yes
> > > > >
> > > > > [bluetooth]# register-characteristic
> > > > > 18ee2ef5-263d-4559-959f-4f9c429f9d11 read,write
> > > > > [NEW] Characteristic
> > > > > /org/bluez/app/service0x562f48a34e70/chrc0x562f48a437c0
> > > > > 18ee2ef5-263d-4559-959f-4f9c429f9d11
> > > > > Vendor specific
> > > > > [/org/bluez/app/service0x562f48a34e70/chrc0x562f48a437c0] Enter v=
alue: 1
> > > > >
> > > > > [bluetooth]# register-application
> > > > > [CHG] Controller 00:AA:01:01:00:24 UUIDs: 00001800-0000-1000-8000=
-00805f9b34fb
> > > > > [CHG] Controller 00:AA:01:01:00:24 UUIDs: 00001801-0000-1000-8000=
-00805f9b34fb
> > > > > [CHG] Controller 00:AA:01:01:00:24 UUIDs: 0000110e-0000-1000-8000=
-00805f9b34fb
> > > > > [CHG] Controller 00:AA:01:01:00:24 UUIDs: 00001200-0000-1000-8000=
-00805f9b34fb
> > > > > [CHG] Controller 00:AA:01:01:00:24 UUIDs: 0000110c-0000-1000-8000=
-00805f9b34fb
> > > > > [CHG] Controller 00:AA:01:01:00:24 UUIDs: 0000feaf-0000-1000-8000=
-00805f9b34fb
> > > > > Application registered
> > > > > [CHG] Controller 00:AA:01:01:00:24 UUIDs: 00001800-0000-1000-8000=
-00805f9b34fb
> > > > > [CHG] Controller 00:AA:01:01:00:24 UUIDs: 00001801-0000-1000-8000=
-00805f9b34fb
> > > > > [CHG] Controller 00:AA:01:01:00:24 UUIDs: 0000110e-0000-1000-8000=
-00805f9b34fb
> > > > > [CHG] Controller 00:AA:01:01:00:24 UUIDs: 00001200-0000-1000-8000=
-00805f9b34fb
> > > > > [CHG] Controller 00:AA:01:01:00:24 UUIDs: 0000110c-0000-1000-8000=
-00805f9b34fb
> > > > > [CHG] Controller 00:AA:01:01:00:24 UUIDs: 0000feaf-0000-1000-8000=
-00805f9b34fb
> > > > > [bluetooth]# back
> > > > >
> > > > > [bluetooth]# advertise peripheral
> > > > > [CHG] Controller 00:AA:01:01:00:24 SupportedInstances: 0x04
> > > > > [CHG] Controller 00:AA:01:01:00:24 ActiveInstances: 0x01
> > > > > Advertising object registered
> > > > > UUID: (FEAF)
> > > > > Tx Power: off
> > > > > LocalName: N0001
> > > > > Apperance: off
> > > > > Discoverable: on
> > > > > [CHG] Controller 00:AA:01:00:00:23 Powered: yes
> > > > > [CHG] Controller 00:AA:01:00:00:23 Discovering: yes
> > > > > [CHG] Controller 00:AA:01:00:00:23 Discovering: no
> > > > > [CHG] Controller 00:AA:01:00:00:23 Discovering: yes
> > > > > [CHG] Device 00:AA:01:00:00:23 Connected: yes
> > > > > [NEW] Primary Service
> > > > > /org/bluez/hci2/dev_00_AA_01_00_00_23/service0006
> > > > > 00001801-0000-1000-8000-00805f9b34fb
> > > > > Generic Attribute Profile
> > > > > [NEW] Characteristic
> > > > > /org/bluez/hci2/dev_00_AA_01_00_00_23/service0006/char0007
> > > > > 00002a05-0000-1000-8000-00805f9b34fb
> > > > > Service Changed
> > > > > [NEW] Descriptor
> > > > > /org/bluez/hci2/dev_00_AA_01_00_00_23/service0006/char0007/desc00=
09
> > > > > 00002902-0000-1000-8000-00805f9b34fb
> > > > > Client Characteristic Configuration
> > > > > [CHG] Device 00:AA:01:00:00:23 ServicesResolved: yes
> > > > >
> > > > >
> > > > > Central:
> > > > >
> > > > > [bluetooth]# select 00:AA:01:00:00:23
> > > > > Discovery stopped
> > > > > [bluetooth]# scan on
> > > > > Discovery started
> > > > > [CHG] Controller 00:AA:01:00:00:23 Discovering: yes
> > > > > [bluetooth]# connect 00:AA:01:01:00:24
> > > > > Attempting to connect to 00:AA:01:01:00:24
> > > > > [CHG] Device 00:AA:01:01:00:24 Connected: yes
> > > > > Connection successful
> > > > > [CHG] Device 00:AA:01:01:00:24 UUIDs: 00001800-0000-1000-8000-008=
05f9b34fb
> > > > > [CHG] Device 00:AA:01:01:00:24 UUIDs: 00001801-0000-1000-8000-008=
05f9b34fb
> > > > > [NEW] Primary Service
> > > > > /org/bluez/hci1/dev_00_AA_01_01_00_24/service0006
> > > > > 00001801-0000-1000-8000-00805f9b34fb
> > > > > Generic Attribute Profile
> > > > > [NEW] Characteristic
> > > > > /org/bluez/hci1/dev_00_AA_01_01_00_24/service0006/char0007
> > > > > 00002a05-0000-1000-8000-00805f9b34fb
> > > > > Service Changed
> > > > > [NEW] Descriptor
> > > > > /org/bluez/hci1/dev_00_AA_01_01_00_24/service0006/char0007/desc00=
09
> > > > > 00002902-0000-1000-8000-00805f9b34fb
> > > > > Client Characteristic Configuration
> > > > > [NEW] Primary Service
> > > > > /org/bluez/hci1/dev_00_AA_01_01_00_24/service000d
> > > > > 0000feaf-0000-1000-8000-00805f9b34fb
> > > > > Nest Labs Inc.
> > > > > [NEW] Characteristic
> > > > > /org/bluez/hci1/dev_00_AA_01_01_00_24/service000d/char000e
> > > > > 18ee2ef5-263d-4559-959f-4f9c429f9d11
> > > > > Vendor specific
> > > > > [CHG] Device 00:AA:01:01:00:24 UUIDs: 00001800-0000-1000-8000-008=
05f9b34fb
> > > > > [CHG] Device 00:AA:01:01:00:24 UUIDs: 00001801-0000-1000-8000-008=
05f9b34fb
> > > > > [CHG] Device 00:AA:01:01:00:24 UUIDs: 0000feaf-0000-1000-8000-008=
05f9b34fb
> > > > > [CHG] Device 00:AA:01:01:00:24 ServicesResolved: yes
> > > > >
> > > > > [N0001]# disconnect 00:AA:01:01:00:24
> > > > > Attempting to disconnect from 00:AA:01:01:00:24
> > > > > [CHG] Device 00:AA:01:01:00:24 ServicesResolved: no
> > > > > Successful disconnected
> > > >
> > > > It should be fixed now, the problem was that the bt_gatt_server was
> > > > set to NULL already thus the bt_att_unregister_disconnect did nothi=
ng,
> > > > Ive might have tested a version were I passed bt_att directly but
> > > > later I changed to use bt_gatt_server to access the bt_att instance
> > > > from btd_device.
> > > >
> > > > >
> > > > > > > It is not for chrome os. I am currently trying bring up bluez=
 version
> > > > > > > from commit in Jan 19 11:37:07 2018 to latest master in Open =
weave
> > > > > > > project(https://github.com/openweave/openweave-core/blob/mast=
er/repos.conf),
> > > > > > > where we are using BLE for weave pairing in iot products, and=
 create
> > > > > > > two GATT characteristics for Tx and Rx and the TCP-like contr=
ol
> > > > > > > protocol  to control BLE packet flow. Periodically I would sy=
nc Bluez
> > > > > > > revision in openweave against Bluez Upstream.
> > > > > >
> > > > > > All major mobile OS support LE L2CAP CoC channels, no idea why
> > > > > > companies want to keep using GATT for emulating serial like
> > > > > > communication special when L2CAP does have support for fragment=
ation
> > > > > > and flow control.
> > > > > >
> > > > > Yes, L2CAP do have support for fragmentation and flow control, bu=
t for
> > > > > some platforms, it may not have bluez, and its L2CAP is not good,=
 then
> > > > > GATT layer fragmentation and flow control is needed. In addition,=
 the
> > > > > L2CAP API is available on neither Android nor iOS when we did thi=
s
> > > > > implementation in the past...then GATT layer fragmentation and fl=
ow
> > > > > control is also needed.
> > > >
> > > > Sure, though moving to L2CAP is a lot simpler... anyway it was just=
 a
> > > > recommendation given that L2CAP is now supported.
> > > >
> > > > > Thanks
> > > > > Best wishes
> > > > > Yunhan
> > > > > > > Thanks
> > > > > > > Best wishes
> > > > > > > Yunhan
> > > > > > >
> > > > > > > On Thu, Oct 25, 2018 at 1:22 PM Luiz Augusto von Dentz
> > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > >
> > > > > > > > Hi Yunhan,
> > > > > > > >
> > > > > > > > On Thu, Oct 25, 2018 at 9:24 PM Luiz Augusto von Dentz
> > > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > Hi Yunhan,
> > > > > > > > >
> > > > > > > > > We might be better of removing the handler altogether and=
 just leave device.c handler instead then.
> > > > > > > > >
> > > > > > > > > On Thu, 25 Oct 2018, 20:19 Yunhan Wang, <yunhanw@google.c=
om> wrote:
> > > > > > > > >>
> > > > > > > > >> Hi, Luiz
> > > > > > > > >>
> > > > > > > > >> Actually before I submit my patch, I tried your way to u=
nregister the
> > > > > > > > >> handler, it is failing. That is why I use random address=
 check in
> > > > > > > > >> btd_gatt_database_att_disconnected to workaround this is=
sue.
> > > > > > > > >>
> > > > > > > > >> Thanks
> > > > > > > > >> Best wishes
> > > > > > > > >> Yunhan
> > > > > > > > >>
> > > > > > > > >>
> > > > > > > > >>
> > > > > > > > >> On Thu, Oct 25, 2018 at 10:49 AM Yunhan Wang <yunhanw@go=
ogle.com> wrote:
> > > > > > > > >> >
> > > > > > > > >> > Hi, Luiz
> > > > > > > > >> >
> > > > > > > > >> > Just have a test with your patch in master branch, bot=
h crashes are
> > > > > > > > >> > still there, and att_disconnected has been called for =
two times even
> > > > > > > > >> > though unregistering the handler....
> > > > > > > >
> > > > > > > > Actually you may be missing the following patch:
> > > > > > > >
> > > > > > > > commit 261cf78db4be79a0f7d44798a57730b159c9be91
> > > > > > > > Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > > > > > Date:   Mon Oct 23 14:13:59 2017 +0300
> > > > > > > >
> > > > > > > >     shared/att: Fix crash when calling disconnect handlers
> > > > > > > >
> > > > > > > > This is quite old btw, what version is Chrome OS shipping?
> > > > > > > >
> > > > > > > > >> > Thanks
> > > > > > > > >> > Best wishes
> > > > > > > > >> > Yunhan
> > > > > > > > >> >
> > > > > > > > >> > Program received signal SIGSEGV, Segmentation fault.
> > > > > > > > >> > btd_adapter_find_device (adapter=3D0x72657664612f6372,
> > > > > > > > >> > dst=3Ddst@entry=3D0x555555872998, bdaddr_type=3D0 '\00=
0')
> > > > > > > > >> >     at bluez/repo/src/adapter.c:845
> > > > > > > > >> > 845 list =3D g_slist_find_custom(adapter->devices, &ad=
dr,
> > > > > > > > >> > (gdb) bt
> > > > > > > > >> > #0  btd_adapter_find_device (adapter=3D0x72657664612f6=
372,
> > > > > > > > >> > dst=3Ddst@entry=3D0x555555872998, bdaddr_type=3D0 '\00=
0')
> > > > > > > > >> >     at bluez/repo/src/adapter.c:845
> > > > > > > > >> > #1  0x00005555555ab890 in att_disconnected (err=3D<opt=
imized out>,
> > > > > > > > >> > user_data=3D0x555555872990)
> > > > > > > > >> >     at bluez/repo/src/gatt-database.c:329
> > > > > > > > >> > #2  0x00005555555eaba8 in queue_foreach (queue=3D0x555=
55585de60,
> > > > > > > > >> > function=3Dfunction@entry=3D0x5555555ee5f0 <disconn_ha=
ndler>,
> > > > > > > > >> > user_data=3D0x68)
> > > > > > > > >> >     at bluez/repo/src/shared/queue.c:220
> > > > > > > > >> > #3  0x00005555555ef819 in disconnect_cb (io=3D<optimiz=
ed out>,
> > > > > > > > >> > user_data=3D0x555555869d50)
> > > > > > > > >> >     at bluez/repo/src/shared/att.c:592
> > > > > > > > >> > #4  0x00005555555f89a3 in watch_callback (channel=3D<o=
ptimized out>,
> > > > > > > > >> > cond=3D<optimized out>, user_data=3D<optimized out>)
> > > > > > > > >> >     at bluez/repo/src/shared/io-glib.c:170
> > > > > > > > >> > #5  0x00007ffff7b0fe35 in g_main_context_dispatch () f=
rom
> > > > > > > > >> > /lib/x86_64-linux-gnu/libglib-2.0.so.0
> > > > > > > > >> > #6  0x00007ffff7b10200 in ?? () from /lib/x86_64-linux=
-gnu/libglib-2.0.so.0
> > > > > > > > >> > #7  0x00007ffff7b10512 in g_main_loop_run () from
> > > > > > > > >> > /lib/x86_64-linux-gnu/libglib-2.0.so.0
> > > > > > > > >> > #8  0x0000555555572238 in main (argc=3D<optimized out>=
, argv=3D<optimized
> > > > > > > > >> > out>) at bluez/repo/src/main.c:808
> > > > > > > > >> >
> > > > > > > > >> >
> > > > > > > > >> > Program received signal SIGSEGV, Segmentation fault.
> > > > > > > > >> > queue_remove (queue=3D0x30, data=3Ddata@entry=3D0x5555=
55873740) at
> > > > > > > > >> > bluez/repo/src/shared/queue.c:256
> > > > > > > > >> > 256 for (entry =3D queue->head, prev =3D NULL; entry;
> > > > > > > > >> > (gdb) bt
> > > > > > > > >> > #0  queue_remove (queue=3D0x30, data=3Ddata@entry=3D0x=
555555873740) at
> > > > > > > > >> > bluez/repo/src/shared/queue.c:256
> > > > > > > > >> > #1  0x00005555555ab8c5 in att_disconnected (err=3D<opt=
imized out>,
> > > > > > > > >> > user_data=3D0x555555873740)
> > > > > > > > >> >     at bluez/repo/src/gatt-database.c:350
> > > > > > > > >> > #2  0x00005555555eabb8 in queue_foreach (queue=3D0x555=
55586e670,
> > > > > > > > >> > function=3Dfunction@entry=3D0x5555555ee600 <disconn_ha=
ndler>,
> > > > > > > > >> > user_data=3D0x68)
> > > > > > > > >> >     at bluez/repo/src/shared/queue.c:220
> > > > > > > > >> > #3  0x00005555555ef829 in disconnect_cb (io=3D<optimiz=
ed out>,
> > > > > > > > >> > user_data=3D0x555555865f50)
> > > > > > > > >> >     at bluez/repo/src/shared/att.c:592
> > > > > > > > >> > #4  0x00005555555f89b3 in watch_callback (channel=3D<o=
ptimized out>,
> > > > > > > > >> > cond=3D<optimized out>, user_data=3D<optimized out>)
> > > > > > > > >> >     at bluez/repo/src/shared/io-glib.c:170
> > > > > > > > >> > #5  0x00007ffff7b0fe35 in g_main_context_dispatch () f=
rom
> > > > > > > > >> > /lib/x86_64-linux-gnu/libglib-2.0.so.0
> > > > > > > > >> > #6  0x00007ffff7b10200 in ?? () from /lib/x86_64-linux=
-gnu/libglib-2.0.so.0
> > > > > > > > >> > #7  0x00007ffff7b10512 in g_main_loop_run () from
> > > > > > > > >> > /lib/x86_64-linux-gnu/libglib-2.0.so.0
> > > > > > > > >> > #8  0x0000555555572238 in main (argc=3D<optimized out>=
, argv=3D<optimized
> > > > > > > > >> > out>) at  bluez/repo/src/main.c:808
> > > > > > > > >> > On Thu, Oct 25, 2018 at 2:20 AM Luiz Augusto von Dentz
> > > > > > > > >> > <luiz.dentz@gmail.com> wrote:
> > > > > > > > >> > >
> > > > > > > > >> > > Hi Yunhan,
> > > > > > > > >> > >
> > > > > > > > >> > > On Thu, Oct 25, 2018 at 4:47 AM Yunhan Wang <yunhanw=
@google.com> wrote:
> > > > > > > > >> > > >
> > > > > > > > >> > > > Hi, Luiz
> > > > > > > > >> > > >
> > > > > > > > >> > > > I am observing the multiple crashes when doing BLE=
 disconnection using
> > > > > > > > >> > > > latest bluez master..It looks like the two att_dis=
connect are
> > > > > > > > >> > > > triggered from your last gatt commit.. Please help=
 take a look at this
> > > > > > > > >> > > > workaround and comments.. the better solution migh=
t be to figure out
> > > > > > > > >> > > > how to handle the disconnection along with random =
address and public
> > > > > > > > >> > > > address together regarding the previous issue, Gat=
t: Subscriptions are
> > > > > > > > >> > > > not cleared after disconnection from a temporary d=
evice
> > > > > > > > >> > >
> > > > > > > > >> > > Ive pushed a similar fix, it should remove the handl=
er before calling
> > > > > > > > >> > > att_disconnected.
> > > > > > > > >> > >
> > > > > > > > >> > > > Thanks
> > > > > > > > >> > > > Best wishes
> > > > > > > > >> > > > Yunhan
> > > > > > > > >> > > > On Wed, Oct 24, 2018 at 5:42 PM yunhanw <yunhanw@g=
oogle.com> wrote:
> > > > > > > > >> > > > >
> > > > > > > > >> > > > > When BLE disconnection happens, att_disconnect i=
s triggered from two locations, the new added location is gatt_server_clean=
up, it would cause several blueetoothd crashes. This bus is introduced from=
 commit 634f0a6e1125af8d5959bff119d9336a8d81c028, where gatt fix, gatt subs=
criptions are not cleared after disconnection from a temporary device with =
private/random address. In order to workaround this issue, btd_gatt_databas=
e_att_disconnected can only be triggered when address type is random, and f=
or others, it can continue to use original disconnect code path.
> > > > > > > > >> > > > >
> > > > > > > > >> > > > >     crash 1
> > > > > > > > >> > > > >     Program received signal SIGSEGV, Segmentatio=
n fault.
> > > > > > > > >> > > > >     queue_remove (queue=3D0x30, data=3Ddata@entr=
y=3D0x555555872a40) at /repo/src/shared/queue.c:256
> > > > > > > > >> > > > >     256     for (entry =3D queue->head, prev =3D=
 NULL; entry;
> > > > > > > > >> > > > >     (gdb) backtrace
> > > > > > > > >> > > > >         at /bluez/repo/src/gatt-database.c:350
> > > > > > > > >> > > > >         at bluez/repo/src/shared/queue.c:220
> > > > > > > > >> > > > >         at bluez/repo/src/shared/att.c:592
> > > > > > > > >> > > > >         at bluez/repo/src/shared/io-glib.c:170
> > > > > > > > >> > > > >
> > > > > > > > >> > > > >     crash 2
> > > > > > > > >> > > > >         at bluez/repo/src/shared/queue.c:220
> > > > > > > > >> > > > >         at bluez/repo/src/shared/att.c:592
> > > > > > > > >> > > > >         at bluez/repo/src/shared/io-glib.c:170
> > > > > > > > >> > > > >
> > > > > > > > >> > > > >     (gdb) print state->db->adapter
> > > > > > > > >> > > > >     Cannot access memory at address 0x61672f6269=
727474
> > > > > > > > >> > > > > ---
> > > > > > > > >> > > > >  src/gatt-database.c | 2 ++
> > > > > > > > >> > > > >  1 file changed, 2 insertions(+)
> > > > > > > > >> > > > >
> > > > > > > > >> > > > > diff --git a/src/gatt-database.c b/src/gatt-data=
base.c
> > > > > > > > >> > > > > index 783b692d5..2f0eb83b5 100644
> > > > > > > > >> > > > > --- a/src/gatt-database.c
> > > > > > > > >> > > > > +++ b/src/gatt-database.c
> > > > > > > > >> > > > > @@ -3365,6 +3365,8 @@ void btd_gatt_database_att=
_disconnected(struct btd_gatt_database *database,
> > > > > > > > >> > > > >
> > > > > > > > >> > > > >         addr =3D device_get_address(device);
> > > > > > > > >> > > > >         type =3D btd_device_get_bdaddr_type(devi=
ce);
> > > > > > > > >> > > > > +    if (type !=3D BDADDR_LE_RANDOM)
> > > > > > > > >> > > > > +        return;
> > > > > > > > >> > > > >
> > > > > > > > >> > > > >         state =3D find_device_state(database, ad=
dr, type);
> > > > > > > > >> > > > >         if (!state)
> > > > > > > > >> > > > > --
> > > > > > > > >> > > > > 2.19.1.568.g152ad8e336-goog
> > > > > > > > >> > > > >
> > > > > > > > >> > >
> > > > > > > > >> > >
> > > > > > > > >> > >
> > > > > > > > >> > > --
> > > > > > > > >> > > Luiz Augusto von Dentz
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > --
> > > > > > > > Luiz Augusto von Dentz
> > > > > >
> > > > > >
> > > > > >
> > > > > > --
> > > > > > Luiz Augusto von Dentz
> > > >
> > > >
> > > >
> > > > --
> > > > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz
