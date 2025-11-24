Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7887531327F
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Nov 2025 16:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764001245; cv=none; b=jxV5b2u6CYOu03rRDbDRaK3Mq3A9y/F4poB1L2ayaQsxgU76VLMrZ+9+GvU1dCgHsgZ+tcYA0x8HxhQB/3G8m7qywRdM81hOVAfXAAcMiaEwCPIgJank2DU8dJpBLxFqckWoNUksjznyzdyGrYQpyex4+a0+oWc3WNWCDHMZ5ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764001245; c=relaxed/simple;
	bh=I02F2hUL51EX1wO5lM11v8AfKfKVnVvj2+NgjUH99RY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K9nDwU+zmHb6axWssRmVZM1dnhJYhu3plpxYjQ+7zzX9zF2Lw8E2JU7LDC9vFkJW/JTBfNTgORN2fqu/zWYr+YuCK03xQD6028lO2mSlljZnVJB/pBONpGhYRUvjBse5oM85OmFx7aRw4fNq5vTAEvycrP2KpcaMFqPkK/dxSiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEj3Drnq; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEj3Drnq"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-37a5bc6b491so7759611fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Nov 2025 08:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764001242; x=1764606042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kb3srsmgPT3cmAxfja+qfbBxD4EIVKlAs0xBvymCTJg=;
        b=eEj3DrnqHFsdU5v26PylLJsqCmxZZB39/Bi/pRuezLS06/HkyABl38hzt5TVPC0qLi
         AbZlsKhWcGCY6wwew1Hc+m+dKdXWeCn9loGm0WgqesRNRj50PClnr411y2Q8AF/OpyGk
         8RXj39yJUCOthCsBB/t0kyunVpSAZWF+puBZBrYOhphv5FE3tGSClvSA7uEdHVLNZ/Hv
         22LKgXJHApT7+kvXUkfQnKVGUCJUDaUVVEI8s95I4Bw40jBgw/FwoGY97CCH75i1xDDo
         w4SrAiITivuRpjeYjrQic7gjwb4toZDov6mUexl7Vq3HV3GKF6k81hcKWSgDVLfFMrmV
         oCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764001242; x=1764606042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kb3srsmgPT3cmAxfja+qfbBxD4EIVKlAs0xBvymCTJg=;
        b=ntlpBhrbCVBUrlHbeqNBWRIDrRpBA6wEQKyBvNL20GnpyLyhGKeEJnEinQAHMdBKum
         LMx4rQoueceSQXHum/wKDxmvA0dw1mDrrTBfOfpErEE4D11D8pTiTjaAXLdj+4uonXlA
         UTijHqSV3D4bKkgAa3HOnEijAQ/45781YklD658k3iMJ9ZWhvQ9sfGMtGws1V/QCUeGd
         LVjbFKkIfEn0SoRSMGTPbEDeCdX6Dfddu7vVjGZwJwofkksgHu1PxE1Cbkmyvtlu18tN
         UVXa8pkfG3ZK6YrDFXvp8oDq0u6g7BkZVw5Kn2tEQxkdWe55+cXjq6QGID5lo/OUPvm6
         T/LA==
X-Gm-Message-State: AOJu0YwyqE/7XPmI+eMMDrIzqah6teudiXqyVzChdxhbp1dkb9iYNXpo
	KwSxWMkUYNvNL8vz3hpKOp2y603dckY0buV4YC9atRdxaeW5npVosCme4uq9Ovp6c0PG97nhnkI
	LNF6qjuHGahKeUVSvTxFLoG0ED3HcPPZjqNZ2
X-Gm-Gg: ASbGncuZo0du+xYT7gqJJuIXGwwgq1/mDMD4SSgW/AeyxKsTSerNxAtb77FAbmGQkvw
	sQnpQr9MkULM8G/qPfhAz0r1mAmRrx6d3tf/Ue5TQ3F6QceB0HFfubwDCnVKbLVapCkW3fVVWjX
	J1BraXs7BKdscJOHxJd4vHj6UHJy6mcdyFh9z0cItZhlDvVH+mUdC5LyYQPmogHeQh6pFWptRG7
	RP9suL6Jol+VQPcLMGDf9s1PyPb+/oCJbWuLOIUPrUxU32Quk/WAluHadVb+C4YtfaLtHoDdGUD
	A+TN
X-Google-Smtp-Source: AGHT+IE53W8RHdlhgHA2UF6BNlkG8ytBlcifcWU6534vENY7RCqTuusk1r0M8uRbnUHsHvOvYfhyk2CoM91nKGSWUl0=
X-Received: by 2002:a05:651c:41d8:b0:372:904d:add4 with SMTP id
 38308e7fff4ca-37cd921c1c9mr32153581fa.28.1764001241284; Mon, 24 Nov 2025
 08:20:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1763914558.git.pav@iki.fi> <5cdb0dfff2fef6a269b6e3b990059ea8966df086.1763914558.git.pav@iki.fi>
In-Reply-To: <5cdb0dfff2fef6a269b6e3b990059ea8966df086.1763914558.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 24 Nov 2025 11:20:28 -0500
X-Gm-Features: AWmQ_bk6Hu3lhs4sh3sQcgilRn-sMqPg4YgahsBnvcWZmdrcS_hOHYC28wldpxY
Message-ID: <CABBYNZL1qBjvnYir5eXrWKnj4HBSct09o-EtgsENv6+Lq3BQnQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 09/10] doc: org.bluez.MediaEndpoint: add SupportedFeatures
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Sun, Nov 23, 2025 at 11:18=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Add SupportedFeatures field for indicating TMAP & GMAP roles and
> features.
> ---
>  doc/org.bluez.MediaEndpoint.rst | 99 +++++++++++++++++++++++++++++++++
>  1 file changed, 99 insertions(+)
>
> diff --git a/doc/org.bluez.MediaEndpoint.rst b/doc/org.bluez.MediaEndpoin=
t.rst
> index c1ce1d562..dd4f03e0d 100644
> --- a/doc/org.bluez.MediaEndpoint.rst
> +++ b/doc/org.bluez.MediaEndpoint.rst
> @@ -299,3 +299,102 @@ Indicates QoS capabilities.
>  :uint32 PreferredMaximumDelay:
>
>         Indicates endpoint preferred maximum presentation delay.
> +
> +array{string} SupportedFeatures [readonly, ISO only, experimental]
> +``````````````````````````````````````````````````````````````````
> +
> +List of strings that represent supported features.
> +
> +Possible values:
> +
> +:"tmap-cg":
> +
> +       TMAP Call Gateway
> +
> +:"tmap-ct":
> +
> +       TMAP Call Terminal
> +
> +:"tmap-ums":
> +
> +       TMAP Unicast Media Sender
> +
> +:"tmap-umr":
> +
> +       TMAP Unicast Media Receiver
> +
> +:"tmap-bms":
> +
> +       TMAP Broadcast Media Sender
> +
> +:"tmap-bmr":
> +
> +       TMAP Broadcast Media Receiver
> +
> +:"gmap-ugg":
> +
> +       GMAP Unicast Game Gateway
> +
> +:"gmap-ugt":
> +
> +       GMAP Unicast Game Terminal
> +
> +:"gmap-bgs":
> +
> +       GMAP Broadcast Game Sender
> +
> +:"gmap-bgr":
> +
> +       GMAP Broadcast Game Receiver
> +
> +:"gmap-ugg-multiplex":
> +
> +       GMAP UGG Multiplex feature support
> +
> +:"gmap-ugg-96kbps-source":
> +
> +       GMAP UGG 96 kbps Source feature support
> +
> +:"gmap-ugg-multisink":
> +
> +       GMAP UGG Multisink feature support
> +
> +:"gmap-ugt-source":
> +
> +       GMAP UGT Source feature support
> +
> +:"gmap-ugt-80kbps-souce":
> +
> +       GMAP UGT 80 kbps Source feature support
> +
> +:"gmap-ugt-sink":
> +
> +       GMAP UGT Sink feature support
> +
> +:"gmap-ugt-64kbps-sink":
> +
> +       GMAP UGT 64 kbps Sink feature support
> +
> +:"gmap-ugt-multiplex":
> +
> +       GMAP UGT Multiplex feature support
> +
> +:"gmap-ugt-multisink":
> +
> +       GMAP UGT Multisink feature support
> +
> +:"gmap-ugt-multisource":
> +
> +       GMAP UGT Multisource feature support
> +
> +:"gmap-bgs-96kbps":
> +
> +       GMAP BGS 96 kbps feature support
> +
> +:"gmap-bgr-multisink":
> +
> +       GMAP BGR Multisink feature support
> +
> +:"gmap-bgr-multiplex":
> +
> +       GMAP BGR Multiplex feature support
> --
> 2.51.1

I wonder if it would make sense to add a sublevel as UUID followed by
the feature set, this is a little bit more streamline since there is
just one level though since you are prefixing the profile friendly
name, that said I think it having a multilevel is probably going to be
easier to maintain since the value domain would be per UUID rather
than global.


--=20
Luiz Augusto von Dentz
