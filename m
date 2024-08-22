Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B831CCB42
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Aug 2024 16:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724343478; cv=none; b=QPxWY4aWFOBPZGQPcxZexu26jRC4I5A6+tyrUkyoY85cICALc9GKJuGcyhTg/LdbaewlZu+K5GDFDH58ippTYixW94V8GfA4pZpZquME+XcgJrbgIIq8SEvo+Vfhlvp497To49iJkjgbsIBDEI+L+hADaAxQ5fyhXS3f85aYjGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724343478; c=relaxed/simple;
	bh=UdS69SHHtL/Z2PrFGHX8onafPC6E1ZVxNrlhG+o9Vd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dq5ksLNd4Rjap16whcMGPPXR0Jv+GZ1FgB5serVyssNcsWMf8TRPwi/nolAhGi+Ap0MqvF/uMtnZU6triatj/78WB0x/r/rs0EEKGN9LtnRlAqn/LoGeKRsHXVNp7+wZQDEOHl6QRDrfGq3xe2U11Vpo42Aga8srbOUBV91GMDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyY8EUrD; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyY8EUrD"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f15790b472so10170351fa.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Aug 2024 09:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724343475; x=1724948275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lp4mOaMW/pf29YROwITKqZLopEXQJwUOPOrliRSH2ZY=;
        b=JyY8EUrDqKmOoLMCLlterA/tgY4KbDGZViiFNP/WeAGI8MS5WoXwn75BTuWeW8xFLz
         uA79jYLLuki8nHSR7A6miNc2Sau1w7joYRDm1MrHExQ2xDXQArH73W5vJFI9vbqf33jn
         Mv0koNcVuv21bvdaR0plKKjy0BW3jqhHmKxTeWpa4Q9LgWtSLn3K8V/nQwhY6OaplSFw
         wz7SNsKv+9KkBQtvMZE3VyMX+dmgKORragZxPOpta7YHFewJK5XfxjvuMB+Oc7jFSh8i
         ErKlfEZJ9bo3LGpcvxUifgUFM/FGjP34gPUd8nD+sSRJyK4NsDs6jo0eGFDIr4rlynHi
         Ro5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724343475; x=1724948275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lp4mOaMW/pf29YROwITKqZLopEXQJwUOPOrliRSH2ZY=;
        b=B7BIaUwHKaz2TvEnRQj/+9fb6DdI5zZ62mQxx2rJ+fVkdmgV1JqMavcK8rqVP7WCwK
         qELB7Xi3/FiT2G+N1CiTS/xPHsv6I2EDww08cYZgDjGLtU2Z3agFRx3nbURlCKhyeyKi
         9dW30b4Delj1Wo8XoDjAWNI+uIERtwkAvZDu+0UbKnjpjdqwNjbsQYP9E7i6lHNBJMcI
         wCIXAV5HdUWZbOIT+f0dXQOazmk+jIQ0lIrCe/zzpDJ3hdzVZaTaAgwPY2Hz93M3ulSy
         1NLdgbFFsUcwtkD0IlbfKNrcNWDBuIpPtRK35T+SKd/gT9EHVuwfK3zNmhuEYAOUJ8xq
         3PRg==
X-Gm-Message-State: AOJu0YxW48hnRrEuDu/ze2pAZPUzPRRXtvYn9yawJf9gUR/85MXplvEI
	qtNRsRcE1al1mxCeFtJZFPqK4mIfvDMnMuSDpoKAAYRBU+g1UKwJdm5or/JEDwXjwIeVLoHDPxO
	zw9FIz9I4xQE+rbdD633FYeFQOPI=
X-Google-Smtp-Source: AGHT+IEz0Q9poSlhWSXyRuTPbSOq1IMuejDmxkLRqtduae/kvC3vZnFHWJOGJAVr5BTqGZkhEyyt97bgSSDf5qVfLB4=
X-Received: by 2002:a2e:be9e:0:b0:2ef:c281:54f7 with SMTP id
 38308e7fff4ca-2f3f893f342mr50536901fa.37.1724343474427; Thu, 22 Aug 2024
 09:17:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822113226.223790-1-kupper.benedek@gmail.com>
In-Reply-To: <20240822113226.223790-1-kupper.benedek@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 22 Aug 2024 12:17:42 -0400
Message-ID: <CABBYNZJQvtOHiApjO-APPr4T459iu-1nxtvRnBkVAD0_iOEkCg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gatt-client: allow AcquireNotify when
 characteristic has indicate flag
To: Benedek Kupper <kupper.benedek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, 
	Benedek Kupper <benedek.kupper@epitome.inc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Benedek,

On Thu, Aug 22, 2024 at 7:32=E2=80=AFAM Benedek Kupper <kupper.benedek@gmai=
l.com> wrote:
>
> From: Benedek Kupper <benedek.kupper@epitome.inc>
>
> StartNotify / StopNotify already correctly allows usage when the
> characteristic indicate is present (simplify this check though),
> apply the same to AcquireNotify.
> ---
>  src/gatt-client.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/src/gatt-client.c b/src/gatt-client.c
> index 8d83a9577..a67e04eee 100644
> --- a/src/gatt-client.c
> +++ b/src/gatt-client.c
> @@ -1556,7 +1556,8 @@ static DBusMessage *characteristic_acquire_notify(D=
BusConnection *conn,
>         if (!queue_isempty(chrc->notify_clients))
>                 return btd_error_in_progress(msg);
>
> -       if (!(chrc->props & BT_GATT_CHRC_PROP_NOTIFY))
> +       if (!(chrc->props & (BT_GATT_CHRC_PROP_NOTIFY |
> +                       BT_GATT_CHRC_PROP_INDICATE)))
>                 return btd_error_not_supported(msg);
>
>         client =3D notify_client_create(chrc, sender);
> @@ -1601,8 +1602,8 @@ static DBusMessage *characteristic_start_notify(DBu=
sConnection *conn,
>         if (chrc->notify_io)
>                 return btd_error_not_permitted(msg, "Notify acquired");
>
> -       if (!(chrc->props & BT_GATT_CHRC_PROP_NOTIFY ||
> -                               chrc->props & BT_GATT_CHRC_PROP_INDICATE)=
)
> +       if (!(chrc->props & (BT_GATT_CHRC_PROP_NOTIFY |
> +                               BT_GATT_CHRC_PROP_INDICATE)))
>                 return btd_error_not_supported(msg);

Afaik this is working according to the documentation:

'Only works with characteristic that has NotifyAcquired property which
relies on "notify" Flag and no other client have called
StartNotify().'

https://github.com/bluez/bluez/blob/master/doc/org.bluez.GattCharacteristic=
.rst#fd-uint16-acquirenotifydict-options-optional[1]

So if we want it to work with Indication as well then we need to
change the documentation to reflect these changes, indication does
mean one need to confirm the reception which is something that would
require some work if done via fd, but in the other hand I think we are
auto confirming in case of D-Bus since that is using a D-Bus signals
so perhaps it would be fine to do the same with fd as well.

>         /* Each client can only have one active notify session. */
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
