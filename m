Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720C31AF0D9
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 15:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731942803; cv=none; b=krcS0xnCYYm0cGLm3J7QgVHq82IiEdhpFlps74v0BVboCDhvhJwScSmVkrOgv/PpOKqEja1PgE2PpPI5pcd0yNHErxphTksLMXXjrZhKVM1Cezw5HydM4QLV5PAkqq9Yob/YgsFk7gyWN0YU5exzvyWFnzjyWSv2djooATXQgkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731942803; c=relaxed/simple;
	bh=avN3GioXm1eL7bNyB87xcuXUuv0kk64fCD9wj5IR5Zs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VLYoV2aMeGx7v5hKmsxjKJEAiHfGFsgPefhJmRpgB0Ga72CoZY+cDFh1Vx8Kyf3kTV0YT9V8g6yRQDC0XEZvwEUiC80wwzEuQR/w7dA0sTP1ZoEOU4XNAbYukpWI+fD8+86dcr6ojQEh2HnLNDP8o8hMnD96h3I7owku0w+usnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhOIr7xn; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhOIr7xn"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb388e64b0so40612021fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 07:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731942799; x=1732547599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ipYtt9HA3eBM852gso8nAe0a1Vhm1aHUt9sOEPLDNmI=;
        b=jhOIr7xnSsvHfFjy3Ny+gGzI8xrj4Bz55ZptBe3ekYaR3GGUhc8d7OnPPjgKvWHPG2
         GAMm8Zd5vJbolTerG9bZ1tnIDWglX9jYgjl+v6YawhbkX+8bzt8P06+IuC3vmYjMX93Q
         uk61Jg7r5ufTXJOtvmZYC+CUrc5Rrtuvp0Zc/Mbf8YT53vFjuggvnftSUBjsYdWrv19U
         DAvstjhzklUajBthEjLWqZyM8ZpPJgBc5O77bFWYVCkPTONk8jq0twQ9WnXHGGdbTCzu
         NdazSsdTmUzIMKoiDrgZ8qlo8YtV6eh+ekqQJGz6/KAhhUu3d6OpEmCCkg2uNxiRRHG5
         Gg5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731942799; x=1732547599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipYtt9HA3eBM852gso8nAe0a1Vhm1aHUt9sOEPLDNmI=;
        b=uyhIzD05EIkh6I/z4nHCNg2LdkGp9VF3+QqpK1nxLRaaSnigTQvOSGTQWop5hCxxBy
         qyusw7W7EzzJV1A6BeqkIH4HZ2uX7zxx0AiXPii1CaqgVG+H3+Cx7gmW22G0EnUvKaCd
         naF/Tqd8YrNNjJBC5YlhgXMxEmTaYVmXukwjps2GcK0Wlf4ZTslCzh6UbJ3bjjJ3UBzj
         Av662gh8e8YXSD2Kr/kMo6z1Tl8OouIse0aquZPiPj4Rm3fmKEA9NuqLASRjTuW/771C
         UOdvR2hX/J1Ek+/e2kmiKS8PzmpXm/LIHZdJ2KqCuY0K214N8gnJarGhUwlWOzlaRd5T
         d4zQ==
X-Gm-Message-State: AOJu0Ywm4A9HdYXzh7yhDBip0H15TmR05FS/x/d4tZ7IOfzp4AA5wjgk
	FhN4N8qu/F61DBlm1ovfgrG5THsH2QyEC1Ums9tSnAQe56y1mPFn/2l9fKOuvXO0ZvmmNOTcgzU
	McEdJz8fxmHVFieS5eJeYBjQHHIDbX3RO
X-Google-Smtp-Source: AGHT+IEX3/L3p0veX5s9JWGuwkmJ/2gbYn1Q/C+pbdCA+JHhjgrHUiKKIVolEdSOeGQXB8BCkbEMZhDVFEFLRrPf/+I=
X-Received: by 2002:a2e:a80f:0:b0:2ef:20ae:d113 with SMTP id
 38308e7fff4ca-2ff606fdb02mr52584681fa.40.1731942799198; Mon, 18 Nov 2024
 07:13:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118094907.2673431-1-quic_jiaymao@quicinc.com>
In-Reply-To: <20241118094907.2673431-1-quic_jiaymao@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 18 Nov 2024 10:13:06 -0500
Message-ID: <CABBYNZK9Z2fKiFmfnptUsX+yrvaKNW+b_BfQyidM=z2YU499nQ@mail.gmail.com>
Subject: Re: [PATCH v1] hog: Check security level before setting
To: Jiayang Mao <quic_jiaymao@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_chejiang@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiayang,

On Mon, Nov 18, 2024 at 4:49=E2=80=AFAM Jiayang Mao <quic_jiaymao@quicinc.c=
om> wrote:
>
> bt_gatt_client_set_security could fail if the security level is
> already BT_ATT_SECURITY_MEDIUM. So, get and check the security
> level before setting it.

Seems a bit strange that this is not handled by the kernel, can you
elaborate on the conditions to trigger it?

> Signed-off-by: Jiayang Mao <quic_jiaymao@quicinc.com>
> ---
>  profiles/input/hog.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/profiles/input/hog.c b/profiles/input/hog.c
> index 017e320f0..011cc0a88 100644
> --- a/profiles/input/hog.c
> +++ b/profiles/input/hog.c
> @@ -191,8 +191,10 @@ static int hog_accept(struct btd_service *service)
>                         return -ECONNREFUSED;
>
>                 client =3D btd_device_get_gatt_client(device);
> -               if (!bt_gatt_client_set_security(client,
> -                                               BT_ATT_SECURITY_MEDIUM))
> +               if (BT_ATT_SECURITY_MEDIUM !=3D
> +                       bt_gatt_client_get_security(client) &&
> +                   !bt_gatt_client_set_security(client,
> +                                                BT_ATT_SECURITY_MEDIUM))
>                         return -ECONNREFUSED;


Definitely not the right way to fix this since there might be other
places that do attempt to set the security, so Id got with something
like the following:

diff --git a/src/shared/att.c b/src/shared/att.c
index 4a406f4b91a4..dabbdb4315eb 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -727,6 +727,9 @@ static bool bt_att_chan_set_security(struct
bt_att_chan *chan, int level)
 {
        struct bt_security sec;

+       if (level =3D=3D bt_att_chan_get_security(chan))
+               return true;
+
        if (chan->type =3D=3D BT_ATT_LOCAL) {
                chan->sec_level =3D level;
                return true;

>         }
>
> --
> 2.25.1
>
>


--=20
Luiz Augusto von Dentz
