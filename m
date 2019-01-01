Return-Path: <SRS0=uf0v=PJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC753C43387
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Jan 2019 19:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A98B0208E3
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Jan 2019 19:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BExvHwvV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfAAT11 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Jan 2019 14:27:27 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36286 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfAAT11 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Jan 2019 14:27:27 -0500
Received: by mail-ot1-f66.google.com with SMTP id k98so25362863otk.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Jan 2019 11:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CJJJsHLnDidVHXTq3/DbNsbODjQwXvFw4okmZMT54Ss=;
        b=BExvHwvV2AnJV5boaKZyfzAKfzGDGwdRC7nRc9GbkSpyOTUGYQ9aLDWM3S1Eohez4+
         hTDA3752Z+jKVluvtg1M/St4TRN38PpuG6nfOMZDx0WApoJ5Q13vL742frzyT5OX8tOF
         i49YQbBL5jXJgty6v/ImU5iuSfPI1Bp9tOjbp1juKFxzrvTKk3hY3NzQzKgT7oRpMoyU
         WPI4X1biiGCujSiAWKDyxg0bjvlG+BxYpHje+EnWGG/SRHTmsZqttifKRJKDaEKRPfEA
         C+YFPF9eT6GStmZztfEhCOjlkwNvF4cKAry6g/sZnL6oJ2rrJ4wmySkhJ9lc7UwmXXPw
         7WeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CJJJsHLnDidVHXTq3/DbNsbODjQwXvFw4okmZMT54Ss=;
        b=FBm/dgtwloZonaq7VJ65CGUARmUFPy+rtieMmusCfNI62eY7OGNK7/wZqhmzBK0kOg
         j3CNE765owyJi1A27hp1xB8izTRdS5ap1L+uYOaDnkBazmcyexiNvOVe/fbOaSV7aNzq
         LVFzLwORJozQ4WlnW8qZlXV5HsNNDTfiNlt2MyNjKJ1kMEvEp1gheNj++hQPcJdj2ZfJ
         4VPOKACsfpkfQFLRMsCBwhibR0QyHft5z3yPP9lG9Igdl2I+qRWIScEP+ocTEO4R4BNC
         8YT6hTAdasj0F5uMKSy72yV1JEKVyQNUWyUragXvyCmcdwOeiNjp3HM99J5cs+EaKMPG
         Z7tQ==
X-Gm-Message-State: AJcUukdUsUnBuZBYvLVvmr+WyZy7FZdQN/LQUS4M+bEy0BU5O9s6evmB
        aRjvEN6MP43swWTUbIzYHtXg1ujoNeLvvfmQcsgWJXra
X-Google-Smtp-Source: ALg8bN4EFsplu1yEcLW6Fr4EOZsWe2kVo6nRg284CZjm7RRQRirEvh6yZek3TrmLOLPt94n5rw9cE/Q/Gg5U8b623pA=
X-Received: by 2002:a9d:7749:: with SMTP id t9mr30292091otl.342.1546370845086;
 Tue, 01 Jan 2019 11:27:25 -0800 (PST)
MIME-Version: 1.0
References: <20181119154311.27826-1-luiz.dentz@gmail.com> <CABBYNZK90H=0e4GKo1g96jYkg3EM+5C2DhbCvi-Cgtd8W+E3YA@mail.gmail.com>
 <CAHotPr_8M4H_6sLV+BK02QBKLwwAn0cEOFhyoMN5F0=_gY1dHQ@mail.gmail.com>
 <CABBYNZJNM2SpM2w3kwuLw1FfXcoSZfyO02xCJAgdx-BBPyw7-w@mail.gmail.com>
 <CAHotPr8nQYJkN30pTncQfx-SGgmUgTs582_q_MAiLi=bEFYO9w@mail.gmail.com>
 <CABBYNZJzpPd+ZfJRTyCnicr8jApj_YW31qZhUDxSk_PgKiPZKg@mail.gmail.com>
 <CAHotPr8pvbCOoYHVz-k4NU-prmtkq2bZOFN5V_GjCebte5HBtg@mail.gmail.com>
 <CAHotPr8MyEwqATiL+4CHfTJ-40Df3cjm60CptT6wh-0GTpFgOg@mail.gmail.com>
 <CABBYNZKGjNYc7WBWrN9XHnLaYmOk0x981MB9XGqk8EQArMZeMg@mail.gmail.com>
 <CAHotPr89aB+bsuMxF3S+jQk-oJp=6XM=AeTqGC78aQ7Xg38NQQ@mail.gmail.com> <CAHotPr9tdmnFhZLX2utqFxeXUx_0G0AYsfwKrmktV4USbfBcyw@mail.gmail.com>
In-Reply-To: <CAHotPr9tdmnFhZLX2utqFxeXUx_0G0AYsfwKrmktV4USbfBcyw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 1 Jan 2019 16:27:13 -0300
Message-ID: <CABBYNZ+sPBv8QdMNp7-fTD_d9g2atNWka1whhD1iUas4g1JWKA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/5] gatt: Fix invalid read when disconnecting
To:     Gal Ben Haim <gbenhaim@augury.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Gal,

On Sat, Dec 22, 2018 at 3:51 PM Gal Ben Haim <gbenhaim@augury.com> wrote:
>
> it definitely happens with this patch and not with mine

Can you try with valgrind so we got to see if the backtrace is really
the same, also is that using GATT caching or is that disabled?

> On Sat, Dec 15, 2018 at 8:45 AM Gal Ben Haim <gbenhaim@augury.com> wrote:
> >
> > I still get segmentation faults occasionally after applying this patch,
> > i'm not 100% sure that it's related but it happens in the same area...
> > its not something that I can reproduce immediately like with the
> > previous segfault. I think that it doesn't happen if I use my original
> > patch https://marc.info/?l=linux-bluetooth&m=154250398526173&w=2
> >
> > bluetoothd[2599]: src/device.c:att_disconnected_cb()
> > bluetoothd[2599]: src/device.c:att_disconnected_cb() Connection reset
> > by peer (104)
> > bluetoothd[2599]: src/service.c:change_state() 0x4edae0: device
> > DA:51:61:24:3C:36 profile gap-profile state changed: connected ->
> > disconnecting (0)
> > bluetoothd[2599]: src/service.c:change_state() 0x4edae0: device
> > DA:51:61:24:3C:36 profile gap-profile state changed: disconnecting ->
> > disconnected (0)
> > bluetoothd[2599]: src/gatt-client.c:btd_gatt_client_disconnected()
> > Device disconnected. Cleaning up.
> > bluetoothd[2599]: src/device.c:att_disconnected_cb() Automatic
> > connection disabled
> > bluetoothd[2599]: src/gatt-database.c:btd_gatt_database_att_disconnected()
> > bluetoothd[2599]: attrib/gattrib.c:g_attrib_unref() 0x4ee410: g_attrib_unref=0
> > bluetoothd[2599]: src/device.c:btd_device_set_temporary() temporary 1
> > bluetoothd[2599]: src/device.c:device_remove() Removing device
> > /org/bluez/hci0/dev_DA_51_61_24_3C_36
> > bluetoothd[2599]: src/service.c:change_state() 0x4edae0: device
> > DA:51:61:24:3C:36 profile gap-profile state changed: disconnected ->
> > unavailable (0)
> > bluetoothd[2599]: profiles/gap/gas.c:gap_remove() GAP profile remove
> > (DA:51:61:24:3C:36)
> > bluetoothd[2599]: src/service.c:btd_service_unref() 0x4edae0: ref=0
> > bluetoothd[2599]: src/device.c:btd_device_unref() Freeing device
> > /org/bluez/hci0/dev_DA_51_61_24_3C_36
> > bluetoothd[2599]: src/gatt-client.c:unregister_service() Removing GATT
> > service: /org/bluez/hci0/dev_DA_51_61_24_3C_36/service0008
> > bluetoothd[2599]: src/gatt-client.c:unregister_service() Removing GATT
> > service: /org/bluez/hci0/dev_DA_51_61_24_3C_36/service0009
> > bluetoothd[2599]: src/gatt-client.c:unregister_characteristic()
> > Removing GATT characteristic:
> > /org/bluez/hci0/dev_DA_51_61_24_3C_36/service0009/char000a
> > bluetoothd[2599]: src/gatt-client.c:unregister_characteristic()
> > Removing GATT characteristic:
> > /org/bluez/hci0/dev_DA_51_61_24_3C_36/service0009/char000c
> > bluetoothd[2599]: src/gatt-client.c:unregister_descriptor() Removing
> > GATT descriptor:
> > /org/bluez/hci0/dev_DA_51_61_24_3C_36/service0009/char000c/desc000e
> > Segmentation fault
> >
> >
> > On Wed, Nov 21, 2018 at 11:15 AM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi,
> > > On Wed, Nov 21, 2018 at 9:15 AM Gal Ben Haim <gbenhaim@augury.com> wrote:
> > > >
> > > > it fixes the same case that cause the version from master to crash.
> > > > i haven't tested for anything else..
> > > >
> > > > On Tue, Nov 20, 2018 at 8:31 PM Gal Ben Haim <gbenhaim@augury.com> wrote:
> > > > >
> > > > > ok I patched it. i'll test it tomorrow in the office and let you know.
> > > > >
> > > > > On Tue, Nov 20, 2018 at 3:59 PM Luiz Augusto von Dentz
> > > > > <luiz.dentz@gmail.com> wrote:
> > > > > >
> > > > > > Hi Gal,
> > > > > >
> > > > > > On Tue, Nov 20, 2018 at 2:35 PM Gal Ben Haim <gbenhaim@augury.com> wrote:
> > > > > > >
> > > > > > > i tried with both git am and git apply
> > > > > >
> > > > > > Does that applies to v2 as well? I just rebased it on top master, are
> > > > > > you sure you don't have your own changes conflicting with it?
> > > > > >
> > > > > > > On Tue, Nov 20, 2018 at 12:35 PM Luiz Augusto von Dentz
> > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > >
> > > > > > > > Hi Gal,
> > > > > > > > On Tue, Nov 20, 2018 at 11:31 AM Gal Ben Haim <gbenhaim@augury.com> wrote:
> > > > > > > > >
> > > > > > > > > I can't apply this patch, not to the revision in master and not to the 5.50 tag
> > > > > > > >
> > > > > > > > They are on top o master, how are you trying to apply them, with git am?
> > > > > > > >
> > > > > > > > > On Tue, Nov 20, 2018 at 10:50 AM Luiz Augusto von Dentz
> > > > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Mon, Nov 19, 2018 at 5:43 PM Luiz Augusto von Dentz
> > > > > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > > > > > > > >
> > > > > > > > > > > In case there is a client of AcquireNotify and a disconnect happens the
> > > > > > > > > > > code not only have to free the client object but also destroy the io
> > > > > > > > > > > associated with it, for this reason the client object cannot be freed
> > > > > > > > > > > until the io is destroyed otherwise it may lead to the following error:
> > > > > > > > > > >
> > > > > > > > > > > Invalid read of size 4
> > > > > > > > > > >    at 0x63920: notify_io_destroy (gatt-client.c:1461)
> > > > > > > > > > >    by 0x63EDB: pipe_io_destroy (gatt-client.c:1082)
> > > > > > > > > > >    by 0x6405B: characteristic_free (gatt-client.c:1663)
> > > > > > > > > > >    by 0x81F33: remove_interface (object.c:667)
> > > > > > > > > > >    by 0x826CB: g_dbus_unregister_interface (object.c:1391)
> > > > > > > > > > >    by 0x85D2B: queue_remove_all (queue.c:354)
> > > > > > > > > > >    by 0x635F7: unregister_service (gatt-client.c:1893)
> > > > > > > > > > >    by 0x85CF7: queue_remove_all (queue.c:339)
> > > > > > > > > > >    by 0x661DF: btd_gatt_client_service_removed (gatt-client.c:2199)
> > > > > > > > > > >    by 0x695CB: gatt_service_removed (device.c:3747)
> > > > > > > > > > >    by 0x85B17: queue_foreach (queue.c:220)
> > > > > > > > > > >    by 0x91283: notify_service_changed (gatt-db.c:280)
> > > > > > > > > > >    by 0x91283: gatt_db_service_destroy (gatt-db.c:291)
> > > > > > > > > > >  Address 0x515ed48 is 0 bytes inside a block of size 20 free'd
> > > > > > > > > > >    at 0x483EAD0: free (vg_replace_malloc.c:530)
> > > > > > > > > > >    by 0x85D2B: queue_remove_all (queue.c:354)
> > > > > > > > > > >    by 0x636D3: unregister_characteristic (gatt-client.c:1741)
> > > > > > > > > > >    by 0x85D2B: queue_remove_all (queue.c:354)
> > > > > > > > > > >    by 0x635F7: unregister_service (gatt-client.c:1893)
> > > > > > > > > > >    by 0x85CF7: queue_remove_all (queue.c:339)
> > > > > > > > > > >    by 0x661DF: btd_gatt_client_service_removed (gatt-client.c:2199)
> > > > > > > > > > >    by 0x695CB: gatt_service_removed (device.c:3747)
> > > > > > > > > > >    by 0x85B17: queue_foreach (queue.c:220)
> > > > > > > > > > >    by 0x91283: notify_service_changed (gatt-db.c:280)
> > > > > > > > > > >    by 0x91283: gatt_db_service_destroy (gatt-db.c:291)
> > > > > > > > > > >    by 0x85D2B: queue_remove_all (queue.c:354)
> > > > > > > > > > >    by 0x91387: gatt_db_clear_range (gatt-db.c:475)
> > > > > > > > > > > ---
> > > > > > > > > > >  src/gatt-client.c | 24 ++++++++++++------------
> > > > > > > > > > >  1 file changed, 12 insertions(+), 12 deletions(-)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/src/gatt-client.c b/src/gatt-client.c
> > > > > > > > > > > index 234f46ed7..55aa5e423 100644
> > > > > > > > > > > --- a/src/gatt-client.c
> > > > > > > > > > > +++ b/src/gatt-client.c
> > > > > > > > > > > @@ -1645,13 +1645,22 @@ static const GDBusMethodTable characteristic_methods[] = {
> > > > > > > > > > >         { }
> > > > > > > > > > >  };
> > > > > > > > > > >
> > > > > > > > > > > +static void remove_client(void *data)
> > > > > > > > > > > +{
> > > > > > > > > > > +       struct notify_client *ntfy_client = data;
> > > > > > > > > > > +       struct btd_gatt_client *client = ntfy_client->chrc->service->client;
> > > > > > > > > > > +
> > > > > > > > > > > +       queue_remove(client->all_notify_clients, ntfy_client);
> > > > > > > > > > > +
> > > > > > > > > > > +       notify_client_unref(ntfy_client);
> > > > > > > > > > > +}
> > > > > > > > > > > +
> > > > > > > > > > >  static void characteristic_free(void *data)
> > > > > > > > > > >  {
> > > > > > > > > > >         struct characteristic *chrc = data;
> > > > > > > > > > >
> > > > > > > > > > >         /* List should be empty here */
> > > > > > > > > > >         queue_destroy(chrc->descs, NULL);
> > > > > > > > > > > -       queue_destroy(chrc->notify_clients, NULL);
> > > > > > > > > > >
> > > > > > > > > > >         if (chrc->write_io) {
> > > > > > > > > > >                 queue_remove(chrc->service->client->ios, chrc->write_io->io);
> > > > > > > > > > > @@ -1663,6 +1672,8 @@ static void characteristic_free(void *data)
> > > > > > > > > > >                 pipe_io_destroy(chrc->notify_io);
> > > > > > > > > > >         }
> > > > > > > > > > >
> > > > > > > > > > > +       queue_destroy(chrc->notify_clients, remove_client);
> > > > > > > > > > > +
> > > > > > > > > > >         g_free(chrc->path);
> > > > > > > > > > >         free(chrc);
> > > > > > > > > > >  }
> > > > > > > > > > > @@ -1715,16 +1726,6 @@ static struct characteristic *characteristic_create(
> > > > > > > > > > >         return chrc;
> > > > > > > > > > >  }
> > > > > > > > > > >
> > > > > > > > > > > -static void remove_client(void *data)
> > > > > > > > > > > -{
> > > > > > > > > > > -       struct notify_client *ntfy_client = data;
> > > > > > > > > > > -       struct btd_gatt_client *client = ntfy_client->chrc->service->client;
> > > > > > > > > > > -
> > > > > > > > > > > -       queue_remove(client->all_notify_clients, ntfy_client);
> > > > > > > > > > > -
> > > > > > > > > > > -       notify_client_unref(ntfy_client);
> > > > > > > > > > > -}
> > > > > > > > > > > -
> > > > > > > > > > >  static void unregister_characteristic(void *data)
> > > > > > > > > > >  {
> > > > > > > > > > >         struct characteristic *chrc = data;
> > > > > > > > > > > @@ -1738,7 +1739,6 @@ static void unregister_characteristic(void *data)
> > > > > > > > > > >         if (chrc->write_op)
> > > > > > > > > > >                 bt_gatt_client_cancel(gatt, chrc->write_op->id);
> > > > > > > > > > >
> > > > > > > > > > > -       queue_remove_all(chrc->notify_clients, NULL, NULL, remove_client);
> > > > > > > > > > >         queue_remove_all(chrc->descs, NULL, NULL, unregister_descriptor);
> > > > > > > > > > >
> > > > > > > > > > >         g_dbus_unregister_interface(btd_get_dbus_connection(), chrc->path,
> > > > > > > > > > > --
> > > > > > > > > > > 2.17.2
> > >
> > > Applied.
> > >
> > > --
> > > Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
