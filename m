Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985653491C4
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 19:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779305543; cv=none; b=i67ZzfCMVx5g4A/JyOKzxM9kxb+62fhiIcwI87Tuj1t8LwQzqP9Mdc4QFjjnttSn37JL+UdvFnzTjh9bUaTmGokK6tfM3cO8DMwcYtnD6okoQd3J0t/ICdiuhvdQi+y8BI6E4hsA+EShQIdZHMXDyQSwyfDNXXt58XT2AQtuPtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779305543; c=relaxed/simple;
	bh=fE7L5X0OAZJPu0MR4qi275DCqHXUYbK31o+O4PycIek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BPujS+CtSIdYd7DeU1+z09EV4Uw7h/NvP2wmN5PDLwIRK7e+bI8k5qvnQLoWJKGz3jzpK6/cWBK0UJ+Pyc43MhofVvC3/mIr7cIZoWFNt6rwqDrTxZ6wKzOjEu7MHL0X38AloqJhmJ2MURA72zf3gF7ki1wTlR92Q2nbl6CPyIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PnGibpC6; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PnGibpC6"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6870f904c6bso2250057a12.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 12:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1779305540; x=1779910340; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XtsLxXbuubW9aHbvOjPZig1kaSvDhEBypwJASxFDBgw=;
        b=PnGibpC6rUadOiLRkvAXF6JgM6bQwoQyo6ys6Q2CJacxAU73u+6XZ0yoP+Cjb61/li
         BfqnfLjWnBd4PsT1fMwJ2v4rQGmAeNp+gPIUuo+5tiRgM3j6WvHjyPemyqxdvm8PXT3R
         7BULDtbzf7AL9/WnfKvWQ66RdEzaVGZnOZF8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779305540; x=1779910340;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XtsLxXbuubW9aHbvOjPZig1kaSvDhEBypwJASxFDBgw=;
        b=hfDEUI1k4+YgeS4CZ3gllLb2ivZlcY4TBR985Be8x4MhDKtkDuTzsU3dyV9vQnWyf2
         7CakiiedbiOm5L57hu/hzhRz4h/GXJrT5upST3/apWf62SRoPcqeUZqFQ4bRnaMKYF89
         caF87FrUJoqcXdwcvQOlzY/ypX/bRwMRW8OMjcs0ZSWDSVOas7Jzd+Zy0UMmSfVmwO9V
         SahSV1ptd7cw3J9v4OgZBNEfl2I7wz+afvhinX4BI4vtqMdjJ6phxHbTqgOGlUOtIBrG
         VfDqFdwT8U2nln1TdLfYooTpsOnn2lnBsCT42hBaxvUNk/1D9RmRiq3x+e2KZVVAjBBl
         Ny3w==
X-Forwarded-Encrypted: i=1; AFNElJ8oJahapjgifaNUaohiDyT1nh0mSniR8kTF9bgqQBEJw7+M4cIHwduVczmMjmsapZ+UQ0fa4qgp7Ww3JSGzFok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2+7J7g7aTvkB5llQ3ubW3xAsYK1289/bNNzqx6TrrSf5b0+K8
	3uIYJKYTM6W8I3wnGpLyHj0kEybXSE5a12cFxWwa0nOC/NTSaVlhpfuzdudp0x3w56aTo1Os9xC
	YmuToeyYIKw==
X-Gm-Gg: Acq92OHuio2IamY2rmgVMbmFAvHHb01DCdbJ6tr8pIGHADjp4jKPYa3LFBz0A+FUHS+
	OflaYh2CSHmYbbzVdx2w4tzh78Xe8ab03j3jLevuAGM9vB/CPBpXvVCbDidPpIgxvmRFjlal6hE
	+Zu1//CJ4TXZwK21YGBxa6JxncFJZFCe1kgiuc6vq/X3ytFEQNnHLVACnEEITHFcfQMUWPylIN7
	NPyZoTcTyD0IJ32kG6eyKZfoUxkiuli6xYE81auMUg9UdmB7dmLoxHiHfjfi+/1yXp4rgIXnfkJ
	08enpEQSmFAnSVTmBTThHXf0JE1AOAd3fzdKz4GvRNfpRy2OK1LjShC+J8ciXa8uP/FMKh4h+kM
	9wuXQ7zYjR3lw1wOAlNtdslS/QF3g+WKVwT6kTloGBEExDMsB72cO+q2DfLJjURqQyerrA1vIqa
	ACu6bUbYkYjbnWhB/DqlE9TmZRbbFdwQY1YzPJr2T01bmiZjjD8mhmgiO+tDtnJk1VilApV9ao
X-Received: by 2002:a17:907:94cd:b0:bd3:7c5d:c712 with SMTP id a640c23a62f3a-bd5177f071emr1306197466b.7.1779305539654;
        Wed, 20 May 2026 12:32:19 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4c2a68dsm911621966b.18.2026.05.20.12.32.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 12:32:18 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-67179ed133dso6360174a12.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 12:32:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8Q+bGD1zs558wlBzTirWfy22/ix/E8fch6qvJErP9OXRyDcmZtf+cklWlH/FZWGzY3wjKhbH+DfwPY8OWxkB4=@vger.kernel.org
X-Received: by 2002:a17:907:8305:b0:bd5:2ed4:4ef6 with SMTP id
 a640c23a62f3a-bd52ed45a11mr891164366b.19.1779305538567; Wed, 20 May 2026
 12:32:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4946f5f3-b7e2-4949-89f7-6427015027c6@leemhuis.info>
 <2026051954-revision-sierra-6bb4@gregkh> <eb5301f9-3133-4fe3-b358-61f14d1ffa5b@leemhuis.info>
 <2026051909-impurity-nemesis-2f65@gregkh> <CABBYNZKKbTXc-okp9P2OncMYXHX9C1XC+pRC7XWOhv-8nPNZ5A@mail.gmail.com>
 <2026051942-uproar-drainpipe-6370@gregkh> <CABBYNZKzWgL3nmeA=CtN9s80LRyDiJ97aQXgvfSm9vYUBw_SpA@mail.gmail.com>
 <e666c332-e2aa-4525-a208-a4a08742d2e0@augustwikerfors.se> <2026052026-barber-espresso-1d9a@gregkh>
 <CABBYNZJ4woc+unpYN6_dzMLtxhFVUd5+ccv2+EQbDMkYuXQ12A@mail.gmail.com>
 <2026052047-silica-grub-0bb2@gregkh> <CABBYNZKnrqHyASMOah795i9eteY7S5AfN3tCWssSRgqBXZwRMw@mail.gmail.com>
In-Reply-To: <CABBYNZKnrqHyASMOah795i9eteY7S5AfN3tCWssSRgqBXZwRMw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 20 May 2026 14:32:01 -0500
X-Gmail-Original-Message-ID: <CAHk-=whwq2_iaf7pTuzVXEcJmng_exwae_bKtgSDdm4BQivGHg@mail.gmail.com>
X-Gm-Features: AVHnY4JbF0smfoYDE8sbuuYGNoDoNmD1Smk1nthlg9vTbrAZFGd72HXyofmB_k8
Message-ID: <CAHk-=whwq2_iaf7pTuzVXEcJmng_exwae_bKtgSDdm4BQivGHg@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth 2026-05-14
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, August Wikerfors <git@augustwikerfors.se>, 
	Thorsten Leemhuis <regressions@leemhuis.info>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, Linux kernel regressions list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 May 2026 at 08:53, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> >
> > Just never rebase any public tree please.
>
> I guess the alternative is to do merges, right?

No. Back-merges are bad too, unless they have a really damn solid
reason for them, and some "keep up with other peoples work" is not
that.

The primary model should be that you care about your own work, and
make sure that that is as stable as possible. Do *NOT* try to chase
other people's work. Not with merges, not with rebases.

Then when your branch is all done and ready, you ask upstream (in your
case typically the networking tree) to pull it.

Some people at that point *jump* to the point where upstream merged from them.

Or another fairly common model is to have just started another branch
for future work. Keeping independent development branches for
different features is also a good thing to strive for, because it
makes it easier for different people to work on different branches
without messing with each other, but it also means that one feature
being delayed (due to unexpected problems or whatever) doesn't affect
other branches. And if done well, it also means that you wouldn't even
care about the whole "point where upstream merged", because your other
work simply isn't dependent on things like that.

So there are many ways to deal with them, but rebasing and merging are
typically the worst ones that should be avoided unless active problems
happen.

Sometimes you have to rebase because of a mistake. Sometimes you need
to do back-merges. But you should damn well have *reasons* for both
that aren't "that's just how we work".

Back-merges in particular need to not just be "merge upstream". They
need a commit message that explains *why* you're merging upstream (and
not merge some random point, the same way you shouldn't start
development at some random point of questionable stability).

Rebasing is "invisible" except for the mess it leaves with random
commit ids (and the problems it can cause for anybody who happened to
use an older version). So you can't explain it, but it should then be
explained to upstream why you ask them to pull recent changes that
clearly cannot have been tested in that form.

                Linus
