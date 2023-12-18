Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635B94237E
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Dec 2023 17:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTg5KNjp"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cc7b9281d1so2512191fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Dec 2023 09:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702919936; x=1703524736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWGHhBD0WYd/cyCepEQ4R1KKPnNd5l8ZQ4xdlTL5+uA=;
        b=GTg5KNjpTy5fiooRROZQI133hjV5BfcNfMojMXpz/n767RqFv1OFy1HC2JKkw3evfm
         HHJasa/kO17Z73MlF9qr00sPAPzY4+583PATjc6OQT4GElIz7LE1G1BgNJGyGTKzTc5Z
         YULB+fc445ZJGe2ZHIbzGr++vHjpRfcs/SaQzuETuwcQKIA0YKK1CrLLr5+EAHlhoULy
         Vtv2OXaZEh28HR0ngJs3nXh4Ws8U2Wdj1dYbBPGUNgfSXjdVAONl1OiagvlDgXg+nFWR
         3JsC0VX32K8ifQdZCAUAuqXPXJBSl05TzHllr3WVhUoZdu1ykgL3HZBC01mwNc9vOaLF
         Va4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702919936; x=1703524736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CWGHhBD0WYd/cyCepEQ4R1KKPnNd5l8ZQ4xdlTL5+uA=;
        b=o0EKLHO5HchBRBGlu8+TJkQCjumH4DUP6cY5GKBP9blOcTBYA9OL0kJAx6UKp3QF3V
         kZaRBs5S50ueQ2gao44vPYx9x/lEHd5yl4dclf+wcbTznkxoUFr5CjnkPXpDmiP61XSH
         c/Jk5ikG6zhEi26v+JTiEEsYCyQDyIEoshP+q9PMNipk55Z9YM+pyGbQXCP7pLOwqJEG
         ZV25epyWjwPEJx9AYgTMszSJtVZKrjLDgP8o3gi8/xCeyqFk5yvOvPjNpTBAzPNqNkZT
         qjzwStcZxJEfSNVXa3nJD1FNz+Tyi0UGQZblRVrvbHcJIe9J2wRhxIoWgmtKObkGdn4T
         Jxlg==
X-Gm-Message-State: AOJu0Ywj+38+5Ue8ZnlKLa3vbDuU6bx49jfACqGDRM1hw1HsrwewVp8D
	fih3Nxx8XNg9GkkDp7EGUq+PGGe4sphDUjviDZo=
X-Google-Smtp-Source: AGHT+IH3Df+mJX4f/sCJfMOtSS18BWM7bdPKu6D4Hefa3FBeK6rnXvRGUY1Hu2JwEjG9iRf9A3RmK8xmqrS9O3bPSiA=
X-Received: by 2002:a2e:bcc9:0:b0:2cc:2b1a:57e3 with SMTP id
 z9-20020a2ebcc9000000b002cc2b1a57e3mr8646309ljp.88.1702919936163; Mon, 18 Dec
 2023 09:18:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231217135012.1476534-1-xiaokeqinhealth@126.com>
In-Reply-To: <20231217135012.1476534-1-xiaokeqinhealth@126.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 18 Dec 2023 12:18:44 -0500
Message-ID: <CABBYNZL=Vi6jaum5B5y8P2sLUF+FkcdTPJ-WU07GbG5B6YtHJw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] adapter: Fix link key address type for old kernels
To: Xiao Yao <xiaokeqinhealth@126.com>
Cc: linux-bluetooth@vger.kernel.org, antiz@archlinux.org, 
	Xiao Yao <xiaoyao@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Xiao,

On Sun, Dec 17, 2023 at 11:21=E2=80=AFAM Xiao Yao <xiaokeqinhealth@126.com>=
 wrote:
>
> From: Xiao Yao <xiaoyao@rock-chips.com>
>
> Fixes: https://github.com/bluez/bluez/issues/686
>
> Signed-off-by: Xiao Yao <xiaoyao@rock-chips.com>
> ---
>  src/adapter.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index ee70b00d2..b4628a411 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -4347,7 +4347,17 @@ static void load_link_keys(struct btd_adapter *ada=
pter, GSList *keys,
>                 struct link_key_info *info =3D l->data;
>
>                 bacpy(&key->addr.bdaddr, &info->bdaddr);
> -               key->addr.type =3D info->bdaddr_type;
> +
> +               /*
> +                * According to the Bluetooth specification, the address
> +                * type of the link key is not fixed. However, the
> +                * load_link_keys function in the old kernel code require=
s
> +                * that the address type must be BREDR. Since the address
> +                * type is not actually used by the link key, to maintain
> +                * compatibility with older kernel versions, the addr.typ=
e
> +                * of the link key is set to BDADDR_BREDR.
> +                */
> +               key->addr.type =3D BDADDR_BREDR;

We probably want to find a way to detect if the kernel is capable of
handling the addr type or not, maybe attempt to load with it set and
in case it doesn't work then use BREDR.

>                 key->type =3D info->type;
>                 memcpy(key->val, info->key, 16);
>                 key->pin_len =3D info->pin_len;
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
