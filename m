Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95AB28E3B
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jan 2024 19:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W67xHYvN"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cce6c719caso10044681fa.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jan 2024 11:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704395313; x=1705000113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNzqOAPiSbhAqNGSIw4qIUZwwB4ssRONcopXO5fU1ww=;
        b=W67xHYvNHSF3wjlw48GdUtfhguNXNrXcZj01F+gzvjXUoGSImj68TL77rkUkRXEKoE
         1a8qxm3XYiePIetjmRSyN5Hb93JtwRGmJ3FSa0EogBfDwv/TyzpqX8iMoeUH/Wwc+SeZ
         h7QqucnFu76uFW7nEyOAZGRzfjKXpaAKdDyqgb+UxX5qZzvrvC5z7/ZrwTyD3cUvjPeq
         nM0KtR3lfnJmHHXWNaoODd+jQTEUzjVIxERXerl3nxL10V7mFU62GbCFoFGinBTRbyJw
         CrCElNGbEu9Zg7edpG81jiH2LVbWwyAhzdWQ5UMtOaf3tSG+3RhoWufa2bdzedgB7chV
         6JIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704395313; x=1705000113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UNzqOAPiSbhAqNGSIw4qIUZwwB4ssRONcopXO5fU1ww=;
        b=a/bQrYvvDDlnS5qk9W9d53FqNptEU6dpLGEqPvtxXX04LO+7UF0H9708KQeu2YgW/7
         yFbFCv4Gca+FXibpPqRFkQGXI7sxZ2goMXZO5WyW0SuIsNQJpn4+UUAz2k3F01sFKyKh
         zKolhW4+4M5F7BkHtCKLYw9e8+ZL/dqXk1DhzH4uqSqPsIu+5MYc+5FxNUNJCC1tAjF+
         QCAjebre4BzXurIbKvjkr8z1467gCohMcMd8XDPaux1Ehb16zqBmMDwjujweqgP14kEi
         /jC5JqoeVyK8UkheAiwY2kk4YwxSRVoimt4qA5W6+Ep2pWoA0UKlJubh9QntfmFvt9VD
         q3kw==
X-Gm-Message-State: AOJu0YziYNoHZqiuw+HcEOsYCokk06lS11mwXcRmHlvXq3Vx7Iww6CXl
	tpAowEN41tk5SGu2LZkDGYVYjXZFysVJRTB6K6M=
X-Google-Smtp-Source: AGHT+IF3ZTOEa/PqVZtZTKeNOtXVReFvSNyHlSoDsf0We1Hfx+F77n1123lSqfs3Tu4i6poAlWJBGoJ3pul6shQ1gAE=
X-Received: by 2002:a2e:9851:0:b0:2cc:d616:ff9b with SMTP id
 e17-20020a2e9851000000b002ccd616ff9bmr482017ljj.46.1704395312646; Thu, 04 Jan
 2024 11:08:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104171400.124128-1-xiaokeqinhealth@126.com>
In-Reply-To: <20240104171400.124128-1-xiaokeqinhealth@126.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 4 Jan 2024 14:08:19 -0500
Message-ID: <CABBYNZJJdZTWBaq1KakyDpg67nx8peyzLgb29+UBd9UEsd5CaQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v4 1/2] a2dp: fix incorrect transaction label in
 setconf phase
To: Xiao Yao <xiaokeqinhealth@126.com>
Cc: linux-bluetooth@vger.kernel.org, Xiao Yao <xiaoyao@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Xiao,

On Thu, Jan 4, 2024 at 12:16=E2=80=AFPM Xiao Yao <xiaokeqinhealth@126.com> =
wrote:
>
> From: Xiao Yao <xiaoyao@rock-chips.com>
>
> BLUETOOTH SPECIFICATION Page 61 of 140
> Audio/Video Distribution Transport Protocol Specification (V13)
> 8.4.6 Message integrity verification at receiver side
>
> - The receiver of an AVDTP signaling message shall not interpret corrupte=
d
> messages. Those messages are discarded and no signaling message is return=
ed
> to the sender if no error code is applicable. Possible corrupted messages
> are:
>
>   * Response messages where the transaction label cannot match a previous
>     command sent to the remote device
>
> Consider the following scenario:
> btmon log:
> AVDTP: Discover (0x01) Command (0x00) type 0x00 label 5 nosp 0
> ... ...
> < AVDTP: Set Configuration (0x03) Command (0x00) type 0x00 label 8 nosp 0
> //Currently, a 'set configuration' message has been received from the
> //sender, which contains a transaction label valued at 8. This message
> //was then relayed to A2DP backend(PulseAudio/PipeWire) using the dbus
> //interface.
>   set_configuration()(media.c)
>     dbus_message_new_method_call(..., "SetConfiguration", ...);
>     g_dbus_send_message_with_reply(btd_get_dbus_connection(), ...);
>     dbus_pending_call_set_notify(request->call, endpoint_reply, ...);
>     ...
>
> //The commit "02877c5e9" introduces a reverse discovery logic, resulting
> //in a small probability that the discovery command is issued before the
> //setconfig accept command.
> //Tip: If an artificial delay is added to the audio backend, this issue
> //will invariably occur."
> > AVDTP: Discover (0x01) Command (0x00) type 0x00 label 0 nosp 0
> //After receiving the discover reply, the session->in.transaction is
> //changed to 0
> < AVDTP: Discover (0x01) Response Accept (0x02) type 0x00 label 0 nosp 0
>
> > AVDTP: Set Configuration (0x03) Resp Accept (0x02) type 0 label 0 nosp =
0
> //The audio backend reply the dbus message
>   endpoint_reply (media.c)
>     setconf_cb (avdtp.c)
>       //Here avdtp_send sends an incorrect transaction value, causing
>       //the sender to discard the message. (The correct transaction
>       //value is 8)
>       avdtp_send(session, session->in.transaction, AVDTP_MSG_TYPE_ACCEPT,
>                  AVDTP_SET_CONFIGURATION, NULL, 0)
>
> AVDTP: Delay Report (0x0d) Command (0x00) type 0x00 label 1 nosp 0
> ... ...
>
> Therefore, the reverse discovery logic was adjusted to the back of
> setconfig accept to avoid two transmission transactions at the same
> time and fixed the problem.
>
> Signed-off-by: Xiao Yao <xiaoyao@rock-chips.com>
> ---
> v1 -> v2: Fixed "session->in.transaction" logic err.
> v2 -> v3: Fixed some compile warnings
> v3 -> v4: Adjust the timing of reverse discovery logic
> ---
>  profiles/audio/a2dp.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
>
> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> index b43161a13..f4ef8aec2 100644
> --- a/profiles/audio/a2dp.c
> +++ b/profiles/audio/a2dp.c
> @@ -586,6 +586,12 @@ done:
>         return FALSE;
>  }
>
> +static void reverse_discover(struct avdtp *session, GSList *seps, int er=
r,
> +                            void *user_data)
> +{
> +       DBG("err %d", err);
> +}
> +
>  static void endpoint_setconf_cb(struct a2dp_setup *setup, gboolean ret)
>  {
>         if (ret =3D=3D FALSE) {
> @@ -595,6 +601,13 @@ static void endpoint_setconf_cb(struct a2dp_setup *s=
etup, gboolean ret)
>         }
>
>         auto_config(setup);
> +
> +       /* Attempt to reverse discover if there are no remote
> +        * SEPs.
> +        */
> +       if (queue_isempty(setup->chan->seps))
> +               a2dp_discover(setup->session, reverse_discover, NULL);
> +
>         setup_unref(setup);
>  }
>
> @@ -634,12 +647,6 @@ static gboolean endpoint_match_codec_ind(struct avdt=
p *session,
>         return TRUE;
>  }
>
> -static void reverse_discover(struct avdtp *session, GSList *seps, int er=
r,
> -                                                       void *user_data)
> -{
> -       DBG("err %d", err);
> -}
> -
>  static gboolean endpoint_setconf_ind(struct avdtp *session,
>                                                 struct avdtp_local_sep *s=
ep,
>                                                 struct avdtp_stream *stre=
am,
> @@ -695,14 +702,8 @@ static gboolean endpoint_setconf_ind(struct avdtp *s=
ession,
>                                                 setup_ref(setup),
>                                                 endpoint_setconf_cb,
>                                                 a2dp_sep->user_data);
> -               if (ret =3D=3D 0) {
> -                       /* Attempt to reverse discover if there are no re=
mote
> -                        * SEPs.
> -                        */
> -                       if (queue_isempty(setup->chan->seps))
> -                               a2dp_discover(session, reverse_discover, =
NULL);

Have you actually test these changes with read devices? I would be
really surprised if this works because you are essentially changing
the reverse discover to when we do initiate AVDTP_SetConfiguration
rather when we receive, which shall never need a reverse discover to
begin with since we are initiating we always perform a discover
anyway, so that most likely is dead code that will never going to
executed.

The real culprit here is that both commands and responses are stored
in the session.in while we should probably have a session.cmd and
session.rsp to be able to handle outstanding requests in each
direction.

> +               if (ret =3D=3D 0)
>                         return TRUE;
> -               }
>
>                 setup_unref(setup);
>                 setup->err =3D g_new(struct avdtp_error, 1);
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
