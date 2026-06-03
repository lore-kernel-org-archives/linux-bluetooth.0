Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2699938C430
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2026 18:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780509982; cv=pass; b=mtZ1nZ0XpMVjRJ7FImKEJG5kAXVG+Pqlxt0eeDnFUUKysoKBlbBbhyatNyzx5jF42UYZELr7BqQ7cY/UUM3cj2e06mASYJUejoi0kUxlUeqTm2wPG7Fh84mWey58C0g/cyxuLI6IK+Wx/aBbHFgYbOdA8PP3vyDdGukI9AWnCMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780509982; c=relaxed/simple;
	bh=oPHJcJlXWx9fnWI2yBrgmxJNTfinqFPRvlD/PhtE+3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dT3ulJvPjrUq5ID/GxeJaHA7yPAEgjt2idRkBeYZg5XQuk4kgmk2rCf4C5h8y8hpe+oCMqymDAxdhCVefcXHrRQ4tHB6GWPqgEEfa4ehaU97LScOSBnM8NLcfqh+PRmllC05s7ti5DwyguAue6idGQJ6khy5QSRaqzTitYikoEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9VX2xeP; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9VX2xeP"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-660e9ff0587so388037d50.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jun 2026 11:06:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780509980; cv=none;
        d=google.com; s=arc-20240605;
        b=NmpMBPFDPsf/na/zsTr9n7EHhvnYRN+mUBsToO5K9gXlUJ3MuR5H3Z+x/vagoX0VEX
         fbghJffeYzyrR5UKWsGqWWLCJHIdOLNPlutOa3jj8iW6m1tOflHHoc2PRmTEphFSr+Dv
         KRsN79EDvp028rjaBQ5TvGFkm+JUsqyqqRxtKaznHUSFquFzFJmfWkknHBO0grez6D4b
         nleif0XviW1KnGK4UlCzVkftGVKiGlbuKEH8mjXks9xL/FSnFkbKTiV8Yq0QhEPFJzxX
         WEJq1atp2B8BdAJS7lPcswwxw5VMQABR3eB+hTzGK89tMNp9Pu8z253I6/lmS7kKY2HM
         5TSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tHc4VE91lD+iOKEz/3e3QH4j4iXBsJ+UOvDzTAG7O0w=;
        fh=fMr+1pnTtj7ao948Q3NC8sQrRTRqc1TpHtJwlDdilYM=;
        b=cuiAM3x/mnqonc6nO2T4LypxW/RAZZaq8NNDYtRaM06Jx4ur0uc/QWYbyL2zdQOpzE
         jS92aweXAS0PFjdnAA7wz2/SiUg9mQruFOK0uaHp9EnIx6au0KRF3+7gNtBDGYQAp0JR
         33FOc2olRuVPSvRtGlE1wETd3Z4dKbUXxNpe7i0ALX/ttVESgw6CyYeXj4NS8yi2Vj1F
         ED+cWRWgm1XVVrOaPbjbeewqIGAHGMkSipdn/8vIrJncKmKmed3nlBDLXIWCdF2FdiqL
         ZTcYOrDZRrLLeqI99mYDygHLwIQnYuBDV9QiiNYjTSY0NR24DAqdXpXJZEGhulGm38vm
         MUxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780509980; x=1781114780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHc4VE91lD+iOKEz/3e3QH4j4iXBsJ+UOvDzTAG7O0w=;
        b=W9VX2xePmZzpWaNwbbf5w4m0QL8ZzGzv2GbXyZXSmFSayg+YndiXg+2/oAt82PzPJz
         lqu0V/NlLGlzAQYjDgUHNEevl0SahKcdzcer7Si7/dV7ueEA7zWM6cN32TyL+3zcc4FB
         +O4Id7dhB32AdEmb/JlhC9ByYZIQj++SPdrxV9kyJNZHSJkVlVDOOSqGn16BE19iZP0d
         xdX5Js4V0FFaQ42XmblPiXbmElYhcrcvwFpUN7y1hLo5Qdi5tcx1rvX1lmZzEsOncymr
         fjoR8L+r7J8JPMWvFPqrTe1lpm3WHD7v8q90SJGY25o8+3q/c5Ad/U4bblvuK2YisC/n
         6IqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780509980; x=1781114780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tHc4VE91lD+iOKEz/3e3QH4j4iXBsJ+UOvDzTAG7O0w=;
        b=ITwY4AoXYhwC/2O3uPGZTYF4OZrekWL2sMjCZProDbYO3ykrDJ9MCzSQF8C7+IY9xy
         FCEZBcduVOkNG1Zv4C2l2pyomgnkwMelnMtfe2ltXkkkex8d/eaoVDNX5dqcbRFiRn4q
         HJ5wq2c+Ul9es9vb2hWm6ypt9d6jZOli2nOU/OMdyGKoH2W5YLtzAziiq8Hv2A1ERCsx
         WfXAAf1s2NedFTpuL6UFkmHmUlkLtDUClaV7xO1ZF9x9CxMmfkcdVcWznTocV78mHoKY
         6ReT3KrcJk/wVGYayAbK1A54B5HHn7VnRJFrhao0YRiw4lC04mGb+23uSPQC9aaaYNBQ
         Wi4w==
X-Forwarded-Encrypted: i=1; AFNElJ+l2c70sLgd1hjtrnw1xvhSzPLv9kIhIxYN+jb/iDothQGnI6e9/Sqttmg76oyXvcWTItRntM/Jl9zNSB3wQQw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp6EUA97rY09rGMSogmUwiFTEFqg6fxWNbwC+l8L8cLM63M2oL
	EWW3uXjqZpxPNROByhdM+qopI1khbpZizsoQqYCF9QtGeXn7KpiyZt5p+qRoavwll0DvlXZvPtq
	Q1nuSueSHo/45z8WNAsJMpMdrxdgakKo=
X-Gm-Gg: Acq92OFbJc3SwkhOQWfZIzdomsMp+oA3+r79U8AEqY/P8uPoO+BA2lLFb5ozJwzaaJg
	Oq9kAv4xBDpmgvUn7OSCGB8uvk+q+kd+mfsBTzzrkVw0FexTMLBU0qM3gC+sy676Sow9YmWzBQT
	pDmSxZtbe69KIRFH6tKUCs+rykdU8ECWl86oswNDmcIAmLBzkEUhQ5WabYh0cr5miotzExmRpyv
	uazTzT2KizENX55va79DD0I6r8zCv1q2mt0g3f+dJNKJ4EtPh8XbEZWSIePUEk/bGIJsnXusVDs
	AIR1GazRIzN1W4Z9K4n8Fk2m/IYORNht7wU7XbUbvmHb4DPKNGZ4FusA73XTmZM4eXU3rK0seX4
	X9v6L
X-Received: by 2002:a05:690e:1515:b0:658:84f5:3c6f with SMTP id
 956f58d0204a3-660dc592265mr3698991d50.58.1780509980194; Wed, 03 Jun 2026
 11:06:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603143643.2514595-1-johan@kernel.org> <20260603143643.2514595-4-johan@kernel.org>
In-Reply-To: <20260603143643.2514595-4-johan@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 3 Jun 2026 14:06:08 -0400
X-Gm-Features: AVHnY4I7qeJh3_0bF4A64AstA3PsaegUMrcykbj28ibp2b7nDS7F-sCKT8_NtNA
Message-ID: <CABBYNZLr+kLHkjRGOEgyVK7RSfvu0KGjJNrnp5mh-sM66i=5WQ@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND 3/5] Bluetooth: btusb: fix wakeup source leak on
 probe failure
To: Johan Hovold <johan@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johan,

On Wed, Jun 3, 2026 at 10:37=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> Make sure to disable wakeup on probe failure to avoid leaking the wakeup
> source.
>
> Fixes: fd913ef7ce61 ("Bluetooth: btusb: Add out-of-band wakeup support")
> Cc: stable@vger.kernel.org      # 4.11
> Cc: Rajat Jain <rajatja@google.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/bluetooth/btusb.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index d0a83a1ffdf2..622df2fff497 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -4181,7 +4181,7 @@ static int btusb_probe(struct usb_interface *intf,
>         if (id->driver_info & BTUSB_MARVELL && data->oob_wake_irq) {
>                 err =3D marvell_config_oob_wake(hdev);
>                 if (err)
> -                       goto out_free_dev;
> +                       goto err_disable_wakeup;
>         }
>  #endif
>         if (id->driver_info & BTUSB_CW6622)
> @@ -4427,6 +4427,9 @@ static int btusb_probe(struct usb_interface *intf,
>         }
>  err_kill_tx_urbs:
>         usb_kill_anchored_urbs(&data->tx_anchor);
> +err_disable_wakeup:
> +       if (data->oob_wake_irq)
> +               device_init_wakeup(&data->udev->dev, false);
>  out_free_dev:
>         if (data->reset_gpio)
>                 gpiod_put(data->reset_gpio);
> --
> 2.53.0

This seem to trigger a compilation problem according to sashiko:

The goto statement targeting err_disable_wakeup is wrapped in an ifdef
CONFIG_PM block earlier in the function, but this label is defined
unconditionally here.
[]https://sashiko.dev/#/patchset/20260603143643.2514595-1-johan%40kernel.or=
g

--=20
Luiz Augusto von Dentz
