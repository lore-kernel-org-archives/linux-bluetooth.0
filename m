Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B2D2E3708
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 15:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751986940; cv=none; b=d3NqbcB+9dXpO7QesVIOZ7IviULpytBLW+qrFi5MwkW7auBsGqT5YsDMVCPwET30099l8WEfia3vyqCZwoa2uWHUaGPTAuryvyDuvrPyv8x3nqKtT4ZNG0hy73mliiM2RzMnmDAv9EUt2K4Yx8QnWD66ARZ7Pk0lqJb7v1S6vTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751986940; c=relaxed/simple;
	bh=opVljh6rvewrCBF2/vdfSOaYpCBF1JWer4/712MmGJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tBfjvLdZzuJ8uhbooL4NPBaCMsjUUGKf9PJKfFkEls1GfsA7dx+WaWjV1EB24KPJRxjw7I7CRLRIs5mqPcESqUVBDrHWjPqAkKwII/Smjc6ZSsfyfbMUd6qas0XiEah//LjRVu75kFApcMPtZCrXF1M+uiKYdTvI3SQNIlJc5sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VkE3828x; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkE3828x"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b34a71d9208so3161819a12.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Jul 2025 08:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751986938; x=1752591738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=561wKuctC9xIFWOpk6++7nmBEhhNgTvfHY/Fbn6Kxcs=;
        b=VkE3828xz+fDWzE1YCW3u2f7mPdLAMRpEP9vOtPdlXNQn999NTFzeGCy0Ho/DceVlx
         X0PAuX6ZF3MPvtVx98PUyIQt89tx++L7cKQSXR8bs8E6wol+K7gesQKgGQ0TIET9Oqkk
         26XaTGaT7n6+fJFoii7syax3ODWLiA/oCd7r397FkPyPRwEFoYlk1rR/v5UKJZTA6vFO
         +urG36RuVXHvWGdSiLsS+5scMi97kMswEsjfiqCKN8H+bU8NGTN388iVHwJ70k16bdaq
         WUtf1EjjoajmzGsk+qdtD20azcoHXamfX9KNzrA9NhNTsLFsXEGGJscD+OB2pEuki0D8
         LyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751986938; x=1752591738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=561wKuctC9xIFWOpk6++7nmBEhhNgTvfHY/Fbn6Kxcs=;
        b=aTD9CScxQbSFaD5r9LDyVq7lxCdY5eVhyGINAWHmeGjZNWsbteBnE+Jdl4se+kN6SI
         5+5xrWBja7jgSyMo4l/nUgGeFg94IdCecDhyIoalY15mzUev2xTdEPKyVT9pc3oHyNs9
         f7k47IDCzCYxg5AImsGu+s8MN6RWp6PbPcVvV5ueBHJkW6LQTz20Bgsn+wyZqiJ2MYua
         jqqmQIP8hjbpjghR/PYZ9TfyOrQfkk+kK/FGImBaOqOXIhFaoxBTt0H2V0hT+Ry4w+jU
         jaU1Zaq7O/906mWr8tstP07t+EAebPsI+HPBSX98N0kZGPDXxSvpjjdc/5GhsoD/WG8C
         Rd/w==
X-Gm-Message-State: AOJu0YzxT6ID9Ma1KpaUeCUKGM1bFq/iMm/Ok4n8A3rbCQZ5l/W5vgUV
	7q5Wpzwbf8qmXk9GniNY+f0TCBOCnxswuNLHe3mr9ug7qRePRUCoRNIWod3dW7i9JvNn2HTL+Mq
	VOQQEuCGAqIr4qnRi2lK39VmNuS260uZZfA==
X-Gm-Gg: ASbGncvx0RqcaRvFlFDlCeRX6NRNPFdxhNTFtFT+s2Erg2dRvf1Re216kUil7YQ6CxQ
	PMuy6u5/WdUlL5IgO3NjdNYsUyovIqSuLv87hU2c2vvDs1Iovuw7Jd3UV0H5MFlVabXHq5qsuT2
	zlUdVKrTZ8a2o+aqmAp4/EzoMTYyGMBwT74UV7WUUFfg==
X-Google-Smtp-Source: AGHT+IELbLy37uH5Gq27S3zOsF1Ulh6h2oonQ1EmNcm8Dx+hO/gSXpnfCdamD7dUSZF9uAB8uL3vsGRvz29M8bJxndY=
X-Received: by 2002:a17:90b:2681:b0:312:26d9:d5b4 with SMTP id
 98e67ed59e1d1-31aadd9f900mr26963890a91.17.1751986936539; Tue, 08 Jul 2025
 08:02:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708110909.2626286-1-i.iskakov@omp.ru>
In-Reply-To: <20250708110909.2626286-1-i.iskakov@omp.ru>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 8 Jul 2025 11:02:01 -0400
X-Gm-Features: Ac12FXzRicegc8zZq4DCG2LIRmgtnTBPfg-NQ_MoQ5aRI68WI8g7B44vI5LQ8uQ
Message-ID: <CABBYNZ+Wr-SV97p1y71__S8n4gYWVvZdfu7WvdCooaXJ9G2TzA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 00/11] Fix bugs found by static analysis
To: Ismagil Iskakov <i.iskakov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ismagil,

On Tue, Jul 8, 2025 at 7:11=E2=80=AFAM Ismagil Iskakov <i.iskakov@omp.ru> w=
rote:
>
> This patch corrects some of the bugs not connected
> to the functionality but to memory management etc.
> Two exceptions being about fixing the arguments
> order, which also could've caused some trouble.
>
> Ismagil Iskakov (11):
>   btio: fix range validation of security level
>   profiles/audio: add nullity checks
>   src/shared: add nullity checks
>   isotest: close fd after sending when nconn=3D1
>   obexd/client: fix err condition causing memleak
>   profiles/audio: fix memleak of bt_bap
>   src/shared: fix memleak
>   src/shared: move null checks before dereferencing
>   isotest: remove repeating conditions
>   profiles/audio: fix io_unlink args order
>   src/plugin: fix args order
>
>  btio/btio.c                |  2 +-
>  obexd/client/transfer.c    |  2 +-
>  profiles/audio/a2dp.c      | 45 +++++++++++++++++++++++++++++---------
>  profiles/audio/avrcp.c     | 24 +++++++++++++++++---
>  profiles/audio/bap.c       | 24 +++++++++++---------
>  profiles/audio/bass.c      |  7 +++++-
>  profiles/audio/transport.c |  2 +-
>  src/plugin.c               |  2 +-
>  src/shared/bap.c           | 40 ++++++++++++++++++++++++++++-----
>  src/shared/gatt-db.c       |  5 ++++-
>  src/shared/vcp.c           |  3 +++
>  tools/isotest.c            |  8 ++++---
>  12 files changed, 126 insertions(+), 38 deletions(-)
>
> --
> 2.34.1
>

When sending this type of change please include the tool output in the
patch description, anyway I went ahead and applied the one that seems
clear enough.


--=20
Luiz Augusto von Dentz
