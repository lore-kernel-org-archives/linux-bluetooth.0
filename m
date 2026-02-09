Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C502475F7
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Feb 2026 20:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770670777; cv=pass; b=no3hWQXfFQ9koo3NYrMIwN7iydV/pTxg/c7OZ38WQ2fHTvZ3UhbNN/27ISRG7rY5Tp0LSchD5FZBNyLZ5ZTNGj1g8oprNxnpi8z826s+QIAHjDPypzOI8KCMyi/Ysip/2aRsaUmwEtr3rz19c+5kfHrgH4Eb24R4ooYgusMfQug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770670777; c=relaxed/simple;
	bh=8rHp3vrfMjoGgrqPZfWT1UeyxOahswHFF6xi576VoEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kJs/944yw7d6tizfyoLrJ2jnS/hADugnciy431ZyeHGC0rJDPNv+7TCpyl3mnm8B3C0ojHFtmY9h2ysZKc5JGx0Edk6aM7OzWvDK3lf5TkgXDD3QBgFLLLt/zPMLEydGH1bIxauT0d/gbp4qBMuC0JYIyhMPY7skaiXaZXcwRyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cet4wHWm; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cet4wHWm"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7964f1405a0so12927467b3.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Feb 2026 12:59:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770670775; cv=none;
        d=google.com; s=arc-20240605;
        b=hXyIOz57OX2XvqlWaHiIMPOyrvKnAj4JokE0+DTQgDq7AqeYjoXKE+jPHRU9tS7L6R
         aNUKbE0zrOPcM39bjUOHp25Tsr4binzJcz/u+bdsRaPVMbFG+aByGIFobE/UpAIan8Xy
         aaPJuSJQOd2OHJvQcQGVU85A1EDqrxKEnpt0oSX2QKXG5eGETEcf7eOSwDKBUxPyqPxo
         m6hBTmnSWvYcfF7M58cl3yh43Y8pDt1TaelfvfOmYtmmpUPIOKSXDaRIywp16IKxuQJs
         i0Aj75wPTFTBf4XUCM8vdTQ0Q3WkujzDNWkv9NAk6TGeyFnDg1CBp4SKCluQgjEJc7Hb
         yS7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BcHooqqh9wfFdrg4geqT0rwP6cAsVaSy7mZTb15xsTY=;
        fh=7LSxPbV2pQSQb1EL9491hTkyd1MOd7S12ATM8//Ti7U=;
        b=OaxMUWpAo5S93ZSGutAyKCq4Jg7eJyBVPloM6bx81ms7pS5JaAOF//Mbba3s5pbC6Q
         +eFboP93wYH9NV+66fZUnEX2jsxvGs5+JQSTr6DyBd7Xlaj9NeAOolNDc4IKINwXwtAx
         xH1As0xcoU3Pir+wfw6DEaA1rMjqt21bPfeJIFYMvh6Vb48Aj0AcU4+FM9hoZroCb/rY
         Zo8xeEjjorcaM0qXSqinq7cEbbKF4EboVg47CdLV0q5x/Kj3LIDjGRPxKiL5KDvmu6NU
         u6TDl+mAeHMZaXVTLwQ2EHF997RGujfVPCEw4p9IpkXs1IBovA4hNZKY9UWt7hRa0+eW
         ZS4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770670775; x=1771275575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BcHooqqh9wfFdrg4geqT0rwP6cAsVaSy7mZTb15xsTY=;
        b=Cet4wHWmQdabuPw53SKJwcTNqXGjXS1CQMlvdMjs+8nnMO27gg0uS8HYk4sumllfg1
         t/ZRuQf6yWAQSxFVGCZ7eEo/78qnKTHXIFXe216VoeTTtqzvTjbdL+E04swki+X7Tjp1
         VM7xmjzV9nqaxsYnjjs/ztxxlSZY9L89FyS6nLUOxUoYx5kJCGS+sC1yfahNLXTnC6IU
         699MSKQu9mWRsrlHicFHUD4zR5tbSDBoeF4k7mZStxd3nTd5t4w1HyiNz70cwMuSzPYc
         YlOmrroMIwDMWUwu20sLBj7zBVCE2S25uM1ph47SIrQjY8MqsaWS+6WOWStvtqNdeShI
         3ijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770670775; x=1771275575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BcHooqqh9wfFdrg4geqT0rwP6cAsVaSy7mZTb15xsTY=;
        b=CJlB61hRSNN44U9SJc0WiZQwg62UYXNuZJfgKRkG2hfMDcQQBiPRQ6oskUTVZ9ppvL
         PufNzyZW49tI3JfreI5qdL0FO0V1v46EtIJUlj8WvwTtPSEsXSWscE1LXnl5qzfgR+zC
         CgosYB7TzMykf8OvneKedLExp/q78ak7LG+b7MvDLpb4UiD+jCMKwauEfu99347qA9Zu
         boMyrVWaeTV65l6XPojOQilrGuzEBQ3dxD+JY9Bm6aLjzJvuwTEj2JcQybUGeaO3cDAv
         g9LcaCU+3qf6ODk8u6IM9A+V7x6KH4YA1Js0gvvswD42X9o9/IXztVD4i4Wy5DQnHsfr
         eiNg==
X-Gm-Message-State: AOJu0YzSG6xL0yOnNfEN2ApvnwZpz2Qk1tLnveJYZTJC66LcMZdnPsMJ
	+jZ/qcORrEFivuWKQLa3IbA9C7GAEQpimlYNXqu7cEbeGLiebBgQRNUc19ZwGNP7w/vCYdVsEbW
	icNFpOeq60WdKU6rb47LJpgVHi4cttDg=
X-Gm-Gg: AZuq6aLHlsTCPFEcIrhphI7DB6YlxTOqXldCuRKfjtFJvvRQlyoJ3mKtF5OK96OUZHU
	Eas50iUPw9uk8xOaCejpMa/x6eXg46ut0fDiJXa9UEJnsv+k3auPQcNA4wL75XYmq7febYfxlGW
	mQDcdfFpqnCj8ETTX0L0/2A7vEzWkzFbk62kYZ8APtI/TdwVtxyqpocA9rLw38tQZzDGV9jZjOM
	DtsbQXmcxbtdm1jmnbMiLg3R/NEDvX99lPWPPkdPkHlRAEXn5jMrtzRBw1opBZ/QRRheo9f2MRH
	MKMnoMYC7bGCccNKfDq/amIEfrEu0JvNFMS7/itCfLaZSuuuTv9s6qM7DA==
X-Received: by 2002:a05:690c:f87:b0:796:3917:72ab with SMTP id
 00721157ae682-7963917782bmr52424177b3.61.1770670774819; Mon, 09 Feb 2026
 12:59:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209203316.3050687-1-hadess@hadess.net> <20260209203316.3050687-2-hadess@hadess.net>
In-Reply-To: <20260209203316.3050687-2-hadess@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 9 Feb 2026 15:59:23 -0500
X-Gm-Features: AZwV_Qit9m0gYWidZigqAKsIZo-MwAY8Hiq18JS7FaEs4Qk8Wq8wRv8wJ3zKq7M
Message-ID: <CABBYNZKzHwLHUQKicjHVuMCTkEUoRWb9qAi+FLKoX=5A09-UeQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] emulator: Fix compilation on big endian systems
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org, Pauli Virtanen <pav@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Mon, Feb 9, 2026 at 3:34=E2=80=AFPM Bastien Nocera <hadess@hadess.net> w=
rote:
>
> Use new helper macros for byteswapping constants.
>
> This fixes the build on big endian systems like s390x:
>
> emulator/bthost.c: In function =E2=80=98bthost_setup_sco=E2=80=99:
> ./src/shared/util.h:43:26: error: initializer element is not constant
>    43 | #define cpu_to_le32(val) bswap_32(val)
>       |                          ^~~~~~~~
> etc.
>
> Fixes: 85888a8357ea ("bthost: add bthost_setup_sco() and accept
> incoming eSCO")
> ---
>  emulator/bthost.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/emulator/bthost.c b/emulator/bthost.c
> index d09ad1e76c50..37865f61bc52 100644
> --- a/emulator/bthost.c
> +++ b/emulator/bthost.c
> @@ -3562,18 +3562,18 @@ int bthost_setup_sco(struct bthost *bthost, uint1=
6_t acl_handle,
>  {
>         static const struct bt_hci_cmd_setup_sync_conn settings[] =3D {
>                 {
> -                       .tx_bandwidth =3D cpu_to_le32(0x00001f40),
> -                       .rx_bandwidth =3D cpu_to_le32(0x00001f40),
> -                       .max_latency =3D cpu_to_le16(0x000a),
> +                       .tx_bandwidth =3D cpu_constant_to_le32(0x00001f40=
),
> +                       .rx_bandwidth =3D cpu_constant_to_le32(0x00001f40=
),
> +                       .max_latency =3D cpu_constant_to_le16(0x000a),
>                         .retrans_effort =3D 0x01,
> -                       .voice_setting =3D cpu_to_le16(BT_VOICE_CVSD_16BI=
T),
> +                       .voice_setting =3D cpu_constant_to_le16(BT_VOICE_=
CVSD_16BIT),
>                 },
>                 {
> -                       .tx_bandwidth =3D cpu_to_le32(0x00001f40),
> -                       .rx_bandwidth =3D cpu_to_le32(0x00001f40),
> -                       .max_latency =3D cpu_to_le16(0x000d),
> +                       .tx_bandwidth =3D cpu_constant_to_le32(0x00001f40=
),
> +                       .rx_bandwidth =3D cpu_constant_to_le32(0x00001f40=
),
> +                       .max_latency =3D cpu_constant_to_le16(0x000d),
>                         .retrans_effort =3D 0x02,
> -                       .voice_setting =3D cpu_to_le16(BT_VOICE_TRANSPARE=
NT),
> +                       .voice_setting =3D cpu_constant_to_le16(BT_VOICE_=
TRANSPARENT),
>                 }

Perhaps we should change the above, I don't think it is really useful
to have a table like this can then do memcpy, instead we can probably
just use a switch (setting) and then initialize the values in the cmd
directly, that way we can use the regular method of converting since
it would not be required to be a constant.

>         };
>         struct bt_hci_cmd_setup_sync_conn cmd;
> --
> 2.52.0
>
>


--=20
Luiz Augusto von Dentz
