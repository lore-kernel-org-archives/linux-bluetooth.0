Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD402481CE
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jul 2024 18:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721845869; cv=none; b=KxrkGcsBI2L7bs+10A+IhKw1oveBwIhJ0qo469cxp4g3ojoIZlnAkJd83wsx2plR85ZMmaOxsMu3LHhA742q5dlRunltUjtdomyjmIz7rLQf5BuQpedS4J+lebZTnlOX7V4waMQrEi3WF85eLSIrGozuIWEpZy2p1hd3zJQLuO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721845869; c=relaxed/simple;
	bh=rVSCfx4ADW304THLNUe1DPA+gjIjfXG7JZdYHtfpKAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LY0iEKR5ms7+xU+RoDyirsrEtw7bEGsAJcfGx7LpXHh2oW/yjwwWAoK5KEyC5yVnCgXnlO8e7OmPsy26eqdQ5hCFsBm0ba88fCgrDpcl1QM2V/MVrsY0MHOovRPI5T+2VjzVJC7dU0WcRcdpCBrmeqVZGEkBw4+IZOT3QrmYGF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWECiF1s; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWECiF1s"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2eeb1ba040aso1834041fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jul 2024 11:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721845865; x=1722450665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rVSCfx4ADW304THLNUe1DPA+gjIjfXG7JZdYHtfpKAA=;
        b=NWECiF1sNG5sRw1jhvm7nhTlcH/wk5bh3pfYkCjAYmtK1oflRQc5flUuNido0Z2k0t
         TWKAc9sS5Bmt/uzVfAsO8iV3tjHixv8NhviVlPXeahy0g/5S/WGDXvBzrAz3PiZ838xS
         n7oDUwgw1MsIrtbF9rIdumhG0rnteW2IOC7/qQqxFcAE/cxR2CuMn5qc894/af3DP5DX
         VaG1EmTethKAbba4pMfA+xZ8CrhvSFXpuiAdQ8+r7k9Jm6LBtxADpStJ0EmCHqvFVjnc
         qLPxGYQ+fGw+Vv3J8dHrLUz+CoIMPX2z+WNqaPe0h98+vp9Ul5y6ZR7gDvHaqhoeEWjc
         Xdxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721845865; x=1722450665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rVSCfx4ADW304THLNUe1DPA+gjIjfXG7JZdYHtfpKAA=;
        b=czWkfTCV234EyXoRd6AJLMJY8rI0iOjkMajvj1t3fi9gMG2bcGFvhvoOy24S6IDvQ2
         I5OU/nO2w8hysN482AFK3eiy5xlPiKiXWd0TgFovUDeg21y4Bdv/Rh2zuLG9QuO5SYxS
         duNOOTl+XUWS6RFoNCDv99tw+6tM/461sWZcu3RqL3xP6GJ8o5CqOynSuVVGt9c1Ozsy
         1fHltDal+JCPxX9kO1euOK1GAmBTeXuToUMQSRRVPTwKztaZi1WGZyFGX1G9rlNGx8Ir
         lv1bahK5qgrpasczPoeFwloFdkP/OaNIJCcd9lofNsA1pwA7+Eh/XI5bfCZtRZ5bZoHb
         Tg5A==
X-Gm-Message-State: AOJu0Yw2WOsBV3cyPsPggKBwZ3i4uf99W2aOb7hFGpysBg7yW6F56T41
	8V4FvHjbP77uAocwVTHL6GzDPZDP+zJ78gAFTAFdXniR8Kb638CDeLXn5vdgZhJ9V4fi6MNm8i4
	eMbqpEv+8zEtfmeI3NBSqDpvdF2cdZw==
X-Google-Smtp-Source: AGHT+IHA6Mh+/iZ4iSUKoXuAl0tjtrIbMiHpDcxpeckszqKqwGjolffdfF132AGj9wqjVxy8VDqo4bD0pLOe3z0bYp8=
X-Received: by 2002:a2e:9e0c:0:b0:2ef:2ee3:6e75 with SMTP id
 38308e7fff4ca-2f039cd8a8cmr5380441fa.17.1721845864638; Wed, 24 Jul 2024
 11:31:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABBYNZL9Tu2mdZeYdwgYuzATbvUMDxJb1T9jznnkxzscS0eLxA@mail.gmail.com>
In-Reply-To: <CABBYNZL9Tu2mdZeYdwgYuzATbvUMDxJb1T9jznnkxzscS0eLxA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 24 Jul 2024 14:30:52 -0400
Message-ID: <CABBYNZLFj_94qXh0FSSpgy+oepXByN==nj=Fbcm=h3c4YM975Q@mail.gmail.com>
Subject: Re: Generic BlueZ Host Qualification
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: Oliver.Staude@avnet.eu, Alex Lu <alex_lu@realsil.com.cn>, 
	Ron Wong <ron.wong@nxp.com>, Chris Laplante <Chris.Laplante@lairdconnect.com>, 
	Arkadiusz Bokowy <a.bokowy@samsung.com>, =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>, 
	hannes.riedl@streamunlimited.com, 
	"Naga Bhavani Akella (QUIC)" <quic_nakella@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 16, 2024 at 1:18=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi,
>
> I created a discussion in github in attempt to gather information
> about companies qualifying BlueZ and if they would be interested in
> having a generic Host Stack Qualification:
>
> https://github.com/orgs/bluez/discussions/817
>
> Some of the benefits would be that not only companies can reuse the
> same listing on their products but we actually could attempt to do
> more automation and use the qualification process to stabilize the
> stack.
>
> Note: If you appear in the CC is that because you have contributed to
> BlueZ and your company has a qualification listed in the discussion
> above.
>
> Note 2: I would suggest not start with discussions about how to fund
> the qualification, or who shall be the company in the listing, since
> for that we might want to involve the likes of Linux Foundation.

Since nobody is responding perhaps we should attempt to first
establish some steering group to discuss how to move forward.

--=20
Luiz Augusto von Dentz
