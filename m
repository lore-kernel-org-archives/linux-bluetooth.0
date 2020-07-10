Return-Path: <SRS0=rPFF=AV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1590C433E5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jul 2020 18:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A902F2075D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jul 2020 18:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNvxclGJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgGJSa6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Jul 2020 14:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbgGJSa6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Jul 2020 14:30:58 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9018C08C5DC
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2020 11:30:57 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id c25so4872582otf.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2020 11:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zEXb/I8QaIOCPUqUy5RRDx8pcQ8cX03xPqPuJYyOe9I=;
        b=UNvxclGJvm1WJ6Oz6ShYi9Qx76YzvjosdsJPnd0DTNLCDugTCCv/jrq/yqIXomGzlc
         7WwtX3EY+aIH9oqaCDPj08RmXmrk1s5S9LHMjR/T496Wax//pZfOCTLit5WjFvyaAI0b
         muAY+k/3YDG32/0RsxErhSwsD2il4/qDOJaOYisULSHKkw8b/j4J/gcunqKN9g5NZEm9
         +GFrhqaItfWJUcZf5be7LnLOEMZGC459aMtp4R8HYCvQgR1XzEDxHpLRiyl5V5iefxQs
         kPMM9malR8GvGffIkhMeLGkQAX0EPjhVPaZGiYVAv8YiPf+myiNlKbW56iCYB1/UQ5aF
         1v0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zEXb/I8QaIOCPUqUy5RRDx8pcQ8cX03xPqPuJYyOe9I=;
        b=Ip6pwunfCqF4XdTQ1RRxbx1FjK0hgqfj0+f3SPFu6+9UPmjbracTIj/U8LY2Hn8Iqf
         Stp/kS3NpCa5uPn0mjlD9BMOaG3zGrdEX20/6Yv/gijjfch0NZs4A15xHgmqX4qcNJwE
         i8WRgpFPhp7rc5wqLHyt1rOCNb28C2f9gS540TxWwvY29NrftmNUlFUwzPfpFQagD87G
         dSs98UD+Efeeyy/gDe9AUHBVzXqgdfCRaDoUEL0OPkWj7fyR0qslboxzjw53HBRLhozb
         7VbXc8oXTZ532XnTJO/pfwSYY6RFl7nWT18T4px63GZ4OMOHmr7CnNnBXsn+PWHDCSIw
         Pz1Q==
X-Gm-Message-State: AOAM532AzemYVvgVNxiNEVxOk6KuNFe6+3bKCblBU5VUX80c5PeuDo6E
        Jsk5wUkEigrFhlRSwJ3PeFwCMXef203YW++QIZI=
X-Google-Smtp-Source: ABdhPJyk2s9JGlHhrmsJ7/q5KgL1BqR2laTK34ry4BqAaIKmF9EdOM8ujiJe8da0PWpeJS0wCUnks2ZClY8bUBf4MT4=
X-Received: by 2002:a9d:5e18:: with SMTP id d24mr19071803oti.88.1594405857197;
 Fri, 10 Jul 2020 11:30:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200710123105.Bluez.v1.1.I667fa0ebcc3056a21c22fdaf476a56dd72aff38d@changeid>
 <20200710123105.Bluez.v1.2.Ic16589fde45fac0c496dfca2fa27672059114c3b@changeid>
In-Reply-To: <20200710123105.Bluez.v1.2.Ic16589fde45fac0c496dfca2fa27672059114c3b@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 10 Jul 2020 11:30:45 -0700
Message-ID: <CABBYNZKB5T4vsofyDRwaDJfEyiv=_9-F9TY9RJwpmpvaNVfoMw@mail.gmail.com>
Subject: Re: [Bluez PATCH v1 2/2] audio/transport: store volume for initialization
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Thu, Jul 9, 2020 at 9:32 PM Archie Pusaka <apusaka@google.com> wrote:
>
> From: Archie Pusaka <apusaka@chromium.org>
>
> Sometimes the response of RegisterNotification for volume change
> event came before we create the transport for the corresponding
> device. If that happens, we lose the volume information. After the
> transport is created, the volume is also potentially stuck to an
> uninitialized invalid value. The property Volume of
> MediaTransport1 will also be left unaccessible.
>
> This patch stores the value of the volume notification response.
> When the transport is initialized, we try to match the device
> with the previously stored volume and assign that value instead.
>
> Reviewed-by: Howard Chung <howardchung@google.com>
> ---
>
>  profiles/audio/media.c     | 17 +----------
>  profiles/audio/transport.c | 61 ++++++++++++++++++++++++++++++++++++--
>  2 files changed, 60 insertions(+), 18 deletions(-)
>
> diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> index 993ecb3b3..be1ca18ee 100644
> --- a/profiles/audio/media.c
> +++ b/profiles/audio/media.c
> @@ -1202,27 +1202,12 @@ static uint32_t get_duration(void *user_data)
>  static void set_volume(uint8_t volume, struct btd_device *dev, void *user_data)
>  {
>         struct media_player *mp = user_data;
> -       GSList *l;
>
>         if (mp->volume == volume)
>                 return;
>
>         mp->volume = volume;
> -
> -       for (l = mp->adapter->endpoints; l; l = l->next) {
> -               struct media_endpoint *endpoint = l->data;
> -               struct media_transport *transport;
> -
> -               /* Volume is A2DP only */
> -               if (endpoint->sep == NULL)
> -                       continue;
> -
> -               transport = find_device_transport(endpoint, dev);
> -               if (transport == NULL)
> -                       continue;
> -
> -               media_transport_update_volume(transport, volume);
> -       }
> +       media_transport_update_device_volume(dev, volume);
>  }
>
>  static bool media_player_send(struct media_player *mp, const char *name)
> diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
> index a32073380..2fd04dd42 100644
> --- a/profiles/audio/transport.c
> +++ b/profiles/audio/transport.c
> @@ -56,6 +56,7 @@
>  #define MEDIA_TRANSPORT_INTERFACE "org.bluez.MediaTransport1"
>
>  #define UNINITIALIZED_VOLUME_VALUE     128
> +#define PEND_DEVICE_VOLUME_TIMEOUT     1
>
>  typedef enum {
>         TRANSPORT_STATE_IDLE,           /* Not acquired and suspended */
> @@ -116,7 +117,13 @@ struct media_transport {
>         void                    *data;
>  };
>
> +struct pending_device_volume {
> +       struct btd_device       *device;
> +       uint8_t                 volume;
> +};
> +
>  static GSList *transports = NULL;
> +static GSList *pending_device_volumes;
>
>  static const char *state2str(transport_state_t state)
>  {
> @@ -810,6 +817,52 @@ static void source_state_changed(struct btd_service *service,
>                 transport_update_playing(transport, FALSE);
>  }
>
> +static uint8_t get_pending_device_volume(struct btd_device *dev)
> +{
> +       GSList *l;
> +
> +       for (l = pending_device_volumes; l; l = l->next) {
> +               struct pending_device_volume *pend = l->data;
> +
> +               if (pend->device == dev)
> +                       return pend->volume;
> +       }
> +
> +       return UNINITIALIZED_VOLUME_VALUE;
> +}
> +
> +static gboolean remove_pending_device_volume(gpointer user_data)
> +{
> +       struct pending_device_volume *pend = user_data;
> +
> +       pending_device_volumes = g_slist_remove(pending_device_volumes, pend);
> +       g_free(pend);
> +
> +       return FALSE;
> +}
> +
> +static void add_pending_device_volume(struct btd_device *dev, uint8_t volume)
> +{
> +       GSList *l;
> +       struct pending_device_volume *pend;
> +
> +       for (l = pending_device_volumes; l; l = l->next) {
> +               pend = l->data;
> +
> +               if (pend->device == dev) {
> +                       pend->volume = volume;
> +                       return;
> +               }
> +       }
> +
> +       pend = g_new0(struct pending_device_volume, 1);
> +       pend->device = dev;
> +       pend->volume = volume;
> +       g_timeout_add_seconds(PEND_DEVICE_VOLUME_TIMEOUT,
> +                               remove_pending_device_volume, pend);
> +       pending_device_volumes = g_slist_append(pending_device_volumes, pend);
> +}
> +
>  static int media_transport_init_source(struct media_transport *transport)
>  {
>         struct btd_service *service;
> @@ -827,7 +880,7 @@ static int media_transport_init_source(struct media_transport *transport)
>         transport->data = a2dp;
>         transport->destroy = destroy_a2dp;
>
> -       a2dp->volume = UNINITIALIZED_VOLUME_VALUE;
> +       a2dp->volume = get_pending_device_volume(transport->device);
>         transport->sink_watch = sink_add_state_cb(service, sink_state_changed,
>                                                                 transport);
>
> @@ -990,9 +1043,13 @@ void media_transport_update_device_volume(struct btd_device *dev,
>                         continue;
>
>                 /* Volume is A2DP only */
> -               if (media_endpoint_get_sep(transport->endpoint))
> +               if (media_endpoint_get_sep(transport->endpoint)) {
>                         media_transport_update_volume(transport, volume);
> +                       return;
> +               }
>         }
> +
> +       add_pending_device_volume(dev, volume);
>  }
>
>  bool media_transport_volume_valid(uint8_t volume)
> --
> 2.27.0.383.g050319c2ae-goog

This sounds a little too complicated, what I would have done it is to
locate the media_player (if there is one), and then pass its stored
volume (mp->volume) to media_transport_create so instead of always
initialize it 127 we actually pass value if it was already fetched and
stored by the media_player instance. Btw, I guess once we merge this
changes we should close the following bug:

https://github.com/bluez/bluez/issues/17

-- 
Luiz Augusto von Dentz
