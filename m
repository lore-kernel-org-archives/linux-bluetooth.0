Return-Path: <SRS0=qOEI=NK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6CEC2BC61
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Oct 2018 07:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D5E22082B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Oct 2018 07:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uR5Ug7Uf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D5E22082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbeJ3QOP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Oct 2018 12:14:15 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:36042 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbeJ3QOO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Oct 2018 12:14:14 -0400
Received: by mail-it1-f194.google.com with SMTP id t4-v6so4248094itf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Oct 2018 00:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bfjP1TihitiwAfBBM9DN9sC7fc7sRvZzSXpKyd0Mg/U=;
        b=uR5Ug7Ufh7pOBd3JjnPS6hGIt449OwP+b8q9js6nbf+P76GpIpc6VMREtP38qcHNHL
         05sQoxfsq9cn1PRCsW0h5AVtJQr395MnF9ehxqE/MDQeuICHdPNpfxlIp+mZwd0OwTP+
         EVacZ7RSL+tIiXg9bXuL6zBJKaPXNK7DTq1YjpG0sN/EnbQzjAGr52ZvOGDWGOk1NprH
         9R4pdHSDoYjY28P1HUhRimj/mzh64BWMsGC9R3qYRT3fIrwKsGuG/xO3rJG8GL1Y3Xqj
         RdYuP00bIGCk4Plosl/9+RL2kuRWwC08msB2N/4TGq6akRx9/FEqAGhKFxKZapYLKHw0
         pYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bfjP1TihitiwAfBBM9DN9sC7fc7sRvZzSXpKyd0Mg/U=;
        b=TBsdjX+TmHeKUHkh0N1oC5XuxyxFYn/i/OKESPRRyoLh14F1gOSNCPNdS24K2LGJmM
         LIFe8rZB7hwBNuBtl9I6gEhI2KzU9fx6Lr+8aqWORTqgy7WSOvJR7Tdx60F/NNqmcTgF
         meuY9svSjknVBPp55UIJ+030BJ5Yt8rZZqckkAlCE0foOfQpNIuVY+/51H92NXNg24iE
         E/VBpyxe30woFDoqnJtVYNc4zRbJr39cNXqH665pIwtvKvNtC6eWtHF26WuYXIaIUvNt
         iZ3cOgii9IalM8wkTLq3SYmL84uA4vSJBc/JpKuMNi9245F64LKEv/LWp1hR/mYybqIq
         D2cQ==
X-Gm-Message-State: AGRZ1gKHyetytMv8aBuTFlIU/Sm3HC93q/IgLLmF1DMS3IqEs/2zSYCr
        c7o3NF3/MoCWde/J425hW0ln2gDLs4CFE2dhYmzAEm3l9jb9HQ==
X-Google-Smtp-Source: AJdET5dxwcQT2k+qyQAUvTFogk7EqxzQ09Qjh9Z68yqDBeBIZYv2oiQ/jEszuziZWpmM6edvR+ATquCsWMzLWsy7h54=
X-Received: by 2002:a24:ee46:: with SMTP id b67-v6mr705613iti.19.1540884114711;
 Tue, 30 Oct 2018 00:21:54 -0700 (PDT)
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
 <CABBYNZK67PN5v1GSnCP=_RYkAjy+o_vfPHoTOHywOv9_-+xRiw@mail.gmail.com> <CALvjcs-XMCMQh=Xz2jXYJZO0b0b4MCFWegn_hKmtNHwor+8eUg@mail.gmail.com>
In-Reply-To: <CALvjcs-XMCMQh=Xz2jXYJZO0b0b4MCFWegn_hKmtNHwor+8eUg@mail.gmail.com>
From:   Yunhan Wang <yunhanw@google.com>
Date:   Tue, 30 Oct 2018 00:21:43 -0700
Message-ID: <CALvjcs-J4gpmvdLk4n6uOKGDiJYQSGs6vQjYSnOWmuDDd9UyGg@mail.gmail.com>
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

I am still seeing the bluetoothd crash when disconnect happens on this
issue. Here I reproduce using btvirt and add characteristic with
indicate in ble peripheral, put notify on for this characteristic in
ble central
crash is as below:

#0  __memcmp_sse4_1 () at ../sysdeps/x86_64/multiarch/memcmp-sse4.S:943
#1  0x00005555555cfd3a in bacmp (ba2=3D0x7fffffffdfe9, ba1=3D0xb) at
bluez/repo/lib/bluetooth.h:317
#2  device_addr_type_cmp (a=3D0x0, b=3D0x7fffffffdfe9) at
/bluez/repo/src/device.c:4216
#3  0x00007ffff7b2e3d1 in g_slist_find_custom () from
/lib/x86_64-linux-gnu/libglib-2.0.so.0
#4  0x00005555555bcf18 in btd_adapter_find_device (adapter=3D<optimized
out>, dst=3Ddst@entry=3D0x555555876038, bdaddr_type=3D<optimized out>)
    at bluez/repo/src/adapter.c:845
#5  0x00005555555ab89e in att_disconnected (err=3D<optimized out>,
user_data=3D0x555555876030)
    at bluez/repo/src/gatt-database.c:329
#6  0x00005555555eabb8 in queue_foreach (queue=3D0x555555874460,
function=3Dfunction@entry=3D0x5555555ee600 <disconn_handler>,
user_data=3D0x68)
    at bluez/repo/src/shared/queue.c:220
#7  0x00005555555ef829 in disconnect_cb (io=3D<optimized out>,
user_data=3D0x5555558742a0)
    at /bluez/repo/src/shared/att.c:592
#8  0x00005555555f89b3 in watch_callback (channel=3D<optimized out>,
cond=3D<optimized out>, user_data=3D<optimized out>)
    at /bluez/repo/src/shared/io-glib.c:170
#9  0x00007ffff7b0fe35 in g_main_context_dispatch () from
/lib/x86_64-linux-gnu/libglib-2.0.so.0
#10 0x00007ffff7b10200 in ?? () from /lib/x86_64-linux-gnu/libglib-2.0.so.0
#11 0x00007ffff7b10512 in g_main_loop_run () from
/lib/x86_64-linux-gnu/libglib-2.0.so.0
#12 0x0000555555572238 in main (argc=3D<optimized out>, argv=3D<optimized
out>) at /bluez/repo/src/main.c:808

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
18ee2ef5-263d-4559-959f-4f9c429f9d11 read,indicate
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

[N0001]# select-attribute 00002a05-0000-1000-8000-00805f9b34fb
[CHG] Device 00:AA:01:01:00:24 RSSI: 127
[CHG] Device 00:AA:01:01:00:24 AdvertisingFlags:
  06                                               .
[N0001:/service0006/char0007]# notify on
[CHG] Attribute
/org/bluez/hci1/dev_00_AA_01_01_00_24/service0006/char0007 Notifying:
yes
Notify started


[N0001]# disconnect 00:AA:01:01:00:24
Attempting to disconnect from 00:AA:01:01:00:24
[CHG] Device 00:AA:01:01:00:24 ServicesResolved: no
Successful disconnected


Thanks
Best wishes
Yunhan
On Mon, Oct 29, 2018 at 1:05 PM Yunhan Wang <yunhanw@google.com> wrote:
>
> Hi, Luiz
>
> Great, thanks. It is working now.
>
> Best wishes
> Yunhan
> On Mon, Oct 29, 2018 at 6:28 AM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Yunhan,
> > On Fri, Oct 26, 2018 at 5:00 AM Yunhan Wang <yunhanw@google.com> wrote:
> > >
> > > Hi, Luiz
> > >
> > > On Thu, Oct 25, 2018 at 2:41 PM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > Hi Yunhan,
> > > > On Fri, Oct 26, 2018 at 12:06 AM Yunhan Wang <yunhanw@google.com> w=
rote:
> > > > >
> > > > > Hi, Luiz
> > > > >
> > > > > I am using latest bluez master without any change for this issue,=
 I
> > > > > think I am not missing any changes....The issue is there.
> > > >
> > > > Then we have a problem on bt_att, but that is tracking if the handl=
er
> > > > is removed so I wonder how it is still reproducible for you.
> > > >
> > > It is reproducible using real ble dongles, It is also reproducible
> > > using btvirt.....
> > > Using btvirt -L -l2  and bluetoothctl
> > >
> > > Following the below instructions, when central issue ble disconnectio=
n
> > > to peripheral, the bluetoothd would crash as I show before.
> > >
> > > Peripheral:
> > >
> > > [bluetooth]# select 00:AA:01:01:00:24
> > > Controller 00:AA:01:01:00:24 N0001 [default]
> > > [bluetooth]# system-alias N0001
> > > Changing N0001 succeeded
> > > [bluetooth]# power on
> > > Changing power on succeeded
> > > [bluetooth]# name N0001
> > > [bluetooth]# uuids FEAF
> > > [bluetooth]# discoverable on
> > > [bluetooth]# back
> > > [bluetooth]# register-service 0000feaf-0000-1000-8000-00805f9b34fb
> > > [NEW] Primary Service
> > > /org/bluez/app/service0x562f48a31860
> > > 0000feaf-0000-1000-8000-00805f9b34fb
> > > Nest Labs Inc.
> > > [/org/bluez/app/service0x562f48a31860] Primary (yes/no): yees
> > > Invalid option: yees
> > > [DEL] Primary Service
> > > /org/bluez/app/service0x562f48a31860
> > > 0000feaf-0000-1000-8000-00805f9b34fb
> > > Nest Labs Inc.
> > > [bluetooth]# register-service 0000feaf-0000-1000-8000-00805f9b34fb
> > > [NEW] Primary Service
> > > /org/bluez/app/service0x562f48a34e70
> > > 0000feaf-0000-1000-8000-00805f9b34fb
> > > Nest Labs Inc.
> > > [/org/bluez/app/service0x562f48a34e70] Primary (yes/no): yes
> > >
> > > [bluetooth]# register-characteristic
> > > 18ee2ef5-263d-4559-959f-4f9c429f9d11 read,write
> > > [NEW] Characteristic
> > > /org/bluez/app/service0x562f48a34e70/chrc0x562f48a437c0
> > > 18ee2ef5-263d-4559-959f-4f9c429f9d11
> > > Vendor specific
> > > [/org/bluez/app/service0x562f48a34e70/chrc0x562f48a437c0] Enter value=
: 1
> > >
> > > [bluetooth]# register-application
> > > [CHG] Controller 00:AA:01:01:00:24 UUIDs: 00001800-0000-1000-8000-008=
05f9b34fb
> > > [CHG] Controller 00:AA:01:01:00:24 UUIDs: 00001801-0000-1000-8000-008=
05f9b34fb
> > > [CHG] Controller 00:AA:01:01:00:24 UUIDs: 0000110e-0000-1000-8000-008=
05f9b34fb
> > > [CHG] Controller 00:AA:01:01:00:24 UUIDs: 00001200-0000-1000-8000-008=
05f9b34fb
> > > [CHG] Controller 00:AA:01:01:00:24 UUIDs: 0000110c-0000-1000-8000-008=
05f9b34fb
> > > [CHG] Controller 00:AA:01:01:00:24 UUIDs: 0000feaf-0000-1000-8000-008=
05f9b34fb
> > > Application registered
> > > [CHG] Controller 00:AA:01:01:00:24 UUIDs: 00001800-0000-1000-8000-008=
05f9b34fb
> > > [CHG] Controller 00:AA:01:01:00:24 UUIDs: 00001801-0000-1000-8000-008=
05f9b34fb
> > > [CHG] Controller 00:AA:01:01:00:24 UUIDs: 0000110e-0000-1000-8000-008=
05f9b34fb
> > > [CHG] Controller 00:AA:01:01:00:24 UUIDs: 00001200-0000-1000-8000-008=
05f9b34fb
> > > [CHG] Controller 00:AA:01:01:00:24 UUIDs: 0000110c-0000-1000-8000-008=
05f9b34fb
> > > [CHG] Controller 00:AA:01:01:00:24 UUIDs: 0000feaf-0000-1000-8000-008=
05f9b34fb
> > > [bluetooth]# back
> > >
> > > [bluetooth]# advertise peripheral
> > > [CHG] Controller 00:AA:01:01:00:24 SupportedInstances: 0x04
> > > [CHG] Controller 00:AA:01:01:00:24 ActiveInstances: 0x01
> > > Advertising object registered
> > > UUID: (FEAF)
> > > Tx Power: off
> > > LocalName: N0001
> > > Apperance: off
> > > Discoverable: on
> > > [CHG] Controller 00:AA:01:00:00:23 Powered: yes
> > > [CHG] Controller 00:AA:01:00:00:23 Discovering: yes
> > > [CHG] Controller 00:AA:01:00:00:23 Discovering: no
> > > [CHG] Controller 00:AA:01:00:00:23 Discovering: yes
> > > [CHG] Device 00:AA:01:00:00:23 Connected: yes
> > > [NEW] Primary Service
> > > /org/bluez/hci2/dev_00_AA_01_00_00_23/service0006
> > > 00001801-0000-1000-8000-00805f9b34fb
> > > Generic Attribute Profile
> > > [NEW] Characteristic
> > > /org/bluez/hci2/dev_00_AA_01_00_00_23/service0006/char0007
> > > 00002a05-0000-1000-8000-00805f9b34fb
> > > Service Changed
> > > [NEW] Descriptor
> > > /org/bluez/hci2/dev_00_AA_01_00_00_23/service0006/char0007/desc0009
> > > 00002902-0000-1000-8000-00805f9b34fb
> > > Client Characteristic Configuration
> > > [CHG] Device 00:AA:01:00:00:23 ServicesResolved: yes
> > >
> > >
> > > Central:
> > >
> > > [bluetooth]# select 00:AA:01:00:00:23
> > > Discovery stopped
> > > [bluetooth]# scan on
> > > Discovery started
> > > [CHG] Controller 00:AA:01:00:00:23 Discovering: yes
> > > [bluetooth]# connect 00:AA:01:01:00:24
> > > Attempting to connect to 00:AA:01:01:00:24
> > > [CHG] Device 00:AA:01:01:00:24 Connected: yes
> > > Connection successful
> > > [CHG] Device 00:AA:01:01:00:24 UUIDs: 00001800-0000-1000-8000-00805f9=
b34fb
> > > [CHG] Device 00:AA:01:01:00:24 UUIDs: 00001801-0000-1000-8000-00805f9=
b34fb
> > > [NEW] Primary Service
> > > /org/bluez/hci1/dev_00_AA_01_01_00_24/service0006
> > > 00001801-0000-1000-8000-00805f9b34fb
> > > Generic Attribute Profile
> > > [NEW] Characteristic
> > > /org/bluez/hci1/dev_00_AA_01_01_00_24/service0006/char0007
> > > 00002a05-0000-1000-8000-00805f9b34fb
> > > Service Changed
> > > [NEW] Descriptor
> > > /org/bluez/hci1/dev_00_AA_01_01_00_24/service0006/char0007/desc0009
> > > 00002902-0000-1000-8000-00805f9b34fb
> > > Client Characteristic Configuration
> > > [NEW] Primary Service
> > > /org/bluez/hci1/dev_00_AA_01_01_00_24/service000d
> > > 0000feaf-0000-1000-8000-00805f9b34fb
> > > Nest Labs Inc.
> > > [NEW] Characteristic
> > > /org/bluez/hci1/dev_00_AA_01_01_00_24/service000d/char000e
> > > 18ee2ef5-263d-4559-959f-4f9c429f9d11
> > > Vendor specific
> > > [CHG] Device 00:AA:01:01:00:24 UUIDs: 00001800-0000-1000-8000-00805f9=
b34fb
> > > [CHG] Device 00:AA:01:01:00:24 UUIDs: 00001801-0000-1000-8000-00805f9=
b34fb
> > > [CHG] Device 00:AA:01:01:00:24 UUIDs: 0000feaf-0000-1000-8000-00805f9=
b34fb
> > > [CHG] Device 00:AA:01:01:00:24 ServicesResolved: yes
> > >
> > > [N0001]# disconnect 00:AA:01:01:00:24
> > > Attempting to disconnect from 00:AA:01:01:00:24
> > > [CHG] Device 00:AA:01:01:00:24 ServicesResolved: no
> > > Successful disconnected
> >
> > It should be fixed now, the problem was that the bt_gatt_server was
> > set to NULL already thus the bt_att_unregister_disconnect did nothing,
> > Ive might have tested a version were I passed bt_att directly but
> > later I changed to use bt_gatt_server to access the bt_att instance
> > from btd_device.
> >
> > >
> > > > > It is not for chrome os. I am currently trying bring up bluez ver=
sion
> > > > > from commit in Jan 19 11:37:07 2018 to latest master in Open weav=
e
> > > > > project(https://github.com/openweave/openweave-core/blob/master/r=
epos.conf),
> > > > > where we are using BLE for weave pairing in iot products, and cre=
ate
> > > > > two GATT characteristics for Tx and Rx and the TCP-like control
> > > > > protocol  to control BLE packet flow. Periodically I would sync B=
luez
> > > > > revision in openweave against Bluez Upstream.
> > > >
> > > > All major mobile OS support LE L2CAP CoC channels, no idea why
> > > > companies want to keep using GATT for emulating serial like
> > > > communication special when L2CAP does have support for fragmentatio=
n
> > > > and flow control.
> > > >
> > > Yes, L2CAP do have support for fragmentation and flow control, but fo=
r
> > > some platforms, it may not have bluez, and its L2CAP is not good, the=
n
> > > GATT layer fragmentation and flow control is needed. In addition, the
> > > L2CAP API is available on neither Android nor iOS when we did this
> > > implementation in the past...then GATT layer fragmentation and flow
> > > control is also needed.
> >
> > Sure, though moving to L2CAP is a lot simpler... anyway it was just a
> > recommendation given that L2CAP is now supported.
> >
> > > Thanks
> > > Best wishes
> > > Yunhan
> > > > > Thanks
> > > > > Best wishes
> > > > > Yunhan
> > > > >
> > > > > On Thu, Oct 25, 2018 at 1:22 PM Luiz Augusto von Dentz
> > > > > <luiz.dentz@gmail.com> wrote:
> > > > > >
> > > > > > Hi Yunhan,
> > > > > >
> > > > > > On Thu, Oct 25, 2018 at 9:24 PM Luiz Augusto von Dentz
> > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > >
> > > > > > > Hi Yunhan,
> > > > > > >
> > > > > > > We might be better of removing the handler altogether and jus=
t leave device.c handler instead then.
> > > > > > >
> > > > > > > On Thu, 25 Oct 2018, 20:19 Yunhan Wang, <yunhanw@google.com> =
wrote:
> > > > > > >>
> > > > > > >> Hi, Luiz
> > > > > > >>
> > > > > > >> Actually before I submit my patch, I tried your way to unreg=
ister the
> > > > > > >> handler, it is failing. That is why I use random address che=
ck in
> > > > > > >> btd_gatt_database_att_disconnected to workaround this issue.
> > > > > > >>
> > > > > > >> Thanks
> > > > > > >> Best wishes
> > > > > > >> Yunhan
> > > > > > >>
> > > > > > >>
> > > > > > >>
> > > > > > >> On Thu, Oct 25, 2018 at 10:49 AM Yunhan Wang <yunhanw@google=
.com> wrote:
> > > > > > >> >
> > > > > > >> > Hi, Luiz
> > > > > > >> >
> > > > > > >> > Just have a test with your patch in master branch, both cr=
ashes are
> > > > > > >> > still there, and att_disconnected has been called for two =
times even
> > > > > > >> > though unregistering the handler....
> > > > > >
> > > > > > Actually you may be missing the following patch:
> > > > > >
> > > > > > commit 261cf78db4be79a0f7d44798a57730b159c9be91
> > > > > > Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > > > Date:   Mon Oct 23 14:13:59 2017 +0300
> > > > > >
> > > > > >     shared/att: Fix crash when calling disconnect handlers
> > > > > >
> > > > > > This is quite old btw, what version is Chrome OS shipping?
> > > > > >
> > > > > > >> > Thanks
> > > > > > >> > Best wishes
> > > > > > >> > Yunhan
> > > > > > >> >
> > > > > > >> > Program received signal SIGSEGV, Segmentation fault.
> > > > > > >> > btd_adapter_find_device (adapter=3D0x72657664612f6372,
> > > > > > >> > dst=3Ddst@entry=3D0x555555872998, bdaddr_type=3D0 '\000')
> > > > > > >> >     at bluez/repo/src/adapter.c:845
> > > > > > >> > 845 list =3D g_slist_find_custom(adapter->devices, &addr,
> > > > > > >> > (gdb) bt
> > > > > > >> > #0  btd_adapter_find_device (adapter=3D0x72657664612f6372,
> > > > > > >> > dst=3Ddst@entry=3D0x555555872998, bdaddr_type=3D0 '\000')
> > > > > > >> >     at bluez/repo/src/adapter.c:845
> > > > > > >> > #1  0x00005555555ab890 in att_disconnected (err=3D<optimiz=
ed out>,
> > > > > > >> > user_data=3D0x555555872990)
> > > > > > >> >     at bluez/repo/src/gatt-database.c:329
> > > > > > >> > #2  0x00005555555eaba8 in queue_foreach (queue=3D0x5555558=
5de60,
> > > > > > >> > function=3Dfunction@entry=3D0x5555555ee5f0 <disconn_handle=
r>,
> > > > > > >> > user_data=3D0x68)
> > > > > > >> >     at bluez/repo/src/shared/queue.c:220
> > > > > > >> > #3  0x00005555555ef819 in disconnect_cb (io=3D<optimized o=
ut>,
> > > > > > >> > user_data=3D0x555555869d50)
> > > > > > >> >     at bluez/repo/src/shared/att.c:592
> > > > > > >> > #4  0x00005555555f89a3 in watch_callback (channel=3D<optim=
ized out>,
> > > > > > >> > cond=3D<optimized out>, user_data=3D<optimized out>)
> > > > > > >> >     at bluez/repo/src/shared/io-glib.c:170
> > > > > > >> > #5  0x00007ffff7b0fe35 in g_main_context_dispatch () from
> > > > > > >> > /lib/x86_64-linux-gnu/libglib-2.0.so.0
> > > > > > >> > #6  0x00007ffff7b10200 in ?? () from /lib/x86_64-linux-gnu=
/libglib-2.0.so.0
> > > > > > >> > #7  0x00007ffff7b10512 in g_main_loop_run () from
> > > > > > >> > /lib/x86_64-linux-gnu/libglib-2.0.so.0
> > > > > > >> > #8  0x0000555555572238 in main (argc=3D<optimized out>, ar=
gv=3D<optimized
> > > > > > >> > out>) at bluez/repo/src/main.c:808
> > > > > > >> >
> > > > > > >> >
> > > > > > >> > Program received signal SIGSEGV, Segmentation fault.
> > > > > > >> > queue_remove (queue=3D0x30, data=3Ddata@entry=3D0x55555587=
3740) at
> > > > > > >> > bluez/repo/src/shared/queue.c:256
> > > > > > >> > 256 for (entry =3D queue->head, prev =3D NULL; entry;
> > > > > > >> > (gdb) bt
> > > > > > >> > #0  queue_remove (queue=3D0x30, data=3Ddata@entry=3D0x5555=
55873740) at
> > > > > > >> > bluez/repo/src/shared/queue.c:256
> > > > > > >> > #1  0x00005555555ab8c5 in att_disconnected (err=3D<optimiz=
ed out>,
> > > > > > >> > user_data=3D0x555555873740)
> > > > > > >> >     at bluez/repo/src/gatt-database.c:350
> > > > > > >> > #2  0x00005555555eabb8 in queue_foreach (queue=3D0x5555558=
6e670,
> > > > > > >> > function=3Dfunction@entry=3D0x5555555ee600 <disconn_handle=
r>,
> > > > > > >> > user_data=3D0x68)
> > > > > > >> >     at bluez/repo/src/shared/queue.c:220
> > > > > > >> > #3  0x00005555555ef829 in disconnect_cb (io=3D<optimized o=
ut>,
> > > > > > >> > user_data=3D0x555555865f50)
> > > > > > >> >     at bluez/repo/src/shared/att.c:592
> > > > > > >> > #4  0x00005555555f89b3 in watch_callback (channel=3D<optim=
ized out>,
> > > > > > >> > cond=3D<optimized out>, user_data=3D<optimized out>)
> > > > > > >> >     at bluez/repo/src/shared/io-glib.c:170
> > > > > > >> > #5  0x00007ffff7b0fe35 in g_main_context_dispatch () from
> > > > > > >> > /lib/x86_64-linux-gnu/libglib-2.0.so.0
> > > > > > >> > #6  0x00007ffff7b10200 in ?? () from /lib/x86_64-linux-gnu=
/libglib-2.0.so.0
> > > > > > >> > #7  0x00007ffff7b10512 in g_main_loop_run () from
> > > > > > >> > /lib/x86_64-linux-gnu/libglib-2.0.so.0
> > > > > > >> > #8  0x0000555555572238 in main (argc=3D<optimized out>, ar=
gv=3D<optimized
> > > > > > >> > out>) at  bluez/repo/src/main.c:808
> > > > > > >> > On Thu, Oct 25, 2018 at 2:20 AM Luiz Augusto von Dentz
> > > > > > >> > <luiz.dentz@gmail.com> wrote:
> > > > > > >> > >
> > > > > > >> > > Hi Yunhan,
> > > > > > >> > >
> > > > > > >> > > On Thu, Oct 25, 2018 at 4:47 AM Yunhan Wang <yunhanw@goo=
gle.com> wrote:
> > > > > > >> > > >
> > > > > > >> > > > Hi, Luiz
> > > > > > >> > > >
> > > > > > >> > > > I am observing the multiple crashes when doing BLE dis=
connection using
> > > > > > >> > > > latest bluez master..It looks like the two att_disconn=
ect are
> > > > > > >> > > > triggered from your last gatt commit.. Please help tak=
e a look at this
> > > > > > >> > > > workaround and comments.. the better solution might be=
 to figure out
> > > > > > >> > > > how to handle the disconnection along with random addr=
ess and public
> > > > > > >> > > > address together regarding the previous issue, Gatt: S=
ubscriptions are
> > > > > > >> > > > not cleared after disconnection from a temporary devic=
e
> > > > > > >> > >
> > > > > > >> > > Ive pushed a similar fix, it should remove the handler b=
efore calling
> > > > > > >> > > att_disconnected.
> > > > > > >> > >
> > > > > > >> > > > Thanks
> > > > > > >> > > > Best wishes
> > > > > > >> > > > Yunhan
> > > > > > >> > > > On Wed, Oct 24, 2018 at 5:42 PM yunhanw <yunhanw@googl=
e.com> wrote:
> > > > > > >> > > > >
> > > > > > >> > > > > When BLE disconnection happens, att_disconnect is tr=
iggered from two locations, the new added location is gatt_server_cleanup, =
it would cause several blueetoothd crashes. This bus is introduced from com=
mit 634f0a6e1125af8d5959bff119d9336a8d81c028, where gatt fix, gatt subscrip=
tions are not cleared after disconnection from a temporary device with priv=
ate/random address. In order to workaround this issue, btd_gatt_database_at=
t_disconnected can only be triggered when address type is random, and for o=
thers, it can continue to use original disconnect code path.
> > > > > > >> > > > >
> > > > > > >> > > > >     crash 1
> > > > > > >> > > > >     Program received signal SIGSEGV, Segmentation fa=
ult.
> > > > > > >> > > > >     queue_remove (queue=3D0x30, data=3Ddata@entry=3D=
0x555555872a40) at /repo/src/shared/queue.c:256
> > > > > > >> > > > >     256     for (entry =3D queue->head, prev =3D NUL=
L; entry;
> > > > > > >> > > > >     (gdb) backtrace
> > > > > > >> > > > >         at /bluez/repo/src/gatt-database.c:350
> > > > > > >> > > > >         at bluez/repo/src/shared/queue.c:220
> > > > > > >> > > > >         at bluez/repo/src/shared/att.c:592
> > > > > > >> > > > >         at bluez/repo/src/shared/io-glib.c:170
> > > > > > >> > > > >
> > > > > > >> > > > >     crash 2
> > > > > > >> > > > >         at bluez/repo/src/shared/queue.c:220
> > > > > > >> > > > >         at bluez/repo/src/shared/att.c:592
> > > > > > >> > > > >         at bluez/repo/src/shared/io-glib.c:170
> > > > > > >> > > > >
> > > > > > >> > > > >     (gdb) print state->db->adapter
> > > > > > >> > > > >     Cannot access memory at address 0x61672f62697274=
74
> > > > > > >> > > > > ---
> > > > > > >> > > > >  src/gatt-database.c | 2 ++
> > > > > > >> > > > >  1 file changed, 2 insertions(+)
> > > > > > >> > > > >
> > > > > > >> > > > > diff --git a/src/gatt-database.c b/src/gatt-database=
.c
> > > > > > >> > > > > index 783b692d5..2f0eb83b5 100644
> > > > > > >> > > > > --- a/src/gatt-database.c
> > > > > > >> > > > > +++ b/src/gatt-database.c
> > > > > > >> > > > > @@ -3365,6 +3365,8 @@ void btd_gatt_database_att_dis=
connected(struct btd_gatt_database *database,
> > > > > > >> > > > >
> > > > > > >> > > > >         addr =3D device_get_address(device);
> > > > > > >> > > > >         type =3D btd_device_get_bdaddr_type(device);
> > > > > > >> > > > > +    if (type !=3D BDADDR_LE_RANDOM)
> > > > > > >> > > > > +        return;
> > > > > > >> > > > >
> > > > > > >> > > > >         state =3D find_device_state(database, addr, =
type);
> > > > > > >> > > > >         if (!state)
> > > > > > >> > > > > --
> > > > > > >> > > > > 2.19.1.568.g152ad8e336-goog
> > > > > > >> > > > >
> > > > > > >> > >
> > > > > > >> > >
> > > > > > >> > >
> > > > > > >> > > --
> > > > > > >> > > Luiz Augusto von Dentz
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
> >
> >
> >
> > --
> > Luiz Augusto von Dentz
