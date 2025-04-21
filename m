Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44268139D0A
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 14:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745246293; cv=none; b=HdBe3DTC9NHnatnr7S8TTyZ6Wy7SpWH0hROh7fuoPik/jewuZmgOfAyZ7zJlFpJoI2l7YfXnPwRx5PufHF91NtT5mJRkSIofKorMu5KNSGNkUWvCx0RZtvnhUhnbwxoRjlNJQ/4WaDQcDd7x/zzJxs9PDmgPJJchlcMoI16CGhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745246293; c=relaxed/simple;
	bh=Ta8H1uBZpVXj4CU3PYLW3pNst7aQCsBXi2qClo1CQHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ULl7UdLF6uQwEzA2e+7QvYQ8eWrekBHOwfke3p7xNqYJOtOCN921S/S7VPIBh+kqtq4b0afJ+Vx2Hdphp3RVABn5fzIebA2WX5XQxdWrrLE+3TYWNdPz71khvTFoGfjfPGfBl1GhBcmBVQ34Xp1RW0Fppmxqv+CNFvZ1FFWAUEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHU5pHjx; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHU5pHjx"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30bfb6ab47cso38037371fa.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 07:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745246290; x=1745851090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vPKmHekpSnAsvFJPjoPrV4NCxHRlTsOCAdcHBiGBVgQ=;
        b=KHU5pHjxDsm52m12csyZ1Ejp3h/LoISIKgAunysUrQY77RJzJtNIR4il+34ZgJcUBa
         GaDslDIWoQradT7TFOe4yjO74DL9hfcClYnwysWowwHTsNtMHV3lraW4ZMCmevpSv4R7
         ppyx3CTl12Q4TFsy4A25DNvofML2dcj5iotd3PIbJguU4Ma0B8XgnKbnINb2nHpa7ysB
         2gAv5wDZ7HnGWrQvTyPrGnNICENdjF8GVMMsxCORf1IHvqeKkezSiXtQ6eebWqEouZsD
         ZS13o0r9Ye6wYBzrJPvKTzzi6x6vilxPVwUVZuwOUW3/m0r1nZYNm3APvabExiLLKte7
         GwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745246290; x=1745851090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vPKmHekpSnAsvFJPjoPrV4NCxHRlTsOCAdcHBiGBVgQ=;
        b=MghEOFNuNaRCZ58/kgxKRUR+Ikwrpc7kF2OW/Ky9LpmrePwlwnfLOcWv4x8G6O9deu
         BjINshJf5rRpfZ1/iQV+GN9Pb6AZLYwAmRr30mz06RAr0nMp+MzuR+OhRqXCoBYEFdkH
         Wk4yQR7eFKmHkVNHSlKPaivtpOvCkJxpy88zKNzVKZwbmw+cpvJeDm8kQiftwNM2Oy9r
         R/vn698Fwyf/o3Z32sPe0UDuPTBQPIw0z9lTNSlKXQonZ23wGgjiRubFjcu507EVDXc6
         ev/yT9HPrfkYnDMa6/axrIZBFuStp5Sz1ZjyWmGwi+RRi6nAG+i8NlCyKl3b5srkLTQs
         +VOQ==
X-Gm-Message-State: AOJu0YzaQ7z4dcvrIbLnOhfXNZomQOCQBBLVcuxjb5ZrQps9wFIlI4VL
	P/3MmMLk1xf7VTFd7rqsycaUQqSv7XkbmJbnmML4xwflTWZQ7OVMicTd2lMDodkhEyIMUmw2MuE
	YNlPOsgMFo70y+HgjCtqO+flsLTtsI8yc5pM=
X-Gm-Gg: ASbGncsqD2QzNfJYLUIfVrJi7mORGa6FGuwt/tS1Hr/zSL/6ZAWzO7xfVSZoQXL10w4
	jq9enqsABfo0uBB/Eo3sKYJhZZgPg9cl0Krg/ZAdQC7LQ6DeXzkx5HdWbYug+25mqNUt3/Jsv2L
	vHQQ4agbI1AoYPs+nuCkV9
X-Google-Smtp-Source: AGHT+IHDZDzIQCyfZRgIZ1Rb8LOFFRvCuNWPcRkdQXB3EFw0jNR7l7pr5WLYCvNof2QcUGg7uWzNUWjSF105hP8jIBw=
X-Received: by 2002:a2e:bc88:0:b0:30b:9813:b010 with SMTP id
 38308e7fff4ca-31090554278mr35434321fa.31.1745246289975; Mon, 21 Apr 2025
 07:38:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fb302ed17cf2a4331d7ca57529cdbdde80376d82.1745233468.git.pav@iki.fi>
 <ebc8762f1d7d65b9fb414d2b538985b23546ab57.1745233468.git.pav@iki.fi>
In-Reply-To: <ebc8762f1d7d65b9fb414d2b538985b23546ab57.1745233468.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 21 Apr 2025 10:37:57 -0400
X-Gm-Features: ATxdqUEDFMvQLNiP7hqTFdKexlgGNy5CZNczJfleaL1uBFy6L6DtX7sR9DYXGGA
Message-ID: <CABBYNZ+CVKheEVCPJnpdhTDr+ReOUTZwXyD0O8eAvZuM+GYGiA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] media: implement SupportedFeatures property
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Mon, Apr 21, 2025 at 7:05=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Add org.bluez.Media.SupportedFeatures. The value tx-timestamping is
> hardcoded as it is currently always enabled.
> ---
>  profiles/audio/media.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> index 69c6dc671..df36bc2df 100644
> --- a/profiles/audio/media.c
> +++ b/profiles/audio/media.c
> @@ -3340,8 +3340,28 @@ static gboolean supported_uuids(const GDBusPropert=
yTable *property,
>         return TRUE;
>  }
>
> +static gboolean supported_features(const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *data=
)
> +{
> +       static const char * const features[] =3D { "tx-timestamping" };
> +       DBusMessageIter entry;
> +       size_t i;
> +
> +       dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
> +                               DBUS_TYPE_STRING_AS_STRING, &entry);
> +
> +       for (i =3D 0; i < ARRAY_SIZE(features); ++i)
> +               dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
> +                                                       &features[i]);

That doesn't really handle if the kernel doesn't support it or setting
SO_TIMESTAMPING fails in case the kernel is too old? We might need to
have a MGMT flag indicating that kernel has support for it otherwise,
that said perhaps it would actually be better to have a socket option
since for the likes of SCO sockets we actually need hardware support
as well.

> +       dbus_message_iter_close_container(iter, &entry);
> +
> +       return TRUE;
> +}
> +
>  static const GDBusPropertyTable media_properties[] =3D {
>         { "SupportedUUIDs", "as", supported_uuids },
> +       { "SupportedFeatures", "as", supported_features },
>         { }
>  };
>
> --
> 2.49.0
>
>


--=20
Luiz Augusto von Dentz
