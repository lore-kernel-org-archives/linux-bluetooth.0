Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC8314A0A7
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Mar 2024 16:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711558253; cv=none; b=KCW9hzotOoUYhhX+EEn1lol+DKl/yewI8WVI1XRcHUFNcAsFZQIdN9psvlxAIm6+AFmQsneq5aoT4x0q/vc0DoBE52DvgR1rn5cdmqNuOAi8rHhZOhuSDiK/quQEurwJ2vuG9r76CzfxDo6P9HD6+d9vBh2P83YLQ+j87necWeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711558253; c=relaxed/simple;
	bh=USme3UVHvKmzhVoJ76NmkrnMMe6lNR7IbHLqJMSdTT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fVym5okB57Wy/ilSmR7ktQnDadOLibBI0XiTzH3WOIGZ8fT08Y6pdznf0V4ZYNj09CudMgfqaZyv++Evpm9rfq3dN1maNLE1MPApBhH+H4T2Ck2mkqAvsOcMHt3t/KH+CK9H9pBH0ESTZHT/fRZQTxzunpmQdyngBkRQa9CuGtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSgA6Z1r; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSgA6Z1r"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-515ac73c516so972345e87.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Mar 2024 09:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711558250; x=1712163050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgydytnPkiCLeCeY7I/T/Kt0r5gMHwX0hnlJtbgxaEg=;
        b=YSgA6Z1rrSl2DEf5eH6dXbN6RI5HFYZ7AUbGYwGLhCsruZcf1ifZXRtHBthPY6qUqP
         aks/EKumLdDEAkYlN75Afy8YfkUxWnYLFP58FEqjkO33wfmLM1XATChnjtaHuk6V+kPI
         OVunFIGci6/P7U7TBvWa3fr/Wz335+zcSWFbh9nh2ASiiR2TbGAbKxaMFHgXmdhO+yA6
         AYHcqwzSLcUYbQRddBmNsZVO0ZjL2F44Fci1iOor+i+1Z2bcB3yyNop5ghihspDiQHkB
         KoQmSzSJw1oEqtAXBMSMw6mi1fEn3vyFzInCJNdb4JukNuWIdul97dYXsmGdSEzANXTZ
         gSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711558250; x=1712163050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sgydytnPkiCLeCeY7I/T/Kt0r5gMHwX0hnlJtbgxaEg=;
        b=obYCcBZVjKk1Ddir+Vua0jTgH7OK7r11X9YPKTA64FkwMZpjWnGqYbY+iLsbLqtpYV
         Puj8xHleFfEGNX9TAweAeH2PYSWW0gxdi2UG91X3U8HcUrr+PrukPlU34VGkoOIWlBOC
         yDOT2Or40AyP5f205JB7TmiRiWYJhkK/ly/AG1U1uIIeDZNI0/Oc4tdqiPWXx38DkeUE
         /Kl+pWljtI7jT+PR4fK5jgB/Bu32zoG8FC8bQc7HqvFLUlwbBcs9Uia2vRxQUc7VH8Fy
         qs5ZJgVHa7S2dsYJdKJZyF26dyYhKMYN8BpkFxXJR8bD0A7z7b9RxREiF5DZCMKY2zat
         2lVw==
X-Gm-Message-State: AOJu0YzXw/EUic6sv7uABeilSgZQwivxg6EEZZleYOYKfmqctO1w8JoZ
	PAkpYkGLJzwNanzthmKOp6sCdGfhTJz5KGG7J0p4Qw/oMvH3lUDoKLoOOfErzBGZsXVlcGLIzaQ
	c3bNcIaIMxcQB7ILJ5rZB+uROoqs=
X-Google-Smtp-Source: AGHT+IEVZZaxMCWjs2oqXIMp3BhF4HPsWHojG5eYZtj2LESaQmmj4P8DPAsr0ZNHDlSZDNnT20mC2CieZsLpfkCc2nA=
X-Received: by 2002:a05:651c:1a27:b0:2d4:6d7b:4b68 with SMTP id
 by39-20020a05651c1a2700b002d46d7b4b68mr75238ljb.6.1711558249585; Wed, 27 Mar
 2024 09:50:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327161019.3078-1-iulia.tanasescu@nxp.com> <20240327161019.3078-3-iulia.tanasescu@nxp.com>
In-Reply-To: <20240327161019.3078-3-iulia.tanasescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 27 Mar 2024 12:50:35 -0400
Message-ID: <CABBYNZJZQf8uvyNzHiqOo4UqwdYb+OEyBZvt1EHvEd3h7t1CMQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] iso-tester: Separate iso_defer_accept into
 dedicated functions
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com, 
	mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com, 
	vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com, 
	Pauli Virtanen <pav@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Iulia,

On Wed, Mar 27, 2024 at 12:10=E2=80=AFPM Iulia Tanasescu
<iulia.tanasescu@nxp.com> wrote:
>
> This separates the iso_defer_accept function into dedicated ones for
> unicast/broadcast, since the flow is different for each scenario:
> For unicast, POLLOUT is checked on socket before calling read and
> adding a G_IO_OUT watch. Checking for POLLOUT is not necessary for
> broadcast, since currently this event is never generated on the
> child socket. Instead, G_IO_IN is generated after BIG sync is
> established and a BIS socket is ready to be accepted.

@Pauli Virtanen Is this inline with TX Timestamping though? Or that
only cares for POLLERR?

Also it would be great to know what are the plans of PW with respect
to broadcast, I was thinking something like this:

1. Broadcast Source: Have some dedicated card that can be configured
via configuration file or a dedicated app that performs the
configuration which can then select what streams shall be broadcasted,
since broadcasting things like system audio notifications probably
doesn't make much sense.
2. Broadcast Sink: This shall be a little bit easier since we now
enumerate the BASE found over the air, so it should work very closely
to unicast, but perhaps you may also want to start a scan session
while the card selection dialog is open so the user don't need to use
yet another app to trigger it, or perhaps this should really be done
at Bluetooth system settings that way PW don't show any Broadcast Sink
until the user selects it at Bluetooth APP, this way we don't clutter
PW interface with unsynchronized Broadcast Sinks. Note that in the
future we are going to remove the step of creating a MediaEndpoint for
Sinks since they are already configured over the air they shall appear
as MediaTransports ready to be Acquired.

> ---
>  tools/iso-tester.c | 45 +++++++++++++++++++++++++++++++++++----------
>  1 file changed, 35 insertions(+), 10 deletions(-)
>
> diff --git a/tools/iso-tester.c b/tools/iso-tester.c
> index 1864b9e9d..60afef301 100644
> --- a/tools/iso-tester.c
> +++ b/tools/iso-tester.c
> @@ -4,7 +4,7 @@
>   *  BlueZ - Bluetooth protocol stack for Linux
>   *
>   *  Copyright (C) 2022  Intel Corporation.
> - *  Copyright 2023 NXP
> + *  Copyright 2023-2024 NXP
>   *
>   */
>
> @@ -489,6 +489,8 @@ struct iso_client_data {
>         bool pa_bind;
>  };
>
> +typedef bool (*iso_defer_accept_t)(struct test_data *data, GIOChannel *i=
o);
> +
>  static void mgmt_debug(const char *str, void *user_data)
>  {
>         const char *prefix =3D user_data;
> @@ -2582,11 +2584,10 @@ static void setup_listen(struct test_data *data, =
uint8_t num, GIOFunc func)
>         }
>  }
>
> -static bool iso_defer_accept(struct test_data *data, GIOChannel *io)
> +static bool iso_defer_accept_bcast(struct test_data *data, GIOChannel *i=
o)
>  {
>         int sk;
>         char c;
> -       struct pollfd pfd;
>         const struct iso_client_data *isodata =3D data->test_data;
>         struct sockaddr_iso *addr =3D NULL;
>
> @@ -2610,6 +2611,31 @@ static bool iso_defer_accept(struct test_data *dat=
a, GIOChannel *io)
>                 free(addr);
>         }
>
> +       if (read(sk, &c, 1) < 0) {
> +               tester_warn("read: %s (%d)", strerror(errno), errno);
> +               return false;
> +       }
> +
> +       tester_print("Accept deferred setup");
> +
> +       data->io_queue =3D queue_new();
> +       if (data->io_queue)
> +               queue_push_tail(data->io_queue, io);
> +
> +       data->io_id[0] =3D g_io_add_watch(io, G_IO_IN,
> +                               iso_accept_cb, NULL);
> +
> +       return true;
> +}
> +
> +static bool iso_defer_accept_ucast(struct test_data *data, GIOChannel *i=
o)
> +{
> +       int sk;
> +       char c;
> +       struct pollfd pfd;
> +
> +       sk =3D g_io_channel_unix_get_fd(io);
> +
>         memset(&pfd, 0, sizeof(pfd));
>         pfd.fd =3D sk;
>         pfd.events =3D POLLOUT;
> @@ -2632,12 +2658,8 @@ static bool iso_defer_accept(struct test_data *dat=
a, GIOChannel *io)
>         if (data->io_queue)
>                 queue_push_tail(data->io_queue, io);
>
> -       if (isodata->bcast)
> -               data->io_id[0] =3D g_io_add_watch(io, G_IO_IN,
> -                                       iso_accept_cb, NULL);
> -       else
> -               data->io_id[0] =3D g_io_add_watch(io, G_IO_OUT,
> -                                       iso_connect_cb, NULL);
> +       data->io_id[0] =3D g_io_add_watch(io, G_IO_OUT,
> +                               iso_connect_cb, NULL);
>
>         return true;
>  }
> @@ -2648,6 +2670,9 @@ static gboolean iso_accept_cb(GIOChannel *io, GIOCo=
ndition cond,
>         struct test_data *data =3D tester_get_data();
>         const struct iso_client_data *isodata =3D data->test_data;
>         int sk, new_sk;
> +       iso_defer_accept_t iso_accept =3D isodata->bcast ?
> +                                               iso_defer_accept_bcast :
> +                                               iso_defer_accept_ucast;
>
>         data->io_id[0] =3D 0;
>
> @@ -2676,7 +2701,7 @@ static gboolean iso_accept_cb(GIOChannel *io, GIOCo=
ndition cond,
>                                 return false;
>                 }
>
> -               if (!iso_defer_accept(data, io)) {
> +               if (!iso_accept(data, io)) {
>                         tester_warn("Unable to accept deferred setup");
>                         tester_test_failed();
>                 }
> --
> 2.39.2
>


--=20
Luiz Augusto von Dentz
