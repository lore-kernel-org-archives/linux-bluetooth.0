Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8E41E5B72
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Aug 2025 16:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754409709; cv=none; b=H27H3IT4nknQifWQZAZ1MBnzatBMCoxbnNHKX3RT18mOXrOu+gVG4Sna+N+bVq+vQsEv3p+ux9vuRKGw7gzm51Gww5XGkXkQTIZKcYCrwGlWAvI7vhRLKWqakejiFYYoIWj466L2LP2B604dhWf14vh5VaL8HXbDfHnZLsNEJ84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754409709; c=relaxed/simple;
	bh=B/tmvrfM6/Mx1p3oLxuHoT47PpkWXvrRQLlSPmHVh/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=er8hUJXz64KwY1xCw9R1urps/BfmY3BGy+pmhMq8X67lKHBWhFZ9BXQFlqiRO7EoYz5pbl3CXz+e5WJi1EF7Gx6vWEuby2qMnTSg9FqsIraystprtxH374avrp1YMtZkdbE43ZWAy+MlPlcUuSO6lBtNejS6J5oZblM0vX/IgY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJVWBNNx; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJVWBNNx"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-33250b6be11so30079681fa.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Aug 2025 09:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754409706; x=1755014506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jncChIk41ebtsucCIMDov+rHxr8jCz4khjIEMXT7UOo=;
        b=eJVWBNNxTgc4qXgzivG0YndeOHfAavofJcOCOVi1kpoajWgvOh3kge+AcI0ZffG99W
         YHB6eoFrhwJclht7tgiInzzLduv5TxFkMZQ7ESOJqcy8YhpXglAMmPwkan+d0+MJa9D8
         cqLvwQzTUWK1duhoEzWw36JpbBCgoc1mo3FqUdsFDLhGffqCEIaF9/kg/bd3XRFALFWd
         4Wc+URPnsyO2S+1KxYwqbqPCrUR/m3SSmEK06o34EwQK8UzSb1vfNmSORPNFmOq2vjSu
         VNTf76I0nb6OSL7D64yyB4u6Qkoa7XpemK3X/JHDfGMFznI8IDgdTtMKXmjxb+N2W5Kr
         bTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754409706; x=1755014506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jncChIk41ebtsucCIMDov+rHxr8jCz4khjIEMXT7UOo=;
        b=CSuK8zDc6n9UAb7DAV25kgYnqITk0mcs+FjuQVu4osp+xeCTcOaJF7tW/+XKxmVH41
         hTIOf3kgjjqu4Hhe+XI0J3DsAMPVtg/WJ/jd1ImxwDEpt0jjxRy/QpTwZEMN/755f/H7
         ipBnRw9rA2Rd6fdwa2RRWUGQWpw7Ma/nRUeE+J2w74qM0QhVhvAWePeXWsgNmnaWw/PP
         eC1/sG5LfByrMN6De7Afcwan0PxYb5xsePc+QlauJkJ9/RPLnYhgJwtTwFRcpkU0EvH8
         MPputdDxRIXb6yCOpEvz9UNSnMlLkSCxo+auQ9AthOZzGGieqN98TAiTi9gX3DdZ2L7l
         MI+A==
X-Gm-Message-State: AOJu0YzZWI2HM0hUiU0VWI8MJDMSE5Fyk1HQ4cFJpHYW6BMiBTaAoVtu
	9xMwJyvDnHE10NAqsc3qa6uz42DitNa82WUdORINhqNzC3qtgZt922uadlUBvMdBvaORqicuon9
	k01a+3o6mPDxyTK9B2MuZWFfJPvcKO6q8+8HqTn8=
X-Gm-Gg: ASbGnctBZtZZrGPVW5InrrhPc/QMkeunqLjcGr4vjdrD89moWkl8X6a3DrRxjQcis3O
	yhUV+LcQlzCxF/3d2U69bjYKtnvqgYyDTNdg/07FOuKqhSpMbscJ4GOLtLV1GD+TPd/K3KGLR5m
	HcQg20Nr0mDPEPxxRK6Kn0vpFjdA458tDEXupqpN82yMB6dhaUarB3gU6SGtXYoVvJ+OmP2CRCr
	MIP+Q==
X-Google-Smtp-Source: AGHT+IE23KnGSM5FXQtMv6xWmkdbr5LvcxTR1IGjFEHAdsp8ugdJtAs2DIc1JWKx3f9Ns5K3CPzAPcz4Rhl8zJ626VQ=
X-Received: by 2002:a2e:be28:0:b0:332:631e:42ff with SMTP id
 38308e7fff4ca-332631e4829mr24530911fa.13.1754409705231; Tue, 05 Aug 2025
 09:01:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805-audio-no-reuse-media-player-volume-v1-1-c9fdfaf74a71@qtmlabs.xyz>
 <CABBYNZJ=Kc_WMa2Srnci=20e+F+JZyPmWFXsjxt8sn_6g0coKQ@mail.gmail.com> <8e903ca0-aeb3-46c2-8da3-95173cb482e5@qtmlabs.xyz>
In-Reply-To: <8e903ca0-aeb3-46c2-8da3-95173cb482e5@qtmlabs.xyz>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 5 Aug 2025 12:01:32 -0400
X-Gm-Features: Ac12FXxggaH4fgQRrVDH37uEJJipnV_2yfndU9Q_2YVuX6dDu3uGKHCYAmuN1t4
Message-ID: <CABBYNZK+vMXgv6OZuCKABqFE+1Y0kojqd2d0EkhJ-3UFVnUq4w@mail.gmail.com>
Subject: Re: [PATCH bluez] audio: Don't initialize device volume from media player
To: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Myrrh,

On Tue, Aug 5, 2025 at 11:34=E2=80=AFAM Myrrh Periwinkle
<myrrhperiwinkle@qtmlabs.xyz> wrote:
>
> Resent because I forgot to use "Reply All"
>
> On 8/5/25 22:24, Luiz Augusto von Dentz wrote:
> > Hi Myrrh,
> >
> > On Tue, Aug 5, 2025 at 6:29=E2=80=AFAM Myrrh Periwinkle
> > <myrrhperiwinkle@qtmlabs.xyz> wrote:
> >> Media player objects may be shared between devices. As a result,
> >> a device without support for hardware volume that is connected after o=
ne
> >> that does may end up being erroneously considered hardware
> >> volume-capable.
> > Don't quite follow, avrcp_player is per device, not sure how it can be
> > shared between devices?
> >
> >> fa7828bdd ("transport: Fix not being able to initialize volume properl=
y")
> >> introduced btd_device_{get,set}_volume that is used as an alternative =
in
> >> case no media player objects are present. Therefore, we can remove
> >> media_player_get_device_volume and instead use btd_device_get_volume t=
o
> >> determine the initial volume.
> > Don't follow you here, why shouldn;t we use the media player if we have=
 one?
> >
> >> ---
> >>   profiles/audio/avrcp.c |  2 +-
> >>   profiles/audio/media.c | 33 +--------------------------------
> >>   profiles/audio/media.h |  1 -
> >>   3 files changed, 2 insertions(+), 34 deletions(-)
> >>
> >> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> >> index e2797112fcd580c3fc56793f933e00b1c61e5205..ec07522e6a34eb1dc5f6f4=
13f48f1087a609df9a 100644
> >> --- a/profiles/audio/avrcp.c
> >> +++ b/profiles/audio/avrcp.c
> >> @@ -4284,7 +4284,7 @@ static void target_init(struct avrcp *session)
> >>                  target->player =3D player;
> >>                  player->sessions =3D g_slist_prepend(player->sessions=
, session);
> >>
> >> -               init_volume =3D media_player_get_device_volume(session=
->dev);
> >> +               init_volume =3D btd_device_get_volume(session->dev);
> >>                  media_transport_update_device_volume(session->dev, in=
it_volume);
> >>          }
> >>
> >> diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> >> index 8e62dca17070edbc5101677c6eebd3707492c824..55f1482d1d9ce52e104481=
bab3ede373f47aee0c 100644
> >> --- a/profiles/audio/media.c
> >> +++ b/profiles/audio/media.c
> >> @@ -499,37 +499,6 @@ struct a2dp_config_data {
> >>          a2dp_endpoint_config_t cb;
> >>   };
> >>
> >> -int8_t media_player_get_device_volume(struct btd_device *device)
> >> -{
> >> -#ifdef HAVE_AVRCP
> >> -       struct avrcp_player *target_player;
> >> -       struct media_adapter *adapter;
> >> -       GSList *l;
> >> -
> >> -       if (!device)
> >> -               return -1;
> >> -
> >> -       target_player =3D avrcp_get_target_player_by_device(device);
> >> -       if (!target_player)
> >> -               goto done;
> >> -
> >> -       adapter =3D find_adapter(device);
> >> -       if (!adapter)
> >> -               goto done;
> >> -
> >> -       for (l =3D adapter->players; l; l =3D l->next) {
> >> -               struct media_player *mp =3D l->data;
> >> -
> >> -               if (mp->player =3D=3D target_player)
> >> -                       return mp->volume;
> The `avrcp_player` object indeed is not shared between devices, but the
> volume is acquired from (and set for) the associated `media_player`
> object which is not tied to a specific device, and corresponds to client
> `org.mpris.MediaPlayer2.Player` objects.

Ok, so what is the problem with that? If there are 2 headsets that
wants to control the same player registered via mpris-proxy(?) that
should be allowed, or the problem is that each device should control a
dedicated instance of the volume? I suspect the volume store in
mp->volume is only used as initial volume since the actual volume is
stored in the Transport.Volume, the reason why we can't use the
Transport directly is that it is created on demand while there is a
stream so if the stream is not ready at time a volume has been set we
need to store it elsewhere, that said perhaps that should be store per
device not per media_player which seem to be registered per adapter in
media.c but then we should probably remove the volume field altogether
to avoid any confusion in the future.

> >> -       }
> >> -
> >> -done:
> >> -#endif /* HAVE_AVRCP */
> >> -       /* If media_player doesn't exists use device_volume */
> >> -       return btd_device_get_volume(device);
> >> -}
> >> -
> >>   static gboolean set_configuration(struct media_endpoint *endpoint,
> >>                                          uint8_t *configuration, size_=
t size,
> >>                                          media_endpoint_cb_t cb,
> >> @@ -556,7 +525,7 @@ static gboolean set_configuration(struct media_end=
point *endpoint,
> >>          if (transport =3D=3D NULL)
> >>                  return FALSE;
> >>
> >> -       init_volume =3D media_player_get_device_volume(device);
> >> +       init_volume =3D btd_device_get_volume(device);
> >>          media_transport_update_volume(transport, init_volume);
> >>
> >>          msg =3D dbus_message_new_method_call(endpoint->sender, endpoi=
nt->path,
> >> diff --git a/profiles/audio/media.h b/profiles/audio/media.h
> >> index 2b2e8e1572874d5f71abb28fdd5b92fa2d9efe83..d3954abd6de505a69cab3f=
cffc217d236a52d3e5 100644
> >> --- a/profiles/audio/media.h
> >> +++ b/profiles/audio/media.h
> >> @@ -23,6 +23,5 @@ uint8_t media_endpoint_get_codec(struct media_endpoi=
nt *endpoint);
> >>   struct btd_adapter *media_endpoint_get_btd_adapter(
> >>                                          struct media_endpoint *endpoi=
nt);
> >>   bool media_endpoint_is_broadcast(struct media_endpoint *endpoint);
> >> -int8_t media_player_get_device_volume(struct btd_device *device);
> >>
> >>   const struct media_endpoint *media_endpoint_get_asha(void);
> >>
> >> ---
> >> base-commit: 2c0c323d08357a4ff3065fcd49fee0c83b5835cd
> >> change-id: 20250805-audio-no-reuse-media-player-volume-fbc2983a287a
> >>
> >> Best regards,
> >> --
> >> Myrrh Periwinkle<myrrhperiwinkle@qtmlabs.xyz>
> >>
> >>



--=20
Luiz Augusto von Dentz
