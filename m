Return-Path: <SRS0=rjyd=EB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806A8C388F9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Oct 2020 19:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D61A20878
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Oct 2020 19:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJd6NAT0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1792618AbgJZTN2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Oct 2020 15:13:28 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:37197 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1734729AbgJZTEl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Oct 2020 15:04:41 -0400
Received: by mail-qv1-f66.google.com with SMTP id t6so4837231qvz.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2020 12:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WNhlJyiU7T9jYJRhKzNO8xzlxM+Eeb+lWT9Z5qbtn78=;
        b=EJd6NAT0eAcRhgnIfOA45sw3rq+ftg/DllSX8CC67G9kZo2s5u1F0q2/KCpxxXv6gk
         uhGHQcmJbrxSZrrL8X+8uCVTkjUu7ThVgMgucapfnA5OHUeYw1HJYVEQp3iIJZF07Kfn
         /EC/dnOJaCf0liDpBS/AbqIoAH7X/ZdxhdEV2SifrCZ0LXni+aXK0+pAzH9hMT603tTD
         1ldBho7ubbYB9bWyvusgWGaeTnFl1aE5KhirTB+Pzjb0VQ74NtKPhgr6AZun1uwkL/7k
         cZwcijBFiFyurYB/sTN2QZBb+pcqhZGVoQQSffPoyAUpfRHnvtr6C6FFOKa3RJsXsExx
         84SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WNhlJyiU7T9jYJRhKzNO8xzlxM+Eeb+lWT9Z5qbtn78=;
        b=N+DpZ9cOxU35/IN6jL5cV/mQ4lRtHitG1KVU8wxv9qLzHNchzOneDreoOzo3IPC3Br
         MKJ/jxGrmXiY+GqLB5fo+MIQ7+yi5BaJeJOMBmV0mdKcAhVn5hTmmTP56fn0/df2kL+m
         3I2mNqGyJL0q/oYVGtEVakyXT7hGj+qiwGMtfqb8ZbH07Ns+37XyJ3ADQw0cuejrfoqK
         1/0MJ/JF9AjxfEMzNctPOCmJynlc++fI1xpOzwRC49DwiOxe4ODSelP4+ETCBLyc6cW+
         4zhn1WIrg1tTDy3wweIAX49SPQhKzmZYtWfMsWpb5tpb0tg6IxxWle9kJx+Q8GG3p64G
         8Giw==
X-Gm-Message-State: AOAM530SKybGypKp274neZqJQfqET3X2sIB/j+8NsOY4hokqCbUbzaeU
        pZ9/zeRxBt+sFXmJ2JlyvH6zrnbxYiaYrJRbB+k=
X-Google-Smtp-Source: ABdhPJzvORov97dWKWiVTqAEf0fxRiuwrhrbxBEuaedYMa5H9lkKoYBYgW08pmTDFAJiqwsJ8MuJqAIKfh9dtQZafkA=
X-Received: by 2002:ad4:45ec:: with SMTP id q12mr15637642qvu.33.1603739079425;
 Mon, 26 Oct 2020 12:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <20201024220956.3051848-1-marijns95@gmail.com> <CABBYNZ+HOcQ5dFCjU5yiRDVTVbkOwWgRaAnQvpDbdhRdv_qiuQ@mail.gmail.com>
In-Reply-To: <CABBYNZ+HOcQ5dFCjU5yiRDVTVbkOwWgRaAnQvpDbdhRdv_qiuQ@mail.gmail.com>
From:   Marijn Suijten <marijns95@gmail.com>
Date:   Mon, 26 Oct 2020 20:04:27 +0100
Message-ID: <CANX-K3uoJH9e2EJXAnE68DQAxW+CBkfMWQYGFho5cmpvRuexzg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] audio/media: Destroy transport if SetConfiguration fails
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Mon, 26 Oct 2020 at 19:32, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Marijn,
>
> On Sat, Oct 24, 2020 at 3:10 PM Marijn Suijten <marijns95@gmail.com> wrote:
> >
> > set_configuration creates a transport before calling SetConfiguration on
> > the MediaEndpoint1 DBus interface.  If this DBus call fails the
> > transport sticks around while it should instead be cleaned up.
> >
> > When the peer retries or reconnects (in case of BlueZ: See
> > avdtp_parse_rej for SET_CONFIGURATION returning TRUE on failure,
> > resulting in connection_lost with EIO) set_configuration finds this old
> > transport and returns FALSE.  The peer will never succeed this call
> > unless it randomly decides to call clear_configuration or BlueZ is
> > restarted.

For the record this observation was totally wrong.  It turned out that
all references to the avdtp session were given up, hence the
disconnection (while there was still a pointer to the object
remaining).  A patch for this is on the list as well [1].

> > ---
> >
> > Hi all,
> >
> > This issue was found while playing around with broken configurations in
> > PulseAudio.  All attempts to set a configuration after the first failure
> > are rejected.  Note that BlueZ disconnects if SET_CONFIGURATION fails,
> > is that expected?  I did not analyze any of this code yet but it seems
> > rather harsh for something that's not fatal and perhaps better
> > propagated to the calling application?
> >
> > As far as I know Pali's A2DP codec additions to PulseAudio expect this
> > this behaviour; if SetConfiguration fails it'll simply attempt the next
> > profile until finding one that succeeds.
>
> Weird, so does PA will attempt to select a configuration on its own
> instead of using Device.Connect which does
> MediaEndpoint.SelectConfiguration on the matching endpoints? Or is
> this part of the codec switch logic? I thought the latter would
> attempt to switch the codec and in case it fails it would then roll
> back, but maybe things have changed.

SetConfiguration is part of the codec switching logic.
SelectConfiguration indeed seems to be called once upon connection by
BlueZ, after that it's just SetConfiguration.

Codec switching doesn't need to roll back anything (afaik), it simply
tries SetConfiguration repeatedly on all the "matching" SEPs it found
until one succeeds (or the list is exhausted).  According to Pali
there's likely an issue in his codec selection mechanism where too
many SEPs are selected that do not accept the given capabilities,
which is inconvenient/slow and should be fixed, but not fatal.  Note
that his PulseAudio implementation exposes multiple SEPs for SBC to be
able to pick a specific channel+bitpool configuration.

> > I moved the functions up above endpoint_reply instead of
> > forward-declaring them as they were pretty close already and aren't that
> > many line changes, let me know if that's okay.
> >
> >  profiles/audio/media.c | 77 +++++++++++++++++++++++++-----------------
> >  1 file changed, 46 insertions(+), 31 deletions(-)
> >
> > diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> > index 74064d398..0632fbe8a 100644
> > --- a/profiles/audio/media.c
> > +++ b/profiles/audio/media.c
> > @@ -271,6 +271,37 @@ static void clear_endpoint(struct media_endpoint *endpoint)
> >                 clear_configuration(endpoint, endpoint->transports->data);
> >  }
> >
> > +static int transport_device_cmp(gconstpointer data, gconstpointer user_data)
> > +{
> > +       struct media_transport *transport = (struct media_transport *) data;
> > +       const struct btd_device *device = user_data;
> > +       const struct btd_device *dev = media_transport_get_dev(transport);
> > +
> > +       if (device == dev)
> > +               return 0;
> > +
> > +       return -1;
> > +}
> > +
> > +static struct media_transport *find_device_transport(
> > +                                       struct media_endpoint *endpoint,
> > +                                       struct btd_device *device)
> > +{
> > +       GSList *match;
> > +
> > +       match = g_slist_find_custom(endpoint->transports, device,
> > +                                                       transport_device_cmp);
> > +       if (match == NULL)
> > +               return NULL;
> > +
> > +       return match->data;
> > +}
> > +
> > +struct a2dp_config_data {
> > +       struct a2dp_setup *setup;
> > +       a2dp_endpoint_config_t cb;
> > +};
> > +
> >  static void endpoint_reply(DBusPendingCall *call, void *user_data)
> >  {
> >         struct endpoint_request *request = user_data;
> > @@ -298,6 +329,21 @@ static void endpoint_reply(DBusPendingCall *call, void *user_data)
> >                         return;
> >                 }
>
> I'd probably just have a reference to the transport in the request
> that way we don't need to look it up if SetConfiguration fails.

Sure, I'll add it to endpoint_request and send v2.

> > +               if (dbus_message_is_method_call(request->msg,
> > +                                       MEDIA_ENDPOINT_INTERFACE,
> > +                                       "SetConfiguration")) {
> > +                       struct a2dp_config_data *data = request->user_data;
> > +                       struct btd_device *device =
> > +                                       a2dp_setup_get_device(data->setup);
> > +                       struct media_transport *transport =
> > +                                       find_device_transport(endpoint, device);
> > +
> > +                       if (transport == NULL)
> > +                               error("Expected to destroy transport");
> > +                       else
> > +                               media_transport_destroy(transport);
> > +               }
> > +
> >                 dbus_error_free(&err);
> >                 goto done;
> >         }
> > @@ -396,37 +442,6 @@ static gboolean select_configuration(struct media_endpoint *endpoint,
> >         return media_endpoint_async_call(msg, endpoint, cb, user_data, destroy);
> >  }
> >
> > -static int transport_device_cmp(gconstpointer data, gconstpointer user_data)
> > -{
> > -       struct media_transport *transport = (struct media_transport *) data;
> > -       const struct btd_device *device = user_data;
> > -       const struct btd_device *dev = media_transport_get_dev(transport);
> > -
> > -       if (device == dev)
> > -               return 0;
> > -
> > -       return -1;
> > -}
> > -
> > -static struct media_transport *find_device_transport(
> > -                                       struct media_endpoint *endpoint,
> > -                                       struct btd_device *device)
> > -{
> > -       GSList *match;
> > -
> > -       match = g_slist_find_custom(endpoint->transports, device,
> > -                                                       transport_device_cmp);
> > -       if (match == NULL)
> > -               return NULL;
> > -
> > -       return match->data;
> > -}
> > -
> > -struct a2dp_config_data {
> > -       struct a2dp_setup *setup;
> > -       a2dp_endpoint_config_t cb;
> > -};
> > -
> >  int8_t media_player_get_device_volume(struct btd_device *device)
> >  {
> >         struct avrcp_player *target_player;
> > --
> > 2.29.1
> >
> > Marijn Suijten
>
>
>
> --
> Luiz Augusto von Dentz

Marijn Suijten

[1]: https://marc.info/?l=linux-bluetooth&m=160364326629847&w=2
