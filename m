Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EB9143C67
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jun 2024 08:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719305417; cv=none; b=oQyVL+kSdfXrnnmyWx4f7ABh8a16whqzGlIcyXmj+aPryiNvMjK0Q6MxeNHy/EzRBhded0+x6yE+x/iJ1ZSYjE+x1x0CC3WWUU7Wp5C1dBSUuGbZraPJ6/WH3J4OiWAR8WmN5gZepCRFDFShmR2VyfLgDwSrLaNK0R6s12yxQcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719305417; c=relaxed/simple;
	bh=K928MGnZ+PjaLzHLPDP9/9l4mTcymRGUKsFIfW80nj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PHWGeaCALywMNqVjAkrshe9OAodRr8TAL64eEPUw+HILbXeHG88JYohkCiBbV0VsPEcEQNgvNGN4175s2a4k8xrzbXxpKtfBWP4UoviP0AvIo7iimXgQoWI+3BbBUBX8TZF/NUDWmeD+koPZ3tXppxzQN6nPXpL9TRotMhdeb44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=jy+gPuMe; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="jy+gPuMe"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7066463c841so2113674b3a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jun 2024 01:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719305415; x=1719910215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K928MGnZ+PjaLzHLPDP9/9l4mTcymRGUKsFIfW80nj0=;
        b=jy+gPuMerNtFCZewrxSBcGOXmWUKDlR6erzPh8blFqFrtzjoDs8Gaa/Eb+2zzBdUjx
         NV1q2yYl4keF+hCFb4NfNUPC2shwOhXstDXwUiuabC1sanVmg/eScCrc5crivgpfO3DD
         6q9QtxsA2A0Qpz56ZPA80dA3nbhEk9kiQGmqQIKkK36Qr6I8BM0ovK7s7DZRohli9i7J
         nTaM+oNRlUYKX00dnEt9iNNFBfeNMFOBbfc1iZQ6mQzDlW1pCMl3RuvJZmLMq6D6CO7c
         ncMqdrY+yH0UFNIV5FGdJShPg7u0RhdObSZCiWVH8hG7Tg0w3Hb7XwN0u+vI6AvN4EOi
         YuyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719305415; x=1719910215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K928MGnZ+PjaLzHLPDP9/9l4mTcymRGUKsFIfW80nj0=;
        b=aZquDPinRcuFA0AiNPbVEy9iZgOsZ+PXt+uqkk56ndt/0IolyoSANX3o5MdL1x/nZ3
         khE5mCgkb4fiAuZhEA00H+wJuOXwLP65XTSedZOVFVOwZt+F1nuiGwEq7jyUy00Ptdtn
         yDnOMJSvfhI9s1uXNKV3sbKOPEjGrHSXQsdIIKOE9DP4kxSwbPDkn/bX56MZPaD+b5bI
         LwYD3SwcN6OlN+z75FJSLBWjQFPEQXa94o6B+/qGIBT20kjxsUIvVVn5iLAuNgrMvORI
         uOdkmsYxg9rK989iZObQ9nENX8YUT4djJJAyXuQPBTbCK3ERqvEEwC49khy8QmVl1hJr
         P2ew==
X-Forwarded-Encrypted: i=1; AJvYcCWnH7WqaON+TLL04EE9ce6s3SZo8sYmCfACYjkKUIxvSwKIp9GATd4Y9gYNDzGTB5Xs3aQFMaEblfDiQaDHHFhjVpJs6UQD8AFsTmD6Xcnr
X-Gm-Message-State: AOJu0YwROk9q34Jd5ZsJNmL2qOK+62cY3qCCKxAcnPvSas6+3ikRIUMw
	Owcy1Zpb6V0XWanEIc9rt/0G1x8/hhrn4+SsS5vIgtD5SBUdQsXK9SmsgtZd6f2lyYcppsFI9hu
	Asc7VcrFdH23BlAkF8JoUrbbxqNHuo0W/C/OWqkOAUX8NngLm
X-Google-Smtp-Source: AGHT+IGxy8QyMvcw1+/Aoy8XRE8HcZMjuOCDtdp7FQmo+RVPhWwYnuL8Yg1nPrRC+yDhUbYdwhD3QkFV54cdkTtZHzU=
X-Received: by 2002:a05:6a20:8422:b0:1b5:8552:3922 with SMTP id
 adf61e73a8af0-1bcf7e32860mr7662957637.3.1719305415296; Tue, 25 Jun 2024
 01:50:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624194518.37458-1-brgl@bgdev.pl> <CAA8EJppMPeYrPH+ssDMnf6UwHRdKQetpY3PotGvR-cc2vE68AQ@mail.gmail.com>
 <CAMRc=MeYy8MgBVbwmrR1Rd9oQMz1tUb+uL4eFJWTL7EOsRXxjg@mail.gmail.com>
 <CAA8EJpqz7wPSyn0ybDWKwBKkp+rWVPbTgjbKuG6VHWm24MCusA@mail.gmail.com>
 <CAMRc=McZ+hrXyNESmf4pFX9+uDnc4AKsuO9X8AJsVgCfQVLd9Q@mail.gmail.com> <CAA8EJpo2_3zSYEfyQ0VwSs9AkeXUpcVRGB+LaRAhA=_SWjrhtQ@mail.gmail.com>
In-Reply-To: <CAA8EJpo2_3zSYEfyQ0VwSs9AkeXUpcVRGB+LaRAhA=_SWjrhtQ@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 25 Jun 2024 10:50:01 +0200
Message-ID: <CAMRc=McPZKYoxWYJ3U35CXYbBdwYBuemBwBC-qA5hhpqqTYBjg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: don't disable power management for QCA6390
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 9:47=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Tue, 25 Jun 2024 at 10:46, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > On Mon, Jun 24, 2024 at 11:20=E2=80=AFPM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > >
> > > > Neither of these has clocks that need to be driven by linux. The on=
ly
> > > > user of QCA6390 Bluetooth in mainline is RB5. Bindings didn't exist
> > > > before so no commitment was ever made.
> > >
> > > This might make some laptop users unhappy.
> >
> > Like I said: without upstreamed DT bindings, we have never made any
> > commitment about the device properties. I doubt anyone will complain
> > though, I haven't seen any DT with QCA6390 with clock properties yet.
> > I wouldn't stress it for now.
>
> I was thinking about x86 laptops / M.2 cards. I'll see if I can locate on=
e.
>

I don't get it, how could they ever get the clocks property without it
being defined in firmware?

Bart
