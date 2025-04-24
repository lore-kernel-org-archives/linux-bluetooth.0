Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B650A14F9EB
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 15:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745508040; cv=none; b=PqU36UjOIyiU5goAyIdbHUZXX8IztOFWMat+IQdRunjYEXZCDqjyCsQUaDnnCJu+o1Rj5yg/2L20c7/tPNmlBU6hSRf6WNX4R+hp2/SRxIbUGHbJyO68V74OCUB09OmrTr/Y41usB8ZlWndeciVFAYn2DL0vfrd8z03Z+VS1Ugc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745508040; c=relaxed/simple;
	bh=30zRYwWDyw97L13NJN/2WyH1N5UknthXGDYpx0TE0AA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TkeUlF61qvzYlVycjpuesutnVHSrekNjRTWTBuXiG6mAOUC0QkssQgga+WlGh2SNu+KG7kvjq/6VoEXZjSsFB3QPYfs8D7t8mZZBz8RtBLg64Atlb/Vs/Gr3dSvlBnvewXeFVX/QKVt146yj0mZyYmUDfpcdeVa3RQNpzUFpyYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQ66hhRg; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQ66hhRg"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3105ef2a08dso11514541fa.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 08:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745508037; x=1746112837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSfQoZM8FUagUD2lrk8PT0fed1B7hY1NOW7y1MucNhs=;
        b=iQ66hhRgtucrx47Q2sF+mXaRg+q1Wc40dOIWlgaE8VRthI+8TD6UEsBasL4JOHPb1x
         0gcRgF03Vyf8z2cp7Na8OszhHpO2ngRKrM3d7mi7qBKruRAt5yhMeqpfXSF/9n2aAa+R
         EGDly6iEub6aCqbdMZwL8mh9WYLKX1hEPfFr/rKr4s71W0djRkbtJg3mIr0b3vywZHUy
         rcJ00JuecHJpd1RbHlRo5zYohNldEvC8YsTiZ4fPc1BWBxgHbuMqXZik5+nAjiFuLxg4
         SbUd3Y17xIda0jKYuu8KCCmjl1PlgoDT+F3gjUxMZVeVaRQ0EefGh71p/wcfUrwkKzU5
         MdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745508037; x=1746112837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eSfQoZM8FUagUD2lrk8PT0fed1B7hY1NOW7y1MucNhs=;
        b=YNm18faSmNykQ7kTgGlAJ7OEe9wmbW/772C+YV0NXSjCqAHVSolPHX8Of/TRzIBIsJ
         IWudXLGMqaw3F20l3AqYicKYXqVL6DVoT36urUOIP7JFG6yTJ6g+Ty+ggl+wKyrJh42R
         Y7Fnip966GbQGasg/Vl4SzNSlGidzdka5WkOsRIUKIGyZIIB58eL7mMpECrazDAprtdt
         bz+HK7DDaurZpF6BMZ5Y0B3C5fnX/cRHTas/mc+qvK6Pd5sYv7f5VriAU02L4fJEBwa9
         ZqfSoIEKmE2/SfRQQ6lxr3JoocDylCA0ybj250xmve1BT/qHh0D7jaY1fUGAPWatsUKo
         Y5/Q==
X-Gm-Message-State: AOJu0YxXj7P3yo/iAwG69FMP4+hXg1nLivh1PBof2IS5jgx1hUtJLGu1
	IAp4oGPMNUkS5QGuRmOjCZV7WUgJIxlIoAH10KPpmpXWvUEswBKgDGBHcsQZA34SUi7VJ9Q2UFv
	mtxrl9UgmB4JjKymoHZJyV/fEq2gwxQ==
X-Gm-Gg: ASbGncvgB1wWVb5FHoL9V98QkBnG2cdyMTFZwO0/iGzDdlfB7AQklObkCf3yy6qA24S
	/XZG3GbWAMBo8dDZo637CeOJoiJdcSOK84jKSGaj4RL/QdVVW825/cbdE4oxFdueX+6EadkaS2E
	tQsmQoDN4Un6L7FQLM4705
X-Google-Smtp-Source: AGHT+IEqTsn5jxkZYEcljG47XBo2RwMLinlqRia2KavV8fs54gcnXK/VeSl+m4KCSDFq8eXMqlxpwSqrOWAIZ8ho57o=
X-Received: by 2002:a05:651c:1608:b0:30a:4428:dead with SMTP id
 38308e7fff4ca-317a01c860amr12000621fa.27.1745508036367; Thu, 24 Apr 2025
 08:20:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424144831.95766-1-ludovico.denittis@collabora.com>
 <20250424144831.95766-7-ludovico.denittis@collabora.com> <CABBYNZKZoBaw_MzRqmR3CUv+=rw_U=Uo25engjsFG=9u-jU8XQ@mail.gmail.com>
 <be3ecba1-8f13-4b63-9835-e4dc4b375dbe@collabora.com>
In-Reply-To: <be3ecba1-8f13-4b63-9835-e4dc4b375dbe@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 24 Apr 2025 11:20:23 -0400
X-Gm-Features: ATxdqUG0REB33nyIpjDXDV8HHkqzcPl1jw8ONTepU0B8ibeOWYAtrf_FDgzwdMM
Message-ID: <CABBYNZ+qLqJXpzb-45xDQ76GmXg-FJo83VhcuM+kX-KDQfTauQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 6/7] adapter: Set server security level in load_devices()
To: Ludovico de Nittis <ludovico.denittis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ludovico,

On Thu, Apr 24, 2025 at 11:10=E2=80=AFAM Ludovico de Nittis
<ludovico.denittis@collabora.com> wrote:
>
> Hi Luiz,
>
> On 4/24/25 4:57 PM, Luiz Augusto von Dentz wrote:
> > Hi Ludovico,
> >
> > On Thu, Apr 24, 2025 at 10:50=E2=80=AFAM Ludovico de Nittis
> > <ludovico.denittis@collabora.com> wrote:
> >> After loading known devices from storage, change the security level if
> >> we have a device with `CablePairing`.
> >> This will allow it to successfully establish a connection.
> >> ---
> >>   src/adapter.c | 7 +++++++
> >>   1 file changed, 7 insertions(+)
> >>
> >> diff --git a/src/adapter.c b/src/adapter.c
> >> index fd425e6d2..8d875013c 100644
> >> --- a/src/adapter.c
> >> +++ b/src/adapter.c
> >> @@ -68,6 +68,7 @@
> >>   #include "adv_monitor.h"
> >>   #include "eir.h"
> >>   #include "battery.h"
> >> +#include "profiles/input/server.h"
> >>
> >>   #define MODE_OFF               0x00
> >>   #define MODE_CONNECTABLE       0x01
> >> @@ -5090,6 +5091,12 @@ free:
> >>                  g_key_file_free(key_file);
> >>          }
> >>
> >> +       if (btd_adapter_has_cable_pairing_devices(adapter)) {
> >> +               DBG("There is at least one known cable paired device, =
setting the "
> >> +                       "listening input server security level accordi=
ngly");
> >> +               server_set_cable_pairing(&adapter->bdaddr, true);
> >> +       }
> > This creates a dependency on the input which is a plugin that can be
> > excluded/not loaded at runtime, so we can't really do this at daemon
> > core.
>
> Do you have any suggestions on how to shuffle this around to avoid callin=
g
> `server_set_cable_pairing()` directly from `adapter.c`? Because in
> theory that
> should still happen after we ensured  we loaded all devices from storage.

We should probably evaluate this on probe, if the device has been
marked with cable pairing flag then it should call
server_set_cable_pairing, if we cannot evaluate it at that point then
we need some callback mechanism to notify the plugin when the cable
pairing property changes.

> >>          closedir(dir);
> >>
> >>          load_link_keys(adapter, keys, btd_opts.debug_keys);
> >> --
> >> 2.49.0
> >>
> >>
> >
>


--=20
Luiz Augusto von Dentz
