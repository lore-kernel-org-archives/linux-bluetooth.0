Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BAB1DFCB
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 18:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713380396; cv=none; b=YkU8pfumLHiUA1OVuoCJCNW6FGpSBAZtZRXkJEKF0DK8pFr+LhZ8ERoH0F1TYV6U+7C/xeO4aj2TFz3WUz/h++vd5fJ97DhGPKrH5MZXeIqazKe9GmJ0ssNW3s6p/2lw3BWyvirre58nayjWZsLcJUJCy51gP6epFtz6f9ywWck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713380396; c=relaxed/simple;
	bh=xcqOo2KrPs0/UBjH5pUeuesBL+Owh+7HWpB0WzvE+cQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SzoNbbHpTnn1a0kWDXoSAHyzmj+G78QE3+2KlypnQO9prmkesCeZHEoIqS9Fg3+T8Q6sWC0Ld2DfeSegRdueryDCTLnejitlG0siTC0D4WvnV/QLapLRHk0noywEQ4T04onz6SR9iSi15cyx1O7jKxYG0Zh19ewMz0Znk0KL990=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vdiu16OR; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vdiu16OR"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-61500da846fso7287b3.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 11:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713380393; x=1713985193; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6Ef1pB3yjc3hAiYOqf/vWNV97GhodMZZZkrZmalB8sk=;
        b=vdiu16OR0XgrPtxS2xqJxswQw6Hg1VkaBwd7cz5U2a0kOQUs+CmfhZcchu3xloAw3Y
         vS5hgI2GaioNuUUyQ1exI7fQ3SdoLk3WpfEvEyatx1mAUAawMRXG0/sPWiPhlKLhseHU
         Pd1xmozbE0s3CI2c5YemBwXLW3eJpovM3++AGROfWlw1zBQIJX0Jag3FDYD1eBviCzay
         rFfhwMX3JqQrry/cIeKGU5oTUg6q5+eA/x3t89JLq4pIMN79Yd7hIfZdbon5qPlTDDp8
         YVh66cR2UmG6glI2kdvdYVG1Bwh+6LHpnCL2Jv6ddO3ai8bIQAo0iMrpMaFWHAc2yBXA
         I10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713380393; x=1713985193;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Ef1pB3yjc3hAiYOqf/vWNV97GhodMZZZkrZmalB8sk=;
        b=m87xBVZRbWrT+DeLCHq60F49MAEXMGOUvPQKL28cyuXNdMQJZoyIQXa5g0bAP+8QE7
         RrFCyhuqY3v7ExrLAM9ngIwbUkFmwM4sjbQDQr58TYMMxCtu3wnClhuCeGP1y2MBt0kY
         pq24uoSgZvJlQlUfh6/VYrnWC+eDxyurmz1RSiuKqQ6wYqVrCV9geDci3BP8DckX6AJ1
         FI5EuuZMBQSixG+JVEO6iB1jx8kcoiOe2tlASyhxHd58EJU44YcYvyVctyx+Cd8fUNIU
         Iv7eYLktvkyrqUNIf1gUI/DatS/BPOkZ3D5SQPW6ZHaziRVnIqrloSIq8OEaLgqtA5Oy
         kXLw==
X-Forwarded-Encrypted: i=1; AJvYcCVTIqK1gQBeYO3skTcsatfutEbLFv+iBpqZnPjnSzfK99Ch5KSocVObgIQHoqrGwjFxVPZeQoNav63QMQ/LOh7MIcJY44pzepRIWNf+JAvI
X-Gm-Message-State: AOJu0YwUNLT+uokLQ2cjUamJFOvtPDVAeyOITdGXKZAqaRQsSeuTIuq8
	K3GxiiOb819v3+vlDq8xy8TKxaWOa9/II0Xo/+KBEaBsZKIvandcedXnGAUjRYZuUgR638R9ngI
	Jhho+toqj5ipJVjwIGFEW77XH08R7bCl+16waZw==
X-Google-Smtp-Source: AGHT+IEA4nBVcQgS5GzcOTF26Ef/PzHIUj2cdais3gdBi/jADwDoVo8tECfZgw3evndSaybP5WXiDzez0U0myRxUjx8=
X-Received: by 2002:a05:690c:6c93:b0:617:d539:12e8 with SMTP id
 is19-20020a05690c6c9300b00617d53912e8mr152217ywb.50.1713380393452; Wed, 17
 Apr 2024 11:59:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1713354823-17826-1-git-send-email-quic_zijuhu@quicinc.com>
In-Reply-To: <1713354823-17826-1-git-send-email-quic_zijuhu@quicinc.com>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Wed, 17 Apr 2024 20:59:42 +0200
Message-ID: <CACMJSeuQMz-JCK7tqiQCmt7z37L1UncNK0un28JHAa8qRhnp-g@mail.gmail.com>
Subject: Re: [PATCH] Revert "Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
 with gpiod_get_optional()"
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: luiz.dentz@gmail.com, luiz.von.dentz@intel.com, marcel@holtmann.org, 
	linux-bluetooth@vger.kernel.org, wt@penguintechs.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Apr 2024 at 13:53, Zijun Hu <quic_zijuhu@quicinc.com> wrote:
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

Then you just go back to bad usage of the GPIO API. Please see my
suggestion below.

> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218726
> Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()")
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
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

Can you just move this out of this block? Or just simply check the
presence of the GPIO descriptor in the if block setting the quirk bit?
Warning on a missing *optional* GPIO is wrong. It's not an unexpected
situation, it's normal.

Bartosz

>                 }
> --
> 2.7.4
>
