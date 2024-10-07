Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9581DBB2E
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Oct 2024 15:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728316583; cv=none; b=e8NjBU2nbYRiix1OUaiQhpFz96FqIrmYVStLA7pj9ni13R6SudoCCYjW6UKTc9Fw1SEdTbjpEjb5OowmRy1GGM9A5P/O3R1h9Ji0KcdvNDYveGc3yN7ebHw/ZhZa1IghqCVTcuB6sh7j4OZfLrxrQvSABL6dPu2q0WAfpGsKUdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728316583; c=relaxed/simple;
	bh=TplF65j2SAqxpL+2JerrWoctPg4GMoDklZmGDLN0MOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a/CIM/67ejuElxWevSWtau20uqpE1lC0Yq7Ue3AOuJm9rwi0jDs/b/g4NRqs5WHY16LbTJmDrMHt8ZkHfPrH3Y8mZC7HxY9UuVFTfFdctv4CdJNN7kWxdYOB7oTWMjUPT9ol56730zGEq+b2lWYpTXUTGD8gveJguKZaLLzRsm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zz3qqGJO; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zz3qqGJO"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fad5024b8dso51484541fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Oct 2024 08:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728316579; x=1728921379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGuwjrVycZLIXnNC870RPEg9wyvmJoD9MiOQosRaHvo=;
        b=Zz3qqGJO0OxWBAxsacxdHBAYZolTSqM0rRn2E2osvcwXh71ytMKBqOL59uWbgUlJjC
         eI/gU7c87Mf5/ICTTMdFSBW796ieeldb9tVHKQViA0Blk+2v1ii969liAGWMN7RIXHJ8
         eDmrI1bCVGEGwEfTiRTBX4VmB4u7pmH/U/2dkDwLRhONJZMNiNlCuxeiJA6pWGfOEYNd
         fXDIrEdsV9hpqt8PlKou1LqeNOIoZEz51O179lYxIwkTVNSJCd8LKrRaSMC0r+AURvzG
         qazz5Xus2x5EzhEEgPMmNYGMPLVPOdh7jdOPypnzn4B8NPS9TA/V4VYU8uw+iOIKc+HM
         kW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728316579; x=1728921379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mGuwjrVycZLIXnNC870RPEg9wyvmJoD9MiOQosRaHvo=;
        b=LPNswkSXnK70rmKRpdI/VPAvlJByP6fWr7dKMsuTT6bpg1/Z5tg849uau0wPrKI5bK
         vZ2HhauPi3oXpCWAkHyj//Nys14IohtrGeLf8a8ARLhJjvHX6SwoX+pGZKghb2NCbjyP
         duwK8yn+iXtGVIhe7qT/Y1XzJGeavngZPxzUG00R4suEr80LUA185ehxtyZvWt41Pm9J
         Q3vfECM+4bD/cqAozQZQhVmqjNqNj6ZyCaenaBVvCs5KJBrTGaOlEDiHeOx2Oulfk70y
         3iZWkgwtlJ/RszPfl3jFgNmgHmk8Vth/tto4AZgUKKsbGYxDIP2GJZis7h7xSHPcKi2t
         L+rw==
X-Gm-Message-State: AOJu0YzR8S68u+x0tPW1GHU2vh4NQQOBn+ANOlkQDOEC0MKa1hS2A/O1
	BZNXp4tJqoOqcNWmvdIYU2qqnaJsNW6RLDBtmtkOJCXmxxZSk8mnWyOXv8bIMh4EA9yqBD5jvMS
	7+teMoazeNgzosjZJIZQeK25sLjY=
X-Google-Smtp-Source: AGHT+IEsDqY5TPRxGgZJZTSXWV45w0ZqWOzjWQKH7NYNOyZZextGxMP9ibvfcYgr3C0T7Lw6qeynu58oNWRrlo9WVHU=
X-Received: by 2002:a05:651c:220d:b0:2f3:f39f:3719 with SMTP id
 38308e7fff4ca-2faf3c64c64mr64522741fa.29.1728316579177; Mon, 07 Oct 2024
 08:56:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005214321.84250-1-marijn.suijten@somainline.org> <20241005214321.84250-4-marijn.suijten@somainline.org>
In-Reply-To: <20241005214321.84250-4-marijn.suijten@somainline.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 7 Oct 2024 11:56:06 -0400
Message-ID: <CABBYNZLQexGSfm_0B-0_EFi3MOSZDiGzEdLBWqqUAU6_jRwOZg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v4 3/3] audio/avrcp: Determine Absolute Volume
 support from feature category 2
To: Marijn Suijten <marijn.suijten@somainline.org>
Cc: linux-bluetooth@vger.kernel.org, Yu Liu <yudiliu@google.com>, 
	Bartosz Fabianowski <bartosz@fabianowski.eu>, Pauli Virtanen <pav@iki.fi>, 
	Marek Czerski <ma.czerski@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marijn,

On Sat, Oct 5, 2024 at 5:43=E2=80=AFPM Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> The AVRCP spec (1.6.2) does not mention anything about a version
> requirement for Absolute Volume, despite this feature only existing
> since spec version 1.4.  Android reports a version of 1.3 [1] for its
> "AVRCP remote" (CT) service and mentions in the comment above it itself
> relies on feature bits rather than the exposed version.  As it stands
> BlueZ requires at least version 1.4 making it unable to communicate
> absolute volume levels with even the most recent Android phones running
> Fluoride (have not checked the version on Gabeldorsche).
>
> The spec states that supporting SetAbsoluteVolume and
> EVENT_VOLUME_CHANGED are mandatory when feature level 2 is declared,
> excluded otherwise.  This feature bit is set on Android and, when used
> by this patch, allows for successfully communicating volume back and
> forth despite the version theoretically being too low.
>
> In order to not affect spec tests too much (which I doubt would catch
> this, and should have otherwise pointed out that Android itself is out
> of spec) this behaviour is guarded behind a config option in main.conf,
> as discussed in [2].
>
> Note that this workaround is deliberately omitted for the "AVRCP
> target" profile version, since Android already signals that to be 1.4
> (which allows receiving SetAbsoluteVolume calls or registration for
> EVENT_VOLUME_CHANGED notifications) for other reasons [3].
>
> [1]: https://android.googlesource.com/platform/system/bt/+/android-11.0.0=
_r28/bta/av/bta_av_main.cc#761
> [2]: https://marc.info/?l=3Dlinux-bluetooth&m=3D163463497503113&w=3D2
> [3]: https://android.googlesource.com/platform/system/bt/+/android-11.0.0=
_r28/bta/av/bta_av_main.cc#755
> ---
>  profiles/audio/avrcp.c | 20 ++++++++++++--------
>  src/btd.h              |  1 +
>  src/main.c             |  5 +++++
>  src/main.conf          |  9 +++++++++
>  4 files changed, 27 insertions(+), 8 deletions(-)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 005c3e306..84172a6f6 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -1779,9 +1779,10 @@ static uint8_t avrcp_handle_set_absolute_volume(st=
ruct avrcp *session,
>          * The controller on the remote end is only allowed to call SetAb=
soluteVolume
>          * on our target if it's at least version 1.4 and a category-2 de=
vice.
>          */
> -       if (!session->target || session->target->version < 0x0104 ||
> +       if (!session->target ||
> +                       (btd_opts.avrcp.volume_version && session->target=
->version < 0x0104) ||
>                         (btd_opts.avrcp.volume_category && !(session->tar=
get->features & AVRCP_FEATURE_CATEGORY_2))) {
> -               error("Remote SetAbsoluteVolume rejected from non-categor=
y-2 peer");
> +               error("Remote SetAbsoluteVolume rejected from non-categor=
y-2 or non-AVRCP-1.4 peer");
>                 goto err;
>         }
>
> @@ -4262,13 +4263,15 @@ static void target_init(struct avrcp *session)
>                                 (1 << AVRCP_EVENT_TRACK_REACHED_END) |
>                                 (1 << AVRCP_EVENT_SETTINGS_CHANGED);
>
> -       if (target->version < 0x0104)
> -               return;
> -
> -       if (!btd_opts.avrcp.volume_category || target->features & AVRCP_F=
EATURE_CATEGORY_2)
> +       /* Remote device supports receiving volume notifications */
> +       if ((!btd_opts.avrcp.volume_version || target->version >=3D 0x010=
4) &&
> +                       (!btd_opts.avrcp.volume_category || target->featu=
res & AVRCP_FEATURE_CATEGORY_2))
>                 session->supported_events |=3D
>                                 (1 << AVRCP_EVENT_VOLUME_CHANGED);
>
> +       if (target->version < 0x0104)
> +               return;
> +
>         session->supported_events |=3D
>                                 (1 << AVRCP_EVENT_ADDRESSED_PLAYER_CHANGE=
D) |
>                                 (1 << AVRCP_EVENT_AVAILABLE_PLAYERS_CHANG=
ED);
> @@ -4688,9 +4691,10 @@ int avrcp_set_volume(struct btd_device *dev, int8_=
t volume, bool notify)
>                 return -ENOTCONN;
>
>         if (notify) {
> -               if (!session->target || session->target->version < 0x0104=
 ||
> +               if (!session->target ||
> +                               (btd_opts.avrcp.volume_version && session=
->target->version < 0x0104) ||
>                                 (btd_opts.avrcp.volume_category && !(sess=
ion->target->features & AVRCP_FEATURE_CATEGORY_2))) {
> -                       error("Can't send EVENT_VOLUME_CHANGED to non-cat=
egory-2 peer");
> +                       error("Can't send EVENT_VOLUME_CHANGED to non-cat=
egory-2 or non-AVRCP-1.4 peer");
>                         return -ENOTSUP;
>                 }
>                 return avrcp_event(session, AVRCP_EVENT_VOLUME_CHANGED,
> diff --git a/src/btd.h b/src/btd.h
> index 07205aa69..61e4d309d 100644
> --- a/src/btd.h
> +++ b/src/btd.h
> @@ -107,6 +107,7 @@ struct btd_avdtp_opts {
>  struct btd_avrcp_opts {
>         bool            volume_without_target;
>         bool            volume_category;
> +       bool            volume_version;
>  };
>
>  struct btd_advmon_opts {
> diff --git a/src/main.c b/src/main.c
> index 89ee6897c..e8504cbe3 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -168,6 +168,7 @@ static const char *avdtp_options[] =3D {
>  static const char *avrcp_options[] =3D {
>         "VolumeWithoutTarget",
>         "VolumeCategory",
> +       "VolumeVersion",
>         NULL
>  };
>
> @@ -1155,6 +1156,9 @@ static void parse_avrcp(GKeyFile *config)
>         parse_config_bool(config, "AVRCP",
>                 "VolumeCategory",
>                 &btd_opts.avrcp.volume_category);
> +       parse_config_bool(config, "AVRCP",
> +               "VolumeVersion",
> +               &btd_opts.avrcp.volume_version);
>  }
>
>  static void parse_advmon(GKeyFile *config)
> @@ -1225,6 +1229,7 @@ static void init_defaults(void)
>
>         btd_opts.avrcp.volume_without_target =3D false;
>         btd_opts.avrcp.volume_category =3D true;
> +       btd_opts.avrcp.volume_version =3D false;
>
>         btd_opts.advmon.rssi_sampling_period =3D 0xFF;
>         btd_opts.csis.encrypt =3D true;
> diff --git a/src/main.conf b/src/main.conf
> index fff13ed2f..b6b32a720 100644
> --- a/src/main.conf
> +++ b/src/main.conf
> @@ -316,6 +316,15 @@
>  # notifications.
>  #VolumeCategory =3D true
>
> +# Require peer AVRCP controllers to have at least version 1.4 before
> +# accessing category-2 (absolute volume) features (depending on the valu=
e
> +# of VolumeCategory above).  It is common for Android-powered devices to=
 not
> +# signal the desired minimum version of 1.4 while still supporting absol=
ute
> +# volume based on the feature category bit, as mentioned in this comment=
:
> +# https://android.googlesource.com/platform/system/bt/+/android-12.0.0_r=
1/bta/
> +# av/bta_av_main.cc#621
> +#VolumeVersion =3D false

I'd change this to have the version e.g. #VolumeVersion =3D 1.4, so the
user can switch to 1.3 or "any" in case he want to bypass version
checking, also perhaps we should create an issue for Android folks to
fix their version, as it seems they do support browsing features
channel for TG they should be able to do the same for CT.

> +
>  [Policy]
>  #
>  # The ReconnectUUIDs defines the set of remote services that should try
> --
> 2.46.2
>


--=20
Luiz Augusto von Dentz
