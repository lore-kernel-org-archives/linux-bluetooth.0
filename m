Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2622DC78C
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 12:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782217103; cv=none; b=oaPyl7Jr3lAM7Jg3rrcrfYVFRiQQJVou/3tVdA6woffxdl/eVMtPGTuV1tQoBLdvT4S2fjcN+FZA54TpGcWR7jOHKDp9scgqzY+/g4M2MeA2TacYmiH/+vYPyOnHGs1Y8ltw6uYC9qWQQCFqVF7JypShUgOP+OkwgUgttWf/EEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782217103; c=relaxed/simple;
	bh=vSuJqpw4IC/b/ofyF9h9S/KSLeQfHeulVBlBDiaKXdc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BkuGBrI6Ugo9neKJOEWNlBl7Di8EQeZQAqQyhnwQL8VUbU6NRtYh6VAp+VlPy9Hb/UJz55zOnFnF+YPeuXBRPoW2b6ArLHTADhl0rjZMqUgg3e9p2YWkWjoEiivfKEpvf2LcDjPg3GVU0MVVXyOsYGkNcD078GO+kz3eEkEuHC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0E5981F75D;
	Tue, 23 Jun 2026 12:18:19 +0000 (UTC)
Message-ID: <95343429b8f06e1c88e2c642471f6f8495e11280.camel@hadess.net>
Subject: Re: [PATCH BlueZ v2] a2dp: Fix handling of codec capability storage
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Date: Tue, 23 Jun 2026 14:18:19 +0200
In-Reply-To: <20260622155621.675255-1-luiz.dentz@gmail.com>
References: <20260622155621.675255-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTGinoaFGGeh9rrdR3gXqHx+yQjJq0OR7qQQJDNVRqAc6aK4us36z/gOpFqRDZQXwK7dp+ot4dpqQZYxlKKNQAYOPYkk1yeILyl6tIVxkEjRXV+u9aIvIKN8HcB5k5qzo2EkxsVm0Yr1aQVLa26gexU5n/XeZm07a1LWFMGv0hyz7/TcxIrKrLcSPb+PR7gkDMvvhG9MkYIVZTwfhprFi+vq12xN7CtqotPoui/jJ9fGHzfjnAFOLxfxqbvSkZQVCYGcfeysDa2B9LyqNTdTJR6j+HW7Afdii611v1mv/XKl7jxovW4KwfoH6uYWbE2meQfQY+eW6ruHXA9EQJ51IUlpBwjO1ia37TiyzgeP25IWt5ns+3ATpiO5OoBSuwF+i0WAOYVWM3eLKnFNpD5Hcczm8OoFR41dPHa/ffourOpZvI6ouh8qdiUIDKcYm8PHupBXP58IFBO4Yb4t5nQA66z9+yKz/xv4I234YdH7+ym8pLvmLL93W9JCUV6Hq6Zxqw8huq/UJ8RK4yXmElavK6a1MZwYssB0rprYV9kdUm/ZKJK4rHlb1uiO6uj0ICXxfAFmSQ20GOZpe3KA19Dhkl+9dkM91iU/m9HkQzTB/guH+eMGCLWRtzkZxrPY2AeiXoyJTHwJk7J2hdlOwvSwU5XlG+SQ3EwReuomRy8ktOUtXw

On Mon, 2026-06-22 at 11:56 -0400, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>=20
> Codec capability is one byte long (max 255) the storage format is
> 02hhx which means each byte ends up as 2 characters so the buffer
> needs to be doubled in order to handle capabilities of that size.
>=20
> Reported-by:=C2=A0 p0her (_@p0her_) in TeamH4C working with TrendAI Zero
> Day Initiative
> Reported-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> =C2=A0profiles/audio/a2dp.c | 10 +++++-----
> =C2=A01 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> index a5e002784c02..c8adc3122563 100644
> --- a/profiles/audio/a2dp.c
> +++ b/profiles/audio/a2dp.c
> @@ -971,7 +971,7 @@ static void store_remote_sep(void *data, void
> *user_data)
> =C2=A0{
> =C2=A0	struct a2dp_remote_sep *sep =3D data;
> =C2=A0	GKeyFile *key_file =3D user_data;
> -	char seid[4], value[256];
> +	char seid[4], value[9 + 512];

What's the "9" value from? Shouldn't it be 11 for the length of:
"%02hhx:%02hhx:%02hhx:"
The "Try loading with delay_reporting first" variant?

> =C2=A0	struct avdtp_service_capability *service =3D
> avdtp_get_codec(sep->sep);
> =C2=A0	struct avdtp_media_codec_capability *codec;
> =C2=A0	unsigned int i;
> @@ -2373,7 +2373,7 @@ static void load_remote_sep(struct a2dp_channel
> *chan, GKeyFile *key_file,
> =C2=A0		uint8_t codec;
> =C2=A0		uint8_t delay_reporting;
> =C2=A0		GSList *l =3D NULL;
> -		char caps[256];
> +		char caps[513];
> =C2=A0		uint8_t data[128];
> =C2=A0		int i, size;
> =C2=A0
> @@ -2386,10 +2386,10 @@ static void load_remote_sep(struct
> a2dp_channel *chan, GKeyFile *key_file,
> =C2=A0			continue;
> =C2=A0
> =C2=A0		/* Try loading with delay_reporting first */
> -		if (sscanf(value, "%02hhx:%02hhx:%02hhx:%s", &type,
> &codec,
> +		if (sscanf(value, "%02hhx:%02hhx:%02hhx:%512s",
> &type, &codec,
> =C2=A0					&delay_reporting, caps) !=3D
> 4) {
> =C2=A0			/* Try old format */
> -			if (sscanf(value, "%02hhx:%02hhx:%s", &type,
> &codec,
> +			if (sscanf(value, "%02hhx:%02hhx:%512s",
> &type, &codec,
> =C2=A0								caps
> ) !=3D 3) {
> =C2=A0				warn("Unable to load Endpoint: seid
> %u", rseid);
> =C2=A0				g_free(value);
> @@ -2398,7 +2398,7 @@ static void load_remote_sep(struct a2dp_channel
> *chan, GKeyFile *key_file,
> =C2=A0			delay_reporting =3D false;
> =C2=A0		}
> =C2=A0
> -		for (i =3D 0, size =3D strlen(caps); i < size; i +=3D 2) {
> +		for (i =3D 0, size =3D strlen(caps); i < size && i >=3D 2;
> i +=3D 2) {
> =C2=A0			uint8_t *tmp =3D data + i / 2;
> =C2=A0
> =C2=A0			if (sscanf(caps + i, "%02hhx", tmp) !=3D 1) {
