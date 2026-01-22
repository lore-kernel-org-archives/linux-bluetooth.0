Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32327249E5
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jan 2026 18:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769105467; cv=pass; b=IRckk/mWiacddO9hjs/sNv7y+RpQGMMacyl+cqSetAttpbUPrnJPrsYTFosLNQjva56HDYAsCWoXJu5rVXuaHhTfMrKM2wdetl/legwtwbwIg6jNyCx2VPqhXq3Yr+/xDB8GT/fE6Ac4JtjCNsXKGH8l4KYdISKez55hJ36C4yA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769105467; c=relaxed/simple;
	bh=8Lp4TlktEqNw2FGiLq/7PEpMmsShHPWTGK2QGeywVEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aRxdPScXsBJO67mWGsnR0uox9mQ5npGBuQ95ATwR70R9rQztoLcHsFSPRKwTMutLV/KVnCSdNOV7P/mRkvYigiLljJFzKhBqB2gCHyuPYjVWIXr7dgAfpTVLPECdRmvpLiB4tyCXYifbkiUFsevReutRQB8zAyES4XcXv5AF11U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSzyC2l3; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSzyC2l3"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-78fba1a1b1eso24793857b3.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jan 2026 10:11:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769105458; cv=none;
        d=google.com; s=arc-20240605;
        b=BUxdnGhBARBL8Cka2eSJnFfjc2tav9x81klGv/ZiYwE313NBsYpvhL45kDTOndfdgw
         WtrQDDFMeAGe2kXqD3h64YLipsS1s2WIZoLDTkMy+I2CiHeXwI89lTvOGk3hy4jz+NeV
         zcbk/rmIN44UGrcMpl9gSTEg7jxwMatqGtcjxKX15mZ4V7WQMaq/vnqmukChEEGy3N8M
         ExkV8eYUIRMj8bKqPFUpObeZycr1d2SZUB65auG27Cw6pCjv9KLxWTxkWBG2upuqp0Vn
         93YD9DQ7HBBEO9Mvm1nixBxp/l5osL+mZsniji06FjgxuImhQt6bLmoRPrWkLt/CHNgT
         6r2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IhcJDfk8+P/H/vEd6PBYPiBMC5o9bK+vPtxK3HqqlOo=;
        fh=DBIRJP4DvnAE+M31BcQ50XI3CAn/idN52/MNTtsfw9E=;
        b=HeQQwTxqApxyMa/2Pga03u/0MWuJg63zDSejqG+/o1JBSZEvf7C0UI+hnfWy737bny
         eVhYyA1INuujR5fbDzC1zuDOb85Mq6FTOEOak00qbRwGTMaqTmed3jB3cGoZiDACWTo2
         0bsOeCE1SIiUCzMtdbSz4vI/IHmBHFx+Z8XcLjbOfqAgCPhQj0+u/LXqom1aKbNmHy1D
         2htpov90RiSnthG4euId/BocMFfzYkxE/24Nr1KU1tAqvvC8l613imRIpnWDT4XNXMeA
         uSa2qOl23hf5HKbGf08oq3Isv6qxaPppKFS2Kr7LZP2ImAO6XmCGcZZoTiTMpLNMbuZH
         3dSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769105458; x=1769710258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IhcJDfk8+P/H/vEd6PBYPiBMC5o9bK+vPtxK3HqqlOo=;
        b=kSzyC2l3QMMw1ImOUgnFaFmy6gHk6/JYr1DhYeu19nsDT87c8jGZ8TmckMtH7kwzvx
         g4XmrceYuzaEqFmtKcRpPoPqi9B5oPazKtJh41yJAtNDf6Rp+QswG52K15ZAEFkGq4Ra
         p7uKtPJVkLx9uPjiwXBYDaHmsZA/5EbG74z2zv0ChQm99x1d7UrHa85KhWbGG58nVJqt
         61QfdKS27YKHuVl3Bu1XCsIWLU5nSAKnEyMLz/01V8uq/IJnR1raGMtCpSi3E8fpmYxx
         icibAp4rxfg/ber4uUDjVVz4XNlQfZrgJaDoQfqej5qbmzjlzRV0+PcdCCetoypbvodl
         LQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769105458; x=1769710258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IhcJDfk8+P/H/vEd6PBYPiBMC5o9bK+vPtxK3HqqlOo=;
        b=JcJ0JZhByeISbtmJD/OBhS0hHWG152x/lGNp3skFdgl2M1Qbri4U1VoZbWbwWkDOzW
         QWNPxPXGlUiuBZFZN98y7Iv0QMwLpuFfc+V9yhp5wABYq0FCVLIlt4hPcl4+XcSbGRlc
         NyHxezDDKZo6IXFMe6hlwbn2N65j/N6fEVIlchj3TpVEisczPMqQglkB8zcbPbeu6/x6
         Ec/uZ9PD9tgMbjiLe4xrJ+pUR7JKvtvcMPumaEZiVb3wjEQTINq4zqQr1yTAheGUDij1
         F+lLcOxZAv2fzDCXUu2EKVjL+MRrllpFF2O5H6BijVQF4oIL54IFmI6SFXprNw8p4nFi
         sBgQ==
X-Gm-Message-State: AOJu0YwqAkBhL1+G17zhmSPuRlYJu599Wz0+uTB0FuNY65EYKxuRnU40
	y9vudq6+85/QdnXMmmhBg0y8kvGtdVmholRWyE2EnuVtZe8BhtvGnhyTEdsGvizL1lZlyvPQ0b6
	xUKNgDUVgQwtyGKsrFAz49lbEYOlbM7iekS2B
X-Gm-Gg: AZuq6aL03dha+pLLJsNuIPxCObleMUsMuUp93CqRp9i7Gu00lwDxYaCxUwa6cecEoCw
	ccDIXBXQ4VPQl8eXu8QFFKGJS/BDN3+heCNP971jGftiOTp5IAVwpqZ5vR6ky1Zqz1pD3/Mb/WD
	4vvCfluucHHADk2Ae/gjl7Xbqo+xcLoAmVLpbEyQM1Qj2JtHYl+2rxigDv/sonbxcvIiZUCNz4e
	j3ADA8E0Jgnytdl5EFjCdX4sTSQLd1X9AfMfbLwpYk3EFSSvolS3MQ3wNvL3ERg3d38NRZogo12
	cF0RUx7glqi/b0oLV5f9uteRkSgcRj2lqb32J62k/K0jakf47liyqPjHbw==
X-Received: by 2002:a05:690c:6187:b0:790:7941:3604 with SMTP id
 00721157ae682-7942a76f15emr35642007b3.15.1769105458254; Thu, 22 Jan 2026
 10:10:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122170001.122052-1-hadess@hadess.net> <20260122170001.122052-2-hadess@hadess.net>
In-Reply-To: <20260122170001.122052-2-hadess@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 22 Jan 2026 13:10:47 -0500
X-Gm-Features: AZwV_QjUELR1SI-tT7sIRQO_KE8Hh56QtoQhnnrPCEfjhGM3yG2u9ew1aehpKlg
Message-ID: <CABBYNZLKeCJLP=gDPx_PhDX3LvvmuEvr++JpAVpyhp=4znnf0Q@mail.gmail.com>
Subject: Re: [BlueZ 1/2] doc: Add "C" code-block markers for coding-style doc
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Thu, Jan 22, 2026 at 1:01=E2=80=AFPM Bastien Nocera <hadess@hadess.net> =
wrote:
>
> The file isn't processed by rst2man, so this doesn't add a new
> dependency as was the case in 0ea4e4d52c55 ("doc: Remove Pygments
> dependency from manpage").

I'd leave this for later, when we actually add the dependency to deal
with language specific blocks.

> ---
>  doc/coding-style.rst | 46 ++++++++++++++++++++++----------------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
>
> diff --git a/doc/coding-style.rst b/doc/coding-style.rst
> index 585d14fd86d9..91250e867f09 100644
> --- a/doc/coding-style.rst
> +++ b/doc/coding-style.rst
> @@ -30,14 +30,14 @@ not preceded by an expression or variable declaration=
.
>  Example:
>  1)
>
> -.. code-block::
> +.. code-block:: C
>
>          a =3D 1;
>          if (b) {  // wrong
>
>  2)
>
> -.. code-block::
> +.. code-block:: C
>
>          a =3D 1
>
> @@ -47,14 +47,14 @@ Example:
>
>  3)
>
> -.. code-block::
> +.. code-block:: C
>
>          if (a) {
>                 if (b)  // correct
>
>  4)
>
> -.. code-block::
> +.. code-block:: C
>
>          b =3D 2;
>
> @@ -67,7 +67,7 @@ Example:
>  The only exception to this rule applies when a variable is being checked=
 for
>  errors as such:
>
> -.. code-block::
> +.. code-block:: C
>
>          err =3D stat(filename, &st);
>          if (err || !S_ISDIR(st.st_mode))
> @@ -80,7 +80,7 @@ If your comment has more than one line, please start it=
 from the second line.
>
>  Example:
>
> -.. code-block::
> +.. code-block:: C
>
>          /*
>           * first line comment  // correct
> @@ -95,7 +95,7 @@ There should be a space before and after each operator.
>
>  Example:
>
> -.. code-block::
> +.. code-block:: C
>
>          a + b;  // correct
>
> @@ -110,28 +110,28 @@ body.
>  Example:
>  1)
>
> -.. code-block::
> +.. code-block:: C
>
>          if ((adapter->supported_settings & MGMT_SETTING_SSP) &&
>                 !(adapter->current_settings & MGMT_SETTING_SSP)) // wrong
>
>  2)
>
> -.. code-block::
> +.. code-block:: C
>
>          if ((adapter->supported_settings & MGMT_SETTING_SSP) &&
>                                         !(adapter->current_settings & MGM=
T_SETTING_SSP))
>
>  3)
>
> -.. code-block::
> +.. code-block:: C
>
>          void btd_adapter_register_pin_cb(struct btd_adapter *adapter,
>                                          btd_adapter_pin_cb_t cb) // wron=
g
>
>  4)
>
> -.. code-block::
> +.. code-block:: C
>
>          void btd_adapter_register_pin_cb(struct btd_adapter *adapter,
>                                                                 btd_adapt=
er_pin_cb_t cb)
> @@ -147,13 +147,13 @@ There should be a space between new type and variab=
le.
>  Example:
>  1)
>
> -.. code-block::
> +.. code-block:: C
>
>          a =3D (int *)b;  // wrong
>
>  2)
>
> -.. code-block::
> +.. code-block:: C
>
>          a =3D (int *) b;  // correct
>
> @@ -165,7 +165,7 @@ When declaring a variable, try not to initialize it u=
nless necessary.
>
>  Example:
>
> -.. code-block::
> +.. code-block:: C
>
>          int i =3D 1;  // wrong
>
> @@ -200,7 +200,7 @@ prefixed by the ``enum`` type name.
>
>  Example:
>
> -.. code-block::
> +.. code-block:: C
>
>          enum animal_type {
>                 ANIMAL_TYPE_FOUR_LEGS,
> @@ -211,7 +211,7 @@ Example:
>  If the enum contents have values (e.g. from specification) the formattin=
g
>  should be as follows:
>
> -.. code-block::
> +.. code-block:: C
>
>          enum animal_type {
>                 ANIMAL_TYPE_FOUR_LEGS =3D         4,
> @@ -230,7 +230,7 @@ compiler will complain the new added type hasn't been=
 handled.
>
>  Example:
>
> -.. code-block::
> +.. code-block:: C
>
>          enum animal_type {
>                 ANIMAL_TYPE_FOUR_LEGS =3D         4,
> @@ -278,13 +278,13 @@ parenthesis, too.
>  Example:
>  1)
>
> -.. code-block::
> +.. code-block:: C
>
>          memset(stuff, 0, sizeof(*stuff));
>
>  2)
>
> -.. code-block::
> +.. code-block:: C
>
>          memset(stuff, 0, sizeof *stuff); // Wrong
>
> @@ -296,7 +296,7 @@ A function with no parameters must use ``void`` in th=
e parameter list.
>  Example:
>  1)
>
> -.. code-block::
> +.. code-block:: C
>
>          void foo(void)
>          {
> @@ -304,7 +304,7 @@ Example:
>
>  2)
>
> -.. code-block::
> +.. code-block:: C
>
>          void foo()     // Wrong
>          {
> @@ -321,7 +321,7 @@ Example:
>
>  1)
>
> -.. code-block::
> +.. code-block:: C
>
>          if (device) {  // worse
>                 memset(&eir_data, 0, sizeof(eir_data));
> @@ -335,7 +335,7 @@ Example:
>
>  2)
>
> -.. code-block::
> +.. code-block:: C
>
>          if (!device) {
>                 error("Unable to get device object for %s", addr);
> --
> 2.52.0
>
>


--=20
Luiz Augusto von Dentz
