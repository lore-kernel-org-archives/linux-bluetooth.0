Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1F8567D
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jun 2024 20:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719260263; cv=none; b=Kykxxb2HTxUNNAffhmbbSwEKQqIAChEWmNpUHCTdUrYBuMBx4T8TY2x0sRktVcYR/9dHojkBsncxE6I89pfIAZ4TQbZhVk8DoMnmfDgcI/lxB2K5rGqgovvRRh3KmLfISOpsOM4LIelB9mviET1B4Kb4jP7u3oLpqgBRx42iH6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719260263; c=relaxed/simple;
	bh=Yc0HYaCiNVMqpQ+E+6XkUsX4wkKct1WvUV3hbKWz77M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AngUz5GM4tupuW0QY7YsNzrb15s7VE1tzPpusfU76fCkj1bzTbNC9R1625CDwfX30cOXwW+wek5FP/gsQkTZH9+LSO95qZNENjo0PT3sMwRfLQh1qYi5MW1gq1zHMZR1zZ7hUmFF6wyUDz/RHAMcKSxs0cWrG/XKbQydt3WpVsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WOWP5kOq; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WOWP5kOq"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-644630a8de9so12846897b3.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jun 2024 13:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719260261; x=1719865061; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E/G7vqge8/AMhNlJ+tOTijQCXPd5V7TRQ0r6Jxcr8oI=;
        b=WOWP5kOqlWJaGjat7jNIjT5kOF9xp2th2iiD6UvWqsmgONVCUbK8gMKAhB9+olTC9x
         Ng0oLBXjRZODJ2KN+ugbgDQ4Qum5Amsh33dZDhZsFg9E6RE3R4u2RIF3OCYuwNppDOsx
         nZE2Bfyk53qJr0rQ3ATrBrMpUit4LNDw8OhYGBS1AZ8xXp3NuYYkeabDx231vYULPcVZ
         Mkvgwfx9V1/2QqUWj2K+IriLJeUuGSswmgk6+OZ2rHWm0VMoQjjmnn52RjG/xf4QS5pO
         NYXXmVXWEg5E0MYv3DybF/ZSQUJew3f1t0hlcoC6oJ7f7KFL45jg2tL+ipMvJF9OpQSv
         fi4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719260261; x=1719865061;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E/G7vqge8/AMhNlJ+tOTijQCXPd5V7TRQ0r6Jxcr8oI=;
        b=KxKS93flcnzwc9rscIulYv6C5yHf98ReK77BBw/eAQhWSetV9y8kcNuqC/DkzfoQeW
         G8rwaZflcG9t0e5B9iWnrDLfghfHQ0bAX5XCIe/rm8916th6kzvMELW0Ajod0cOQ6/Jl
         knXjG2tdHvbIMmnjPHZcYUBZgzTdKVcYvJB/UfHDJue5kMRLX85DMzgxv7AwKFGybmEC
         kyGd/BAJUblXvEfOJ0IbK+LfZiX/9jAyYECE+B8oF5GjcNw0fx/2IYytOiQFlF15uTCf
         jPyNHTwxEiFuQrdNbQgcB+d+FGBw1l0aCFz5xs8ER4NEv+7Py0k3iI/ZxfFktzAefAOC
         sxtA==
X-Forwarded-Encrypted: i=1; AJvYcCX/nFvoqvlb4X8MiHKRnx4CCK52R2MlOdRhLN0U7sA5VbQ86i0OdKNSH+4/uIATHxt5iePvVpAQYdWr4pHNwv3HJfydw6yxon7fkxFQZhlL
X-Gm-Message-State: AOJu0YwUArFGwGvSLTqUKRf9beVC6CjB70wR5risV0LGdracoHroI9gL
	ehUyTmtchL5EswM9yuMjEjUSv7TtwhE5u2CObYwPlhzmltiuO7pYHu8OMJ7/VE2XAxbyVpFr7Ie
	POF1y+ABDimo9Ew6UFRKQUvkQ9gHaNtuAGtR2AA==
X-Google-Smtp-Source: AGHT+IG60q8kebyIquS1qrxnUyo32rJmM/jOykbnuXCsnoil1c5UFnlPtVw2q6vrSdcKIQkw08GtbNTmSFWTBh9fPvM=
X-Received: by 2002:a81:a7c9:0:b0:62f:60db:326 with SMTP id
 00721157ae682-6424bd69f63mr37708397b3.20.1719260261020; Mon, 24 Jun 2024
 13:17:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624194518.37458-1-brgl@bgdev.pl>
In-Reply-To: <20240624194518.37458-1-brgl@bgdev.pl>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 24 Jun 2024 23:17:29 +0300
Message-ID: <CAA8EJppMPeYrPH+ssDMnf6UwHRdKQetpY3PotGvR-cc2vE68AQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: don't disable power management for QCA6390
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Jun 2024 at 22:45, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> We unnecessarily fallthrough the case for QCA6390 when initializing the
> device and hit the condition where - due to the lack of the enable-gpio
> - we disable power management despite using the power sequencer. We don't
> need to look for clocks on this model so it makes more sense to just
> register the hci device and break the switch.
>
> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Fixes: 4029dba6b6f1 ("Bluetooth: qca: use the power sequencer for QCA6390")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Is this going to break the QCA6390 as present on M.2 / PCIe cards? Or
the older DT which didn't have pwrseq entries?

> ---
>  drivers/bluetooth/hci_qca.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 2b31f3dc33a9..bc6a49ba26f9 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -2402,7 +2402,13 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>                                                            "bluetooth");
>                 if (IS_ERR(qcadev->bt_power->pwrseq))
>                         return PTR_ERR(qcadev->bt_power->pwrseq);
> -               fallthrough;
> +
> +               err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
> +               if (err) {
> +                       BT_ERR("qca6390 serdev registration failed");
> +                       return err;
> +               }
> +               break;
>
>         default:
>                 qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
> --
> 2.43.0
>


-- 
With best wishes
Dmitry
