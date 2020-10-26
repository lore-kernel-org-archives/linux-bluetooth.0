Return-Path: <SRS0=rjyd=EB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D165EC5517A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Oct 2020 18:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64A952224E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Oct 2020 18:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4BimYxC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1789849AbgJZScy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Oct 2020 14:32:54 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37840 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1784916AbgJZScx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Oct 2020 14:32:53 -0400
Received: by mail-ot1-f67.google.com with SMTP id m22so8907196ots.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2020 11:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ng8YfM1/FvMj7C/kvahOMDj4CUuE9OZO1xT9IBSzh4M=;
        b=X4BimYxCQn4cUvF+2DnuTG/0Ikqw1AZ7oe1B43S92HTpSstL8FZ7pf3W+OLxhRe5XY
         MBi/Bx2ffW7eSWGehkvlia1bPewgMD8BTgqwjpc7m3HB9mAwxPQ0IwKM7h1fcAB6rpCk
         069qwNTl5drLNLhagQu6+rPxD8rup2QQUzjIc/zk2HXxsXgjG/Xoebh+i0Iz1kDu6m0z
         rOVHGYnjJgmKJnd3lS5OGNTIPrrKpMvjVwRS1ZH/G/ps/kxTNCSzBly9SpXcTyzAgJq5
         P5oaFxLx5n2VB7jJZopUciAB+wlWZlq048XDQ2km4JxifU9AxqTzGXW6V94fWlE2wzmj
         HHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ng8YfM1/FvMj7C/kvahOMDj4CUuE9OZO1xT9IBSzh4M=;
        b=eZMcqjA5Etaz3cZDZ0jUz4mAkxdvAh2MXRkJxK7RMC0HZt962u517IkjX3NAbA/xrC
         iK7N1D7CQPjQ3cItp04xDkd9Zrwjgio3fqJI4t2P6Bj4iSja3H+8imo1c8xS4wZ+lTFR
         7iHfP9Bdu2klrAg+UT6HHnKLKU+5ZESJga5sMAnZgNj0RhTDQ+WagSCwqjkh+lL5oRWs
         9biy3P0BhTtm9vkBH4RJ5JTLpV2EBqvdHXTzcR10e8ZnHrEI7w3mVEsCPPtCxjKDAML/
         +Dyze7wP1suPRnDKJwqXlaKsXOAEE92pz68DpIqlRROKjIZEkrBWNcWDEHH/WtY2YDaC
         L5wQ==
X-Gm-Message-State: AOAM5331qtq34Y4IO0QZFktE7vzj7yngTpPciBJ1L+K7sxjqx9LqnlBO
        8XxnCpfltHvRaRP+OC+kYkMEqRW7oTPJTMBR/f4=
X-Google-Smtp-Source: ABdhPJy3v67YwszHBPtYP9zg8l5yM/Jz9EPrDyuEdyhxRwpME6RA0LWyK3D+QdOloYxD4TEHZo/fg6B1NcePINzPts0=
X-Received: by 2002:a05:6830:400d:: with SMTP id h13mr16145275ots.371.1603737171839;
 Mon, 26 Oct 2020 11:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20201024220956.3051848-1-marijns95@gmail.com>
In-Reply-To: <20201024220956.3051848-1-marijns95@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 26 Oct 2020 11:32:40 -0700
Message-ID: <CABBYNZ+HOcQ5dFCjU5yiRDVTVbkOwWgRaAnQvpDbdhRdv_qiuQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] audio/media: Destroy transport if SetConfiguration fails
To:     Marijn Suijten <marijns95@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marijn,

On Sat, Oct 24, 2020 at 3:10 PM Marijn Suijten <marijns95@gmail.com> wrote:
>
> set_configuration creates a transport before calling SetConfiguration on
> the MediaEndpoint1 DBus interface.  If this DBus call fails the
> transport sticks around while it should instead be cleaned up.
>
> When the peer retries or reconnects (in case of BlueZ: See
> avdtp_parse_rej for SET_CONFIGURATION returning TRUE on failure,
> resulting in connection_lost with EIO) set_configuration finds this old
> transport and returns FALSE.  The peer will never succeed this call
> unless it randomly decides to call clear_configuration or BlueZ is
> restarted.
> ---
>
> Hi all,
>
> This issue was found while playing around with broken configurations in
> PulseAudio.  All attempts to set a configuration after the first failure
> are rejected.  Note that BlueZ disconnects if SET_CONFIGURATION fails,
> is that expected?  I did not analyze any of this code yet but it seems
> rather harsh for something that's not fatal and perhaps better
> propagated to the calling application?
>
> As far as I know Pali's A2DP codec additions to PulseAudio expect this
> this behaviour; if SetConfiguration fails it'll simply attempt the next
> profile until finding one that succeeds.

Weird, so does PA will attempt to select a configuration on its own
instead of using Device.Connect which does
MediaEndpoint.SelectConfiguration on the matching endpoints? Or is
this part of the codec switch logic? I thought the latter would
attempt to switch the codec and in case it fails it would then roll
back, but maybe things have changed.

> I moved the functions up above endpoint_reply instead of
> forward-declaring them as they were pretty close already and aren't that
> many line changes, let me know if that's okay.
>
>  profiles/audio/media.c | 77 +++++++++++++++++++++++++-----------------
>  1 file changed, 46 insertions(+), 31 deletions(-)
>
> diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> index 74064d398..0632fbe8a 100644
> --- a/profiles/audio/media.c
> +++ b/profiles/audio/media.c
> @@ -271,6 +271,37 @@ static void clear_endpoint(struct media_endpoint *endpoint)
>                 clear_configuration(endpoint, endpoint->transports->data);
>  }
>
> +static int transport_device_cmp(gconstpointer data, gconstpointer user_data)
> +{
> +       struct media_transport *transport = (struct media_transport *) data;
> +       const struct btd_device *device = user_data;
> +       const struct btd_device *dev = media_transport_get_dev(transport);
> +
> +       if (device == dev)
> +               return 0;
> +
> +       return -1;
> +}
> +
> +static struct media_transport *find_device_transport(
> +                                       struct media_endpoint *endpoint,
> +                                       struct btd_device *device)
> +{
> +       GSList *match;
> +
> +       match = g_slist_find_custom(endpoint->transports, device,
> +                                                       transport_device_cmp);
> +       if (match == NULL)
> +               return NULL;
> +
> +       return match->data;
> +}
> +
> +struct a2dp_config_data {
> +       struct a2dp_setup *setup;
> +       a2dp_endpoint_config_t cb;
> +};
> +
>  static void endpoint_reply(DBusPendingCall *call, void *user_data)
>  {
>         struct endpoint_request *request = user_data;
> @@ -298,6 +329,21 @@ static void endpoint_reply(DBusPendingCall *call, void *user_data)
>                         return;
>                 }

I'd probably just have a reference to the transport in the request
that way we don't need to look it up if SetConfiguration fails.

> +               if (dbus_message_is_method_call(request->msg,
> +                                       MEDIA_ENDPOINT_INTERFACE,
> +                                       "SetConfiguration")) {
> +                       struct a2dp_config_data *data = request->user_data;
> +                       struct btd_device *device =
> +                                       a2dp_setup_get_device(data->setup);
> +                       struct media_transport *transport =
> +                                       find_device_transport(endpoint, device);
> +
> +                       if (transport == NULL)
> +                               error("Expected to destroy transport");
> +                       else
> +                               media_transport_destroy(transport);
> +               }
> +
>                 dbus_error_free(&err);
>                 goto done;
>         }
> @@ -396,37 +442,6 @@ static gboolean select_configuration(struct media_endpoint *endpoint,
>         return media_endpoint_async_call(msg, endpoint, cb, user_data, destroy);
>  }
>
> -static int transport_device_cmp(gconstpointer data, gconstpointer user_data)
> -{
> -       struct media_transport *transport = (struct media_transport *) data;
> -       const struct btd_device *device = user_data;
> -       const struct btd_device *dev = media_transport_get_dev(transport);
> -
> -       if (device == dev)
> -               return 0;
> -
> -       return -1;
> -}
> -
> -static struct media_transport *find_device_transport(
> -                                       struct media_endpoint *endpoint,
> -                                       struct btd_device *device)
> -{
> -       GSList *match;
> -
> -       match = g_slist_find_custom(endpoint->transports, device,
> -                                                       transport_device_cmp);
> -       if (match == NULL)
> -               return NULL;
> -
> -       return match->data;
> -}
> -
> -struct a2dp_config_data {
> -       struct a2dp_setup *setup;
> -       a2dp_endpoint_config_t cb;
> -};
> -
>  int8_t media_player_get_device_volume(struct btd_device *device)
>  {
>         struct avrcp_player *target_player;
> --
> 2.29.1
>
> Marijn Suijten



-- 
Luiz Augusto von Dentz
