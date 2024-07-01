Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5032D16EB5E
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jul 2024 15:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719846260; cv=none; b=gGJWWDL+UuOKRIerWVp5Uy+lAPDqHb2kwr336cmR5GD+uorohi8tsL5e1ldUN6RA7lJEoxZQID/D+OxH3tVojOATHA8slv3AxkLoswj+FTuzCfJ/UqjntiJ0TFtmjr/Ti/2Z6V+oO6GgPmuCqN+qQXKnYBYZvMn0/8q0sivENcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719846260; c=relaxed/simple;
	bh=FT7mSZPteWkUwioNpHe1hvw/jip1u1Gu9JN4DWCsbYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V/622McXubRU/arRdVWFAa/CHeEUgs20XHYX2vk7ckTYUJBDTZ6+xGdDpb7plv+BZelte+z9/P7JZ6RGgN716FbnK/vvU3tkQ1raFxeq5z8mwXTg6/3i5sUpjbrenM7Z5WyN0eI/tHXQGAyDV9N8K+qukO7rklD0NuZgJb8niU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVsjCOV9; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVsjCOV9"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ebe0a81dc8so42096241fa.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jul 2024 08:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719846256; x=1720451056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dolRartDVncLOu7qchiZBbMqO17xnTkRHIByLzWjsxE=;
        b=gVsjCOV9YaZgx9lWUaf1NU9uWsuQSqZVD5cOjWySkMm923iARugpxvOjBaDbYTP/4M
         rxteVuhY8bapG8Pb6f57p/5Zg6AkE2s0pPDZiB7B/TELALWhUTjzNGEC7B1/BjooZXeV
         nAX8Yz/fuBBLHVKfB+p7mrSFdnVn7bLz+wKFkmjTph84BgSSIRH9ZaQOIrLudW/HsYiN
         rxZM+IqJSohfWSaAX1xP+RAe0uXngrle6hpGWj9Kegb489aEI2iwJBXNvgZtiU4X198P
         clMV4IF7Zvc0C+H7E5+ty/EfapnxAXGPtqsDoh+Vz+NzF1x+cyvAiLvbzB7WiIRXxMKZ
         aVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719846256; x=1720451056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dolRartDVncLOu7qchiZBbMqO17xnTkRHIByLzWjsxE=;
        b=sR9jH3lNIY6SW1whd/uyRquf0BehbkOxLHGiP1R2UC7BJSPpQBWcAjLpmaPs/ADqO5
         j65ete+QRlEk7UkiAXfFjRpi1n+dqE36moV5/j8xK3dQ/ZRO77QHFOAroyJN1DIeYtwp
         yFNikJO6faLXq0gsAlMnuwaemlnMNZj7OFmSAiaINpJpn9mzytQY2rcyS680ExGL3PW3
         WIAgNW7CWZhDSPSLaeAMU3blbvp8OBmoubkVdGib2IM3+kjo0ieNp5dhtA0ft38sgRt/
         kqA/YKYefIfducGCNf1+iombhY88fLaMJl4hcQINGFnieeCLntn0WlTbUoLLtw0S1mhF
         SNoA==
X-Gm-Message-State: AOJu0YwVZChyEAVQSCdV0y/sd+NiA2LZ6+ovT8Z3Q6NaPqwa8r8uhII5
	0uCEiRxoM0IhRXKLjoONADLqZVUgYFBbimefLul4rUFc1EgXZHlTC801P6F0b3772hcDp4Ab/qZ
	LFK2b1ptr/D4cTu3XNO2zU4NTPos6wQ==
X-Google-Smtp-Source: AGHT+IE5koZ0ScJwN19tCOGMo1YV3oLWDsu7T+CtdUSLzKGXjEycvJBfoshQmkRmpUtK4KfvSKvI1IDd8i0yEJDw3uM=
X-Received: by 2002:a05:651c:2127:b0:2ee:594d:f54b with SMTP id
 38308e7fff4ca-2ee5e6f7781mr47605321fa.47.1719846256341; Mon, 01 Jul 2024
 08:04:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701143135.45677-1-iulia.tanasescu@nxp.com> <20240701143135.45677-2-iulia.tanasescu@nxp.com>
In-Reply-To: <20240701143135.45677-2-iulia.tanasescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 1 Jul 2024 11:04:04 -0400
Message-ID: <CABBYNZJU-EeScD+zBes7xhRzM7FBwyXcNh4g-HqV9RBv80nbZQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/1] doc: Add initial MediaAssistant rst
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com, 
	mihai-octavian.urzica@nxp.com, vlad.pruteanu@nxp.com, 
	andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Iulia,

On Mon, Jul 1, 2024 at 10:31=E2=80=AFAM Iulia Tanasescu <iulia.tanasescu@nx=
p.com> wrote:
>
> This adds initial documentation for the MediaAssistant D-Bus API, to
> be used by a Broadcast Assistant application to interract with the
> BlueZ implementation (BASS Client).
> ---
>  Makefile.am                      |  6 +-
>  doc/org.bluez.MediaAssistant.rst | 97 ++++++++++++++++++++++++++++++++
>  2 files changed, 100 insertions(+), 3 deletions(-)
>  create mode 100644 doc/org.bluez.MediaAssistant.rst
>
> diff --git a/Makefile.am b/Makefile.am
> index 0ae721111..46a8cfb49 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -362,7 +362,7 @@ man_MANS +=3D doc/org.bluez.Adapter.5 doc/org.bluez.D=
evice.5 \
>  man_MANS +=3D doc/org.bluez.Media.5 doc/org.bluez.MediaControl.5 \
>                 doc/org.bluez.MediaPlayer.5 doc/org.bluez.MediaFolder.5 \
>                 doc/org.bluez.MediaItem.5 doc/org.bluez.MediaEndpoint.5 \
> -               doc/org.bluez.MediaTransport.5
> +               doc/org.bluez.MediaTransport.5 doc/org.bluez.MediaAssista=
nt.5
>  man_MANS +=3D doc/org.bluez.GattManager.5 doc/org.bluez.GattProfile.5 \
>                 doc/org.bluez.GattService.5 \
>                 doc/org.bluez.GattCharacteristic.5 \
> @@ -395,7 +395,7 @@ manual_pages +=3D doc/org.bluez.Adapter.5 doc/org.blu=
ez.Device.5 \
>  manual_pages +=3D doc/org.bluez.Media.5 doc/org.bluez.MediaControl.5 \
>                 doc/org.bluez.MediaPlayer.5 doc/org.bluez.MediaFolder.5 \
>                 doc/org.bluez.MediaItem.5 doc/org.bluez.MediaEndpoint.5 \
> -               doc/org.bluez.MediaTransport.5
> +               doc/org.bluez.MediaTransport.5 doc/org.bluez.MediaAssista=
nt.5
>  manual_pages +=3D doc/org.bluez.GattManager.5 doc/org.bluez.GattProfile.=
5 \
>                 doc/org.bluez.GattService.5 \
>                 doc/org.bluez.GattCharacteristic.5 \
> @@ -475,7 +475,7 @@ EXTRA_DIST +=3D doc/org.bluez.Adapter.rst doc/org.blu=
ez.Device.rst \
>  EXTRA_DIST +=3D doc/org.bluez.Media.rst doc/org.bluez.MediaControl.rst \
>                 doc/org.bluez.MediaPlayer.rst doc/org.bluez.MediaFolder.r=
st \
>                 doc/org.bluez.MediaItem.rst doc/org.bluez.MediaEndpoint.r=
st \
> -               doc/org.bluez.MediaTransport.rst
> +               doc/org.bluez.MediaTransport.rst doc/org.bluez.MediaAssis=
tant.rst
>
>  EXTRA_DIST +=3D doc/org.bluez.GattManager.rst doc/org.bluez.GattProfile.=
rst\
>                 doc/org.bluez.GattService.rst \
> diff --git a/doc/org.bluez.MediaAssistant.rst b/doc/org.bluez.MediaAssist=
ant.rst
> new file mode 100644
> index 000000000..a6fdef393
> --- /dev/null
> +++ b/doc/org.bluez.MediaAssistant.rst
> @@ -0,0 +1,97 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +org.bluez.MediaAssistant
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +--------------------------------------------
> +BlueZ D-Bus MediaAssistant API documentation
> +--------------------------------------------
> +
> +:Version: BlueZ
> +:Date: June 2024
> +:Manual section: 5
> +:Manual group: Linux System Administration
> +
> +Interface
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +:Service:      org.bluez
> +:Interface:    org.bluez.MediaAssistant1
> +:Object path:  /org/bluez/{hci0,hci1,...}/src_XX_XX_XX_XX_XX_XX/dev_YY_Y=
Y_YY_YY_YY_YY/bisZ
> +
> +Methods
> +-------
> +
> +void Push(array{byte} Broadcast_Code)
> +````````````````````````````````````````````````````````
> +
> +       Send stream information to the remote device. If the stream
> +       is unencrypted, the Broadcast_Code is set to 0. Otherwise,
> +       it contains the key to decrypt the stream.

I'd make the Push take a QoS dictionary, that way if one can overwrite
the discovered QoS property if it needs to and in case the user
doesn't enter any value then we can assume it wants to use the same
value as in the QoS property.

> +
> +Properties
> +----------
> +
> +string State [readonly]
> +```````````````````````
> +
> +       Indicates the state of the assistant object. Possible values are:
> +
> +       :"idle": assistant object was created for the stream
> +       :"pending": assistant object was pushed (stream information was s=
ent to the peer)
> +       :"requesting": remote device requires Broadcast_Code
> +       :"active": remote device started receiving stream
> +
> +dict QoS [readonly, ISO only, experimental]
> +`````````````````````````````````````````````````````
> +
> +       Indicates QoS capabilities.
> +
> +       Values:
> +
> +       :byte BIG:
> +
> +               Indicates BIG id.
> +
> +       :byte Encryption:
> +
> +               Indicates whether the stream is encrypted.
> +
> +       :array{byte} BCode
> +
> +               Indicates Broadcast_Code to decrypt stream.
> +
> +       :byte Options:
> +
> +               Indicates configured broadcast options.
> +
> +       :uint16 Skip:
> +
> +               Indicates configured broadcast skip.
> +
> +       :byte SyncTimeout:
> +
> +               Indicates configured broadcast sync timeout.
> +
> +       :byte SyncType:
> +
> +               Indicates configured broadcast sync CTE type.
> +
> +       :byte MSE:
> +
> +               Indicates configured broadcast MSE.
> +
> +       :uint16 Timeout:
> +
> +               Indicates configured broadcast timeout.
> +
> +       :uint32 Interval:
> +
> +               Indicates configured ISO interval (us).
> +
> +       :uint16 Latency:
> +
> +               Indicates configured transport latency (ms).
> +
> +       :uint16 SDU:
> +
> +               Indicates configured maximum SDU.
> \ No newline at end of file
> --
> 2.39.2
>


--=20
Luiz Augusto von Dentz
