Return-Path: <SRS0=5QOG=NF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00CBC46475
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Oct 2018 17:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC8F2084A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Oct 2018 17:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HfCm4hrT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC8F2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbeJZCXX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Oct 2018 22:23:23 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:55647 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbeJZCXW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Oct 2018 22:23:22 -0400
Received: by mail-it1-f194.google.com with SMTP id c23-v6so2656572itd.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Oct 2018 10:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xIUoAyas1HBlhpL38Jblxeu9x4OXZt+HE0iAYN+M9UM=;
        b=HfCm4hrTBl06k7IWeB9hgXn3py/42ymDPh0q5JsquwU9jdzFVG3iWYW01fnnqqNC00
         2oeh9Ub2rDVoUQRaCJR2siQHdXickR82TT9ZCRL4X9GLIQSgiYuKUw6Bb7EEJwg/c/M2
         rDvLEq0noLNwOcpSmphB4L32eW84x2N1PYO4ovELeeWXcJRZCOUYeTkwQ6fs/sy5URgC
         xjsLg3D1PvACr838L3uItBL7NF1yu7sJYCk0iHqQ+3vO7VAYrfEDrQkN6MoW5OsxWBP2
         eXLuNPQaSYxghe2gzySCTdMVcJE2gAqb7ajLnJGW4fVcS9gYi3oxV2YXugj+2hHKLns/
         ysLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xIUoAyas1HBlhpL38Jblxeu9x4OXZt+HE0iAYN+M9UM=;
        b=ZRILj5tb3XUrJ/p8/56NVZUfZ/5/nhDwrnxHZQIZmhAuk6fRnxEr1iie/cwB5sw+Aa
         ZUg0RLE1BYHgA0aP0tl6GJyei0+wMMsgPNXo6lSvP9Kr/Rfyjlz62TsL/ZYZWeB5qNun
         dPeeYhoJTU1LflDri5HsTLtYq3XukCqJ0Fa9AB/a0vL0J3ShaqGu/3/NUg/go7I/kbvv
         Rq7H1OvcuDtieRqJLXQALdHcbm0BcRpUlY4SgXXhF4doFVW+FmeFTLJloaMwJEJAPHIY
         CT89MUq/jEZYg0ZR2yGWAZpwBJnxTmfBMUrjRVMEIE2awS5EjCCMF0ItDydNYue/Gkg2
         oCBQ==
X-Gm-Message-State: AGRZ1gIeqXxf+38LVib2ctLKD6yvCLrMaobsIP8gOIGCf933qwXgFdaG
        iExkHvlaaqA7rUFSpjJcPmA7JeEYXJIq6rumVes4aw==
X-Google-Smtp-Source: AJdET5cuVJiT+gd17P5BV1Ndjsugc2iPt8ySEoIj0LQFueq6cEQSAOWa/5/AAFwgYx87/58jSE7SECQ6UZCvFHT3o+I=
X-Received: by 2002:a24:2e4e:: with SMTP id i75-v6mr1614064ita.72.1540489774499;
 Thu, 25 Oct 2018 10:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <20181025004210.177441-1-yunhanw@google.com> <CALvjcs83c2B0aq7Vz8WU4DC=ikQfB5W_XfYh+S_rkydi=6agMw@mail.gmail.com>
 <CABBYNZ+5i=tv-dcnMr+21D28NZL9ayWVTLkC8DfWQA9jZUWXQg@mail.gmail.com>
In-Reply-To: <CABBYNZ+5i=tv-dcnMr+21D28NZL9ayWVTLkC8DfWQA9jZUWXQg@mail.gmail.com>
From:   Yunhan Wang <yunhanw@google.com>
Date:   Thu, 25 Oct 2018 10:49:22 -0700
Message-ID: <CALvjcs_-_DuXJWt8zWj4wH32Dz2w41UdPKxfOqQ5ZwA-gqO1mw@mail.gmail.com>
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

Just have a test with your patch in master branch, both crashes are
still there, and att_disconnected has been called for two times even
though unregistering the handler....

Thanks
Best wishes
Yunhan

Program received signal SIGSEGV, Segmentation fault.
btd_adapter_find_device (adapter=3D0x72657664612f6372,
dst=3Ddst@entry=3D0x555555872998, bdaddr_type=3D0 '\000')
    at bluez/repo/src/adapter.c:845
845 list =3D g_slist_find_custom(adapter->devices, &addr,
(gdb) bt
#0  btd_adapter_find_device (adapter=3D0x72657664612f6372,
dst=3Ddst@entry=3D0x555555872998, bdaddr_type=3D0 '\000')
    at bluez/repo/src/adapter.c:845
#1  0x00005555555ab890 in att_disconnected (err=3D<optimized out>,
user_data=3D0x555555872990)
    at bluez/repo/src/gatt-database.c:329
#2  0x00005555555eaba8 in queue_foreach (queue=3D0x55555585de60,
function=3Dfunction@entry=3D0x5555555ee5f0 <disconn_handler>,
user_data=3D0x68)
    at bluez/repo/src/shared/queue.c:220
#3  0x00005555555ef819 in disconnect_cb (io=3D<optimized out>,
user_data=3D0x555555869d50)
    at bluez/repo/src/shared/att.c:592
#4  0x00005555555f89a3 in watch_callback (channel=3D<optimized out>,
cond=3D<optimized out>, user_data=3D<optimized out>)
    at bluez/repo/src/shared/io-glib.c:170
#5  0x00007ffff7b0fe35 in g_main_context_dispatch () from
/lib/x86_64-linux-gnu/libglib-2.0.so.0
#6  0x00007ffff7b10200 in ?? () from /lib/x86_64-linux-gnu/libglib-2.0.so.0
#7  0x00007ffff7b10512 in g_main_loop_run () from
/lib/x86_64-linux-gnu/libglib-2.0.so.0
#8  0x0000555555572238 in main (argc=3D<optimized out>, argv=3D<optimized
out>) at bluez/repo/src/main.c:808


Program received signal SIGSEGV, Segmentation fault.
queue_remove (queue=3D0x30, data=3Ddata@entry=3D0x555555873740) at
bluez/repo/src/shared/queue.c:256
256 for (entry =3D queue->head, prev =3D NULL; entry;
(gdb) bt
#0  queue_remove (queue=3D0x30, data=3Ddata@entry=3D0x555555873740) at
bluez/repo/src/shared/queue.c:256
#1  0x00005555555ab8c5 in att_disconnected (err=3D<optimized out>,
user_data=3D0x555555873740)
    at bluez/repo/src/gatt-database.c:350
#2  0x00005555555eabb8 in queue_foreach (queue=3D0x55555586e670,
function=3Dfunction@entry=3D0x5555555ee600 <disconn_handler>,
user_data=3D0x68)
    at bluez/repo/src/shared/queue.c:220
#3  0x00005555555ef829 in disconnect_cb (io=3D<optimized out>,
user_data=3D0x555555865f50)
    at bluez/repo/src/shared/att.c:592
#4  0x00005555555f89b3 in watch_callback (channel=3D<optimized out>,
cond=3D<optimized out>, user_data=3D<optimized out>)
    at bluez/repo/src/shared/io-glib.c:170
#5  0x00007ffff7b0fe35 in g_main_context_dispatch () from
/lib/x86_64-linux-gnu/libglib-2.0.so.0
#6  0x00007ffff7b10200 in ?? () from /lib/x86_64-linux-gnu/libglib-2.0.so.0
#7  0x00007ffff7b10512 in g_main_loop_run () from
/lib/x86_64-linux-gnu/libglib-2.0.so.0
#8  0x0000555555572238 in main (argc=3D<optimized out>, argv=3D<optimized
out>) at  bluez/repo/src/main.c:808
On Thu, Oct 25, 2018 at 2:20 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Yunhan,
>
> On Thu, Oct 25, 2018 at 4:47 AM Yunhan Wang <yunhanw@google.com> wrote:
> >
> > Hi, Luiz
> >
> > I am observing the multiple crashes when doing BLE disconnection using
> > latest bluez master..It looks like the two att_disconnect are
> > triggered from your last gatt commit.. Please help take a look at this
> > workaround and comments.. the better solution might be to figure out
> > how to handle the disconnection along with random address and public
> > address together regarding the previous issue, Gatt: Subscriptions are
> > not cleared after disconnection from a temporary device
>
> Ive pushed a similar fix, it should remove the handler before calling
> att_disconnected.
>
> > Thanks
> > Best wishes
> > Yunhan
> > On Wed, Oct 24, 2018 at 5:42 PM yunhanw <yunhanw@google.com> wrote:
> > >
> > > When BLE disconnection happens, att_disconnect is triggered from two =
locations, the new added location is gatt_server_cleanup, it would cause se=
veral blueetoothd crashes. This bus is introduced from commit 634f0a6e1125a=
f8d5959bff119d9336a8d81c028, where gatt fix, gatt subscriptions are not cle=
ared after disconnection from a temporary device with private/random addres=
s. In order to workaround this issue, btd_gatt_database_att_disconnected ca=
n only be triggered when address type is random, and for others, it can con=
tinue to use original disconnect code path.
> > >
> > >     crash 1
> > >     Program received signal SIGSEGV, Segmentation fault.
> > >     queue_remove (queue=3D0x30, data=3Ddata@entry=3D0x555555872a40) a=
t /repo/src/shared/queue.c:256
> > >     256     for (entry =3D queue->head, prev =3D NULL; entry;
> > >     (gdb) backtrace
> > >         at /bluez/repo/src/gatt-database.c:350
> > >         at bluez/repo/src/shared/queue.c:220
> > >         at bluez/repo/src/shared/att.c:592
> > >         at bluez/repo/src/shared/io-glib.c:170
> > >
> > >     crash 2
> > >         at bluez/repo/src/shared/queue.c:220
> > >         at bluez/repo/src/shared/att.c:592
> > >         at bluez/repo/src/shared/io-glib.c:170
> > >
> > >     (gdb) print state->db->adapter
> > >     Cannot access memory at address 0x61672f6269727474
> > > ---
> > >  src/gatt-database.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/src/gatt-database.c b/src/gatt-database.c
> > > index 783b692d5..2f0eb83b5 100644
> > > --- a/src/gatt-database.c
> > > +++ b/src/gatt-database.c
> > > @@ -3365,6 +3365,8 @@ void btd_gatt_database_att_disconnected(struct =
btd_gatt_database *database,
> > >
> > >         addr =3D device_get_address(device);
> > >         type =3D btd_device_get_bdaddr_type(device);
> > > +    if (type !=3D BDADDR_LE_RANDOM)
> > > +        return;
> > >
> > >         state =3D find_device_state(database, addr, type);
> > >         if (!state)
> > > --
> > > 2.19.1.568.g152ad8e336-goog
> > >
>
>
>
> --
> Luiz Augusto von Dentz
