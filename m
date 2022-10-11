Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872BBC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Oct 2022 19:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiJKT2S (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Oct 2022 15:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJKT2R (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Oct 2022 15:28:17 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7286E8769C
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Oct 2022 12:28:16 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id x18so9533368ljm.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Oct 2022 12:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qxXDG+RmTHpJS9lWYni8h23VwXV4sYIHbsSa/uC6mKc=;
        b=FoBbooQVnkfME9/Z94J+vOJOuijyZO+OZufCFH2oerbdkcdW1mVp3TyyljPYLR5KFJ
         pDYxIyn56rXNQ4vQ+DEzJojwKPLNEz0WIApbYt+zZjarJOvtJOF5KVXArswdRoscAlkt
         cf/o1G/VjETvxBmC6WzD/ooxZhGZnipcI648X5taHENVL0vQ9fARwhtdx+Z0H6Ae+E+2
         Ugop/R0Gg3P0yleWEQuNM3ihdA5khPyTA6IBLAhKQaVFKnV3Hsl6U/ufPY6a95be5i+b
         fG/nyUfg/0Ie+mYSJ2wuIAK93nMOQkQgJQJwhBh9+1Vmys2L33MKaf50Zux/MhEe1yFS
         tSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qxXDG+RmTHpJS9lWYni8h23VwXV4sYIHbsSa/uC6mKc=;
        b=f6Ghkpm0iRRQjmKi0KEpETtyCta42Nhl0n0q+10UapJPVVYYodcgeZUBjYcnbJW0Ks
         E2Siwt/RTTN8Jx1hG88V3xxx0sfe8g2HN9bay/vIbYbWqv3PNIO+bYgZhxTSyVLHsP7+
         lbpB+okwDn2FHwQT0ASiikCVldovs6Squ447CyC7Mv3aNS3WEOqaWIXbV2c5OvbrylTB
         Vu4kHwJv1x/umh+0+bxaWSn6DyUkl6KYQq7mAFMRe/BY/aUACHb7f8whaxLE+bwS1XVm
         34TLnEIM9tGsHckfgt0vZaYXuhk0z3I6jpjmU2PpDyR3KUBIMDrkjLNnojnWGvnDtm8q
         NgOw==
X-Gm-Message-State: ACrzQf3Jyb9b6xXU9ETAn9D3owiZAg7ICQPnbG9oFfQXpF9IVqcpYxN/
        FW8T/OTFb7o8wP4jexqP84W9J3oMeA1VQqt6P2E=
X-Google-Smtp-Source: AMsMyM7pgzEEmuwUkqo27r11KYDfrvZjgDp2Pcmwiox7/Q+c6SX752iD227wLWK5NTM3rR8bYR5F5wMWmFYm871wcI0=
X-Received: by 2002:a2e:834b:0:b0:26d:e1f8:1453 with SMTP id
 l11-20020a2e834b000000b0026de1f81453mr8764706ljh.65.1665516494469; Tue, 11
 Oct 2022 12:28:14 -0700 (PDT)
MIME-Version: 1.0
References: <20221011113116.70514-1-sathish.narasimman@intel.com>
In-Reply-To: <20221011113116.70514-1-sathish.narasimman@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 11 Oct 2022 12:28:02 -0700
Message-ID: <CABBYNZJpebSE=hke9V6-FY4gc6AMS6_mVxiMnh7HhK7kHjDSGA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 1/3] audio/transport: Adding volume callback to
 media transport
To:     Sathish Narasimman <sathish.narasimman@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sathish,

On Tue, Oct 11, 2022 at 4:38 AM Sathish Narasimman
<sathish.narasimman@intel.com> wrote:
>
> Initialize set_volume and get_volume to media transport and update the
> volume when media_transport_update_device_volume is called.
> ---
>  profiles/audio/transport.c | 126 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 120 insertions(+), 6 deletions(-)
>
> diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
> index 41339da51e17..a1445cba7993 100644
> --- a/profiles/audio/transport.c
> +++ b/profiles/audio/transport.c
> @@ -91,6 +91,7 @@ struct bap_transport {
>         uint8_t                 rtn;
>         uint16_t                latency;
>         uint32_t                delay;
> +       int8_t                  volume;
>  };
>
>  struct media_transport {
> @@ -116,6 +117,9 @@ struct media_transport {
>                                                                 guint id);
>         void                    (*set_state) (struct media_transport *transport,
>                                                 transport_state_t state);
> +       void                    (*set_volume) (struct media_transport *transp,
> +                                               int8_t volume);
> +       int8_t                  (*get_volume) (struct media_transport *transp);
>         GDestroyNotify          destroy;
>         void                    *data;
>  };
> @@ -769,6 +773,58 @@ error:
>                                         "Invalid arguments in method call");
>  }
>
> +static gboolean volume_bap_exists(const GDBusPropertyTable *property,
> +                                       void *data)
> +{
> +       struct media_transport *transport = data;
> +       struct bap_transport *bap = transport->data;
> +
> +       return bap->volume >= 0;
> +}
> +
> +static gboolean get_bap_volume(const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *data)
> +{
> +       struct media_transport *transport = data;
> +       struct bap_transport *bap = transport->data;
> +       uint16_t volume = (uint16_t)bap->volume;
> +
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &volume);
> +
> +       return TRUE;
> +}
> +
> +static void set_bap_volume(const GDBusPropertyTable *property,
> +                          DBusMessageIter *iter, GDBusPendingPropertySet id,
> +                          void *data)
> +{
> +       struct media_transport *transport = data;
> +       struct bap_transport *bap = transport->data;
> +       uint16_t arg;
> +       int8_t volume;
> +
> +       if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT16)
> +               goto error;
> +
> +       dbus_message_iter_get_basic(iter, &arg);
> +       if (arg > INT8_MAX)
> +               goto error;
> +
> +       g_dbus_pending_property_success(id);
> +
> +       volume = (int8_t)arg;
> +       if (bap->volume == volume)
> +               return;
> +
> +       /*TODO vcp_send_volume */

What is this TODO item for? Can we complete it right now? Afaik we
should be able to handle local changes and notify it to remote peers
or that is not how VCP works?

> +       return;
> +
> +error:
> +       g_dbus_pending_property_error(id, ERROR_INTERFACE ".InvalidArguments",
> +                                       "Invalid arguments in method call");
> +}
> +
> +
>  static gboolean endpoint_exists(const GDBusPropertyTable *property, void *data)
>  {
>         struct media_transport *transport = data;
> @@ -970,6 +1026,7 @@ static const GDBusPropertyTable bap_properties[] = {
>         { "Retransmissions", "y", get_retransmissions },
>         { "Latency", "q", get_latency },
>         { "Delay", "u", get_delay },
> +       { "Volume", "q", get_bap_volume, set_bap_volume, volume_bap_exists },

Now that we have set_volume/get_volume as callbacks these could be
changed to use them instead of having dedicated callback like abouve,
something like:

https://gist.github.com/Vudentz/19edcf96735567c1f7437a5e1dee7e04

>         { "Endpoint", "o", get_endpoint, NULL, endpoint_exists },
>         { "Location", "u", get_location },
>         { "Metadata", "ay", get_metadata },
> @@ -1048,6 +1105,31 @@ static void source_state_changed(struct btd_service *service,
>                 transport_update_playing(transport, FALSE);
>  }
>
> +static int8_t get_volume_a2dp(struct media_transport *transport)
> +{
> +       struct a2dp_transport *a2dp = transport->data;
> +
> +       return a2dp->volume;
> +}
> +
> +static void set_volume_a2dp(struct media_transport *transport, int8_t volume)
> +{
> +       struct a2dp_transport *a2dp = transport->data;
> +
> +       if (volume < 0)
> +               return;
> +
> +       /* Check if volume really changed */
> +       if (a2dp->volume == volume)
> +               return;
> +
> +       a2dp->volume = volume;
> +
> +       g_dbus_emit_property_changed(btd_get_dbus_connection(),
> +                                       transport->path,
> +                                       MEDIA_TRANSPORT_INTERFACE, "Volume");
> +}
> +
>  static int media_transport_init_source(struct media_transport *transport)
>  {
>         struct btd_service *service;
> @@ -1061,6 +1143,8 @@ static int media_transport_init_source(struct media_transport *transport)
>
>         transport->resume = resume_a2dp;
>         transport->suspend = suspend_a2dp;
> +       transport->set_volume = set_volume_a2dp;
> +       transport->get_volume = get_volume_a2dp;
>         transport->cancel = cancel_a2dp;
>         transport->data = a2dp;
>         transport->destroy = destroy_a2dp;
> @@ -1387,6 +1471,31 @@ static void free_bap(void *data)
>         free(bap);
>  }
>
> +static void set_volume_bap(struct media_transport *transport, int8_t volume)
> +{
> +       struct bap_transport *bap = transport->data;
> +
> +       if (volume < 0)
> +               return;
> +
> +       /* Check if volume really changed */
> +       if (bap->volume == volume)
> +               return;
> +
> +       bap->volume = volume;
> +
> +       g_dbus_emit_property_changed(btd_get_dbus_connection(),
> +                                       transport->path,
> +                                       MEDIA_TRANSPORT_INTERFACE, "Volume");
> +}
> +
> +static int8_t get_volume_bap(struct media_transport *transport)
> +{
> +       struct bap_transport *bap = transport->data;
> +
> +       return bap->volume;
> +}
> +
>  static int media_transport_init_bap(struct media_transport *transport,
>                                                         void *stream)
>  {
> @@ -1403,6 +1512,7 @@ static int media_transport_init_bap(struct media_transport *transport,
>         bap->rtn = qos->rtn;
>         bap->latency = qos->latency;
>         bap->delay = qos->delay;
> +       bap->volume = 127;
>         bap->state_id = bt_bap_state_register(bt_bap_stream_get_session(stream),
>                                                 bap_state_changed,
>                                                 bap_connecting,
> @@ -1413,6 +1523,8 @@ static int media_transport_init_bap(struct media_transport *transport,
>         transport->suspend = suspend_bap;
>         transport->cancel = cancel_bap;
>         transport->set_state = set_state_bap;
> +       transport->set_volume = set_volume_bap;
> +       transport->get_volume = get_volume_bap;
>         transport->destroy = free_bap;
>
>         return 0;
> @@ -1537,12 +1649,13 @@ int8_t media_transport_get_device_volume(struct btd_device *dev)
>         /* Attempt to locate the transport to get its volume */
>         for (l = transports; l; l = l->next) {
>                 struct media_transport *transport = l->data;
> +
>                 if (transport->device != dev)
>                         continue;
>
> -               /* Volume is A2DP only */
> -               if (media_endpoint_get_sep(transport->endpoint))
> -                       return media_transport_get_volume(transport);
> +               /* Get transport volume */
> +               if (transport->get_volume)
> +                       return transport->get_volume(transport);
>         }
>
>         /* If transport volume doesn't exists use device_volume */
> @@ -1560,12 +1673,13 @@ void media_transport_update_device_volume(struct btd_device *dev,
>         /* Attempt to locate the transport to set its volume */
>         for (l = transports; l; l = l->next) {
>                 struct media_transport *transport = l->data;
> +
>                 if (transport->device != dev)
>                         continue;
>
> -               /* Volume is A2DP only */
> -               if (media_endpoint_get_sep(transport->endpoint)) {
> -                       media_transport_update_volume(transport, volume);
> +               /* Set transport volume */
> +               if (transport->set_volume) {
> +                       transport->set_volume(transport, volume);
>                         return;
>                 }
>         }
> --
> 2.25.1
>


-- 
Luiz Augusto von Dentz
