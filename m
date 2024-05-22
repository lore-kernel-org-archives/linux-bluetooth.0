Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2383C210EC
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 May 2024 18:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716403450; cv=none; b=qRPxOEZ6TRxlOYG/5v2EePi8szxIUEH9o6ifgkRqi6tXsT3tacs6JmKeDrVjoZsSE6QVvz9KpbDAc4YpVTZk8bfIiP4XLm+FS3N08ezsJVtJBfR0KmG9Z5tHUQTeC4AVtArAk72lAiJ28DUCir7pva+aImN+1pNActTdGyUanvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716403450; c=relaxed/simple;
	bh=Ji2hNR62HJExgnXzCsmRMWLeJvT4xObu7J7qdDKWxZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WNVu55YzQcjgnu0VkwXU5FCqtsG7pSmoEBKQDgCXdVOGrxjUhOySvUU6wqZsiQSnwOIh/zxHmq4Z42PrUZiVlEGI9AxZi5vqXO3EjB34fSEbrLyYcuXt8wAvY87QMQfZGZ8yVkoDJPQ8nmXtm/OZrSUfd8xOOAr0zDtvL7hEJ7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dyFEzqwE; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyFEzqwE"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2e719bab882so51154441fa.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 May 2024 11:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716403447; x=1717008247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0R/H2ZxRgcTDKjoml22C7/U25tmAJzn0uDdpWw2qbq4=;
        b=dyFEzqwEh5rKvz5K620bs6JoPPs+yTzHr5E8rHWa0y0j0MgWFdZwSmI8wj2SaXD2vX
         YnLp2xnqR/5NyscDA8LxbnVYfXG7i1qbOJxQwfmwtSTMHXVS2He96kLtO3I0VuBv8pwK
         qAhPGkHGRPR3h1+Z38JKgh20xa9YmoX7oO9kMOsPKU3Ddy2cLnKB2MpCdUVgSyT+31Cu
         Du7kHBah4iw5KyoWD6o3oMQ9AE28MX8d/cmJnbcLGxMxloyh/BVOc9nihDIeycMvIq6B
         5M7bTOuzgSDaONyJFGIIyXtcwC99yopnX2hfr9Usl6/OtP6yiOvb5Xv5+1/Qk2Xcc5Ee
         2T3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716403447; x=1717008247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0R/H2ZxRgcTDKjoml22C7/U25tmAJzn0uDdpWw2qbq4=;
        b=Q2m8P6uqNFfCMW7SRVJY0UBFYDySmeXGW4r28wpQEKgQjQybuoGkrNxy1Tm0oHQsgQ
         jkBhMdnPTzU76Z9sDBXFdDFWQCX2n6SZJ5sXlavEGrleIurtzyVRxyvB5OcCo5NlTdVF
         qJin7DQfJ97C8CiCYjUCxXhkbo51Z7ymF1NygWECM8kh8z4HVi9EwLKnEWlIFqwdCUA2
         TZXqpWFhHqHHtHeM6Xwkwz9Vz9m4O6DvesEkuCPnF54NmB5+d/eVgSLKQP4uIJJo09AW
         V00TXnf5CHSeiV8pS77byoTvoaqz7FSmX+VWkdWsEpG1QAGU8aN+PZeTolQfW/cwPOJG
         gOVA==
X-Gm-Message-State: AOJu0YyVcGmvu+QHEwa585sSQFv4M7zNkkjCZGrVBWr/AXMfTweopgve
	sirGWG64s80NWRQg8GQywmRjeezrdCWnmQSzttpwC/DZdof3WgR8Gh7dOj40ujwSi82sRzp0wlE
	pSbA1Kd/IIGc8EZRxVAEAphgARsruGw==
X-Google-Smtp-Source: AGHT+IGl3KQ+NdDcgxeD+6m0e3AqB4gIiwbsDwEGuTJ6wRV6jseldJYhRIYT2bp4R0XGC3azM05qW+PfDwEEH4M3dGE=
X-Received: by 2002:a2e:9c07:0:b0:2e5:15d0:511c with SMTP id
 38308e7fff4ca-2e94969e177mr17656601fa.40.1716403446940; Wed, 22 May 2024
 11:44:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522064504.7560-1-quic_nakella@quicinc.com>
In-Reply-To: <20240522064504.7560-1-quic_nakella@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 22 May 2024 14:43:54 -0400
Message-ID: <CABBYNZLX0PGEVEFhtWGiLdCN4gJTyg+mqSmRiq2y0sT--skjPQ@mail.gmail.com>
Subject: Re: [PATCH v3] Adding Sepolicy rules to allow bluetoothctl and
 dbus-daemon to access unix stream sockets.
To: Naga Bhavani Akella <quic_nakella@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Naga,

On Wed, May 22, 2024 at 2:46=E2=80=AFAM Naga Bhavani Akella
<quic_nakella@quicinc.com> wrote:
>
> Required for using acquire-notify, acquire-write options (Gatt Client)
> and Sending notifications (Gatt Server)
>
> Below are the avc denials that are fixed with this patch -
>
> 1. audit: type=3D1400 audit(1651238006.276:496):
> avc:  denied  { read write } for  pid=3D2165 comm=3D"bluetoothd"
> path=3D"socket:[43207]" dev=3D"sockfs" ino=3D43207
> scontext=3Dsystem_u:system_r:bluetooth_t:s0-s15:c0.c1023
> tcontext=3Dsystem_u:system_r:initrc_t:s0-s15:c0.c1023
> tclass=3Dunix_stream_socket permissive=3D1
> 2. audit: type=3D1400 audit(1651238006.276:497):
> avc:  denied  { getattr } for  pid=3D2165 comm=3D"bluetoothd"
> path=3D"socket:[43207]" dev=3D"sockfs" ino=3D43207
> scontext=3Dsystem_u:system_r:bluetooth_t:s0-s15:c0.c1023
> tcontext=3Dsystem_u:system_r:initrc_t:s0-s15:c0.c1023
> tclass=3Dunix_stream_socket permissive=3D1
> 3. audit: type=3D1400 audit(1651238006.272:495):
> avc:  denied  { read write } for  pid=3D689 comm=3D"dbus-daemon"
> path=3D"socket:[43207]" dev=3D"sockfs" ino=3D43207
> scontext=3Dsystem_u:system_r:system_dbusd_t:s0-s15:c0.c1023
> tcontext=3Dsystem_u:system_r:initrc_t:s0-s15:c0.c1023
> tclass=3Dunix_stream_socket permissive=3D1
> 4. audit: type=3D1400 audit(315966559.395:444):
> avc:  denied  { use } for  pid=3D710 comm=3D"dbus-daemon"
> path=3D"socket:[13196]" dev=3D"sockfs" ino=3D13196
> scontext=3Dsystem_u:system_r:system_dbusd_t:s0-s15:c0.c1023
> tcontext=3Dsystem_u:system_r:bluetooth_t:s0-s15:c0.c1023
> tclass=3Dfd permissive=3D0
> 5. audit: type=3D1400 audit(315999854.939:523):
> avc:  denied  { read write } for  pid=3D812 comm=3D"dbus-daemon"
> path=3D"socket:[99469]" dev=3D"sockfs" ino=3D99469
> scontext=3Dsystem_u:system_r:system_dbusd_t:s0-s15:c0.c1023
> tcontext=3Dsystem_u:system_r:bluetooth_t:s0-s15:c0.c1023
> tclass=3Dbluetooth_socket permissive=3D1
>
> Signed-off-by: Naga Bhavani Akella <quic_nakella@quicinc.com>
> ---
>  policy/modules/apps/pulseaudio.te    |  2 +-
>  policy/modules/services/bluetooth.if | 23 +++++++++++++++++++++++
>  policy/modules/services/dbus.te      |  2 +-
>  policy/modules/services/obex.te      |  2 +-
>  4 files changed, 26 insertions(+), 3 deletions(-)

Where is this coming from? I don't think we even have a policy folder,
and this might be an are where the distros want to have their own
policies so I'm not sure if we shall have this upstream, or perhaps
this is just for reference?

> diff --git a/policy/modules/apps/pulseaudio.te b/policy/modules/apps/puls=
eaudio.te
> index 65b9a7428..42ed3a1d2 100644
> --- a/policy/modules/apps/pulseaudio.te
> +++ b/policy/modules/apps/pulseaudio.te
> @@ -193,7 +193,7 @@ optional_policy(`
>  ')
>
>  optional_policy(`
> -       bluetooth_stream_connect(pulseaudio_t)
> +       bluetooth_use(pulseaudio_t)
>  ')
>
>  optional_policy(`
> diff --git a/policy/modules/services/bluetooth.if b/policy/modules/servic=
es/bluetooth.if
> index c7e1c3f14..edead1fa1 100644
> --- a/policy/modules/services/bluetooth.if
> +++ b/policy/modules/services/bluetooth.if
> @@ -85,6 +85,29 @@ interface(`bluetooth_stream_connect',`
>         stream_connect_pattern($1, bluetooth_runtime_t, bluetooth_runtime=
_t, bluetooth_t)
>  ')
>
> +#####################################
> +## <summary>
> +##     Connect to bluetooth over a unix domain
> +##     stream socket.
> +## </summary>
> +## <param name=3D"domain">
> +##     <summary>
> +##     Domain allowed access.
> +##     </summary>
> +## </param>
> +#
> +interface(`bluetooth_use',`
> +       gen_require(`
> +               type bluetooth_t, bluetooth_runtime_t;
> +       ')
> +
> +       files_search_runtime($1)
> +       allow $1 bluetooth_t:bluetooth_socket rw_socket_perms;
> +       allow $1 bluetooth_t:unix_stream_socket { connectto rw_socket_per=
ms };
> +       allow $1 bluetooth_t:fd use;
> +       bluetooth_stream_connect($1);
> +')
> +
>  ########################################
>  ## <summary>
>  ##     Execute bluetooth in the bluetooth domain.
> diff --git a/policy/modules/services/dbus.te b/policy/modules/services/db=
us.te
> index 2d1d09d71..855ce86bd 100644
> --- a/policy/modules/services/dbus.te
> +++ b/policy/modules/services/dbus.te
> @@ -265,7 +265,7 @@ optional_policy(`
>  ')
>
>  optional_policy(`
> -       bluetooth_stream_connect(system_dbusd_t)
> +       bluetooth_use(system_dbusd_t)
>  ')
>
>  optional_policy(`
> diff --git a/policy/modules/services/obex.te b/policy/modules/services/ob=
ex.te
> index 6686edb37..5e2f20578 100644
> --- a/policy/modules/services/obex.te
> +++ b/policy/modules/services/obex.te
> @@ -31,7 +31,7 @@ miscfiles_read_localization(obex_t)
>  userdom_search_user_home_content(obex_t)
>
>  optional_policy(`
> -       bluetooth_stream_connect(obex_t)
> +       bluetooth_use(obex_t)
>  ')
>
>  optional_policy(`
> --
>


--=20
Luiz Augusto von Dentz
