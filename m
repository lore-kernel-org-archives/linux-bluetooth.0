Return-Path: <SRS0=qOEI=NK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A1FC2BC61
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Oct 2018 15:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3EB2205F4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Oct 2018 15:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6CZnHQO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3EB2205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbeJaAAi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Oct 2018 20:00:38 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46310 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbeJaAAi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Oct 2018 20:00:38 -0400
Received: by mail-oi1-f194.google.com with SMTP id k64-v6so10662983oia.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Oct 2018 08:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jYI0OGdKiphy2+uZzkRHHUERhIPqazFZ08QPOMX6DHw=;
        b=m6CZnHQOACBs2DcXAvK2VTiRdgR03dpBGE8wLOOu+mHMaSyE4IkW6RJPx05rQ/JDmC
         WUR9Z4C2yL+M/gq9onKelGR9hC3NzjY24+wKkoKPHn+LqRECZmnjwA39qlAXl9FW91LC
         htq0k20gkpvhGgiqXPMxQJD9EDPY4FDW2ke1QuVQKlzqcng9MnaroVrmJiS8zo3tOC+9
         lHFEjyyEX5PJLf8VX2Uuo6v1lmGJRnbjMSHpkqksYQ/ylsuMaYErodjqx/IfH7J+i4x/
         0O++Z/mkE6EyZP01UCyRXs1JjXyHRpetJh6tlk/sw15BGZwlZnlPBAgBu4Fsa02H1qG6
         h4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jYI0OGdKiphy2+uZzkRHHUERhIPqazFZ08QPOMX6DHw=;
        b=ff3HJH9SJutpHdLfZVni4vPUBoRpBlo9hMHlDqalnTMz7XXkAnYQafx1B4QBQ79Xfv
         2w1KaWW1uMXYNy00O9HaI9ivmynOcd6jTVCoxslJOAmTwDkZJfJBNYSArac/HGMo7+bj
         E9eXr2MkDR/G0eSEzYpX1Ak2cCtCHpfnnx0qUkWjuyNB5b5jSsmF8CshlSPEW2IZfgR1
         tpl6YuE83LlSw/CqFINrP26kDGbFx88lxX+4gks0WH88exaVcK6bjTQh0VAwDSf3815M
         8Z8/cqN89YpAnwGDKVlLy6U8UWHK7TDphrx684GPcs4+rMcmzC0wJPWHRzuz/ot+RnkU
         /0gg==
X-Gm-Message-State: AGRZ1gJ8mCZUJ/QR06RK4bCUo+EQVfRZsxwSH1dL4XonglF1MZmxkHqx
        DLjuQeTEM9D/u2ixuZpxB1EGyTm/DjY/FRFUpZw=
X-Google-Smtp-Source: AJdET5cQnNevQx2384mV4TdYy9wBTogkggyt2kBMq6apzxtc011sjsAWTeVQTDs6q7zUTz2u4WD5Rj+h7i90TPtRRc0=
X-Received: by 2002:a54:409a:: with SMTP id i26-v6mr834701oii.251.1540912006386;
 Tue, 30 Oct 2018 08:06:46 -0700 (PDT)
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
 <CABBYNZLd_ms7SbjEx2t_a52KVwBDVJMhVhv8YXM=Dvw8tq5WjA@mail.gmail.com> <CALvjcs9OH3sH+mMyfrxAVROesF=Ok1i2n9J7QR45OBAzP2OE8g@mail.gmail.com>
In-Reply-To: <CALvjcs9OH3sH+mMyfrxAVROesF=Ok1i2n9J7QR45OBAzP2OE8g@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 30 Oct 2018 17:06:34 +0200
Message-ID: <CABBYNZLS+uMCv+DsWS4oddfhd8jNi_q2iFUFrVDAZ2h-fPoKLg@mail.gmail.com>
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
On Tue, Oct 30, 2018 at 5:02 PM Yunhan Wang <yunhanw@google.com> wrote:
>
> Hi, Luiz
> On Tue, Oct 30, 2018 at 5:52 AM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Yunhan,
> >
> > On Tue, Oct 30, 2018 at 9:21 AM Yunhan Wang <yunhanw@google.com> wrote:
> > >
> > > Hi, Luiz
> > >
> > > I am still seeing the bluetoothd crash when disconnect happens on thi=
s
> > > issue. Here I reproduce using btvirt and add characteristic with
> > > indicate in ble peripheral, put notify on for this characteristic in
> > > ble central
> > > crash is as below:
> > >
> > > #0  __memcmp_sse4_1 () at ../sysdeps/x86_64/multiarch/memcmp-sse4.S:9=
43
> > > #1  0x00005555555cfd3a in bacmp (ba2=3D0x7fffffffdfe9, ba1=3D0xb) at
> > > bluez/repo/lib/bluetooth.h:317
> > > #2  device_addr_type_cmp (a=3D0x0, b=3D0x7fffffffdfe9) at
> > > /bluez/repo/src/device.c:4216
> > > #3  0x00007ffff7b2e3d1 in g_slist_find_custom () from
> > > /lib/x86_64-linux-gnu/libglib-2.0.so.0
> > > #4  0x00005555555bcf18 in btd_adapter_find_device (adapter=3D<optimiz=
ed
> > > out>, dst=3Ddst@entry=3D0x555555876038, bdaddr_type=3D<optimized out>=
)
> > >     at bluez/repo/src/adapter.c:845
> > > #5  0x00005555555ab89e in att_disconnected (err=3D<optimized out>,
> > > user_data=3D0x555555876030)
> > >     at bluez/repo/src/gatt-database.c:329
> > > #6  0x00005555555eabb8 in queue_foreach (queue=3D0x555555874460,
> > > function=3Dfunction@entry=3D0x5555555ee600 <disconn_handler>,
> > > user_data=3D0x68)
> > >     at bluez/repo/src/shared/queue.c:220
> > > #7  0x00005555555ef829 in disconnect_cb (io=3D<optimized out>,
> > > user_data=3D0x5555558742a0)
> > >     at /bluez/repo/src/shared/att.c:592
> > > #8  0x00005555555f89b3 in watch_callback (channel=3D<optimized out>,
> > > cond=3D<optimized out>, user_data=3D<optimized out>)
> > >     at /bluez/repo/src/shared/io-glib.c:170
> > > #9  0x00007ffff7b0fe35 in g_main_context_dispatch () from
> > > /lib/x86_64-linux-gnu/libglib-2.0.so.0
> > > #10 0x00007ffff7b10200 in ?? () from /lib/x86_64-linux-gnu/libglib-2.=
0.so.0
> > > #11 0x00007ffff7b10512 in g_main_loop_run () from
> > > /lib/x86_64-linux-gnu/libglib-2.0.so.0
> > > #12 0x0000555555572238 in main (argc=3D<optimized out>, argv=3D<optim=
ized
> > > out>) at /bluez/repo/src/main.c:808
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
> >
> > Hmm, are you connecting over BR/EDR, normally you would need to
> > advertise in order to connect? I guess I haven't tried that, but at
> > least with LE Im pretty sure it doesn't crash anymore, it is worth
> > checking if it is not connecting on multiple bearers at the same time
> > though.
> >
> No, I am not connecting over BR/EDR, i am only using LE. I am
> consistently reproducing this issue using btvirt using the
> instructions here, the additional thing I have done is to add
> characteristic with indicate and notify on, without this additional
> setting, you will not see the crash.
>
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
> > > 18ee2ef5-263d-4559-959f-4f9c429f9d11 read,indicate
> > > [NEW] Characteristic
> > > /org/bluez/app/service0x562f48a34e70/chrc0x562f48a437c0
> > > 18ee2ef5-263d-4559-959f-4f9c429f9d11
> > > Vendor specific
> > > [/org/bluez/app/service0x562f48a34e70/chrc0x562f48a437c0] Enter value=
: 1
> > >
> Indicate is here
>
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
> advertise peripheral is here
>
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
> > > [N0001]# select-attribute 00002a05-0000-1000-8000-00805f9b34fb
> > > [CHG] Device 00:AA:01:01:00:24 RSSI: 127
> > > [CHG] Device 00:AA:01:01:00:24 AdvertisingFlags:
> > >   06                                               .
> > > [N0001:/service0006/char0007]# notify on
> > > [CHG] Attribute
> > > /org/bluez/hci1/dev_00_AA_01_01_00_24/service0006/char0007 Notifying:
> > > yes
> > > Notify started
> notify on is here
> > >
> > >
> > > [N0001]# disconnect 00:AA:01:01:00:24
> > > Attempting to disconnect from 00:AA:01:01:00:24
> > > [CHG] Device 00:AA:01:01:00:24 ServicesResolved: no
> > > Successful disconnected
> >
> > After this all I got was:
> >
> > bluetoothd[31908]: src/gatt-client.c:btd_gatt_client_disconnected()
> > Device disconnected. Cleaning up.
> > bluetoothd[31908]: src/device.c:att_disconnected_cb() Automatic
> > connection disabled
> > bluetoothd[31908]: src/gatt-database.c:btd_gatt_database_att_disconnect=
ed()
> > bluetoothd[31908]: src/gatt-database.c:att_disconnected()
> > bluetoothd[31908]: attrib/gattrib.c:g_attrib_unref() 0x99b3ba0: g_attri=
b_unref=3D0
> >
> Have you setup =E2=80=98indicate=E2=80=99 and =E2=80=98notify on =E2=80=
=98 in your steps?

Yep, Im adding exactly the same service and attribute connecting and
enabling indication here:

https://gist.github.com/Vudentz/8fe3d85a0df9b1dfaf829db6f3588ede

The only difference is that Im using real controllers so perhaps it is
only really reproducible with btvirt, but we should fix it either way.




--=20
Luiz Augusto von Dentz
