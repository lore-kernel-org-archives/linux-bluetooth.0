Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C077F47604E
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 15:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788191881; cv=pass; b=CnWDetBHFMrl2d69MGGFRqk854RvjF7253PtpYrTYbH0+TQVn2rfK+mU6KXA2+EKLaK29Fb8DRDX0nxAt82sI4+KSNE7jD1vr86RYG0vyEloKHxGUfmLiQ0JqWQN+vldz6dTEmFiJ5QarH1DT/KsTiBKGnz7IMQWL8at1SiXrTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788191881; c=relaxed/simple;
	bh=oaFUQjUzI8q+WkAbIgnbl7ncw0tIwGFEVpop1R1TExY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DQr9X2fgvFdvVbaue6MN8j+I36ZHq6zpWmMP5IRCnzVDAL91BViGlc+rVCFPxe9qc7uXMneDWgSvf+x1tpukkPx82OoYlry2NFT0mDV3mNyXRUV5LmxCO1UmXvsJb2KZntU6kg3NznusDpmF+qvKmq1XXCfYTRRoLYfLRlYncyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTE7Uaat; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTE7Uaat"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8664769db58so11359087b3.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 08:57:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788191879; cv=none;
        d=google.com; s=arc-20260327;
        b=KFiKf+wcwZ1KyKXhR5Vd3KUuKWLv0FJif7jLd9RX+IZSONvdYnqSSOQlcNGuJ3CA4y
         P/ax2s8hNnRDlQqXlSEjMrh+/qR3qqyc0mEvmfQJnsLZvcIyj3hnZBoM5aozJIZJgeEP
         uCmquZDs3HByUFcKxXWc6/2xVG0dKGvsH/yAAiMmrJVNipfHtw4L3yzTFv/JT877WVi/
         1XWUmcP4xXCgjz4+GcbLLoGdR6COtIhB5Gg0TabSl0TFKrTucMCJijkLMzgqpJfn+gLA
         ZcQO+79bCw3vo7cAjtV0SnbO0VLyuJEFlVG69dgSwanIcqUxfka2JRE6kcMsvLIupO37
         Rf1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U5ZxZbMyuSte3/Y+Ze5B9/gqHPmk/Fp6FciYk9oX9mY=;
        fh=NKfA7UDgM4p/zNz+NmgUdEGk3tSbHFr6jzzngQ0z+9U=;
        b=KoqND/kRD7lSxatIMd7CNBHV5nnFTMbUbrig2h+rkyBa4zm/PuwjCVCHW9kY9upZ+i
         OmWFfCHX1s+92nBbJ+KBN57j9tIPEVwHOmYwDafyCRdXSp4p1RKh0Yb/+T2DGN1v0e7C
         tFJumvm9F8xw25Gdd5Tj0Lygr7n/QCXme2RBZifoOVqPcSF3sJv5BfGihla0QZLF5hRG
         O1XKPfM83mC1hfXmMQQ/IitMYsLyx8ElolWXwfYVxd+qVVmE8NLWvRxZSyzy9KNckSM6
         zCmYGnnRJ3ODjw6g6Hpl1l1jKUic9y6UsVPDwnVXoo0dQSZp8XXC76Y8CD7ta/6P9IZE
         iBSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788191879; x=1788796679; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U5ZxZbMyuSte3/Y+Ze5B9/gqHPmk/Fp6FciYk9oX9mY=;
        b=iTE7UaatWDsO5lbdsrvoZQNuFUZyXySXqphLPLypP8T94YvrIrYSsjoDicBsQelqO1
         hThfR7Hhi4aBIISTvqgskK0MnCQKofVDO3nY9xl4COunTM9unbGwTACqOhT0Todm99te
         yJZuigIF5MrnZkDyeeQcPcZAW7sUP5Ee/MrWAxt/clrPXeTMQQNWbaDzR4GyotuDjW+E
         ZKlu12a7sA/vsGZC5yiy4hTF1OUvIi1lcbYxAtk0ptL/wdanphoPAwSh83oYX78Tmt+5
         koIf8nIoA5AVwVG1rSimjrU521zZ40VpTF6ZyobqdNyn2z6+K6ozAG+lkEpuMTBmp2Dc
         IWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788191879; x=1788796679;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U5ZxZbMyuSte3/Y+Ze5B9/gqHPmk/Fp6FciYk9oX9mY=;
        b=fc1RGCbZjRNapBVgeSegrfKE9AuP+AFyuo0JbABcfecax4WuNCrEStYQrOjrJa8byX
         md3SPpsuI+urOA4uwHdevIijrZB6jHEEbpbPT2e8/jWdJeaqPNeC81udLZ1bE93umSyG
         Q5HNBVXA1T3XoBsiE/o33YfW9jq0RWxa593Grmpc7GBC+ltMyvCoSitVnGLc6CQ3tK57
         3oyhtFxwIzCEYIusl2y8b8lU9PNSC3w2AVJNkM4vyXqmwAIHUT3Yam9buVif6/iP/C9A
         Y6prP6A8j1CTPNh9AXloAvbbdo7JahTa3y3PMCiIcyDY02nJ8NFzXyFZcuewj4hu/wuW
         jeCA==
X-Forwarded-Encrypted: i=1; AKwUvBzRutfIPCgqhCIchE3fw4oxyrTOnfOsmxpw/Yjc4tn+VS/x2v5PqC4sI+U60NQD9efIdGUp0Tv+8DNfZUxekzE=@vger.kernel.org
X-Gm-Message-State: AFuF++n2APyMqFQ0lusKj3gNKus44310trX1705nt7xDUspd94CCyD1U
	kIpBQNnn5xXRxiH6uELN9ng5sAYY2331VHv5ra/O9224F9EUAB09EYkdaAkL3lcGMuUJsgdz1IR
	pZTNYeM3aytLVvGPF22z4HQD0UGfwGBM7+OEYagm+4/SG
X-Gm-Gg: AYBFou1ASQdpWaOBuSNNxo1Iworr3XHNOTsfmWiGcs8KdRMfaCy3g5q0LlydPq8v38V
	SerQjFiZouEpBGlqTkCI9pjs7bLDCg2QFXSWMUffZHJb0caTVtiGysiu8FnH68+bb3aZCapQu0a
	tEvwjfFvKArEVvz6VhriILYL4UrK4XN1sFzBBLNGjPWe6ir7Dwh4b6AVvDkqi7d9bEqH1w9Ye2M
	IbdN94K2uKBipn2Wmm8csJoLxGX4j7VOV2U6NtU3wyn8uOy1rWlaXL9aP13BJILg7dRPpnEWUX3
	GmXf0cJrBKVaScsCZQoSK5PU6awuUsAyE7NFqmItVqMoqh21xd9YS1cJkqdoNGyqflArDgDuHHU
	ySyUoVpKw9N9zVBr8+qq7dLtfLoKNcPk=
X-Received: by 2002:a05:690c:dd3:b0:80d:f376:5ba9 with SMTP id
 00721157ae682-85d6c7e2969mr93934827b3.24.1788191878670; Mon, 31 Aug 2026
 08:57:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831014638.123808-1-lijun01@kylinos.cn>
In-Reply-To: <20260831014638.123808-1-lijun01@kylinos.cn>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 31 Aug 2026 11:57:47 -0400
X-Gm-Features: AcwNN1XcRvuTlSiNRXDjAXKLNRUAtOpwoW1BzW19VznrRQGhaSUYAZ7M3mGKzIo
Message-ID: <CABBYNZJ8aTr-o-306cdFaFCiq-cApAe0gRe1TYRsFafugQ+zdA@mail.gmail.com>
Subject: Re: [PATCH v6] Bluetooth: pm: use DEFINE_SIMPLE_DEV_OPS for pm struct
To: Li Jun <lijun01@kylinos.cn>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Aug 30, 2026 at 9:47=E2=80=AFPM Li Jun <lijun01@kylinos.cn> wrote:
>
> use DEFINE_SIMPLE_DEV_PM_OPS for btmrvl_sdio_pm_ops, and add the value of
> '.freeze, .thaw, .poweroff, .restore'. if these address are null,
> may cause error in s4. pm_sleep_ptr() to safely drop the references witho=
ut
> triggering compiler warnings. This macro automatically handles
> CONFIG_PM_SLEEP configuration and generates freeze/thaw/poweroff/restore
> callbacks, reducing boilerplate code.
>
> Signed-off-by: Li Jun <lijun01@kylinos.cn>
> ---
> Changes:
> -Corrected grammar and spell errors in comment.
> -Replace SIMPLE_DEV_OPS with DEFINE_SIMPLE_DEV_OPS.
> -Add a description of pm_sleep_ptr().
> -Add pm_sleep_ptr(&btmrvl_sdio_pm_ops) for bt_mrvl_sdio struct.
> ---
>  drivers/bluetooth/btmrvl_sdio.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_s=
dio.c
> index b91fc63bc9fe..a250a83a031d 100644
> --- a/drivers/bluetooth/btmrvl_sdio.c
> +++ b/drivers/bluetooth/btmrvl_sdio.c
> @@ -1726,10 +1726,7 @@ static int btmrvl_sdio_resume(struct device *dev)
>         return 0;
>  }
>
> -static const struct dev_pm_ops btmrvl_sdio_pm_ops =3D {
> -       .suspend        =3D btmrvl_sdio_suspend,
> -       .resume         =3D btmrvl_sdio_resume,
> -};
> +static DEFINE_SIMPLE_DEV_PM_OPS(btmrvl_sdio_pm_ops, btmrvl_sdio_suspend,=
 btmrvl_sdio_resume);
>
>  static struct sdio_driver bt_mrvl_sdio =3D {
>         .name           =3D "btmrvl_sdio",
> @@ -1738,7 +1735,7 @@ static struct sdio_driver bt_mrvl_sdio =3D {
>         .remove         =3D btmrvl_sdio_remove,
>         .drv =3D {
>                 .coredump =3D btmrvl_sdio_coredump,
> -               .pm =3D &btmrvl_sdio_pm_ops,
> +               .pm =3D pm_sleep_ptr(&btmrvl_sdio_pm_ops),
>         }
>  };
>
> --
> 2.25.1

I hope you are checking the feedback Sashiko provided:

https://sashiko.dev/#/patchset/20260831014638.123808-1-lijun01%40kylinos.cn

--=20
Luiz Augusto von Dentz
