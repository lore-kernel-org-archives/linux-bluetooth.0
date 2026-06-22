Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7E63B2FF6
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 13:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782136521; cv=pass; b=aeBeNLIHJADkz6JUXwK8Vqo+/FTXgKPiASti55kkuhfGiKx3EmD3Scr4cF1LIFGyUeVhW0u8qDwRpYKtVHfiWSFEGedz44xvX9c70wbdhWmPCW8gWru3JaMG8Cvmfex05M0UO4HIugW04ix6iCXvhGarHzJKaY/ELWMZUBu8R2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782136521; c=relaxed/simple;
	bh=spCSafN16Q3nAV0EKzYqUajKGKlUklgsDgQrTxz1smo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=umAoErmrleb7/rnd5is5yyLS4DOBAchTAweL5HiRbMf0Zu3gYcKl6MHe2aowZq+Sz9d7DVECd+7ev+IxxlcgoMi6qI2cPXGRG2uxIsXQwibkkt5lJPuBXx0N4AzvNI0jiYRcu484VI1wvTRwZSau2jiFoMKm1UkR8g/s7hNHbGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFLW/bQB; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFLW/bQB"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6611689dc10so5156128d50.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 06:55:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782136520; cv=none;
        d=google.com; s=arc-20240605;
        b=UkW7VKtZ2AtDAJoMA20FgUALuKq/bATqZqN/EyCsnqumYIw87+BSr2c5OqDWU0fZ8K
         +xxeGRVUyKHiNyqzRbYbaeoU3c7ZviJOy/x1Bia0SyBHq56M6QlW64njkgvaXPtxU9FB
         qxjbBWuRQMcAQiF71d4AB+B21cKP7Qz1nUzzLS/O6nTuxnrecRqNcZMIgAtZMZGCVUxx
         pt9Ym4mpEcJ5A5qNHskmrEw+IT0MtqwW9EgQuC1TQNegPVj5phjBfV+zOxhLIfPhsO34
         yxPA8E9dwZkHZ/vhgCsG2oSUvwjVPU9WBkrJdr0higEdJnXJMu59ej8ibGruHmHW+/xH
         vnWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dke5TrNkGe9UBkjytTbWSHukFz3N4mY88uBqHNTvmmk=;
        fh=A/Q/jNPcPJyWlB/0KiTqrmPoa5p+gzL1PJrZG/U2mxs=;
        b=S8HOkz8j9qSL9AfFljzuWUbRhYMa/IGUhlZokiGxYaCZfCI6dR/W+sd+iNYMg7mKon
         o0kTqCedVYQtov/FWrUQYXmCtdTHIPNilPOwqw2hTbVaqv4mOKhrwAhTYIkTb0LI/Lpd
         FN/mN5oSAhH45f3GPNpJwN88otIvrP+avV+imtGXx9MbuPRPl6VcC7cpKuYJfUX8XRVI
         kiV0aghRqufD5wS614lAqBivXaxInLf1t3gQ/VgDe+2D9DiyIbxM5Lu75DIJT1H1hBZo
         kN2rzK/Cv6KFwbFW4Ki1XeUCRMgvEbvMeD0QD/H26njBcunSCqfGa8ufwqxosXtLlMXT
         cbew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782136520; x=1782741320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dke5TrNkGe9UBkjytTbWSHukFz3N4mY88uBqHNTvmmk=;
        b=ZFLW/bQBhtJJcawUpZcjFdcxMqhoPcO3QRrW1+LCvfj7mL6YyowoQuhox2B9Q/riHY
         eq8dc/hwZGc1Oh24JtmZzCLIWvatvQPJ3DaQR7BckGX1jTbdDmNdL+iOd5TaydMpvHV9
         e4MbRyYU/rXZatPgXdpc/RNVkzJPK3xz+K88/7ZPlhxHyf1JA6z74yfZ1oTuGvOGdkco
         +r5kzi2wDaARixeG+NeHEXOFgSlFUR7RNNHPy661YWYU+xaOAv13oUmwYgQVYQYwIsC1
         ZlBoawIG36tE2l+8m28G2A2VfgNNm/8XAFYQ3ovrTbBDFlI6m0rjFssBOMwXsrxnVSu9
         4Iiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782136520; x=1782741320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dke5TrNkGe9UBkjytTbWSHukFz3N4mY88uBqHNTvmmk=;
        b=HkBgnaSrzpt9mIUmdtmBt6ZreoeoXNpOOrydRZQcOS2hWx5MZuhNmJlK8BQ+sg9+lS
         uUA805th5HWpPOFkCExClsHkzNjuIu8f5NatgX57HVqIeBnNuxJzuoSf75EnXDxPJh2G
         v9ajwbHlDd4bcD9Xmc/CyXvO8uOq8230ueikhsEUtSsospN1m73HALO7mdIZjEuoCQc4
         Fst+oYKJXbilkjN0LJVOstzvdk+JDo2j1BbxDAzkmXYSdDFzxPSoRHI+hHRWsgm+6P3Q
         aidsnPTAlSRFFQPdhkHR4ct1hE0Mh4eCX9WfutmjkncBZFqZFZdvzkCr7JCQNL3EhYsn
         pKPA==
X-Gm-Message-State: AOJu0YzcF6Mp8Y22hxRgK1YnVRHCWoZ2++XeQCzlld7kB8OPa+ZuB55w
	sl9l+WoBKrLV8eRmZm04YpvwDuFeincm7wk4BUXiiIQ9CXU7v61kjNWb2S4nZ8b9Mr/8HnLgmUJ
	u7Xem+l6Z+1taJ+ts0jGqQ9c9VgN23bYZ8PHgH9E=
X-Gm-Gg: AfdE7cmSxxyK1GiOHAHwjsQcMnUt/tRGI/6sBtwp8w//UykUqSfD3fqODCh6lyZsydB
	4E+NvO8cRSDpIS947NL4h30PKLccEGusJsEuZGQFQdKviRBdqhvunoM3qBEgOIDVareD8ZCsNpe
	4t9LV0W7LiuR7FWjJ/BjxBJQmagX/Sec93R7HcuxuUsYtk4V+q5l+oWQYLf4dK1gXW2o+NKRSE9
	VitUVcJ3BrvVhOU9dQagrEwgQW6scblv12oPyX7Cv/53evGVfRsKINhOL75AzVLV/70LHNgA2Tt
	xrlcWWBEVljuGiudZ4oAiSkjr9msOdMJWloIj8PYAJ7IQgtrmoyNNj48/Xc=
X-Received: by 2002:a05:690e:e85:b0:660:ffe0:2df1 with SMTP id
 956f58d0204a3-6630335ace3mr12058708d50.42.1782136519508; Mon, 22 Jun 2026
 06:55:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260620191735.2675946-1-geraldonetto@gmail.com> <20260620191735.2675946-3-geraldonetto@gmail.com>
In-Reply-To: <20260620191735.2675946-3-geraldonetto@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 22 Jun 2026 09:55:08 -0400
X-Gm-Features: AVVi8CcApMI_V9hzN9euzLV2zgBTqx8HxI0Km9Ptso9_T5vz3wf-NOjD_0eUnEw
Message-ID: <CABBYNZL7g7A8jVAUKqrr4KTGOfwjfR=pN7FetD=9erog2w4X4Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] audio: reduce a2dp parser complexity
To: Geraldo Netto <geraldonetto@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geraldo,

On Sat, Jun 20, 2026 at 3:18=E2=80=AFPM Geraldo Netto <geraldonetto@gmail.c=
om> wrote:
>
> ---
>  profiles/audio/a2dp-helpers.c | 55 +++++++++++++++++++++++++++--------
>  1 file changed, 43 insertions(+), 12 deletions(-)
>
> diff --git a/profiles/audio/a2dp-helpers.c b/profiles/audio/a2dp-helpers.=
c
> index 035236df6..09dc6db91 100644
> --- a/profiles/audio/a2dp-helpers.c
> +++ b/profiles/audio/a2dp-helpers.c
> @@ -74,6 +74,46 @@ static bool parse_caps(const char *value, uint8_t *cap=
s, size_t caps_len,
>         return true;
>  }
>
> +static bool has_delay_field(const char *value)
> +{
> +       return value[0] !=3D '\0' && value[1] !=3D '\0' &&
> +                       g_ascii_isxdigit(value[0]) &&
> +                       g_ascii_isxdigit(value[1]) &&
> +                       value[2] =3D=3D ':';
> +}
> +
> +static bool parse_endpoint_header(const char **value, uint8_t *type,
> +                                                       uint8_t *codec)
> +{
> +       if (!parse_hex_byte(value, type) || !parse_colon(value))
> +               return false;
> +
> +       if (!parse_hex_byte(value, codec) || !parse_colon(value))
> +               return false;
> +
> +       return true;
> +}
> +
> +static bool parse_delay_field(const char **value, uint8_t *delay)
> +{
> +       *delay =3D 0;
> +
> +       if (!has_delay_field(*value))
> +               return true;
> +
> +       parse_hex_byte(value, delay);
> +       parse_colon(value);
> +
> +       return *delay <=3D 1;
> +}
> +
> +static bool valid_endpoint_args(const char *value,
> +                               const uint8_t *type, const uint8_t *codec=
,
> +                               const bool *delay_reporting, const size_t=
 *size)
> +{
> +       return value && type && codec && delay_reporting && size;
> +}
> +
>  bool a2dp_parse_capabilities_array(DBusMessageIter *value,
>                                         uint8_t **caps, int *size)
>  {
> @@ -106,27 +146,18 @@ bool a2dp_parse_persisted_endpoint(const char *valu=
e, uint8_t *type,
>         const char *pos;
>         uint8_t delay =3D 0;
>
> -       if (!value || !type || !codec || !delay_reporting || !size)
> +       if (!valid_endpoint_args(value, type, codec, delay_reporting, siz=
e))
>                 return false;
>
>         *size =3D 0;
>
>         pos =3D value;
> -       if (!parse_hex_byte(&pos, type) || !parse_colon(&pos))
> +       if (!parse_endpoint_header(&pos, type, codec))
>                 return false;
>
> -       if (!parse_hex_byte(&pos, codec) || !parse_colon(&pos))
> +       if (!parse_delay_field(&pos, &delay))
>                 return false;
>
> -       if (pos[0] !=3D '\0' && pos[1] !=3D '\0' &&
> -                       g_ascii_isxdigit(pos[0]) && g_ascii_isxdigit(pos[=
1]) &&
> -                       pos[2] =3D=3D ':') {
> -               parse_hex_byte(&pos, &delay);
> -               parse_colon(&pos);
> -               if (delay > 1)
> -                       return false;
> -       }

I'm not really sure this is any better to be honest. It sounds like
comments explaining the parsing logic are needed, but otherwise, I
can't quite follow the changes you are proposing with this.

>         if (!parse_caps(pos, caps, caps_len, size))
>                 return false;
>
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
