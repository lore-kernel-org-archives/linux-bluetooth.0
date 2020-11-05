Return-Path: <SRS0=JOhI=EL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBFAC388F7
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Nov 2020 19:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33BBF2087D
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Nov 2020 19:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LLHgELqL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgKETU5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Nov 2020 14:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbgKETU5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Nov 2020 14:20:57 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340BFC0613CF
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2020 11:20:57 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id dk16so4238734ejb.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2020 11:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yEC9qcIYTHTZY72+LWRrw52Izq3fD9/0SfC8youwGHo=;
        b=LLHgELqLdnb5Z8YWRpni2o0No4NYub61se4dfSwojoLtXASld4yWNwvGKmLNjzIopO
         m13hj2kNx4Xs4X8oFb17iXjXwN/LbjEnGLotG5sjsvYVeZkvyvvP2iF2KUmUDn/hNkIl
         QN3RAiLB0z8eDXDON/JRwTEU4+vhxiduaAax0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yEC9qcIYTHTZY72+LWRrw52Izq3fD9/0SfC8youwGHo=;
        b=PgEURttKbNmjTD+HeJUD4ZdMCqV2BcNN2lzrEMgfZgoGOH3U/kexlCAb118sujl9fj
         f1qqaoZYBjqyEMGTaBEyfR+CpLWMh9vZbIBrn6/RrKWEDMPRDKRHfGv1p2Hc7gmv92Kk
         LZDmCiVwtdM2lIjIiHQq7BHyXrT3jdLAPu9yW/ppv1X/BvguZzAeKQIdFrvy6d/NHSNU
         pJPsJ/G9InS9bbI/NyXsO8Kh8kA8rdxvhJC871ASu7Wg8udGyWTOpp8YVtCrnmSwStAP
         LUXrEA7eD20W31Daq0bDH6POtQ5gAI/piBdYgsLrhymEwRIKqfU5ydJPoy23PiHvB3bz
         EBVA==
X-Gm-Message-State: AOAM5303fqzT6pTUUIEI7L4h+uk2B3UYfezK+kyJIYD0osjtapbolUh4
        BFDD0/Yerg0KRUwmd6XBbqN9cQ8tmp2YPg==
X-Google-Smtp-Source: ABdhPJxSkxV9wCNXFEF31Ka7QTnpthWlmUXJ2C6W3ARIsFdFuVpUkrUq9K72HDiU51SXBRcYhdGmbw==
X-Received: by 2002:a17:906:5247:: with SMTP id y7mr3744149ejm.503.1604604055272;
        Thu, 05 Nov 2020 11:20:55 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id by8sm1514060edb.49.2020.11.05.11.20.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 11:20:54 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id c18so2702690wme.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2020 11:20:53 -0800 (PST)
X-Received: by 2002:a1c:6654:: with SMTP id a81mr4537759wmc.104.1604604053097;
 Thu, 05 Nov 2020 11:20:53 -0800 (PST)
MIME-Version: 1.0
References: <20201105002412.37720-1-sonnysasaka@chromium.org> <CABBYNZ+=wukeRdRD9p=46NAeHhmSVSkAieJCya2UvMz-=zf3sg@mail.gmail.com>
In-Reply-To: <CABBYNZ+=wukeRdRD9p=46NAeHhmSVSkAieJCya2UvMz-=zf3sg@mail.gmail.com>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Thu, 5 Nov 2020 11:20:42 -0800
X-Gmail-Original-Message-ID: <CAO271m=Q50FX4W5+6LndarO6uWz-9QzzrWAurZF9gVwf=f6Hig@mail.gmail.com>
Message-ID: <CAO271m=Q50FX4W5+6LndarO6uWz-9QzzrWAurZF9gVwf=f6Hig@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gatt-client: Do not continue service discovery if disconnected
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,


On Thu, Nov 5, 2020 at 10:46 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sonny,
>
> On Wed, Nov 4, 2020 at 10:01 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> >
> > If device is disconnected, discovery_complete_op should not continue
> > processing since this can lead to a crash because the GATT-related
> > objects may already be freed.
> >
> > Sample crash stack trace:
> > 0  gatt_db_service_get_handles (service=0x1751130, service=0x1751130, end_handle=0x7ffcd600806e, start_handle=0x7ffcd600806c) at src/shared/gatt-db.c:569
> > 1  gatt_db_attribute_get_service_data (attrib=<optimized out>, start_handle=0x7ffcd600806c, end_handle=0x7ffcd600806e, primary=0x0, uuid=0x0) at src/shared/gatt-db.c:1657
> > 2  0x00000000004983a8 in discovery_op_complete (op=op@entry=0x173b320, success=<optimized out>, err=err@entry=10 '\n') at src/shared/gatt-client.c:406
> > 3  0x000000000049a548 in discover_descs_cb (success=<optimized out>, att_ecode=<optimized out>, result=<optimized out>, user_data=0x173b320) at src/shared/gatt-client.c:915
> > 4  0x00000000004a1d87 in discovery_op_complete (op=0x1748450, success=<optimized out>, ecode=<optimized out>) at src/shared/gatt-helpers.c:615
> > 5  0x00000000004a2379 in discover_descs_cb (opcode=<optimized out>, pdu=0x174d551, length=<optimized out>, user_data=0x1748450) at src/shared/gatt-helpers.c:1465
> > 6  0x00000000004966db in handle_rsp (pdu_len=4, pdu=<optimized out>, opcode=<optimized out>, chan=0x17483c0) at src/shared/att.c:814
> > 7  can_read_data (io=<optimized out>, user_data=0x17483c0) at src/shared/att.c:1011
>
> Weird, are you still receiving data after the device is disconnected?
To be more precise, this happens if I do "remove device" from
bluetoothctl while it's still doing GATT discovery, i.e. connect and
quickly remove device. Also this is reproducible if the GATT.Cache
config is set to "yes". So, the "disconnection" may not be physical
but a consequence of the code path of the RemoveDevice API. I can
reproduce it almost 100% of the time with an LE Mouse (tried with MS
Mouse 3600 and Logitech M355).
>
> > 8  0x00000000004a0853 in watch_callback (channel=<optimized out>, cond=<optimized out>, user_data=<optimized out>) at src/shared/io-glib.c:157
> > 9  0x00007fb3f2d7fe87 in g_main_context_dispatch () from /usr/lib64/libglib-2.0.so.0
> > 10 0x00007fb3f2d80230 in ?? () from /usr/lib64/libglib-2.0.so.0
> > 11 0x00007fb3f2d80542 in g_main_loop_run () from /usr/lib64/libglib-2.0.so.0
> > 12 0x00000000004a0e25 in mainloop_run () at src/shared/mainloop-glib.c:66
> > 13 0x00000000004a11f2 in mainloop_run_with_signal (func=func@entry=0x43f200 <signal_callback>, user_data=user_data@entry=0x0) at src/shared/mainloop-notify.c:188
> > 14 0x000000000040c72e in main (argc=<optimized out>, argv=<optimized out>) at src/main.c:959
> >
> > Reviewed-By: Archie Pusaka <apusaka@chromium.org>
> >
> > ---
> >  src/device.c             |  3 +++
> >  src/shared/gatt-client.c | 20 ++++++++++++++++++++
> >  src/shared/gatt-client.h |  2 ++
> >  3 files changed, 25 insertions(+)
> >
> > diff --git a/src/device.c b/src/device.c
> > index a5ef46730..9dad746eb 100644
> > --- a/src/device.c
> > +++ b/src/device.c
> > @@ -586,6 +586,9 @@ static void gatt_client_cleanup(struct btd_device *device)
> >                 device->gatt_ready_id = 0;
> >         }
> >
> > +       /* Make sure that service discovery is stopped if any is in progress */
> > +       bt_gatt_client_reset_in_discovery(device->client);
>
> Does this means that other references will also get interrupted? That
> is something very weird here since when disconnected the bt_att
> instance should actually have informed the bt_gatt_client and the
> cleanup should had happened there.
What do you mean by "other references"? My guess is that
bt_gatt_client has done the cleanup, but discovery_op_complete still
tries to execute the whole code path which involves accessing the
already cleaned-up gatt_db_attribute objects.
>
> > +
> >         bt_gatt_client_unref(device->client);
> >         device->client = NULL;
> >  }
> > diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> > index 8becf1c6c..2ba6efe9a 100644
> > --- a/src/shared/gatt-client.c
> > +++ b/src/shared/gatt-client.c
> > @@ -104,6 +104,9 @@ struct bt_gatt_client {
> >
> >         struct bt_gatt_request *discovery_req;
> >         unsigned int mtu_req_id;
> > +
> > +       /* Whether there is a service discovery operation ongoing */
> > +       bool in_discovery;
> >  };
> >
> >  struct request {
> > @@ -381,6 +384,12 @@ static void discovery_op_complete(struct discovery_op *op, bool success,
> >  {
> >         const struct queue_entry *svc;
> >
> > +       /* Service discovery may be reset due to disconnection */
> > +       if (!op->client->in_discovery)
> > +               return;
> > +
> > +       op->client->in_discovery = false;
> > +
> >         op->success = success;
> >
> >         /* Read database hash if discovery has been successful */
> > @@ -1857,6 +1866,9 @@ static void process_service_changed(struct bt_gatt_client *client,
> >  {
> >         struct discovery_op *op;
> >
> > +       if (client->in_discovery)
> > +               goto fail;
> > +
> >         op = discovery_op_create(client, start_handle, end_handle,
> >                                                 service_changed_complete,
> >                                                 service_changed_failure);
> > @@ -1869,6 +1881,7 @@ static void process_service_changed(struct bt_gatt_client *client,
> >                                                 discovery_op_ref(op),
> >                                                 discovery_op_unref);
> >         if (client->discovery_req) {
> > +               client->in_discovery = true;
> >                 client->in_svc_chngd = true;
> >                 return;
> >         }
> > @@ -2057,6 +2070,7 @@ static bool gatt_client_init(struct bt_gatt_client *client, uint16_t mtu)
> >                 return false;
> >         }
> >
> > +       client->in_discovery = true;
> >         client->in_init = true;
> >
> >         return true;
> > @@ -2080,6 +2094,7 @@ discover:
> >         }
> >
> >  done:
> > +       client->in_discovery = true;
> >         client->in_init = true;
> >         return true;
> >  }
> > @@ -3694,3 +3709,8 @@ int bt_gatt_client_get_security(struct bt_gatt_client *client)
> >
> >         return bt_att_get_security(client->att, NULL);
> >  }
> > +
> > +void bt_gatt_client_reset_in_discovery(struct bt_gatt_client *client)
> > +{
> > +       client->in_discovery = false;
> > +}
> > diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
> > index dc5102394..dcd8e5cf6 100644
> > --- a/src/shared/gatt-client.h
> > +++ b/src/shared/gatt-client.h
> > @@ -126,3 +126,5 @@ bool bt_gatt_client_unregister_notify(struct bt_gatt_client *client,
> >
> >  bool bt_gatt_client_set_security(struct bt_gatt_client *client, int level);
> >  int bt_gatt_client_get_security(struct bt_gatt_client *client);
> > +
> > +void bt_gatt_client_reset_in_discovery(struct bt_gatt_client *client);
> > --
> > 2.26.2
> >
>
>
> --
> Luiz Augusto von Dentz
