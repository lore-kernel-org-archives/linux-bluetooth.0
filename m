Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5B62136C
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Nov 2023 15:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFR5UP2/"
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C152D63
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Nov 2023 07:39:47 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c7c7544c78so49643211fa.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Nov 2023 07:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699889985; x=1700494785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spVD9maHgn3dOFVV+RPSCQb+mrzjmOAHBFl+UUggONo=;
        b=eFR5UP2/5ynX/VNzxkeYrMd+20/u9Kp0pt1hIVT8vtQM1IlN5ewOU4vsztKkbH5uLY
         o6nnEOkiXePwR9E04Qf3HMRk/j/pBTFiaAekMsh631b95zzstyQL7j6Ij037ujbfjcHQ
         C+PgD4UUq+6ziR1YhAei76hAqq0I8ZoVZFL34Kl9s0cHfHmuA7Whk2n3psPYzbWiiRFY
         WSsHVWSvPf7HgkSfFhwjpGMxHPzN+0BcYMkIKZG32zpD5qfAXPXBrq8JBAnKFc0F4W6s
         vRaY6i8J2h+qPWGs+YJVbxvWz5x2uGLQl1EYMlvieXVKWk/82JD8U0FdVEYw3mZQVPPR
         3izg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699889985; x=1700494785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=spVD9maHgn3dOFVV+RPSCQb+mrzjmOAHBFl+UUggONo=;
        b=G+9pBI2bUUoMVpjb81leThgA8oF27mglhjuIOWWQyNYdukmdsAWwuSzfB7JsGB9kh7
         7T8bXdz7/G8Lchr6ECK1xAr7myfgvyyxByiML3xrtSCF80eEzGBjR2WGZi0AdT1nAzz4
         UW1qxbpGeIEG9ME/0A+PYkl0pZ8X2c/GTxjN/QnIyvW2yafnG5aisFkzrG99LS5jaguZ
         bdehon+twlulTYsjDm31mbhGMkMTXxoc9UFjLCIX+/0DpUiBcqlEOsVsBnWpRztkiMTt
         XOZpjUyiQq0cwnzmJpPHwuh9gTRxYaKvdn9C3SUaglzJr06fa8sB+atMqfbfyjGH/61k
         TMZg==
X-Gm-Message-State: AOJu0YwMz1jMOTLhGB1Bvs+fmo9uozkZWMU8CtkqPlSfjoRpRlOHWryA
	EYys5HCx01NMcIe7QUf2EXKhDlV/YxTggtKttvAtkXoD9rk=
X-Google-Smtp-Source: AGHT+IFgEtjSgVU5DslID2VpjiHKn8hqiZP4+wrbqiHcALfOJBfVCWh5yzSrM1650Rkzok/kL10WQ30/X7j84npTMlw=
X-Received: by 2002:a2e:9416:0:b0:2c5:1c9d:7f81 with SMTP id
 i22-20020a2e9416000000b002c51c9d7f81mr5387288ljh.32.1699889985239; Mon, 13
 Nov 2023 07:39:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b48261aeab5a4f5927c9da5296b2ffb079bee375.1699802164.git.pav@iki.fi>
In-Reply-To: <b48261aeab5a4f5927c9da5296b2ffb079bee375.1699802164.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 13 Nov 2023 10:39:33 -0500
Message-ID: <CABBYNZKFP9SiEcrcNM3ASRXmDqt2+CUngEpMFaMtrBymq5u28Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/4] shared/bap: add bt_bap_stream_config_update for
 updating QoS choice
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Sun, Nov 12, 2023 at 11:00=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Add bt_bap_stream_config_update for updating the QoS while in Codec
> Configured state.
> ---
>  src/shared/bap.c | 18 ++++++++++++++++++
>  src/shared/bap.h |  3 +++
>  2 files changed, 21 insertions(+)
>
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index 13bbcf793..d90e39f7c 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -4600,6 +4600,24 @@ unsigned int bt_bap_stream_config(struct bt_bap_st=
ream *stream,
>         return 0;
>  }
>
> +int bt_bap_stream_config_update(struct bt_bap_stream *stream,
> +                                       struct bt_bap_qos *qos)
> +{
> +       if (!bap_stream_valid(stream))
> +               return -EINVAL;
> +
> +       if (stream->ep->state !=3D BT_BAP_STREAM_STATE_CONFIG)
> +               return -EINVAL;
> +
> +       switch (bt_bap_stream_get_type(stream)) {
> +       case BT_BAP_STREAM_TYPE_UCAST:
> +               stream->qos =3D *qos;
> +               return 0;
> +       }
> +
> +       return -EINVAL;
> +}
> +
>  static bool match_pac(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
>                                                         void *user_data)
>  {
> diff --git a/src/shared/bap.h b/src/shared/bap.h
> index 23edbf4c6..099c2edd0 100644
> --- a/src/shared/bap.h
> +++ b/src/shared/bap.h
> @@ -255,6 +255,9 @@ unsigned int bt_bap_stream_config(struct bt_bap_strea=
m *stream,
>                                         bt_bap_stream_func_t func,
>                                         void *user_data);
>
> +int bt_bap_stream_config_update(struct bt_bap_stream *stream,
> +                                       struct bt_bap_qos *pqos);
> +

Can't we just make bt_bap_stream_config do update the config in case
it is for a broadcast? At least to me it seems a much cleaner approach
then starting introducing new functions where the user needs to know
when they should be called, etc.

>  unsigned int bt_bap_stream_qos(struct bt_bap_stream *stream,
>                                         struct bt_bap_qos *qos,
>                                         bt_bap_stream_func_t func,
> --
> 2.41.0
>
>


--=20
Luiz Augusto von Dentz
