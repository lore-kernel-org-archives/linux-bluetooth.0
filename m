Return-Path: <SRS0=5QOG=NF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55314C46475
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Oct 2018 21:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB3E02075D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Oct 2018 21:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VBlxKpo8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB3E02075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbeJZFkS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Oct 2018 01:40:18 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:55281 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbeJZFkS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Oct 2018 01:40:18 -0400
Received: by mail-it1-f196.google.com with SMTP id l191-v6so3320399ita.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Oct 2018 14:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HEi96lRiQKsJnkZfSFgbZLyJfzVG0jKm+aYT8qIRfUk=;
        b=VBlxKpo8dqfe0H8NXvKM45qpCswZG1HwiMjz44bTkaIQr+K7BwRnrc6E4ZJxc5owEZ
         /nEMM6eWJue5MVsGxQlCPMYPDcMJntZiVY3AHTvisIDb2+VV06n+HVJXS4NAnW2T3x6/
         xSE+6Qyxa7hZKi57jk26K9dqiMeszSqZ1pq2T+CLsnmPyz6eH3aIfAQWiyGndprzuosa
         6W48l/0zfywHvFM7s6av21zfhqRJCOx/tF6c8Que9MY0XPA3WIQnMMp7j2O53KEPHYfI
         WRD0wph45rsB7sznRRfybHB7YRtG9SZCXUa/cOIMyRpLwPw43Keqrs1hUslXv7QzmQIN
         YDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HEi96lRiQKsJnkZfSFgbZLyJfzVG0jKm+aYT8qIRfUk=;
        b=UJC9bgC4+aEQay6OPZfcBTX8uTEj2CcU+k7JrAeZVYdcHvOeJ7JDbNCWc8nJjlolxe
         5JlKuOsBoad2WxRYYzOSACSCVbp2P4a/53ysCp/u02BpCuTeg9i3zXs6xjiRnkvQzCJQ
         AIk2QGq7AoMv0dhC3l3qsuw+Q5UY4pAS6ZUv9E7DX7iJZsHDzuBM6CBwsJaAa43FXY0A
         GR2k0mQ9OwnVHB3PKj6T0cH7IT62CxzZHamAow70PiPniN/voN3bcSsVG+7KCLq8a6Vk
         N8OPMTWmPCNWOSheS65nBooBDWxf5SnNkh/YmvdqdGvPJBDrp3M81T0vCys1QDg5Zn9G
         5Vhg==
X-Gm-Message-State: AGRZ1gLlT5b3hIB2FbTCVXGzn3PeOstqqy7/gUqCcN+YKcZNZkhztycr
        u6xdOpr9Bm5JKDxm96vkMJR6fQPZ+oRM18qGA9hE8g==
X-Google-Smtp-Source: AJdET5f3IUTHYMedxvxDe+yN5XdlLUU+EJV7BwhTWXF4oh7lLOC4GdDuiiFgk9aRom+EPALIDZaXg/jy9cUxOgIbzmM=
X-Received: by 2002:a24:2e4e:: with SMTP id i75-v6mr2029022ita.72.1540501559308;
 Thu, 25 Oct 2018 14:05:59 -0700 (PDT)
MIME-Version: 1.0
References: <20181025004210.177441-1-yunhanw@google.com> <CALvjcs83c2B0aq7Vz8WU4DC=ikQfB5W_XfYh+S_rkydi=6agMw@mail.gmail.com>
 <CABBYNZ+5i=tv-dcnMr+21D28NZL9ayWVTLkC8DfWQA9jZUWXQg@mail.gmail.com>
 <CALvjcs_-_DuXJWt8zWj4wH32Dz2w41UdPKxfOqQ5ZwA-gqO1mw@mail.gmail.com>
 <CALvjcs_YPhcg4GEVvRrsnS=auzzA_=AxmFt_Nx2UO5Rw1rY0cg@mail.gmail.com>
 <CABBYNZ+YKck9btAU=qkohHT0C__RF-0pf2vK2eF14XB8K6x9WQ@mail.gmail.com> <CABBYNZKQ_jFUA7PBuW_oc3eU22SV4hyy4nBeSEDNtWTk+mWhnw@mail.gmail.com>
In-Reply-To: <CABBYNZKQ_jFUA7PBuW_oc3eU22SV4hyy4nBeSEDNtWTk+mWhnw@mail.gmail.com>
From:   Yunhan Wang <yunhanw@google.com>
Date:   Thu, 25 Oct 2018 14:05:47 -0700
Message-ID: <CALvjcs9_ssfyVGjfg8b836_D=poy-W1F16uLNXZ=1_8rAK9b-A@mail.gmail.com>
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

I am using latest bluez master without any change for this issue, I
think I am not missing any changes....The issue is there.

It is not for chrome os. I am currently trying bring up bluez version
from commit in Jan 19 11:37:07 2018 to latest master in Open weave
project(https://github.com/openweave/openweave-core/blob/master/repos.conf)=
,
where we are using BLE for weave pairing in iot products, and create
two GATT characteristics for Tx and Rx and the TCP-like control
protocol  to control BLE packet flow. Periodically I would sync Bluez
revision in openweave against Bluez Upstream.

Thanks
Best wishes
Yunhan

On Thu, Oct 25, 2018 at 1:22 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Yunhan,
>
> On Thu, Oct 25, 2018 at 9:24 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Yunhan,
> >
> > We might be better of removing the handler altogether and just leave de=
vice.c handler instead then.
> >
> > On Thu, 25 Oct 2018, 20:19 Yunhan Wang, <yunhanw@google.com> wrote:
> >>
> >> Hi, Luiz
> >>
> >> Actually before I submit my patch, I tried your way to unregister the
> >> handler, it is failing. That is why I use random address check in
> >> btd_gatt_database_att_disconnected to workaround this issue.
> >>
> >> Thanks
> >> Best wishes
> >> Yunhan
> >>
> >>
> >>
> >> On Thu, Oct 25, 2018 at 10:49 AM Yunhan Wang <yunhanw@google.com> wrot=
e:
> >> >
> >> > Hi, Luiz
> >> >
> >> > Just have a test with your patch in master branch, both crashes are
> >> > still there, and att_disconnected has been called for two times even
> >> > though unregistering the handler....
>
> Actually you may be missing the following patch:
>
> commit 261cf78db4be79a0f7d44798a57730b159c9be91
> Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Date:   Mon Oct 23 14:13:59 2017 +0300
>
>     shared/att: Fix crash when calling disconnect handlers
>
> This is quite old btw, what version is Chrome OS shipping?
>
> >> > Thanks
> >> > Best wishes
> >> > Yunhan
> >> >
> >> > Program received signal SIGSEGV, Segmentation fault.
> >> > btd_adapter_find_device (adapter=3D0x72657664612f6372,
> >> > dst=3Ddst@entry=3D0x555555872998, bdaddr_type=3D0 '\000')
> >> >     at bluez/repo/src/adapter.c:845
> >> > 845 list =3D g_slist_find_custom(adapter->devices, &addr,
> >> > (gdb) bt
> >> > #0  btd_adapter_find_device (adapter=3D0x72657664612f6372,
> >> > dst=3Ddst@entry=3D0x555555872998, bdaddr_type=3D0 '\000')
> >> >     at bluez/repo/src/adapter.c:845
> >> > #1  0x00005555555ab890 in att_disconnected (err=3D<optimized out>,
> >> > user_data=3D0x555555872990)
> >> >     at bluez/repo/src/gatt-database.c:329
> >> > #2  0x00005555555eaba8 in queue_foreach (queue=3D0x55555585de60,
> >> > function=3Dfunction@entry=3D0x5555555ee5f0 <disconn_handler>,
> >> > user_data=3D0x68)
> >> >     at bluez/repo/src/shared/queue.c:220
> >> > #3  0x00005555555ef819 in disconnect_cb (io=3D<optimized out>,
> >> > user_data=3D0x555555869d50)
> >> >     at bluez/repo/src/shared/att.c:592
> >> > #4  0x00005555555f89a3 in watch_callback (channel=3D<optimized out>,
> >> > cond=3D<optimized out>, user_data=3D<optimized out>)
> >> >     at bluez/repo/src/shared/io-glib.c:170
> >> > #5  0x00007ffff7b0fe35 in g_main_context_dispatch () from
> >> > /lib/x86_64-linux-gnu/libglib-2.0.so.0
> >> > #6  0x00007ffff7b10200 in ?? () from /lib/x86_64-linux-gnu/libglib-2=
.0.so.0
> >> > #7  0x00007ffff7b10512 in g_main_loop_run () from
> >> > /lib/x86_64-linux-gnu/libglib-2.0.so.0
> >> > #8  0x0000555555572238 in main (argc=3D<optimized out>, argv=3D<opti=
mized
> >> > out>) at bluez/repo/src/main.c:808
> >> >
> >> >
> >> > Program received signal SIGSEGV, Segmentation fault.
> >> > queue_remove (queue=3D0x30, data=3Ddata@entry=3D0x555555873740) at
> >> > bluez/repo/src/shared/queue.c:256
> >> > 256 for (entry =3D queue->head, prev =3D NULL; entry;
> >> > (gdb) bt
> >> > #0  queue_remove (queue=3D0x30, data=3Ddata@entry=3D0x555555873740) =
at
> >> > bluez/repo/src/shared/queue.c:256
> >> > #1  0x00005555555ab8c5 in att_disconnected (err=3D<optimized out>,
> >> > user_data=3D0x555555873740)
> >> >     at bluez/repo/src/gatt-database.c:350
> >> > #2  0x00005555555eabb8 in queue_foreach (queue=3D0x55555586e670,
> >> > function=3Dfunction@entry=3D0x5555555ee600 <disconn_handler>,
> >> > user_data=3D0x68)
> >> >     at bluez/repo/src/shared/queue.c:220
> >> > #3  0x00005555555ef829 in disconnect_cb (io=3D<optimized out>,
> >> > user_data=3D0x555555865f50)
> >> >     at bluez/repo/src/shared/att.c:592
> >> > #4  0x00005555555f89b3 in watch_callback (channel=3D<optimized out>,
> >> > cond=3D<optimized out>, user_data=3D<optimized out>)
> >> >     at bluez/repo/src/shared/io-glib.c:170
> >> > #5  0x00007ffff7b0fe35 in g_main_context_dispatch () from
> >> > /lib/x86_64-linux-gnu/libglib-2.0.so.0
> >> > #6  0x00007ffff7b10200 in ?? () from /lib/x86_64-linux-gnu/libglib-2=
.0.so.0
> >> > #7  0x00007ffff7b10512 in g_main_loop_run () from
> >> > /lib/x86_64-linux-gnu/libglib-2.0.so.0
> >> > #8  0x0000555555572238 in main (argc=3D<optimized out>, argv=3D<opti=
mized
> >> > out>) at  bluez/repo/src/main.c:808
> >> > On Thu, Oct 25, 2018 at 2:20 AM Luiz Augusto von Dentz
> >> > <luiz.dentz@gmail.com> wrote:
> >> > >
> >> > > Hi Yunhan,
> >> > >
> >> > > On Thu, Oct 25, 2018 at 4:47 AM Yunhan Wang <yunhanw@google.com> w=
rote:
> >> > > >
> >> > > > Hi, Luiz
> >> > > >
> >> > > > I am observing the multiple crashes when doing BLE disconnection=
 using
> >> > > > latest bluez master..It looks like the two att_disconnect are
> >> > > > triggered from your last gatt commit.. Please help take a look a=
t this
> >> > > > workaround and comments.. the better solution might be to figure=
 out
> >> > > > how to handle the disconnection along with random address and pu=
blic
> >> > > > address together regarding the previous issue, Gatt: Subscriptio=
ns are
> >> > > > not cleared after disconnection from a temporary device
> >> > >
> >> > > Ive pushed a similar fix, it should remove the handler before call=
ing
> >> > > att_disconnected.
> >> > >
> >> > > > Thanks
> >> > > > Best wishes
> >> > > > Yunhan
> >> > > > On Wed, Oct 24, 2018 at 5:42 PM yunhanw <yunhanw@google.com> wro=
te:
> >> > > > >
> >> > > > > When BLE disconnection happens, att_disconnect is triggered fr=
om two locations, the new added location is gatt_server_cleanup, it would c=
ause several blueetoothd crashes. This bus is introduced from commit 634f0a=
6e1125af8d5959bff119d9336a8d81c028, where gatt fix, gatt subscriptions are =
not cleared after disconnection from a temporary device with private/random=
 address. In order to workaround this issue, btd_gatt_database_att_disconne=
cted can only be triggered when address type is random, and for others, it =
can continue to use original disconnect code path.
> >> > > > >
> >> > > > >     crash 1
> >> > > > >     Program received signal SIGSEGV, Segmentation fault.
> >> > > > >     queue_remove (queue=3D0x30, data=3Ddata@entry=3D0x55555587=
2a40) at /repo/src/shared/queue.c:256
> >> > > > >     256     for (entry =3D queue->head, prev =3D NULL; entry;
> >> > > > >     (gdb) backtrace
> >> > > > >         at /bluez/repo/src/gatt-database.c:350
> >> > > > >         at bluez/repo/src/shared/queue.c:220
> >> > > > >         at bluez/repo/src/shared/att.c:592
> >> > > > >         at bluez/repo/src/shared/io-glib.c:170
> >> > > > >
> >> > > > >     crash 2
> >> > > > >         at bluez/repo/src/shared/queue.c:220
> >> > > > >         at bluez/repo/src/shared/att.c:592
> >> > > > >         at bluez/repo/src/shared/io-glib.c:170
> >> > > > >
> >> > > > >     (gdb) print state->db->adapter
> >> > > > >     Cannot access memory at address 0x61672f6269727474
> >> > > > > ---
> >> > > > >  src/gatt-database.c | 2 ++
> >> > > > >  1 file changed, 2 insertions(+)
> >> > > > >
> >> > > > > diff --git a/src/gatt-database.c b/src/gatt-database.c
> >> > > > > index 783b692d5..2f0eb83b5 100644
> >> > > > > --- a/src/gatt-database.c
> >> > > > > +++ b/src/gatt-database.c
> >> > > > > @@ -3365,6 +3365,8 @@ void btd_gatt_database_att_disconnected(=
struct btd_gatt_database *database,
> >> > > > >
> >> > > > >         addr =3D device_get_address(device);
> >> > > > >         type =3D btd_device_get_bdaddr_type(device);
> >> > > > > +    if (type !=3D BDADDR_LE_RANDOM)
> >> > > > > +        return;
> >> > > > >
> >> > > > >         state =3D find_device_state(database, addr, type);
> >> > > > >         if (!state)
> >> > > > > --
> >> > > > > 2.19.1.568.g152ad8e336-goog
> >> > > > >
> >> > >
> >> > >
> >> > >
> >> > > --
> >> > > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz
