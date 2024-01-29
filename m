Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68C6159571
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 21:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706562417; cv=none; b=LY3gdfjBOKcn5gz2A3YlnN0o0COmuEKwHh/8XeNw3enZwBWbTqAGy4N7rqG6tYhS30p2Yfi08mtaJP5xFVwLWoQvESDJgdmMK71mOmyJTEw+3Sn8irQPSMKSFiYH2++jdiDBjqioosGwYlJtQjUJ82w0pjc+egKnKL5njKhjJRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706562417; c=relaxed/simple;
	bh=leTdTs0UtXkk2IqqK4ch8KBJsn9mAd7TKc3bpXUZJd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CvTvvrw6GdTZdGJoh7aKqMa3/5Ww3rKzD9Nr8wfDzszRqBekUewPRMA9N3LWf0o7xfxAj5QzZ9AJ/AJjSSOYF4xWqP14jxNxD5si86YNENZXMFlMP1xTl7vwdRaq+7KrSPkxq8a2oQcpgqoA7Os7+ghvvrkKtCOulezj/7BdWGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5XMzvip; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5XMzvip"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d03fde0bd9so24511821fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 13:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706562413; x=1707167213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVzMyU3FQHso08To4X1kTXqhplhZ2eL0+twfQ5HlWNs=;
        b=U5XMzvipeJdpcjwT4HtzzLF0HeKAEt082uEuo/L8DkY7bxwD4/zXvrmecPSmrSbaZR
         8RaUjbqIpQu20g+y0DwrgxM249H1KQQU+Ko5HuVsUaUvbGG+Z/EuofRzbfo6FToYoAW6
         En/6HC3kUAUptJI0NXRmTfGLpMRyUCSlJF6XkmsBBvQVTOHJqJ1ye9VW10b4lamTmqhf
         fDFhJc12svrUxh375nKVl891pHhqwaIE0bsNqPbjRxpo+RsZHPhLmzIab85hBcPM3urh
         3pnNX4nErTgMml1Gq+gPmmidBtae9B1P0mZGPszWJ0G0OmBI3y9hU2HU9oYHrvxBgbSL
         eWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706562413; x=1707167213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mVzMyU3FQHso08To4X1kTXqhplhZ2eL0+twfQ5HlWNs=;
        b=KQiVWLLJ4ADeiB6PHw7XD+VpXxohm/b4+3OtpmCpQ39axdoCO7A3yFBPsLEVnZRzLJ
         1TR1eahnkzsjaAeNHUaSIghni+JDjwTEWG+0SVm+HBJG7dQVHo8oRW6x0Uu5rviFFXo3
         hL86LavoQn8a8NcSKKIjvvaYYzb4Z2r9n1H+Oo0PndxVkTpVZBpOhG4DA8WvEdsEKXq2
         E9jz/hqYggvf9Slzdfg/PmfKKE/uFPtCmbIgdaRL4yVmRaw0sgk6JZCF0x+0NULlbWcR
         s8HpZS8JfA5oFPg+e7crA27IZd/tUDVumlE0FsW27dOvfw5hE7TjlnpmwKAGBQw3sLn1
         2hlw==
X-Gm-Message-State: AOJu0YzC1bCNHAjmicIgXPFza8OGGKBNYdgruK3RvB0jYQCTJASO1pXj
	QWmt6VV9vWpmZpznZETWRy3HO4j6uKbDQhxu4fWfGWrzLe4G/rrKy8nKXuK0LjZNM4+IObQkEzG
	dyvVI5RU/9bNXXx6doHUZMHsSZ5DU4Vj3
X-Google-Smtp-Source: AGHT+IHHdpuEqd7Ya2cPFCU0bbuC+m6OfS5b95ECS3kcsjtmr8usXmGtyta28DhbOWRo+ntw4/8zXmCVpAC7g0gxVD8=
X-Received: by 2002:a2e:9882:0:b0:2cf:3851:5fad with SMTP id
 b2-20020a2e9882000000b002cf38515fadmr5284209ljj.2.1706562412564; Mon, 29 Jan
 2024 13:06:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129204154.95773-1-VAnPushkarev@salutedevices.com> <20240129204154.95773-3-VAnPushkarev@salutedevices.com>
In-Reply-To: <20240129204154.95773-3-VAnPushkarev@salutedevices.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 29 Jan 2024 16:06:40 -0500
Message-ID: <CABBYNZK7Eb18d5tV57yhWsyuRmk-zBQptULs7nOVn_F8bjWN4A@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 2/2] a2dp: Reject connection when the channel
 limit is exceeded
To: VAnPushkarev@salutedevices.com
Cc: linux-bluetooth@vger.kernel.org, sdfw_system_team@salutedevices.com, 
	corvinus.v@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 29, 2024 at 3:42=E2=80=AFPM Victor Pushkarev
<VAnPushkarev@salutedevices.com> wrote:
>
> Reject incoming connection when the configured limit
> for A2DP channels is exceeded.
>
> Signed-off-by: Victor Pushkarev <VAnPushkarev@salutedevices.com>
> ---
>  profiles/audio/a2dp.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> index b43161a13..117b27db3 100644
> --- a/profiles/audio/a2dp.c
> +++ b/profiles/audio/a2dp.c
> @@ -2549,6 +2549,14 @@ static void confirm_cb(GIOChannel *io, gpointer da=
ta)
>         if (!chan)
>                 goto drop;
>
> +       if (btd_opts.a2dp.channels &&
> +                               queue_length(server->channels) > btd_opts=
.a2dp.channels) {
> +               device_request_disconnect(device, NULL);
> +               DBG("Reject current connection, A2DP channel limit exceed=
ed: %d",
> +                                               btd_opts.a2dp.channels);
> +               goto drop;
> +       }

NAK, this is the wrong layer to do this, it is up to the MediaEndpoint
implementation to tell how many streams it can handle.

>         chan->auth_id =3D btd_request_authorization(&src, &dst,
>                                                         ADVANCED_AUDIO_UU=
ID,
>                                                         auth_cb, chan);
> --
> 2.39.3 (Apple Git-145)
>
>


--=20
Luiz Augusto von Dentz
