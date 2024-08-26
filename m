Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD6B40855
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Aug 2024 13:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724679838; cv=none; b=uzaW+NlXNrPNR4THwDNEjQi28YTwe3Xz3KLhOrEw0k63+TrGbVLlAc5saOdZ+KJ8UjcvjoA8E82qHcCnA0UT/KIr0qp1vaKnldvSf1jg/GksDTbaFuHtcxKr2Gkq+EEs79AwugOkAJcR44yP4r8FFtKl6WnpVq/5ol7tOTEPNjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724679838; c=relaxed/simple;
	bh=HBywNm/HSGYYBRZQNMO808fqDYbuwhGAVtI93G6RzNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e0MJIijg3A11JrBdCfQBdVnnUGBbfd0vj6O2BqttR6PuNr4rSmzKyz1m5eyOwRzuFyciUx38MGwAZWbT+gs/bSlX1AREdQUDu5ayeKvw3ouMqn8SZS3UCGH4pt9jD2Qq0FJPRlePeY0PT1YZOme8nFJf/UTWX6KYOK4rnY6jdWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9Lggd+K; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9Lggd+K"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f4f8742138so33268691fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Aug 2024 06:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724679835; x=1725284635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQ2JrwrskauDm68y7rjkwhT0z4WWBEirZUiQKuAy2oY=;
        b=h9Lggd+Kv4/fUEUdEKQG2pDY7blbs6SyL+Ea29pwx4fgqL2+aLzpuoAlbc3zRiBLmO
         B335WAHIsdqaupYXbmbRWskvwMPo4qKYMBerTg6VRR0FDWHLaU7MtpY4q82YYcKzjWMH
         HYwtwCRICKmBJ445chfUANaMt4J0+B8N+yMBUFA5fzazar9QQ1sLusaKLCBR9HxsgH1q
         V0nVizE45RTFq9VLmVgzaloSwQXsfnBIu770oflQ6lPNqwK1DwJWaNGPmjVwVxja/23V
         7cCK4v4wLKfKaD0rqQQU6emc9d4tvC5YZVH7/YJnKMBOEZdjHS6BdvE8b/glxe6f5qYm
         /qDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724679835; x=1725284635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQ2JrwrskauDm68y7rjkwhT0z4WWBEirZUiQKuAy2oY=;
        b=ZM7/b3EOqrlXD6i6yn0d3owwD0zYmcITWMGtC9HBDy8NK7+9zYdWirhxaY/gH1CgI3
         eHgGhCxslBqTFZxsWyGf3q971VGYgaA2AMVt0p3j03rSZ3mGNpg5iP4OCJnWsj/erzqZ
         3eS95ckCiN10pEzTDzbZLChL1Qn6m5j+LUnPA4RsT1sweblYIhTHIYEjGKuIExxZwzkt
         empiaOJWfIZ99r61rf/GSh3E9YWMazNtB2R78AdurOCD4pmHSlSF65tsirisjcaZJAom
         kmRisKXYwDH9rAb+Cckw/TRssxjzAMOoiTu+zIg4kt3oG6iCv3WLYTDK7J4/FhlHhcEu
         hppw==
X-Gm-Message-State: AOJu0YyjJdy7fwKLSrT7i4+XSLZktPZXkY/XJ17CskcsxZFiVK90Z9W9
	FkscONL4aHed9XjUQEGhM6WZnOE+7k5JPfH5jIl8WWK0l0+0BV2I0+A+0hYCVoOhJNljGH3Y6tp
	mkTIkkVQ6xHf4mDKSAQZGUk2/XmASknRQ
X-Google-Smtp-Source: AGHT+IE8OQfFqNNd/NVm5/FVGFUEKaQtCFcONUF9qDqX5OHn1N3AN7V/U5T8Ltjcv/g9ZazZS3ID1RpBDPE14TVjjWU=
X-Received: by 2002:a2e:a99d:0:b0:2ef:2bb4:45d with SMTP id
 38308e7fff4ca-2f4f48edae5mr77903211fa.9.1724679833920; Mon, 26 Aug 2024
 06:43:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826090044.560142-1-quic_chejiang@quicinc.com>
In-Reply-To: <20240826090044.560142-1-quic_chejiang@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 26 Aug 2024 09:43:41 -0400
Message-ID: <CABBYNZLOawJZgtm89QKBpbMdS1_NgXOzHgh2ftBzPyNRKfx+Sw@mail.gmail.com>
Subject: Re: [PATCH v2] adapter: Cancel the service authorization when remote
 is disconnected
To: Cheng Jiang <quic_chejiang@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cheng,

On Mon, Aug 26, 2024 at 5:01=E2=80=AFAM Cheng Jiang <quic_chejiang@quicinc.=
com> wrote:
>
> If the remote device drops the connection before DUT confirm the
> service authorization, the DUT still must wait for service
> authorization timeout before processing future request.
>
> Cancel the service authorization request when connection is dropped.
> ---
>  src/adapter.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 245de4456..3ad000425 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -8502,6 +8502,25 @@ static void disconnect_notify(struct btd_device *d=
ev, uint8_t reason)
>         }
>  }
>
> +static void adapter_cancel_service_auth(struct btd_adapter *adapter,
> +                                       struct btd_device *device)
> +{
> +       struct service_auth *auth;
> +       GList *l;
> +
> +       auth =3D NULL;
> +       for (l =3D adapter->auths->head; l !=3D NULL; l =3D l->next) {
> +               auth =3D l->data;
> +               if (auth->device =3D=3D device)
> +                       break;
> +       }
> +       if (auth !=3D NULL) {
> +               DBG("Cancel pending auth: %s", auth->uuid);
> +               g_queue_remove(auth->adapter->auths, auth);
> +               service_auth_cancel(auth);
> +       }
> +}
> +
>  static void dev_disconnected(struct btd_adapter *adapter,
>                                         const struct mgmt_addr_info *addr=
,
>                                         uint8_t reason)
> @@ -8516,6 +8535,7 @@ static void dev_disconnected(struct btd_adapter *ad=
apter,
>         device =3D btd_adapter_find_device(adapter, &addr->bdaddr, addr->=
type);
>         if (device) {
>                 adapter_remove_connection(adapter, device, addr->type);
> +               adapter_cancel_service_auth(adapter, device);

This shall probably be placed together with
device_cancel_authentication in adapter_remove_connection but we need
to track in what bearer the authorization is for and remove all
authorization requests like in btd_adapter_remove_device:

    l =3D adapter->auths->head;
    while (l !=3D NULL) {
        struct service_auth *auth =3D l->data;
        GList *next =3D g_list_next(l);

        if (auth->device !=3D dev) {
            l =3D next;
            continue;
        }

        g_queue_delete_link(adapter->auths, l);
        l =3D next;

        service_auth_cancel(auth);
   }

I'd probably move the above code to a helper function so it can be
called from different places, as for doing this on a per bearer basis
would probably need to add bearer information to btd_service but I
guess that can be treated separately.


>                 disconnect_notify(device, reason);
>         }
>
> --
> 2.25.1
>
>


--=20
Luiz Augusto von Dentz
