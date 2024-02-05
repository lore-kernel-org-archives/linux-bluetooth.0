Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340D73B18D
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Feb 2024 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707147069; cv=none; b=flMbi/O3DRTic3m6WuhFqxlRzvlbFGVl97xBEj/sJHVC1AEmhBuX/YCPrYlOaTOvi7ZkIaJRCUFIEatrX5ndKM8rhWPZlebH+/gBRpuCuUSg5NsGReZqY+XXlIZzyz2HSo+dinC267h5U3SSeJH/qUFeJrD1wKZq9Uy3lRPxUB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707147069; c=relaxed/simple;
	bh=m4eGtCxdfhjPBwR7e3QJYNaubLBopgYaNk8cje+dCfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=esDhXniqea8WA92dtmTc4+5Ccuaqv0CYNlxaTIdvz0GeL0cmgH1bvZYm5ywMIIrVA3J5spAdcczATh5LRfX4kfliN0IS1EOi3wCfnPoQDP6T8xbdM4PrxsHz8GrNYpSDsP51i3QgIs5QGEGWSuV7gzqGWjwVsB173tPtgsiH2sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERFq9PK/; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERFq9PK/"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2cf4fafa386so57602461fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Feb 2024 07:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707147066; x=1707751866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5e00uIeyI6OC8H73sn42u4p1ZeS1NP4/QwP/wv6XXEo=;
        b=ERFq9PK/mP26/1vRch/nhZQ3rJcKpJNoKY36c9fIqF+O2S7bniHloYw39arruqbrpP
         HIG0CaoNeyAZSUHPBLl3rQHcS6vBCMtpk68VZqDebRsdNIHn/1Bk4hfHydUGSOK2Va+F
         kq9rfpSJ+8a6/hu4oyCkUnpXaHYvzqzZqJuPZrYhlgdCMJKtJP1A4pwvZa33HSUyCsyt
         1yPU/AlImMRnDed0aQKVDsi0BWe0/O2TJCplQDxoayPOws1JJNiDry7X9JGgZFOgaXSy
         +vjTCH4yAQ5ln0Er47GTA4gxoSlV7NTuQEE02DN8MbEvwNEjfpKWzLLJ4tcizYU4jc54
         nq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707147066; x=1707751866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5e00uIeyI6OC8H73sn42u4p1ZeS1NP4/QwP/wv6XXEo=;
        b=qnzQ1ri33V9kBPWIQBbK8hSJydGSJ1P4kbc/ZZajfMYNUqMg3/J6IaKtrFQLCalogR
         dlP/FDMTRXsUTVhF6NkOWZg+TpTF0KEa7Ibp7dAT9Zh+Ov7Nv0pCL77TXqmPiZX1HnBj
         9BmrNB7+6nDckP4HJsseCicGUDasbTCTGjPQRG+U/vtHJyyzB5cR96qd+GqUp7EaVkxr
         7s/Xc09A28q8YaJZJWkJFoq2bnvvjXSeKKRxYVJP2LJ5X0zWC5nobeAwQQNr9yjFfTjR
         oeZ8VmQsEOhps8VFfxEPHG0emsmkaOedGYZOVbgHeCyLD/P6u9gQi49HRaelg0oTX0X+
         76hw==
X-Gm-Message-State: AOJu0YxvROQRUIhmnN/c+BYpP+cyMK7ZVUJgM8MWllcmizLQWMDxXh9T
	iAxBoVLpT2/u6Kj2S5GnvHAUCOQMFxkXWNUoGGaP0H1d7B6JzfIYv3nU7O9xOqEGbU+UNuJvG8p
	o0dwbnCCy5xQFWzIoWq/71PXlKBswfANz
X-Google-Smtp-Source: AGHT+IEXIhmXa3bqubRxEGq3I7/DQKGbN7gUnCAvb3Be4ino8c6UsOPoozQy/BgWGIEMiY4h3A5suajSyJLlU4qm6d0=
X-Received: by 2002:a05:651c:32a:b0:2d0:a105:4937 with SMTP id
 b10-20020a05651c032a00b002d0a1054937mr23875ljp.52.1707147065885; Mon, 05 Feb
 2024 07:31:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b02d20dd168627b35016dfd0b56beb4a3a8755bd.1706904250.git.pav@iki.fi>
In-Reply-To: <b02d20dd168627b35016dfd0b56beb4a3a8755bd.1706904250.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 5 Feb 2024 10:30:53 -0500
Message-ID: <CABBYNZ+yD=ba=Sv0YU+LMh7qxMijxSFVCdzW9qm=309P2ra7XQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] monitor: parse Google's Opus A2DP vendor codec capabilities
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Fri, Feb 2, 2024 at 3:08=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Support parsing Opus (Google) A2DP vendor codec capabilities.

Add a sample output.

> ---
>  monitor/a2dp.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/monitor/a2dp.c b/monitor/a2dp.c
> index f6e99ab26..d26b679bc 100644
> --- a/monitor/a2dp.c
> +++ b/monitor/a2dp.c
> @@ -47,6 +47,8 @@
>  #define APTX_HD_CODEC_ID       0x0024
>  #define LDAC_VENDOR_ID         0x0000012d
>  #define LDAC_CODEC_ID          0x00aa
> +#define OPUS_G_VENDOR_ID       0x000000e0
> +#define OPUS_G_CODEC_ID                0x0001

Hmm, is this vendor-specific to Google? Don't we have it defined as an
optional codec nowadays?


>  struct bit_desc {
>         uint8_t bit_num;
> @@ -201,6 +203,24 @@ static const struct bit_desc faststream_source_frequ=
ency_table[] =3D {
>         { }
>  };
>
> +static const struct bit_desc opus_g_frequency_table[] =3D {
> +       {  7, "48000" },
> +       { }
> +};
> +
> +static const struct bit_desc opus_g_duration_table[] =3D {
> +       {  3, "10 ms" },
> +       {  4, "20 ms" },
> +       { }
> +};
> +
> +static const struct bit_desc opus_g_channels_table[] =3D {
> +       {  0, "Mono" },
> +       {  1, "Stereo" },
> +       {  2, "Dual Mono" },
> +       { }
> +};
> +
>  static void print_value_bits(uint8_t indent, uint32_t value,
>                                                 const struct bit_desc *ta=
ble)
>  {
> @@ -244,6 +264,7 @@ static bool codec_vendor_aptx_ll_cfg(uint8_t losc, st=
ruct l2cap_frame *frame);
>  static bool codec_vendor_aptx_hd_cap(uint8_t losc, struct l2cap_frame *f=
rame);
>  static bool codec_vendor_aptx_hd_cfg(uint8_t losc, struct l2cap_frame *f=
rame);
>  static bool codec_vendor_ldac(uint8_t losc, struct l2cap_frame *frame);
> +static bool codec_vendor_opus_g(uint8_t losc, struct l2cap_frame *frame)=
;
>
>  static const struct vndcodec vndcodecs[] =3D {
>         { APTX_VENDOR_ID, APTX_CODEC_ID, "aptX",
> @@ -256,6 +277,8 @@ static const struct vndcodec vndcodecs[] =3D {
>           codec_vendor_aptx_hd_cap, codec_vendor_aptx_hd_cfg },
>         { LDAC_VENDOR_ID, LDAC_CODEC_ID, "LDAC",
>           codec_vendor_ldac, codec_vendor_ldac },
> +       { OPUS_G_VENDOR_ID, OPUS_G_CODEC_ID, "Opus (Google)",
> +         codec_vendor_opus_g, codec_vendor_opus_g },
>         { }
>  };
>
> @@ -685,6 +708,27 @@ static bool codec_vendor_ldac(uint8_t losc, struct l=
2cap_frame *frame)
>         return true;
>  }
>
> +static bool codec_vendor_opus_g(uint8_t losc, struct l2cap_frame *frame)
> +{
> +       uint8_t cap =3D 0;
> +
> +       if (losc !=3D 1)
> +               return false;
> +
> +       l2cap_frame_get_u8(frame, &cap);
> +
> +       print_field("%*cFrequency: 0x%02x", BASE_INDENT + 2, ' ', cap);
> +       print_value_bits(BASE_INDENT + 2, cap, opus_g_frequency_table);
> +
> +       print_field("%*cFrame Duration: 0x%02x", BASE_INDENT + 2, ' ', ca=
p);
> +       print_value_bits(BASE_INDENT + 2, cap, opus_g_duration_table);
> +
> +       print_field("%*cChannel Mode: 0x%02x", BASE_INDENT + 2, ' ', cap)=
;
> +       print_value_bits(BASE_INDENT + 2, cap, opus_g_channels_table);
> +
> +       return true;
> +}
> +
>  static bool codec_vendor_cap(uint8_t losc, struct l2cap_frame *frame)
>  {
>         uint32_t vendor_id =3D 0;
> --
> 2.43.0
>
>


--
Luiz Augusto von Dentz
