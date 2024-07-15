Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B4318C17B
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jul 2024 14:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721053971; cv=none; b=Q5irerEKAql6nfCK2JSQAOUJq8G+davrdYvwX1dYh8bLIGsmF75mYcGDbv6S3rFmFut7imIZxZJcL9pSBtPGAduTi7LZRJ7Q1vYKCOkV+QMdgU/AGdqTXqpSR8+4ry/jzO9oepXb2pKKmE8Cne77kVs21nZkgqcTBxzwJuT2Xd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721053971; c=relaxed/simple;
	bh=Br5NjM+8wQNBe7Uk9YsTAeXeTj40IkCtiYiYKTREDRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=abxRCB5q6GJq/I0G9EsCYo33b5OlBbFfMZ9l2gh/cpT1g/p1SN0h90tZOrU9obftfF3VFB69yZHHSCCjO3QzbJyjS48j5tFDeqSBBX4hf6HfkhbPrSQOVdOW8FLc5b4JqwSJvE6lGZH8wpYRMMte4jMK9EAv7861PtaXCFlWeaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fHnsMSB8; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fHnsMSB8"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-65f9e25fffaso19635507b3.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jul 2024 07:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721053969; x=1721658769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XBIY7M7BM4brKFl2c3AgS2v9Iaoh8qE16Ej5dbPbOE=;
        b=fHnsMSB8XPdHXS3+Bua0iBWxwfRb4L8W9qpngSogVLwVp502ChDLKV7mnBvadj2GNt
         M7gB6/IHy+xavR9GYxhwwcff6WPpBmh+B97+IbdoWIWpRJsRNpXzQxbGJxwa6AK2D0e8
         9NZ2Ah8uy/ATtH/MyquacswvoLwadswjXmiUjtjbpSYY+ixlZoHhbCkMn33ph/fKJG1s
         SYQJx/Fu1yhegghCEltYh9KyYapeQ2rGQSCE97cTu6QkQrHKhs7hS1Jaq240XOLDemEI
         YTsXgx6FWM7fW1k1xQYUsnjLJkIKzfGzBnoN9UhsYKCLJSYTw5nom0nbQrhcxV026Z1t
         I6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721053969; x=1721658769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8XBIY7M7BM4brKFl2c3AgS2v9Iaoh8qE16Ej5dbPbOE=;
        b=fZt4nOoWI2F65dItMMP/zm3S7fYu9a4t3XF6NrgTfBZa+B1aoqs5ydDfBrrmeOcYeE
         LIi+J91hCoQmVajC26w6ti/O78fWfhPy192XVmobiMB4bUuTW92tvRrg/VoMP2p1PH+c
         BFu6fhbpnW7Ve30uhifdlxy8rmPsXhKK4UEUE3o6iPEvJcri6cP2A2d/9A7wYLkAe9g+
         +V1AEBwBQTwyI3m5dYbcoTEIQxTm57yCBng3BKpgxMCEvCF1rfX19aLBkewpCbdLveza
         4qsralans1GOmyJ3OQxx6G2qh7+HkijccS2AJK0Kr1RdqaaidaLAXi6eGUTUuw8hOLnw
         S+9w==
X-Forwarded-Encrypted: i=1; AJvYcCXdwSoks98V4zk3zMxb5ELW5Q1YyMOPqxB+Wb6dS/3VsTBZ9/D6Bs5KVbDyZBuPRJHKjZ+uzWkaMnPofMKcO8roaTrorElVbniWI6MtlKdS
X-Gm-Message-State: AOJu0YwY6ZoS2poCJmdRcI9Mtv+Kv5fxdmIhyvYUzRxvGSmNkdXs3H4M
	CUY3nGJKvFCL7L/oC/O/PrYOX7gf0FJL38vADwX43R2tm2leqtzafkJk0rwtZI8FZKG4WoCWpf6
	jGq5xuxZAt9iboNsEJxmpmv4rOC/r5VHg5gNQPQ==
X-Google-Smtp-Source: AGHT+IEsBnieFa35w2SSedbZu4wM92dlRuNoduR7DEiwRWhJOSszj9ucHx3kBKQaHbI5F1b0vzWl3n8BTBqXpvCzljI=
X-Received: by 2002:a05:690c:4a13:b0:64a:7d9b:934 with SMTP id
 00721157ae682-658eed5fc6dmr231759647b3.16.1721053968979; Mon, 15 Jul 2024
 07:32:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715015726.240980-1-luiz.dentz@gmail.com> <20240715064939.644536f3@kernel.org>
 <CACMJSes7rBOWFWxOaXZt70++XwDBTNr3E4R9KTZx+HA0ZQFG9Q@mail.gmail.com>
 <CABBYNZKudJ=7F2px9DYcqgpfEJX7n1+p4ASsH24VwELSMt8X4w@mail.gmail.com>
 <CACMJSesSpm=C67LE9Nn+fBS_JLZgzA_h-ocnPGy_wqzy8vH70Q@mail.gmail.com> <CABBYNZJJZp1Ge5UJS9SgR+YrYVA_-fLaM_Ft_51a3Bz+Q8JJWw@mail.gmail.com>
In-Reply-To: <CABBYNZJJZp1Ge5UJS9SgR+YrYVA_-fLaM_Ft_51a3Bz+Q8JJWw@mail.gmail.com>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Mon, 15 Jul 2024 16:32:38 +0200
Message-ID: <CACMJSes8SYppYf1ix+5N92YyiVfmkkpz2xYeVv8iA0e5mBGzsQ@mail.gmail.com>
Subject: Re: pull request: bluetooth-next 2024-07-14
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Jul 2024 at 16:28, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> HI Bartosz, Jakub,
>
> On Mon, Jul 15, 2024 at 10:17=E2=80=AFAM Bartosz Golaszewski
> <bartosz.golaszewski@linaro.org> wrote:
> >
> > On Mon, 15 Jul 2024 at 16:00, Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Bartosz,
> > >
> > > On Mon, Jul 15, 2024 at 9:56=E2=80=AFAM Bartosz Golaszewski
> > > <bartosz.golaszewski@linaro.org> wrote:
> > > >
> > > > On Mon, 15 Jul 2024 at 15:49, Jakub Kicinski <kuba@kernel.org> wrot=
e:
> > > > >
> > > > > On Sun, 14 Jul 2024 21:57:25 -0400 Luiz Augusto von Dentz wrote:
> > > > > >  - qca: use the power sequencer for QCA6390
> > > > >
> > > > > Something suspicious here, I thought Bartosz sent a PR but the co=
mmits
> > > > > appear with Luiz as committer (and lack Luiz's SoB):
> > > > >
> > > > > Commit ead30f3a1bae ("power: pwrseq: add a driver for the PMU mod=
ule on the QCom WCN chipsets") committer Signed-off-by missing
> > > > >         author email:    bartosz.golaszewski@linaro.org
> > > > >         committer email: luiz.von.dentz@intel.com
> > > > >         Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@l=
inaro.org>
> > > > >
> > > > > Commit e6491bb4ba98 ("power: sequencing: implement the pwrseq cor=
e")
> > > > >         committer Signed-off-by missing
> > > > >         author email:    bartosz.golaszewski@linaro.org
> > > > >         committer email: luiz.von.dentz@intel.com
> > > > >         Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@l=
inaro.org>
> > > > >
> > > > > Is this expected? Any conflicts due to this we need to tell Linus=
 about?
> > > >
> > > > Luiz pulled the immutable branch I provided (on which my PR to Linu=
s
> > > > is based) but I no longer see the Merge commit in the bluetooth-nex=
t
> > > > tree[1]. Most likely a bad rebase.
> > > >
> > > > Luiz: please make sure to let Linus (or whomever your upstream is)
> > > > know about this. I'm afraid there's not much we can do now, the
> > > > commits will appear twice in mainline. :(
> > >
> > > My bad, didn't you send a separate pull request though? I assumed it
> > > is already in net-next, but apparently it is not, doesn't git skip if
> > > already applied?
> > >
> >
> > My PR went directly to Torvalds. It was never meant to go into
> > net-next. You should keep the merge commit in your tree and mention it
> > to Linus in your PR.
> >
> > Bart
>
> Should be fixed now:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.=
git/commit/?id=3Df497862d99ddbf4e46d6e26cd0f40adb724f55c9
>
> And I made another tag for the pull-request:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.=
git/tag/?h=3Dfor-net-next-2024-07-15
>

Commit hashes now check out. Looks good.

Thanks,
Bartosz
