Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B9D3D8107
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 21:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774041598; cv=none; b=g1mJhG345r1+gmsLS2wCV5mUfFB4trVms+dX+wiY1RJaRjf9O3L62bwCf6hhccuw5XTfaYCp8VHeD1bfSfvwFbkF7pyOIpX4WNkv6giP0IeqA6nSi8n8WOpWYDsi9MFBJ/EMMaCxKr+ryO7cJXoJKDin+VxGkzs4RZ9ZjYNl31M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774041598; c=relaxed/simple;
	bh=HZRLHEwGWpwaQuLLrSh40uPRxk7ylCvGq0hs14KucR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lOQijLuJq7JDQaHV0+pOAkQnj5xbkmf246HLY4wgVMKe7dX69BwrdD6Gu5tU2tBD9tJsz9aM6rPVPTdHkAfdlE+nnkfiVWOhOe86dSBsU+GDtqKmyd+JGu8Ljdhi1lAtwjSUK/m4+dTolBf+HP98wy2H9ccqfGEy4mkRT6VP1eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eMDEouhS; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eMDEouhS"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b982b0889d8so204172566b.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 14:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1774041594; x=1774646394; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XCE3Sb6hrBAlOh+2FMHN/3IZlK3Hh6o5UrXz2dr3r8U=;
        b=eMDEouhSzs9exaBlbpACFyebZTFs3/a1JRwqnl6O8PH1E+uMaOwhH22MSGCtmsOYQk
         IO03GOrQF82Eaa3WvbITXsHMrGcgQH27vphf7MLbcsYWdZgx+nLEQP9pFmJ7QpoRw7pq
         NRyz4LOlLewWTz2p4/3MoTXbwJgnVbLW5cX04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774041594; x=1774646394;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCE3Sb6hrBAlOh+2FMHN/3IZlK3Hh6o5UrXz2dr3r8U=;
        b=EvjC7ZPYHJiXUV/rA4q1MRfEObX1oaOakpqgHCoSp079B9a1OHsRnSwZmuwakwjUDC
         ynPeo59ss4uG2j2W1nFSeEj/BQkMkFqBMGD+ij/sGMKmzVILfquU1qEIEPouesQrt3z0
         OtTVs/nk0S3viJmv6NbpXh8cbRmjn9GPhhpQDGaNJq8mZtHAe9qOy8Vcn7cUgyoLBcyu
         8NJY2dqB1i+6FNqJCEy2L1YtlsFLrN7HmZi4JDKP3eVJqFgtDGcPfzJ6BV8J10uAr9OM
         4LpCPA93Xxgz3csFFN6PvljyNQEmK1oILMS0EtrE+H9VrJLlIbU41ENsmIb60wYYYspW
         wTuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWk8syBuiRoL8h0klsRggtnB28necaq76VpZGcf0sFW/MkilSORUVog2KFah/+L23qP/pBA176PUP0ie9jq8Ew=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfN1alndQ2zfE8jKDyxxtDme+zp9MPjTD6yrWVQD4qKBo2mKk7
	7wMRZ9PQZCqp2LikbNK0LTsKdkfz/qpeAoowTPuuRhzdCMmdA2nQOMsH+PCf96lsbL8Pn4s19ws
	LGm1sWhM=
X-Gm-Gg: ATEYQzwKiRuZdGlELfvRYufugX+ZQgEg7VPmRN2LsRP5SFJVR0KnaBM5tPvnKU1Q7o9
	0dsEF0C5M1Y/d9yrH+b/0kE8LaJgg24uIAOfFNXAIu+xR4lnFrVRg8UhMCyWfUCKsautIJng0yd
	lmvnN0sfZOfV9MhJUrgWpH+RnzNDWT9FKSyLwxLh3OyiHCT4c2QxqlQBU1JLOVA6vlpq+cAIKfA
	NtcR20YETM9ner2QlJfCBZ+NiBL+mk5fA/xfUc85Fc0mDbAR57+y0CNQDqX9NZ7sViDqJW4YW4+
	X15Bqeu3IbYo8Jj88qXvf+VxonqanxhbCUVsWJDzvblGVbmwV7tDUa3J5VzreuBN63RNhD2tFIF
	Iac3pENO8+1XE7hhxJZ84BVoobAPWFv0f+9au9JxM78DhwRthnjXcv9gMR+8VyV8aMr93P2sJfp
	G22jSUrVkt09pPIZ3tnjFvN/AvkKL+/alz0Km7/j/ujv0wN2Uvd6lGrmXoBzmXfmQQIl6Ml7Hl
X-Received: by 2002:a17:907:3e8c:b0:b98:33c5:1bb9 with SMTP id a640c23a62f3a-b9833c56776mr303971366b.35.1774041594561;
        Fri, 20 Mar 2026 14:19:54 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b983398c140sm195792466b.63.2026.03.20.14.19.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 14:19:54 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-661d20c9787so3756504a12.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 14:19:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWQ5K4HoJzPEkQh+N2W8HjDs5RZuEP6Zv36oTF9mlPe6t2Cr4z0PC5ybIRFF2kF4pgZA1JP6bgLKiPW3tnL7A8=@vger.kernel.org
X-Received: by 2002:a05:6402:3786:b0:668:8c50:284c with SMTP id
 4fb4d7f45d1cf-668c911da49mr3212716a12.11.1774041593499; Fri, 20 Mar 2026
 14:19:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319190455.135302-1-luiz.dentz@gmail.com> <177396481128.1855248.1024090053580545012.git-patchwork-notify@kernel.org>
 <6411a735-d187-4848-b199-a0e2c2e0e52c@leemhuis.info> <CABBYNZJfLf6PzKUkGjiCvqEm3h0+3SUcxY5RNbUHv6LBdPT_zQ@mail.gmail.com>
 <CAHk-=wh8dnp1qT_CHG-Zz9H2=G1Q=0rF5SYv+YsEaPnVhznxWA@mail.gmail.com>
In-Reply-To: <CAHk-=wh8dnp1qT_CHG-Zz9H2=G1Q=0rF5SYv+YsEaPnVhznxWA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 20 Mar 2026 14:19:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgryF_COh9xzhGaJ-FAm471pn5uvqt-Z94+3ENPVu4w-Q@mail.gmail.com>
X-Gm-Features: AaiRm52w5UPxNX4mH_HiyvwPIsVpHwHmqg_LpHJqM3MhIn7krj-l7qPCQ22Gurs
Message-ID: <CAHk-=wgryF_COh9xzhGaJ-FAm471pn5uvqt-Z94+3ENPVu4w-Q@mail.gmail.com>
Subject: Re: bluetooth regression fix likely to miss -rc5 (was: Re: [GIT PULL]
 bluetooth 2026-03-19)
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, kuba@kernel.org, 
	linux-bluetooth@vger.kernel.org, davem@davemloft.net, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Mar 2026 at 14:03, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> That hardware may admittedly often not be great, and we may all wish
> that it didn't exist, but hey, that's the thing about reality: it's
> often messy.

Of course, the thing about "reality is often messy" is that then you
end up with the truly conflicting situations where there are other
complications: security issues can sometimes mean that you *really*
can't just revert a regression fix, because while paper standards and
artificial tests are relatively worthless (compared to a user
regression report), a severe security problem obviously isn't...

Also, if the regression reports then come in late, people may have
started relying on the new behavior, and reverting things then causes
its own set of regressions.

But when you get a regression report quickly during the early -rc
period, that tends to mean that it's either a really bad fix, or it's
just a very common piece of bad hardware (or a shared bug across many
different hw implementations - which obviously is often then due to
some common chip or firmware implementation or whatever)

               Linus
