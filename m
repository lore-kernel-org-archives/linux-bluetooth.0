Return-Path: <SRS0=zLyx=BB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA82C433E1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jul 2020 18:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C614620781
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jul 2020 18:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRwl1Nxi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbgGVS7f (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Jul 2020 14:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgGVS7e (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Jul 2020 14:59:34 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826C0C0619DC
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2020 11:59:34 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id c25so2561232otf.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2020 11:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GdB12dnoTOawpzluSOuk/ROLKi6hRVx1l8xfty7YSoY=;
        b=XRwl1Nxi5JhBrFY3yuaiYsy/P4jUuJtaCKDVQtFPw0eW8yFCoEISB3Zx0w2v9UW68H
         LYQw3La8KB/Ht8jAg2sit9iC0aaRNQj+ajJEtZStyGfiod/w7/giTMD3mSTdVrYLmqLH
         GcG1rbnKrjRvTPhD4500CfSD9uBHibN+VYyRszP4H7vh27c00TyrORkVTRvgU+yVT4j0
         ebnhDTgY19J2/JuNX2TosKurglmVM36C2VDg78QApHfYOZch+JSOGakrB4DHP7ODhgyg
         GFomMbUcGJWLYaEJnqHm4y8NGjFLktN7kFodlu7MB30PMeepnqTs7tdQmZYoQGpByOjj
         cc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GdB12dnoTOawpzluSOuk/ROLKi6hRVx1l8xfty7YSoY=;
        b=KPVs8Rp/5wPKOkb2vB2OFEHzxhgPXovoM1ZHw9dn56YdKNnLWSJyX2jI0J0/WJ4UA6
         WbevGQ9el1jQSXqYmZdGvLd959HK270ANE8nU5dUiKKyYQskUkr73cqn+ViC51J0MCO1
         PBntpy/53BDzP9BlFWFlAghEzZJKUu54NI14KBgrvY6ZdIW2Fd7oB3N/ygBihhWEeNXC
         ecab/wJtYAfRWbJP8Mie9V57VdjWgmvxvYb9LrC5YbJ8URbntLuuV/+RLIgZ/MA7kPpd
         ghvd0ZkcSwfDiap5ERMAACNf+uKbmJay6auI7XRGIAYpqHwhjiR6E8tIpUXXE6BtiMAh
         ArNA==
X-Gm-Message-State: AOAM531n5Fxxt8oHaXm1Hb0AJEWDEgd/Kp3oNorzwux7vshrH0M1rStr
        Om+sUFhKPlrxAtAOLlSLE76/K3u7U/OuaxZl+qQ=
X-Google-Smtp-Source: ABdhPJzMGfzHa7uxB7qsLd6PO/Pk5SiMUAmSTQ0VLdBjO+tD/tMh8HOLPDKd+7+C+IpCjnHXIlhdUlrxIvJeIpw61Bc=
X-Received: by 2002:a9d:5e18:: with SMTP id d24mr1228166oti.88.1595444373802;
 Wed, 22 Jul 2020 11:59:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200722113644.Bluez.v3.1.I667fa0ebcc3056a21c22fdaf476a56dd72aff38d@changeid>
In-Reply-To: <20200722113644.Bluez.v3.1.I667fa0ebcc3056a21c22fdaf476a56dd72aff38d@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 22 Jul 2020 11:59:22 -0700
Message-ID: <CABBYNZKBTbYaP+=OYbATzj5GkyyskW9pkCafhtDoQafVayKyvA@mail.gmail.com>
Subject: Re: [Bluez PATCH v3 1/2] audio/transport: change volume to 8bit
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Michael Sun <michaelfsun@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Tue, Jul 21, 2020 at 8:37 PM Archie Pusaka <apusaka@google.com> wrote:
>
> From: Archie Pusaka <apusaka@chromium.org>
>
> The valid range of volume is 0 - 127, yet it is stored in 16bit
> data type. This patch modifies it so we use 8bit data type to
> store volume instead.
>
> Furthermore, this patch introduces helper function and defined
> values to check for volume validity, to prevent numbers
> scattered all over.
>
> Reviewed-by: Michael Sun <michaelfsun@google.com>
> ---
>
> Changes in v3: None
> Changes in v2: None
>
>  profiles/audio/avrcp.c     |  2 +-
>  profiles/audio/avrcp.h     |  1 -
>  profiles/audio/transport.c | 46 ++++++++++++++++++++++----------------
>  profiles/audio/transport.h |  3 ++-
>  4 files changed, 30 insertions(+), 22 deletions(-)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 1bf85041e..b312b70b9 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -1660,7 +1660,7 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
>                 break;
>         case AVRCP_EVENT_VOLUME_CHANGED:
>                 pdu->params[1] = media_transport_get_device_volume(dev);
> -               if (pdu->params[1] > 127)
> +               if (!media_transport_volume_valid(pdu->params[1]))
>                         goto err;
>
>                 len = 2;
> diff --git a/profiles/audio/avrcp.h b/profiles/audio/avrcp.h
> index 86d310c73..3fd74e18a 100644
> --- a/profiles/audio/avrcp.h
> +++ b/profiles/audio/avrcp.h
> @@ -114,6 +114,5 @@ void avrcp_unregister_player(struct avrcp_player *player);
>  void avrcp_player_event(struct avrcp_player *player, uint8_t id,
>                                                         const void *data);
>
> -
>  size_t avrcp_handle_vendor_reject(uint8_t *code, uint8_t *operands);
>  size_t avrcp_browsing_general_reject(uint8_t *operands);
> diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
> index 48fabba9b..a32073380 100644
> --- a/profiles/audio/transport.c
> +++ b/profiles/audio/transport.c
> @@ -55,6 +55,8 @@
>
>  #define MEDIA_TRANSPORT_INTERFACE "org.bluez.MediaTransport1"
>
> +#define UNINITIALIZED_VOLUME_VALUE     128
> +
>  typedef enum {
>         TRANSPORT_STATE_IDLE,           /* Not acquired and suspended */
>         TRANSPORT_STATE_PENDING,        /* Playing but not acquired */
> @@ -86,7 +88,7 @@ struct media_owner {
>  struct a2dp_transport {
>         struct avdtp            *session;
>         uint16_t                delay;
> -       uint16_t                volume;
> +       uint8_t                 volume;

It might be simpler to just have it as int8_t so we can keep the
current logic of negative means invalid.

>  };
>
>  struct media_transport {
> @@ -634,7 +636,7 @@ static gboolean volume_exists(const GDBusPropertyTable *property, void *data)
>         struct media_transport *transport = data;
>         struct a2dp_transport *a2dp = transport->data;
>
> -       return a2dp->volume <= 127;
> +       return media_transport_volume_valid(a2dp->volume);
>  }
>
>  static gboolean get_volume(const GDBusPropertyTable *property,
> @@ -654,24 +656,20 @@ static void set_volume(const GDBusPropertyTable *property,
>  {
>         struct media_transport *transport = data;
>         struct a2dp_transport *a2dp = transport->data;
> -       uint16_t volume;
> +       uint16_t arg;
> +       uint8_t volume;
>         bool notify;
>
> -       if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT16) {
> -               g_dbus_pending_property_error(id,
> -                                       ERROR_INTERFACE ".InvalidArguments",
> -                                       "Invalid arguments in method call");
> -               return;
> -       }
> +       if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT16)
> +               goto error;
>
> -       dbus_message_iter_get_basic(iter, &volume);
> +       dbus_message_iter_get_basic(iter, &arg);
> +       if (arg > UINT8_MAX)
> +               goto error;
>
> -       if (volume > 127) {
> -               g_dbus_pending_property_error(id,
> -                                       ERROR_INTERFACE ".InvalidArguments",
> -                                       "Invalid arguments in method call");
> -               return;
> -       }
> +       volume = (uint8_t)arg;
> +       if (!media_transport_volume_valid(volume))
> +               goto error;
>
>         g_dbus_pending_property_success(id);
>
> @@ -688,6 +686,11 @@ static void set_volume(const GDBusPropertyTable *property,
>                                                 "Volume");
>
>         avrcp_set_volume(transport->device, volume, notify);
> +       return;
> +
> +error:
> +       g_dbus_pending_property_error(id, ERROR_INTERFACE ".InvalidArguments",
> +                                       "Invalid arguments in method call");
>  }
>
>  static gboolean endpoint_exists(const GDBusPropertyTable *property, void *data)
> @@ -824,7 +827,7 @@ static int media_transport_init_source(struct media_transport *transport)
>         transport->data = a2dp;
>         transport->destroy = destroy_a2dp;
>
> -       a2dp->volume = -1;
> +       a2dp->volume = UNINITIALIZED_VOLUME_VALUE;
>         transport->sink_watch = sink_add_state_cb(service, sink_state_changed,
>                                                                 transport);
>
> @@ -931,7 +934,7 @@ struct btd_device *media_transport_get_dev(struct media_transport *transport)
>         return transport->device;
>  }
>
> -uint16_t media_transport_get_volume(struct media_transport *transport)
> +uint8_t media_transport_get_volume(struct media_transport *transport)
>  {
>         struct a2dp_transport *a2dp = transport->data;
>         return a2dp->volume;
> @@ -958,7 +961,7 @@ uint8_t media_transport_get_device_volume(struct btd_device *dev)
>         GSList *l;
>
>         if (dev == NULL)
> -               return 128;
> +               return UNINITIALIZED_VOLUME_VALUE;
>
>         for (l = transports; l; l = l->next) {
>                 struct media_transport *transport = l->data;
> @@ -991,3 +994,8 @@ void media_transport_update_device_volume(struct btd_device *dev,
>                         media_transport_update_volume(transport, volume);
>         }
>  }
> +
> +bool media_transport_volume_valid(uint8_t volume)
> +{
> +       return volume < 128;
> +}
> diff --git a/profiles/audio/transport.h b/profiles/audio/transport.h
> index ac542bf6c..c430515f2 100644
> --- a/profiles/audio/transport.h
> +++ b/profiles/audio/transport.h
> @@ -32,7 +32,7 @@ struct media_transport *media_transport_create(struct btd_device *device,
>  void media_transport_destroy(struct media_transport *transport);
>  const char *media_transport_get_path(struct media_transport *transport);
>  struct btd_device *media_transport_get_dev(struct media_transport *transport);
> -uint16_t media_transport_get_volume(struct media_transport *transport);
> +uint8_t media_transport_get_volume(struct media_transport *transport);
>  void media_transport_update_delay(struct media_transport *transport,
>                                                         uint16_t delay);
>  void media_transport_update_volume(struct media_transport *transport,
> @@ -43,3 +43,4 @@ void transport_get_properties(struct media_transport *transport,
>  uint8_t media_transport_get_device_volume(struct btd_device *dev);
>  void media_transport_update_device_volume(struct btd_device *dev,
>                                                                 uint8_t volume);
> +bool media_transport_volume_valid(uint8_t volume);
> --
> 2.28.0.rc0.105.gf9edc3c819-goog
>


-- 
Luiz Augusto von Dentz
