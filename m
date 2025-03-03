Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2C622F178;
	Mon,  3 Mar 2025 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019414; cv=none; b=j12Wb7G69lGcTioXXgR8do5DtcN8iTGUtZ6gG7R8W1OKj81zS7702qewarf7mM/DAbkEs34Xpt12kx/XWSfqfEkRq5DX9pQ6reCsskqCQKoLPwmIaArS0p19ZKX58SdjO8m8oYcosEjAoIYB8OVuUJlOUKGvVRUmSJDnX1isl50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019414; c=relaxed/simple;
	bh=gCpLZGk6d2LraPzUQfSO75O3BCaKN/MWPVFymzkjVUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NuknalVI4/uUmGGswvy9LWUeUnlm+vJaWxAqGNjSHlaoNkqtY8EWieXTNuVk135ZxTLnvJr83FTHQEFpiPAkaNMU0sucC+ZTFp0c/nfnRwQn5zAKBUBQ7IRHxPpL7st0k10p76KIIos/zuqeveHuf/AKc4P85OJ9RXdfo0Ll2nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKHyETmQ; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKHyETmQ"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30930b0b420so38848271fa.2;
        Mon, 03 Mar 2025 08:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741019411; x=1741624211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3JF0xMBR+WwT2sVa6zJeyjN1XH4wIWbrdBRs8wTzL5c=;
        b=SKHyETmQ9tkuzUkgaHyh3FGTwcgrN/dfrXWjWnhoWROgNMduWZ2aao06jHiaLN5XEj
         pVLdItQw95UjRAQuU+MWrK2uo42gRQmhWn35xrSqLVLeEORZK0u15DMQqmqKDLIDx+un
         ilSZVscWKrTUl9+Tauk3GK4FzX/usKWXVoSyEH2H8BevsdVQ32KvIrLQL9Wb2PlK6WNK
         kyy+Qa8tFhjX5inF+tw15Ppk3Xcelq3uVctFSaMkBAYZoG+AnJINPDNz6bblSZBYLfWk
         PqMU30jyCH04BOlEp1YEzB9pTt1nCMSdWIxHsP8ytODuqoTKvp1sWJSWatfZJRYIVSyP
         qiiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741019411; x=1741624211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3JF0xMBR+WwT2sVa6zJeyjN1XH4wIWbrdBRs8wTzL5c=;
        b=VqoEBV/iOnMEiQE7oQbignHaJcs8E3U9wDjI1RhjYnYEM/0kNwmHEPQOna9nAw1LzW
         /A6ed+cdTemaC1UpOXLFvVpYTeGMAX041x4i13tAE/iLeJ/Z3KOOzsqR8NUSVmbp46SE
         pS0Jt9dYxpAVLP7ivXlt9sLhnpUaw+SG1DQTW7sSofk+doTlcJ3sZJCaMKKKy5gOd/nI
         R5Td7PirkVBsbBDeqsnSZtUeFj0V23TR+rDzY+DHcsU+8D2nrcFBXJJW8frl9Lz9yDKw
         RTGjHk9xsYB+xUqGod8ycOMuJtwY0DRWs+jLTBWSG0a/Jpix1l7sTzxTBRpMLvf8VOMs
         VmgA==
X-Forwarded-Encrypted: i=1; AJvYcCW2L8VBaPgXeVpBDoDo89eKcTUDvzpMJuPdvqhJFE4cwW+lY2iStz+ktYj+hEPUz11VUbOM9EXRwyRCTB7UGWg=@vger.kernel.org, AJvYcCX0LsU5EFJ80BEUpC0aFZRGBBIs81OY6O9tR0dl+z4Oyn1ofbouj6DtG3O59c1A1RRWBEqHz9uOcvEht2ID@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ7gxw8XZc0Gm4qZmjsKqzR+z54RoRGQIagNx2Vqx5uvJyYaeh
	UNceDwBYo7+AnQp3CXsxZjcE9/gS04n5sLLdxYiduH32UUfYt1jOjwHYh/H6Ev276eFmC0jrM9m
	W/tAeeIn7enWMBb24sMpoCcqCl8w=
X-Gm-Gg: ASbGncthLdBuh3WjMi3EJ9qlZvpKeGbeYeIYYWG6LT5I2/O483AWSu7P36PdPnsOHnN
	dlvbckE1+IHO7K2eCiJH7S8zxRPOsjZDs41YgSe+taymWwPvV18sAoRw+G4aYxHedGAhJGnE6ul
	+mIdHtolfm2FzX/vy7pG3F2Sop
X-Google-Smtp-Source: AGHT+IFfpy/TVn7HOAEXHu6LlZnjUDcGf9rgeYdMySN3cvFDulhxN8Y25ukrxktnaSf1XOKr2/QdU+DTlBtrWHu+9FI=
X-Received: by 2002:a2e:96c2:0:b0:308:e0bd:a091 with SMTP id
 38308e7fff4ca-30b934623e4mr38116531fa.36.1741019410599; Mon, 03 Mar 2025
 08:30:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87a5a3ah2y.wl-tiwai@suse.de> <CABBYNZJOW-YSOLS0tBdUQmxqbOmgT2n2jVheyxbvWbYmBicqyg@mail.gmail.com>
 <877c56dub7.wl-tiwai@suse.de> <CABBYNZJ6Gfmpur2by01B9+XxBX+VBzBY95v+9f5-VpiantunfQ@mail.gmail.com>
 <87y0xmcdl4.wl-tiwai@suse.de>
In-Reply-To: <87y0xmcdl4.wl-tiwai@suse.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 3 Mar 2025 11:29:58 -0500
X-Gm-Features: AQ5f1JoJWfI57iUJDIvknxt8WH2nhxh_U_EwNLKLgRIt7x4HN_2Y-fusx9Ou3c4
Message-ID: <CABBYNZJsqXLRuY6ZMPujio7-tx82SHRZyZh=tChonVs-XiWMjw@mail.gmail.com>
Subject: Re: Is commit 4d94f0555827 safe?
To: Takashi Iwai <tiwai@suse.de>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 3, 2025 at 10:56=E2=80=AFAM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Mon, 03 Mar 2025 16:50:37 +0100,
> Luiz Augusto von Dentz wrote:
> >
> > Hi Takashi,
> >
> > On Mon, Mar 3, 2025 at 10:10=E2=80=AFAM Takashi Iwai <tiwai@suse.de> wr=
ote:
> > >
> > > On Mon, 03 Mar 2025 15:57:16 +0100,
> > > Luiz Augusto von Dentz wrote:
> > > >
> > > > Hi Takashi,
> > > >
> > > > Well the assumption was that because we are doing a copy of the str=
uct
> > > > being unregistered/freed would never cause any errors, so to trigge=
r
> > > > something like UAF like the comment was suggesting the function
> > > > callback would need to be unmapped so even if the likes of iso_exit=
 is
> > > > called it function (e.g. iso_connect_cfm) remains in memory.
> > >
> > > But it doesn't guarantee that the callback function would really
> > > work.  e.g. if the callback accesses some memory that was immediately
> > > freed after the unregister call, it will lead to a UAF, even though
> > > the function itself is still present on the memory.
> > >
> > > That said, the current situation makes hard to judge the object life
> > > time.
> > >
> > > > You can find the previous version here:
> > > >
> > > > https://syzkaller.appspot.com/text?tag=3DPatch&x=3D100c0de8580000
> > > >
> > > > Problem with it was that it is invalid to unlock and relock like th=
at.
> > >
> > > Thanks for the pointer!
> > >
> > >
> > > BTW, I saw another patch posted to replace the mutex with spinlock
> > > (and you replied later on that it's been already fixed).
> > > Is it an acceptable approach at all?
> >
> > I don't remember if I saw that, but yeah anything that makes the issue
> > go away, and doesn't create new problems, would probably be
> > acceptable.
>
> I saw this one:
>   https://lore.kernel.org/all/20230907122234.146449-1-william.xuanziyang@=
huawei.com/

Ive might have missed it, we will probably need to rebase it but other
than that it should be acceptable.

--=20
Luiz Augusto von Dentz
