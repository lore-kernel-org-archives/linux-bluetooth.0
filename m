Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536392F12A5
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Mar 2026 18:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774118181; cv=pass; b=EKut/7u7lSrketPH7x8UcaVdqzQdnZA9VzIiQfUWgZmD1YdQtF1bFyi9Hn2kI2gpmvvFyxm67lZ0joZZjfde0scy0zhr6kFY/LEiv7g8qT9RtduK+lekNic0QEQtFxMMLGpm78DJLoRiWL22n/a0zxRjnaeYixLrbPMseoXEl08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774118181; c=relaxed/simple;
	bh=E73mJLbVj0JbkSUviEdOjxdJyafwNzdmTlBRvW6WZ14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hzOock6r1XfMc2Z/dPacBmIpZpdgAm9b4Ylzj7yOTOm35NRQfzTZbgqU1zBYOyh3WoKbF6O1MYZEwquW2MWg1oimbDW2GeySTQJaDc+b03joK9cqGYWPAc1hA71uQ1qbvETU5j0x2LotZyuwUsbBK2s4Tfl6WEcAWW+DB9Qx58g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1x1Youb; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1x1Youb"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64ae222d978so3178936d50.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 21 Mar 2026 11:36:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774118179; cv=none;
        d=google.com; s=arc-20240605;
        b=H34KiRe+d9Pf4V5+jRWhnduylmSo25NzTetckR2ArAE+aj+14/Ed4/2j9n+478SRHj
         QY6hI2NSSlD4ABpe3CPSp2i9MjKff4EAW0FPeV8zat5XSO+tcXlS/4k2vL4qXuzBP7/h
         gaSKC4GDgcOKtPDjXpUBbPqZbngKRFSxZYoUK19/isN0KMypLD8TW2tIR+6tjkwmelnt
         +ss8nVH6Bh9h3y3ax+l1zqZjtLkpvqBGcQ2OeWrmHhqDpNq1smncBsu6yipuplldA7qh
         rtJOfn/4BA4TxHdobAKGst6r4V84saMsG5Uryv12UI4w3gS3d6HP+3f5SLTU58Ktp6Gf
         DGjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E73mJLbVj0JbkSUviEdOjxdJyafwNzdmTlBRvW6WZ14=;
        fh=2jQ6POPFUs2gBzHto99lHnOjUzZrdbmFO1le12cXlAY=;
        b=co4QKWWR8vlAitBvpp037cjOb6xlqCnTh5+QxR2Y6OMEjdbGEWgMYKK8RzP0cyC7dJ
         ioKH9H4H28ewc7nlZtLTkZQQ/T5RgeFScYHLVcFcxsqlA00VhrqwxsjWQMw8USoFbtJj
         IvTYdv0enFvJOOPG69Mzv1pftC5QrStk9t8gtaDEZa7CVkFEyLSQabNXnWt3DiMVbGqr
         Ge6tGEqvuYthtZNLLYcsw3yKAK7Lv17Fwdv5rsy/vd9IRoLs4/Fm2Bfhmc6wdnsNNduK
         ScDDIN5HpU+0o3yYMMzp/D5k/w09fom/6IRk5PLDOrEU1zdMCoqPVPBvTWYrAkhfgQT6
         kgow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774118179; x=1774722979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E73mJLbVj0JbkSUviEdOjxdJyafwNzdmTlBRvW6WZ14=;
        b=a1x1YouboCSOvm/kS8mbf/ihOBW0gbIJuaLoU8POQYEMT9VdQIompT5NnPxpNLVm+M
         k3R8Z+DJxv0Nw8sxuPp6Gjlka/Y4Msu86f3OejokTfKTOmkHl7ZGDUpUMZlR2Avb5PTr
         Q0xUyAgqAhlRXYBIz5fkgCuafPXuSZjPuvEkAr6kHHT7gNQsCjY5exyGbD4a4oz8g/3a
         FFOLy0ZSZxvbtnpmAvXffi4RjRV3SHjq8AyzN4ZQzY5WaE0hUrJvdm1EbB9zu3QXuO4G
         8FpHIVuQshgUzAYSlGxUA6+ornAkGkFtEYlwPMNkp3KpwFdvvkw5udmjoABY86ngsrRN
         Tw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774118179; x=1774722979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E73mJLbVj0JbkSUviEdOjxdJyafwNzdmTlBRvW6WZ14=;
        b=eTyh08P2ijdKbFVBtbT932g4+ixIjmQcmrgAhpps8PJIPceyfyJVFbR79myUtvclJx
         RnmQOw+7XcU7x3dAGH0wQMMR7mFiVSHydnkRNnlAW8l+1W3S7VOi7z+EMAqUvWumuZKN
         lHHW7ftC00QZ1kAqz5hGNxY3aznk7zRD/YMRep34Snvc32j1hQvuLR4SK2dnya6swDOh
         xtR/b1BHwr+PmVbyw5p+rLUS9ZKSaoxVuAUaSinsQjQr0meHHbb0kgJOCwzBPb13l8L/
         gqZynsmPgpo5o4sHHWOJ1u9z6wEmmUCxCH5Sr8o6BzbiddXQn02OIVJPKvre+MaFPMQs
         2Hjw==
X-Forwarded-Encrypted: i=1; AJvYcCWZyWkBPDCoEOc/D7RM5u3n5IWAvawzx7uxfkvHsYDYvzWIKbACAPrZ24lF/wjw50NpEM7Tz/CnSTlWNGTs/mE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/n/6C7nH5brsobcpe1cHfENSoM7CfE5i4YBHCVXyDLlWe0R+z
	ozB2StiVtBn9FC/I33v76IbIpXFhgbKNxqOoxrpBaq4vhN9uqznZjk/oMB7ZhprkdjAqMzXP4/v
	TaW1BQ4Dsq8SdFFuV++sREmA1BXgXQi8=
X-Gm-Gg: ATEYQzxAKu+sAgYAZ3w389Grwzyxb4xj6lHEPHr0SqW4K6UDDB01TakfsIUIIHz4dud
	wLdU9xag+3rXnLmqzVuyMHq4TIP5Fq+ChyuMMpvQ+c+SL45gecst2skExgOA/myFMAzkP9gcbrQ
	W/VFIo0WvEXqXh3GlcAYh8I0xaYjcDAsGQX6VpeoBZxyCIpjxgfCH7oOealWX+k+dKm8cqH4BoI
	EYvMDzo8PlUJthsCF8JtpSojA4XD1+QoGytM8z+1zKFvZTm3y18IwAL3IyF0yqrrEpEfAf9Drd2
	zw67cLB5/tqwQRKwikNwFipwHVj7Qh0y8XUUlw2VlSM+w3QWt9juaRarZzGFKW4/Ad7+yQ==
X-Received: by 2002:a05:690e:e17:b0:649:e501:21af with SMTP id
 956f58d0204a3-64eaa6a23e8mr5995453d50.14.1774118179320; Sat, 21 Mar 2026
 11:36:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319190455.135302-1-luiz.dentz@gmail.com> <177396481128.1855248.1024090053580545012.git-patchwork-notify@kernel.org>
 <6411a735-d187-4848-b199-a0e2c2e0e52c@leemhuis.info> <CABBYNZJfLf6PzKUkGjiCvqEm3h0+3SUcxY5RNbUHv6LBdPT_zQ@mail.gmail.com>
 <20260320175220.47147285@kernel.org>
In-Reply-To: <20260320175220.47147285@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Sat, 21 Mar 2026 14:36:07 -0400
X-Gm-Features: AaiRm50g7uMS86-n9jkJ6Q519tiQJjDz5q1yhkXXjsoHNxncFtVOJQmEad9viRw
Message-ID: <CABBYNZ+Tk+in8tLVQ7qXQXZjVYLRt3bstvSLPHh6Y9bBb2Dg-w@mail.gmail.com>
Subject: Re: bluetooth regression fix likely to miss -rc5 (was: Re: [GIT PULL]
 bluetooth 2026-03-19)
To: Jakub Kicinski <kuba@kernel.org>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-bluetooth@vger.kernel.org, 
	davem@davemloft.net, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

On Fri, Mar 20, 2026 at 8:52=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 20 Mar 2026 14:02:34 -0400 Luiz Augusto von Dentz wrote:
> > Afaik, it was tagged as regression on March 1st afaik, according to
> > [2]; traces were only provided on March 15th, so yeah it was fixed
> > within a week once the necessary traces were supplied.
>
> Hi Luiz, I don't really care about the complaint, just wanted to check
> whether you know that we always send the PR on Thu (either AM or PM
> depending on which maintainer is handling it)? If you do then nothing
> to see here, we are all doing our best. But if it's not crystal clear
> I should probably ping all sub-trees to remind folks.

Sure thing, normally I would have send it sooner but I did want to
make sure the regression fix was included, I will put a reminder to
send the PR by Wednesday to make sure that git to you ahead of time.

--=20
Luiz Augusto von Dentz
