Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D35238E27
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Dec 2024 16:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734022003; cv=none; b=L3t54MmxF16/Qh2Q9NV5IK9R1xVj5Fh7EhK4n49ixv0hUMrS4yIVTPXrSrzm0u0N47EVHJfUWPSaWGVZv+BQY3ZbbEZ+zSwMilDzlrietTDDsdyNP3pn79w9BF+mYfHBnZo63reRe4hyUZKCAJBzgyEly3soE0AIL6YK6Ps7kNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734022003; c=relaxed/simple;
	bh=FX6vIcwqoJyL3LG1daoHh27lMEgpowUqu1kSY2Vo4qY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rD//UuiIWXBULKFkLvAbaU8c1dOj6jGKL/XixNwgc1/WhYiHuOaoBOhnr5JMEHozgYEfW+Zm3Vy0zbsIJOUNtdOaU230HyjXGLEx6frbKb4FQ04xwBsmi96h/Jb9oq75vTo1H0xgw20E76DXzhbjEeuf5hJ+w3T4cNI2yMQ5a3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWyUeLEs; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWyUeLEs"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3023c51146cso8273001fa.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Dec 2024 08:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734021999; x=1734626799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSo0H14uy7tzXyH8GYmaqPch3lG/Tj4vL7KFIhKLAIA=;
        b=dWyUeLEst2livAEP9hPHNEr/LDmCrupODSZ401RlI5YbcBoud0omdSyJ/zgkkH8p6E
         EMkLZqYxgjk8npXdJ/klDhsNW7vbWJFgyXs1/wgZ4SKVwdbmcZ9HLSPnE9O5tcBLM5Gf
         CRG/LMqZnFsHMtSN9KSwBHwnNtQe1653WZ7tsCZLQB+N+ABCq6IM7GFemXVL7+xoecqY
         2Uj3va4O7cw92299d6se+KfVdGnHqN5sQYIresUN9R6ExQogH5a4SY1SFCwLX44SNO+0
         /dtOAqsDSJolJQ2SmooIXRD3M74CT1MzkzB5JKJFUsDcmK4QxBWa7yFvD7OPrkSkADkJ
         rQdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734021999; x=1734626799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qSo0H14uy7tzXyH8GYmaqPch3lG/Tj4vL7KFIhKLAIA=;
        b=FX/MISwl7mHWfrtut8d/8TpbeESf50B/0rFQuMESPngVHlW6Zrm6V43AZq0nBPJUeK
         I/CdrdY6Di3pA0TDRqsphNAwBqkY3hpilNxBHtOBVzP/Evn6E84wTsSkH7yPHMKEt93b
         aeBhfcacluYGd2L7BiLskh1j6G4IBN4nLD9Y/QNzZ007vnnQ29cXtuzIoyOiWjl40qBl
         t0m1Rtvky3TAL9G6HoI9xDl/FxN3yQvubvy05ghHVvYLkckADsltotDpt6i7vH0JZRct
         jQ/i0Owigf4/uyBgTGXI4ZMh4s6zYHdHqcNG/CkPE3Z+vH8x9asUxzQKOvpxrb/cDn5S
         Ce5g==
X-Gm-Message-State: AOJu0Yz/0g/+q5Q8ovG9VBKKrtw05p6DbcOQy+axQnlnjoHzIN4fxx/D
	5aPXJMD99AzMj5mA1q4bB3AYsbsAEd0cr1R2p0H47/V6Z4MQvq99ik5f4WIgEnH9T5kYxqYe7qC
	t18vFDW3egzUWfTyyzboZKeBy+J9czA==
X-Gm-Gg: ASbGnctPi7BPW+3InV1iguh4RXav5GdpwkZaKtNZO6bSyULWYNFzWmS2Ti2f0rvdICE
	I+tS9fP/XQsUX7f9NjnKq/LKV3UWP3xzElaYy+Ak=
X-Google-Smtp-Source: AGHT+IFh6SECpXpgliVwYwPW9xmIjkSOVEC/RaVntab+fVtRY8apqowu2RaxT5cDfhpxwMsD7KB6Hyn/3bxyMCUCRHs=
X-Received: by 2002:a05:651c:1542:b0:2ff:df01:2b4c with SMTP id
 38308e7fff4ca-30251eef554mr3818721fa.4.1734021997164; Thu, 12 Dec 2024
 08:46:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212161445.298083-1-frederic.danis@collabora.com>
In-Reply-To: <20241212161445.298083-1-frederic.danis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 12 Dec 2024 11:46:24 -0500
Message-ID: <CABBYNZJvqkWLREyOEB2qySe7o-saSr4Fb8TSNiH3vRjL5U3miQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] lib: Add constant for 16 bits transparent voice setting
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On Thu, Dec 12, 2024 at 11:38=E2=80=AFAM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> Add 16 bits, 2s complement, transparent air coding format for mSBC.
> Corresponding commit implements functionality on kernel side.
>
> The voice setting is used by sco_connect() or sco_conn_defer_accept()
> after being set by sco_sock_setsockopt().
>
> The PCM part of the voice setting is used for offload mode through PCM
> chipset port.
> This commits add support for mSBC 16 bits offloading, i.e. audio data
> not transported over HCI.
>
> The BCM4349B1 supports 16 bits transparent data on its I2S port.
> If BT_VOICE_TRANSPARENT is used when accepting a SCO connection, this
> gives only garbage audio while using BT_VOICE_TRANSPARENT_16BIT gives
> correct audio.
> This has been tested with connection to iPhone 14 and Samsung S24.
> ---
>  lib/bluetooth.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/bluetooth.h b/lib/bluetooth.h
> index 073ed875d..32e58678b 100644
> --- a/lib/bluetooth.h
> +++ b/lib/bluetooth.h
> @@ -111,6 +111,7 @@ struct bt_voice {
>
>  #define BT_VOICE_TRANSPARENT                   0x0003
>  #define BT_VOICE_CVSD_16BIT                    0x0060
> +#define BT_VOICE_TRANSPARENT_16BIT             0x0063
>
>  #define BT_PHY                 14

Are you planning on adding support for sco-tester as well?

> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
