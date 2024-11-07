Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935DE322E
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Nov 2024 23:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731020523; cv=none; b=UyWB8LJLxL8cD02zMYYDgvmfxHEK4z/k8BEaKs4ZSZBl7xAJwKK4rsvUa1ZsNiOyYUnMjUxh676xakD9yqrcOEHJDT+bdwuColNPSbWBNt6V8EWWbz4e1QwJ1eMaTdUd2DwiPm+3hFbk19mAB+l2o+osI0cf0+wCs4AOCeNBtVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731020523; c=relaxed/simple;
	bh=LQ0mg6YjguzLM60NE9mZ+WfU9OZLEqfCwlIRQ4uhbOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QX6KQ+fR/IOzjduJ0uiHeAkUYjQ2nmCpY4cHCrfO1Kw2hMNitFw3twy4cGD2gFzApqn+HNsjgHGKlpDANAhBD0yOS4ierh0Fkg4E74RLTAPp8j3j5dVWLerNtdH9EkPMmfTmZZzZ+OTEXlW+NrfS1S8JzDZjZYq6Z7JMnPUckcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIdeNSV0; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIdeNSV0"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb5740a03bso14792591fa.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Nov 2024 15:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731020518; x=1731625318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIIG8ueOFGhrKJrepkr0QZKlfIEk5/IaUQUlcugEF80=;
        b=PIdeNSV0/itJmpF34MhYSyIchynijUD+tsSEd2hZFiWytLupNii93YNtWkWA/gTny2
         2HeGBTmpsGZMrRdeHhU4h+QbaRUkzfoRQ3TGP9hBQOBJHwfRGQnw6JSq/N7pOcSRyvvm
         VeMnqDiCHxwwhpjpedy802W0Z5qHWSAB1kZ6DxOUONVY0FnURBIFfcnY6hopwMuDyZHt
         9ZhltEp7S9LiO594uuuWwQDMdI2eNVQ3i5MXJE8ElAGPOSWXlRsRXB0bFm997KcOU1ga
         9FOvGmei82M5CjdxosxxHWXFQ9/+vwruMmcMrr92CqR/mKJAVlFybkzAF6hTLl0XrNT4
         B9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731020518; x=1731625318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sIIG8ueOFGhrKJrepkr0QZKlfIEk5/IaUQUlcugEF80=;
        b=JAZBct+HHy5jFhcLqiVuqTJI5cWugWqOB9X1BdqqOW53w/jI33oXExbZkdRpvPJoTM
         EVnUAkWXsK9gkYAdnkwZorqMMEu94B0pbvuX+0pV4+f6k3iKfkMacAs6OSPiyV80ou7V
         xFgTyIAl1WGPAx122Sirg+gmNbFqeHoFzriAEKTj1D5zGZr/PMQsqQaAsfAicoSkUcih
         1Dc0sm1JbMsEQoxvu0S0B629sYsSsY4iukajGNaz3zBFhOFWPaR8V9WkKcqnE9NtmzpK
         Ia//8ToqnLLOp4o2CYY8noQMjsJ5PpClw+UUOhYlvf9ubdh7cYc2DaE0W6CAbz8KvxWu
         L3eA==
X-Gm-Message-State: AOJu0Yw9vVSkWLTAIrZV0Yd5+vNPRNHQ7RAiHTa/kA7bnOGRX/jgRI6+
	il4ar1cxISBGBYAH8a7kUlsE5lQYSIUFt6lZuesMlL2RoGtln4UIbChyPFBUndcTCk57ohXcH61
	11xgSCQajYcetYu/r3IRHG4LVHfgc9A==
X-Google-Smtp-Source: AGHT+IF1iZw3eldnnD3VXeX/XJZQ/IxA2iCGbRR1RyymA/N2g6znebK8uC2G5ItaJTqIu/fUcCDweWOpAC/Nev2xszE=
X-Received: by 2002:a2e:be05:0:b0:2fa:c0fc:e3d6 with SMTP id
 38308e7fff4ca-2ff201e6dd2mr3305601fa.7.1731020517329; Thu, 07 Nov 2024
 15:01:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107220121.97417-1-VAnPushkarev@salutedevices.com> <20241107220121.97417-3-VAnPushkarev@salutedevices.com>
In-Reply-To: <20241107220121.97417-3-VAnPushkarev@salutedevices.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 7 Nov 2024 18:01:24 -0500
Message-ID: <CABBYNZJp9qmPY2YtNP9JsbuMk1e_-MnJMdBoZZd0kGsSvwMqBQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] a2dp: Reject incoming connection when channel
 limit is exceeded
To: Victor Pushkarev <VAnPushkarev@salutedevices.com>
Cc: linux-bluetooth@vger.kernel.org, sdfw_system_team@salutedevices.com, 
	corvinus.v@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Victor,

On Thu, Nov 7, 2024 at 5:10=E2=80=AFPM Victor Pushkarev
<VAnPushkarev@salutedevices.com> wrote:
>
> Add counting of active audio streams at MediaEndpoint level.
>
> Reject incoming connection at the audio stream setting stage
> when the configured A2DP channel limit is exceeded.
>
> ---
>  profiles/audio/a2dp.c  |  9 +++++++++
>  profiles/audio/media.c | 11 +++++++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> index c97bd6e89..935873d07 100644
> --- a/profiles/audio/a2dp.c
> +++ b/profiles/audio/a2dp.c
> @@ -716,6 +716,15 @@ static gboolean endpoint_setconf_ind(struct avdtp *s=
ession,
>                         return TRUE;
>                 }
>
> +               if (ret =3D=3D -1) {
> +                       /* Reject connection from SEP
> +                       * and clear configuration.
> +                       */
> +                       DBG("Reject connection from %s", device_get_path(=
setup->chan->device));
> +                       a2dp_sep->endpoint->clear_configuration(a2dp_sep,=
 a2dp_sep->user_data);
> +                       device_request_disconnect(setup->chan->device, NU=
LL);
> +               }
> +
>                 setup_error_init(setup, AVDTP_MEDIA_CODEC,
>                                         AVDTP_UNSUPPORTED_CONFIGURATION);
>                 setup_unref(setup);
> diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> index 746e538fc..20b860f6a 100644
> --- a/profiles/audio/media.c
> +++ b/profiles/audio/media.c
> @@ -33,6 +33,7 @@
>  #include "src/dbus-common.h"
>  #include "src/profile.h"
>  #include "src/service.h"
> +#include "src/btd.h"
>
>  #include "src/uuid-helper.h"
>  #include "src/log.h"
> @@ -134,6 +135,7 @@ struct media_player {
>  };
>
>  static GSList *adapters =3D NULL;
> +static unsigned int active_streams;
>
>  static void endpoint_request_free(struct endpoint_request *request)
>  {
> @@ -302,6 +304,9 @@ done:
>
>  static void clear_endpoint(struct media_endpoint *endpoint)
>  {
> +       if (active_streams > 0)
> +               active_streams--;
> +
>         media_endpoint_cancel_all(endpoint);
>
>         while (endpoint->transports !=3D NULL)
> @@ -659,6 +664,12 @@ static int set_config(struct a2dp_sep *sep, uint8_t =
*configuration,
>         struct media_endpoint *endpoint =3D user_data;
>         struct a2dp_config_data *data;
>
> +       active_streams++;
> +       if (active_streams > btd_opts.a2dp.channels) {
> +               DBG("A2DP channel limit (%u) exceeded", btd_opts.a2dp.cha=
nnels);
> +               return -1;
> +       }

This is a global limit? Not really following the reasoning here, if
the platform don't want to connect to more devices just don't connect
them, or in case of incoming connection don't authorize the
connections, make the endpoints return an error to SetConfiguration,
suspend the streams, etc. There are so many ways to block this that I
don't really feel like introducing a new one will do us any good.

>         data =3D g_new0(struct a2dp_config_data, 1);
>         data->setup =3D setup;
>         data->cb =3D cb;
> --
> 2.39.3 (Apple Git-146)
>
>


--=20
Luiz Augusto von Dentz
