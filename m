Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DDA1FBF41
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Oct 2024 18:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729534027; cv=none; b=Yq8KZs9h3T+u+dKe/6Zx+GNVEcYEng4UKrZVLaXXzjWWtwO3MppFBb6KDZWj15RsMXCCFiY98IgxTJOwnoyQ+e9dO4og/Anfi/DShXy2ib9DgJi+yd309lE9oXGglt1dIPkwBNQfxSBAUOCVKqvoeOccjh1PhLJSDc+4JCQEpk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729534027; c=relaxed/simple;
	bh=M4kM5lUArydv5dJlC3xGAgRG9sLdyI57ghLl58KLUck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Se2msG/MgUA6HVjV4YAcvSfkGYjrAZlMGdlx7c8fnEJSuqKbzA27OLTXuxV9yap2MBG5lMuq5TB8MyrtcHH0JGoVZPFTcQbkk7/UDkK9BtCaqyYXJp02uAA0XK+x3gFsUdWv7dECsgdXnAo1TOSNiV19ou3zyzlhhsxEnsd8vGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CjxSxoAx; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CjxSxoAx"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a99f3a5a44cso557109666b.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Oct 2024 11:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1729534024; x=1730138824; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Vxq8+fnWQoCNUD9nqgZ6L3cBMv3ogByZUUYEqazDFpU=;
        b=CjxSxoAxokDhPQrE2NUWmOL/53p46LMNtF0yhhaelzBJEC8YsioLY4rLJoqWFaWetK
         uoQ7Qt++AwN2LlZajO90F3c5X4+QEClgrGsYaNYxadbdJr6E1Sf2dJp0pEmD64P0lZ6O
         ZEZ/kxeIRURITvPtuJDH6YW7DVtefJWpovpQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729534024; x=1730138824;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vxq8+fnWQoCNUD9nqgZ6L3cBMv3ogByZUUYEqazDFpU=;
        b=XR1fFHhgYwBfDCv4kz+HZRYLqhiXN5aSz+VLYIMn1n8oifZ+QnU45wdRS2vwRV9Ro1
         je1CsQHrAOuuHUPmOKdMGki25a36Cu10ttAY/PO0HWSA2DjnSD+e1ZcS30PEErM/1kZe
         oI8v9kSTXEvRHf4to+kGSIrDeXXeSnk1dM5Tq0Sot721ZDY7WVPqP/Hhk0qlhA12hNyZ
         VhtyAMZg6l3hrH0xD3X+wDo2nvDDk9sXhp3B9ljf++bbauwaa0GASDsFibAvtpprHNEP
         /Y7CEEnwvCvh3u0+6dwuW7ralH1FLvFXeKl7MYTCECJhNNbZm3rq1ghRJRgYs/bGx6dB
         p/Mw==
X-Forwarded-Encrypted: i=1; AJvYcCX1Uxjzh90EzRBgUePmrQ5GfMKd39ZGboxhULAYf4Y3/sgr5BPp2OGvRQZTKWo6vEegqblwODjlehXmwh/rdNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJp2WdcwABShUtoTKJ3Cy34gTw/cBbspuKufEURiDDl5goOKsR
	ydh4KxeZEiGLps8cAonhOqbJ6HBXtVjcd8gMMFCkZFv7h/IJUprmn5qw2CfCu89UZXwB6qXef4g
	ZFqA=
X-Google-Smtp-Source: AGHT+IGqjdTthZlSNseNBZ+2MBw88ulmr7v4+p8iQFjZP1yOYtbUTp4oHsZWWNUtYIDZmhYw3WhYZA==
X-Received: by 2002:a17:907:980f:b0:a99:fa4e:ba97 with SMTP id a640c23a62f3a-a9a69bad21fmr1187877866b.39.1729534023566;
        Mon, 21 Oct 2024 11:07:03 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a915724fdsm236584166b.166.2024.10.21.11.07.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 11:07:02 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a99f3a5a44cso557104966b.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Oct 2024 11:07:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWNoK1nTsaBSsCp2pSBgTRQnzxTF16e7BqYJHbwhoq/fP7UhniNPxJ4B6Y20+yaFGQ1NXtMZCsN6kKyP723vfk=@vger.kernel.org
X-Received: by 2002:a17:907:1b84:b0:a99:e4a2:1cda with SMTP id
 a640c23a62f3a-a9a69ccfc7amr827335866b.56.1729534022017; Mon, 21 Oct 2024
 11:07:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016204258.821965-1-luiz.dentz@gmail.com> <4e1977ca-6166-4891-965e-34a6f319035f@leemhuis.info>
 <CABBYNZL0_j4EDWzDS=kXc1Vy0D6ToU+oYnP_uBWTKoXbEagHhw@mail.gmail.com>
 <CAHk-=wh3rQ+w0NKw62PM37oe6yFVFxY1DrW-SDkvXqOBAGGmCA@mail.gmail.com> <9e03dba5-1aed-46b3-8aee-c5bde6d4eaec@leemhuis.info>
In-Reply-To: <9e03dba5-1aed-46b3-8aee-c5bde6d4eaec@leemhuis.info>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 21 Oct 2024 11:06:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgQhFPvneqAVXjUZDq=ahpATdgfg6LZ9n07MSSUGkQWuA@mail.gmail.com>
Message-ID: <CAHk-=wgQhFPvneqAVXjUZDq=ahpATdgfg6LZ9n07MSSUGkQWuA@mail.gmail.com>
Subject: Re: pull request: bluetooth 2024-10-16
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, davem@davemloft.net, kuba@kernel.org, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	Linux kernel regressions list <regressions@lists.linux.dev>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Oct 2024 at 01:22, Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> Just to clarify: I assume it's the "taking things directly and thus
> bypassing -net" that is the problem here?

Well, it's not a *problem* per se. It's just not something I want to
be a regular occurrence, because then the lines of responsibility get
less clear.

And we've seen (many times) how that causes a kind of "bystander
effect" where everybody kind of just expects somebody else to handle
it, and things start falling through the cracks.

IOW: having clear lines of "this goes here" just avoids a lot of waffling.

So that's actually one of the main things about being a maintainer:
sure, there's the whole "enough technical knowledge to be able to
handle it", but a *lot* of maintainership is literally just about
being responsible (and responsive) for some area, and people _knowing_
you're responsible for that area, so that there is less of the "who
should take care of this patch" confusion.

That said, in situations like this, where some small part missed a
regular subsystem pull request, I don't think it's problematic to just
go "let's bypass the subsystem, and get just this thing fixed asap".

Not when it happens rarely (like this time), and not when it happens
in a way where everybody is aware of it (like this time).

So I think in this case it was probably *better* to just pull a very
small and targeted fix for bluetooth issues, than have the networking
tree send me out-of-sequence pull request that had other things too in
addition to a high-priority bluetooth fix.

Put another way: having clear lines of maintainership is important,
but it's also important to not make things *too* black-and-white.

Exceptions are fine, as long as they clearly remain the unusual case
and people explain them.

(That is basically true of pretty much everything. A lot of the
development rules like "don't rebase" are things where the occasional
exception with an _explanation_ for why it happened is perfectly fine)

Developers are people. Black-and-white rules are for machines.

                Linus
