Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1CD1CA9C
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jan 2024 18:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJduR3Zw"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ccabf5a4beso96617681fa.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jan 2024 10:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704307783; x=1704912583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJ34YAkrhJZm+EKhST1m9/yxnoPMN1EuCfDpuAPstGY=;
        b=eJduR3Zwz1DIUQw+0EBlCQeiRqI+q42fmZUxypDzytfGENCY7Nlc29XQKd23nL5CzU
         R10dJmBEi1I38uuRQ7RoDCPr5x9+ObwhUoS8xMM8sa7XD22cy6s1sKJm8SKnlw+Qc3wb
         H/3AWcGg2t0k7FYaX7uxuYGkGLOTZnjskSzxM/TP7snwuIATw7mrIsu+Vn2yAYynViRt
         MLEwBK064sUAJD/SfiPjViwrP8Yh776qb4vBHjROYgKISFH1Zs6ge7x9jWFsXMCPF2lV
         UPChAOjEk5ecHTe/MiNkbPLwlypAp+fzH26amXnuMsmeDoBypctzsFhH82ld7UKfSTdW
         XOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704307783; x=1704912583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJ34YAkrhJZm+EKhST1m9/yxnoPMN1EuCfDpuAPstGY=;
        b=fzgklxTDn+fVlyOOaAP9TlZxikkY+Xxg1r+26YfZ3GJT+X7DfksFtRK4SDOMTWplm0
         jyn07ujGQcheAVyaSUGFOESUVPZhF8xB27wbx0BemitWEjX5Z2EYJg5LLD/MxacZZ42c
         CFSB6XLLyra0lWBFVgEsapK4FCaY4KbjVM9E+4IyOKvvPWLy26vnfj1pzsePqAK1DVde
         ID9NhztLCzu6zqOhNG9Pl8N7G8VjAX4IEZ4Qf7nSbA/lJADaGM4U1qSIAp1DzqQwQTSY
         s/WNRQURo4hhE9d6yFIDGAnVRmNc8NXP9nvJJVzPXmReOXvT/Qbiv1Dx8HWIo6YyT+Yr
         CKLA==
X-Gm-Message-State: AOJu0Yx05naALSTk17P4hsHVNWKvSkZcUWu7XQ/RwKiDzOJ7D/97Az/p
	VcrPHRldzma8UaHLtzXpZumwgklEOTD/zopbkzcggcuK
X-Google-Smtp-Source: AGHT+IFRdJ/E79gRtuPcqd3bQM7m0DcP090Nq0ClNN8LsC33wfHOPlnq4gZuXDCslmqW5NOiv966fcVJ6WSa0Wa9nYE=
X-Received: by 2002:a2e:a278:0:b0:2cc:e3b8:3184 with SMTP id
 k24-20020a2ea278000000b002cce3b83184mr2087769ljm.39.1704307783072; Wed, 03
 Jan 2024 10:49:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103143904.77146-1-xiaokeqinhealth@126.com>
 <CABBYNZLo9CVZsjvzjKsGKFyhOkrWoyWYL8bQoSfvTDf=PAQ-iw@mail.gmail.com> <5df7515e-5785-400c-8e29-42fc88cef0c6@126.com>
In-Reply-To: <5df7515e-5785-400c-8e29-42fc88cef0c6@126.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 3 Jan 2024 13:49:30 -0500
Message-ID: <CABBYNZ+T9PJDWgdyfKdTXB1gpuLdvrb3BycUW-pwCLFSLvmGhA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 1/2] avdtp: fix incorrect transaction label in
 setconf phase
To: Yao Xiao <xiaokeqinhealth@126.com>
Cc: linux-bluetooth@vger.kernel.org, Xiao Yao <xiaoyao@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 3, 2024 at 1:41=E2=80=AFPM Yao Xiao <xiaokeqinhealth@126.com> w=
rote:
>
> Hi,
> On 2024/1/3 23:38, Luiz Augusto von Dentz wrote:
> > Hi,
> >
> > On Wed, Jan 3, 2024 at 9:40=E2=80=AFAM Xiao Yao <xiaokeqinhealth@126.co=
m> wrote:
> >> From: Xiao Yao <xiaoyao@rock-chips.com>
> >>
> >> BLUETOOTH SPECIFICATION Page 61 of 140
> >> Audio/Video Distribution Transport Protocol Specification (V13)
> >> 8.4.6 Message integrity verification at receiver side
> >>
> >> - The receiver of an AVDTP signaling message shall not interpret corru=
pted
> >> messages. Those messages are discarded and no signaling message is ret=
urned
> >> to the sender if no error code is applicable. Possible corrupted messa=
ges
> >> are:
> >>
> >>    * Response messages where the transaction label cannot match a prev=
ious
> >>      command sent to the remote device
> >>
> >> Consider the following scenario:
> >> btmon log:
> >> ... ...
> >> AVDTP: Discover (0x01) Command (0x00) type 0x00 label 5 nosp 0
> >> AVDTP: Discover (0x01) Response Accept (0x02) type 0x00 label 5 nosp 0
> >> AVDTP: Get All Capabilities (0x0c) Command (0x00) type 0x00 label 6 no=
sp 0
> >> AVDTP: Get All Capabilities (0x0c) Resp Accept (0x02) type 0 label 6 n=
osp 0
> >> AVDTP: Get All Capabilities (0x0c) Command (0x00) type 0x00 label 7 no=
sp 0
> >> AVDTP: Get All Capabilities (0x0c) Resp Accept (0x02) type 0 label 7 n=
osp 0
> >>
> >> < AVDTP: Set Configuration (0x03) Command (0x00) type 0x00 label 8 nos=
p 0
> >> //Currently, a 'set configuration' message has been received from the
> >> //sender, which contains a transaction label valued at 8. This message
> >> //was then relayed to A2DP backend(PulseAudio/PipeWire) using the dbus
> >> //interface.
> >>    set_configuration()(media.c)
> >>      dbus_message_new_method_call(..., "SetConfiguration", ...);
> >>      g_dbus_send_message_with_reply(btd_get_dbus_connection(), ...);
> >>      dbus_pending_call_set_notify(request->call, endpoint_reply, ...);
> >>      ...
> >>
> >>> AVDTP: Discover (0x01) Command (0x00) type 0x00 label 0 nosp 0
> >> //At this time, the A2DP reverse discovery issued an A2DP discover com=
mand.
> >> < AVDTP: Discover (0x01) Response Accept (0x02) type 0x00 label 0 nosp=
 0
> >> //After receiving the discover reply, the session->in.transaction is
> >> //changed to 0
> >>
> >>> AVDTP: Set Configuration (0x03) Resp Accept (0x02) type 0 label 0 nos=
p 0
> >> //The audio backend reply the dbus message
> >>    endpoint_reply (media.c)
> >>      setconf_cb (avdtp.c)
> >>        //Here avdtp_send sends an incorrect transaction value, causing
> >>        //the sender to discard the message. (The correct transaction
> >>        //value is 8)
> >>        avdtp_send(session, session->in.transaction, AVDTP_MSG_TYPE_ACC=
EPT,
> >>                   AVDTP_SET_CONFIGURATION, NULL, 0)
> >>
> >> AVDTP: Delay Report (0x0d) Command (0x00) type 0x00 label 1 nosp 0
> >> AVDTP: Delay Report (0x0d) Response Accept (0x02) type 0x00 label 1 no=
sp 0
> >> AVDTP: Get All Capabilities (0x0c) Command (0x00) type 0x00 label 2 no=
sp 0
> >> AVDTP: Get All Capabilities (0x0c) Resp Accept (0x02) type 0 label 2 n=
osp 0
> >> ... ...
> >>
> >> Therefore, a async_transaction that requires asynchronous return is
> >> recorded to prevent it from being incorrectly modified.
> >>
> >> Signed-off-by: Xiao Yao <xiaoyao@rock-chips.com>
> >> ---
> >> v1 -> v2: Fixed "session->in.transaction" logic err.
> >> v2 -> v3: Fixed some compile warnings
> >> ---
> >>   profiles/audio/avdtp.c | 19 ++++++++++++++-----
> >>   1 file changed, 14 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> >> index 10ef380d4..386c7f67c 100644
> >> --- a/profiles/audio/avdtp.c
> >> +++ b/profiles/audio/avdtp.c
> >> @@ -286,6 +286,7 @@ struct in_buf {
> >>          gboolean active;
> >>          int no_of_packets;
> >>          uint8_t transaction;
> >> +       uint8_t async_transaction;
> > Didn't I already explain it already that we are not supposed to have 2
> > outstanding transactions?
> Apologies for the misunderstanding earlier. When you mentioned
> 'outstanding transactions',
> were you referring to a complete configuration process, rather than a
> single command?
> Can I understand it this way: An a2dp discovery command should not be
> sent before responding
> to the AVDTP_MSG_TYPE_ACCEPT message? Is it only after sending the
> AVDTP_MSG_TYPE_ACCEPT
> response to the remote device that I can proceed with the a2dp discovery?

You can have a single outstanding transaction in each direction, but
not 2 like in.transaction + in.async_transaction since that means we
received a second request while 1 is still outstanding.

> >
> >>          uint8_t message_type;
> >>          uint8_t signal_id;
> >>          uint8_t buf[1024];
> >> @@ -1462,15 +1463,16 @@ static void setconf_cb(struct avdtp *session, =
struct avdtp_stream *stream,
> >>          if (err !=3D NULL) {
> >>                  rej.error =3D AVDTP_UNSUPPORTED_CONFIGURATION;
> >>                  rej.category =3D err->err.error_code;
> >> -               avdtp_send(session, session->in.transaction,
> >> -                               AVDTP_MSG_TYPE_REJECT, AVDTP_SET_CONFI=
GURATION,
> >> -                               &rej, sizeof(rej));
> >> +               avdtp_send(session, session->in.async_transaction,
> >> +                          AVDTP_MSG_TYPE_REJECT, AVDTP_SET_CONFIGURAT=
ION,
> >> +                          &rej, sizeof(rej));
> >>                  stream_free(stream);
> >>                  return;
> >>          }
> >>
> >> -       if (!avdtp_send(session, session->in.transaction, AVDTP_MSG_TY=
PE_ACCEPT,
> >> -                                       AVDTP_SET_CONFIGURATION, NULL,=
 0)) {
> >> +       if (!avdtp_send(session, session->in.async_transaction,
> >> +                       AVDTP_MSG_TYPE_ACCEPT,
> >> +                       AVDTP_SET_CONFIGURATION, NULL, 0)) {
> >>                  stream_free(stream);
> >>                  return;
> >>          }
> >> @@ -1569,6 +1571,13 @@ static gboolean avdtp_setconf_cmd(struct avdtp =
*session, uint8_t transaction,
> >>                  session->version =3D 0x0103;
> >>
> >>          if (sep->ind && sep->ind->set_configuration) {
> >> +               /* The setconfig configuration stage is asynchronous;
> >> +                * high CPU load or other factors can delay dbus messa=
ge
> >> +                * responses, potentially altering the transaction val=
ue.
> >> +                * It's essential to record the received transaction v=
alue
> >> +                * for use in the final accept command.
> >> +                */
> >> +               session->in.async_transaction =3D transaction;
> >>                  if (!sep->ind->set_configuration(session, sep, stream=
,
> >>                                                          stream->caps,
> >>                                                          setconf_cb,
> >>
> >> base-commit: 7ad5669402c9acff8e4cc808edc12a41df36654e
> >> --
> >> 2.34.1
> >>
> >>
> >
>


--=20
Luiz Augusto von Dentz
