Return-Path: <SRS0=XILz=C2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3852C43464
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 22:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93FD3208DB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 22:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EHm7B/tD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgIQWXO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 18:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgIQWXN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 18:23:13 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7B6C06174A
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 15:23:13 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id g4so4176808edk.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 15:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I6w1TUj9xOYczLkyrq5zxBjdqnRjwnwLIwEXm54w/Sk=;
        b=EHm7B/tDIwRdUzM9hhoNybasA38pxCuhexvO69Bsig4Qc23WEB+4GhZmXBn18jA7vU
         vil2r5qM/VedJlE6RYkDUEnk42H7zAP32tRn0bz68GSPt9Y8sl4uidIOAlKcpPzT/2kL
         vHGKkllyRS8oDWWT23ZJ9C42HlQgGLmO7ZnXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I6w1TUj9xOYczLkyrq5zxBjdqnRjwnwLIwEXm54w/Sk=;
        b=B8zMnk8VyQMC298UyDv8mEwDeMmxPPHOUR3G2rRScR48VxClpoyCCHfyVHEr7W7T7T
         NIqvd61E6fUsgDXzTrkC/moqc8xmvVEyUTwsk6CEzpaiR52IFCKlQoimv25fem63qNw5
         HdA0Lt7xz02nIQvXL4bqQC6J6F5zWBnveQWJWp4yvM/2wZfefNk35Cvxec1nIb7BDk2d
         5prmMALWCQc03o9i62XXc/kF27wWRuyJIuun8uzhIcFf+2qSMMefZnxpKiKlzRo5dGGy
         C6pWSry98qFlI5P0eNzPBs8MV54rmi2QnGNRYO5ahLzij97l9XK5IlmdBC7eBXPeKUn8
         WtRg==
X-Gm-Message-State: AOAM530s5gaKbxnXQo8xCpgXawcsRgJXTHuVNpa7sosMUt+yx/t/nXmx
        AX9+fs2dkVWcA+vEKR8qiM+BEElkTta6Hg==
X-Google-Smtp-Source: ABdhPJxMOkWshWG7/so7Nbbkfeqh2aftcLnIAsqa2orAjyBXGjbLnUJymf/w7CxONn4Npq7V18YH+Q==
X-Received: by 2002:a05:6402:16c9:: with SMTP id r9mr34630562edx.27.1600381391464;
        Thu, 17 Sep 2020 15:23:11 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id os15sm795696ejb.61.2020.09.17.15.23.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2020 15:23:10 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id d4so3427004wmd.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 15:23:10 -0700 (PDT)
X-Received: by 2002:a05:600c:2252:: with SMTP id a18mr13090168wmm.154.1600381389791;
 Thu, 17 Sep 2020 15:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200916211122.127881-1-sonnysasaka@chromium.org> <CABBYNZKwZBM-3=jBvNVL7oHa133GGnZ5f8roNyrAR-hXNOVuhA@mail.gmail.com>
In-Reply-To: <CABBYNZKwZBM-3=jBvNVL7oHa133GGnZ5f8roNyrAR-hXNOVuhA@mail.gmail.com>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Thu, 17 Sep 2020 15:22:58 -0700
X-Gmail-Original-Message-ID: <CAO271mknf69CZyv8cbmiJR8_OLhC3qwjNByAeCSrcQrJkyy32w@mail.gmail.com>
Message-ID: <CAO271mknf69CZyv8cbmiJR8_OLhC3qwjNByAeCSrcQrJkyy32w@mail.gmail.com>
Subject: Re: [PATCH BlueZ] a2dp: Keep track of ref ownership of a2dp_setup
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,


On Wed, Sep 16, 2020 at 4:28 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sonny,
>
> On Wed, Sep 16, 2020 at 3:31 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> >
> > Currently transport_cb and abort_cfm make assumption that they have an
> > a2dp_setup reference held as a result of open_ind invocation. In the
> > field this is not always true, for example when the peer device opens an
> > L2CAP channel for AVDTP transport channel without sending AVDTP_OPEN
> > request through the AVDTP signaling channel first. Although in this case
> > the peer device does not behave correctly, we should protect this
> > possible crash from happening by making sure that transport_cb and
> > abort_cfm are really holding a reference of a2dp_setup object before
> > trying to unref them.
> >
> > After grabbing a reference, open_ind stores the pointer in
> > stream->pending_open_data. If this field is set, that means there is a
> > pending AVDTP_OPEN command and it needs to be unref-fed later once and
> > only once: when the transport channel is created (transport_cb) or when
> > the AVDTP_OPEN command is aborted (abort_cfm). If this field is not set,
> > nothing should unref it. This enforces that the reference counting is
> > correct regardless of the behavior of the peer device.
>
> While I agree that we should handle this properly and never crash I
> think we can take a more generic approach by attaching a user_data to
> the stream, see my comments bellow.
I sent a v2 to change to generic user_data instead of pending_open_data.

>
> > A sample crash stack trace from Chrome OS:
> > * thread #1, stop reason = signal SIGSEGV
> >   * frame #0: 0x0c64f0e8 bluetoothd`queue_remove_all at queue.c:351
> >     frame #1: 0x0c64f086 bluetoothd`queue_destroy at queue.c:73
> >     frame #2: 0x0c6022b0 bluetoothd`setup_unref at a2dp.c:222
> >     frame #3: 0x0c604942 bluetoothd`transport_cb at a2dp.c:2229
> >     frame #4: 0x0c61e35c bluetoothd`accept_cb at btio.c:203
> >     frame #5: 0xf679523c libglib-2.0.so.0`g_main_context_dispatch at gmain.c:3182
> >     frame #6: 0xf67954aa libglib-2.0.so.0`g_main_context_iterate at gmain.c:3920
> >     frame #7: 0xf679569a libglib-2.0.so.0`g_main_loop_run at gmain.c:4116
> >     frame #8: 0x0c65a5a0 bluetoothd`mainloop_run at mainloop-glib.c:79
> >     frame #9: 0x0c65a7ea bluetoothd`mainloop_run_with_signal at mainloop-notify.c:201
> >     frame #10: 0x0c6477ec bluetoothd`main at main.c:772
> >     frame #11: 0xf65bc0a2 libc.so.6`__libc_start_main at libc-start.c:308
> >
> > ---
> >  profiles/audio/a2dp.c  | 24 ++++++++++++++++--------
> >  profiles/audio/avdtp.c | 17 +++++++++++++++++
> >  profiles/audio/avdtp.h |  3 +++
> >  3 files changed, 36 insertions(+), 8 deletions(-)
> >
> > diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> > index 2feea66c0..9e96f8c4b 100644
> > --- a/profiles/audio/a2dp.c
> > +++ b/profiles/audio/a2dp.c
> > @@ -927,10 +927,16 @@ static gboolean open_ind(struct avdtp *session, struct avdtp_local_sep *sep,
> >         else
> >                 DBG("Source %p: Open_Ind", sep);
> >
> > +       if (avdtp_stream_get_pending_open_data(stream)) {
> > +               warn("Pending open data already exists");
> > +               return FALSE;
> > +       }
> > +
>
> Not really clear why you need to check if there is a setup already in
> pending state here, if that is the case then that should be fixed in
> avdtp.c since it is not support to call open again if it is already
> pending.
It's one thing that avdtp.c should never allow open_ind to be invoked
twice. But it's also another thing to ensure that a2dp.c guarantees
the correctness of the ref counting of setup object regardless of the
broader code area. What we do here is following the contract that
stream->user_data being not NULL means that there is a reference taken
on a setup object. We should either return early here, or unref that
object before continuing to ensure that ref-counting is guaranteed to
be correct even without looking/understanding the bigger picture.

>
> >         setup = a2dp_setup_get(session);
> >         if (!setup)
> >                 return FALSE;
> >
> > +       avdtp_stream_set_pending_open_data(stream, setup);
>
> Id like this to be handle generically in with something like:
>
> avdtp_stream_set_user_data(session, setup, destroy)
> setup = avdtp_stream_get_user_data(session)
>
> This should avoid lookups in the likes of a2dp_setup_get and ensure
> that the setup lifetime is tied to the stream.
I have sent a v2 to use generic user_data with destroy function.
However I can't follow exactly what you recommend here because setup
still needs to be looked up from a2dp_setup_get because this is the
first time we assign stream->user_data.
>
> >         setup->stream = stream;
> >
> >         if (!err && setup->chan)
> > @@ -1285,14 +1291,13 @@ static void abort_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
> >                         void *user_data)
> >  {
> >         struct a2dp_sep *a2dp_sep = user_data;
> > -       struct a2dp_setup *setup;
> > +       struct a2dp_setup *setup = avdtp_stream_get_pending_open_data(stream);
>
> Abort can be called while in configured state as well, anyway if we go
> ahead with the idea of attaching the setup to the avdtp_stream then
> this would be just a matter of calling avdtp_stream_get_user_data.
>
> >
> >         if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
> >                 DBG("Sink %p: Abort_Cfm", sep);
> >         else
> >                 DBG("Source %p: Abort_Cfm", sep);
> >
> > -       setup = find_setup_by_session(session);
> >         if (!setup)
> >                 return;
> >
> > @@ -1302,6 +1307,7 @@ static void abort_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
> >         }
> >
> >         setup_unref(setup);
> > +       avdtp_stream_set_pending_open_data(stream, NULL);
>
> This would then be avdtp_stream_set_user_data(stream, NULL, NULL), or
> better yet wait the destroy function to be called which should then do
> setup_unref to destroy the setup.
>
> >  }
> >
> >  static gboolean reconf_ind(struct avdtp *session, struct avdtp_local_sep *sep,
> > @@ -2216,11 +2222,12 @@ fail:
> >
> >  static void transport_cb(GIOChannel *io, GError *err, gpointer user_data)
> >  {
> > -       struct a2dp_setup *setup = user_data;
> > +       struct avdtp_stream *stream = user_data;
> > +       struct a2dp_setup *setup = avdtp_stream_get_pending_open_data(stream);
> >         uint16_t omtu, imtu;
> >
> > -       if (!g_slist_find(setups, setup)) {
> > -               warn("bt_io_accept: setup %p no longer valid", setup);
> > +       if (!setup) {
> > +               warn("transport_cb: pending open data does not exist");
> >                 g_io_channel_shutdown(io, TRUE, NULL);
> >                 return;
> >         }
> > @@ -2238,8 +2245,7 @@ static void transport_cb(GIOChannel *io, GError *err, gpointer user_data)
> >                 goto drop;
> >         }
> >
> > -       if (!avdtp_stream_set_transport(setup->stream,
> > -                                       g_io_channel_unix_get_fd(io),
> > +       if (!avdtp_stream_set_transport(stream, g_io_channel_unix_get_fd(io),
> >                                         imtu, omtu))
> >                 goto drop;
> >
> > @@ -2249,6 +2255,7 @@ static void transport_cb(GIOChannel *io, GError *err, gpointer user_data)
> >         setup->io = NULL;
> >
> >         setup_unref(setup);
> > +       avdtp_stream_set_pending_open_data(stream, NULL);
>
> Ditto.
>
> >         return;
> >
> > @@ -2297,7 +2304,8 @@ static void confirm_cb(GIOChannel *io, gpointer data)
> >                         goto drop;
> >                 }
> >
> > -               if (!bt_io_accept(io, transport_cb, setup, NULL, &err)) {
> > +               if (!bt_io_accept(io, transport_cb, setup->stream, NULL,
> > +                                       &err)) {
> >                         error("bt_io_accept: %s", err->message);
> >                         g_error_free(err);
> >                         goto drop;
> > diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> > index 782268c08..74b9f8dfa 100644
> > --- a/profiles/audio/avdtp.c
> > +++ b/profiles/audio/avdtp.c
> > @@ -366,6 +366,8 @@ struct avdtp_stream {
> >         GSList *caps;
> >         GSList *callbacks;
> >         struct avdtp_service_capability *codec;
> > +       void *pending_open_data;        /* Data when the transport channel
> > +                                        * opening is pending */
> >         guint io_id;            /* Transport GSource ID */
> >         guint timer;            /* Waiting for other side to close or open
> >                                  * the transport channel */
> > @@ -727,6 +729,11 @@ static void stream_free(void *data)
> >         g_slist_free_full(stream->callbacks, g_free);
> >         g_slist_free_full(stream->caps, g_free);
> >
> > +       /* pending_open_data must have been unref-ed and unset before freeing
> > +        * avdtp_stream. Otherwise, it is a reference leak bug.
> > +        */
> > +       assert(!stream->pending_open_data);
> > +
> >         g_free(stream);
> >  }
> >
> > @@ -3147,6 +3154,16 @@ struct avdtp_remote_sep *avdtp_stream_get_remote_sep(
> >         return NULL;
> >  }
> >
> > +void avdtp_stream_set_pending_open_data(struct avdtp_stream *stream, void *data)
> > +{
> > +       stream->pending_open_data = data;
> > +}
> > +
> > +void *avdtp_stream_get_pending_open_data(struct avdtp_stream *stream)
> > +{
> > +       return stream->pending_open_data;
> > +}
> > +
> >  gboolean avdtp_stream_set_transport(struct avdtp_stream *stream, int fd,
> >                                                 size_t imtu, size_t omtu)
> >  {
> > diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
> > index 011fea89e..92ce65ed3 100644
> > --- a/profiles/audio/avdtp.h
> > +++ b/profiles/audio/avdtp.h
> > @@ -260,6 +260,9 @@ gboolean avdtp_stream_has_capabilities(struct avdtp_stream *stream,
> >                                         GSList *caps);
> >  struct avdtp_remote_sep *avdtp_stream_get_remote_sep(
> >                                                 struct avdtp_stream *stream);
> > +void avdtp_stream_set_pending_open_data(struct avdtp_stream *stream,
> > +                                       void *data);
> > +void *avdtp_stream_get_pending_open_data(struct avdtp_stream *stream);
> >
> >  unsigned int avdtp_add_state_cb(struct btd_device *dev,
> >                                 avdtp_session_state_cb cb, void *user_data);
> > --
> > 2.26.2
> >
>
>
> --
> Luiz Augusto von Dentz
