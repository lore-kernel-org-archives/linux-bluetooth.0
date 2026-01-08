Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68F31F9ECB
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Jan 2026 15:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767886087; cv=none; b=EAPBvIV1/gb7zjwwR3TTyWZEARaIbDIJ4u69Mg1RRKiN9YN/DbzMzgbT46mlecvNtcvZu9LyRR4vsQTBvuJHiQYXBZR6CTr/rNW5ZxgWZkhUUZo1lJfkaw2fpQXAXQEoUNl05kbC0RH+zv9guy4YsL4OpICxUXz7z5SXLUMTpMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767886087; c=relaxed/simple;
	bh=IdxsiVxHJKaSZ7hdLiDxeYrZCtfdyAvwRuZB0qQ7+O4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KApPLh6hE4T0FgAyOLlVOUWvvAwActTJOgFdcmm673wqtF+vdB9TVaujWssFCGOYgokTxB/5ugKKgIPPhlQjixH3hLPW4AgGduUjH0B8UYFHB7dXtVS+Lt5A4xAv1rAJy3s3JG2+Y+ejpkCp7uZV43VyxsF3nQ9UqFhUkH9LdDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOV5sx5g; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOV5sx5g"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-644795bf5feso3663251d50.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Jan 2026 07:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767886084; x=1768490884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1k1FIocjGvjVHrIJ/4NYayUMYb1ZlBpf4G4H5JArsM=;
        b=IOV5sx5gCsNr8Dm6acmgQBb7ao3IfMbKKd7dt181k2u1FnzPZ0o1ZthdyGR73WaJLe
         +qL/tAOUt4GG89vfhdK8wEJGBDHp8veFB79mxBY8FdZPx8ie0ByAWSQMnA+gKN7wpQTk
         vl3JwcmUW4FqgbxyTxDDjGECibIu/UfQbgU5lJIvmnQMvbXBEVOEzGwmMQNn6G9hvJnJ
         DclWTnUGLb5XCITeaAWSSmVIycSIG8RtHESr/1TDSrjy1TW9j8CsFtUsdpuoNkGWFlwV
         enPsFNywOaKC0W9a5x4RG+HSygvNT+pR88rfzh3wHQuoJ55KAkqfndSpTjlAD7E1SPmU
         o+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767886084; x=1768490884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s1k1FIocjGvjVHrIJ/4NYayUMYb1ZlBpf4G4H5JArsM=;
        b=QXM86ysKuzAY7c0WZS1gP9s9Ewk8x7enmlHDun2pJ4It2cxyn9rI0GUNn4lP73BuGO
         SjdH6S2hrgbavzNijqrN5hPFyVNXFJb+6Xp3n5YdRCWgMakLIfS2yMZstKU6CTh1eO5n
         hrUe8GOTJTwaKyXmeXxtJo2nEheCX+OKqM1reK/gUsgctZDN8yagY9savzyHhLyTPqZL
         hh0jLFN6q78dadL1Bgiu/8Zs/AolRqCHop1ZskAuUOW7LUO1kkL3bndQHO/hHzawKwuw
         Bdv7YVBhWe+8ronPW3BuKRtc69orqCz6KPIzqYut64+4WoH0k5ncdbkX9QBbbrfUttAV
         9INA==
X-Gm-Message-State: AOJu0Yw/KgOAGAJSoZAk5yDQIVDpcl1Wjcu2CmARDDQp58kLu7+wUaXb
	mBCVfDHH6EqVWQk+97dDPbXHSwt3Z/Oc1FqyRdm7PUSDAgFDJvHdIYaAGN7D8D6eh7KhFz2+RlR
	oA68B0zaMPDtz6xCE+LmIJ3UnnP8xMZwYBvFU
X-Gm-Gg: AY/fxX7mX9qpOySJEHMw6WIzEGVtdujEyvteUUKwNhWmTYVQ/jqYt34cgvXqHDBR8mm
	r3T2oXpizBPmqWC3FevStw2MHcHF2D7CCJTOPYLSTqkTrHQbbnYFkMvZ+8LJImkis2fldYhsJ9O
	Wcc8vgT0X6pfgqfEQYGktyZLfmB8bTMtidr0BjAlEXvZuK2nLTJdHWdXozUIL+0u9y2v0QerLAm
	l1eWR/N8UVHLobrr9F0aMSnoyHk1fKUOrEmPAr1B7I9FDntoKScckV7YalvEjR4jDRk2RdCD7Ld
	62KtPf5kyWs6WpuDDI0B4GlCRjyjgMQWwL0p+ZzkO+NHhhQ7PIr/NNXRJA==
X-Google-Smtp-Source: AGHT+IHtVC9dgUm0VSQXWTPoR/bm4q4vP60yMF0yzQcH+zcsPF1mwv4btSC+pe9s76zHcBqXAGLzFAGzJ8wTI+sQO1I=
X-Received: by 2002:a53:c243:0:b0:644:60d9:866e with SMTP id
 956f58d0204a3-64716c9500amr4105633d50.95.1767886084462; Thu, 08 Jan 2026
 07:28:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108100136.486675-1-dalegaard@gmail.com> <20260108100136.486675-2-dalegaard@gmail.com>
In-Reply-To: <20260108100136.486675-2-dalegaard@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 8 Jan 2026 10:27:53 -0500
X-Gm-Features: AQt7F2q80mP9l-Cv0vbydjyMSrVDRsgIy36BRzHEpVPl0Kx19sJDd60QmoXb5sM
Message-ID: <CABBYNZKT91_1arQSNSxzy-4RVVnAX+BV=Vw6qBMyCHjQSdE_KA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] device: fix memory leak
To: Lasse Dalegaard <dalegaard@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lasse,

On Thu, Jan 8, 2026 at 7:29=E2=80=AFAM Lasse Dalegaard <dalegaard@gmail.com=
> wrote:
>
> device_add_eir_uuids creates a list of added UUIDs, but it was never
> freed.

This seems valid, how did you find it though, I don't recall seeing it
with the likes of valgrind, anyway it would be great to have the
information how this was detected.

> ---
>  src/device.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/src/device.c b/src/device.c
> index c8aaf042f..0842becde 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -2453,6 +2453,7 @@ void device_add_eir_uuids(struct btd_device *dev, G=
SList *uuids)
>         }
>
>         device_probe_profiles(dev, added);
> +       g_slist_free(added);
>  }
>
>  static void add_manufacturer_data(void *data, void *user_data)
> --
> 2.52.0
>
>


--=20
Luiz Augusto von Dentz
