Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388431CF93
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 09:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722416714; cv=none; b=J8NAA4inzytXU7+pGVLpaSQOz5tDbLU3Xlt/c8fBnZRfSQGjWIFIVIXffXojzM7LcVOP4zpklZr1KMRNc6f9I78n6mgv55mHm79a01jkkajK9ALHIdxHi2uAsWkISp9vS25HFkddnfb04Dhi0+F5qj9OVmihSwNhCrUl5yY9A8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722416714; c=relaxed/simple;
	bh=s0tfu28phXWOJoUZH9phstl0pAqtBwTGxbvr2lfPSSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P7sJl90KJOJ+zG11zwc1+70saekLyWGknz910u+qI9YMJkrAFfAyUmRFmrT5O4SCinZ4+DI4hlkx8Jc+lMd2KCWqmd20M15FFXOPOYM0asc4umF0dirdtOGKD+iX4iKPs9S5d+sGO81lfgoy25syrg/4gAJH4xNjI5cKqIpe0qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UTQYIx6+; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UTQYIx6+"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-66a1842b452so31905947b3.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 02:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722416712; x=1723021512; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s0tfu28phXWOJoUZH9phstl0pAqtBwTGxbvr2lfPSSs=;
        b=UTQYIx6+sx0qbVovb+HKXKraQD7THHLzmERrgHxeb611aqiz5BWrC4xquHZF/U7qho
         S0IH6xlDGFvTxFHuu3qPQ+dTqJbSHKCBFWuiHAoBdahMLfAAB5RW4qYtsEQxZ65kW1t/
         aLgQPumlRTlMcmCY2dQoH1ChEoCyODowmjsIaK3Zb5LJ2TJOxW+Y82ZKf1LHlWF/dgsk
         uIVV/XdCEYxDEbdeDDkkWXhXfzXisYCGDDCaQdzjSGCRzzk21SPaXY66oUx+95eoZHXH
         BwMXNK8P+ogOQmFQmR5G5mua3+lorwo8erLg/mtxLj8jz5LdYPV5L3XjOv+W3+sCKnnb
         B74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722416712; x=1723021512;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s0tfu28phXWOJoUZH9phstl0pAqtBwTGxbvr2lfPSSs=;
        b=G7FQAyYOgUXiT7xOLz3XwbgHsNUeYHP1qnWpqwZ8KMq5TUHAVZNNtfA40ZisLhlOZk
         /6p4d8bmxU0NQvwXpxiztlblMOuMfHbTaSz2tB62s+HZmzlb/HT+VEHBU3hxVx+abcyG
         Sj4hHssHCp4BQaa54KSz2Rxn93Aii/LhW209oYHfC9V0tsYcHq7FaZEmFhiHJyP25EvK
         5nVo9F1C4is390/SmRorDLDe38WMYOgsqUemJ0/5kZYLRuaDtR4Cqjod3O+NsjWBsjIx
         QL0h3k/cPeJYg2jduKqV8nu1KJEvYVCuE+MN1z0DZXSModKO2pBUlPauUYfuEPfdLLfu
         xl0A==
X-Forwarded-Encrypted: i=1; AJvYcCXhSLWyoRgEfW7BRFQ2TZ4z6AzQiNkxHcjnzTbKVDXDUmaVL4Mpd1B2wDsQPmfsY9FtQnBnX9aqAvxybeYI8PGgRmdG0hMZAVyfGg//KO9b
X-Gm-Message-State: AOJu0YzkIrlN+aeLgpAWA44se1vAz+OqSEjHqK9/1PT8FMDvorDcdawK
	bEipDCIoOlGadFSY0TWrBHWC8ZizTpW/sg6yumbFbXx5CqSHKZd4tI3qGYapn/xWDLIzFP7oBcE
	ixYt++tdWg5tq7ITVD8Vgc2833SfdNjRPusFrI3UzNEfkeb+t
X-Google-Smtp-Source: AGHT+IGI5zDyxKWVurDZtVUiGA6SIBoyKTWz9+Fkgv/AVvmqujupn36hnIOy4tmqgHwlY6ofZZM9u/ZQ7f2MHIWRSZo=
X-Received: by 2002:a05:690c:a96:b0:64b:f86:b7a8 with SMTP id
 00721157ae682-67a06158d2amr172926917b3.10.1722416712101; Wed, 31 Jul 2024
 02:05:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <27e6a6c5-fb63-4219-be0b-eefa2c116e06@penguintechs.org>
 <CABBYNZ+vVFUm1Tb+BvViYMJd6XQczTYPgyO++GGbCcWrkaC4Kg@mail.gmail.com>
 <30319168-9456-49dd-be27-480b2a068fe3@penguintechs.org> <1a519b2f-f5cf-40b3-8223-162dc04f8ca8@penguintechs.org>
 <21645f07-da90-4441-8dbb-d999298165e9@penguintechs.org> <b1061ec0-5f8f-44af-8955-2d6fa11f94b3@penguintechs.org>
 <CACMJSet3H3B1rz2eZyxUr_ySUOdhTkAognfKpFZ=Kzto8UsxMQ@mail.gmail.com>
 <534cff38-7bbf-4e9d-90c5-c4a4ba331a8e@penguintechs.org> <CACMJSett7WOHWnfNGwtWL0sQQ3K9rqr08W9KDF5U=rJbpBZfzA@mail.gmail.com>
 <CAA8EJprdmXfJYx2xk5fcV4UgWqeBPekrgv1iv7F7FugaBH6=KA@mail.gmail.com>
In-Reply-To: <CAA8EJprdmXfJYx2xk5fcV4UgWqeBPekrgv1iv7F7FugaBH6=KA@mail.gmail.com>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Wed, 31 Jul 2024 11:05:01 +0200
Message-ID: <CACMJSesML_Q-Z79XyAZd0sJuE=AbGQ-TWozPWTRmdF3sMh7VHg@mail.gmail.com>
Subject: Re: QCA6390 broken in current kernel
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Wren Turkal <wt@penguintechs.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Zijun Hu <quic_zijuhu@quicinc.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 31 Jul 2024 at 10:55, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Wed, 31 Jul 2024 at 11:51, Bartosz Golaszewski
> <bartosz.golaszewski@linaro.org> wrote:
> >
> > On Tue, 30 Jul 2024 at 22:05, Wren Turkal <wt@penguintechs.org> wrote:
> > > >
> > > > Hi Wren,
> > > >
> > > > Thanks for the report. I was made aware of this yesterday. I had some
> > > > more regressions on my plate but with those now fixed, I will take
> > > > care of the Bluetooth breakage tomorrow morning.
> > > >
> > > > Bartosz
> > > >
> > > >> I will next try Zijun's suggested patch.
> > > >>
> > > >> wt
> > > >> --
> > > >> You're more amazing than you think!
> > > >>
> > >
> > > Thanks! If there is anything I can do to help, like test a patch, please
> > > feel free to include me. I'd really like to help you, if I can.
> > >
> > > wt
> > > --
> > > You're more amazing than you think!
> > >
> >
> > The issue Dmitry reported to me happens with qca6174 not qca6390 which
> > makes me think it's a different issue after all.
> >
> > The laptop you're using is not supported by upstream device-tree, is it?
> >
> > Is the device tree publicly available?
> >
> > I'm thinking that - since we switched qca6390 to using the power
> > sequencer exclusively in the driver (we could do it as there were no
> > DT bindings in place that would say otherwise so no ABI contract) -
> > out-of-tree DT sources could potentially stop working. You may need to
> > update it to reflect the true internal architecture of the qca6390.
>
> Please allow me to point out that QCA6390 supports binding via ACPI
> tables? And it might be used on x86 laptops with no device tree.
>
> Dell XPS13 9310 is an Intel-based laptop.
>
> --
> With best wishes
> Dmitry

Indeed. I don't know why I assumed it must be an ARM laptop. I will
come up with a fix shortly.

Bart
