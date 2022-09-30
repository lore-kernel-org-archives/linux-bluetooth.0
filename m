Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7DFC433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Sep 2022 17:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbiI3R6j (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Sep 2022 13:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbiI3R6i (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Sep 2022 13:58:38 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E1F1E2FD3
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 10:58:36 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id t16so5593659ljh.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 10:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=dWZgRko0gLE8cOeql5P8m+YMOVHhrMSUx5dyNPswITc=;
        b=PRkJCLRi9TW3Gu91WQJ+TJfer56ekAcUbiuRb7GE79mRFXWqW6A6LujQV3jE1y+sIe
         2NhFiF+Tn2qqkgw4g+HMKEpfsIbTq/aicDRHvw3mP56rs1203jwvxZisBXOwkYUSyNj+
         EtnEYBANd8xc+DE+MfxQum0r7btQnA4c/w+oNEylMsg7OloxW9nwrxipCX9U1ga5Yys5
         d9Yv9tdJfM9E0/SwcX7wRXY+Dw6yoQj3T/5tXWjGoxNOaj7S3dPFtutnvilKVonBlz4w
         CUz7SS44ELGkj6l6YzafnohjvSzrBSCzgdXAOtKDGDPEJ72kSr7a/rlATlmqNx8Vyei5
         3Pcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=dWZgRko0gLE8cOeql5P8m+YMOVHhrMSUx5dyNPswITc=;
        b=mq6lDx63o5g/hpufjzQNTCtX/0JFG2j4gPHvI1RDgOpQ/tmKXGAwDU+/yg/a/Nbe4w
         tqPdAYLznKM3Z6GH9l05I5Rm9ffilyCmrMW9oyKjBamUDMkzDyjnAR+VQUrA+HEJQALC
         6EfqG33d3OKy1ENoO6f4dZjbiuzHtHMBb5R6t7+uRYb/evGzPK3fp/ontXMWdT6fiOn9
         2QyZous+nkFDfJkNdT5HHvIzJvawjCaeXUwEUSeCMR28f6jMs5+9otFxWLi3Wm9fwt1y
         Zm3rxRS20iZfdtLjYh3sB2TOgOS7l2D7KVUTEb7xTff8BFBJVRtRoNoMYDomsHaI72CF
         B0SQ==
X-Gm-Message-State: ACrzQf3BsxRMJWF2b/g5S6adwcdLthPYfzA6zUz7CvD0LZuEaU0eYPoZ
        y4WnDtRf3lD5S/SiwB8/feFEfCRKnD7YIil32oQ=
X-Google-Smtp-Source: AMsMyM5aujwthYxISrYZ9vcJnBeDDblgErlyG2AaGzx9AAKp8/WPxtuByoPsIRIsIOb7RAh3LqBlVBUmRH5rkJtE9xM=
X-Received: by 2002:a05:651c:546:b0:26c:698f:a4a2 with SMTP id
 q6-20020a05651c054600b0026c698fa4a2mr3433551ljp.161.1664560714482; Fri, 30
 Sep 2022 10:58:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220930184954.108937-1-sathish.narasimman@intel.com>
In-Reply-To: <20220930184954.108937-1-sathish.narasimman@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 30 Sep 2022 10:58:22 -0700
Message-ID: <CABBYNZ+X_Le6tm9+pMTwz=bJnUeQwdMbg+o+S_HvsSkoEz2SZQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] audio/transport: seprate a2dp and bap transport to
 update volume
To:     Sathish Narasimman <sathish.narasimman@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sathish,

On Fri, Sep 30, 2022 at 3:14 AM Sathish Narasimman
<sathish.narasimman@intel.com> wrote:
>
> Identify BAP and a2dp transport to update the transport volume.
> Also add properties volume for bap_transport.
> ---
>  profiles/audio/media.c     |   2 +-
>  profiles/audio/transport.c | 120 ++++++++++++++++++++++++++++++++++---
>  profiles/audio/transport.h |   7 ++-
>  3 files changed, 117 insertions(+), 12 deletions(-)
>
> diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> index c9328ab9bd6e..0e3c7cbbaf2c 100644
> --- a/profiles/audio/media.c
> +++ b/profiles/audio/media.c
> @@ -523,7 +523,7 @@ static gboolean set_configuration(struct media_endpoint *endpoint,
>                 return FALSE;
>
>         init_volume = media_player_get_device_volume(device);
> -       media_transport_update_volume(transport, init_volume);
> +       media_a2dp_transport_update_volume(transport, init_volume);
>
>         msg = dbus_message_new_method_call(endpoint->sender, endpoint->path,
>                                                 MEDIA_ENDPOINT_INTERFACE,
> diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
> index 41339da51e17..a606d45eb628 100644
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
> @@ -709,7 +710,8 @@ static gboolean get_delay_reporting(const GDBusPropertyTable *property,
>         return TRUE;
>  }
>
> -static gboolean volume_exists(const GDBusPropertyTable *property, void *data)
> +static gboolean volume_a2dp_exists(const GDBusPropertyTable *property,
> +                                       void *data)
>  {
>         struct media_transport *transport = data;
>         struct a2dp_transport *a2dp = transport->data;
> @@ -717,7 +719,8 @@ static gboolean volume_exists(const GDBusPropertyTable *property, void *data)
>         return a2dp->volume >= 0;
>  }
>
> -static gboolean get_volume(const GDBusPropertyTable *property,
> +
> +static gboolean get_a2dp_volume(const GDBusPropertyTable *property,
>                                         DBusMessageIter *iter, void *data)
>  {
>         struct media_transport *transport = data;
> @@ -729,7 +732,7 @@ static gboolean get_volume(const GDBusPropertyTable *property,
>         return TRUE;
>  }
>
> -static void set_volume(const GDBusPropertyTable *property,
> +static void set_a2dp_volume(const GDBusPropertyTable *property,
>                         DBusMessageIter *iter, GDBusPendingPropertySet id,
>                         void *data)
>  {
> @@ -769,6 +772,58 @@ error:
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
> @@ -809,7 +864,8 @@ static const GDBusPropertyTable a2dp_properties[] = {
>         { "Configuration", "ay", get_configuration },
>         { "State", "s", get_state },
>         { "Delay", "q", get_delay_reporting, NULL, delay_reporting_exists },
> -       { "Volume", "q", get_volume, set_volume, volume_exists },
> +       { "Volume", "q", get_a2dp_volume, set_a2dp_volume,
> +                                       volume_a2dp_exists },
>         { "Endpoint", "o", get_endpoint, NULL, endpoint_exists,
>                                 G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
>         { }
> @@ -970,6 +1026,7 @@ static const GDBusPropertyTable bap_properties[] = {
>         { "Retransmissions", "y", get_retransmissions },
>         { "Latency", "q", get_latency },
>         { "Delay", "u", get_delay },
> +       { "Volume", "q", get_bap_volume, set_bap_volume, volume_bap_exists },
>         { "Endpoint", "o", get_endpoint, NULL, endpoint_exists },
>         { "Location", "u", get_location },
>         { "Metadata", "ay", get_metadata },
> @@ -1403,6 +1460,7 @@ static int media_transport_init_bap(struct media_transport *transport,
>         bap->rtn = qos->rtn;
>         bap->latency = qos->latency;
>         bap->delay = qos->delay;
> +       bap->volume = 127;
>         bap->state_id = bt_bap_state_register(bt_bap_stream_get_session(stream),
>                                                 bap_state_changed,
>                                                 bap_connecting,
> @@ -1502,14 +1560,22 @@ struct btd_device *media_transport_get_dev(struct media_transport *transport)
>         return transport->device;
>  }
>
> -int8_t media_transport_get_volume(struct media_transport *transport)
> +int8_t media_a2dp_transport_get_volume(struct media_transport *transport)
>  {
>         struct a2dp_transport *a2dp = transport->data;
> +
>         return a2dp->volume;
>  }
>
> -void media_transport_update_volume(struct media_transport *transport,
> -                                                               int8_t volume)
> +int8_t media_bap_transport_get_volume(struct media_transport *transport)
> +{
> +       struct bap_transport *bap = transport->data;
> +
> +       return bap->volume;
> +}
> +
> +void media_a2dp_transport_update_volume(struct media_transport *transport,
> +                                       int8_t volume)
>  {
>         struct a2dp_transport *a2dp = transport->data;
>
> @@ -1527,6 +1593,25 @@ void media_transport_update_volume(struct media_transport *transport,
>                                         MEDIA_TRANSPORT_INTERFACE, "Volume");
>  }
>
> +void media_bap_transport_update_volume(struct media_transport *transport,
> +                                                               int8_t volume)
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
>  int8_t media_transport_get_device_volume(struct btd_device *dev)
>  {
>         GSList *l;
> @@ -1537,12 +1622,21 @@ int8_t media_transport_get_device_volume(struct btd_device *dev)
>         /* Attempt to locate the transport to get its volume */
>         for (l = transports; l; l = l->next) {
>                 struct media_transport *transport = l->data;
> +               const char *uuid = media_endpoint_get_uuid(transport->endpoint);
> +
> +               /* Locate BAP Transport */
> +               if (!strcasecmp(uuid, PAC_SINK_UUID) &&
> +                               !strcasecmp(uuid, PAC_SOURCE_UUID)) {
> +
> +                       return media_bap_transport_get_volume(transport);
> +               }
> +
>                 if (transport->device != dev)
>                         continue;
>
>                 /* Volume is A2DP only */
>                 if (media_endpoint_get_sep(transport->endpoint))
> -                       return media_transport_get_volume(transport);
> +                       return media_a2dp_transport_get_volume(transport);
>         }
>
>         /* If transport volume doesn't exists use device_volume */
> @@ -1560,12 +1654,20 @@ void media_transport_update_device_volume(struct btd_device *dev,
>         /* Attempt to locate the transport to set its volume */
>         for (l = transports; l; l = l->next) {
>                 struct media_transport *transport = l->data;
> +               const char *uuid = media_endpoint_get_uuid(transport->endpoint);
> +
> +               /* Locate BAP Transport */
> +               if (!strcasecmp(uuid, PAC_SINK_UUID)) {
> +                       media_bap_transport_update_volume(transport, volume);
> +                       return;
> +               }
> +
>                 if (transport->device != dev)
>                         continue;
>
>                 /* Volume is A2DP only */
>                 if (media_endpoint_get_sep(transport->endpoint)) {
> -                       media_transport_update_volume(transport, volume);
> +                       media_a2dp_transport_update_volume(transport, volume);
>                         return;
>                 }
>         }
> diff --git a/profiles/audio/transport.h b/profiles/audio/transport.h
> index 102fc3cf1153..3cbefa5d7bee 100644
> --- a/profiles/audio/transport.h
> +++ b/profiles/audio/transport.h
> @@ -20,10 +20,13 @@ struct media_transport *media_transport_create(struct btd_device *device,
>  void media_transport_destroy(struct media_transport *transport);
>  const char *media_transport_get_path(struct media_transport *transport);
>  struct btd_device *media_transport_get_dev(struct media_transport *transport);
> -int8_t media_transport_get_volume(struct media_transport *transport);
> +int8_t media_a2dp_transport_get_volume(struct media_transport *transport);
> +int8_t media_bap_transport_get_volume(struct media_transport *transport);
>  void media_transport_update_delay(struct media_transport *transport,
>                                                         uint16_t delay);
> -void media_transport_update_volume(struct media_transport *transport,
> +void media_a2dp_transport_update_volume(struct media_transport *transport,
> +                                                               int8_t volume);

Not really following what you need to introduce dedicated functions
foreach? The prototype is the same and we could just introduce
callbacks that access the respective data internally, like we do for
suspend/resume.

> +void media_bap_transport_update_volume(struct media_transport *transport,
>                                                                 int8_t volume);
>  void transport_get_properties(struct media_transport *transport,
>                                                         DBusMessageIter *iter);
> --
> 2.25.1
>


-- 
Luiz Augusto von Dentz
