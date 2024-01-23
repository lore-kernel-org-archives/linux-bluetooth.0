Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43905F872
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706018058; cv=none; b=Ldn+9jnuLxWT4VpnuQR4bWy1YQqsAQLPV8HVLSiuEHUvIfetYfK7mizj03WstsXMeJQHE+r7sPFaz+h+MRhP1IF34+Md2sUfTIRtaJETBUk3+u+dlqB1cJWifMoKbRP6VytKcSv1tDY0/4NIf4BmZmviX6aVFd9M+4x6yrppZsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706018058; c=relaxed/simple;
	bh=kZnEpml4U4egk6gG2SkuKjUjgvtpATJO6s23K59nszg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TFftW221xMpaSVh0NiRHN4FhAr5S452nHCJOvKuwDsPaualCtfNQ/ZrsH+SqoYjp4GmhIjBMv7bS0TQShXbJjMoukOQebOu3GkX6gIZyhNRgAYn7tAzkObcRYta0L4iuGAMtMeUCpmkAaackGYqfRsL7XRZ6o0MGRB1VpMRFhd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKqrGcrU; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKqrGcrU"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5fc2e997804so37947277b3.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 05:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706018056; x=1706622856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1cJlA3h4MfALXkKdXeo+eGjEAn5Xxg7KkGHkfmXzj0=;
        b=CKqrGcrU4Q+OPSDukLRiclAOHiDmJHFekTnJsKspD1+wtLmDJmpLUA68O1i0EpPVfo
         iPJeP3c94zw6dGX0qgdD9cA7aLpAkrZIJTw4YckDuoQz6oewd/ROA2h8bDQP3sJOT044
         jjkdWA6Tjk1ctkff2TvyYVeJchgmjrJvAV/93crMSnFBc3UI2HTeRI72lgLlI4Jww3/4
         lWMNFxyhCDpAGx5Y8P+qV0XlqBk6bsLgr0xG6nM8BR6fi8R8moe4jLXLEy1wKsXE5l0r
         xaBEGZ8pXOBZHb3MIcw1i017XjldhFtX2sMJp42BjamqOOrlZsRnxK1qVb25sTmKeSBe
         4/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706018056; x=1706622856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L1cJlA3h4MfALXkKdXeo+eGjEAn5Xxg7KkGHkfmXzj0=;
        b=UkxymRFjQdp33aHX/SquLWtQ+owHoM9es+DiBeuDDLJpFzHaPIJALooPoau77v8gEv
         tOqTwCIWK3eGpjR8yHWnfgE2qpISK6DhMua3psFXgKLyRKpFacskuIqJgbbCbxDO7acr
         4YnIsPBBRZl4f9BQ2ZQdNSTwCL2dynUEW7MoVf49vSLR/7nlFbLjbOLBWxo73uPuEE1l
         HaO4JSQn+8VuC+11O3p47uMfFRfZHOVxG8/T4KC0m8g1KH0wxQz13GZFY+OXrsikmG+y
         cjVHBG6v45gResDVjX8kPlTfYYshF1r0IImodLVAvTvpcEP+ulxQv0E5oXSr7ZSU2ETz
         TQ2g==
X-Gm-Message-State: AOJu0YyFzq7QmU17liMS6383DxBnTQ4qoi25GRaOTkmpexv+b1zOuSce
	ANQ90xhHEGGLpP8JAezI6Xdo8qi7pkLRREKtu84c7+rBzuzxNvw68W2jE7qcvXP+aEYkKpbgyD1
	eD5XWKHWmedKOHpAUCejiDWUVKnI=
X-Google-Smtp-Source: AGHT+IFlhlRSJamE3EakIqrd+gENnn8uc7rG1MIeUi5CdcHyidU434SdArfeKTYHddFb/y5tQc8OUhbZV/Eg121K6+s=
X-Received: by 2002:a81:6e85:0:b0:5ec:c970:19b6 with SMTP id
 j127-20020a816e85000000b005ecc97019b6mr4667982ywc.17.1706018055768; Tue, 23
 Jan 2024 05:54:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116-rm-ext-plugins-v1-0-62990fb07369@gmail.com> <CABBYNZKv+KFAAY-5-LwMdYKDHKtyh3BRbigUv06h_ZBLJPQobQ@mail.gmail.com>
In-Reply-To: <CABBYNZKv+KFAAY-5-LwMdYKDHKtyh3BRbigUv06h_ZBLJPQobQ@mail.gmail.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Tue, 23 Jan 2024 13:54:03 +0000
Message-ID: <CACvgo535rjwHh1J+kX8L8wYrgZJ0ui4DaLsjDqtptm5XU8dSHw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/8] Remove support for external plugins
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Emil Velikov <emil.velikov@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Jan 2024 at 18:35, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Emil,
>
> On Tue, Jan 16, 2024 at 9:19=E2=80=AFAM Emil Velikov via B4 Relay
> <devnull+emil.l.velikov.gmail.com@kernel.org> wrote:
> >
> > Greetings one and all,
> >
> > In this series, we prune support for external plugins and cleanup the
> > associated code. The inspiration here is multiple-fold:
> >  - the plugins are under linked - generally a bad idea
> >  - the plugins use undefined, unscoped, unversioned internal API
> >  - the main daemons expose their internal API increasing their size
>
> Im not so sure I want to remove the external plugins support
> completely, but I do understand that normally distros don't really
> want to have it enabled in production due to the reasons mentioned
> above, but I think we could find a middle ground here by disabling it
> by default but still let systems to re-enable it if they have some
> custom plugin that they may still want to use as external plugin.
>

Thanks for the feedback. Sure, I can convert this to a "configure
--support-external-plugins", where all the presently removed code will
be compiled out.

Still not entirely sure how external plugins are supposed to work,
considering the API/ABI mentioned earlier - any pointers? Do you know
of any example plugins that you can mention?

-Emil
