Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1787D1DDA20
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 14:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730125152; cv=none; b=iueal4JlZ/ZRxdLvFi53Kfr2KXmL0O0uwhEMI7jbsFo0UxgECpwd011U1jjcdQDVY2ZU/8UKOt8I3Tlt+q8HS4ur65bf44rmNcvnoEuYfORXHUWdsvBNt/nMYK0LiySNgGXMfYj5SnJlJNo0UHEZXbXSK2u0jVh7MY1vpyKS2TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730125152; c=relaxed/simple;
	bh=a51ZI5X0y9OUr7As7GW72ES1NC+BadVLjoT4NrYa2UE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kbtooF6JLHrz1H3xM/WXvSkj1m24Hk7ibmsvh8IiU4HNiT+mzrvGtOgXwYN/RjI3ZHNgySDXb1ONy3Ge1g4IBxYEGE0C6ByuaINS8R0jewPUTSyrU04h4EWjqnYmPL6x8ErnazmuXEvDYKTsEKEWpAEJ1oZzpF74rvx3P8IXyKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YdupUiy0; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdupUiy0"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb51f39394so42458941fa.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 07:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730125148; x=1730729948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8xwU3CCsjWE5RI8Tgzg4/h6OIaI7RSAUf4s7U6enRw=;
        b=YdupUiy0MrlLXssDXH94v10UDPBTyw6oWsXXfOt55CWWHN5mRPK9Ami2CXH5cc9lMG
         +SyxKY2NrCw2WgvtnB9leDI8rAzGx2zPTvPcMzz2BkgzvUeXfvUzD1TPrOkMgDt3/3UT
         xJrUJpd2LYVvAdFRRVRFePFswxhMrxsI6lPCticVOzFsUw8jkfUKyzaxS17XbWdH4wCE
         G4QLgdch71qBK5MCM+8VzwaLW9gGmZc5WQozozqDypktJFam7apZ/1TD/ucdNUzclXVi
         mlF/iM9sNd3zhHCgiVeoejQlvLwQIlVDyWXYsKe6/971876mz+9zPcaJFJRDtqoQ5iZi
         RFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730125148; x=1730729948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u8xwU3CCsjWE5RI8Tgzg4/h6OIaI7RSAUf4s7U6enRw=;
        b=nhxr2kYoUcEEK5NQ473s5z1Q2EGDbhLmYByFlW2cQBjozxB9wbyUGei/7NPL5kTEPa
         hQv0GBVliXJzCajhEVnvrBRa60tKVagYoAqit6jyjPKL84tvQt+oldZrlr3x2IdUEyFE
         WTlvzaKazIEay4XJxB7TXBBJtcwcCM6QueLEum7DZcBqwu1o1lLVgWlG4tD5CyMqlRen
         5dhcpdcGvK2biaGF6bWUxHD+XX5a2wGbx3iWnLgcQKTQt2m46Hej9iyw6wTPe8cmKnNi
         x4pWnTHP08gyusvEb5TDBzbmlrvmrFuEuCcCX+yUvqKKHJwncUfMOy7z4JPzveSV5mF9
         xuEw==
X-Gm-Message-State: AOJu0Ywb+4UOAjyq64Opj1egIzPP7I3P01xZhcFUSCEQKESYAp2zAxsP
	WK9X0qWPpDwu+tFewGLQv/CbMgaz6SyX4uVMpi4qTqZ741VJ8yAD7sv10gV0SC/atpJA4UKUqUT
	F3awnMQEOPU5ikU2BSJs1qlkMx2k6Jw==
X-Google-Smtp-Source: AGHT+IHNc8Rd4HY4hQ3ZMmq4laYUx667UFRzaeT0H2IEZyI58IVx30wBCWsCDQkDkm/b0yYgeUkRfX82FDoAKl3O1+c=
X-Received: by 2002:a05:651c:2209:b0:2ef:17f7:6e1d with SMTP id
 38308e7fff4ca-2fcbdf689acmr33512831fa.4.1730125147851; Mon, 28 Oct 2024
 07:19:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026191434.556716-1-arkadiusz.bokowy@gmail.com>
In-Reply-To: <20241026191434.556716-1-arkadiusz.bokowy@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 28 Oct 2024 10:18:55 -0400
Message-ID: <CABBYNZKs5JNZJV17gZ_Nrbj_f-NbFJVfrBy5tuWcKk1yq58uMg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] transport: Expose DelayReporting on
 MediaTransport interface
To: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arkadiusz,

On Sat, Oct 26, 2024 at 3:15=E2=80=AFPM Arkadiusz Bokowy
<arkadiusz.bokowy@gmail.com> wrote:
>
> Exposing DelayReporting property on the MediaTransport interface will
> allow media application to get the information about the delay reporting
> feature during the SetConfiguration call in a similar way the profile
> UUID and transport codec are provided. Otherwise, the application would
> need to check the associated endpoint which might not be convenient.
> ---
>  doc/org.bluez.MediaTransport.rst | 10 ++++++++--
>  profiles/audio/transport.c       | 30 ++++++++++++++++++++++++++++--
>  2 files changed, 36 insertions(+), 4 deletions(-)
>
> diff --git a/doc/org.bluez.MediaTransport.rst b/doc/org.bluez.MediaTransp=
ort.rst
> index 4838d69d0..5da13b3b5 100644
> --- a/doc/org.bluez.MediaTransport.rst
> +++ b/doc/org.bluez.MediaTransport.rst
> @@ -115,11 +115,17 @@ string State [readonly]
>                 created by a broadcast sink
>         :"active": streaming and acquired
>
> +boolean DelayReporting [readonly]
> +
> +       Indicates if the endpoint associated with the transport supports =
Delay
> +       Reporting.

The presence of Delay indicates delay reporting is supported, so no
need to add another property for it.

>  uint16 Delay [readwrite, optional]
>  ``````````````````````````````````
>
> -       Transport delay in 1/10 of millisecond, this property is only wri=
teable
> -       when the transport was acquired by the sender.
> +       Transport delay in 1/10 of millisecond.
> +       This property is available only if the DelayReporting is true and=
 is
> +       writeable only when the transport was acquired by the sender.

Again no need to add another property just to indicate its support
since its presence shall already indicate that.

>  uint16 Volume [readwrite, optional]
>  ```````````````````````````````````
> diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
> index 0f7909a94..dd6878427 100644
> --- a/profiles/audio/transport.c
> +++ b/profiles/audio/transport.c
> @@ -860,6 +860,22 @@ static gboolean get_state(const GDBusPropertyTable *=
property,
>         return TRUE;
>  }
>
> +static gboolean get_delay_reporting(const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *data=
)
> +{
> +       struct media_transport *transport =3D data;
> +       struct avdtp_stream *stream;
> +
> +       stream =3D media_transport_get_stream(transport);
> +       if (stream =3D=3D NULL)
> +               return FALSE;
> +
> +       gboolean value =3D avdtp_stream_has_delay_reporting(stream);
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &value);
> +
> +       return TRUE;
> +}
> +
>  static gboolean delay_reporting_exists(const GDBusPropertyTable *propert=
y,
>                                                         void *data)
>  {
> @@ -873,7 +889,7 @@ static gboolean delay_reporting_exists(const GDBusPro=
pertyTable *property,
>         return avdtp_stream_has_delay_reporting(stream);
>  }
>
> -static gboolean get_delay_reporting(const GDBusPropertyTable *property,
> +static gboolean get_delay_report(const GDBusPropertyTable *property,
>                                         DBusMessageIter *iter, void *data=
)
>  {
>         struct media_transport *transport =3D data;
> @@ -1019,7 +1035,8 @@ static const GDBusPropertyTable transport_a2dp_prop=
erties[] =3D {
>         { "Codec", "y", get_codec },
>         { "Configuration", "ay", get_configuration },
>         { "State", "s", get_state },
> -       { "Delay", "q", get_delay_reporting, NULL, delay_reporting_exists=
 },
> +       { "DelayReporting", "b", get_delay_reporting },
> +       { "Delay", "q", get_delay_report, NULL, delay_reporting_exists },
>         { "Volume", "q", get_volume, set_volume, volume_exists },
>         { "Endpoint", "o", get_endpoint, NULL, endpoint_exists,
>                                 G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
> @@ -1359,6 +1376,14 @@ static const GDBusPropertyTable transport_bap_bc_p=
roperties[] =3D {
>         { }
>  };
>
> +static gboolean get_asha_delay_reporting(const GDBusPropertyTable *prope=
rty,
> +                                       DBusMessageIter *iter, void *data=
)
> +{
> +       gboolean value =3D TRUE;
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &value);
> +       return TRUE;
> +}
> +
>  static gboolean get_asha_delay(const GDBusPropertyTable *property,
>                                         DBusMessageIter *iter, void *data=
)
>  {
> @@ -1380,6 +1405,7 @@ static const GDBusPropertyTable transport_asha_prop=
erties[] =3D {
>         { "UUID", "s", get_uuid },
>         { "Codec", "y", get_codec },
>         { "State", "s", get_state },
> +       { "DelayReporting", "b", get_asha_delay_reporting },
>         { "Delay", "q", get_asha_delay },
>         { "Volume", "q", get_volume, set_volume, volume_exists },
>         { }
> --
> 2.39.5
>
>


--=20
Luiz Augusto von Dentz
