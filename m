Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48052206059
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Oct 2024 12:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729080275; cv=none; b=r6q+9TkXC70XY71J49EOWXbw2WqEesJr0lRIe5fO3Pc05TUU9kMFYh0odXLvkHa/bmtHv6f0gxRhE8Dyyx9o552tRG13e0JMFTi57IgwxEFtyZxMYE9JLHP3C67usUJXYHTSlapU9i71l7I5mZs2TEfu3HMZvFGnNxihqDhlaRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729080275; c=relaxed/simple;
	bh=e4B9W5YZWAeL2lSGydllhfk65MFqYLAnvYVXg0a/Y6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nxGIc+owdKvAV87jt7i8PhCRsHi4j2aMJMndiH+uYjFi/T2wc55pn6cHHZk7gStG6j4ayLN1TQoS+ur6bJ4BvQO7mo2LKFt6CIPyGJk3DexJevkW7dwHALWDmYCbb8/OZLugBNKj5tJJwS4xZkqHONiUz6uYkiDtUglqnalof5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gG3+POpe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gG3+POpe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17ABC4CED1
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Oct 2024 12:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729080274;
	bh=e4B9W5YZWAeL2lSGydllhfk65MFqYLAnvYVXg0a/Y6o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gG3+POpet/uh52H2PMS7p+Qr6UzAwNtneYuVuEST2EImUnWB27PYnn2t0gtcZ1yGB
	 mRTEwptlyfUr6s1Xd8OqwiWJvfXRRPJ8opFVouX9Xis4dvfA4zt7RdekUl+r7gqbtK
	 MZ7l6eDMFWEL8wp93KfJ3q9qGL8WYSoMDMO4llJhfkqTEbt1JjXBCOe0HQ3joPYeKA
	 TbnMC+KHSVungiyfcG6ynKPkhqqUwXXljRFeIXgc+02mPOVk5itlmtAMGF87+k20YB
	 PDMqm7JdB77pY44Y5AZpjcXiDguqtXuNZfa8kPQ0aQJ8m3/dPt4ZRWBcVcTUayd/fL
	 77iwxxs2/gCGA==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-288642376bcso2959787fac.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Oct 2024 05:04:34 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy6/AIa/zvmoPVcYh6CynGhFp6m9h+Yq1TCtAKQUQsmDRS/wbUT
	Q/y3ifrsMpiQewjgFnjLsVdDZjiN0y9LtGsh6am5+/x8PKyFoTWKft35fhV2iFrQxDE73bgB1Va
	iLTuw71wOIsXmR/Ei9BZneHLcySY=
X-Google-Smtp-Source: AGHT+IHq6P9q9n/Du6i4s+BJMxoQiOBFAx5yoEfFpRBCGczSxOKoJmira3tE0pgTTwuJ2DLtOeIzbarvhrANaflsAdY=
X-Received: by 2002:a05:6870:89a4:b0:286:f9c3:ed78 with SMTP id
 586e51a60fabf-28887477421mr8952706fac.36.1729080274035; Wed, 16 Oct 2024
 05:04:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014202326.381559-1-luiz.dentz@gmail.com>
In-Reply-To: <20241014202326.381559-1-luiz.dentz@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 16 Oct 2024 14:04:22 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0it7=wbAfNZxFQw2tia4W2FfA_sAnL1nvu8aKmATbWOPg@mail.gmail.com>
Message-ID: <CAJZ5v0it7=wbAfNZxFQw2tia4W2FfA_sAnL1nvu8aKmATbWOPg@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: btusb: Fix not being able to reconnect
 after suspend
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Kenneth Crudup <kenny@panix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 10:24=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Calls to hci_suspend_dev assumes the system-suspend which doesn't work
> well when just the device is being suspended because wakeup flag is only
> set for remote devices that can wakeup the system.
>
> Reported-by: Rafael J. Wysocki <rafael@kernel.org>

First of all, the patch works here, so

Tested-by: Rafael J. Wysocki <rafael@kernel.org>

> Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
> Reported-by: Kenneth Crudup <kenny@panix.com>
> Fixes: 81b3e33bb054 ("Bluetooth: btusb: Don't fail external suspend reque=
sts")

However, this is not the commit ID referred to in my report, as
already mentioned by Paul.

> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  drivers/bluetooth/btusb.c | 14 --------------
>  1 file changed, 14 deletions(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index d14b941bfde8..c0b6ef8ee5da 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -4075,7 +4075,6 @@ static void btusb_disconnect(struct usb_interface *=
intf)
>  static int btusb_suspend(struct usb_interface *intf, pm_message_t messag=
e)
>  {
>         struct btusb_data *data =3D usb_get_intfdata(intf);
> -       int err;
>
>         BT_DBG("intf %p", intf);
>
> @@ -4088,16 +4087,6 @@ static int btusb_suspend(struct usb_interface *int=
f, pm_message_t message)
>         if (data->suspend_count++)
>                 return 0;
>
> -       /* Notify Host stack to suspend; this has to be done before stopp=
ing
> -        * the traffic since the hci_suspend_dev itself may generate some
> -        * traffic.
> -        */
> -       err =3D hci_suspend_dev(data->hdev);
> -       if (err) {
> -               data->suspend_count--;
> -               return err;
> -       }
> -
>         spin_lock_irq(&data->txlock);
>         if (!(PMSG_IS_AUTO(message) && data->tx_in_flight)) {
>                 set_bit(BTUSB_SUSPENDING, &data->flags);
> @@ -4105,7 +4094,6 @@ static int btusb_suspend(struct usb_interface *intf=
, pm_message_t message)
>         } else {
>                 spin_unlock_irq(&data->txlock);
>                 data->suspend_count--;
> -               hci_resume_dev(data->hdev);
>                 return -EBUSY;
>         }
>
> @@ -4226,8 +4214,6 @@ static int btusb_resume(struct usb_interface *intf)
>         spin_unlock_irq(&data->txlock);
>         schedule_work(&data->work);
>
> -       hci_resume_dev(data->hdev);
> -
>         return 0;
>
>  failed:
> --
> 2.47.0
>
