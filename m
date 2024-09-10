Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3D5193085
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Sep 2024 14:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725979731; cv=none; b=ofBn6FZzjbp7Lhwq/ryLSQ2deRc3zlEqZZqmNsPkdcS1dYTF1XVLyVNmz96dsvjdcHlLyECMZNTtisH7xi+Y8ik9pUIKKiw50jCKxWJLWM2htoaEiSJmeN58bCFXPzjUCmRcpj9qRblAxOUPzB9K+Dp+KaINuCsliwf5Ip2eOaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725979731; c=relaxed/simple;
	bh=ooum7AcbZVYBsvwKtoF9XWsa0IXr4BWSv+W5fNj0h1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a9nE3sB3x/8ZQoFVJBChuFZ31lMCtzMrdYvnVpQZcgGVQ19Rpw2m/lc6EY898VwIgerCDyb0XKTfa+GeZZvYHemwnJS0KVNWcvFxrz1abXnLX5w2bWWsjEFn4zxu6TAhq4rgFs0VM84xeVVlhhfMYuLz8BEu+RKfT2u5FzxZ744=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ly2dePmf; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ly2dePmf"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f75428b9f8so2567331fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Sep 2024 07:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725979728; x=1726584528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUmouZhvr+q34R2S/bVYuDGvtxpTho2ejRJ8jdc2nNQ=;
        b=Ly2dePmfrwuxVSjmCsuMsQDX3BBOwDzb92DhrKY1IhydJGwpOLZVLlrlrAlTrkWTMf
         Cm9iXfFSiMFeNveHRVg0bpBGF9brFxWZ2sMMGjVQ+02iahiJePQpGDEyezJzokKL2NwG
         tz0hb08Gqe1IwTRIe+yN3t6nffSzw1HYzck3RaFAnyP7lNiHOBjfClxxnku3+8bzmCZ4
         q6u/mR7/Y2wxEg7BWkQmwhNoLEJcwd/AwM5v+n6lyKxwBbekMfJMcq29VR/u6HWNlnFJ
         tae4/J288sHNBy04k47s8szAD7h8m/K/0DRs1kXdlm9jKuJbulD/rESXf5EuPMA0a3A/
         LCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725979728; x=1726584528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUmouZhvr+q34R2S/bVYuDGvtxpTho2ejRJ8jdc2nNQ=;
        b=gpGPl/N+ai7LWZIhhoF7m4mzOVXkeuUmwTdL7LFRbGzwGeolz7SuNsw07SyvrKegVj
         QrHvITqsKZLMnTswbdV1lc2hL3spid4O7FffuU7mPyQeCIAmcg+TRMc+Bokm2oBIawZt
         Uwv5NyggoIx6H/PEbXEnuK+uXFRHyILX+DqMftXEAdO+vkdzcAnZxEhzeHPLcbvCfzYc
         9YOo6KYFmkbjA5yrZd7XB965MtD4wKAgX3+i/cwYf424gh4Pw0SIldjUqj3akccBswiw
         C6uCH7cbzeNqTsfmYoDtzRS9IkdCrPzqXIwgTTBrVhTQ+GW/UO5FNI35kVwlI4//KLm8
         UtSg==
X-Gm-Message-State: AOJu0YzUCIpmFD9MgWfe9YTIQcCV4jjLjLKei0oGh+J/VgXow6dmMmnQ
	8PWONy6NHg31dRT4svnx93FFfq4MLl8UN6egplqa7KyaBrafX5UT4yyU14sWQrIA+A5bTR6R0uP
	vcrYc7IqHFBMr6WU/NkU+uWukQKK8tvDn
X-Google-Smtp-Source: AGHT+IGlPKV+MrODsiUryK8PHRZQzZvy6mVj1dRB/EBqDU7L67DNeOA26QEFUhYnsrAt5aA8CeFy46QJciOU1/JY7CE=
X-Received: by 2002:a2e:a9a0:0:b0:2ef:1b1b:7f42 with SMTP id
 38308e7fff4ca-2f75aa07c90mr82432911fa.36.1725979726723; Tue, 10 Sep 2024
 07:48:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910090201.115557-1-frederic.danis@collabora.com>
In-Reply-To: <20240910090201.115557-1-frederic.danis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 10 Sep 2024 10:48:33 -0400
Message-ID: <CABBYNZJoamaMNUaAmj00N+ubdYcdeYzoPO-i4kOGbeiVP4r7Rg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3] gobex: Replace g_convert by utf16_to_utf8
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On Tue, Sep 10, 2024 at 5:03=E2=80=AFAM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> The glibc's iconv implementation is based around plug in modules
> for specific translations which may not been built on the platform
> and prevent to use g_convert().
> This commit replaces it by a function similar to the existing
> utf8_to_utf16() function.
> ---
> v1 -> v2: Fix missing g_free
> v2 -> v3: Replace g_malloc0 by alloca
>           Fix UTF-16 buffer size allocation
>           Ensure that UTF-16 buffer is terminated by '\0'
>
>  gobex/gobex-header.c | 41 +++++++++++++++++++++++++++++++++++------
>  1 file changed, 35 insertions(+), 6 deletions(-)
>
> diff --git a/gobex/gobex-header.c b/gobex/gobex-header.c
> index 002ba8861..889c794df 100644
> --- a/gobex/gobex-header.c
> +++ b/gobex/gobex-header.c
> @@ -62,6 +62,34 @@ static glong utf8_to_utf16(gunichar2 **utf16, const ch=
ar *utf8) {
>         return utf16_len;
>  }
>
> +static glong utf16_to_utf8(char **utf8, const gunichar2 *utf16, guint16 =
len,
> +                               GError **err)
> +{
> +       glong utf8_len;
> +       guint16 utf16_len, i;
> +       gunichar2 *buf;
> +
> +       if (*utf16 =3D=3D '\0') {
> +               *utf8 =3D NULL;
> +               return 0;
> +       }
> +
> +       /* OBEX requires network byteorder (big endian) UTF-16
> +        * but g_utf16_to_utf8 expects host-byteorder UTF-8
> +        */
> +       utf16_len =3D len / sizeof(gunichar2);
> +       buf =3D alloca(sizeof(gunichar2) * utf16_len);
> +       for (i =3D 0; i < utf16_len; i++)
> +               (buf)[i] =3D g_ntohs(utf16[i]);
> +       buf[utf16_len] =3D '\0';

You will need to allocate one extra index if you want it to be NULL
terminated otherwise you will be accessing past allocated area, that
said can't you just pass the utf16_len to g_utf16_to_utf8 instead of
-1?

> +
> +       *utf8 =3D g_utf16_to_utf8(buf, -1, NULL, &utf8_len, err);
> +       if (*utf8 =3D=3D NULL)
> +               utf8_len =3D -1;
> +
> +       return utf8_len;
> +}
> +
>  static guint8 *put_bytes(guint8 *to, const void *from, gsize count)
>  {
>         memcpy(to, from, count);
> @@ -130,7 +158,7 @@ GObexHeader *g_obex_header_decode(const void *data, g=
size len,
>         GObexHeader *header;
>         const guint8 *ptr =3D data;
>         guint16 hdr_len;
> -       gsize str_len;
> +       glong str_len;
>         GError *conv_err =3D NULL;
>
>         if (len < 2) {
> @@ -177,13 +205,14 @@ GObexHeader *g_obex_header_decode(const void *data,=
 gsize len,
>                         goto failed;
>                 }
>
> -               header->v.string =3D g_convert((const char *) ptr, hdr_le=
n - 5,
> -                                               "UTF-8", "UTF-16BE",
> -                                               NULL, &str_len, &conv_err=
);
> -               if (header->v.string =3D=3D NULL) {
> +               str_len =3D utf16_to_utf8(&header->v.string,
> +                                       (const gunichar2 *) ptr,
> +                                       hdr_len - 5,
> +                                       &conv_err);
> +               if (str_len < 0) {
>                         g_set_error(err, G_OBEX_ERROR,
>                                         G_OBEX_ERROR_PARSE_ERROR,
> -                                       "Unicode conversion failed: %s",
> +                                       "UTF16 to UTF8 conversion failed:=
 %s",
>                                         conv_err->message);
>                         g_error_free(conv_err);
>                         goto failed;
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
