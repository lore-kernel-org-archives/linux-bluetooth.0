Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC083375A6
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 14:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768574165; cv=none; b=HGRXAovSp8HkKMKTSBX04nOXgXWwLFcQxti3tQchqeDfGIf/qNpN/PxOjRTIE0ABPzwaVBKaSsN+HaKisoYqhGLRlgTPg3PhhGrHvdMqEtjec0Uc4b/aJVOh1QwU/V0U/V9bux/XYe1RGVsx0cJpibSEETRHt9IAElybQtqwEk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768574165; c=relaxed/simple;
	bh=0UWEWOv32jL9B/FXucNUp6c9MQMhVgKwDMD2fPz2u5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oLqA/JN084BV2t/js0stjNvv+YUpyphaZzu1bEtVwFzE6icieKFJ5h8uNIjXiuJVqw6U4hwJ6AIBqu6h/OcezJ5Yq3KnmUuP1vTtV73APWHoN0hYvhmrZ6ElBuRuqx5UfMcgOu+Kj5akrCSCRebKosoiKI6M5Gtcovb4J4QdvY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dyMT1Qd+; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyMT1Qd+"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-78d6a3c3b77so34688977b3.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 06:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768574163; x=1769178963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K38T+RY7Eq7cXrwJxwrwODhwsFTQVEAqnZusGRST7Ik=;
        b=dyMT1Qd+nD7qRevo+Snhp1+VmkG0nxezoQim/pyEGEgGFAHYC3muFecXJC/+YTK7yK
         s0eP6wWWYiFQ5CWw4FJyYmIJ/lZeCb88xXWG6f4jtOpZDihXv/tZwMHvH+YSpNkzH8X4
         KsGr7t/u/fuInm7ZVRjtufEQ/kY9cFhxt1x2hhZuMTEAwiDDO6ufhN0i447LpY3bYc+5
         VYuPEeHu4c7GXJDl0DKkO12zYm4R+Cq4QyX1/JwTgZ7V9qHNbkN5B5D5mJnqSGq5NZc2
         MUn7/I5HaXHqUB7n3IUQtoXCJL8SEIWZNuZQ/qGWEDg78UbGjEIhnF/fWA+7pdE/nnb9
         4TKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768574163; x=1769178963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K38T+RY7Eq7cXrwJxwrwODhwsFTQVEAqnZusGRST7Ik=;
        b=Q+vzYjJpkR2zqwDWljDRWozzPJ99jNbjkgYNj9rpym2sQymQBMhkgJdFFWS93MtTVo
         9XcC0/5kwzR9dVFM5RP3x5XXVrkbEfMS87kaI5hy3V840IIwWrca70IPcnZxuoXEqgh1
         eQAllhWtnY2hemaiPnsGFhABrpQJ6I+QHbrwHTEXDFvpKuqjrXcD7jb9mAyClZ6iouRW
         BfnjkeliTrdyYoMwMbp98pQ/bWWwjeHp3Z3KvCHEzq/NCoNZgLogAar4o/wUkPr9GkZy
         UE4KjgcTYBsDHKtLizbecTZEHI4UNlsiD+pP9v8l4ebng3Xr0DpgJo9tqThS/kCwyCmz
         ei5w==
X-Gm-Message-State: AOJu0Yz460C0oN6k8RbsZql9K4k4REFB7oZ5yUSeA9xPXWI+gkW/DkEt
	TkUuylaPnx2TU8bF4/15kI1sv3EsMKOJm1INVWgr2aCX7Baa7wpC2uXsHFSkSuAGsJk4NYqmbYU
	vNf0WhaoIJBhHGw8NUJq2fExoSUZPVJQ03e2F
X-Gm-Gg: AY/fxX6WqxWtLaAEJkNZEbrzp26Uk4doI0iHDEcxcifNwEK1RUBY83ruopm1QDfsMYh
	E9mXDnkaunFZLA24RnpJmVSSenrS+c6pQ4ArY0UW0G8sMq2rzhMwyv0Nd94ihVk8uDHb9OVTRa6
	4hEAhAcJVt/W0JZ4wS+aMXEG57ECRD2loJV9RVzVq8Oyg8IHXtBmIG6Ra4syfBxAa/76VV4nUxQ
	vpM4v3MIPGDaaKCXygBeCvRd8YktdKLYXDBqkESo93ShmCP/dKkzHHAGyxFasXealIz/OZ2TNFA
	IS3n1JlMskiStS46w2xIBM4E01zNUfDR5XO3XP8jRMsv1XbnthMDBoMPgnO326k8g8yf
X-Received: by 2002:a05:690e:1510:b0:63f:9fd6:94f5 with SMTP id
 956f58d0204a3-6490a5eee2bmr5244499d50.8.1768574162723; Fri, 16 Jan 2026
 06:36:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116125803.598552-1-hadess@hadess.net> <20260116125803.598552-3-hadess@hadess.net>
In-Reply-To: <20260116125803.598552-3-hadess@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 16 Jan 2026 09:35:50 -0500
X-Gm-Features: AZwV_QiVMz_vuUW_poyiRrsowNxL6bDLqkvSTJYSAO0VLKhj6_FvW25fbZ_PZyI
Message-ID: <CABBYNZ+Bkeuwogyj3TiZZV=kvv1oAw4y2gt8MfQb-WaYS-zQSQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] Bluetooth: btnxpuart: Remove unneeded CONFIG_PM ifdef
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Fri, Jan 16, 2026 at 7:58=E2=80=AFAM Bastien Nocera <hadess@hadess.net> =
wrote:
>
> The functions are already disabled through the use of pm_ptr() when
> CONFIG_PM is disabled, and won't be included in the final code if not
> needed.

I guess it would be more correct to say that compilers will detect
that these functions are not in use (aka. dead code) and just remove
them.

> This increases build coverage and allows to drop an #ifdef.
>
> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> ---
>  drivers/bluetooth/btnxpuart.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.=
c
> index 3b1e9224e965..13daa174aaaa 100644
> --- a/drivers/bluetooth/btnxpuart.c
> +++ b/drivers/bluetooth/btnxpuart.c
> @@ -1947,7 +1947,6 @@ static void nxp_serdev_remove(struct serdev_device =
*serdev)
>         hci_free_dev(hdev);
>  }
>
> -#ifdef CONFIG_PM_SLEEP
>  static int nxp_serdev_suspend(struct device *dev)
>  {
>         struct btnxpuart_dev *nxpdev =3D dev_get_drvdata(dev);
> @@ -1975,7 +1974,6 @@ static int nxp_serdev_resume(struct device *dev)
>         ps_control(psdata->hdev, PS_STATE_AWAKE);
>         return 0;
>  }
> -#endif
>
>  #ifdef CONFIG_DEV_COREDUMP
>  static void nxp_serdev_coredump(struct device *dev)
> --
> 2.52.0
>
>


--=20
Luiz Augusto von Dentz
