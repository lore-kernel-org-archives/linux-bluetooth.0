Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B83C4315F
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2025 17:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738086619; cv=none; b=OsGYhDW6JU1+P/mXczrdKWt3T70+uide4e3UndJfhAFo1ZBOpnNnZ2hUMScfOXCV1eZfRjoUHeW4lG2OD6Ao1f2rTZC00okYvoYoZkcD8uN72wqcwZ2QcxjJ24ctXMQdQyejCzpdv5PN3kewzQeCikhljfwxQHaISc+0KTwkKAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738086619; c=relaxed/simple;
	bh=23KKR1hkF8eXbPS2J+l09Psw3CWmMPe3Yr991UEZ/p4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fYvwiig6Dcq3qHRd6XSFRLVO4x3caIUQTY1olu0NFnWYHaOtookxF7UNgHz/ypxYm1GqXJ4jAzTvic8xeKURE+lB/LbgPh6OPkPTE26nIQX1PI/DkHtkKCVieyyAGxVciNktrjasmY3QkSEBRrRYhYRGPmPRrFruy4DVKf/o6A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hiB1Z9QZ; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiB1Z9QZ"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-306007227d3so59929301fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2025 09:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738086615; x=1738691415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RsgARjkLJbDUmRmndOp5kWDqqf2zc+LSyj1mgDu5SFg=;
        b=hiB1Z9QZZidfHd7B2M9LOsLR3izFimuSHgIOEcI9Nx9qblIYxyzA1Q1M0vOC7USe4H
         QD+H10QNcG3HCaD+Zwpyn0/6EXqg7KZB8oDj/zHaYYYmj5ctbdBvxUc6+RjMEwFpFOyw
         4HuVeI8zsEgabvNmkAEw950kDg9JJi3s0DqzNQbcaC8JIqibgQySSzGe9NfBRGD8o+Bd
         JGw3oqClHD4gHi8DhxmxfMk0VpBfZ/tezbTNOq38ohmy1WL5RlqLDdbpmSa2ul0w8AEu
         f/gFCYFDNcbAR/orCe0iJxkaPRsn7s7Qi0tXM3kfowzifv4Un+WErdE8lRyGncHYPEhV
         k/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738086615; x=1738691415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RsgARjkLJbDUmRmndOp5kWDqqf2zc+LSyj1mgDu5SFg=;
        b=iJs012oQHyxQVBOu6qBLfee/bkQtdNIAYA3JcbQ8WF7X9odnblMWEQKlP7II6ugSjN
         GX2b6OVd2UGiVpduUBx5wG0iksmJP1hflVP7gmaSxIaWy55nCnoPmvTQmW9coI+f9792
         lSq57xhcPM2K52QdvO7jwgAt2l5dOK3cebmJiYrqx1yc2kyisKeZJOLvfQIO2v7bnEGq
         DogPaxDQs4VuNgleckk+t30TKN1DZDC75bM5j4kX+iSK9AuOtQxxO5U0cyT90d1FjVVv
         WLvwuMmJoXzdqmWGFVUySSyazU2PKegMtVvakjK/tiYqJWbUk3q8WF832aH4t0kIm9FP
         nZYw==
X-Gm-Message-State: AOJu0YwjOPfZ1XYahid2b8hffu3PofLkXbiZTOJmkwXFmj98EslB7vmv
	YLk3On9XFldst7v2nVi6IsaIUnIWjAfyBv1IrpC2hNMCdn7DhmT86we48isTqOVAEjkzgF6NTsz
	k/gw762hozKA+Bm41mZYupjuC+c5bSA==
X-Gm-Gg: ASbGnctapUcb4+uYYDetjjUjop8ZrDdE6fWwjtwivLYQk6L6jMDlvYOgiKMbYyKuQj5
	6+JsKvqX7DyTKpap5UYo3z1lTRxGyPkC7ixhUq0mtUS+sbaRZaSQY6inuXOg1YpnrwFeNyfI=
X-Google-Smtp-Source: AGHT+IFU/LvOKBtsqy0j6ddKyF+u97rSe5ZkmlcHvTJDvNxk+3YX8/M13tHNad/uj0LQdZU4I/P8S7KARuwr+oT91/Y=
X-Received: by 2002:a05:651c:2224:b0:300:42ad:f284 with SMTP id
 38308e7fff4ca-3079681efe3mr969721fa.7.1738086614736; Tue, 28 Jan 2025
 09:50:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128174327.1477546-1-quic_amisjain@quicinc.com>
In-Reply-To: <20250128174327.1477546-1-quic_amisjain@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 28 Jan 2025 12:50:02 -0500
X-Gm-Features: AWEUYZk6Dz5A275GCR8A7le4cyPCMqaV44ULRFvRfjn8-uqKZo-7sVnzmIfYcbQ
Message-ID: <CABBYNZL-26H=BuJvPbrqF8oswWiGWxiX8atNdt5ULYt5Xs3VgA@mail.gmail.com>
Subject: Re: [PATCH v1] obex: Add supported features tag in MAP Client Connect Request
To: Amisha Jain <quic_amisjain@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Amisha,

On Tue, Jan 28, 2025 at 12:43=E2=80=AFPM Amisha Jain <quic_amisjain@quicinc=
.com> wrote:
>
> This change is required for below PTS testcase -
>
> 1. MAP/MCE/MFB/BV-06-C
> Verify that the MCE sends its MapSupportedFeatures in the
> OBEX Connect request if the MSE declares support for the
> feature MapSupportedFeatures in Connect Request in
> its SDP record.
>
> If Server's SDP record contains the field 'MapSupportedFeatures in
> Connect Request' as supported then include the supported features tag in
> obex connect request.

Can you include the btmon output with and without?

> ---
>  obexd/client/map.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/obexd/client/map.c b/obexd/client/map.c
> index b8820335b..2fd0f74ec 100644
> --- a/obexd/client/map.c
> +++ b/obexd/client/map.c
> @@ -39,6 +39,7 @@
>  #define OBEX_MAS_UUID \
>         "\xBB\x58\x2B\x40\x42\x0C\x11\xDB\xB0\xDE\x08\x00\x20\x0C\x9A\x66=
"
>  #define OBEX_MAS_UUID_LEN 16
> +#define SUPPORTED_FEATURES_TAG  0x29
>
>  #define MAP_INTERFACE "org.bluez.obex.MessageAccess1"
>  #define MAP_MSG_INTERFACE "org.bluez.obex.Message1"
> @@ -2179,6 +2180,23 @@ static void parse_service_record(struct map_data *=
map)
>                 map->supported_features =3D 0x0000001f;
>  }
>
> +static void *map_supported_features(struct obc_session *session)
> +{
> +       const void *data;
> +
> +       /* Supported Feature Bits */
> +       data =3D obc_session_get_attribute(session,
> +                                       SDP_ATTR_MAP_SUPPORTED_FEATURES);
> +       if (!data)
> +               return NULL;
> +
> +       if(*(uint32_t *)data & 0x00080000)
> +               return g_obex_apparam_set_uint32(NULL, SUPPORTED_FEATURES=
_TAG,
> +                               0x0000027f);

Don't think it is safe to check the data like above, we don't know if
field returned is really 32 bits, perhaps it would be a good idea to
introduce something like obc_session_get_attribute_le32 that would
ensure the value is really 32 bits and also check its little/big
endian in the process.

> +
> +       return NULL;
> +}
> +
>  static int map_probe(struct obc_session *session)
>  {
>         struct map_data *map;
> @@ -2224,6 +2242,7 @@ static struct obc_driver map =3D {
>         .uuid =3D MAS_UUID,
>         .target =3D OBEX_MAS_UUID,
>         .target_len =3D OBEX_MAS_UUID_LEN,
> +       .supported_features =3D map_supported_features,
>         .probe =3D map_probe,
>         .remove =3D map_remove
>  };
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
