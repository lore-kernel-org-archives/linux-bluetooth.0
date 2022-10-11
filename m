Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768C0C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Oct 2022 03:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiJKDzC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Oct 2022 23:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJKDzB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Oct 2022 23:55:01 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA64E0FA
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Oct 2022 20:55:00 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id d7-20020a17090a2a4700b0020d268b1f02so5372774pjg.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Oct 2022 20:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7OrYoP3zbM5SsSP+ugjQMkcyx7n9Wr8nNR4a02m40IU=;
        b=eXDdXgZyq1B5FG90uPHbbS1W50YN9I9YJXI6hdPWmsirzZdzRhs1Ai0Lz1ePLh3lVV
         N4fSNB2yHWQ4+X+AYi+cr9IdMoC2/6rdIR9bXNMOhNGvBUa/JXWht+DcxQa7ZZ58n6GU
         hYve5UKrxEH0xMHRv3i+5eEpiVlPn0c1hg+Ouzn6Z4UzOLYFsI6b5ioF8i05bADZ0iwy
         4N7G7pzj/s2YC0wMh0ZmrFLvNSGf/5ga92lXW1DZqKI8JBfeskCmfQMRjf+OzkHgoybH
         pEMPfuApyDLJagMVDVMltXF8He7KRwal+A3MA2D4e4A6MS00DOmfp9C+ILtkyStsNEfK
         y/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7OrYoP3zbM5SsSP+ugjQMkcyx7n9Wr8nNR4a02m40IU=;
        b=UIyzE8RNUgwas4sPZqN5uwaUuWemHUgXRclhzkELBtyCwm4lppykvKU755FzPWNuHJ
         t9bddEFQYz92XL5Ht5rts5NdxVO1ENNdCQQu6DZVYzRl/oXodY/TFMJzb9OJUVVxl8FD
         BDZ4PF+a2L0FGs84fAw7mbzAF2V5YHCA0r+kEmP5Z5FP/6uaOLcQlo2Gl6xT3SI3vdWZ
         3f43ZYlGlkkwTpPlypzYhA3+oEAp8MXtesborQbAgPGSMk7sbz+XMRjm3nJseLYifz8n
         Df0nZbsjnK1XDCqwIYYNNsLtI0u1VJk6F03QTLimHNhUR1y8Ad5pD+sfcVVA7HJhfQSf
         HhiQ==
X-Gm-Message-State: ACrzQf3Z5Nv5n083kZuyVkXAK5ofq7gNawAv0CbPr9FXoyLiSy/nW5Of
        a4swkhas3bdLQHrVB89VAd8pjmDmH+Vmuev3MOFafAHXqdo=
X-Google-Smtp-Source: AMsMyM4tg7RFFNXNscXEM1/Pa9SOSEil4Ih4sIApjFA29SUiKV8bkYGqTqbRrcKTYiHWtQXnkzzDwBvLiE6nVWPszj0=
X-Received: by 2002:a17:902:d2d0:b0:183:6545:39c7 with SMTP id
 n16-20020a170902d2d000b00183654539c7mr3405728plc.16.1665460499323; Mon, 10
 Oct 2022 20:54:59 -0700 (PDT)
MIME-Version: 1.0
References: <20221007061223.46114-1-sathish.narasimman@intel.com> <CABBYNZL7v5zAaQAqzBikZXDD5wHtjTJCFf9NBFZ_GFvsF6q3qg@mail.gmail.com>
In-Reply-To: <CABBYNZL7v5zAaQAqzBikZXDD5wHtjTJCFf9NBFZ_GFvsF6q3qg@mail.gmail.com>
From:   Sathish Narasimman <nsathish41@gmail.com>
Date:   Tue, 11 Oct 2022 09:24:47 +0530
Message-ID: <CAOVXEJJr15SpAL3wYYfctg6UQBeUou5jU7tZ6Hc4G9qv=q6poQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 1/3] audio/transport: Add volume callback to BAP transport
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz

On Tue, Oct 11, 2022 at 1:45 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sathish,
>
> On Thu, Oct 6, 2022 at 11:26 PM Sathish Narasimman
> <sathish.narasimman@intel.com> wrote:
> >
> > Initialize set_volume and get_volume to BAP transport and update the
> > volume when media_transport_update_device_volume is called.
> > ---
> >  profiles/audio/transport.c | 98 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 98 insertions(+)
> >
> > diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
> > index 41339da51e17..46b936c965bf 100644
> > --- a/profiles/audio/transport.c
> > +++ b/profiles/audio/transport.c
> > @@ -91,6 +91,7 @@ struct bap_transport {
> >         uint8_t                 rtn;
> >         uint16_t                latency;
> >         uint32_t                delay;
> > +       int8_t                  volume;
> >  };
> >
> >  struct media_transport {
> > @@ -116,6 +117,9 @@ struct media_transport {
> >                                                                 guint id);
> >         void                    (*set_state) (struct media_transport *transport,
> >                                                 transport_state_t state);
> > +       void                    (*set_vol)(struct media_transport *transport,
> > +                                               int8_t volume);
> > +       int8_t                  (*get_vol)(struct media_transport *transport);
>
> Lets have volume in the function name instead of just vol above.
For the present indentation if we use set_volume it exceeds 80 spaces.
Not sure if we can split the like this
"struct media_transport
*transport"
in 2 lines. If the above is allowed,I will make the changes and submit.

>
> >         GDestroyNotify          destroy;
> >         void                    *data;
> >  };
> > @@ -717,6 +721,7 @@ static gboolean volume_exists(const GDBusPropertyTable *property, void *data)
> >         return a2dp->volume >= 0;
> >  }
> >
> > +
> >  static gboolean get_volume(const GDBusPropertyTable *property,
> >                                         DBusMessageIter *iter, void *data)
> >  {
> > @@ -769,6 +774,58 @@ error:
> >                                         "Invalid arguments in method call");
> >  }
> >
> > +static gboolean volume_bap_exists(const GDBusPropertyTable *property,
> > +                                       void *data)
> > +{
> > +       struct media_transport *transport = data;
> > +       struct bap_transport *bap = transport->data;
> > +
> > +       return bap->volume >= 0;
> > +}
> > +
> > +static gboolean get_bap_volume(const GDBusPropertyTable *property,
> > +                                       DBusMessageIter *iter, void *data)
> > +{
> > +       struct media_transport *transport = data;
> > +       struct bap_transport *bap = transport->data;
> > +       uint16_t volume = (uint16_t)bap->volume;
> > +
> > +       dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &volume);
> > +
> > +       return TRUE;
> > +}
> > +
> > +static void set_bap_volume(const GDBusPropertyTable *property,
> > +                          DBusMessageIter *iter, GDBusPendingPropertySet id,
> > +                          void *data)
> > +{
> > +       struct media_transport *transport = data;
> > +       struct bap_transport *bap = transport->data;
> > +       uint16_t arg;
> > +       int8_t volume;
> > +
> > +       if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT16)
> > +               goto error;
> > +
> > +       dbus_message_iter_get_basic(iter, &arg);
> > +       if (arg > INT8_MAX)
> > +               goto error;
> > +
> > +       g_dbus_pending_property_success(id);
> > +
> > +       volume = (int8_t)arg;
> > +       if (bap->volume == volume)
> > +               return;
> > +
> > +       /*TODO vcp_send_volume */
> > +       return;
> > +
> > +error:
> > +       g_dbus_pending_property_error(id, ERROR_INTERFACE ".InvalidArguments",
> > +                                       "Invalid arguments in method call");
> > +}
> > +
> > +
> >  static gboolean endpoint_exists(const GDBusPropertyTable *property, void *data)
> >  {
> >         struct media_transport *transport = data;
> > @@ -970,6 +1027,7 @@ static const GDBusPropertyTable bap_properties[] = {
> >         { "Retransmissions", "y", get_retransmissions },
> >         { "Latency", "q", get_latency },
> >         { "Delay", "u", get_delay },
> > +       { "Volume", "q", get_bap_volume, set_bap_volume, volume_bap_exists },
> >         { "Endpoint", "o", get_endpoint, NULL, endpoint_exists },
> >         { "Location", "u", get_location },
> >         { "Metadata", "ay", get_metadata },
> > @@ -1387,6 +1445,31 @@ static void free_bap(void *data)
> >         free(bap);
> >  }
> >
> > +static void set_volume_bap(struct media_transport *transport, int8_t volume)
> > +{
> > +       struct bap_transport *bap = transport->data;
> > +
> > +       if (volume < 0)
> > +               return;
> > +
> > +       /* Check if volume really changed */
> > +       if (bap->volume == volume)
> > +               return;
> > +
> > +       bap->volume = volume;
> > +
> > +       g_dbus_emit_property_changed(btd_get_dbus_connection(),
> > +                                       transport->path,
> > +                                       MEDIA_TRANSPORT_INTERFACE, "Volume");
> > +}
> > +
> > +static int8_t get_volume_bap(struct media_transport *transport)
> > +{
> > +       struct bap_transport *bap = transport->data;
> > +
> > +       return bap->volume;
> > +}
> > +
> >  static int media_transport_init_bap(struct media_transport *transport,
> >                                                         void *stream)
> >  {
> > @@ -1403,6 +1486,7 @@ static int media_transport_init_bap(struct media_transport *transport,
> >         bap->rtn = qos->rtn;
> >         bap->latency = qos->latency;
> >         bap->delay = qos->delay;
> > +       bap->volume = 127;
> >         bap->state_id = bt_bap_state_register(bt_bap_stream_get_session(stream),
> >                                                 bap_state_changed,
> >                                                 bap_connecting,
> > @@ -1413,6 +1497,8 @@ static int media_transport_init_bap(struct media_transport *transport,
> >         transport->suspend = suspend_bap;
> >         transport->cancel = cancel_bap;
> >         transport->set_state = set_state_bap;
> > +       transport->set_vol = set_volume_bap;
> > +       transport->get_vol = get_volume_bap;
>
> Im not seeing any initialization for A2DP or that doesn't need
> dedicated callbacks?
yes, I have missed it just to keep bap changes. will update in v3
>
> >         transport->destroy = free_bap;
> >
> >         return 0;
> > @@ -1537,6 +1623,11 @@ int8_t media_transport_get_device_volume(struct btd_device *dev)
> >         /* Attempt to locate the transport to get its volume */
> >         for (l = transports; l; l = l->next) {
> >                 struct media_transport *transport = l->data;
> > +
> > +               /* Get BAP transport volume */
> > +               if (transport->get_vol)
> > +                       return transport->get_vol(transport);
> > +
> >                 if (transport->device != dev)
> >                         continue;
> >
> > @@ -1560,6 +1651,13 @@ void media_transport_update_device_volume(struct btd_device *dev,
> >         /* Attempt to locate the transport to set its volume */
> >         for (l = transports; l; l = l->next) {
> >                 struct media_transport *transport = l->data;
> > +
> > +               /* Set BAP transport volume */
> > +               if (transport->set_vol) {
> > +                       transport->set_vol(transport, volume);
> > +                       return;
> > +               }
> > +
> >                 if (transport->device != dev)
> >                         continue;
> >
> > --
> > 2.25.1
> >
>
>
> --
> Luiz Augusto von Dentz

Sathish N
