Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F61F248F5A
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Jul 2025 10:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751451805; cv=none; b=lcUHKGE4JNTiKTMgAlN0x/mfktnrqSHbDu36VQzRW0ov2KxLUvfb/P2uyVC8XdUe89iTuA4zhWdSZem9CYJrYDLQNkdMyTj8P05WNWwaM+6K42gfq1vJrEgfQzu9rbZ/hJM9r8GxlPflQlMP52KWqA40SFijkZZIg3zbkI1IZSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751451805; c=relaxed/simple;
	bh=Nj5nSI59hbeyop4iVjOwrm9k8R/gSeg9uN+yj3RKBCs=;
	h=In-Reply-To:MIME-Version:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eLU+IkaYk8Elz/yOfvOMi33lUcBlyk60vHlrV+wy29NMmp9t8hmFSv3H0Oi9WSlzU8LqFCbkNR2NUXOsLkDKi/vUSskoiabyMAhva3r7wvs8r+p0Q0QAg/KdFVBsOC1b24TswLwysWv2X+EM6bq3Uz3i2dtQlcMjwW9K5InqeXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=X5gp5hkt; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="X5gp5hkt"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5562838ce68so677913e87.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Jul 2025 03:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1751451802; x=1752056602; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:mime-version
         :in-reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=zVSk8pkCSvIZ4e4sM18HZrjEbG2bAMS6FSmdSReefF0=;
        b=X5gp5hktI1a1Bh7KR2BUtO5KR1bH+22w1ZF4BYmWQ8ztG99kZ8GRzJ2noZWrGUcVL0
         5Tjn5MnvIGS2rolemyjFMupxFem7eaMCvNbyj4biyuhcqcUm7WC1n4j87HDQFDttvRMZ
         LziM1OqgD3goyX5ZiC7IPMqE9uc72xKst8PD9HwchsmodmlpBJhYWoap+3ACNmixOJmc
         NTuNMSLjjxJMvWmf5qAIkJuntAbAF1keGbWXzxGHtEt1emrp3+Y/IEi2RDb+04vy117b
         vGKiEHtRexp4k8y+RAoJ1Th5sEW8m7Qk8eFcPc27tzkRySrQW2Q5HR6FVES2IVL3KFX+
         esEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751451802; x=1752056602;
        h=cc:to:subject:message-id:date:from:references:mime-version
         :in-reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zVSk8pkCSvIZ4e4sM18HZrjEbG2bAMS6FSmdSReefF0=;
        b=nMNTkARMuzQ1fM3GJAp1CN7TSdGBRAUae8einKvLiShikyb3Gs1zRtCU0kTktgkjZp
         /3R2IAPythGYBIzMSCHkbytjJmgOQeUFahEP77A8k6Jsza7hiRAk2F1q25AIk8VFKGKG
         oXzUziBBxSXX9WEJlJpNXPjCYNtLo76FuecemU9EficqnLzl94QCZ618iSV19tShig52
         /uXUK3EY7TVETXQrE1TQZFMFsd1bmIBOGVS3Cfad1k2o4Fc/hJ9ullD1lPn+X1536m4Q
         BomyTMQBdGfijiVUiWzwq42675LOLslNB402eZdTyjn5+NvPwcxWgtQmWrJszJUmaP6I
         QStQ==
X-Gm-Message-State: AOJu0YzrHmtv/XNuVrwt5O23qfqaRxzuwXQ3LhRufx7QesG8O+yyCTay
	haVYirPrKZQgFHKx0JOmN4PwqO/9Bqf/iFYnmqTq/2e5yCa0BMbpZYTzaA5CNy96vkHuqSBM3p6
	OwyWBBO/6Ni7ARG01AdxSVkb7Ja2e9xJJ+BcYn51tKv+ZJtv52GJNGjg=
X-Gm-Gg: ASbGncvzPzl3Q0CxLrOBRHw9AxMtV+R0/3Zyv/QK/ecoOO3L4tnKzebUO7vXR/3OQh3
	tm1v+MOgRoBx06s8ozgqNQWScOVhrDiNr6fcE2f5ecfnH8ZJBrCltw20w+qtDdXPBkDYySDWOxx
	TlbTNov6zqQF7l7WNJdDj0xL1xDiyE+ajC0qbPtLjmie7AEi0jfCMGJZ4uEP4iQGMGmmr4oT4I
X-Google-Smtp-Source: AGHT+IH1HT+YWhbdnPFnFz6lMVfGgPL2ZKkhwB53V5BesM2QrgvJ1ei9n3P+NuGpbGNdCexF6LELbZIBcfA9oD4Rk7M=
X-Received: by 2002:a05:6512:3d0c:b0:553:65cf:4dfd with SMTP id
 2adb3069b0e04-556282b19d9mr597415e87.3.1751451801639; Wed, 02 Jul 2025
 03:23:21 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 2 Jul 2025 03:23:21 -0700
In-Reply-To: <20250609105500.4083963-1-quic_shuaz@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609105500.4083963-1-quic_shuaz@quicinc.com>
From: brgl@bgdev.pl
Date: Wed, 2 Jul 2025 03:23:21 -0700
X-Gm-Features: Ac12FXxKxwmbMtvSihBya7GjjUAyzx__mprBnPid2EuNUFrroKtvsPoRowRluqE
Message-ID: <CAMRc=MfF7d9+cJi12G1yxPpMoe8K5N8tEO9kfCRJejHWt2DkXw@mail.gmail.com>
Subject: Re: [PATCH v1] driver: bluetooth: hci_qca:fix unable to load the BT driver
To: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Jun 2025 18:55:00 +0800, Shuai Zhang <quic_shuaz@quicinc.com> wrote:
>
> Some modules have BT_EN enabled via a hardware pull-up,
> meaning it is not defined in the DTS and is not controlled
> through the power sequence. In such cases, fall through
> to follow the legacy flow.
>

Thanks Stephan for bringing this to my attention.

Shuai: you have not Cc'ed arm-msm or even linux-kernel and so didn't give us
any chance to object. I will separately send a MAINTAINERS change to add
arm-msm as the mailing list for this driver.

What is the problem you're seeing? The bt-enable GPIO is optional in the power
sequencing driver and if it's not there, then there should be no difference in
how this driver works. What are the offending platforms?

> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
> ---
>  drivers/bluetooth/hci_qca.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index a2dc39c00..976ec88a0 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -2392,10 +2392,17 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>  		 */
>  			qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->dev,
>  								   "bluetooth");
> -			if (IS_ERR(qcadev->bt_power->pwrseq))
> -				return PTR_ERR(qcadev->bt_power->pwrseq);
>
> -			break;
> +			/*
> +			 * Some modules have BT_EN enabled via a hardware pull-up,
> +			 * meaning it is not defined in the DTS and is not controlled
> +			 * through the power sequence. In such cases, fall through
> +			 * to follow the legacy flow.
> +			 */
> +			if (IS_ERR(qcadev->bt_power->pwrseq))
> +				qcadev->bt_power->pwrseq = NULL;
> +			else
> +				break;

This is wrong. It just effectively ignores all errors - even -EPROBE_DEFER.
This patch should be reverted as - depending on the run-time ordering of driver
probing - it will surely break existing platforms.

>  		}
>  		fallthrough;
>  	case QCA_WCN3950:
> --
> 2.34.1

Bart
