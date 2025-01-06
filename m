Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FC71C69D;
	Mon,  6 Jan 2025 20:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736197099; cv=none; b=qwM2uh65Hcg+yeIUIRlf1dJc7mSlW6V9+Ft2RvKUaCvmZFh4L0KZ+yp/8QcErFPwEW4rwWhbt0AidkUx7zY3EupLhf1BgtvU3gPPhZ9JIPVwlhpx3oB0GQcP3rNJzysAX0/vfGcsFJHS9KAtyKYPVFxAfzg5EwUQH4jK7eHFQmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736197099; c=relaxed/simple;
	bh=g1JExpdKvL8BIW6V0XCWerzvAYkMBqLYUbI0voD9zbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CAthBYz/arBCtAKWAnORIl+Q37As/ypoy96i79yzZhkr567Y4sNgD0LMu5XKA3JTVw5H9gKVBz48tbq8Th/L4XdSQNjb88/9sJF1/dBTqOW6RH+lgbaimdJWxmOwpxcQmYQoLljmKvw52QWNjk3ZuWGxhLjRckRj4JeOAk0x9Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDbRIXat; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDbRIXat"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-304d9a1f198so33766461fa.0;
        Mon, 06 Jan 2025 12:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736197096; x=1736801896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvLSlBy49U9+Y5+necr52/D9WG5pRnAPnud0tjMich4=;
        b=CDbRIXatym6rskLGt/9k4j2KjRr84GdjYSEsTuc5gUaI1o4gK8pXhOd67BXX5aUNDj
         yDyYaci+3slF2eFi1FKV7KKqw4L1xf4KIpQ0IoujgcodJL2Qu+3lc+swElC9NLP/GiNe
         5xFfrz5oSL+uoqhKpnN2zz5juxZKrUQ/ob40Oo1hZwS8gIzAX0a9MWGSivdYBpDeGv9G
         /w/tlQft2rZyZ3BPEFlkT8g9LNU51OsECSsOE60T7NXkt1TIHpFq1Vc77Rm2FJtr0ILI
         ujO3lkHbkZ6JWC+I/NMF/d4FYMUjReqeQn8CNQplt48fkWwpTwH8Sj5SwLTmYXmNVaq0
         GeHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736197096; x=1736801896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lvLSlBy49U9+Y5+necr52/D9WG5pRnAPnud0tjMich4=;
        b=EogqEyf3+6lYMEFemKWu/RUITyrjsvSVa0hiZe35dN2+56LHm4pGe06rs6ctCSbcqY
         7Ec24RRM3LTN3x7LBhRkvqXHZyErRKwfAvhHbwMdhUKdBtxICIlboR4IXKs9UGTVLHQW
         ID+whN5uzWfWA77XqluD9O/cCjLixe1ygkZMEdxVIdGKWJZfR7lWJwMTVSUpm6SWv8th
         Swk3aETJ7i43LJi4WRqAAY2YGXNGSqj1asofdijnTZnJQbtMfvWvDnAPCkR7DEd/k8mf
         iCE6ve36BQ/RDQGGmBXJbjAwbGUAqDdNv/EWYBh+c9WKHpyj7DIhqx6vKoOeThOzpPB5
         89WQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQA2BWyRaP77Jp/YdvIxSCN4dj8W6oODaaVeDwXZ8/Rdla7XQ6c58T695QsNrb6nbfmjldAhTuH7AnfXNf@vger.kernel.org, AJvYcCWlSwiExWsPiXyygXf1iZMAneMEHf0xKAN9RSp68jr8PYOrWo6cZJLxySM2D7pUmplMG3p1S+ekh6mTYyB6kdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmufFBw4r4gIE/sUuVKAQkf1phyixYnzrevc5MWtPuXf4mTrRa
	2Yvv+Azj75KF2OVaU22+ikKs8BN6UMu1X9QwQtxBv6JalrL4Z95RuQjnfUgZuk9qyVJJtJ2GMxS
	HxOTsZmsCRoEDNoulxhtrN5OWP/qSy58s
X-Gm-Gg: ASbGnct0po3EpoQ3lJsjBcJYyM4+AU9TGL2StD0lj4htIZ3MpKXXAxJN8E/bUDv+Orf
	CQlvTp/TPUZ4l0Ldf3cUlCy2axXoZrxFE39U3mTw=
X-Google-Smtp-Source: AGHT+IFADW4wfH7t6oRz+Ch47Ka6A7UY87FBku9N1Z9wCNB9+Y4X1gE152knTkaojXdLwIyr0cUUFuOEn3Esj7aSe+0=
X-Received: by 2002:a05:651c:60d:b0:300:de99:fcc7 with SMTP id
 38308e7fff4ca-30468630647mr150383661fa.36.1736197096034; Mon, 06 Jan 2025
 12:58:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241223094411.47496-1-en-wei.wu@canonical.com>
In-Reply-To: <20241223094411.47496-1-en-wei.wu@canonical.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 6 Jan 2025 15:58:03 -0500
Message-ID: <CABBYNZJJdCw=iP3ketY_fDt8HcKe6mAo9LFZY9i5oSxnF=HZ1Q@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btusb: Add NULL check for data in btusb_suspend
To: En-Wei Wu <en-wei.wu@canonical.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Markus.Elfring@web.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi En-Wei,

On Mon, Dec 23, 2024 at 4:44=E2=80=AFAM En-Wei Wu <en-wei.wu@canonical.com>=
 wrote:
>
> When performing warm boot tests with an MT7920 device, we encounter
> NULL pointer dereferences with failure rate 5/30. The crash occurs
> during device suspend when btusb attempts to access data->hdev where
> data is NULL. This may happen due to a race condition between PM suspend
> and device disconnect. The root cause needs further investigation.

Ok, so we expect this to be backported or not? Because if you do then
we need to fix its root cause and not add a workaround.

>
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> Workqueue: pm pm_runtime_work
> RIP: 0010:btusb_suspend+0x1d/0x1d0 [btusb]

This looks like probe hasn't finished yet, btusb_probe is still
pending/executing and usb_set_infdata hasn't been performed, but
suspend is called before that completes (?).

> Add a NULL check for data and return -ENODEV in this case to prevent
> the NULL pointer dereference. This indicates that the device is no
> longer available, which is appropriate when the driver's private data
> is missing.

Once we find the root cause then we need the Fixes tag to point out
where this regression was introduced.

> Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
> ---
> Changes in v2:
> - Change "dereference" to "dereferences" in commit message
> - Re-flow commit message lines to use more characters per line
>
>  drivers/bluetooth/btusb.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 279fe6c115fa..a0461528548b 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -4096,6 +4096,9 @@ static int btusb_suspend(struct usb_interface *intf=
, pm_message_t message)
>
>         BT_DBG("intf %p", intf);
>
> +       if (!data)
> +               return -ENODEV;
> +
>         /* Don't auto-suspend if there are connections; external suspend =
calls
>          * shall never fail.
>          */
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz
