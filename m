Return-Path: <SRS0=mCsq=A7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5336C433E1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Jul 2020 20:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9715722BEF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Jul 2020 20:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7VQ60S8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731117AbgGTUAW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Jul 2020 16:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbgGTUAV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Jul 2020 16:00:21 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82CCC061794
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2020 13:00:21 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id d4so13237126otk.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2020 13:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xsxQnXTkDVwEn2yORiSe88zGHIEKrGVneUBiXY4K0PY=;
        b=C7VQ60S8+/zm3V+ddFjdF5hfdUHSEIWgEOzDfzyTduJLZae7IecfY55q71QBn0ugwK
         TDffYAIRbMJdOmDwH0hqIGZiomqwaTwKVWI+F50YQMC+Qn4ID5A8K5SKdg3txuwTejf9
         wHe8n1Ew4Wj88kqEf9k16ybs0QzbWs0GemW2twy+ReKaQ3IVu23aLr43FR6qKGL8kcqt
         zMoobyQFNnONm4I1QUBPAcjsN34YpSBcOVi8nHclVdBDyUK5nJlt97A/268CuhC5RL/x
         DaIsK/bp0RA7UzuqneqRVDlt2ot1sjrRd5TzFz0eklnYi8bQJx9mnzagRGZ3tveteyTo
         /hTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xsxQnXTkDVwEn2yORiSe88zGHIEKrGVneUBiXY4K0PY=;
        b=U7Dvndvh1jJfyMc79jAEEMZjeuZ0gjOyRKHtp7i6T5Zn2aUkfAqGsGjQrIUmaedEc2
         9QuPalYcQSkO/ETmMhyYH0bH6D7BdUSVXqcxIjkUylLyeuofTQOfpLpybWVzt+pgU11O
         fD181dWUEUwq/rMNf2oCYxW2ff+Gctw8LaZGm7GTYmrId+GC2I1gEf6YS95Zz4i+k8tB
         d5Z+LGWUL7XHmcVSY89bemPo9RXL0cOZkbtZZjgl0p7VNJ41842fBb3rBDgu3F+2TqHs
         yDYCWZ/FplYMnyYftsNWsbmyqCKqarvGdyA6iRTnYMbeph9t0vrQcl/J5f/ohXr3noLv
         jNLQ==
X-Gm-Message-State: AOAM530QtSPvfaXJqrRaYomIoZM2ilSRI6wj4sJ7IYe6nQIJ9FQkxevU
        pbBles/YJGVbV8gkST5WW7iXhMLc2dJj/1XW878=
X-Google-Smtp-Source: ABdhPJxoOkpinX4uGwK+saiucfaF8NNALFwIf8W8zAbEy4shWl61kmgbXt7SszDjy9ATepBss/TEFE7NRBqBZBu3fUw=
X-Received: by 2002:a9d:68d1:: with SMTP id i17mr20967711oto.182.1595275220569;
 Mon, 20 Jul 2020 13:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200711115031.123793-1-marijns95@gmail.com> <CABBYNZJid20zZDBtjkm14zLF8XOEhxBOfGffYo0aWX0aE0N54A@mail.gmail.com>
 <CABBYNZL1Ac4jnKGbK2vqBeAog09xSR-nHhgLCBA166Wqiwzefw@mail.gmail.com>
In-Reply-To: <CABBYNZL1Ac4jnKGbK2vqBeAog09xSR-nHhgLCBA166Wqiwzefw@mail.gmail.com>
From:   Marijn Suijten <marijns95@gmail.com>
Date:   Mon, 20 Jul 2020 22:00:07 +0200
Message-ID: <CANX-K3vd8BVvxd1D9Do2nf50dh5j8BZCQUCnsYNCjX_kEMyz3w@mail.gmail.com>
Subject: Re: [PATCH BlueZ] audio/avrcp: Always update transport volume
 regardless of player
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Tue, 14 Jul 2020 at 02:06, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Marijn,
>
> On Mon, Jul 13, 2020 at 5:05 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Marijn,
> >
> > On Sat, Jul 11, 2020 at 4:50 AM Marijn Suijten <marijns95@gmail.com> wrote:
> > >
> > > `Volume` is a special property that not only exists on players but also
> > > on the transport (see org.bluez.MediaTransport1). A player is not
> > > attached when the controller does not support FEATURE_CATEGORY_1, which
> > > is common on headphones without media browsing capabilities.
> > >
> > > On such audio devices (headphones, in-ears and the like) Absolute Volume
> > > is not available unless an external player is registered
> > > (org.bluez.Media1.RegisterPlayer) and the device sends a volume event
> > > back after that to set a2dp->volume in transport.c to a valid value
> > > (causing volume_exists to finally return true).
> > >
> > > This [1] mail thread denoting the same issue has a solution to at least
> > > request capabilities from the controller, but the proposed player object
> > > is not created on category 2 devices. Any notifications received on
> > > AVRCP_EVENT_VOLUME_CHANGED (avrcp_volume_changed) that is subsequently
> > > registered, or handling the result of avrcp_set_volume in
> > > avrcp_handle_set_volume will be ignored unless said player is present.
> > >
> > > This issue is not addressed by adding a fake player but instead dealing
> > > with the fact that volume is "special" and available on the transport
> > > regardless of the existence of a player. This is confirmed in
> > > avrcp_get_capabilities_resp as well which requires a player to register
> > > any event except AVRCP_EVENT_VOLUME_CHANGED.
> > >
> > > The applied solution moves media_transport_update_device_volume out of
> > > the player and into avrcp_volume_changed/avrcp_handle_set_volume where
> > > it is unconditionally called. These functions are the only users of
> > > avrcp_player->set_volume.
> > >
> > > Note that the volume member of media_player is never used which seems a
> > > result of updating from org.bluez.MediaPlayer1 to
> > > org.mpris.MediaPlayer2.Player in
> > > 15e421737ccc4696ed567edcc24d178aedb47854, where the volume property [2]
> > > is left out.
> >
> > This is actually on purpose since the volume notification indicates
> > the volume at the device side we don't want to change the player
> > volume as well as it would most likely result in duplicating the
> > volume change both at sink and source, note that the likes of handling
> > the transport like pulseaudio would already notify the device volume
> > level change without actually applying any change to the volume
> > locally.

I might have wrongfully assumed that a player registers a MediaPlayer2
with BlueZ to stay in sync with the playback endpoint, including
Volume. In which case the application should be aware that attenuation
is applied at the sink (hence not feasible). The other way around
mpris-proxy "re-exports" the transport volume over the MediaPlayer2
interface.

As for pulseaudio it currently doesn't do anything with the transport
volume and always applies attenuation based on a local gain. My
attempt to change that [1] is what ended up in submitting this patch
to make it possible.

> > > [1]: https://marc.info/?l=linux-bluetooth&m=145337574806153
> > > [2]: https://specifications.freedesktop.org/mpris-spec/2.2/Player_Interface.html#Property:Volume
> > >
> > > ---
> > > Hi,
> > >
> > > This is is a resend from an earlier mail that didn't comply with the
> > > contributor guidelines. Seeing that the topic of AVRCP volume is brought
> > > up recently it is about time to repair it and hereby send it again.
> > >
> > > I still have an incomplete patch lying around that synchronizes Volume
> > > on org.mpris.MediaPlayer2.Player back when this patch was written 6
> > > months ago. It'll require some time to get back in to it and finalize
> > > it, let me know if that's desired.
> > >
> > > - Marijn Suijten
> > >
> > >  profiles/audio/avrcp.c | 12 ++++++++----
> > >  profiles/audio/media.c | 16 ----------------
> > >  2 files changed, 8 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> > > index e2428250e..8370c8a44 100644
> > > --- a/profiles/audio/avrcp.c
> > > +++ b/profiles/audio/avrcp.c
> > > @@ -3625,12 +3625,13 @@ static void avrcp_volume_changed(struct avrcp *session,
> > >         struct avrcp_player *player = target_get_player(session);
> > >         uint8_t volume;
> > >
> > > -       if (!player)
> > > -               return;
> > > -
> > >         volume = pdu->params[1] & 0x7F;
> > >
> > > -       player->cb->set_volume(volume, session->dev, player->user_data);
> > > +       /* Always update the transport volume, which is separate from the player */
> > > +       media_transport_update_device_volume(session->dev, volume);
> > > +
> > > +       if (player)
> > > +               player->cb->set_volume(volume, session->dev, player->user_data);
> > >  }
> > >
> > >  static void avrcp_status_changed(struct avrcp *session,
> > > @@ -4378,6 +4379,9 @@ static gboolean avrcp_handle_set_volume(struct avctp *conn, uint8_t code,
> > >
> > >         volume = pdu->params[0] & 0x7F;
> > >
> > > +       /* Always update the transport volume, which is separate from the player */
> > > +       media_transport_update_device_volume(session->dev, volume);
> > > +
> > >         if (player != NULL)
> > >                 player->cb->set_volume(volume, session->dev, player->user_data);
> > >
> > > diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> > > index 993ecb3b3..a0173fdd4 100644
> > > --- a/profiles/audio/media.c
> > > +++ b/profiles/audio/media.c
> > > @@ -1202,27 +1202,11 @@ static uint32_t get_duration(void *user_data)
> > >  static void set_volume(uint8_t volume, struct btd_device *dev, void *user_data)
> > >  {
> > >         struct media_player *mp = user_data;
> > > -       GSList *l;
> > >
> > >         if (mp->volume == volume)
> > >                 return;
> > >
> > >         mp->volume = volume;
> > > -
> > > -       for (l = mp->adapter->endpoints; l; l = l->next) {
> > > -               struct media_endpoint *endpoint = l->data;
> > > -               struct media_transport *transport;
> > > -
> > > -               /* Volume is A2DP only */
> > > -               if (endpoint->sep == NULL)
> > > -                       continue;
> > > -
> > > -               transport = find_device_transport(endpoint, dev);
> > > -               if (transport == NULL)
> > > -                       continue;
> > > -
> > > -               media_transport_update_volume(transport, volume);
> > > -       }
> > >  }
> > >
> > >  static bool media_player_send(struct media_player *mp, const char *name)
> > > --
> > > 2.27.0
> > >
>
> Applied, Thanks. Note that I did fix some coding style problems.

Thanks, I wasn't sure about submitting a v2 to merely trim the
comments or remove them altogether. Note that the link to the mail
thread referenced with `[1]` inadvertently disappeared too.

> --
> Luiz Augusto von Dentz

- Marijn

[1]: https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/merge_requests/239
