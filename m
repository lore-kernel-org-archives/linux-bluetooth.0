Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88938214A80;
	Mon,  3 Mar 2025 15:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741017054; cv=none; b=dFAZiN/7jH4YSYnFV0lvmoMw9Y5MEsDIFTiNxI+Xt7lrzY8klIRbcqPBzYB1xtyeED6szGep4wZwpqPmKNQ/Y4kabQwZmYx+YuPHsx+wXtauZx5TEKFg9mpcEFEhGE+f3bmnRWHA4FSZtjcoYS92lb2jwm6he2GLa7rdF2bpYww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741017054; c=relaxed/simple;
	bh=LSD11h3vH8DkVGp1a6ZXmYPOWhB8+23Hkxz6JWlFANY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CPg1YBRBIIGDPnOZ1WvqCNXikye5IpAonXSsPX2aK76XoWCpiYo+fDocG03mTDcDmSpM0oEGaG5FjsWcmYOwh8+Y5323Di+6P3VdNUWQ9ZeOcdWPxbf94n1JPDZ7rp692dpowALUO+PV7zl0PCZGk5HyDEAcWXA4tBm/6mgLKoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ev/o/tIl; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ev/o/tIl"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-307d1ab59c6so48927981fa.1;
        Mon, 03 Mar 2025 07:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741017051; x=1741621851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84/nxDHXrrgjKD/ucl57armSk0ZOr6uLTpY3LSxR7og=;
        b=ev/o/tIlUEnRvmgk2VkQ2ImWlFKiOtV2nmYcBBywPft7QviNpMQ1aGVzLqDIKU+iRK
         qLIDrT6XmUmZhu5Gcj8Of52L+rG95NWrHYsMiMNLgRl989elvK7WNIvDFOwWwv7LanvI
         U6ZU5WcLRGWFNxsgl/z7m0j4ZwBLqHskuxWK+Yd1j2ZVOjh1aZyEbrUpbHsO4K0X3v3l
         LkLR1Xj0Ci/65L6rA1X0gZ5e8737nFq+07U/T+DIENjl3D4oL7a8a3+vBooCVdUPMg1N
         NbSrA0jszM8MWYvmlXY05K88hp9GzRj8c9hGjPn/gxDn8vHUcOzdKhTqylSDQzyf+2/+
         tlew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741017051; x=1741621851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=84/nxDHXrrgjKD/ucl57armSk0ZOr6uLTpY3LSxR7og=;
        b=Ns7bWQO+osEFWKQ2Hpc8Oi7eafI6CCsHSoJQLqW2M5VcsVhZg/dWj4rVqM3ux8EmU+
         aYeyRG7yB5eDbwGg0hivBtqsJQRuqZEM8j6K/cumLfOdTTb1/ALwqVLUGueLi0ec+kCl
         ZGtVU1IwvXBKrcWkLM34736etrMZDqlyoD7riYzCpYPOQSgZMjrY+aSQtUVv9a5xzDlc
         gF0obVBchvIzQ0Va/3m04HS/xwAea0Gxs9wYRGYaeOJRJiIENnlFvwnNrwlXmmOjIMfw
         vGae6d2PKpnqRllGxKhlLs0rVUX7PtBFg+j7z1jiV/812iaGiR6YIBV692PtxOsVfgVT
         lugw==
X-Forwarded-Encrypted: i=1; AJvYcCUCr6oyq+Dg7DGadgeERcW2M0XCGPdkCILmYwr1y1skKVSp1TVYx01XfTVYGhbViHARl08EVet6RoODYhby@vger.kernel.org, AJvYcCWvy5FPdU+RMAEX6BPVQBH3SlcCpq7pxU/bUM6wgON+ZkDzjmH/NZr2tsxYVIbAqfQjJ4m0ve8vULve25pVZEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqiU+lf40kyBAnrk06oMju1xcvwrGHcv7iTAgooJnhAscgsGr9
	o7X/VFNffMlNwiP5s3KTio8EzJSMVh0eX2xWuDeskK0cJVLwn2QbLAUSOp+tPjLj4jSkC8/lGTP
	AzGqFC4hdU2G78RdPYxd/Cvrqcpo=
X-Gm-Gg: ASbGncvw4icL8ADP4RLFp20LQ2tCxsf/mg7+DnR1IrlCAndPqt5VJ/qlm50YMbtxw/v
	D9pHcKBLJqL0/9mBffEm6JKKFrKpViapxClkZMy+jxCeSbD2QxLrM21WboWCBsIITTW9ymG4DjD
	QuSpTzsovy16A6bHfgikw54Dr7
X-Google-Smtp-Source: AGHT+IH0uqn9ajZXsudRbFmByggH7SDOVTLq7h2InJNd+SYvYFO2b5VdldcnSTUN0MrR0xCJg4ruoCb9U0edpAgAunI=
X-Received: by 2002:a05:651c:b14:b0:30b:b204:6b80 with SMTP id
 38308e7fff4ca-30bb20472b5mr19478271fa.8.1741017050369; Mon, 03 Mar 2025
 07:50:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87a5a3ah2y.wl-tiwai@suse.de> <CABBYNZJOW-YSOLS0tBdUQmxqbOmgT2n2jVheyxbvWbYmBicqyg@mail.gmail.com>
 <877c56dub7.wl-tiwai@suse.de>
In-Reply-To: <877c56dub7.wl-tiwai@suse.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 3 Mar 2025 20:50:37 +0500
X-Gm-Features: AQ5f1JrUG4Z6TbqYNmR1odwh5ZzXNHXINSLwhowhbXiFuDiRr4FxTlw7fu0T-zQ
Message-ID: <CABBYNZJ6Gfmpur2by01B9+XxBX+VBzBY95v+9f5-VpiantunfQ@mail.gmail.com>
Subject: Re: Is commit 4d94f0555827 safe?
To: Takashi Iwai <tiwai@suse.de>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

On Mon, Mar 3, 2025 at 10:10=E2=80=AFAM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Mon, 03 Mar 2025 15:57:16 +0100,
> Luiz Augusto von Dentz wrote:
> >
> > Hi Takashi,
> >
> > Well the assumption was that because we are doing a copy of the struct
> > being unregistered/freed would never cause any errors, so to trigger
> > something like UAF like the comment was suggesting the function
> > callback would need to be unmapped so even if the likes of iso_exit is
> > called it function (e.g. iso_connect_cfm) remains in memory.
>
> But it doesn't guarantee that the callback function would really
> work.  e.g. if the callback accesses some memory that was immediately
> freed after the unregister call, it will lead to a UAF, even though
> the function itself is still present on the memory.
>
> That said, the current situation makes hard to judge the object life
> time.
>
> > You can find the previous version here:
> >
> > https://syzkaller.appspot.com/text?tag=3DPatch&x=3D100c0de8580000
> >
> > Problem with it was that it is invalid to unlock and relock like that.
>
> Thanks for the pointer!
>
>
> BTW, I saw another patch posted to replace the mutex with spinlock
> (and you replied later on that it's been already fixed).
> Is it an acceptable approach at all?

I don't remember if I saw that, but yeah anything that makes the issue
go away, and doesn't create new problems, would probably be
acceptable.
