Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD6D6BB3C
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Feb 2024 17:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708450350; cv=none; b=fbrNn+bQTpVtwkPbAO/BW+BRZAG3ezvJS4JR/V/Z1DyhhIEENe741wOpnaCinmPvGa9jr3bUsZWLK8qyPOTTCzUrUztRZFyUMxjhn5p7QXzGIZyKF6ztXAYCQIfJfG0KTbOhHiOjpXx7tIYu4LAOYIq/O7gkRSIqsN4RWyiS3sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708450350; c=relaxed/simple;
	bh=EeMfHNLhLXLA9MtI2LEX67JaNMfoWqexJrk6k5XnB5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h90haMlVvY7Nnlj5f2WU+yIsiTKGa/fWVkRsIsoNAhGJCoJh7WUKNumTGPRZsstOrkHAEAxUWNn95mh86IkzXt9igFzfQOe+wzAW3Sk3FfVW751SX6kDfpUU3Z7awZKRQVMwEdbl+KazU3JevuqgddsNjfImFg0imOZUCcb3eu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdAJV7kB; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdAJV7kB"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d23a22233fso28857251fa.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Feb 2024 09:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708450346; x=1709055146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81yMUNpgJD1PwEKi34be1wDzTREbTsEmno7qnXycmSk=;
        b=bdAJV7kBLVN14jG5Rs1Lp1UrOtOpt2+D9QofBNbrnzU2dULDv/hKcokpG7zY6IZ41D
         s5Qriu2kCf+/gJ1Ly3VKMVZbjnsjUj73c+a+d5rVFLkFgnuyDdx6+qZFySUGKl0P7RBY
         CFicyOFzdVDJHxlSnR6Y3JmhahmKt0OUM2IsUOdXg0IJ/KjY4e78p1VLtamp4kzuzLEm
         BqlkF7rrWnoE84Dh/eRrF5oxsGoss2KZ26akxMMMdUdSspfwKdHeH7Ce5GadV4N+yrBL
         rL/8zIcylFgB03Y+HpnBSI4z1CEOpfeYpUvSIgxM6H3+iZD7ZYSjumxSpGvCKYSCcElC
         uEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708450346; x=1709055146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=81yMUNpgJD1PwEKi34be1wDzTREbTsEmno7qnXycmSk=;
        b=I8QxX6VsemPyxc1LL2Yf0lqLswOBo5AF9fXNIcAcbAEJfrtC6p+FUmSPRKPmbzTWkP
         IRtP2aAO0GfzDZ9roWrEavwm9e0Xy47p67wLCt9uorXXiySoE0EAjFgotTGs563P8aLj
         AcjqxQ2K0lkdvXurZQmDM1AEZkEnRvSv2GWjqRee9OAgDbRmSXR8biSc7CsXlqUx2wuM
         Ds2E24ilrtT4JTbayva0sv/d3554idcqvZu6rZjMVFaSr9Eee3hwj9/6EUneXWhJOtAV
         u+HcUXWwrzPd9Hlc4KnprpBR2yI/+RRkad1fIYiW+RzQ6rB0EHLzEV+tYNa1IP2Ysskx
         gdnQ==
X-Gm-Message-State: AOJu0Yzp0zkViIABWPnDJOeedEJX4UmfDwXNbIgigtgfjtuNlEmWmso9
	g3h4hdiqJvZnqOBHvfbzzsXYq4ygxCn1N221YCeWFJ8DMprVzHWbbG1zxYUJc7Y9xKpSEgZnq6F
	IfmmgSx/1bjmzl68IpUDm1PjG6qjXDwBl
X-Google-Smtp-Source: AGHT+IEUslnYl5TYVe8QrhlE8h0cRo6DOGc/IS44/hf74mBe76fuEY9GPRNCVpNN9k08pfSnIZo1eYnnNHX9eYytzPQ=
X-Received: by 2002:a2e:8290:0:b0:2d2:1fed:a679 with SMTP id
 y16-20020a2e8290000000b002d21feda679mr7159889ljg.7.1708450346130; Tue, 20 Feb
 2024 09:32:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219121509.5702-1-andrei.istodorescu@nxp.com> <20240219121509.5702-4-andrei.istodorescu@nxp.com>
In-Reply-To: <20240219121509.5702-4-andrei.istodorescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 20 Feb 2024 12:32:13 -0500
Message-ID: <CABBYNZJyD4usWXv4fbp641_CmnmZamd=juGnBQgiAtGnFKfgkA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 3/4] shared/bap: Add Broadcast QOS copy functions
To: Andrei Istodorescu <andrei.istodorescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com, 
	silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com, iulia.tanasescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrei,

On Mon, Feb 19, 2024 at 7:15=E2=80=AFAM Andrei Istodorescu
<andrei.istodorescu@nxp.com> wrote:
>
> BAP works with bt_bap_qos structures and kernel with bt_iso_qos. These
> functions are utilitary functions to allow jumping easily from one
> structure to another.
> ---
>  src/shared/bap.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  src/shared/bap.h |  4 ++++
>  2 files changed, 48 insertions(+)
>
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index c3d96c08fddc..19e40e3c70f4 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -6527,3 +6527,47 @@ void bt_bap_parse_bis(void *data, void *user_data)
>         queue_foreach(subgroup->bises, bis_to_pac, subgroup);
>         cleanup_subgroup(subgroup);
>  }
> +
> +void bt_bap_bcast_qos_iso_to_bap(struct bt_bap_qos *bap_qos,
> +               struct bt_iso_qos *iso_qos)
> +{
> +       bap_qos->bcast.big =3D iso_qos->bcast.big;
> +       bap_qos->bcast.bis =3D iso_qos->bcast.bis;
> +       bap_qos->bcast.sync_factor =3D iso_qos->bcast.sync_factor;
> +       bap_qos->bcast.packing =3D iso_qos->bcast.packing;
> +       bap_qos->bcast.framing =3D iso_qos->bcast.framing;
> +       bap_qos->bcast.encryption =3D iso_qos->bcast.encryption;
> +       if (bap_qos->bcast.bcode && bap_qos->bcast.bcode->iov_base)
> +               memcpy(bap_qos->bcast.bcode->iov_base, iso_qos->bcast.bco=
de,
> +                               bap_qos->bcast.bcode->iov_len);
> +       bap_qos->bcast.options =3D iso_qos->bcast.options;
> +       bap_qos->bcast.skip =3D iso_qos->bcast.skip;
> +       bap_qos->bcast.sync_timeout =3D iso_qos->bcast.sync_timeout;
> +       bap_qos->bcast.sync_cte_type =3D iso_qos->bcast.sync_cte_type;
> +       bap_qos->bcast.mse =3D iso_qos->bcast.mse;
> +       bap_qos->bcast.timeout =3D iso_qos->bcast.timeout;
> +       memcpy(&bap_qos->bcast.io_qos, &iso_qos->bcast.out,
> +                       sizeof(struct bt_iso_io_qos));
> +}
> +
> +void bt_bap_bcast_qos_bap_to_iso(struct bt_iso_qos *iso_qos,
> +               struct bt_bap_qos *bap_qos)
> +{
> +       iso_qos->bcast.big =3D bap_qos->bcast.big;
> +       iso_qos->bcast.bis =3D bap_qos->bcast.bis;
> +       iso_qos->bcast.sync_factor =3D bap_qos->bcast.sync_factor;
> +       iso_qos->bcast.packing =3D bap_qos->bcast.packing;
> +       iso_qos->bcast.framing =3D bap_qos->bcast.framing;
> +       iso_qos->bcast.encryption =3D bap_qos->bcast.encryption;
> +       if (bap_qos->bcast.bcode && bap_qos->bcast.bcode->iov_base)
> +               memcpy(iso_qos->bcast.bcode, bap_qos->bcast.bcode->iov_ba=
se,
> +                               bap_qos->bcast.bcode->iov_len);
> +       iso_qos->bcast.options =3D bap_qos->bcast.options;
> +       iso_qos->bcast.skip =3D bap_qos->bcast.skip;
> +       iso_qos->bcast.sync_timeout =3D bap_qos->bcast.sync_timeout;
> +       iso_qos->bcast.sync_cte_type =3D bap_qos->bcast.sync_cte_type;
> +       iso_qos->bcast.mse =3D bap_qos->bcast.mse;
> +       iso_qos->bcast.timeout =3D bap_qos->bcast.timeout;
> +       memcpy(&iso_qos->bcast.out, &bap_qos->bcast.io_qos,
> +                       sizeof(struct bt_iso_io_qos));
> +}
> diff --git a/src/shared/bap.h b/src/shared/bap.h
> index aed3bf52b8d9..968257651766 100644
> --- a/src/shared/bap.h
> +++ b/src/shared/bap.h
> @@ -354,4 +354,8 @@ struct iovec *bt_bap_stream_get_base(struct bt_bap_st=
ream *stream);
>  bool bt_bap_parse_base(struct bt_bap *bap, void *data, size_t len,
>                 util_debug_func_t func, struct bt_bap_base *base);
>  void bt_bap_parse_bis(void *data, void *user_data);
> +void bt_bap_bcast_qos_iso_to_bap(struct bt_bap_qos *bap_qos,
> +               struct bt_iso_qos *iso_qos);
> +void bt_bap_bcast_qos_bap_to_iso(struct bt_iso_qos *iso_qos,
> +               struct bt_bap_qos *bap_qos);

Not sure if that is the best place to have this sort of helper
function, usually bap.h don't have to deal with bt_iso_qos, also this
seems to not care about unicast either.

> --
> 2.40.1
>


--=20
Luiz Augusto von Dentz
