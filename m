Return-Path: <SRS0=qOEI=NK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38C4C2BC61
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Oct 2018 15:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B92C2075D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Oct 2018 15:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N9etKdMm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B92C2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbeJaA3z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Oct 2018 20:29:55 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:52502 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbeJaA3y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Oct 2018 20:29:54 -0400
Received: by mail-it1-f193.google.com with SMTP id r5-v6so12239977ith.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Oct 2018 08:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dRju8zgybtkeQw4y23CDa6NSSwC1WEeHbI6p29cxEfg=;
        b=N9etKdMmRUCI21+x3bQTwtwhUljZFQtqYGz08mLTnzFWJFbGEVMk8DZGoYBiIYO0Dl
         fXA6smWlkVrdjnuzHBnE+Bu7qDCny83AAqu0ObZO6Uwzd876urixMCihcZyTGj4Vc2Ko
         rO9YPYO0YGHzX0YIcJ/pUmEMZ2b/t4u406hIqcdiRMM+1J5wFB5NMX9s/f9KREpZIJkl
         cusL5siH1QFrYKGxmCg2UPAx3y6PWoZEpnyWJw454JbAhrjs0kcwB23KAXjwb/9j8YHv
         LjEbaEX705UQBoQRU+2vipWYsGH2oeimsons5TkD+K2TtVmsOce09x3Ig2mTIBG6mpY0
         tj9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dRju8zgybtkeQw4y23CDa6NSSwC1WEeHbI6p29cxEfg=;
        b=Jn1IEsLTi30B6lfl6p7hk1AuznZGDC2bSA3oSUsNf8MQoWOxpHYM7JRAqSDpPP9tGD
         /7IFjVBES/DE8BcWYP/IsLyGHpfCrd/YZWcy4ljUa8MZpjS5zdmK3JmdfqnDOn0mR9Oe
         TzWg/g//ZxFbRC2IdE+NrBLiEJU7J5SgtH5gOpnU4qHpgB6tKdBqKidF5MRVwcqOLp/U
         jBXbXjQHuFWWhsekZUsLtxIdpo+MtxXlXMIdfpLXqCp7PctYfdvtLD0NSDpRhUP2HVVQ
         lkp03OdWyo/EnN0L8r+zplxR0f2ErITFi1cWMdWByuErHr7bryaZgkt7DjP+gbcQAPGS
         ZbEQ==
X-Gm-Message-State: AGRZ1gKc6N5Zf9/OWrOLM/l5+5iD/2yA76b8wkamlk+4xYVzXejDVH5W
        604Plg2Ms/4R9ncvBbnnMwz8OscPQtp5QY4Ubr6TVRn3P3s=
X-Google-Smtp-Source: AJdET5fMvTJh1jxpkf0VyJs9YegGOi8c6CNQ3Bv/QxafUCz6EZ0P+g/iSJl26Uvxy7q2hNUwUXquKdhRRPs++rZw/lg=
X-Received: by 2002:a02:3547:: with SMTP id y7-v6mr14546777jae.26.1540913756476;
 Tue, 30 Oct 2018 08:35:56 -0700 (PDT)
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
 <CALvjcs-J4gpmvdLk4n6uOKGDiJYQSGs6vQjYSnOWmuDDd9UyGg@mail.gmail.com>
 <CABBYNZLd_ms7SbjEx2t_a52KVwBDVJMhVhv8YXM=Dvw8tq5WjA@mail.gmail.com>
 <CALvjcs9OH3sH+mMyfrxAVROesF=Ok1i2n9J7QR45OBAzP2OE8g@mail.gmail.com> <CABBYNZLS+uMCv+DsWS4oddfhd8jNi_q2iFUFrVDAZ2h-fPoKLg@mail.gmail.com>
In-Reply-To: <CABBYNZLS+uMCv+DsWS4oddfhd8jNi_q2iFUFrVDAZ2h-fPoKLg@mail.gmail.com>
From:   Yunhan Wang <yunhanw@google.com>
Date:   Tue, 30 Oct 2018 08:35:44 -0700
Message-ID: <CALvjcs_XJZz5r-RZF4XquSjifdz9T0bMaUehioyzq1f3iBhQ_g@mail.gmail.com>
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

I think somehow I fail to rebase to your latest change, now this issue
goes away.

Thanks
Best wishes
Yunhan
On Tue, Oct 30, 2018 at 8:06 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Yunhan,
> On Tue, Oct 30, 2018 at 5:02 PM Yunhan Wang <yunhanw@google.com> wrote:
> >
> > Hi, Luiz
> > On Tue, Oct 30, 2018 at 5:52 AM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Yunhan,
> > >
> > > On Tue, Oct 30, 2018 at 9:21 AM Yunhan Wang <yunhanw@google.com> wrot=
e:
> > > >
> > > > Hi, Luiz
> > > >
> > > > I am still seeing the bluetoothd crash when disconnect happens on t=
his
> > > > issue. Here I reproduce using btvirt and add characteristic with
> > > > indicate in ble peripheral, put notify on for this characteristic i=
n
> > > > ble central
> > > > crash is as below:
> > > >
> > > > #0  __memcmp_sse4_1 () at ../sysdeps/x86_64/multiarch/memcmp-sse4.S=
:943
> > > > #1  0x00005555555cfd3a in bacmp (ba2=3D0x7fffffffdfe9, ba1=3D0xb) a=
t
> > > > bluez/repo/lib/bluetooth.h:317
> > > > #2  device_addr_type_cmp (a=3D0x0, b=3D0x7fffffffdfe9) at
> > > > /bluez/repo/src/device.c:4216
> > > > #3  0x00007ffff7b2e3d1 in g_slist_find_custom () from
> > > > /lib/x86_64-linux-gnu/libglib-2.0.so.0
> > > > #4  0x00005555555bcf18 in btd_adapter_find_device (adapter=3D<optim=
ized
> > > > out>, dst=3Ddst@entry=3D0x555555876038, bdaddr_type=3D<optimized ou=
t>)
> > > >     at bluez/repo/src/adapter.c:845
> > > > #5  0x00005555555ab89e in att_disconnected (err=3D<optimized out>,
> > > > user_data=3D0x555555876030)
> > > >     at bluez/repo/src/gatt-database.c:329
> > > > #6  0x00005555555eabb8 in queue_foreach (queue=3D0x555555874460,
> > > > function=3Dfunction@entry=3D0x5555555ee600 <disconn_handler>,
> > > > user_data=3D0x68)
> > > >     at bluez/repo/src/shared/queue.c:220
> > > > #7  0x00005555555ef829 in disconnect_cb (io=3D<optimized out>,
> > > > user_data=3D0x5555558742a0)
> > > >     at /bluez/repo/src/shared/att.c:592
> > > > #8  0x00005555555f89b3 in watch_callback (channel=3D<optimized out>=
,
> > > > cond=3D<optimized out>, user_data=3D<optimized out>)
> > > >     at /bluez/repo/src/shared/io-glib.c:170
> > > > #9  0x00007ffff7b0fe35 in g_main_context_dispatch () from
> > > > /lib/x86_64-linux-gnu/libglib-2.0.so.0
> > > > #10 0x00007ffff7b10200 in ?? () from /lib/x86_64-linux-gnu/libglib-=
2.0.so.0
> > > > #11 0x00007ffff7b10512 in g_main_loop_run () from
> > > > /lib/x86_64-linux-gnu/libglib-2.0.so.0
> > > > #12 0x0000555555572238 in main (argc=3D<optimized out>, argv=3D<opt=
imized
> > > > out>) at /bluez/repo/src/main.c:808
> > > >
> > > > Peripheral:
> > > >
> > > > [bluetooth]# select 00:AA:01:01:00:24
> > > > Controller 00:AA:01:01:00:24 N0001 [default]
> > > > [bluetooth]# system-alias N0001
> > > > Changing N0001 succeeded
> > > > [bluetooth]# power on
> > > > Changing power on succeeded
> > > > [bluetooth]# name N0001
> > > > [bluetooth]# uuids FEAF
> > > > [bluetooth]# discoverable on
> > >
> > > Hmm, are you connecting over BR/EDR, normally you would need to
> > > advertise in order to connect? I guess I haven't tried that, but at
> > > least with LE Im pretty sure it doesn't crash anymore, it is worth
> > > checking if it is not connecting on multiple bearers at the same time
> > > though.
> > >
> > No, I am not connecting over BR/EDR, i am only using LE. I am
> > consistently reproducing this issue using btvirt using the
> > instructions here, the additional thing I have done is to add
> > characteristic with indicate and notify on, without this additional
> > setting, you will not see the crash.
> >
> > > > [bluetooth]# back
> > > > [bluetooth]# register-service 0000feaf-0000-1000-8000-00805f9b34fb
> > > > [NEW] Primary Service
> > > > /org/bluez/app/service0x562f48a31860
> > > > 0000feaf-0000-1000-8000-00805f9b34fb
> > > > Nest Labs Inc.
> > > > [/org/bluez/app/service0x562f48a31860] Primary (yes/no): yees
> > > > Invalid option: yees
> > > > [DEL] Primary Service
> > > > /org/bluez/app/service0x562f48a31860
> > > > 0000feaf-0000-1000-8000-00805f9b34fb
> > > > Nest Labs Inc.
> > > > [bluetooth]# register-service 0000feaf-0000-1000-8000-00805f9b34fb
> > > > [NEW] Primary Service
> > > > /org/bluez/app/service0x562f48a34e70
> > > > 0000feaf-0000-1000-8000-00805f9b34fb
> > > > Nest Labs Inc.
> > > > [/org/bluez/app/service0x562f48a34e70] Primary (yes/no): yes
> > > >
> > > > [bluetooth]# register-characteristic
> > > > 18ee2ef5-263d-4559-959f-4f9c429f9d11 read,indicate
> > > > [NEW] Characteristic
> > > > /org/bluez/app/service0x562f48a34e70/chrc0x562f48a437c0
> > > > 18ee2ef5-263d-4559-959f-4f9c429f9d11
> > > > Vendor specific
> > > > [/org/bluez/app/service0x562f48a34e70/chrc0x562f48a437c0] Enter val=
ue: 1
> > > >
> > Indicate is here
> >
> > > > [bluetooth]# register-application
> > > > [CHG] Controller 00:AA:01:01:00:24 UUIDs: 00001800-0000-1000-8000-0=
0805f9b34fb
> > > > [CHG] Controller 00:AA:01:01:00:24 UUIDs: 00001801-0000-1000-8000-0=
0805f9b34fb
> > > > [CHG] Controller 00:AA:01:01:00:24 UUIDs: 0000110e-0000-1000-8000-0=
0805f9b34fb
> > > > [CHG] Controller 00:AA:01:01:00:24 UUIDs: 00001200-0000-1000-8000-0=
0805f9b34fb
> > > > [CHG] Controller 00:AA:01:01:00:24 UUIDs: 0000110c-0000-1000-8000-0=
0805f9b34fb
> > > > [CHG] Controller 00:AA:01:01:00:24 UUIDs: 0000feaf-0000-1000-8000-0=
0805f9b34fb
> > > > Application registered
> > > > [CHG] Controller 00:AA:01:01:00:24 UUIDs: 00001800-0000-1000-8000-0=
0805f9b34fb
> > > > [CHG] Controller 00:AA:01:01:00:24 UUIDs: 00001801-0000-1000-8000-0=
0805f9b34fb
> > > > [CHG] Controller 00:AA:01:01:00:24 UUIDs: 0000110e-0000-1000-8000-0=
0805f9b34fb
> > > > [CHG] Controller 00:AA:01:01:00:24 UUIDs: 00001200-0000-1000-8000-0=
0805f9b34fb
> > > > [CHG] Controller 00:AA:01:01:00:24 UUIDs: 0000110c-0000-1000-8000-0=
0805f9b34fb
> > > > [CHG] Controller 00:AA:01:01:00:24 UUIDs: 0000feaf-0000-1000-8000-0=
0805f9b34fb
> > > > [bluetooth]# back
> > > >
> > > > [bluetooth]# advertise peripheral
> > > > [CHG] Controller 00:AA:01:01:00:24 SupportedInstances: 0x04
> > > > [CHG] Controller 00:AA:01:01:00:24 ActiveInstances: 0x01
> > > > Advertising object registered
> > advertise peripheral is here
> >
> > > > UUID: (FEAF)
> > > > Tx Power: off
> > > > LocalName: N0001
> > > > Apperance: off
> > > > Discoverable: on
> > > > [CHG] Controller 00:AA:01:00:00:23 Powered: yes
> > > > [CHG] Controller 00:AA:01:00:00:23 Discovering: yes
> > > > [CHG] Controller 00:AA:01:00:00:23 Discovering: no
> > > > [CHG] Controller 00:AA:01:00:00:23 Discovering: yes
> > > > [CHG] Device 00:AA:01:00:00:23 Connected: yes
> > > > [NEW] Primary Service
> > > > /org/bluez/hci2/dev_00_AA_01_00_00_23/service0006
> > > > 00001801-0000-1000-8000-00805f9b34fb
> > > > Generic Attribute Profile
> > > > [NEW] Characteristic
> > > > /org/bluez/hci2/dev_00_AA_01_00_00_23/service0006/char0007
> > > > 00002a05-0000-1000-8000-00805f9b34fb
> > > > Service Changed
> > > > [NEW] Descriptor
> > > > /org/bluez/hci2/dev_00_AA_01_00_00_23/service0006/char0007/desc0009
> > > > 00002902-0000-1000-8000-00805f9b34fb
> > > > Client Characteristic Configuration
> > > > [CHG] Device 00:AA:01:00:00:23 ServicesResolved: yes
> > > >
> > > >
> > > > Central:
> > > >
> > > > [bluetooth]# select 00:AA:01:00:00:23
> > > > Discovery stopped
> > > > [bluetooth]# scan on
> > > > Discovery started
> > > > [CHG] Controller 00:AA:01:00:00:23 Discovering: yes
> > > > [bluetooth]# connect 00:AA:01:01:00:24
> > > > Attempting to connect to 00:AA:01:01:00:24
> > > > [CHG] Device 00:AA:01:01:00:24 Connected: yes
> > > > Connection successful
> > > > [CHG] Device 00:AA:01:01:00:24 UUIDs: 00001800-0000-1000-8000-00805=
f9b34fb
> > > > [CHG] Device 00:AA:01:01:00:24 UUIDs: 00001801-0000-1000-8000-00805=
f9b34fb
> > > > [NEW] Primary Service
> > > > /org/bluez/hci1/dev_00_AA_01_01_00_24/service0006
> > > > 00001801-0000-1000-8000-00805f9b34fb
> > > > Generic Attribute Profile
> > > > [NEW] Characteristic
> > > > /org/bluez/hci1/dev_00_AA_01_01_00_24/service0006/char0007
> > > > 00002a05-0000-1000-8000-00805f9b34fb
> > > > Service Changed
> > > > [NEW] Descriptor
> > > > /org/bluez/hci1/dev_00_AA_01_01_00_24/service0006/char0007/desc0009
> > > > 00002902-0000-1000-8000-00805f9b34fb
> > > > Client Characteristic Configuration
> > > > [NEW] Primary Service
> > > > /org/bluez/hci1/dev_00_AA_01_01_00_24/service000d
> > > > 0000feaf-0000-1000-8000-00805f9b34fb
> > > > Nest Labs Inc.
> > > > [NEW] Characteristic
> > > > /org/bluez/hci1/dev_00_AA_01_01_00_24/service000d/char000e
> > > > 18ee2ef5-263d-4559-959f-4f9c429f9d11
> > > > Vendor specific
> > > > [CHG] Device 00:AA:01:01:00:24 UUIDs: 00001800-0000-1000-8000-00805=
f9b34fb
> > > > [CHG] Device 00:AA:01:01:00:24 UUIDs: 00001801-0000-1000-8000-00805=
f9b34fb
> > > > [CHG] Device 00:AA:01:01:00:24 UUIDs: 0000feaf-0000-1000-8000-00805=
f9b34fb
> > > > [CHG] Device 00:AA:01:01:00:24 ServicesResolved: yes
> > > >
> > > > [N0001]# select-attribute 00002a05-0000-1000-8000-00805f9b34fb
> > > > [CHG] Device 00:AA:01:01:00:24 RSSI: 127
> > > > [CHG] Device 00:AA:01:01:00:24 AdvertisingFlags:
> > > >   06                                               .
> > > > [N0001:/service0006/char0007]# notify on
> > > > [CHG] Attribute
> > > > /org/bluez/hci1/dev_00_AA_01_01_00_24/service0006/char0007 Notifyin=
g:
> > > > yes
> > > > Notify started
> > notify on is here
> > > >
> > > >
> > > > [N0001]# disconnect 00:AA:01:01:00:24
> > > > Attempting to disconnect from 00:AA:01:01:00:24
> > > > [CHG] Device 00:AA:01:01:00:24 ServicesResolved: no
> > > > Successful disconnected
> > >
> > > After this all I got was:
> > >
> > > bluetoothd[31908]: src/gatt-client.c:btd_gatt_client_disconnected()
> > > Device disconnected. Cleaning up.
> > > bluetoothd[31908]: src/device.c:att_disconnected_cb() Automatic
> > > connection disabled
> > > bluetoothd[31908]: src/gatt-database.c:btd_gatt_database_att_disconne=
cted()
> > > bluetoothd[31908]: src/gatt-database.c:att_disconnected()
> > > bluetoothd[31908]: attrib/gattrib.c:g_attrib_unref() 0x99b3ba0: g_att=
rib_unref=3D0
> > >
> > Have you setup =E2=80=98indicate=E2=80=99 and =E2=80=98notify on =E2=80=
=98 in your steps?
>
> Yep, Im adding exactly the same service and attribute connecting and
> enabling indication here:
>
> https://gist.github.com/Vudentz/8fe3d85a0df9b1dfaf829db6f3588ede
>
> The only difference is that Im using real controllers so perhaps it is
> only really reproducible with btvirt, but we should fix it either way.
>
>
>
>
> --
> Luiz Augusto von Dentz
