Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1303718FDC2
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 20:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730149020; cv=none; b=kDlOwSuHZ3XQoS8c12OjbqLg1q04w8ELj3SP488rrLC3qx8XJTyrJVZJO0uXeXjv43MVAf6zMPnevWjlpF9PQfHp0PI9ZIZCweLEkWoTKsZYv4LnG/MQuuSECU3BgqpnzfZo67zmzao5SRplXMyfRyp3HLbpcUA0k5xZGewbjDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730149020; c=relaxed/simple;
	bh=+y8vwykiPMY7XQDEjOvqRtfz/ZfmTuKN+zV4CFqyt34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ed2DVTHNmiHAEfkswyVaBz/U7gUkOh2HcM2fzP4ltGZ56L1EdHEqN+wO+iVZtxQQVg/ezEKKzQUQJOKsjRHFRZjcbphYDPgeXUkwprOuv1zX+Poh5aOUNzzzFQeediherLik7I/n7p0BwbtrpEleXsT+qv05sj/EnYjHni9YjYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVPwSjj0; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVPwSjj0"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb5014e2daso45146401fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 13:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730149016; x=1730753816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+y8vwykiPMY7XQDEjOvqRtfz/ZfmTuKN+zV4CFqyt34=;
        b=BVPwSjj0S4B++4wA2g96TM7NqtjhfFuyVD5VVxshLfT9zTrOW8EfzWx5aD9zZrIjoO
         P+lHIdC/wAyzqTQSAsipU2sgpJIO/y/C6oz/Ba6DZwM9Ny4RGksZUHO2fKhKMFwoMjLV
         VDT9ugac8qiVn7HNXHe9dhZbfiXb9dE42GW+ZLeEFsdyGv4a9oqdJdSn7/a4OKGufTLR
         CT9RaOkPBz1qqGVq9qOa8Ga0GBwRX39tUI55NlfBLKXVQwLBj2WXaE/6Gef/Yn3C31Gw
         PnWk4fx55i6yajepjoLS5Zkq21YyoIUJ7aEMy6CCM92vcBKFGavxPrc9d5zGhZAzs2Pu
         tOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730149016; x=1730753816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+y8vwykiPMY7XQDEjOvqRtfz/ZfmTuKN+zV4CFqyt34=;
        b=mBR+ZkEmFvLkCfVWAbYJ7KhGoXaqzDEuWfiV3aELNcgs7gca4S3nhbIaj+ywPYoQPZ
         +rX3fsF1MClfaWtJ2dkMSUiWsDBEYPrrx1xM8mMkoywm8/vEGa9yr/Xnm7LvQfwk43nR
         SjfSDx3DK3LcXLuMbDI3BwBV1wq7h/+TbGYjT6LrTO5ZHzehxl1Sg5uumLRl7AYjAO+4
         dlMbL1QZmyxJ9Kd+VXgTgsYG1eJ4BHgzMcfS3Ct5ovAJ+llTw7+i6NTTm7PinHYp1gwm
         K2c+W1e/598NhL4cJ8HO0paLVM5TdXA1hu1u2EUYCOwh3npY/+cOtQijSSTcS2nk2v8T
         AFQQ==
X-Gm-Message-State: AOJu0YxBU/zreAMx7iisAEn/Rz+VyMAQ57cO3pdY6Ed9rhccIDJAB7qO
	yClEp/ov6RGbnCZb6rj5g2R5Ni0FdodcF4DBg70xe4B6E9M6Fp8idaNMxx/g1UvUDHKqE+/gd4+
	9Bw4SChxTBCnJkWcwm/QpkvxMSXHitw==
X-Google-Smtp-Source: AGHT+IFrR/bk4J32HArW7DPswM97yuvHUiNYK7jk/31VeoTxwDUBZuqjJMFhHFzRcAXCBpTR7giXEAI7VMQ9YqB50RU=
X-Received: by 2002:a2e:be85:0:b0:2fa:f5f1:2539 with SMTP id
 38308e7fff4ca-2fcbe00392dmr40116631fa.24.1730149015815; Mon, 28 Oct 2024
 13:56:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025202141.158946-1-daniel.beer@igorinstitute.com>
 <20241025202141.158946-2-daniel.beer@igorinstitute.com> <CABBYNZLjNgTe6E0f6oKuap+VLttiaGse3_vP3ZYFxiO7mmNfog@mail.gmail.com>
 <Zx/Ft7upRYfGVD4f@fermat.nev> <CABBYNZ+=chpkTNhB=P2RM2c2V7Vxe9wUDdrWi-KkqOmc2wmV5Q@mail.gmail.com>
 <Zx/5S32GbBsV+any@fermat.nev>
In-Reply-To: <Zx/5S32GbBsV+any@fermat.nev>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 28 Oct 2024 16:56:42 -0400
Message-ID: <CABBYNZKShEs-Sz-Tiojkst9PRHsava9R4WAFjNyf1+2KwcgLsw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] source: clean up outstanding AVDTP requests if
 the stream goes away.
To: Daniel Beer <daniel.beer@igorinstitute.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Mon, Oct 28, 2024 at 4:51=E2=80=AFPM Daniel Beer
<daniel.beer@igorinstitute.com> wrote:
>
> On Mon, Oct 28, 2024 at 01:37:30PM -0400, Luiz Augusto von Dentz wrote:
> > Ok, then perhaps it is a good idea to have these applied, that said it
> > would have been great to have this type of test automation upstream in
> > the future so we can catch regressions if we ever change this logic
> > for some reason.
>
> Hi Luiz,
>
> I would like to be able to share the test setup, but unfortunately it's
> a difficult-to-replicate hardware setup plus some proprietary control
> pieces.

Ok, well I like to have it perhaps running under our test-runner
environment wit emulated controller to make it part of our CI, anyway
this probably require much more resources to put it together.

> I see that the patches failed a lint check due to the trailing period in
> the commit message. Would you like me to resubmit, or are you happy to
> edit those?

No need, Ive fixed them myself before pushing.

>
> Cheers,
> Daniel
>
> --
> Daniel Beer
> Director of Firmware Engineering at Igor Institute
> daniel.beer@igorinstitute.com or +64-27-420-8101
> Offices in Seattle, San Francisco, and Vancouver BC or (206) 494-3312



--=20
Luiz Augusto von Dentz
