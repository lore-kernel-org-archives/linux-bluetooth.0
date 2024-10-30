Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16651DD53C
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Oct 2024 13:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730296365; cv=none; b=FufD+ZJlptMjCH8a3L4188WzD/kmTUIFUMK3XN9qPulDyqEhXfac4C6Ez9BfTX+jco6T+cudk61FQTE9AGDvRMZMrcmgNfvMc9xp3aX2blyCU/EgGq8d8mNIHV6bD1K9+yazRKdX10lmK/GQmTxFu1xgU7UT213gQyuNQ2MODPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730296365; c=relaxed/simple;
	bh=PpSVPgLO/t3fM3N7QMRruXrOZ4xGooXcbbD0C3ERjUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IYpeMkL2abCIM3K6EyyNijy9yD8W/waWQ6u9UWLP5Ox95KnEVFAjipikSk1MYI5ZRDSRDuQYxcmAlCEZ0+PpndCjYil3rQJhr1TP20dGd7tZsqiEi0is0No7z6DBlb+JtWlDc/ow4Vep87TZlDci7e4CzJ+XwTtlmfKXtpgTS7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/2np/Yx; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/2np/Yx"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb5743074bso8438611fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Oct 2024 06:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730296361; x=1730901161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//z8BaLPWn5f5+xS7ydDRSZX3pmX/g4FrgWqAoSGEII=;
        b=k/2np/YxlqXs6lck36RarUFg7ir1P5qlj5dTTkhRiONlmSuPrFj0uHxy97/MM1yhkM
         9BnnidW9RKUuANjLJ4EvQ/JH7W26Njx3dyo/TmnPpQh2+9mG+jorshlN7ozodPrwg0+i
         rQCElRmLqc9k2pCiAAqp05L6JRVst08HIAie+uyJaGQD45Dj1bcUZInhYF5NNlCIurX7
         W2URo/EzYTSiEsGEhdjO4w4/Uqg2QbWdAR4N9VDH4TXdZGwcynnaI0YMoksarML9FK9N
         19pM4w5c4c4OLE8ia3dSzirnjDgLvHsCWAP1Zvup/9RQu2S5XdjoWlnu32+DjORo3cnV
         TSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730296361; x=1730901161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=//z8BaLPWn5f5+xS7ydDRSZX3pmX/g4FrgWqAoSGEII=;
        b=vkwFPpTO6tj6xGWEec2AnOMLoaKgmgZX3guciLg8SjQya893400nSp8x9XhfPEGFkg
         QYIrAWNbU1503GwqutI11gTfz+73A3OjB0gV7uSd5zFmFByrIjYH+slSiFDY6/lGC3Ml
         uXMtb7YEgjoBbRE2ZOVQgOKnmKNUc4w/DBn5vEhOZn8coAcytGOYtvQ/tql3rfLYZPt3
         G8VbXbhaLxQEbBjzZ1fF62NlwSe1P22o1ELTUGnbc3m8F690lIf3fRLMKsMdBjNQJChm
         0dcEtN83dZrmC7oaosOHuXWnOjg6rCpaqFwB3/CXSdFJcxP6j/Mx67MqMGPE3W2UV1TG
         zANA==
X-Gm-Message-State: AOJu0YwiSdJ50bJtnCgtC2KhPr9BNV8mVuyyM7IZAhIfg+bRGyLd1H4E
	ckPx/EiZ6SkwJH1RtAOxEizyxHQdtPtE09+2DT+OC2qSqBRUpx8Vx7Qi5Y/AzssDBjNBAwiYoJE
	tIhEK0EgdxDXQxkZ5krXp1xmfsg8=
X-Google-Smtp-Source: AGHT+IF3S8/nnz8VCrvd0Oxgmoiv9Ij7AGAi3qx1/DlsegsWEypLpqGxMpezQgkTzLPBoDGODZcAsA1VWZQzY3xzxII=
X-Received: by 2002:a2e:b8c5:0:b0:2fb:50e9:34cc with SMTP id
 38308e7fff4ca-2fda7e1416dmr7236401fa.17.1730296360771; Wed, 30 Oct 2024
 06:52:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <494bda1fd71a4b3099910f3a9cfaac65@quicinc.com>
In-Reply-To: <494bda1fd71a4b3099910f3a9cfaac65@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 30 Oct 2024 09:52:27 -0400
Message-ID: <CABBYNZKqUoa3ZpNoekVQn9zxUMZ4tjvZkVkcvn4z9ZtMo3sdkA@mail.gmail.com>
Subject: Re: Profile versions are not supported with BT Sig
To: "Amisha Jain (QUIC)" <quic_amisjain@quicinc.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	"Harish Bandi (QUIC)" <quic_hbandi@quicinc.com>, 
	"Mohammed Sameer Mulla (QUIC)" <quic_mohamull@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Amisha,

On Wed, Oct 30, 2024 at 6:50=E2=80=AFAM Amisha Jain (QUIC)
<quic_amisjain@quicinc.com> wrote:
>
> Hi Luiz,
> We are verifying the PTS testcases for all supported profiles.
> We are seeing profile version issues for below profiles as current suppor=
ted versions are in withdrawn state by BT Sig.
> BLUEZ Version - 5.72
>
> >> A2DP
>      Current version 1.3 - Withdrawn
>      Subversion 1.3.2 is adopted
>
> >> AVRCP CT
>      1.6 - Withdrawn
>      Subversion 1.6.2 is adopted
>
> >> HFP
>      1.7.1 - Withdrawn
>      1.7.2 need to be supported
>
> >> PBAP
>      1.1 - Withdrawn
>      Subversion 1.1.1 is adopted
>
>
> >> OPP
>      1.2 - Withdrawn
>      Subversion 1.2.1 is adopted
>
> >> FTP
>      1.2 - Withdrawn
>      1.3 need to be supported
>
> >> MAP
>      1.2 - Withdrawn
>      1.4.2 need to be supported
>
>
> So how do we upgrade the profiles versions so it must be aligned with the=
 BT Sig ?

Normally you just update the SDP record if there are no mandatory
features missing, OBEX profile in particular has not been qualified in
some time which might explain why they were sort of left behind in
terms of version, anyway patches are welcomed and don't forget to
update supported-features.txt.

Speaking about qualification I would also welcome it if you guys are
willing to upstream the qualification documents, in the past we
attempted to document it as text files under pics-*.txt but this is
probably outdated as well.

>
>
> Thanks,
> Amisha
>
>
>
>


--=20
Luiz Augusto von Dentz
