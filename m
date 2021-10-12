Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B33C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Oct 2021 20:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB8B560E0C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Oct 2021 20:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234896AbhJLUpX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Oct 2021 16:45:23 -0400
Received: from mout01.posteo.de ([185.67.36.141]:50147 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233140AbhJLUpW (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Oct 2021 16:45:22 -0400
X-Greylist: delayed 479 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Oct 2021 16:45:22 EDT
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 52847240028
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Oct 2021 22:35:19 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4HTS8k4LV8z9rxQ;
        Tue, 12 Oct 2021 22:35:18 +0200 (CEST)
Message-ID: <097b7a889f73ea9cee42b9a0c99683a1d7ee8069.camel@iki.fi>
Subject: Re: [PATCH BlueZ] avrcp: keep track of last volume, and use as
 transport init_volume
From:   Pauli Virtanen <pav@iki.fi>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date:   Tue, 12 Oct 2021 20:35:17 +0000
In-Reply-To: <CABBYNZKgXNA1jqdhXV3t44bhRjXiKboTb7nOPMtidmi4dHAQpA@mail.gmail.com>
References: <20211010171447.35355-1-pav@iki.fi>
         <CABBYNZKgXNA1jqdhXV3t44bhRjXiKboTb7nOPMtidmi4dHAQpA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Thanks,

su, 2021-10-10 kello 21:26 -0700, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
> 
> On Sun, Oct 10, 2021 at 10:20 AM Pauli Virtanen <pav@iki.fi> wrote:
> > 
> > Some devices may send AVRCP VolumeChanged notification before AVDTP
> > SetConfiguration occurs, and not send another until a hardware button on
> > the device is pressed. If a media_player is registered to BlueZ, the
> > volume from the event is stored on the player, and used as init_volume
> > for new transports.  However, if no media_player is registered,
> > transports are created with volume missing.
> > 
> > If that occurs, the DBus "Volume" attribute on transports will be
> > missing until a hardware button is pressed.  Consequently, applications
> > cannot get or set volume, even though it is actually possible.
> > 
> > Address this by keeping track of the last device volume set in AVRCP
> > session. If no media_player is registered, use that as the init_volume
> > for new transports.  This has a similar effect as if a dummy media
> > player was registered.
> > 
> > This fixes AVRCP absolute volume not being available on some headphones
> > on Pipewire & Pulseaudio until HW button press.
> > ---
> >  profiles/audio/avrcp.c | 23 +++++++++++++++++++++++
> >  profiles/audio/avrcp.h |  1 +
> >  profiles/audio/media.c |  3 +++
> >  3 files changed, 27 insertions(+)
> > 
> > diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> > index 7c280203c..0df416d2c 100644
> > --- a/profiles/audio/avrcp.c
> > +++ b/profiles/audio/avrcp.c
> > @@ -276,6 +276,8 @@ struct avrcp {
> >         uint8_t transaction;
> >         uint8_t transaction_events[AVRCP_EVENT_LAST + 1];
> >         struct pending_pdu *pending_pdu;
> > +
> > +       int8_t last_device_volume;
> 
> We can probably keep this short and just call it volume.

Ok.

> >  };
> > 
> >  struct passthrough_handler {
> > @@ -1759,6 +1761,7 @@ static uint8_t avrcp_handle_set_absolute_volume(struct avrcp *session,
> >         volume = pdu->params[0] & 0x7F;
> > 
> >         media_transport_update_device_volume(session->dev, volume);
> > + session->last_device_volume = volume;
> > 
> >         return AVC_CTYPE_ACCEPTED;
> > 
> > @@ -3731,6 +3734,7 @@ static void avrcp_volume_changed(struct avrcp *session,
> > 
> >         /* Always attempt to update the transport volume */
> >         media_transport_update_device_volume(session->dev, volume);
> > + session->last_device_volume = volume;
> > 
> >         if (player)
> >                 player->cb->set_volume(volume, session->dev, player->user_data);
> > @@ -4145,6 +4149,7 @@ static void target_init(struct avrcp *session)
> > 
> >                 init_volume = media_player_get_device_volume(session->dev);
> >                 media_transport_update_device_volume(session->dev, init_volume);
> > + session->last_device_volume = init_volume;
> >         }
> > 
> >         session->supported_events |= (1 << AVRCP_EVENT_STATUS_CHANGED) |
> > @@ -4308,6 +4313,7 @@ static struct avrcp *session_create(struct avrcp_server *server,
> >         session->server = server;
> >         session->conn = avctp_connect(device);
> >         session->dev = device;
> > + session->last_device_volume = -1;
> > 
> >         server->sessions = g_slist_append(server->sessions, session);
> > 
> > @@ -4497,6 +4503,7 @@ static gboolean avrcp_handle_set_volume(struct avctp *conn, uint8_t code,
> > 
> >         /* Always attempt to update the transport volume */
> >         media_transport_update_device_volume(session->dev, volume);
> > + session->last_device_volume = volume;
> 
> So if I understand this right we are going to cache the volume here
> since media_transport_update_device_volume may not have a transport
> yet? If that is the case we probably need to be checking if there is a
> transport or not beforehand instead of doing this blindly.

Yes, so that avrcp volume received previously is exhibited in
transports created next. I now see that this is the same issue as in
4b6153b0501c ("audio/transport: supply volume on transport init"), but
in the case when there are no local players registered, and the fix
there does not work.

Currently, if there is a local player registered, the current volume is
cached in the player volume whether there are transports or not.
Caching always in struct avrcp would then make the zero-players case
the same. I don't immediately see something incorrect.

Albeit, this probably should be only done for BlueZ as CT, so shouldn't
cache in avrcp_handle_set_absolute_volume. That could be a minimal v2?

***

There's also something confusing in the code in current master
branch: why are avrcp_handle_set_volume and avrcp_volume_changed
setting the volume on local target->player, which I thought is a BlueZ
as TG thing? 

I see that df7d3fa50023 ("audio/avrcp: Always update transport volume
regardless of player") moved most of what player->set_volume does to
the callbacks, and the player volumes seem to be currently used only to
provide initial volume for transports. The volume probably should be
stored elsewhere than in local players?

In fact, it causes problems because there's just a single player that
has long lifetime: BlueZ sink/TG use as the initial volume, the volume
of a previously connected different remote device sink/TG. Also, having
multiple remote device TG/sink makes the initial volumes conflict. So
there seems to be something to fix (separate patch?).

Caching in struct avrcp session doesn't have these problems, but
df7d3fa50023 mentions there's some issue with avrcp session appearing
late. I'll need to think a bit how to fix this.

> > 
> >         if (player != NULL)
> >                 player->cb->set_volume(volume, session->dev, player->user_data);
> > @@ -4598,6 +4605,22 @@ int avrcp_set_volume(struct btd_device *dev, int8_t volume, bool notify)
> >                                         avrcp_handle_set_volume, session);
> >  }
> > 
> > +int8_t avrcp_get_last_volume(struct btd_device *dev)
> > +{
> > +       struct avrcp_server *server;
> > +       struct avrcp *session;
> > +
> > +       server = find_server(servers, device_get_adapter(dev));
> > +       if (server == NULL)
> > +               return -1;
> > +
> > +       session = find_session(server->sessions, dev);
> > +       if (session == NULL)
> > +               return -1;
> > +
> > +       return session->last_device_volume;
> > +}
> > +
> >  struct avrcp_player *avrcp_get_target_player_by_device(struct btd_device *dev)
> >  {
> >         struct avrcp_server *server;
> > diff --git a/profiles/audio/avrcp.h b/profiles/audio/avrcp.h
> > index dcc580e37..952f0eea9 100644
> > --- a/profiles/audio/avrcp.h
> > +++ b/profiles/audio/avrcp.h
> > @@ -91,6 +91,7 @@ struct avrcp_player_cb {
> >  };
> > 
> >  int avrcp_set_volume(struct btd_device *dev, int8_t volume, bool notify);
> > +int8_t avrcp_get_last_volume(struct btd_device *dev);
> 
> Let's have it as avrcp_get_volume so it is symmetric to avrcp_set_volume.

Ok.

> >  struct avrcp_player *avrcp_register_player(struct btd_adapter
> > *adapter,
> >                                                 struct
> > avrcp_player_cb *cb,
> > diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> > index 521902ed8..a37378393 100644
> > --- a/profiles/audio/media.c
> > +++ b/profiles/audio/media.c
> > @@ -494,6 +494,9 @@ static gboolean set_configuration(struct
> > media_endpoint *endpoint,
> >                 return FALSE;
> > 
> >         init_volume = media_player_get_device_volume(device);
> > + if (init_volume < 0)
> > + init_volume = avrcp_get_last_volume(device);
> 
> I wonder if we shouldn't be better to move the call to
> avrcp_get_volume inside media_player_get_device_volume so it does the
> fallback automatically if there is no volume set.

Ok.

> >         media_transport_update_volume(transport, init_volume);
> > 
> >         msg = dbus_message_new_method_call(endpoint->sender,
> > endpoint->path,
> > --
> > 2.31.1
> > 
> 
> 





