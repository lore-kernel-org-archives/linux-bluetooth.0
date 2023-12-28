Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D0AF4F6
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Dec 2023 16:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzhXQFB4"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ccec119587so187361fa.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Dec 2023 08:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703779538; x=1704384338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0HYL2XJO5kfwBeir9eEtKgqwXg5We9KYBbGbRTAB8Ss=;
        b=HzhXQFB4lOaKMUHB6eLKntDmvJ/QMDY9k9ZpW/72kU6ZX10LYNeUDBXpHpWg6Mqo44
         I5bRthz2PRJ1FXVm1Fp3DTuAw98PCu9fFkd8X5Ysy+PG8k1/b4sG2yzUqU3P5n4IP/+2
         dmryMYCCGYHNzLo1LS/Pm4+srt2uz0rpNR6CkTRXmNCN7bjco8YGSUgpHebBHlFGCL3K
         p6lR011jD3nRHdZ5xcxwYbQ2PbWiyrSURBCgO/pdOJFlmbwQhydXZfql9CSRm0OsM0Tm
         I0+RR9CdyjUGch04Zdjm1+4aRezyRkVoBO0CFugkKMHMzQBfGB71n9E2Wf8Atc2aARwb
         8LJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703779538; x=1704384338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0HYL2XJO5kfwBeir9eEtKgqwXg5We9KYBbGbRTAB8Ss=;
        b=wWFgvY2nkWoKETrRfotmmemZsXgNLNiGOYT+C/IQ9W7qNUVXaeKJzX18mBu+NrWrwS
         ek7+788AzuBQWRsSzaqqFG/kJex3KC0TY+q/c8MdEHNs5yowVWG4uzKY9SLB7N6rlIAq
         F49OY/8hlReRpfpVtr7ZgIWqpk/2KFDSmVK9FDkHX0CyLlvRevZGq+DJzCeuCFyeQ2kL
         bqkeQJAGeKszIYVMRg4LM0pZyF/u6pIw7wj/trca+qZ8JQdLwO1m8uVT69uRbI2zKLG2
         BTLhpVeTzAT0ls4yXZBgLMhaLw5Axt+HY/rUVeQj8LDg98C/Ymte2J79M9lMnnIKtAL/
         /oQQ==
X-Gm-Message-State: AOJu0YwZfKyNOMHh4mRwxp4LaqP56zSgfAEmUxuFvnaeMEMgbE5v0Qxf
	N4w+FiQNJ1cr0yZ/84LvoFetpYvO2x/IDJzVgVVWqKT8
X-Google-Smtp-Source: AGHT+IFDPPoCLDhwBOtj12YW/i9Scr4degPuzMLMMlvrOnh8UXQealVcBuEOvoW2N5uvwZVzKUIcv6JVOCWl1MFN6RE=
X-Received: by 2002:a2e:5cc7:0:b0:2cc:9a11:9f34 with SMTP id
 q190-20020a2e5cc7000000b002cc9a119f34mr4302573ljb.20.1703779537431; Thu, 28
 Dec 2023 08:05:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228135206.1949453-1-xiaokeqinhealth@126.com>
In-Reply-To: <20231228135206.1949453-1-xiaokeqinhealth@126.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 28 Dec 2023 11:05:23 -0500
Message-ID: <CABBYNZLVZOJ6uAJdu876S5=jb1CeAX_ajn7jAUCurWdDOcKotQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/1] avdtp: fix incorrect transaction label in
 setconf phase
To: Xiao Yao <xiaokeqinhealth@126.com>
Cc: linux-bluetooth@vger.kernel.org, Xiao Yao <xiaoyao@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 28, 2023 at 9:07=E2=80=AFAM Xiao Yao <xiaokeqinhealth@126.com> =
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
> ... ...
> AVDTP: Discover (0x01) Command (0x00) type 0x00 label 5 nosp 0
> AVDTP: Discover (0x01) Response Accept (0x02) type 0x00 label 5 nosp 0
> AVDTP: Get All Capabilities (0x0c) Command (0x00) type 0x00 label 6 nosp =
0
> AVDTP: Get All Capabilities (0x0c) Response Accept (0x02) type 0x00 label=
 6 nosp 0
> AVDTP: Get All Capabilities (0x0c) Command (0x00) type 0x00 label 7 nosp =
0
> AVDTP: Get All Capabilities (0x0c) Response Accept (0x02) type 0x00 label=
 7 nosp 0
>
> < AVDTP: Set Configuration (0x03) Command (0x00) type 0x00 label 8 nosp 0
> //Currently, a 'set configuration' message has been received from the
> //sender, which contains a transaction label valued at 8. This message
> //was then relayed to A2DP backend(PulseAudio/PipeWire) using the dbus
> //interface.
>     ---
>     set_configuration()(media.c)
>         msg =3D dbus_message_new_method_call(endpoint->sender, endpoint->=
path,
>                                                 MEDIA_ENDPOINT_INTERFACE,
>                                                 "SetConfiguration");
>         media_endpoint_async_call()
>         //dbus send
>         g_dbus_send_message_with_reply(btd_get_dbus_connection(),
>                                                 msg, &request->call,
>                                                 REQUEST_TIMEOUT(3 seconds=
))
>         dbus_pending_call_set_notify(request->call, endpoint_reply, reque=
st,NULL);
>         ...
>
> > AVDTP: Discover (0x01) Command (0x00) type 0x00 label 0 nosp 0
> //At this time, the A2DP reverse discovery issued an A2DP discover comman=
d.
> < AVDTP: Discover (0x01) Response Accept (0x02) type 0x00 label 0 nosp 0
> //After receiving the discover reply, the session->in.transaction is
> //changed to 0
>
> > AVDTP: Set Configuration (0x03) Response Accept (0x02) type 0x00 label =
0 nosp 0
> //The audio backend reply the dbus message
>     endpoint_reply (media.c)
>         setconf_cb (avdtp.c)
>             //Here avdtp_send sends an incorrect transaction value, causi=
ng
>             //the sender to discard the message. (The correct transaction
>             //value is 8)
>             avdtp_send(session, session->in.transaction, AVDTP_MSG_TYPE_A=
CCEPT,
>                                         AVDTP_SET_CONFIGURATION, NULL, 0)
>
> AVDTP: Delay Report (0x0d) Command (0x00) type 0x00 label 1 nosp 0
> AVDTP: Delay Report (0x0d) Response Accept (0x02) type 0x00 label 1 nosp =
0
> AVDTP: Get All Capabilities (0x0c) Command (0x00) type 0x00 label 2 nosp =
0
> AVDTP: Get All Capabilities (0x0c) Response Accept (0x02) type 0x00 label=
 2 nosp 0
> ... ...
>
> Therefore, a async_transaction that requires asynchronous return is
> recorded to prevent it from being incorrectly modified.
>
> Signed-off-by: Xiao Yao <xiaoyao@rock-chips.com>
> ---
>  profiles/audio/avdtp.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> index 10ef380d4..2171e7723 100644
> --- a/profiles/audio/avdtp.c
> +++ b/profiles/audio/avdtp.c
> @@ -286,6 +286,7 @@ struct in_buf {
>         gboolean active;
>         int no_of_packets;
>         uint8_t transaction;
> +       uint8_t async_transaction;

You can only have one transaction in each direction, so this doesn't
look right at all. What perhaps is the problem is that we are changing
the transaction ID also in case of responses in which case we need to
fix that.

>         uint8_t message_type;
>         uint8_t signal_id;
>         uint8_t buf[1024];
> @@ -1459,6 +1460,9 @@ static void setconf_cb(struct avdtp *session, struc=
t avdtp_stream *stream,
>         struct conf_rej rej;
>         struct avdtp_local_sep *sep;
>
> +       if (session->in.transaction !=3D session->in.async_transaction)
> +               session->in.transaction =3D session->in.async_transaction=
;
> +
>         if (err !=3D NULL) {
>                 rej.error =3D AVDTP_UNSUPPORTED_CONFIGURATION;
>                 rej.category =3D err->err.error_code;
> @@ -1569,6 +1573,7 @@ static gboolean avdtp_setconf_cmd(struct avdtp *ses=
sion, uint8_t transaction,
>                 session->version =3D 0x0103;
>
>         if (sep->ind && sep->ind->set_configuration) {
> +               session->in.async_transaction =3D transaction;
>                 if (!sep->ind->set_configuration(session, sep, stream,
>                                                         stream->caps,
>                                                         setconf_cb,
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
