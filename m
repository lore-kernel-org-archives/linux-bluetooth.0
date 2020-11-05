Return-Path: <SRS0=JOhI=EL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D54C388F7
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Nov 2020 21:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EF8C20724
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Nov 2020 21:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IptyzMFR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730973AbgKEVDb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Nov 2020 16:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKEVDb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Nov 2020 16:03:31 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29964C0613CF
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2020 13:03:31 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id n15so2748721otl.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2020 13:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HgFOmW80uye6uZALfKNTFP6WESC5LK+5thLI+hZeYA8=;
        b=IptyzMFRvFGZB+Sr6pd/ArMzDj3owwQyn9o2eTAIoadaBmXjSCtkx98zYqHZPskRvX
         EEArI0Yfx2pCLN5Yyr19sO0KEaw6d5cGOsZ6K7GZ7QkhydmhsoC3aPonq1r820XP11dQ
         f9eJN335T2/chpYksT+qdA+85MPH5oVkDtWctsWiIudK4pCyZdd8RLb7IfBrvqj8Kibg
         gGhxQK7K/1ypSfQz1qxCZVeRovdeQARk8wKeJIrwMLBww1zDwAQCayjYJK4kzYAF2XJu
         MT0om+NM5KOoVVq3EVajgXG96kM4Rh20OsUHIeuAcgiG4y7aUOikQ8EVyLvo50kelXsy
         h3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HgFOmW80uye6uZALfKNTFP6WESC5LK+5thLI+hZeYA8=;
        b=o6yFaylY8lpmO/Yy6kjqCvn+bU+bBuJRY7XzDNfeh/4Kjn4OrzxXNy7QihF/FkcU4W
         9CPRhmbq1D66XeEDa1ht9ouWzJ2UlfBETA75Cm96EbcVur4ByU+mwfLQwYJJPG4eLpXx
         ZSlE8O6HGiroRvKkXePiP9UOuRKC+uu3Te9HpVOR5t4r4XzJZisKlKsGoCuGLpHz9w5Y
         uWun66i8wuOLtCKqaSetM/7RwqbWrYhmaUJ84wNKuC4R5w5UXmENhYGihJrJ7wilwcXX
         JUEKYU2Avwejpkt6nYRVMMO9urhTSyzjZi5FwlmqL4oMO6uE3ZF+KhXpAK80tgj/M8vb
         7OGg==
X-Gm-Message-State: AOAM530spc+GUd6T1Mn22G/JtjSjZBLqrsLdnYFMBmYnJ4/KNJlmnhP7
        kGnrzhILahvdPTfAN7lW9z/rmOEnLeKtYkMxoyDvOBvZ74s0Ew==
X-Google-Smtp-Source: ABdhPJy5IxKreX60qxofmd5BV2pRBA9bVqt/iazB6dmwXDNNG6l//9k+ztC3na2MRaH/D+JyH5TdCzgB3ncZPC+O3Ho=
X-Received: by 2002:a9d:1a9:: with SMTP id e38mr2845397ote.240.1604610210385;
 Thu, 05 Nov 2020 13:03:30 -0800 (PST)
MIME-Version: 1.0
References: <20201105002412.37720-1-sonnysasaka@chromium.org>
 <CABBYNZ+=wukeRdRD9p=46NAeHhmSVSkAieJCya2UvMz-=zf3sg@mail.gmail.com> <CAO271m=Q50FX4W5+6LndarO6uWz-9QzzrWAurZF9gVwf=f6Hig@mail.gmail.com>
In-Reply-To: <CAO271m=Q50FX4W5+6LndarO6uWz-9QzzrWAurZF9gVwf=f6Hig@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 5 Nov 2020 13:03:19 -0800
Message-ID: <CABBYNZJLyhF8oAujNfFJ3R69T9PoUq5-P=GdtJkw2Z33ozF4Zw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gatt-client: Do not continue service discovery if disconnected
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Thu, Nov 5, 2020 at 11:20 AM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> Hi Luiz,
>
>
> On Thu, Nov 5, 2020 at 10:46 AM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Sonny,
> >
> > On Wed, Nov 4, 2020 at 10:01 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> > >
> > > If device is disconnected, discovery_complete_op should not continue
> > > processing since this can lead to a crash because the GATT-related
> > > objects may already be freed.
> > >
> > > Sample crash stack trace:
> > > 0  gatt_db_service_get_handles (service=0x1751130, service=0x1751130, end_handle=0x7ffcd600806e, start_handle=0x7ffcd600806c) at src/shared/gatt-db.c:569
> > > 1  gatt_db_attribute_get_service_data (attrib=<optimized out>, start_handle=0x7ffcd600806c, end_handle=0x7ffcd600806e, primary=0x0, uuid=0x0) at src/shared/gatt-db.c:1657
> > > 2  0x00000000004983a8 in discovery_op_complete (op=op@entry=0x173b320, success=<optimized out>, err=err@entry=10 '\n') at src/shared/gatt-client.c:406
> > > 3  0x000000000049a548 in discover_descs_cb (success=<optimized out>, att_ecode=<optimized out>, result=<optimized out>, user_data=0x173b320) at src/shared/gatt-client.c:915
> > > 4  0x00000000004a1d87 in discovery_op_complete (op=0x1748450, success=<optimized out>, ecode=<optimized out>) at src/shared/gatt-helpers.c:615
> > > 5  0x00000000004a2379 in discover_descs_cb (opcode=<optimized out>, pdu=0x174d551, length=<optimized out>, user_data=0x1748450) at src/shared/gatt-helpers.c:1465
> > > 6  0x00000000004966db in handle_rsp (pdu_len=4, pdu=<optimized out>, opcode=<optimized out>, chan=0x17483c0) at src/shared/att.c:814
> > > 7  can_read_data (io=<optimized out>, user_data=0x17483c0) at src/shared/att.c:1011
> >
> > Weird, are you still receiving data after the device is disconnected?
> To be more precise, this happens if I do "remove device" from
> bluetoothctl while it's still doing GATT discovery, i.e. connect and
> quickly remove device. Also this is reproducible if the GATT.Cache
> config is set to "yes". So, the "disconnection" may not be physical
> but a consequence of the code path of the RemoveDevice API. I can
> reproduce it almost 100% of the time with an LE Mouse (tried with MS
> Mouse 3600 and Logitech M355).
> >
> > > 8  0x00000000004a0853 in watch_callback (channel=<optimized out>, cond=<optimized out>, user_data=<optimized out>) at src/shared/io-glib.c:157
> > > 9  0x00007fb3f2d7fe87 in g_main_context_dispatch () from /usr/lib64/libglib-2.0.so.0
> > > 10 0x00007fb3f2d80230 in ?? () from /usr/lib64/libglib-2.0.so.0
> > > 11 0x00007fb3f2d80542 in g_main_loop_run () from /usr/lib64/libglib-2.0.so.0
> > > 12 0x00000000004a0e25 in mainloop_run () at src/shared/mainloop-glib.c:66
> > > 13 0x00000000004a11f2 in mainloop_run_with_signal (func=func@entry=0x43f200 <signal_callback>, user_data=user_data@entry=0x0) at src/shared/mainloop-notify.c:188
> > > 14 0x000000000040c72e in main (argc=<optimized out>, argv=<optimized out>) at src/main.c:959
> > >
> > > Reviewed-By: Archie Pusaka <apusaka@chromium.org>
> > >
> > > ---
> > >  src/device.c             |  3 +++
> > >  src/shared/gatt-client.c | 20 ++++++++++++++++++++
> > >  src/shared/gatt-client.h |  2 ++
> > >  3 files changed, 25 insertions(+)
> > >
> > > diff --git a/src/device.c b/src/device.c
> > > index a5ef46730..9dad746eb 100644
> > > --- a/src/device.c
> > > +++ b/src/device.c
> > > @@ -586,6 +586,9 @@ static void gatt_client_cleanup(struct btd_device *device)
> > >                 device->gatt_ready_id = 0;
> > >         }
> > >
> > > +       /* Make sure that service discovery is stopped if any is in progress */
> > > +       bt_gatt_client_reset_in_discovery(device->client);
> >
> > Does this means that other references will also get interrupted? That
> > is something very weird here since when disconnected the bt_att
> > instance should actually have informed the bt_gatt_client and the
> > cleanup should had happened there.
> What do you mean by "other references"? My guess is that
> bt_gatt_client has done the cleanup, but discovery_op_complete still
> tries to execute the whole code path which involves accessing the
> already cleaned-up gatt_db_attribute objects.

Here normally what should have happened is:

bt_gatt_client_unref -> bt_gatt_client_free ->
bt_gatt_client_cancel_all -> bt_gatt_request_unref ->
discovery_op_unref -> discovery_op_free

So there is something about this code path that is not really working
as intended or perhaps bt_gatt_client_free is never really called? It
would perhaps be worth trying to reproduce this with a a unit test.

> >
> > > +
> > >         bt_gatt_client_unref(device->client);
> > >         device->client = NULL;
> > >  }
> > > diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> > > index 8becf1c6c..2ba6efe9a 100644
> > > --- a/src/shared/gatt-client.c
> > > +++ b/src/shared/gatt-client.c
> > > @@ -104,6 +104,9 @@ struct bt_gatt_client {
> > >
> > >         struct bt_gatt_request *discovery_req;
> > >         unsigned int mtu_req_id;
> > > +
> > > +       /* Whether there is a service discovery operation ongoing */
> > > +       bool in_discovery;
> > >  };
> > >
> > >  struct request {
> > > @@ -381,6 +384,12 @@ static void discovery_op_complete(struct discovery_op *op, bool success,
> > >  {
> > >         const struct queue_entry *svc;
> > >
> > > +       /* Service discovery may be reset due to disconnection */
> > > +       if (!op->client->in_discovery)
> > > +               return;
> > > +
> > > +       op->client->in_discovery = false;
> > > +
> > >         op->success = success;
> > >
> > >         /* Read database hash if discovery has been successful */
> > > @@ -1857,6 +1866,9 @@ static void process_service_changed(struct bt_gatt_client *client,
> > >  {
> > >         struct discovery_op *op;
> > >
> > > +       if (client->in_discovery)
> > > +               goto fail;
> > > +
> > >         op = discovery_op_create(client, start_handle, end_handle,
> > >                                                 service_changed_complete,
> > >                                                 service_changed_failure);
> > > @@ -1869,6 +1881,7 @@ static void process_service_changed(struct bt_gatt_client *client,
> > >                                                 discovery_op_ref(op),
> > >                                                 discovery_op_unref);
> > >         if (client->discovery_req) {
> > > +               client->in_discovery = true;
> > >                 client->in_svc_chngd = true;
> > >                 return;
> > >         }
> > > @@ -2057,6 +2070,7 @@ static bool gatt_client_init(struct bt_gatt_client *client, uint16_t mtu)
> > >                 return false;
> > >         }
> > >
> > > +       client->in_discovery = true;
> > >         client->in_init = true;
> > >
> > >         return true;
> > > @@ -2080,6 +2094,7 @@ discover:
> > >         }
> > >
> > >  done:
> > > +       client->in_discovery = true;
> > >         client->in_init = true;
> > >         return true;
> > >  }
> > > @@ -3694,3 +3709,8 @@ int bt_gatt_client_get_security(struct bt_gatt_client *client)
> > >
> > >         return bt_att_get_security(client->att, NULL);
> > >  }
> > > +
> > > +void bt_gatt_client_reset_in_discovery(struct bt_gatt_client *client)
> > > +{
> > > +       client->in_discovery = false;
> > > +}
> > > diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
> > > index dc5102394..dcd8e5cf6 100644
> > > --- a/src/shared/gatt-client.h
> > > +++ b/src/shared/gatt-client.h
> > > @@ -126,3 +126,5 @@ bool bt_gatt_client_unregister_notify(struct bt_gatt_client *client,
> > >
> > >  bool bt_gatt_client_set_security(struct bt_gatt_client *client, int level);
> > >  int bt_gatt_client_get_security(struct bt_gatt_client *client);
> > > +
> > > +void bt_gatt_client_reset_in_discovery(struct bt_gatt_client *client);
> > > --
> > > 2.26.2
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
