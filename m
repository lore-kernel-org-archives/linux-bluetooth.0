Return-Path: <SRS0=kcDe=D5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D999C388F7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Oct 2020 20:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B291324654
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Oct 2020 20:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIwckgFt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506106AbgJVULE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Oct 2020 16:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503404AbgJVULD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Oct 2020 16:11:03 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75ABFC0613CE
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2020 13:11:03 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id f7so2027127oib.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2020 13:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SIrsw3t66hyBAaajmft2cdPAGs+HvAtllOORrP6N6w4=;
        b=eIwckgFtVu0ImVL7ASpjTxl8j2d1o3YmUDdgL4lhzjguRM25aaclwG0HoD7LXeUHvi
         WOXO5osro0ho/rSqR9jkJcEwk5ycvu4tfZgp5mqShA7FhEnQWBU25EE/hg6ZYnOgtO8e
         f/yzdPr44NrZ0Q22G09B5oEJDbtB8oCC6O+MzWBxREDYdRavpJ3f/VEHOuIItbRJAq7G
         sIqEZCXAV+fayxxerMc8KC45j+4sA8sMCMN4v4QEONPN78sKiZsnxnFCTmWFsE5I1jrq
         Wq0PEH4QjktLaz2wTHk7dERsDQOjiXIbjWN81MjgGpaFLxxqUHXLnY0eS2nWhUQVOf+M
         GbGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SIrsw3t66hyBAaajmft2cdPAGs+HvAtllOORrP6N6w4=;
        b=eVu8Q2LiHLO2ANTashJjhZz7O0vp445udrVHCPNpzWQkfQzpW0x1sKh5Gcmv5jVhMw
         //ZRAVWHGI4DEOFeqK+lBh3u6gc/S0GRWNqY/Vhi16xuw911f7GctMJBalcemTwVwP9j
         y40jkOyCdUFdpPkjXs9skMJ7b2jpsOGI8Qq+RX+qHMjDAQePKE9HTk7CoNG8I4mX5rdV
         ZClDY5hf/9WRYeRq5lBPYPr6P8qxHUKdklIQBQgNP6yu+e+b5IOxk01WWPeTPedziyp6
         PO83n1s2iOdSBHKiPAMndYTcDuUgb87hCOKONSDT6OtCSV0Xo6J+uKd9X9XOvCw0oK37
         yqmA==
X-Gm-Message-State: AOAM530fnNy8uh4AR6cfA72S32KeQbaJq9CxQF3DrVIu4jL/vKlaYPqb
        17GOHoW+Fx+sEi5QDiJqR63BT5Q3LsfDthm1y1o=
X-Google-Smtp-Source: ABdhPJxLp4l1W60RIMpBdH/ZwKXJy6aYnmpYFWsBOTSiGpdpD17Zf/3ObMO9fsty+BvDNYlCRVm24mCGH0yT/jTJYWc=
X-Received: by 2002:aca:5143:: with SMTP id f64mr2503792oib.161.1603397462645;
 Thu, 22 Oct 2020 13:11:02 -0700 (PDT)
MIME-Version: 1.0
References: <CANX-K3v87MKJB-TCpATMP3D-RO0dSduJgSbbho4RY9TK+a-CRw@mail.gmail.com>
 <20201021221931.931878-1-marijns95@gmail.com>
In-Reply-To: <20201021221931.931878-1-marijns95@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 22 Oct 2020 13:10:51 -0700
Message-ID: <CABBYNZKrJUXrfz6K5Oa7dui6ERVMZp6C6pDJWz9ZJOfwSjhMyQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] audio: avrcp: Split supported events between target
 and controller
To:     Marijn Suijten <marijns95@gmail.com>
Cc:     Marek Czerski <ma.czerski@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Marijn,

On Wed, Oct 21, 2020 at 3:19 PM Marijn Suijten <marijns95@gmail.com> wrote:
>
> supported_events was previously initialized based on whatever the AV
> Remote Controller profile running on the peer device could request based
> on its version, and assumes BlueZ is running in the AV Remote Target
> profile.
> If however BlueZ runs the Remote Controller profile (is an audio sink)
> against a Remote Target profile on the peer (the audio source) this
> version is incorrectly taken into account: a Remote Controller profile
> on the peer is not involved in this connection.  If its version is too
> low supported_events will not contain all events the peer might
> rightfully attempt to register.
>
> This is particularly problematic with Android phones as an A2DP audio
> source playing back to BlueZ which is the sink.  Most Android phones
> report their Remote Controller profile version as 1.3 when initializing
> as audio source [1] meaning that AVRCP_EVENT_VOLUME_CHANGED is
> inadvertently rejected in avrcp_handle_register_notification.  As
> mentioned above this profile is of no relevance to the connection, only
> the Remote Target on the phone (source) and Remote Controller on BlueZ
> (sink) take part.
>
> The problem is addressed by splitting supported_events in two variables:
> target_supported_events containing all events the peer Remote Controller
> might attempt to register with the local Remote Target profile, and
> controller_supported_events containing all events the Remote Target
> might attempt to register with the local Remote Controller profile.
>
> In addition the possible notifications going either way have been
> limited.  An audio source is in control over media playback and will
> never request playback state changes from the Remote Controller.
> Likewise the audio sink is in control over its rendering volume and will
> never have to request volume notifications from the Remote Target.
> This does however still allow the Remote Controller to send playback
> control messages to the source, and the Remote Target to send
> SetAbsoluteVolume to the sink; both of which are not notifications.
>
> [1]: https://android.googlesource.com/platform/system/bt/+/android-11.0.0_r4/bta/av/bta_av_main.cc#761
>
> ---
>
> Hi Luiz, Marek,
>
> This is a preliminary version of the patch that aims to address the
> issues covered in our mail thread.  Keep in mind it is "intentionally"
> messy; I commented out unexpected events based on logically deriving the
> possibilities (as described in the message above) without checking if
> this is in accordance with the documentation.
>
> I still have to test this between two devices that can both run an audio
> sink and source, such as two machines running BlueZ.  Playing back audio
> both ways should never make this collapse on its own, though I think at
> that point multiple transports are associated with a device and
> media_transport_is_source would be lying, based on whichever transport
> comes first in the list.  Likewise registered_events needs to be split
> in two variables as well.
>
> I'm not sure what's causing the race condition Marek was observing.  I
> assume the call to avrcp_get_capabilities or avrcp_connect_browsing in
> controller_init triggers the peer to start requesting capabilities and
> registering for notifications, before target_init is called (which would
> previously be too late to initialize supported_events).  That case will
> also be addressed in this patch, but if it happens "at random" because
> the pdu handler is registered before supported_events is assigned I
> propose to split session_init_control in 3 steps instead:
>
> 1. Retrieve remote profile versions and set up *_supported_events;
> 2. Register pdu and passthrough handler;
> 3. The rest from {controller,target}_init.
>
> Looking forward to hearing your suggestions.
>
> Best regards,
> Marijn Suijten
>
>  profiles/audio/avrcp.c     | 58 +++++++++++++++++++++++++++++++-------
>  profiles/audio/transport.c | 20 +++++++++++++
>  profiles/audio/transport.h |  1 +
>  3 files changed, 69 insertions(+), 10 deletions(-)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index c093deac8..af5dc4212 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -269,7 +269,13 @@ struct avrcp {
>         unsigned int control_id;
>         unsigned int browsing_id;
>         unsigned int browsing_timer;
> -       uint16_t supported_events;
> +       // TODO: Swap names to make them represent the name of the peer profile,

Please do not use c++ tyle when commenting use /* */

> +       // instead of the opposite local profile?
> +       /* Events the Remote Target expects based on peer Remote Controller version */
> +       uint16_t target_supported_events;
> +       /* Events the Remote Controller expects based on peer Remote Target version */
> +       uint16_t controller_supported_events;
> +       // TODO: Registered_events should be split across controller/target too!
>         uint16_t registered_events;

I'd prefer to have a separate struct:

struct avrcp_role {
        uint16_t version;
        uint16_t supported_events;
        uint16_t registered_events;
};

struct avrcp {
...
        struct avrcp_role ct;
        struct avrcp_role tg;

>         uint8_t transaction;
>         uint8_t transaction_events[AVRCP_EVENT_LAST + 1];
> @@ -1060,7 +1066,7 @@ static uint8_t avrcp_handle_get_capabilities(struct avrcp *session,
>                                                 struct avrcp_header *pdu,
>                                                 uint8_t transaction)
>  {
> -       uint16_t len = ntohs(pdu->params_len);
> +       uint16_t len = ntohs(pdu->params_len), supported_events;
>         unsigned int i;
>
>         if (len != 1)
> @@ -1068,6 +1074,11 @@ static uint8_t avrcp_handle_get_capabilities(struct avrcp *session,
>
>         DBG("id=%u", pdu->params[0]);
>
> +       if (media_transport_is_source(session->dev))
> +               supported_events = session->target_supported_events;
> +       else
> +               supported_events = session->controller_supported_events;

I guess you did not fully understand my comments regarding AVRCP
roles, the roles are solely based on client/server, so here it is a
server/target no matter the A2DP role since we are receiving a
command.

>         switch (pdu->params[0]) {
>         case CAP_COMPANY_ID:
>                 for (i = 0; i < G_N_ELEMENTS(company_ids); i++) {
> @@ -1082,7 +1093,7 @@ static uint8_t avrcp_handle_get_capabilities(struct avrcp *session,
>         case CAP_EVENTS_SUPPORTED:
>                 pdu->params[1] = 0;
>                 for (i = 1; i <= AVRCP_EVENT_LAST; i++) {
> -                       if (session->supported_events & (1 << i)) {
> +                       if (supported_events & (1 << i)) {
>                                 pdu->params[1]++;
>                                 pdu->params[pdu->params[1] + 1] = i;
>                         }
> @@ -1607,7 +1618,7 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
>  {
>         struct avrcp_player *player = target_get_player(session);
>         struct btd_device *dev = session->dev;
> -       uint16_t len = ntohs(pdu->params_len);
> +       uint16_t len = ntohs(pdu->params_len), supported_events;
>         uint64_t uid;
>         int8_t volume;
>
> @@ -1620,7 +1631,12 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
>                 goto err;
>
>         /* Check if event is supported otherwise reject */
> -       if (!(session->supported_events & (1 << pdu->params[0])))
> +       if (media_transport_is_source(session->dev))
> +               supported_events = session->target_supported_events;
> +       else
> +               supported_events = session->controller_supported_events;
> +
> +       if (!(supported_events & (1 << pdu->params[0])))
>                 goto err;

Ditto.

>         switch (pdu->params[0]) {
> @@ -4129,7 +4145,11 @@ static void target_init(struct avrcp *session)
>                 media_transport_update_device_volume(session->dev, init_volume);
>         }
>
> -       session->supported_events |= (1 << AVRCP_EVENT_STATUS_CHANGED) |
> +       if (target->version < 0x0103)
> +               return;
> +
> +       session->target_supported_events |=
> +                               (1 << AVRCP_EVENT_STATUS_CHANGED) |
>                                 (1 << AVRCP_EVENT_TRACK_CHANGED) |
>                                 (1 << AVRCP_EVENT_TRACK_REACHED_START) |
>                                 (1 << AVRCP_EVENT_TRACK_REACHED_END) |
> @@ -4138,10 +4158,13 @@ static void target_init(struct avrcp *session)
>         if (target->version < 0x0104)
>                 return;
>
> -       session->supported_events |=
> +       session->target_supported_events |=
>                                 (1 << AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED) |
> -                               (1 << AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED) |
> -                               (1 << AVRCP_EVENT_VOLUME_CHANGED);
> +                               (1 << AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED);
> +                               // Does not make sense here; the remote is the
> +                               // rendering device and in control, it'll never
> +                               // request this notification.
> +                               // (1 << AVRCP_EVENT_VOLUME_CHANGED);

Again you are think the roles are based on A2DP roles when they are
not, target supported events should reflect what events we support as
server, so we should indicate that we support volume changed even when
acting as a A2DP Source, although this seems to be always omitting
volume changed which would be a regression.

>         /* Only check capabilities if controller is not supported */
>         if (session->controller == NULL)
> @@ -4180,11 +4203,26 @@ static void controller_init(struct avrcp *session)
>         if (controller->version < 0x0103)
>                 return;
>
> -       avrcp_get_capabilities(session);
> +       // Players should only run on the remote target; they
> +       // should never request notifications about their own
> +       // playback status.
> +       // session->controller_supported_events |=
> +       //                      (1 << AVRCP_EVENT_STATUS_CHANGED) |
> +       //                      (1 << AVRCP_EVENT_TRACK_CHANGED) |
> +       //                      (1 << AVRCP_EVENT_TRACK_REACHED_START) |
> +       //                      (1 << AVRCP_EVENT_TRACK_REACHED_END) |
> +       //                      (1 << AVRCP_EVENT_SETTINGS_CHANGED);

The controller/client supported_events should reflect what the remote
target/server supports, so here we should probably not initialize with
anything (or perhaps initialize with the mandatory ones if there are
any events that the spec indicates as mandatory) but read the
supported events from the remote with avrcp_get_capabilities.

>         if (controller->version < 0x0104)
>                 return;
>
> +       session->controller_supported_events |=
> +                               // (1 << AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED) |
> +                               // (1 << AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED) |
> +                               (1 << AVRCP_EVENT_VOLUME_CHANGED);
> +
> +       avrcp_get_capabilities(session);
> +
>         if (!(controller->features & AVRCP_FEATURE_BROWSING))
>                 return;
>
> diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
> index 8248014ae..f5226776f 100644
> --- a/profiles/audio/transport.c
> +++ b/profiles/audio/transport.c
> @@ -980,3 +980,23 @@ void media_transport_update_device_volume(struct btd_device *dev,
>                         media_transport_update_volume(transport, volume);
>         }
>  }
> +
> +gboolean media_transport_is_source(struct btd_device *dev)
> +{
> +       GSList *l;
> +       const char *uuid;
> +
> +       if (dev == NULL)
> +               return FALSE;
> +
> +       for (l = transports; l; l = l->next) {
> +               struct media_transport *transport = l->data;
> +               if (transport->device != dev)
> +                       continue;
> +
> +               uuid = media_endpoint_get_uuid(transport->endpoint);
> +               return strcasecmp(uuid, A2DP_SOURCE_UUID) == 0;
> +       }
> +
> +       return FALSE;
> +}
> diff --git a/profiles/audio/transport.h b/profiles/audio/transport.h
> index 51a67ea74..eb1621813 100644
> --- a/profiles/audio/transport.h
> +++ b/profiles/audio/transport.h
> @@ -30,3 +30,4 @@ void transport_get_properties(struct media_transport *transport,
>  int8_t media_transport_get_device_volume(struct btd_device *dev);
>  void media_transport_update_device_volume(struct btd_device *dev,
>                                                                 int8_t volume);
> +gboolean media_transport_is_source(struct btd_device *dev);
> --
> 2.29.0
>


-- 
Luiz Augusto von Dentz
