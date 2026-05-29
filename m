Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167A94048BD
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 18:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079926; cv=pass; b=VGQ+9EsRitFBv3LvdAFNb0h5zNqQAGLDHZdy+c0/T/cMGQkZsDo/6MF01sCcTCzaoDsBbLnyzs6YRSciDOXk4HmO5KD47F3CRB74qBvA56/b6FAMWCVJ8J5WOieBkvTDXATfeTt2nUczF+Ett1wDx/rFBYO0pQvYPQeGY/AVnfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079926; c=relaxed/simple;
	bh=SFtccoLb3l9zc2iIxLNfr+pNo9wHAKwDYS1fN9NT/n0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DUPBSaI15vHCSZNoFxagZRE/sosxhfchmIS07L3DZUJhLpXer1R+6W7Qh48/UucO+rGkECawy2wfYArS5r19GELo0BFm7LqK4piXG8Jxmn6qSrOEfud2lXMrkeNilYMEwSuoscf8lb5rG+WujY3SXWzuxBCVq1GZPaf0DF5geto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=boE/AcGw; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boE/AcGw"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-66058b880e9so707407d50.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 11:38:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780079924; cv=none;
        d=google.com; s=arc-20240605;
        b=bZXobunVnKq/q5mZT9lmMcS+mP9PzYW+FW6If6LYpUQ7FZnjfJYdBpi+ME69/OP4QI
         V5nN6heR1ctdkVBAwDxWgozAr6L586Fu9s5AVoyQ/nGmsd585A8Mik71agTl7Dh8V7j0
         wdwv1bNA3GW9MXKy3T0fF/6KC6U3leSfF9HTNZ5DpiWC1u3BeC/INAztsBgjC7zcGbuL
         5CK3MVeAEfSgA2EQFDwSwIP1+MOeOmT086CO3bvguy4H2QzszcUsAo2VGap6Z3B4Yxdl
         2l9GJfDxSDM7c5SEIC8i1+tik5chNXmLJRW80Vs9KCrXZ0FES4ZzUfI4xj+YOtSIxB+N
         oWOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SFtccoLb3l9zc2iIxLNfr+pNo9wHAKwDYS1fN9NT/n0=;
        fh=daFVVL4chqPq8Egt8CQA9DiAlOpS3zPWGTFFDUTXDDo=;
        b=WMLrKtR7oJTg/KmRtHRAoeCnVUYVy2K+ZcHcfvOxNWw8KlisEqkC3+O67G8lTY47/W
         mq81CTFRHaqcLBemDZv4Ql+i2+8leqlHbjYK1A3v82TUuikGiZ3o2himOsUbpYpzNDHd
         dfbj/2vMGek953hZWukuGunasRQxxf90kkAVa3K2xLE/1zjGUKZXFT9GcE5rfaCxQxy5
         RK712mPLypb+Ju/SAEp9QnObzgCKBSOG/5mSsxkPXQlivDeElgtNAwNqcU8YCLJ/NNbK
         FCLewYnISkWWoydD4OLnu3AHKUBkaw1JW6yq5luZ9D/ozPKM+QIzToIwNSVCB6tLD5LM
         3lMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780079924; x=1780684724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFtccoLb3l9zc2iIxLNfr+pNo9wHAKwDYS1fN9NT/n0=;
        b=boE/AcGwrQM5pVw17c9WBg0ymtKMRopTtyTccyycGhT0VKwuKWGNjWSEGfeUlAnpHl
         Fqu8Eg5sjBSQiOzg+YGzT0uPw8t8qpjW1fwxNf70K70DcjzO5AgAXwfIkkSuROioYiwm
         M0J354rgdJHUa2IhsCdJ5ir+0dJ82dyYAMMpNwvvVedOvRNnjq+oQtkL8nnPscukFUjx
         r0s1ZhSyJNyrL+cc4tgDppszmklgWEOTsIylb949Wc+WlN2aPYTR3pH5VFRCW3ygYJuz
         QnDgP3fs4ukZyA9x9t3D+AiEXooLIsCv4L5VsJ5TwxGaVpmclIvYYwRBkAXCMQA6Awxs
         0rtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079924; x=1780684724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SFtccoLb3l9zc2iIxLNfr+pNo9wHAKwDYS1fN9NT/n0=;
        b=GjSbeMv8Z09CdmBlZB5AT5Y10qlZipkH919gfTrsF87B+OBlgxc0nlrqG6sP8Cw+iM
         LSzkKTB5xLMeXMoRiI3YWoCGuSZrTAFnmkOs4TJ5j+rHlw6eRF6FisT9j/nc80N7iJJO
         NwTdKsU+iiFBTA3Kgw405zetivzxjoGFUGmb/7c3Kgel/qRI2huVNZuC33hSfiWjp7iu
         kALf5fJPpEa5ZWvmmQFQU9nzqSSa52+AQgnePJrDICdeqiPg0sBVd+XesrpgUa7Ldbt/
         lf2biMVgCBgzsqS9c5hXJ93NLNXicPFwpXRdFiqhm+ZilvBya3KQqRgaJqvaQ5Cuc8g/
         D1sw==
X-Forwarded-Encrypted: i=1; AFNElJ9PBpK8YGWBnZ9Gd3dFebqABQA6+Q1h+F8IdbfDP91RvfhHYJxVgtMDovDGfdBUso9AlI19hsaZ7AvkpkDkZsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyehXQah+DnU2aexGnZHVr+QKw4N4TX3vrXW7CrrpJFz4RKxSrg
	a4uTxCjENsWjCj5d16kEOwlp6J7dLMVqHRH9KCN2254R8KQoST6V2vTWzqCwgTjngfpMM3JCPxN
	tbBSWIsK7ljiYOHYfSyEc16oVbsARIIk=
X-Gm-Gg: Acq92OF94bUmQelpFQ2JQ2IhAj8L9FN29YWppFd77l1GW2YuToOXXa4R4AY7iwWQgam
	RB7T85j/KMLbPUnjmw4i/Uwf1rs2YWWzHqMfRS0zoipN/2fe9XREVV6ahp0BCRTlE/prG1aqlOv
	0QXTzBvKIRsnFkXaZXEojJqhAn2CO1vj67YYcUwPetV4d7GfQW6w9tJrhuRnAhIUeKnLrpMGbaK
	YsHBfflvaTHKYnWYEvD/HhjszOa7cCzz+E25PWXlpwTdUWlrCOQxODuFQJtlhHv6UlT10KK8fkF
	xpujnZFvK6D5VkqDQgSL1OxuiLutru6ef+9M6jDoB9nZ8MvVOo9dU9ZQZNptN3du3G0PexB2fe6
	ACA==
X-Received: by 2002:a05:690e:2547:b0:651:c160:1c06 with SMTP id
 956f58d0204a3-6605f17dc1cmr558121d50.58.1780079923810; Fri, 29 May 2026
 11:38:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528131839.462344-1-luiz.dentz@gmail.com> <46c6541e-9cd3-43f6-94d5-baac7b3fe7ad@redhat.com>
 <CABBYNZJjCVRp-00vA29nZahxOWYkCE03TnX=3-QWR7jzwx4mww@mail.gmail.com>
 <de887211-1005-43cf-b1d3-ddf1a82c283e@redhat.com> <20260529112024.2c0d2c51@kernel.org>
In-Reply-To: <20260529112024.2c0d2c51@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 29 May 2026 14:38:31 -0400
X-Gm-Features: AVHnY4JUj9gksxceVt0oHOCDSlEf9H8CdV4f4Gokr-amuunhelnWFcgboTNYuNY
Message-ID: <CABBYNZLKtrKZVhXOQz3Mq0joY-jXTBRk1bHGTps83v1M4FXX2A@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth 2026-05-28
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

On Fri, May 29, 2026 at 2:20=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 29 May 2026 09:35:20 +0200 Paolo Abeni wrote:
> > Even multiple PRs per week makes sense to me, if the average size is
> > still significant. I'm not sure about others maintainers opinion, pleas=
e
> > don't take my last statement as "a please go ahead with this" before
> > more acks.
>
> That's a pretty costly fix. It takes me ~3h to generate the PR I suspect
> it takes you similar amount of time. So it's not going to help the
> patch review queue if we waste time generating multiple PRs.
>
> Luiz, simply run this bash script before you send the PR:
>
> github.com/linux-netdev/nipa/blob/master/tests/patch/verify_signedoff/ver=
ify_signedoff.sh
>
> it's not the first time you're missing SoBs

Ive already integrated it our CI:

https://github.com/bluez/action-ci/commit/c1b86bca7cacc936bea82b3ca8b2ee4b4=
fcb6e74
https://github.com/bluez/bluetooth-next/pull/257/checks?check_run_id=3D7855=
9358818

I might be missing a local hook though, in this case it seems my SoB
was missing, maybe I could configure git am to always adds SoBs, that
said we don't use that on userspace portion of the stack.

--=20
Luiz Augusto von Dentz
