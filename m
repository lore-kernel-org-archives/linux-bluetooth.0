Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F681D90D7
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Mar 2025 18:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742235662; cv=none; b=g3ZDMydJNORr24nFbGEWR4bqhXtOv4JC+b7S/NGNMGbaRln0UwQzZQcb75Z5QNZ6+zyQUOr7ihv0zL58jLImtrM6nhyTrS+iI0ZXiu4XMiSoeLh8+6Fl63ZufGiQGYfaZNS3VV8nBlJUAPdeAHjQhZd97qGlOqAim8E4kPBrXrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742235662; c=relaxed/simple;
	bh=us7rZ6ci6bZXvTd1jEu2ZC8/vYKnUMPV5bc2DI3c1ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mx4yrfoDEp6YVlo63yI6Sf71pms13bsvpKzjOeVordKq1LkrUZSAyppTlcOyH4a1ZZQy0j4wbg3mtJOyMworFiTYtlf3uZz/d430jNV4lmuUxgIIC4kfd0m6NLT3RokYJI7MyT0BZ2Jdn2N925rurjk1h9R/+1aZtF40H5nyckA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CtjuVKVZ; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtjuVKVZ"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30761be8fa8so9856551fa.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Mar 2025 11:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742235659; x=1742840459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBhSv1NKV3w3nOycbQWJ25sVUojq+R6r8mIJ2by2jQM=;
        b=CtjuVKVZ1NtUt/EkjpQ09O/mhk7ZI7tpDxrS2HWGvIxNvspmXOV3tg5MJcGS4qLzIr
         4gVHcbbe4r4AIZ/CxZlOcGV/G3MK5ZTS/wrMysG5FNHKj7llMRXXIcuHr9K6oPOzaEbj
         gIe9EXn3Y3yIeu1qFo2+p38QGJp4wzl5gJ75A9Zem6h7uKwhHlOZFAFm2zLpg2HNqKz+
         yIch+tdUYytXX9BBAaZTgt+s28XnXut3ks0Dtn6TEuRZpTNayyZ6jqnu+oYSTKKcPcFm
         9lu2Q0k/JhiAtLHAVYNwUIbI2F7y9jOnNk+ALv0cnqfSQJYMVYi3OTewSL8uo18feyha
         I65A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742235659; x=1742840459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SBhSv1NKV3w3nOycbQWJ25sVUojq+R6r8mIJ2by2jQM=;
        b=i+CgG3iDbAiY6GFjfHZBVwQgwrQ9ieTlYk8AoyYH3IS+TS1qzBySpzgmoXhddK77aE
         YIvToK0me7RG3al+/wznV9Tce0nQX0+345O50IRPy2kKe0fqvc5/eRxGJsC3E88l47eI
         OFiIL357OiMb7uB2ImnC6TU+D+HR3c9PyQn9hdP0ODZbn5a9i6W7x3AgIKiB+WIWwGkj
         klPiCgkuuOcjL+ksaqb7vGZjlhuSI2mgRt1nSyU01yglgzD0b8DyN8SdiURVTCKjlWeR
         SIMNaMvp+ozf6JX56XE5huA5Kt9XWg0UR/XYSmk9P5BssBY+rZDGUMSMzaIMDMJh3P5i
         QDHQ==
X-Gm-Message-State: AOJu0YwRUIwaE/IogceTwCnkfqv9EO8Do/mc9bVR2no761NCEiAcu0sB
	iQa4lJ2nMWbOLmzcX7aCNJu4hLealbyRGDWdUcGmvhtjirE0ezg4yJOZXiJwtIpWJi74uQzXC+Z
	m6wlXE6EX/1H1sNQoig4ra+s7FfZE386/oyI=
X-Gm-Gg: ASbGncvrejsPeCbuO6wd8sM3VL/4Ng67x27EctCls4RLum1zERZc1e56wZxLGGJ5gNF
	yl9ZHJ78UZ5T5JN2+dpObm+aWjV/6JOON7ij3ckUKT5pR/XFATV6O4QOkKodTKDlmuodDTnjCwB
	9TJJWJWMaZE/a73mHHFOcOv7tI
X-Google-Smtp-Source: AGHT+IHyH0IyGP+VFE6do3U1hlxUvgcQWMna662ZdRtkEjWCUqEGaPJR6V158uKZSWapU10Exmu7Lq5xM3eAZa5DpBg=
X-Received: by 2002:a2e:b8cf:0:b0:30b:d40c:7eb4 with SMTP id
 38308e7fff4ca-30c4a7546b6mr91335631fa.7.1742235658613; Mon, 17 Mar 2025
 11:20:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740844616.git.pav@iki.fi> <e6c11514c61343d0991e5d6952f800076a941cf3.1740844616.git.pav@iki.fi>
In-Reply-To: <e6c11514c61343d0991e5d6952f800076a941cf3.1740844616.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 17 Mar 2025 14:20:46 -0400
X-Gm-Features: AQ5f1JrwSFXmCRzZjZD20AB6LaOJSQls7jUBTbK--WXSCkKQK-5K64AaV0e5Ct4
Message-ID: <CABBYNZJERCGbUu-0iMxiroi9Omc4ui5aurDFEVxQ50ey41g8fg@mail.gmail.com>
Subject: Re: [RFC PATCH BlueZ 2/9] org.bluez.MediaEndpoint: add client role SelectProperties
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Sat, Mar 1, 2025 at 10:58=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Add a simple way for the sound server to reconfigure a BAP unicast
> endpoint, by calling org.bluez.MediaEndpoint.SelectProperties().
>
> This shall destroy all streams of the endpoint, and restart the
> SelectProperties() configuration flow from the beginning.
>
> Since it may be necessary to reconfigure multiple endpoints at once to
> correctly make bidirectional CIS, add Defer argument to just mark eps
> for configuration.
>
> In future, org.bluez.MediaEndpoint.SetConfiguration() could be changed
> to handle unicast in the same way as broadcast: only create streams.
> This allows sound server to have full control over stream configuration
> itself, and not rely on bt_bap_select().

This one Im not too sure, perhaps it would be better to add something
like org.bluez.MediaTransport.Reconfigure to avoid having to add role
dependent documentation like bellow

> ---
>  doc/org.bluez.MediaEndpoint.rst | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/doc/org.bluez.MediaEndpoint.rst b/doc/org.bluez.MediaEndpoin=
t.rst
> index b81106f0b..5c42b878c 100644
> --- a/doc/org.bluez.MediaEndpoint.rst
> +++ b/doc/org.bluez.MediaEndpoint.rst
> @@ -69,6 +69,8 @@ array{byte} SelectConfiguration(array{byte} capabilitie=
s)
>  dict SelectProperties(dict capabilities)
>  ````````````````````````````````````````
>
> +       **Server Role**
> +
>         Select BAP unicast configuration from the supported capabilities:
>
>         :object Endpoint:
> @@ -104,6 +106,25 @@ dict SelectProperties(dict capabilities)
>         Note: There is no need to cache the selected properties since on
>         success the configuration is send back as parameter of SetConfigu=
ration.
>
> +       **Client Role**
> +
> +       Reconfigure a BAP unicast endpoint. This closes all existing
> +       streams of the endpoint, and restarts the configuration
> +       selection flow which e.g. triggers calls to *SelectProperties*
> +       allowing the sound server to modify the configuration.
> +
> +       The following arguments are taken in *capabilities*:
> +
> +       :boolean Defer [optional]:
> +
> +               If True, mark endpoint for reconfiguration, but
> +               postpone it until a non-deferred *SelectProperties()*
> +               operation is made on an endpoint of the same device.
> +
> +               This is necessary to use when reconfiguring source and
> +               sink streams with the intention that they be combined
> +               into the same CIG, possibly forming bidirectional CIS.

We could perhaps adds Defer option to MediaTransport.Reconfigure and
then use MediaTransport.Select to clear it, that said for broadcast we
did set a dedicated state when it is not active so perhaps we should
do something similar here.

>  void ClearConfiguration(object transport)
>  `````````````````````````````````````````
>
> --
> 2.48.1
>
>


--=20
Luiz Augusto von Dentz
