Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC43613AA2D
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2025 21:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738101255; cv=none; b=SNUR54WiRzpBUfet3uP9eFe/0/IGkJHPNU3XEbW3s9W6HAsndg9rxu8gFKIzRE7fDjwqF9+5JvLBjgfmmk6Gwi4mXPEEm6uZSSwujguMp2mIcUy2O6ZWTnb15bIZtGYCT1WRIJkPKw3+5STH/j46PpEApcPn158/yv4mjidIIW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738101255; c=relaxed/simple;
	bh=fLvNB6h2HoVOgan/ys8I7aJOUuNRwWJ3XzobfoLrVtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JT2mBm3Jl9FrPBom6OGQdL4OvJTZOLBbf227RaGBqnmz1hDzuVkuhAl2ZS5DzvKmQMbLzwXIZv1ksaG/E7c/bcOUgR1MC5xFxmaZP5pkhPyPzp+SlgFfrphSIhyu8VM/To/Np7aneCy9NsQfvr3uFO4SSp8LZ01zF8Yqkm0+tDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGaOneVu; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGaOneVu"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-304d757a9c1so1180341fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2025 13:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738101252; x=1738706052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtmKiYJN/GQD5zNZP5zp3FPyugIBByJCfUXiipb9gW4=;
        b=kGaOneVutdaMphR23dZ/oZ7p9Waa0MbqCmkZIGfIsmXw2jRlFQ8B6ecvBURJtsCUg7
         1MNw1XQd3asmMYyyz2F3KOYn/VAKxHwx9sEk+iTX+hlJ19oav9v2UDNpgvDUadusZRr8
         eqow4x+H6U5Zcjw7vN63iDtWdZ46QqQiWILRzigm+doLcXDCK81iJRmOU7z0dcdxKZ2p
         HYaDsQn3tuJx1v6vsFiwiBvhw2uO0hMmErObmgCFGzJfa1Zhgc4B+c5Mjfx2GpsQVYCU
         VVGy4hGRGedKoWbuUUaptnshQYINCNkT7DR2bx3UnmnD6zxKsQU05a9174iO4kPvlVBh
         Vo4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738101252; x=1738706052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wtmKiYJN/GQD5zNZP5zp3FPyugIBByJCfUXiipb9gW4=;
        b=uJwiY9Po8MWWX7auX1+o/e86GQcJGJinHdmNWaR2MvTglWryk+fdCf+BkLU762+8pA
         VVrxkU/SGkaM1Fc10JFLktqAYUusNNabkOdG67xJbOmXi36OBHpYyh3a+7HqUW0O0vBY
         JAAkUejnUkxpF/qwznIKxUywt5//9/hzEgITyoFhwNCt+efWe0PPDWj3VGEz+emvXCJB
         AlH8gqceHnt3dudl9rt8fFpxWWwS9H6IWeFio2ftUTmOo+nkuRFQlyz8TxlsOSq2SGZX
         uZ5ikT3HSo1UYZ0pmwISr4QmACdjFoTz/xpJD5uXvDF4wi/wzIAfPsnkIfkor53aVa22
         Os4A==
X-Gm-Message-State: AOJu0YyPbWVO6uv6PoW3cswGYiavHPm0gzbQ1YXqnTC+kWpVryM32Zrx
	SqHlu44sH65nLVl7I2UWjtHxYzl5VP6fr/vNSJiGJfVScNNlFDbPn5sDAgabmirE0BnWSrhLNVB
	kfXcdudHvHic2pyUgCnm3oJEgdPc=
X-Gm-Gg: ASbGncv6MarXNPUATh4lVHM2aLr1nSXEdaVXv+2ZcKv8K2QZKwQ/2114rbHo5MM17RM
	IHPOrJGgoAiU2YZ92mYZ23LRak3nkzgQ1eHOiTcEvPlOojrexCiNfLu/V7kvP/Q+GGPOcoDK4LQ
	==
X-Google-Smtp-Source: AGHT+IF13BLWCzRyHfmAPZu5lcY64Ti3XjZi4ED4PcFmv9GN+WUGXrrzQPPjndpMhXbgO8PQAXyxl7ekYmOX12lT71I=
X-Received: by 2002:a05:651c:2110:b0:302:49b6:dfaf with SMTP id
 38308e7fff4ca-307969a5dccmr2355161fa.20.1738101251558; Tue, 28 Jan 2025
 13:54:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128210354.73732-1-pchelkin@ispras.ru> <20250128210354.73732-2-pchelkin@ispras.ru>
In-Reply-To: <20250128210354.73732-2-pchelkin@ispras.ru>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 28 Jan 2025 16:53:58 -0500
X-Gm-Features: AWEUYZkrbQJ71waB9ZNEEiIytyXjneRsIJ-j_zou4xWuC_xM8WeF2bymd2s-LG4
Message-ID: <CABBYNZ+zFOGn2cq87txV3KVsW9aT-VeYpX5SO21sPZ3zuTqoNg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] a2dp: enable input MTU auto-tuning for the server
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: linux-bluetooth@vger.kernel.org, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fedor,

On Tue, Jan 28, 2025 at 4:04=E2=80=AFPM Fedor Pchelkin <pchelkin@ispras.ru>=
 wrote:
>
> L2CAP frames are lost while utilizing some exotic A2DP transports
> usually coming up with weird custom MTU sizes so take advantage of
> auto-tuning it for such cases.
>
> Found by Linux Verification Center (linuxtesting.org).
>
> Fixes: https://github.com/bluez/bluez/issues/1080
> ---
>  profiles/audio/a2dp.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> index c97bd6e89..05a2e2e80 100644
> --- a/profiles/audio/a2dp.c
> +++ b/profiles/audio/a2dp.c
> @@ -2592,6 +2592,8 @@ static bool a2dp_server_listen(struct a2dp_server *=
server)
>                                 BT_IO_OPT_MODE, mode,
>                                 BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
>                                 BT_IO_OPT_CENTRAL, true,
> +                               /* Set Input MTU to 0 to auto-tune */
> +                               BT_IO_OPT_IMTU, 0,
>                                 BT_IO_OPT_INVALID);
>         if (server->io)
>                 return true;
> --
> 2.39.5

Another thing we might have to do is to fallback if BT_IO_OPT_IMTU =3D 0
doesn't work so perhaps we should incorporate some special handling if
auto fails at btio level.

--=20
Luiz Augusto von Dentz
