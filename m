Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB4B1B27A
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jan 2024 15:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSb5aACt"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ccbf8cbf3aso99990981fa.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jan 2024 07:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704296317; x=1704901117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0nXd94lY0XL11F1qVxzDayC+ufI1DufrBEqlHXePNo=;
        b=TSb5aACt9SELCYH5pcsUzxXuMbXei3LaszLJjTYYmUxKtfq937n0NAVg6siFK/SQ5W
         hbKwpPmGQNVpD6nCbLtcgJvOHC1T/OP0Z/FmnZhwhg5jpwt9GTa8RxB8S+bUpDvNDMzW
         e4RCi6CMZ9uHQX5ivVAN8geaPgAt5JZCEyq0lBUJBBDLqfyDKweihGQHSpkCH76rnvsP
         HAM1A7jMbTDmTMf5aSuJbA845BcvR4DPRjEMoyQGYN35QG+J2a4MfA6MPyrde15TCb3a
         Vjzn2a+zHSlqJdZ7YhoAH3pVMdEIfgdDS8FPf8IYynbe6i2CFModnDHHK4Hg8Mqr2hJj
         JxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704296317; x=1704901117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h0nXd94lY0XL11F1qVxzDayC+ufI1DufrBEqlHXePNo=;
        b=sS3QxsQowP1oFlk1XgdAG0TTK1tgEBA+WbJyhITgBL4j8xzDIbVhUKsH9RdSBOu45s
         sWl25ViciQEwMOD3JRfsNCV8K8FkYt+pcTnGee4OBpfFDNm9I2FJPjH2UEjMcLJIWW2m
         LQfMalkmp8150/qlWi7uYtU2crVx4fqmqL3NNvQy5A8acEoPCKUI22opHXFHHOjmeB5C
         p/azX6tkqc662kTuRInnpJ3vhW7VNOnPI7vf0qnIEcJk3iqILQoKWuVZIeTRyqjtrOva
         b4eC22OiZVMRyyCBvVnpRTbKL6MCU8wCQR9apea/qugR1BSwBDkI9OToZTgnALZ3omUR
         d1lw==
X-Gm-Message-State: AOJu0YxAFZN3c37reYxmUPNMgCWOZucjrM4RAkxXSnfQC0m63wQplJrK
	EYD8ISJfxBVsB5zv5uYBOgY4S3cs5pNHdr7nI8u8x8yt
X-Google-Smtp-Source: AGHT+IE8C3gsOrRdPvwpvz1PuBDTMwpSQ3oEyRpmYSjniFpWzzp1nOIhgYV636sKVywR8q/RVv2VcklstxOmSd64WQw=
X-Received: by 2002:a2e:b88e:0:b0:2cc:e9d8:40c6 with SMTP id
 r14-20020a2eb88e000000b002cce9d840c6mr5007502ljp.43.1704296316764; Wed, 03
 Jan 2024 07:38:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103143904.77146-1-xiaokeqinhealth@126.com>
In-Reply-To: <20240103143904.77146-1-xiaokeqinhealth@126.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 3 Jan 2024 10:38:23 -0500
Message-ID: <CABBYNZLo9CVZsjvzjKsGKFyhOkrWoyWYL8bQoSfvTDf=PAQ-iw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 1/2] avdtp: fix incorrect transaction label in
 setconf phase
To: Xiao Yao <xiaokeqinhealth@126.com>
Cc: linux-bluetooth@vger.kernel.org, Xiao Yao <xiaoyao@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 3, 2024 at 9:40=E2=80=AFAM Xiao Yao <xiaokeqinhealth@126.com> w=
rote:
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
> ... ...
> AVDTP: Discover (0x01) Command (0x00) type 0x00 label 5 nosp 0
> AVDTP: Discover (0x01) Response Accept (0x02) type 0x00 label 5 nosp 0
> AVDTP: Get All Capabilities (0x0c) Command (0x00) type 0x00 label 6 nosp =
0
> AVDTP: Get All Capabilities (0x0c) Resp Accept (0x02) type 0 label 6 nosp=
 0
> AVDTP: Get All Capabilities (0x0c) Command (0x00) type 0x00 label 7 nosp =
0
> AVDTP: Get All Capabilities (0x0c) Resp Accept (0x02) type 0 label 7 nosp=
 0
>
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
> > AVDTP: Discover (0x01) Command (0x00) type 0x00 label 0 nosp 0
> //At this time, the A2DP reverse discovery issued an A2DP discover comman=
d.
> < AVDTP: Discover (0x01) Response Accept (0x02) type 0x00 label 0 nosp 0
> //After receiving the discover reply, the session->in.transaction is
> //changed to 0
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
> AVDTP: Delay Report (0x0d) Response Accept (0x02) type 0x00 label 1 nosp =
0
> AVDTP: Get All Capabilities (0x0c) Command (0x00) type 0x00 label 2 nosp =
0
> AVDTP: Get All Capabilities (0x0c) Resp Accept (0x02) type 0 label 2 nosp=
 0
> ... ...
>
> Therefore, a async_transaction that requires asynchronous return is
> recorded to prevent it from being incorrectly modified.
>
> Signed-off-by: Xiao Yao <xiaoyao@rock-chips.com>
> ---
> v1 -> v2: Fixed "session->in.transaction" logic err.
> v2 -> v3: Fixed some compile warnings
> ---
>  profiles/audio/avdtp.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> index 10ef380d4..386c7f67c 100644
> --- a/profiles/audio/avdtp.c
> +++ b/profiles/audio/avdtp.c
> @@ -286,6 +286,7 @@ struct in_buf {
>         gboolean active;
>         int no_of_packets;
>         uint8_t transaction;
> +       uint8_t async_transaction;

Didn't I already explain it already that we are not supposed to have 2
outstanding transactions?

>         uint8_t message_type;
>         uint8_t signal_id;
>         uint8_t buf[1024];
> @@ -1462,15 +1463,16 @@ static void setconf_cb(struct avdtp *session, str=
uct avdtp_stream *stream,
>         if (err !=3D NULL) {
>                 rej.error =3D AVDTP_UNSUPPORTED_CONFIGURATION;
>                 rej.category =3D err->err.error_code;
> -               avdtp_send(session, session->in.transaction,
> -                               AVDTP_MSG_TYPE_REJECT, AVDTP_SET_CONFIGUR=
ATION,
> -                               &rej, sizeof(rej));
> +               avdtp_send(session, session->in.async_transaction,
> +                          AVDTP_MSG_TYPE_REJECT, AVDTP_SET_CONFIGURATION=
,
> +                          &rej, sizeof(rej));
>                 stream_free(stream);
>                 return;
>         }
>
> -       if (!avdtp_send(session, session->in.transaction, AVDTP_MSG_TYPE_=
ACCEPT,
> -                                       AVDTP_SET_CONFIGURATION, NULL, 0)=
) {
> +       if (!avdtp_send(session, session->in.async_transaction,
> +                       AVDTP_MSG_TYPE_ACCEPT,
> +                       AVDTP_SET_CONFIGURATION, NULL, 0)) {
>                 stream_free(stream);
>                 return;
>         }
> @@ -1569,6 +1571,13 @@ static gboolean avdtp_setconf_cmd(struct avdtp *se=
ssion, uint8_t transaction,
>                 session->version =3D 0x0103;
>
>         if (sep->ind && sep->ind->set_configuration) {
> +               /* The setconfig configuration stage is asynchronous;
> +                * high CPU load or other factors can delay dbus message
> +                * responses, potentially altering the transaction value.
> +                * It's essential to record the received transaction valu=
e
> +                * for use in the final accept command.
> +                */
> +               session->in.async_transaction =3D transaction;
>                 if (!sep->ind->set_configuration(session, sep, stream,
>                                                         stream->caps,
>                                                         setconf_cb,
>
> base-commit: 7ad5669402c9acff8e4cc808edc12a41df36654e
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
