Return-Path: <SRS0=kcDe=D5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FF6C388F9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Oct 2020 21:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EE4324641
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Oct 2020 21:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjYD8DKo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372587AbgJVV7t (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Oct 2020 17:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S372585AbgJVV7t (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Oct 2020 17:59:49 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC76C0613CE
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2020 14:59:49 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b69so3455311qkg.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2020 14:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jwzxgqCLU528P29xSFj3FxDxgK2E09JDbWN9i7YqZ2Q=;
        b=MjYD8DKoM21h8Dlyqxc9sPF8kDjOFxnfyj6/tkFLy0+n0KPJ/8CScpLx5cJs007fBk
         Oc88QKCLOYRNBvIKRYSugj5UQOieUFbplzoJECnf/M946BDVBuwE2Q6nkoFdE0/6wkeJ
         eW6xJteWR3HrWzrtbZPiE/V9kaqoKLwsjX29LP2sKqPeVzt+lDMNNrj5TRghCTZ1hr+5
         EAJVISpQliYplfAilJ/mt5MDJ5LZtiIu78FxBY0XeQo3+ovd6mJGUM50N9z1QUvxBy2X
         2+wAyBid0fW70btFcN6EjVKcFnhMuj9LTP64+vfUghK45mMVCweVo0/JVWoovt8CcipT
         ZFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jwzxgqCLU528P29xSFj3FxDxgK2E09JDbWN9i7YqZ2Q=;
        b=cR62UeG8Mfka42yuFP+LY1jY8orBNIcKngDWa3cBKqqjBjZg/9Pe1qyNEpx1gjiS9Z
         4QpQ6n+kcMsmaq2KuqQouMcgZh9RQVzQH2txItkyoh2EmbGcSd7hmhUAzL8CkRO7Gdqz
         lWf/TbNhWW/Op3SLyioWbjUDIPHsBhkYkLVaI+Jsx2qcuRMZmg4E641SpwIP7D6VEkSh
         7/xSlaZHJ32VwYgpDg2rGce4sVD8Qffm4kEOVrRfy5QwxDJbWVkf9eozZigOuHGbHcFA
         La2hEwxjYAEdEDgRHTLELJLFpdma1KS1guZimwHGTrKFR+GxHEGwDRRQJCIalq9De6nd
         7rKQ==
X-Gm-Message-State: AOAM533fx0kQiyzzpvD8BLjGBN7nR4SA19xomQ0hFkN10C8YNVn1vE7F
        5FvWw/M/onmMePYDxvNQMzJwHY4vEgkD53J1cx0q63FJQhU=
X-Google-Smtp-Source: ABdhPJwXAIfm7Fy7yOqZcgNFsvdmhObcuJCC9yxLy8Jds8+yb77df9N88Mo00qD2OdZdglCJ5yvSuIrcbU0n3FV856Y=
X-Received: by 2002:ae9:f402:: with SMTP id y2mr3276490qkl.459.1603403988008;
 Thu, 22 Oct 2020 14:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <CANX-K3v87MKJB-TCpATMP3D-RO0dSduJgSbbho4RY9TK+a-CRw@mail.gmail.com>
 <20201021221931.931878-1-marijns95@gmail.com> <CABBYNZKrJUXrfz6K5Oa7dui6ERVMZp6C6pDJWz9ZJOfwSjhMyQ@mail.gmail.com>
In-Reply-To: <CABBYNZKrJUXrfz6K5Oa7dui6ERVMZp6C6pDJWz9ZJOfwSjhMyQ@mail.gmail.com>
From:   Marijn Suijten <marijns95@gmail.com>
Date:   Thu, 22 Oct 2020 23:59:36 +0200
Message-ID: <CANX-K3v_q0zU1n552EAxZff9ge+U68vuhou5MH6g9OstmL8bfA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] audio: avrcp: Split supported events between target
 and controller
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Marek Czerski <ma.czerski@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Luiz,

On Thu, 22 Oct 2020 at 22:11, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Marijn,
>
> On Wed, Oct 21, 2020 at 3:19 PM Marijn Suijten <marijns95@gmail.com> wrote:
> >
> > supported_events was previously initialized based on whatever the AV
> > Remote Controller profile running on the peer device could request based
> > on its version, and assumes BlueZ is running in the AV Remote Target
> > profile.
> > If however BlueZ runs the Remote Controller profile (is an audio sink)
> > against a Remote Target profile on the peer (the audio source) this
> > version is incorrectly taken into account: a Remote Controller profile
> > on the peer is not involved in this connection.  If its version is too
> > low supported_events will not contain all events the peer might
> > rightfully attempt to register.
> >
> > This is particularly problematic with Android phones as an A2DP audio
> > source playing back to BlueZ which is the sink.  Most Android phones
> > report their Remote Controller profile version as 1.3 when initializing
> > as audio source [1] meaning that AVRCP_EVENT_VOLUME_CHANGED is
> > inadvertently rejected in avrcp_handle_register_notification.  As
> > mentioned above this profile is of no relevance to the connection, only
> > the Remote Target on the phone (source) and Remote Controller on BlueZ
> > (sink) take part.
> >
> > The problem is addressed by splitting supported_events in two variables:
> > target_supported_events containing all events the peer Remote Controller
> > might attempt to register with the local Remote Target profile, and
> > controller_supported_events containing all events the Remote Target
> > might attempt to register with the local Remote Controller profile.
> >
> > In addition the possible notifications going either way have been
> > limited.  An audio source is in control over media playback and will
> > never request playback state changes from the Remote Controller.
> > Likewise the audio sink is in control over its rendering volume and will
> > never have to request volume notifications from the Remote Target.
> > This does however still allow the Remote Controller to send playback
> > control messages to the source, and the Remote Target to send
> > SetAbsoluteVolume to the sink; both of which are not notifications.
> >
> > [1]: https://android.googlesource.com/platform/system/bt/+/android-11.0.0_r4/bta/av/bta_av_main.cc#761
> >
> > ---
> >
> > Hi Luiz, Marek,
> >
> > This is a preliminary version of the patch that aims to address the
> > issues covered in our mail thread.  Keep in mind it is "intentionally"
> > messy; I commented out unexpected events based on logically deriving the
> > possibilities (as described in the message above) without checking if
> > this is in accordance with the documentation.
> >
> > I still have to test this between two devices that can both run an audio
> > sink and source, such as two machines running BlueZ.  Playing back audio
> > both ways should never make this collapse on its own, though I think at
> > that point multiple transports are associated with a device and
> > media_transport_is_source would be lying, based on whichever transport
> > comes first in the list.  Likewise registered_events needs to be split
> > in two variables as well.
> >
> > I'm not sure what's causing the race condition Marek was observing.  I
> > assume the call to avrcp_get_capabilities or avrcp_connect_browsing in
> > controller_init triggers the peer to start requesting capabilities and
> > registering for notifications, before target_init is called (which would
> > previously be too late to initialize supported_events).  That case will
> > also be addressed in this patch, but if it happens "at random" because
> > the pdu handler is registered before supported_events is assigned I
> > propose to split session_init_control in 3 steps instead:
> >
> > 1. Retrieve remote profile versions and set up *_supported_events;
> > 2. Register pdu and passthrough handler;
> > 3. The rest from {controller,target}_init.
> >
> > Looking forward to hearing your suggestions.
> >
> > Best regards,
> > Marijn Suijten
> >
> >  profiles/audio/avrcp.c     | 58 +++++++++++++++++++++++++++++++-------
> >  profiles/audio/transport.c | 20 +++++++++++++
> >  profiles/audio/transport.h |  1 +
> >  3 files changed, 69 insertions(+), 10 deletions(-)
> >
> > diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> > index c093deac8..af5dc4212 100644
> > --- a/profiles/audio/avrcp.c
> > +++ b/profiles/audio/avrcp.c
> > @@ -269,7 +269,13 @@ struct avrcp {
> >         unsigned int control_id;
> >         unsigned int browsing_id;
> >         unsigned int browsing_timer;
> > -       uint16_t supported_events;
> > +       // TODO: Swap names to make them represent the name of the peer profile,
>
> Please do not use c++ tyle when commenting use /* */

This is a preliminary patch to aid our discussions and show a
potential solution to the problem.  If you want to enforce commenting
style there as well I'll clean that up next time.  It wasn't my intent
to get this merged at all anyway.

>
> > +       // instead of the opposite local profile?
> > +       /* Events the Remote Target expects based on peer Remote Controller version */
> > +       uint16_t target_supported_events;
> > +       /* Events the Remote Controller expects based on peer Remote Target version */
> > +       uint16_t controller_supported_events;
> > +       // TODO: Registered_events should be split across controller/target too!
> >         uint16_t registered_events;
>
> I'd prefer to have a separate struct:
>
> struct avrcp_role {
>         uint16_t version;
>         uint16_t supported_events;
>         uint16_t registered_events;
> };

Agreed, though I don't know if we need the version. Perhaps this comes
in handy in other places.

> struct avrcp {
> ...
>         struct avrcp_role ct;
>         struct avrcp_role tg;

CT/TG? I've read section 2.2.1 of the 1.6.2 over and over again, this
doesn't make sense.

>
> >         uint8_t transaction;
> >         uint8_t transaction_events[AVRCP_EVENT_LAST + 1];
> > @@ -1060,7 +1066,7 @@ static uint8_t avrcp_handle_get_capabilities(struct avrcp *session,
> >                                                 struct avrcp_header *pdu,
> >                                                 uint8_t transaction)
> >  {
> > -       uint16_t len = ntohs(pdu->params_len);
> > +       uint16_t len = ntohs(pdu->params_len), supported_events;
> >         unsigned int i;
> >
> >         if (len != 1)
> > @@ -1068,6 +1074,11 @@ static uint8_t avrcp_handle_get_capabilities(struct avrcp *session,
> >
> >         DBG("id=%u", pdu->params[0]);
> >
> > +       if (media_transport_is_source(session->dev))
> > +               supported_events = session->target_supported_events;
> > +       else
> > +               supported_events = session->controller_supported_events;
>
> I guess you did not fully understand my comments regarding AVRCP
> roles, the roles are solely based on client/server, so here it is a
> server/target no matter the A2DP role since we are receiving a
> command.

Indeed, I don't understand this anymore at all.  The A2DP role should
map directly to the AV Remote (0x110e) and AV Remote Target (0x110c).
It is my understanding that these define what _direction_ events could
possibly go in.  For example in 6.13.2 SetAbsoluteVolume we find:

    It is expected that the audio sink will perform as the TG for this command.

Then, in 6.13.3 Notify Volume Change:

    This Register Notification event is used by the CT to detect when
the volume has been changed locally on the TG, or what the actual
volume level is following use of relative volume commands.
    [...]
    It is expected for this command that the audio sink fulfills the TG role.

That matches what I am trying to explain in all these mails.  We
cannot assume in this function that we are always the server or TG; if
we are the audio source, we must be the CT (when Absolute Volume is
concerned).  This is in accordance with the logical expectation that
the sink is in control of the volume.  The target (source) can change
it by sending SetAbsoluteVolume, or ask the controller (sink) to
update it about volume changes by means of registering this event.
Not the other way around (what would happen if the sink starts sending
SetAbsoluteVolume to the source?).

What can we do to clarify the difference between CT/TG,
target/controller (the profiles), source/sink, client/server?
Terminology is going all over the place to the point that I don't know
how to express my understanding of the system (nor specs) anymore.

> >         switch (pdu->params[0]) {
> >         case CAP_COMPANY_ID:
> >                 for (i = 0; i < G_N_ELEMENTS(company_ids); i++) {
> > @@ -1082,7 +1093,7 @@ static uint8_t avrcp_handle_get_capabilities(struct avrcp *session,
> >         case CAP_EVENTS_SUPPORTED:
> >                 pdu->params[1] = 0;
> >                 for (i = 1; i <= AVRCP_EVENT_LAST; i++) {
> > -                       if (session->supported_events & (1 << i)) {
> > +                       if (supported_events & (1 << i)) {
> >                                 pdu->params[1]++;
> >                                 pdu->params[pdu->params[1] + 1] = i;
> >                         }
> > @@ -1607,7 +1618,7 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
> >  {
> >         struct avrcp_player *player = target_get_player(session);
> >         struct btd_device *dev = session->dev;
> > -       uint16_t len = ntohs(pdu->params_len);
> > +       uint16_t len = ntohs(pdu->params_len), supported_events;
> >         uint64_t uid;
> >         int8_t volume;
> >
> > @@ -1620,7 +1631,12 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
> >                 goto err;
> >
> >         /* Check if event is supported otherwise reject */
> > -       if (!(session->supported_events & (1 << pdu->params[0])))
> > +       if (media_transport_is_source(session->dev))
> > +               supported_events = session->target_supported_events;
> > +       else
> > +               supported_events = session->controller_supported_events;
> > +
> > +       if (!(supported_events & (1 << pdu->params[0])))
> >                 goto err;
>
> Ditto.

How do you propose to figure out what "role" we are providing when
this function is called?  As explained above it depends if we are
sink/controller or source/target what events we are expecting to be
registered.

>
> >         switch (pdu->params[0]) {
> > @@ -4129,7 +4145,11 @@ static void target_init(struct avrcp *session)
> >                 media_transport_update_device_volume(session->dev, init_volume);
> >         }
> >
> > -       session->supported_events |= (1 << AVRCP_EVENT_STATUS_CHANGED) |
> > +       if (target->version < 0x0103)
> > +               return;
> > +
> > +       session->target_supported_events |=
> > +                               (1 << AVRCP_EVENT_STATUS_CHANGED) |
> >                                 (1 << AVRCP_EVENT_TRACK_CHANGED) |
> >                                 (1 << AVRCP_EVENT_TRACK_REACHED_START) |
> >                                 (1 << AVRCP_EVENT_TRACK_REACHED_END) |
> > @@ -4138,10 +4158,13 @@ static void target_init(struct avrcp *session)
> >         if (target->version < 0x0104)
> >                 return;
> >
> > -       session->supported_events |=
> > +       session->target_supported_events |=
> >                                 (1 << AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED) |
> > -                               (1 << AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED) |
> > -                               (1 << AVRCP_EVENT_VOLUME_CHANGED);
> > +                               (1 << AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED);
> > +                               // Does not make sense here; the remote is the
> > +                               // rendering device and in control, it'll never
> > +                               // request this notification.
> > +                               // (1 << AVRCP_EVENT_VOLUME_CHANGED);
>
> Again you are think the roles are based on A2DP roles when they are
> not, target supported events should reflect what events we support as
> server,

I think you are confusing what these variables represent.  In the
original BlueZ code this value is based on the version of the peer
AVRCP_REMOTE_UUID.  That to me means we are checking whether we are
expecting our peer to register for that particular event, and
rejecting it otherwise.  I simply extended this to do the same for the
remote version of the AVRCP_TARGET_UUID profile as well.
What you are suggesting is implicitly encoded as well: if we cannot
handle an event registration even though the peer could realistically
request it based on its version, it's not in the list.

> so we should indicate that we support volume changed even when
> acting as a A2DP Source although this seems to be always omitting
> volume changed which would be a regression.

It does not regress, and was tested with a bluetooth headset to
confirm.  This is indeed rejecting EVENT_VOLUME_CHANGED, and for a
good reason as explained above.  If BlueZ is the source, _it_ will
register this notification with the headset, not the other way around.
Note that get_capabilities_resp/register_notification do not check
*_supported_events, and they shouldn't.

However, say we flip the roles around and make BlueZ a sink, playing
back from an Android phone.  Now avrcp_handle_register_notification
takes controller_supported_events and will happily comply when the
source (the Android phone) registers EVENT_VOLUME_CHANGED.

To make this even more explicit insert some log lines in
get_capabilities_resp: this clearly shows when connecting headphones
as sink it only supports EVENT_VOLUME_CHANGED - when connecting an
Android phone as source it reports a bunch of playback/player related
events but not EVENT_VOLUME_CHANGED.

>
> >         /* Only check capabilities if controller is not supported */
> >         if (session->controller == NULL)
> > @@ -4180,11 +4203,26 @@ static void controller_init(struct avrcp *session)
> >         if (controller->version < 0x0103)
> >                 return;
> >
> > -       avrcp_get_capabilities(session);
> > +       // Players should only run on the remote target; they
> > +       // should never request notifications about their own
> > +       // playback status.
> > +       // session->controller_supported_events |=
> > +       //                      (1 << AVRCP_EVENT_STATUS_CHANGED) |
> > +       //                      (1 << AVRCP_EVENT_TRACK_CHANGED) |
> > +       //                      (1 << AVRCP_EVENT_TRACK_REACHED_START) |
> > +       //                      (1 << AVRCP_EVENT_TRACK_REACHED_END) |
> > +       //                      (1 << AVRCP_EVENT_SETTINGS_CHANGED);
>
> The controller/client supported_events should reflect what the remote
> target/server supports, so here we should probably not initialize with
> anything (or perhaps initialize with the mandatory ones if there are
> any events that the spec indicates as mandatory) but read the
> supported events from the remote with avrcp_get_capabilities.

I think we can initialize this list (as well as
target_supported_events) based on what we expect (as explained above),
and AND it as soon as get_capabilities_resp tells us what the remote
can comply with.

> >         if (controller->version < 0x0104)
> >                 return;
> >
> > +       session->controller_supported_events |=
> > +                               // (1 << AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED) |
> > +                               // (1 << AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED) |
> > +                               (1 << AVRCP_EVENT_VOLUME_CHANGED);
> > +
> > +       avrcp_get_capabilities(session);
> > +
> >         if (!(controller->features & AVRCP_FEATURE_BROWSING))
> >                 return;
> >
> > diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
> > index 8248014ae..f5226776f 100644
> > --- a/profiles/audio/transport.c
> > +++ b/profiles/audio/transport.c
> > @@ -980,3 +980,23 @@ void media_transport_update_device_volume(struct btd_device *dev,
> >                         media_transport_update_volume(transport, volume);
> >         }
> >  }
> > +
> > +gboolean media_transport_is_source(struct btd_device *dev)
> > +{
> > +       GSList *l;
> > +       const char *uuid;
> > +
> > +       if (dev == NULL)
> > +               return FALSE;
> > +
> > +       for (l = transports; l; l = l->next) {
> > +               struct media_transport *transport = l->data;
> > +               if (transport->device != dev)
> > +                       continue;
> > +
> > +               uuid = media_endpoint_get_uuid(transport->endpoint);
> > +               return strcasecmp(uuid, A2DP_SOURCE_UUID) == 0;
> > +       }
> > +
> > +       return FALSE;
> > +}
> > diff --git a/profiles/audio/transport.h b/profiles/audio/transport.h
> > index 51a67ea74..eb1621813 100644
> > --- a/profiles/audio/transport.h
> > +++ b/profiles/audio/transport.h
> > @@ -30,3 +30,4 @@ void transport_get_properties(struct media_transport *transport,
> >  int8_t media_transport_get_device_volume(struct btd_device *dev);
> >  void media_transport_update_device_volume(struct btd_device *dev,
> >                                                                 int8_t volume);
> > +gboolean media_transport_is_source(struct btd_device *dev);
> > --
> > 2.29.0
> >
>
>
> --
> Luiz Augusto von Dentz

 - Marijn
