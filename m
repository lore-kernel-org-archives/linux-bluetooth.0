Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD2E8248B
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 14:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754923143; cv=none; b=YnIMiO6s4mzZYIvB+SamwC3QYip38B3zlZeZEuKo+abJhZLzp/SiMCTwc9dfvaq+i78Zc29R8CbDZ4isKrlveTGV1xNRzhnI/T13TdIPywopREfva24puq5hfppt1Q8JgwDnBUq2w+1rHRu5l/if8zriTNY/ZD8CLZfC9Jf2IG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754923143; c=relaxed/simple;
	bh=/Yt5Bh6UOfGXEYLZqAKsNyd+KllUgH8Ay9Nn4aBzjww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e+ya8MSwnJn23Kz1bucBn+wfJL/4Ge7ab/DQnkrlVruHSXTTV1e3i29KiKBaAXo2t9JLYNcjCJ2D4DEL9b58+ZPthgE5MXqHnXtfS4HW0DIoOtZpIupim/YpND+XqymZgo1fyaSz732vt6TiTzu0KCbd6K58ioHg0DoEyEI0e0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/MPgidg; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/MPgidg"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3324e2e6f54so49751491fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 07:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754923140; x=1755527940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMf9tAQdahSxVNZ91+Lfrl0LrtL8Fw5gQghTpKZR0yU=;
        b=G/MPgidgJdBFobhXKqQVRHG7k1wf5hW8rlIabp2o3JIVsKMEvFz5W+BjlHt8uC3AiC
         IfXQId2CS4XDNy/tTAdBq33NDh9AHiUVBf6ajE6uYxOBPXRM0kGuiBnUfC2cXC19UBWV
         5kQtQXLNR2bHXdR607O3B6ScDDYW3DYMh+57f67uSENyGDent6Y0nWs/z5CGXz8WaFKN
         2SOsB9WPSPAlOHRZI9wGuYwbeT5eEwaKQkxeIgcBQjy7yRqFeifAjmVSbgkBN2seg58P
         UbS7HMUw/HtVQYY4MYoaSC2u2oP32xhC3Zx7YkUdyK+QMfQM6sbuwmR1VWWbtqZJQzEQ
         VlSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754923140; x=1755527940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zMf9tAQdahSxVNZ91+Lfrl0LrtL8Fw5gQghTpKZR0yU=;
        b=t7rH414PzFQayPZNfCXLsa4a8phAjZmyugLNX+eyxil+aaUsu7ZFlw4f+uzyPAcQY6
         xuJLQchQNZjEkJgEfoxqwML27vjHA5suvxuIA5NcPilVeIhJoXLj2Kxx7WhA+IAwPPSf
         ZPPqhkDdCvUg5k0KLx/YpF1jHitB0N5cD60BpXeN+e+1YBIQuFTFK1IJgEDEVWtyCc6+
         UEqey0kEqspsCHPCa8TVrzzH7nE+1oOfhp6pGPtTuQPmFsgDIUHn/R2wnIEOr1iba0s9
         oC7Jc2MmCTN+ZRoe0hJhnbuvARWzQNFhBpnCw013O2C9NuKCjI7hgGL5Hm1KLO9pLrLO
         6Mwg==
X-Gm-Message-State: AOJu0Ywxlhc33iNIVxRo2UT9n/xt62gYb8I5lhHW75LVyLsla/Nb1G5+
	TLxZIELL1Tlm4YLJt/bC9LMUCWe4QrKglGO/FySOWtCArCukPdb7wLAfFKsb3Pqn1COKeZ7sBN+
	C2vlj3Emv36eNN/+CyHgo81qnPu7fgegSqQ==
X-Gm-Gg: ASbGnct6bVgMoKcyHk+gTcBeuAMCLNoHTgtfFrC6I8VZ2hPi9PIbhnTnC1Hw9638DBf
	Nl3u9uOa4/NobTYkxfLc/RMwhoT7HniCOXjMjEpNDTYDDWhMhgJR3ezK7oJJvliKb6vTwXoOPzk
	6PQ3Vw+zGGjHi6Als4ncv7k6t1m4LToXQJLpbZV6SewUH7R1ymfz60ysRQPtYWRxRl4Wy1SuobJ
	lrLfw==
X-Google-Smtp-Source: AGHT+IHdJFZ89DhdUrDvrW0UVQKg3jx77EvmBrqalIIJqAcd827IC7HzG/CHHcuI58TA0T39/u1hIPvMnK+asaJDUWs=
X-Received: by 2002:a2e:a5c6:0:b0:32b:4521:73d1 with SMTP id
 38308e7fff4ca-333d62b442bmr92981fa.20.1754923139458; Mon, 11 Aug 2025
 07:38:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d31b0994cc4ffa178f044be156e95324bdc0e64b.1754849783.git.pav@iki.fi>
In-Reply-To: <d31b0994cc4ffa178f044be156e95324bdc0e64b.1754849783.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 11 Aug 2025 10:38:47 -0400
X-Gm-Features: Ac12FXxRW23xmMwsBki3f5cHlEkycaKNdkiToRdnrgmq30zrxOJCbVgnYygjDsk
Message-ID: <CABBYNZKpYS=55P06PendXTT-VF+hyMqd4n94koXWrtbc9Li14Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ] shared/bap: reset local ep states on bap session detach
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Sun, Aug 10, 2025 at 2:18=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> When detaching BAP session, the session is removed from the global list,
> and streams do not go through normal state change cleanup, so local
> endpoint states are not cleaned up. This causes problems as ASE may be
> in busy state even though there is no stream.

Why wouldn't they go through the normal state change cleanup though,
the stream shall be set to idle and then affect the endpoint state as
well or we do have something preventing that to happen? Or the
local_eps are not used as stream->ep for some reason?

>
> Fix by resetting all ASE to IDLE state after detaching all streams.
> ---
>  src/shared/bap.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index ed5c322b4..d4beb9818 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -5664,6 +5664,14 @@ static void stream_foreach_detach(void *data, void=
 *user_data)
>         stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
>  }
>
> +static void ep_foreach_detach(void *data, void *user_data)
> +{
> +       struct bt_bap_endpoint *ep =3D data;
> +
> +       ep->state =3D BT_ASCS_ASE_STATE_IDLE;
> +       ep->old_state =3D BT_ASCS_ASE_STATE_IDLE;
> +}
> +
>  static void bap_req_detach(void *data)
>  {
>         struct bt_bap_req *req =3D data;
> @@ -5696,6 +5704,7 @@ void bt_bap_detach(struct bt_bap *bap)
>         bap->att =3D NULL;
>
>         queue_foreach(bap->streams, stream_foreach_detach, bap);
> +       queue_foreach(bap->local_eps, ep_foreach_detach, bap);

This sounds more like a workaround though, the stream_foreach_detach
should have cleaned up all existing streams and their endpoints, we
could perhaps print a message if the ep->state is not idle then it
means something is not quite right.

>         queue_foreach(bap_cbs, bap_detached, bap);
>  }
>
> --
> 2.50.1
>
>


--=20
Luiz Augusto von Dentz
