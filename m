Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CD456446
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 May 2024 15:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715440977; cv=none; b=XMcmTdTKswuWrXRYBxKBx9CiCczoU/xlwRZo/3Q4kGz6xBwz5YMyX4bWi2LXr2SJrMmxGGoentoayxDZgs4dgXwq70WDTTMx3O1M4aIJw7oo0notS2+wyDSZGlQdE2ojl7HdJGw0Uc9C/gPZW1DWAm0Gb5ZZBQxKdxn5yI+E+CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715440977; c=relaxed/simple;
	bh=pXMeCWJw8S1D/bVDtLk0KQbzD3+0vpdObnkPAL0cVLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zd07lQS+WEjoM3Y1vvGoFwyO1zC4ColjeM6CvtjEC/IiK6IPLOONEgOxR4u9xwWj504bk4qreerm06xypGpUvNrkEH7wzC1n3E1IMgX25MlCiQQOTmWjZtXtQsVLoNBMADnyJ4+BPbrLBoqqemRxi8x3CFaueBYhmFO/gmD24Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAP3krpF; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAP3krpF"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e576057c06so4705611fa.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 May 2024 08:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715440974; x=1716045774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUp2JhFNXMqGOh8rdzOB1bSX7aSOlcV/QVTJzKubOk4=;
        b=cAP3krpFRzugYJ4THrsPnm5hROj9OgFMk/JLa+abfLRm/r6gOrZFWxVDbLZFjP72wd
         /eskkAYWr93Juiy6PZF6IoxtJ+SR6JtU74u8RAu5bP2GoPxMSA6OHa/cqLlAlGuNd/+w
         X1cU+v8CIHQ4+GRSrlS9AByZvcV8KzeFxjciZlY3RpJKafL0LbnZIfMfJCk3V/jVaWQV
         uknanrjNVk4RlkiWzQ26O1aIEhZ+Y6iN+AmnA1lule9tlLeocERJUbKritmgzGQ50QZt
         jKuOpC3oG4UaYsb9Or/ycJMcTu1Z/7HhAWmdtYdvBVCT8Tjp9GPEJQPummO//yg81IJA
         ZoHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715440974; x=1716045774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUp2JhFNXMqGOh8rdzOB1bSX7aSOlcV/QVTJzKubOk4=;
        b=aTBPoGq+5VS2WKafXsQj4aec6pyKzDt01Kf2iLr1f4zHEQfPX5EPzRJlKZ4p+x91py
         oC7/wFxAS8TdcrEn2/7BemfAs5YftBqV8CPfn1x+41mA4cGN1m8jGvvoBvFjuCzTw0zr
         R50J+CBwc2iv6FInUl4cgim1CPIt6CykxREuEsvhmkwpXUvKZD34GOpIEolu8gLYSMOn
         k7ezQuPzWE7ZuyfTz3HXES5b61QwKwKAoSasXd0UacFMOHIHDfo6CGA/eW4v96akIUpn
         YuIL7WAawf+QpFyh3swu3uLYRVtfjisLAOqQUdynvEmCtl/3hwKuTsiJa5xuZruwJdk5
         F5tQ==
X-Gm-Message-State: AOJu0YyDolTpRQWswMexdwOvBnCjrAPzeFG1Cz/JOmVl90IDB7fZqtkV
	i14ANiTN4HoucXcZThhGLqJbbu6sKrhcZ0NmwnA3O8N8epjx/hCJy7MQ3tgzYMAsYI7WKO7cW6n
	UFXHhwCJnvlmOsbyIcq1O/BhA0pE=
X-Google-Smtp-Source: AGHT+IFwov/YFrkRFxYmZ85aMEqJzoiPRUVZF7GpP3rm9tkG9HCJXTTJN9NJhrQPvMRkYtT/fhkxB3r3MAMIJO0cgu8=
X-Received: by 2002:a2e:b0db:0:b0:2d6:dba1:6d37 with SMTP id
 38308e7fff4ca-2e51fd2d389mr33068701fa.11.1715440974038; Sat, 11 May 2024
 08:22:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9b88a0238679d24aa5d68a4c473483943a8ea2b6.1715427163.git.pav@iki.fi>
In-Reply-To: <9b88a0238679d24aa5d68a4c473483943a8ea2b6.1715427163.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Sat, 11 May 2024 11:22:41 -0400
Message-ID: <CABBYNZ+zVn+GYG4sFubU4CMRkJBvhmjEX7UsAPROeQM1Pyjoqw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] client: fix ISO send data rate
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, vlad.pruteanu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Sat, May 11, 2024 at 7:34=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> We are sending data to controller at wrong average rate not equal to
> 1 packet / SDU interval, if Transport_Latency is not an integer multiple
> of SDU_Interval.  The calculation currently may also give zero, so no
> data gets sent.
>
> We are sending data in bursts of num ~=3D Transport_Latency/SDU_Interval
> packets, in hopes that possibly larger timer interval makes things more
> efficient.
>
> Fix the data rate by sending num packets every num*SDU_Interval, so that
> the average data rate is correct.
>
> Also fix use of itimerspect.it_value with TFD_TIMER_ABSTIME.  The value
> set previously is going to always be in the past in CLOCK_MONOTONIC so
> just set it to 1, and leave sending the initial packets to the main
> loop.
> ---
>
> Notes:
>     This assumes kernel shall set qos.interval to SDU_Interval and not
>     ISO_Interval.
>
>  client/player.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/client/player.c b/client/player.c
> index 7f67425aa..8d17022de 100644
> --- a/client/player.c
> +++ b/client/player.c
> @@ -5066,22 +5066,30 @@ static int transport_send(struct transport *trans=
port, int fd,
>         if (timer_fd < 0)
>                 return -errno;
>
> +       /* Send data in bursts of
> +        * num =3D ROUND_CLOSEST(Transport_Latency (ms) / SDU_Interval (u=
s))
> +        * with average data rate =3D 1 packet / SDU_Interval
> +        */
> +       transport->num =3D ROUND_CLOSEST(qos->latency * 1000, qos->interv=
al);
> +       if (!transport->num)
> +               transport->num =3D 1;
> +
>         memset(&ts, 0, sizeof(ts));
> -       ts.it_value.tv_nsec =3D qos->latency * 1000000;
> -       ts.it_interval.tv_nsec =3D qos->latency * 1000000;
> +       ts.it_value.tv_nsec =3D 1;
> +       ts.it_interval.tv_nsec =3D transport->num * qos->interval * 1000;
>
> -       if (timerfd_settime(timer_fd, TFD_TIMER_ABSTIME, &ts, NULL) < 0)
> +       if (timerfd_settime(timer_fd, TFD_TIMER_ABSTIME, &ts, NULL) < 0) =
{
> +               close(timer_fd);
>                 return -errno;
> +       }
>
>         transport->fd =3D fd;
> -       /* num of packets =3D ROUND_CLOSEST(latency (ms) / interval (us))=
 */
> -       transport->num =3D ROUND_CLOSEST(qos->latency * 1000, qos->interv=
al);
>         transport->timer_io =3D io_new(timer_fd);
>
>         io_set_read_handler(transport->timer_io, transport_timer_read,
>                                                 transport, NULL);
>
> -       return transport_send_seq(transport, fd, 1);

The above was actually done on purpose so we are always one interval
ahead to keep controller buffer full as much as possible.

> +       return 0;
>  }
>
>  static void cmd_send_transport(int argc, char *argv[])
> --
> 2.45.0
>
>


--=20
Luiz Augusto von Dentz
