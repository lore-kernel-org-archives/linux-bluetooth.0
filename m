Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA9933B6C9
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 15:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779205801; cv=pass; b=JbtO3hI/RCUQFQrH0IS5mj5lRSaeZKlPbcfJRVWP4jmTel//Xa5gPuBwtgguHKDyryXVFViZzoE5k915G9XZKraQeuSwBOtxOKnVC7sx69uErxcnaurV71R0gfMfyH3LnT+38XiMxQvGzNAhhxrPuW739wIkP7knU3jwIuDb/ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779205801; c=relaxed/simple;
	bh=x/7cCwdNDXXJxtXg1SGsgN05u2+rsVMZSWA2qFFjjh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X9jcmAwa7xsVn2/4azz+diRoCyexoiBR8uLGjETnsZvqqDobf/+GL42vzHYcA1mAU3a3vE7R8ekEyglx9jTxbMb5AmmQ6ENi4ojY8fRGZ7lg9BlNcr+OqV8uHpdvYpIdmdwEVGnwh1g0f9o8xAHPIzO9KIg9UcP4FHVnI6nWM+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEiXkpkR; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEiXkpkR"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-65d071aac6eso3114480d50.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 08:49:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779205798; cv=none;
        d=google.com; s=arc-20240605;
        b=jlIlJs9ClA0uyzsml6RVRiKhTuwe4w6PbNTsJpyrz1YWTY+dj1oMqhV9aCKus5dYeu
         eH/44FgXtWuv5Rzi/G/ZwQrWaUn2hzCgsXVoB/GPFQC7kDu9lVBgtjFqwuzHrjtR74oz
         mmlYKL79a1ldEw0m5zZuywUl3c+0lbrnHrxmTppLKjumEQm0oxk0FKl1yn5kiwhZ0fKk
         Mlx/OPsj3w11+oCRDTA3qRQsFjlzWBV3Ufo2KlBwmFTrqQgbEbFfWBYm3RwqzOVuTXZ3
         cnLPUgJIAHynlaz9mod+EY51wvhmWyNRtvFh7NweSTAmI2YotNulCgzdH9lsg3vwKy6u
         ktXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=svXaO9Car/cL1x6P0kXNjSbwoRo/ZLSYkrf9JDZDMqE=;
        fh=/tfYwQ3NTCq+NIT4JYWVF8VhTpn8qGYH2fj3jFZhH+E=;
        b=jFjzwp8Zu8J1yIihqcBdQAAJKRJrxHM5Hew/j07JgUi4fVdK+PpnsUI+HaBb1A/klq
         RQXQ8h27hUxRnDkkNkqx332dIguyjam5oU6BP0nkKd0RViPvOkOtk6LXwQ8QoGGMLE1x
         AKiB05P4ZXgTVsVea8v4tPNO5Lr37dRiuQgclkrD9xZqJ5f7VMw0iYEZiU5K++sJy9km
         7p7sDb5cvmvQmJMgiW+H/FVk23+92X24g9ag8tCz1yiyzknJ9Q9C1bUVYxuaFmT9epWN
         rXY0+hfjeI/HA6wq6S+cJnNm039DXwg87NWKSgTXJ+0drLoX3ZDzaZf1zy9GPwiZxtbD
         730A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779205798; x=1779810598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svXaO9Car/cL1x6P0kXNjSbwoRo/ZLSYkrf9JDZDMqE=;
        b=QEiXkpkRj4+tE3U+2AlitOx/CXjgde+D3wyFc+K/ivxh2pXy0UmTqgrtXuqMm68o1V
         jOZkrPoI1ajdVVx6Mlz0Z7jN+VSM8k84LKF0NZAUCLgnZS8eNTSxAXSZZ/QGhTpmjoi2
         cfUrsM7wBc7xOOos/MtU1uyfZqKSkKqhfAImmnQte4ywipgLktjLiuSGOarn2fD35y3G
         lMaa1Z8nt6DZA/18qQaXmFlA7lnM0e4SnMgqAnW53oKmw/q8ZmaJedqbOKSrrhQYw4io
         eUF6rjZIC4zrgXcW5KyaXU9XYjEe8NMJLeNUFq9xf6GJUHYFsfbmTkHPRLlnpSilp7hF
         yw+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779205798; x=1779810598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=svXaO9Car/cL1x6P0kXNjSbwoRo/ZLSYkrf9JDZDMqE=;
        b=NxhfUDxEojnfFAkDlU8ZdGVf/0gwjh4LpZ1nUd+iE2X5qSqdcyr5Svsl1nzvu77NbQ
         m4Ajz4e6OhyFcu7Io71goc+PWEfRB1UxXvc9PF6UA1lKawCYDXtpHEXrx8Au8SElJaUY
         KB2srLk7crrgfZRzVl9pAzfzkDKE0DAfIl/R3uLJAwUBNkyUg5SuMYV57CH3DHpGUwLt
         aBZ2jruT5IlRcOTXxWJgvzOlTcuZYZwKAtuO/9TbStPw8z36u1O9rZ0juAYw6iT4BJeq
         iACEky65XNG9Irojv4aLch/80qk4npW32Arf8qZwdl2UeQxlBPKgkxZNzbDmfWMPx4II
         t5Gg==
X-Forwarded-Encrypted: i=1; AFNElJ8LRFP/XOiTyYUqXrff4wKUIbqqbE4Y+ezx4T1+VqmxtnFwT8mWrAOtPdlO66DrjT7+eLvrsVt0VUi5bEhAZB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhnSrXs75Y6GndZ+CDPzeXRPcIqlMVH/6so+pOh+W88vjbnItJ
	HBpUMPOp37P25ergvfgG0mXTqqNRpsqCrSJ0ED3KhxLJSjVZdIMP3mjuy+2u+2vEWkX6xEuCzED
	svGRpKMkti+9PMbF1sDW3f4LitJlwP3Q=
X-Gm-Gg: Acq92OF4BNO9/Z1Fo0VQmQSIz9BzZQm5is2gHfLm4t106m2F+XxIMQttDH3K9OZFl7x
	93ZnHXIEza5GawHWvo7Dy0XmXrd4K2DPsWY96APwx/eDrliXFgX+AyjKM9wRTA1YmWFidoZqp5e
	2/SbYqPuarv1S2eCLFZw/c8R3SCQjogz+18vAv+ZKOMLdqx6AE7xrbwAOsily6O4+g/Gqb8Qwio
	L7Sk/5C3rrexfRHbfZHyaHFi/FQwtdYrbSf7wW2bWUEbT8Pl5fDFAOThUGxpzenONw8XpOxfO2C
	R9j0tdVdbOK8KJJ6UFBv4MLSDA0LuT3b1ai0z5h5pC3S7R3xp0M2WrNY6yFZhc85PxMCvA==
X-Received: by 2002:a05:690e:12cd:b0:65e:41dc:e8de with SMTP id
 956f58d0204a3-65e41dcecd9mr12441208d50.61.1779205798318; Tue, 19 May 2026
 08:49:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514172340.1515042-1-luiz.dentz@gmail.com>
 <f5cf1c30-48a4-4102-ae00-b74cf02e639e@leemhuis.info> <4946f5f3-b7e2-4949-89f7-6427015027c6@leemhuis.info>
 <2026051954-revision-sierra-6bb4@gregkh> <eb5301f9-3133-4fe3-b358-61f14d1ffa5b@leemhuis.info>
 <2026051909-impurity-nemesis-2f65@gregkh> <CABBYNZKKbTXc-okp9P2OncMYXHX9C1XC+pRC7XWOhv-8nPNZ5A@mail.gmail.com>
 <2026051942-uproar-drainpipe-6370@gregkh>
In-Reply-To: <2026051942-uproar-drainpipe-6370@gregkh>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 19 May 2026 11:49:47 -0400
X-Gm-Features: AVHnY4L0X8LYGYt87xzFEQmSQ0jaH-sWR5xnvms9EdsiDiaiEGK8SYnDvpGiMU0
Message-ID: <CABBYNZKzWgL3nmeA=CtN9s80LRyDiJ97aQXgvfSm9vYUBw_SpA@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth 2026-05-14
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, Linux kernel regressions list <regressions@lists.linux.dev>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Tue, May 19, 2026 at 11:19=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Tue, May 19, 2026 at 09:44:39AM -0400, Luiz Augusto von Dentz wrote:
> > Hi Greg,
> >
> > On Tue, May 19, 2026 at 8:07=E2=80=AFAM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Tue, May 19, 2026 at 12:53:49PM +0200, Thorsten Leemhuis wrote:
> > > > On 5/19/26 12:30, Greg KH wrote:
> > > > > On Tue, May 19, 2026 at 09:04:38AM +0200, Thorsten Leemhuis wrote=
:
> > > > >> On 5/15/26 17:10, Thorsten Leemhuis wrote:
> > > > >>> On 5/14/26 19:23, Luiz Augusto von Dentz wrote:
> > > > >>>
> > > > >>>> The following changes since commit c78bdba7b9666020c0832150a4f=
c4c0aebc7c6ac:
> > > > >>>>   net: phy: DP83TC811: add reading of abilities (2026-05-14 15=
:17:12 +0200)
> > > > >>>>
> > > > >>>> are available in the Git repository at:
> > > > >>>>
> > > > >>>>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/blue=
tooth.git tags/for-net-2026-05-14
> > > > >>>>
> > > > >>>> for you to fetch changes up to 375ba7484132662a4a8c7547d088fb6=
275c00282:
> > > > >>>>
> > > > >>>>   Bluetooth: hci_qca: Convert timeout from jiffies to ms (2026=
-05-14 09:58:08 -0400)
> > > > >>>
> > > > >>> It seems this PR sadly came too late for this week's net PR to =
mainline
> > > > >>> that was merged yesterday.
> > > > >>>
> > > > >>> TWIMC, from my point of view, it would be great if we somehow c=
ould
> > > > >>> still get the changes from this PR or at least the btmtk fix it
> > > > >>> contains[1] to mainline this week before -rc4, as it is fixing =
a
> > > > >>> regression known since 2026-04-24 that at least five people enc=
ountered
> > > > >>> with mainline since -rc3 due to 634a4408c0615c ("Bluetooth: btm=
tk:
> > > > >>> validate WMT event SKB length before struct access") [006b9943b=
982 in
> > > > >>> -next].
> > > > >>
> > > > >> Greg, Sasha, that [1] fix I was talking about now reached -next =
as
> > > > >> 162b1adeb057d2 ("Bluetooth: btmtk: accept too short WMT FUNC_CTR=
L
> > > > >> events") and will likely hit mainline on Thursday or so with the=
 weekly
> > > > >> -net PR to -mainline. If that's good enough for you, I'd say it =
would be
> > > > >> good to pick this up for the next round of stable kernels.
> > > > >
> > > > > That "Fixes:" tag is referring to something that is also not in a=
ny
> > > > > tree, but that commit does have a cc: stable in it.  So do we nee=
d both
> > > > > of these:
> > > >
> > > > Valid question, as yes, there is a slight mixup here:
> > > >
> > > > > 041e88fb0c08 ("Bluetooth: btmtk: validate WMT event SKB length be=
fore struct access")
> > > >
> > > > That is already in v7.0.7, v6.18.30, v6.12.88, as 041e88fb0c08 is t=
he
> > > > -next commit-id for mainline commit-id 634a4408c0615c ("Bluetooth:
> > > > btmtk: validate WMT event SKB length before struct access") -- the =
one
> > > > that is causing the regression that I want to get fixed. So we now =
only
> > > > need:
> > > >
> > > > > 162b1adeb057 ("Bluetooth: btmtk: accept too short WMT FUNC_CTRL e=
vents")
> > >
> > > Ok, but that "Fixes:" tag pointing to an invalid commit is going to b=
e a
> > > nightmare to track over time, ugh.
> >
> > Hmm, did we get the wrong hash or something? Usually, that would show
> > up in the verify-fixes.sh, but perhaps it didn't capture it this time
> > for some reason, perhaps I'm running an outdated version or something
> > similar.
>
> Something went wrong if we ended up with a patch in the stable trees,
> yet this fix is referring to it as a different git sha.  Don't know
> where the disconnect happend :(

041e88fb0c08 ("Bluetooth: btmtk: validate WMT event SKB length before
struct access")

I don't have that in any of our tree either, this is actually
634a4408c061 on all trees in the chain:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git/com=
mit/?id=3D634a4408c061
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=
=3D634a4408c061
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D634a4408c061

Or actually that was the hash before it got rebased on bluetooth-next tree:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/commit/?id=3D041e88fb0c08

But I didn't send the PR from that three so perhaps somebody else sent
it to stable with the wrong fixes tag?

> thanks,
>
> greg k-h



--=20
Luiz Augusto von Dentz
