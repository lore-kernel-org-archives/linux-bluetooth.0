Return-Path: <SRS0=JOhI=EL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DFEC388F7
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Nov 2020 22:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75619206CA
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Nov 2020 22:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="goHbe5Sx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731860AbgKEWyY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Nov 2020 17:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgKEWyX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Nov 2020 17:54:23 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B72C0613CF
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2020 14:54:22 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id i19so4987551ejx.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2020 14:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X8T0pUmKnn35Eg/9tc/b/apuIVZ/n+84KqtGzqVP/AA=;
        b=goHbe5SxyRFEyauTXgcSejzqYaK0y0HMDcoAiK3ZU9nP9kUyCZq82WPyp+8fdUpj1j
         9lLbDSwzN3QbgQA5IflEKZgY5dFM83HEtSdKZjOblQnM8YxkXN02X9RJ2hDGmSwC5Qie
         9yerRF16p0ViEXyPsxtgSYn/avMMmyIFchJ+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X8T0pUmKnn35Eg/9tc/b/apuIVZ/n+84KqtGzqVP/AA=;
        b=mAPzKFX61fCjw9nXvGDeniCi1r/Ra46+KK9YbS/YPNcr+jt54FZNXL5ATL4vTaQ52G
         OHWLb3taF3FAohPlvF3n+yOeNtVqvySJF7dqoyu2Fg/d7LOKnAy8HyxYhCdC2nnDbmN8
         b2wrnvrlfBzZ7MWtN5n3fY/Dh9z+P3a62HQa4HxSeMxkE7fAU1RXVDGC9+qAo/AKLIFZ
         ih3eLxvmXE3QVdEy2LfaN3hAOmEiUuutflRDCuvHdtVRAi1hK+U+13TdS79a8eiCA+bl
         9ZBzTjBXUqKE7AbAy1BZ0BqGzfVkZdHccFc5SYUiF5bj0kMhB5QALojVR+zpgm3i7raJ
         O8GQ==
X-Gm-Message-State: AOAM532HP8jmKQdbzGgQkul/4VwOJ7J/384jZRIvXhUCFIflCTVJtgpj
        pb9UdQ0eapEcGHg4or2XJVFOM3cMV5mkzQ==
X-Google-Smtp-Source: ABdhPJyfTLixbj9UCA2wQGdBZctT73GmYq49H3M8yMCqHq39jrHLIeL0ZtHN1d+QHJaZMNqlrUJA+g==
X-Received: by 2002:a17:906:30c8:: with SMTP id b8mr4887774ejb.77.1604616860741;
        Thu, 05 Nov 2020 14:54:20 -0800 (PST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id s12sm1779989ejy.25.2020.11.05.14.54.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 14:54:19 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id d142so3143845wmd.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2020 14:54:19 -0800 (PST)
X-Received: by 2002:a7b:c309:: with SMTP id k9mr4750148wmj.125.1604616859059;
 Thu, 05 Nov 2020 14:54:19 -0800 (PST)
MIME-Version: 1.0
References: <20201105002412.37720-1-sonnysasaka@chromium.org>
 <CABBYNZ+=wukeRdRD9p=46NAeHhmSVSkAieJCya2UvMz-=zf3sg@mail.gmail.com>
 <CAO271m=Q50FX4W5+6LndarO6uWz-9QzzrWAurZF9gVwf=f6Hig@mail.gmail.com>
 <CABBYNZJLyhF8oAujNfFJ3R69T9PoUq5-P=GdtJkw2Z33ozF4Zw@mail.gmail.com>
 <CAO271mnosJM7YQbYaPEeQ22xJNO=fUnF5dE_EAqfxWb_TP5fSg@mail.gmail.com> <CABBYNZL+3_jqkHxZ9PPesChoti891Uc52m6K-2b1UywWNoGv5g@mail.gmail.com>
In-Reply-To: <CABBYNZL+3_jqkHxZ9PPesChoti891Uc52m6K-2b1UywWNoGv5g@mail.gmail.com>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Thu, 5 Nov 2020 14:54:08 -0800
X-Gmail-Original-Message-ID: <CAO271mnYCMxjCFymdUk9Tfv8purnaJGPPeQfEFy9hmELr6ikgw@mail.gmail.com>
Message-ID: <CAO271mnYCMxjCFymdUk9Tfv8purnaJGPPeQfEFy9hmELr6ikgw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gatt-client: Do not continue service discovery if disconnected
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Thu, Nov 5, 2020 at 1:28 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sonny,
>
> On Thu, Nov 5, 2020 at 1:10 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> >
> > Hi Luiz,
> >
> > bt_gatt_client is not freed. It is expected that bt_gatt_client is
> > still alive at discovery_op_complete since the code clearly references
> > it. It is the gatt_db_attribute objects in client->pending_svcs that
> > are already freed.
>
> That probably means there are other references, also if the attributes
> are being freed that probably means gatt_db_clear has been called
> which would explain why I could not reproduce, that said we should
> invoke bt_gatt_client_cancel_all before cleanup the db.
Yes there are other references. So we can't rely on gatt_client_free
to do the cancel_all. Instead, how about we do the
bt_gatt_client_cancel_all before clearing the db when cleaning up the
cache? I have tested and it fixes the crash for me. (if you're curious
about the repro, maybe you need to set GATT.Cache = "yes" in the
config). Please take a look at my other patch called "Cancel GATT
client operations when cleaning up GATT cache".

>
> > On Thu, Nov 5, 2020 at 1:03 PM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Sonny,
> > >
> > > On Thu, Nov 5, 2020 at 11:20 AM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> > > >
> > > > Hi Luiz,
> > > >
> > > >
> > > > On Thu, Nov 5, 2020 at 10:46 AM Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > > >
> > > > > Hi Sonny,
> > > > >
> > > > > On Wed, Nov 4, 2020 at 10:01 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> > > > > >
> > > > > > If device is disconnected, discovery_complete_op should not continue
> > > > > > processing since this can lead to a crash because the GATT-related
> > > > > > objects may already be freed.
> > > > > >
> > > > > > Sample crash stack trace:
> > > > > > 0  gatt_db_service_get_handles (service=0x1751130, service=0x1751130, end_handle=0x7ffcd600806e, start_handle=0x7ffcd600806c) at src/shared/gatt-db.c:569
> > > > > > 1  gatt_db_attribute_get_service_data (attrib=<optimized out>, start_handle=0x7ffcd600806c, end_handle=0x7ffcd600806e, primary=0x0, uuid=0x0) at src/shared/gatt-db.c:1657
> > > > > > 2  0x00000000004983a8 in discovery_op_complete (op=op@entry=0x173b320, success=<optimized out>, err=err@entry=10 '\n') at src/shared/gatt-client.c:406
> > > > > > 3  0x000000000049a548 in discover_descs_cb (success=<optimized out>, att_ecode=<optimized out>, result=<optimized out>, user_data=0x173b320) at src/shared/gatt-client.c:915
> > > > > > 4  0x00000000004a1d87 in discovery_op_complete (op=0x1748450, success=<optimized out>, ecode=<optimized out>) at src/shared/gatt-helpers.c:615
> > > > > > 5  0x00000000004a2379 in discover_descs_cb (opcode=<optimized out>, pdu=0x174d551, length=<optimized out>, user_data=0x1748450) at src/shared/gatt-helpers.c:1465
> > > > > > 6  0x00000000004966db in handle_rsp (pdu_len=4, pdu=<optimized out>, opcode=<optimized out>, chan=0x17483c0) at src/shared/att.c:814
> > > > > > 7  can_read_data (io=<optimized out>, user_data=0x17483c0) at src/shared/att.c:1011
> > > > >
> > > > > Weird, are you still receiving data after the device is disconnected?
> > > > To be more precise, this happens if I do "remove device" from
> > > > bluetoothctl while it's still doing GATT discovery, i.e. connect and
> > > > quickly remove device. Also this is reproducible if the GATT.Cache
> > > > config is set to "yes". So, the "disconnection" may not be physical
> > > > but a consequence of the code path of the RemoveDevice API. I can
> > > > reproduce it almost 100% of the time with an LE Mouse (tried with MS
> > > > Mouse 3600 and Logitech M355).
> > > > >
> > > > > > 8  0x00000000004a0853 in watch_callback (channel=<optimized out>, cond=<optimized out>, user_data=<optimized out>) at src/shared/io-glib.c:157
> > > > > > 9  0x00007fb3f2d7fe87 in g_main_context_dispatch () from /usr/lib64/libglib-2.0.so.0
> > > > > > 10 0x00007fb3f2d80230 in ?? () from /usr/lib64/libglib-2.0.so.0
> > > > > > 11 0x00007fb3f2d80542 in g_main_loop_run () from /usr/lib64/libglib-2.0.so.0
> > > > > > 12 0x00000000004a0e25 in mainloop_run () at src/shared/mainloop-glib.c:66
> > > > > > 13 0x00000000004a11f2 in mainloop_run_with_signal (func=func@entry=0x43f200 <signal_callback>, user_data=user_data@entry=0x0) at src/shared/mainloop-notify.c:188
> > > > > > 14 0x000000000040c72e in main (argc=<optimized out>, argv=<optimized out>) at src/main.c:959
> > > > > >
> > > > > > Reviewed-By: Archie Pusaka <apusaka@chromium.org>
> > > > > >
> > > > > > ---
> > > > > >  src/device.c             |  3 +++
> > > > > >  src/shared/gatt-client.c | 20 ++++++++++++++++++++
> > > > > >  src/shared/gatt-client.h |  2 ++
> > > > > >  3 files changed, 25 insertions(+)
> > > > > >
> > > > > > diff --git a/src/device.c b/src/device.c
> > > > > > index a5ef46730..9dad746eb 100644
> > > > > > --- a/src/device.c
> > > > > > +++ b/src/device.c
> > > > > > @@ -586,6 +586,9 @@ static void gatt_client_cleanup(struct btd_device *device)
> > > > > >                 device->gatt_ready_id = 0;
> > > > > >         }
> > > > > >
> > > > > > +       /* Make sure that service discovery is stopped if any is in progress */
> > > > > > +       bt_gatt_client_reset_in_discovery(device->client);
> > > > >
> > > > > Does this means that other references will also get interrupted? That
> > > > > is something very weird here since when disconnected the bt_att
> > > > > instance should actually have informed the bt_gatt_client and the
> > > > > cleanup should had happened there.
> > > > What do you mean by "other references"? My guess is that
> > > > bt_gatt_client has done the cleanup, but discovery_op_complete still
> > > > tries to execute the whole code path which involves accessing the
> > > > already cleaned-up gatt_db_attribute objects.
> > >
> > > Here normally what should have happened is:
> > >
> > > bt_gatt_client_unref -> bt_gatt_client_free ->
> > > bt_gatt_client_cancel_all -> bt_gatt_request_unref ->
> > > discovery_op_unref -> discovery_op_free
> > >
> > > So there is something about this code path that is not really working
> > > as intended or perhaps bt_gatt_client_free is never really called? It
> > > would perhaps be worth trying to reproduce this with a a unit test.
> > >
> > > > >
> > > > > > +
> > > > > >         bt_gatt_client_unref(device->client);
> > > > > >         device->client = NULL;
> > > > > >  }
> > > > > > diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> > > > > > index 8becf1c6c..2ba6efe9a 100644
> > > > > > --- a/src/shared/gatt-client.c
> > > > > > +++ b/src/shared/gatt-client.c
> > > > > > @@ -104,6 +104,9 @@ struct bt_gatt_client {
> > > > > >
> > > > > >         struct bt_gatt_request *discovery_req;
> > > > > >         unsigned int mtu_req_id;
> > > > > > +
> > > > > > +       /* Whether there is a service discovery operation ongoing */
> > > > > > +       bool in_discovery;
> > > > > >  };
> > > > > >
> > > > > >  struct request {
> > > > > > @@ -381,6 +384,12 @@ static void discovery_op_complete(struct discovery_op *op, bool success,
> > > > > >  {
> > > > > >         const struct queue_entry *svc;
> > > > > >
> > > > > > +       /* Service discovery may be reset due to disconnection */
> > > > > > +       if (!op->client->in_discovery)
> > > > > > +               return;
> > > > > > +
> > > > > > +       op->client->in_discovery = false;
> > > > > > +
> > > > > >         op->success = success;
> > > > > >
> > > > > >         /* Read database hash if discovery has been successful */
> > > > > > @@ -1857,6 +1866,9 @@ static void process_service_changed(struct bt_gatt_client *client,
> > > > > >  {
> > > > > >         struct discovery_op *op;
> > > > > >
> > > > > > +       if (client->in_discovery)
> > > > > > +               goto fail;
> > > > > > +
> > > > > >         op = discovery_op_create(client, start_handle, end_handle,
> > > > > >                                                 service_changed_complete,
> > > > > >                                                 service_changed_failure);
> > > > > > @@ -1869,6 +1881,7 @@ static void process_service_changed(struct bt_gatt_client *client,
> > > > > >                                                 discovery_op_ref(op),
> > > > > >                                                 discovery_op_unref);
> > > > > >         if (client->discovery_req) {
> > > > > > +               client->in_discovery = true;
> > > > > >                 client->in_svc_chngd = true;
> > > > > >                 return;
> > > > > >         }
> > > > > > @@ -2057,6 +2070,7 @@ static bool gatt_client_init(struct bt_gatt_client *client, uint16_t mtu)
> > > > > >                 return false;
> > > > > >         }
> > > > > >
> > > > > > +       client->in_discovery = true;
> > > > > >         client->in_init = true;
> > > > > >
> > > > > >         return true;
> > > > > > @@ -2080,6 +2094,7 @@ discover:
> > > > > >         }
> > > > > >
> > > > > >  done:
> > > > > > +       client->in_discovery = true;
> > > > > >         client->in_init = true;
> > > > > >         return true;
> > > > > >  }
> > > > > > @@ -3694,3 +3709,8 @@ int bt_gatt_client_get_security(struct bt_gatt_client *client)
> > > > > >
> > > > > >         return bt_att_get_security(client->att, NULL);
> > > > > >  }
> > > > > > +
> > > > > > +void bt_gatt_client_reset_in_discovery(struct bt_gatt_client *client)
> > > > > > +{
> > > > > > +       client->in_discovery = false;
> > > > > > +}
> > > > > > diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
> > > > > > index dc5102394..dcd8e5cf6 100644
> > > > > > --- a/src/shared/gatt-client.h
> > > > > > +++ b/src/shared/gatt-client.h
> > > > > > @@ -126,3 +126,5 @@ bool bt_gatt_client_unregister_notify(struct bt_gatt_client *client,
> > > > > >
> > > > > >  bool bt_gatt_client_set_security(struct bt_gatt_client *client, int level);
> > > > > >  int bt_gatt_client_get_security(struct bt_gatt_client *client);
> > > > > > +
> > > > > > +void bt_gatt_client_reset_in_discovery(struct bt_gatt_client *client);
> > > > > > --
> > > > > > 2.26.2
> > > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Luiz Augusto von Dentz
> > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz
