Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B04165FD9
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 17:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713459650; cv=none; b=Cdf5zWnVywvIhilFhkK5qjpX3C+IbW+OncJVQajw17T+dmCz0gvmVg0lcu+907CQSgdplFUgIb5JScepkh+6N0JJkkEjoyfi2/7haZPh2G8dMHoajzf9Ewo+XKtk4Gikf1psOei5gRuy312nq3Gobz8b/blhC6Tfozly3rOd1zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713459650; c=relaxed/simple;
	bh=VlsTMa4LVSmOeTJsnkfbraULAS0VDf+EyMpAs6Q3HsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FwdrJTRBcBoqpSQAiSULANmX+O3PSjaOj17UEmR+mPxdcZ2nPKP1YH1W5xWCFn+rAaOzxBseNKHpkUwnD3CAxTVeomthEIUR/UdB6RJw9hTEqmw5H+wMZCZ63lL8TsY6K9O4VOP2HgeEyZeNcdlpKfdoazrmCvTNuoH8OqbzcwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=godjbVmY; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="godjbVmY"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-de467733156so1008495276.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 10:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713459648; x=1714064448; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ytqcrFoVCWsXvoo0izClLachnxXGVVj6Kun6ubesPns=;
        b=godjbVmYsMUyiEt7Z7YAa2jHco4eREPuDDH98I1MM6eQjfkThpxj2tMDhu03UWh6sl
         RCqURsnW/jeJrr8mmVWxCcdxy0siljGLrd9VksCjjPQNZDb0B9fRQVbtcI1huN0b5YEo
         Ugg57iG+wuLbG153qbsrjGeAay7yhK+6iEKD6d0B0enXD9TnwF9PmtGx8muij2NlSKDD
         94hVc6+A4K5MJW3NGggkuDQa8ltSsCBf9/4T7wTXVC3nrkcM+HR8tBxQozrDJ+MJdUVz
         9DqT8VWvXtTjA3SEBkOd79FqkHCaLtRZVYgczajaUF0TY3gMKcmDLEinDXYYKRHgMrO0
         a2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713459648; x=1714064448;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ytqcrFoVCWsXvoo0izClLachnxXGVVj6Kun6ubesPns=;
        b=UI/1a0rcGSvBrO22c94JFt5r30cjcDOFcYgrqziaTrCzbvl/BPv8L1EwDaHKhGRKo+
         23EGx2zSyxHWnctPxboRgslEueizLgY5oelJTNVTXiaScJgmFqefHmRx6jf+eYWYLMdQ
         2v2HB9W2JdLjcBfiM96narvJ86DYKpVY34G9pXhWgWt0bgvc06iOcPkVYFp7opuHSloO
         lDuwxmCltCz8C0EjafBy3NsMjJo2U1Ma+8cYvanGlUojG7bV93vY/Xlrtu7Hgx8kZTgQ
         HipwNcEpV5REbJozJIhyzjG4MFGPRSjZP7PAPCV1pELDusUue1Wm84P3q7rUfxWcFq9w
         BA4A==
X-Forwarded-Encrypted: i=1; AJvYcCWsUhhYKKuQPR+GOISTAobJmv6EvTVrDsAD5wXlLiTDTWyrtU7PMWqZeNtCQ0WtlDnj4VFN+2337jRyrbdjCwH5WdGpX+n7TS5AvHjfKuXi
X-Gm-Message-State: AOJu0YyKQM/oLILGITF0vro4IfG+3RS11Z/bke2l7UZ/RzwbvQHgNni2
	JontHv2S5ljqzHW42s0WoBdY3Gl8BgjHkdxHEa93MPglWh+50Rr04g8S9RxY4lX+GSIutJF/qNN
	WDbvoNkQyY9UO/nNbdpN9i7KWCKO0RTIjd+brPg==
X-Google-Smtp-Source: AGHT+IHe8C9MmX2gUvmh2ij3tTPedLRPoNn2F0/lCJslP24eZvEUX9a+mq4KQ8exEtqUT0tJpEHhiRfBBaYbnoN+9ys=
X-Received: by 2002:a25:1107:0:b0:dcb:fb49:cb93 with SMTP id
 7-20020a251107000000b00dcbfb49cb93mr3479260ybr.45.1713459648088; Thu, 18 Apr
 2024 10:00:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1713449192-25926-1-git-send-email-quic_zijuhu@quicinc.com> <1713449192-25926-2-git-send-email-quic_zijuhu@quicinc.com>
In-Reply-To: <1713449192-25926-2-git-send-email-quic_zijuhu@quicinc.com>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Thu, 18 Apr 2024 19:00:37 +0200
Message-ID: <CACMJSevfE3wLhaz1z6A977JL5gOH62NThYWzybVqmHyR7pru=w@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] Revert "Bluetooth: hci_qca: don't use
 IS_ERR_OR_NULL() with gpiod_get_optional()"
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: luiz.dentz@gmail.com, luiz.von.dentz@intel.com, marcel@holtmann.org, 
	linux-bluetooth@vger.kernel.org, wt@penguintechs.org, 
	krzysztof.kozlowski@linaro.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Apr 2024 at 16:06, Zijun Hu <quic_zijuhu@quicinc.com> wrote:
>
> This reverts commit 56d074d26c5828773b00b2185dd7e1d08273b8e8.
>
> Commit 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
> with gpiod_get_optional()") will cause serious regression issue for
> several QCA controllers such as QCA_WCN6750,QCA_WCN6855,QCA_ROME,
> QCA_QCA6390 and QCA_QCA2066, the regression issue is that BT can't be
> enabled any more once BT is disabled if BT reset pin is not configured
> by DT or ACPI.
>
> if BT reset pin is not configured, devm_gpiod_get_optional() will return
> NULL, and we should NOT set quirk HCI_QUIRK_NON_PERSISTENT_SETUP, but the
> reverted commit SET the quirk since NULL is not a error case, and cause
> qca_setup() call failure triggered by the 2nd and later BT enable
> operations since there are no available BT reset pin to clear BT firmware
> downloaded by the 1st enable operation, fixed by reverting the commit.
>
> Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()")
> Reported-by: Wren Turkal <wt@penguintechs.org>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218726
> Link: https://lore.kernel.org/linux-bluetooth/ea20bb9b-6b60-47fc-ae42-5eed918ad7b4@quicinc.com/T/#m73d6a71d2f454bb03588c66f3ef7912274d37c6f
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> Tested-by: Wren Turkal <wt@penguintechs.org>
> ---
>  drivers/bluetooth/hci_qca.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 92fa20f5ac7d..160175a23a49 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -2323,7 +2323,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>
>                 qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
>                                                GPIOD_OUT_LOW);
> -               if (IS_ERR(qcadev->bt_en) &&
> +               if (IS_ERR_OR_NULL(qcadev->bt_en) &&
>                     (data->soc_type == QCA_WCN6750 ||
>                      data->soc_type == QCA_WCN6855)) {
>                         dev_err(&serdev->dev, "failed to acquire BT_EN gpio\n");
> @@ -2332,7 +2332,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>
>                 qcadev->sw_ctrl = devm_gpiod_get_optional(&serdev->dev, "swctrl",
>                                                GPIOD_IN);
> -               if (IS_ERR(qcadev->sw_ctrl) &&
> +               if (IS_ERR_OR_NULL(qcadev->sw_ctrl) &&
>                     (data->soc_type == QCA_WCN6750 ||
>                      data->soc_type == QCA_WCN6855 ||
>                      data->soc_type == QCA_WCN7850))
> @@ -2354,7 +2354,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>         default:
>                 qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
>                                                GPIOD_OUT_LOW);
> -               if (IS_ERR(qcadev->bt_en)) {
> +               if (IS_ERR_OR_NULL(qcadev->bt_en)) {
>                         dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
>                         power_ctrl_enabled = false;
>                 }
> --
> 2.7.4
>

I told you under your yesterday's submission that you should instead
consider bailing out from probe() if gpiod_get_optional() returns an
error as right now if it returns EPROBE_DEFER (enable-gpios is there
but the controller is not up yet), you will act like the GPIO was not
even specified.

gpiod_get_optional() returns NULL if the GPIO property is not there or
an error if anything else goes wrong. In the latter case, you should
abort probe.

Bart
