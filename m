Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAFD2230F
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Nov 2023 20:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiGZ3jgv"
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781AD55AA
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Nov 2023 12:44:17 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c7c7544c78so18796011fa.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Nov 2023 12:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699649055; x=1700253855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGp+66so8k+JvUyYXJxgj1MDJAs4qx7sOzP4G0YXr4k=;
        b=fiGZ3jgvB9cKtkmdoQoi52tNMRPPm2ZWAwPF1159zqSwEfdllrWr83U0kDHlijK16k
         pqNboN+PlbAVZ/99+mlURmQh6hc+zFIfUZKZ4+5uTFR9AIOHY3K0I0mvZdJI29b9Yp8K
         lOJDl39kumQYWzsS1e75jNc8F+oSjgIVng0yYK++5/v1bqUK34nQaaAHoHL7UH7HnNbt
         S0KmpJ6ab+ko+w+GmX5mKBau2fQM/UF8UAOpHxJeTKlsR2z8BHmNNCmz8mzyBw27770x
         QzXLfAcI2GOdRao0An+YfFrn5u4wsjVg5w0K4f3rsiTia0Kh6x6rdjfF6//O3UI506QT
         mGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699649055; x=1700253855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mGp+66so8k+JvUyYXJxgj1MDJAs4qx7sOzP4G0YXr4k=;
        b=cFDTV6safJul4R+9q/7kgso4RR9NAae0sWvlqidtWn1wW2XxvfRcPPHKmYXrPkmzui
         kaxlv57zcNu2dYQcRgqWZnZvfLVLIU+ITOPXrEiR25bTq1RZaNu9czUTv67p49fT1/RD
         Mh5qoMykbfmVfzFStU0X8RC/mgyUWemtSnvOFwsavrYnahgzfGfpQntI2awxAlz/ns0O
         QqlUo50jz3hKdnVJfyxNTlsQWYAi+xqHMa1iFNvV0qVJXbyb0VBGHKP3b0/G3SKXsKIg
         uy/PR9ltjqgZ78OGYLfqboG5blUJ3I+blhMqDFRH9HdYoQKuGRBeopUVigqUgQsVY61q
         V7DA==
X-Gm-Message-State: AOJu0Yxhfyt39ZZl9EzYqmehCtUHTDV05k3PlaetowFnXlpb+1WRoMGZ
	/PYh1a4FsRel8iSiSymgETtPqKScBj90eq8HC7U=
X-Google-Smtp-Source: AGHT+IHWoVq7XsixpoCgw9ukzt9GH5TcTbPGQP5GZxttRNBFwZYUHFEK1ANup8zZP50EOa9QnwUR0vO5G2YSAwqAuU8=
X-Received: by 2002:a2e:b0e7:0:b0:2c5:a6e:4bcc with SMTP id
 h7-20020a2eb0e7000000b002c50a6e4bccmr400161ljl.39.1699649055173; Fri, 10 Nov
 2023 12:44:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5c65fa8da174de15074310ec368f537c717ded43.1699646238.git.pav@iki.fi>
In-Reply-To: <5c65fa8da174de15074310ec368f537c717ded43.1699646238.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 10 Nov 2023 15:44:02 -0500
Message-ID: <CABBYNZLbk52FUhkCcqMTkpnsqYfqATrmwTJ5mwiChpzofMNz=A@mail.gmail.com>
Subject: Re: [PATCH BlueZ] bap: handle state transitions with old_state == new_state
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Fri, Nov 10, 2023 at 2:58=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> ASCS allows transitions from Codec/QoS Configured back to the same
> state.
>
> E.g. NRF5340_AUDIO devkit starts in the config(1) state, which is
> allowed (only Config QoS, Release, Enable, Receiver Stop Ready
> transition are client-only). In this case, as client, we do Config Codec
> ourselves and end up with config(1)->config(1) transition.  We currently
> ignore that event, so QoS won't be setup and transports won't be
> created.

Nice catch, that said I do wonder if we shouldn't be checking if the
configuration is the same and not attempt to reconfigure if it
matches.

> Handle the config(1)->config(1) transition by continuing to Config QoS
> if it occurs.
>
> Log:
>
> src/gatt-client.c:btd_gatt_client_connected() Device connected.
> src/shared/gatt-client.c:exchange_mtu_cb() MTU exchange complete, with MT=
U: 65
> src/shared/bap.c:bap_ep_set_status() ASE status: ep 0x604000039a90 id 0x0=
1 handle 0x000f state config len 42
> src/shared/bap.c:ep_status_config() codec 0x06 framing 0x00 phy 0x02 rtn =
2 latency 10 pd 4000 - 40000 ppd 4000 - 40000
> src/shared/bap.c:ep_status_config() Codec Config #0: type 0x01 len 2
> src/shared/bap.c:ep_status_config() Codec Config #1: type 0x02 len 2
> src/shared/bap.c:ep_status_config() Codec Config #2: type 0x03 len 5
> src/shared/bap.c:ep_status_config() Codec Config #3: type 0x04 len 3
> src/shared/bap.c:ep_status_config() Codec Config #4: type 0x05 len 2
> src/shared/bap.c:bap_stream_state_changed() stream 0x60c0000334c0 dir 0x0=
1: idle -> config
> src/shared/bap.c:bap_stream_update_io_links() stream 0x60c0000334c0
> profiles/audio/bap.c:bap_state() stream 0x60c0000334c0: idle(0) -> config=
(1)
> profiles/audio/bap.c:bap_ready() bap 0x60e000001d20
> profiles/audio/bap.c:pac_found() lpac 0x608000017520 rpac 0x6080000183a0
> profiles/audio/bap.c:ep_register() ep 0x60d000006910 lpac 0x608000017520 =
rpac 0x6080000183a0 path /org/bluez/hci0/dev_C9_C9_76_21_08_4F/pac_sink0
> profiles/audio/media.c:media_endpoint_async_call() Calling SelectProperti=
es: name =3D :1.604 path =3D /MediaEndpointLE/BAPSource/lc3
> ...
> src/shared/bap.c:bap_stream_state_changed() stream 0x60c0000334c0 dir 0x0=
1: config -> config
> src/shared/bap.c:bap_stream_update_io_links() stream 0x60c0000334c0
> profiles/audio/bap.c:bap_state() stream 0x60c0000334c0: config(1) -> conf=
ig(1)
> ---
>  profiles/audio/bap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
> index b74498c4c..30a585ede 100644
> --- a/profiles/audio/bap.c
> +++ b/profiles/audio/bap.c
> @@ -1887,7 +1887,7 @@ static void bap_state(struct bt_bap_stream *stream,=
 uint8_t old_state,
>                         bt_bap_stream_statestr(old_state), old_state,
>                         bt_bap_stream_statestr(new_state), new_state);
>
> -       if (new_state =3D=3D old_state)

Add a comment regarding reconfiguring allowing the state machine to
transition to the same state.

> +       if (old_state =3D=3D new_state && new_state !=3D BT_BAP_STREAM_ST=
ATE_CONFIG)
>                 return;
>
>         ep =3D bap_find_ep_by_stream(data, stream);
> --
> 2.41.0
>
>


--=20
Luiz Augusto von Dentz
