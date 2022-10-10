Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CFEC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Oct 2022 19:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiJJT6a (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Oct 2022 15:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJJT62 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Oct 2022 15:58:28 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4BD7654C
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Oct 2022 12:58:27 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id bs14so1520732ljb.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Oct 2022 12:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IEbS7kAlE6wZlsF07SHwbtiGV81pfc+9Onv1JtRiNAM=;
        b=UDnguqJR4tnSFgKcwWMQydN7FCAlOboQ4bGhDbPyG/Q9sqhPz15Z7JtF4w55j63PeO
         wiI35i9QwgcoJpEsiL/d8ESQEowKzG9VYZ4n+8F65uhG6epTllJNv0SSY6dfFcWzfbwE
         j4mvw2fpzBpxcP6C4O66VIveP3Ld/Euf9gZFw2V5D7X6DJ/wQ6ov+BhZfHLrgvNuadMu
         kKvM1AMZdWCYKJMRbbIwgMEvNC+XN4NUMyalgOT2pYqVHhkIBYbM1TZ+XCS+Lv0risCE
         w41V1UmWG7cYJg79KoxNu98MMePM5cHbY2ya7J9mq7gLuBOFpC/Ka2RlWYsEvOiV3O/D
         i9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IEbS7kAlE6wZlsF07SHwbtiGV81pfc+9Onv1JtRiNAM=;
        b=pRRukDZAOYCPXsCGzv2k8XD558NmnN/W+KUXJVrmzhPDlBRJwu9WKzdfG4rd0iwxy9
         Ufd681w7WVinSfNoZgtEKB6rjVs9KFA9o+V6LE+53K+IGaVpI2eh1yb64GIx7TYoUb8c
         iOEeK307DDx2IrXGgSrfJ68AHvwXQBL+UhjrzBbRpo2UDTNBMLgBdErTKyctSAvpkz3O
         qwvz4ZuLvjJ1ZKugfBoYIfcYPYMXohTTpqIngX7TXRdX3ezeLkLDCPpJQObEA9EpkG0T
         vBj/LERjYpobLRHu3o4QV/ADzjT8jZORatv8ddSVl/zTdKuTS4u0DBVjiIUQu3UEhc54
         +t9A==
X-Gm-Message-State: ACrzQf0UuhjjyY/FKvdMTOqyACkQCbl7g2kn99M6vjb+Lgq1Hu6VX+sU
        PtHjbHb6yWh3NweDsxbAsFy5FUpRDEMdqkMAJ3jCBeLEUoZ7gg==
X-Google-Smtp-Source: AMsMyM4fFRvxvYpZbkalQygLwSa3DiHBiaoNoUHql+8wqoD+zFApssYTMRIcAUqyiTYsFWZEjS1+w9Dhct9ud09thHU=
X-Received: by 2002:a05:651c:23aa:b0:26f:2b7:ddc with SMTP id
 bk42-20020a05651c23aa00b0026f02b70ddcmr3281740ljb.260.1665431905311; Mon, 10
 Oct 2022 12:58:25 -0700 (PDT)
MIME-Version: 1.0
References: <20221007061223.46114-1-sathish.narasimman@intel.com>
In-Reply-To: <20221007061223.46114-1-sathish.narasimman@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 10 Oct 2022 12:58:13 -0700
Message-ID: <CABBYNZL7v5zAaQAqzBikZXDD5wHtjTJCFf9NBFZ_GFvsF6q3qg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 1/3] audio/transport: Add volume callback to BAP transport
To:     Sathish Narasimman <sathish.narasimman@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sathish,

On Thu, Oct 6, 2022 at 11:26 PM Sathish Narasimman
<sathish.narasimman@intel.com> wrote:
>
> Initialize set_volume and get_volume to BAP transport and update the
> volume when media_transport_update_device_volume is called.
> ---
>  profiles/audio/transport.c | 98 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 98 insertions(+)
>
> diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
> index 41339da51e17..46b936c965bf 100644
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
> +       void                    (*set_vol)(struct media_transport *transport,
> +                                               int8_t volume);
> +       int8_t                  (*get_vol)(struct media_transport *transport);

Lets have volume in the function name instead of just vol above.

>         GDestroyNotify          destroy;
>         void                    *data;
>  };
> @@ -717,6 +721,7 @@ static gboolean volume_exists(const GDBusPropertyTable *property, void *data)
>         return a2dp->volume >= 0;
>  }
>
> +
>  static gboolean get_volume(const GDBusPropertyTable *property,
>                                         DBusMessageIter *iter, void *data)
>  {
> @@ -769,6 +774,58 @@ error:
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
> @@ -970,6 +1027,7 @@ static const GDBusPropertyTable bap_properties[] = {
>         { "Retransmissions", "y", get_retransmissions },
>         { "Latency", "q", get_latency },
>         { "Delay", "u", get_delay },
> +       { "Volume", "q", get_bap_volume, set_bap_volume, volume_bap_exists },
>         { "Endpoint", "o", get_endpoint, NULL, endpoint_exists },
>         { "Location", "u", get_location },
>         { "Metadata", "ay", get_metadata },
> @@ -1387,6 +1445,31 @@ static void free_bap(void *data)
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
> @@ -1403,6 +1486,7 @@ static int media_transport_init_bap(struct media_transport *transport,
>         bap->rtn = qos->rtn;
>         bap->latency = qos->latency;
>         bap->delay = qos->delay;
> +       bap->volume = 127;
>         bap->state_id = bt_bap_state_register(bt_bap_stream_get_session(stream),
>                                                 bap_state_changed,
>                                                 bap_connecting,
> @@ -1413,6 +1497,8 @@ static int media_transport_init_bap(struct media_transport *transport,
>         transport->suspend = suspend_bap;
>         transport->cancel = cancel_bap;
>         transport->set_state = set_state_bap;
> +       transport->set_vol = set_volume_bap;
> +       transport->get_vol = get_volume_bap;

Im not seeing any initialization for A2DP or that doesn't need
dedicated callbacks?

>         transport->destroy = free_bap;
>
>         return 0;
> @@ -1537,6 +1623,11 @@ int8_t media_transport_get_device_volume(struct btd_device *dev)
>         /* Attempt to locate the transport to get its volume */
>         for (l = transports; l; l = l->next) {
>                 struct media_transport *transport = l->data;
> +
> +               /* Get BAP transport volume */
> +               if (transport->get_vol)
> +                       return transport->get_vol(transport);
> +
>                 if (transport->device != dev)
>                         continue;
>
> @@ -1560,6 +1651,13 @@ void media_transport_update_device_volume(struct btd_device *dev,
>         /* Attempt to locate the transport to set its volume */
>         for (l = transports; l; l = l->next) {
>                 struct media_transport *transport = l->data;
> +
> +               /* Set BAP transport volume */
> +               if (transport->set_vol) {
> +                       transport->set_vol(transport, volume);
> +                       return;
> +               }
> +
>                 if (transport->device != dev)
>                         continue;
>
> --
> 2.25.1
>


-- 
Luiz Augusto von Dentz
