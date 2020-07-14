Return-Path: <SRS0=5ENf=AZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C564FC433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jul 2020 00:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 916C621548
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jul 2020 00:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhYPvviX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbgGNAGe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jul 2020 20:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgGNAGd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jul 2020 20:06:33 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAA3C061755
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2020 17:06:33 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 5so11143619oty.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2020 17:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SQ3l4doeyUmx+JMK3G+1kNxMSGthKGgDrjcyPjOBTyg=;
        b=EhYPvviXqSCQUswVE4uzykuMhXDLWUEmQIptrvC2aoYHbqdqm8xHGByblxyud97Pob
         aaV4MJ7Q47kfUATrwyKaz6FjJpJrunvYilGkptUi99whTHmhAldFiLM2W0FuvkwPrRnz
         WJuQsDetGQfFQ1UuvkCgTjMcBa9UhUwTVFxLlOxbuJuq6BkUAIPhoNbAtxlIDvmLuQJV
         4SwI0ZYEzcwlSkQH9+FgKlD249RTqdaVNgOlqItJo4bo70IjeXv2LOpbdb7QBxheirW0
         fPEOBOkpdLFHFx0MZXifPaIjN/k4tdcAfTAjcXkDdO111WcomF4aj+y1J4DSLpX+QiEi
         LFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SQ3l4doeyUmx+JMK3G+1kNxMSGthKGgDrjcyPjOBTyg=;
        b=IipPmJkilxw7jkTRrSOd4Qs05UPfg4VoclBw+YiYi55d9NNC1LKSABoDimfsGGFsQq
         X9mxaq29bwegO0i21HjzWK66WMc9XO64YQrECgKXZ2eopkMVDq8TkLqaxzHkaqX6Z58W
         1dzNznD4pfukZghbSRz68axWCLdfGrIMmw/EpqL0cTHVUBZfwtN6M4uHzHRMO2hl0y0/
         deuqZ4QXs9Ri+qh4wTiZyO+q6ii5ukc53mAKmITaeS8+a/5GpAyT7m/75gh5WPgQkZpQ
         fTKBopdS+Rr/vfQ+etuJqWofbHNO7/MZFHqKXz4g1MDxmADsKXEmpdTMMy5u4sfRvY19
         RxZA==
X-Gm-Message-State: AOAM530sWoyPPAc0ZXl+QvRK1JrFVR3Q5KtIhGI7w9DnOSuLk1M23gTU
        6+Ypj2jJsWdjWsG5JYyrrd3Sb/3cA9T0NAkINFo=
X-Google-Smtp-Source: ABdhPJyHcOi+dgzhLC72u0k6nDDUCHyz4XlmLN9sWqvfROiKg3DNKm7EKZ80f7BukArtBxoIb3ZNlW26gGRNacH58gM=
X-Received: by 2002:a9d:5e18:: with SMTP id d24mr1850375oti.88.1594685193051;
 Mon, 13 Jul 2020 17:06:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200711115031.123793-1-marijns95@gmail.com> <CABBYNZJid20zZDBtjkm14zLF8XOEhxBOfGffYo0aWX0aE0N54A@mail.gmail.com>
In-Reply-To: <CABBYNZJid20zZDBtjkm14zLF8XOEhxBOfGffYo0aWX0aE0N54A@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 13 Jul 2020 17:06:21 -0700
Message-ID: <CABBYNZL1Ac4jnKGbK2vqBeAog09xSR-nHhgLCBA166Wqiwzefw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] audio/avrcp: Always update transport volume
 regardless of player
To:     Marijn Suijten <marijns95@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marijn,

On Mon, Jul 13, 2020 at 5:05 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Marijn,
>
> On Sat, Jul 11, 2020 at 4:50 AM Marijn Suijten <marijns95@gmail.com> wrote:
> >
> > `Volume` is a special property that not only exists on players but also
> > on the transport (see org.bluez.MediaTransport1). A player is not
> > attached when the controller does not support FEATURE_CATEGORY_1, which
> > is common on headphones without media browsing capabilities.
> >
> > On such audio devices (headphones, in-ears and the like) Absolute Volume
> > is not available unless an external player is registered
> > (org.bluez.Media1.RegisterPlayer) and the device sends a volume event
> > back after that to set a2dp->volume in transport.c to a valid value
> > (causing volume_exists to finally return true).
> >
> > This [1] mail thread denoting the same issue has a solution to at least
> > request capabilities from the controller, but the proposed player object
> > is not created on category 2 devices. Any notifications received on
> > AVRCP_EVENT_VOLUME_CHANGED (avrcp_volume_changed) that is subsequently
> > registered, or handling the result of avrcp_set_volume in
> > avrcp_handle_set_volume will be ignored unless said player is present.
> >
> > This issue is not addressed by adding a fake player but instead dealing
> > with the fact that volume is "special" and available on the transport
> > regardless of the existence of a player. This is confirmed in
> > avrcp_get_capabilities_resp as well which requires a player to register
> > any event except AVRCP_EVENT_VOLUME_CHANGED.
> >
> > The applied solution moves media_transport_update_device_volume out of
> > the player and into avrcp_volume_changed/avrcp_handle_set_volume where
> > it is unconditionally called. These functions are the only users of
> > avrcp_player->set_volume.
> >
> > Note that the volume member of media_player is never used which seems a
> > result of updating from org.bluez.MediaPlayer1 to
> > org.mpris.MediaPlayer2.Player in
> > 15e421737ccc4696ed567edcc24d178aedb47854, where the volume property [2]
> > is left out.
>
> This is actually on purpose since the volume notification indicates
> the volume at the device side we don't want to change the player
> volume as well as it would most likely result in duplicating the
> volume change both at sink and source, note that the likes of handling
> the transport like pulseaudio would already notify the device volume
> level change without actually applying any change to the volume
> locally.
>
> > [1]: https://marc.info/?l=linux-bluetooth&m=145337574806153
> > [2]: https://specifications.freedesktop.org/mpris-spec/2.2/Player_Interface.html#Property:Volume
> >
> > ---
> > Hi,
> >
> > This is is a resend from an earlier mail that didn't comply with the
> > contributor guidelines. Seeing that the topic of AVRCP volume is brought
> > up recently it is about time to repair it and hereby send it again.
> >
> > I still have an incomplete patch lying around that synchronizes Volume
> > on org.mpris.MediaPlayer2.Player back when this patch was written 6
> > months ago. It'll require some time to get back in to it and finalize
> > it, let me know if that's desired.
> >
> > - Marijn Suijten
> >
> >  profiles/audio/avrcp.c | 12 ++++++++----
> >  profiles/audio/media.c | 16 ----------------
> >  2 files changed, 8 insertions(+), 20 deletions(-)
> >
> > diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> > index e2428250e..8370c8a44 100644
> > --- a/profiles/audio/avrcp.c
> > +++ b/profiles/audio/avrcp.c
> > @@ -3625,12 +3625,13 @@ static void avrcp_volume_changed(struct avrcp *session,
> >         struct avrcp_player *player = target_get_player(session);
> >         uint8_t volume;
> >
> > -       if (!player)
> > -               return;
> > -
> >         volume = pdu->params[1] & 0x7F;
> >
> > -       player->cb->set_volume(volume, session->dev, player->user_data);
> > +       /* Always update the transport volume, which is separate from the player */
> > +       media_transport_update_device_volume(session->dev, volume);
> > +
> > +       if (player)
> > +               player->cb->set_volume(volume, session->dev, player->user_data);
> >  }
> >
> >  static void avrcp_status_changed(struct avrcp *session,
> > @@ -4378,6 +4379,9 @@ static gboolean avrcp_handle_set_volume(struct avctp *conn, uint8_t code,
> >
> >         volume = pdu->params[0] & 0x7F;
> >
> > +       /* Always update the transport volume, which is separate from the player */
> > +       media_transport_update_device_volume(session->dev, volume);
> > +
> >         if (player != NULL)
> >                 player->cb->set_volume(volume, session->dev, player->user_data);
> >
> > diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> > index 993ecb3b3..a0173fdd4 100644
> > --- a/profiles/audio/media.c
> > +++ b/profiles/audio/media.c
> > @@ -1202,27 +1202,11 @@ static uint32_t get_duration(void *user_data)
> >  static void set_volume(uint8_t volume, struct btd_device *dev, void *user_data)
> >  {
> >         struct media_player *mp = user_data;
> > -       GSList *l;
> >
> >         if (mp->volume == volume)
> >                 return;
> >
> >         mp->volume = volume;
> > -
> > -       for (l = mp->adapter->endpoints; l; l = l->next) {
> > -               struct media_endpoint *endpoint = l->data;
> > -               struct media_transport *transport;
> > -
> > -               /* Volume is A2DP only */
> > -               if (endpoint->sep == NULL)
> > -                       continue;
> > -
> > -               transport = find_device_transport(endpoint, dev);
> > -               if (transport == NULL)
> > -                       continue;
> > -
> > -               media_transport_update_volume(transport, volume);
> > -       }
> >  }
> >
> >  static bool media_player_send(struct media_player *mp, const char *name)
> > --
> > 2.27.0
> >

Applied, Thanks. Note that I did fix some coding style problems.

-- 
Luiz Augusto von Dentz
