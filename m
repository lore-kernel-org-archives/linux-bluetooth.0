Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ECB13C663
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jul 2024 14:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720449914; cv=none; b=eN+xgPbfLeG6CeK7ynXkFYHqei6+kiu4WzHxb2sn1GDADVg6bNKDLNLvZHR+F6MBoiN/TJ+AqcN7IrUNjs5NUShW/ZLJ2bGoaOiyae5ywUtSqe0qYyuey1OGWXEKmi47mj4nqzw9rR82K9rKPgy+19eUj90AMuzmWNe7LJvyf0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720449914; c=relaxed/simple;
	bh=oF09ZgiYJv6kVhB2FbeukHX/6UBdFR5W+X1HqqV+t/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MtyVeAXeMEA+R/wV6GgVtIau4CndCZhbvowxfBTZWqNFKoJTLhFxAQqZt5rWzFUlvzz2gcMqybNhbPryPUW/dSv2muD5eQZ6KAxKqSfHm7JNpzn5FwdqRn0HI0nCOU16SOJaigH5LoGBgPPhBAxvEbT3oAah/eUUeNGaNsTp8CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6VFEoBD; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6VFEoBD"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ee7a1ad286so41965511fa.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jul 2024 07:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720449911; x=1721054711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2TG6bY8rbK8fpvQpcTXR5O9hURdykldAFVHwWpK/D0I=;
        b=f6VFEoBDgcXve2/nhIaNgMFko9DIhMikYOQI/uj8eFtfp7qrO4fQzrSO28FpbTLNez
         3gPj0kjh5MC6ZwVRqwP5cgkVu2HMDJEcqhwYVsdPrz8PEFn+HfmAL5RRu5Wtd7Q6Ki6w
         VKbfiaeOnYwdIQhZrQbO6dUpjamxDS/Ge/H6hAAfoKqizAEXOMwq69M/81koKqbIO+Oz
         5wuxSNJxyHLlTCePZNdQLLikIssAnicmFPpdx6h6/aJQpDBaXGRenstv1zj5AfEdQ3gS
         wGbMxZuuBPaBDRJUfTolb3UtBkSNR93k68IzMpjZ+i9E/UYhESGeWSWcif5oM3oOTsd2
         qEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720449911; x=1721054711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2TG6bY8rbK8fpvQpcTXR5O9hURdykldAFVHwWpK/D0I=;
        b=MBVREHHShGlsTMFQCErcOqh2k/P+mirob03Zzk98AWQmVIwYfibHISPkSZ3wWfaR1f
         3kDZ8ppra6v7404rfg7XVWQN1hVR++e8gmLbam23vvHCLVLR1xnFJ4vYBQ8G8zEet1vL
         Tpb9c3D5HoNQvfRJsFGZMfTE+99T658Ei3upjkKM4DUHI4cPp2nkBHnTFPaP6zDcYeaR
         AT6DhPlFCes9XN+kljpkOvF+gbkJ67Fd0tT1DkEA6y55gfzSiYxksfwC0YRi9ZnUiWz8
         zcRvYJWxDDwcVTVBxXfHzmKie4JA3LLk+hRXen7t+N8limaG8cGE2/razvpyOsk32u9D
         3ikg==
X-Gm-Message-State: AOJu0YwlhfgC3bOfvAL8gexpVs5nBgXzrY8xUQVj7erWIFuKNIe5B8Ql
	gwUWIwVbVNFeI5IFRfd4fbfTM72bCaHF7vp5KRj3H+MlAB2/d8uADH6Bvvi92mLh/3WZ+/JbMxB
	5x193RAn4TSbls/3YOuBegcApIKQ=
X-Google-Smtp-Source: AGHT+IF12ulAJBh9SXswhDOHJJx3yKLpSg6wEPtkTbqLb65sm1imBxHxXxO6VX5ojD8XMC/fTiV6edVDHlzEPCv9hT4=
X-Received: by 2002:a2e:6e11:0:b0:2ee:8d05:db2 with SMTP id
 38308e7fff4ca-2ee8eda81b9mr89052501fa.29.1720449910676; Mon, 08 Jul 2024
 07:45:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705085935.1255725-1-hadess@hadess.net> <20240705085935.1255725-2-hadess@hadess.net>
In-Reply-To: <20240705085935.1255725-2-hadess@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 8 Jul 2024 10:44:58 -0400
Message-ID: <CABBYNZ+dDvU4nUeCU+9VNfynmQ1iajp=SkD_oFf4F8wxWqsh9g@mail.gmail.com>
Subject: Re: [BlueZ v2 01/11] gatt-server: Don't allocate negative data
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Fri, Jul 5, 2024 at 5:00=E2=80=AFAM Bastien Nocera <hadess@hadess.net> w=
rote:
>
> Set a lower-bound to the data MTU to avoid allocating -1 elements if
> bt_att_get_mtu() returns zero.
>
> Error: OVERRUN (CWE-119): [#def36] [important]
> bluez-5.76/src/shared/gatt-server.c:1121:2: zero_return: Function call "b=
t_att_get_mtu(server->att)" returns 0.
> bluez-5.76/src/shared/gatt-server.c:1121:2: assignment: Assigning: "data-=
>mtu" =3D "bt_att_get_mtu(server->att)". The value of "data->mtu" is now 0.

We are disconnected or have an invalid bt_att instance if
bt_att_get_mtu returns 0 so it is probably pointless to attempt to
send any response if that is the case.

> bluez-5.76/src/shared/gatt-server.c:1123:19: assignment: Assigning: "__n"=
 =3D "(size_t)(data->mtu - 1UL)". The value of "__n" is now 184467440737095=
51615.
> bluez-5.76/src/shared/gatt-server.c:1123:19: assignment: Assigning: "__s"=
 =3D "1UL".
> bluez-5.76/src/shared/gatt-server.c:1123:19: overrun-buffer-arg: Calling =
"memset" with "__p" and "__n * __s" is suspicious because of the very large=
 index, 18446744073709551615. The index may be due to a negative parameter =
being interpreted as unsigned. [Note: The source code implementation of the=
 function has been overridden by a builtin model.]
> 1121|           data->mtu =3D bt_att_get_mtu(server->att);
> 1122|           data->length =3D 0;
> 1123|->         data->rsp_data =3D new0(uint8_t, data->mtu - 1);
> 1124|
> 1125|           return data;
> ---
>  src/shared/gatt-server.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
> index 3a53d5dfde6b..66e370d1fe3d 100644
> --- a/src/shared/gatt-server.c
> +++ b/src/shared/gatt-server.c
> @@ -1120,7 +1120,7 @@ static struct read_mult_data *read_mult_data_new(st=
ruct bt_gatt_server *server,
>         data->cur_handle =3D 0;
>         data->mtu =3D bt_att_get_mtu(server->att);
>         data->length =3D 0;
> -       data->rsp_data =3D new0(uint8_t, data->mtu - 1);
> +       data->rsp_data =3D new0(uint8_t, MAX(data->mtu, 1) - 1);
>
>         return data;
>  }
> --
> 2.45.2
>
>


--=20
Luiz Augusto von Dentz
