Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BAC369D61
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 13:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779198293; cv=pass; b=CSyf6Vk8PVQFlz3njRywjR1FNMgBU69XebLxCN2mU3afUIF9QcVnbtxatfUudw0eOddapeOGOhw8RLlroViubHK3flXkfavPhGG/ev2v7EBlSK+NdXNUEkoy80zJJvAW8lRAqg6vHzlb7R8Ch4XbE2Uz7StMdIH10OcZYKTJ3pU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779198293; c=relaxed/simple;
	bh=TPvCxuHJtKVGhQ/GlHUaH8cPjA9QMgDJQzp3fZRPCXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jw0R02chdlU48CS0Ay18ei8Bqn1bayrlPl/sZJqzAHXFux+z89MEr6nOovt3tlsSrInfmLA2/ClqsuOLP4WTz18Zo6KQed6rFWDSyZn2ZGmwRiZh8VVCYISY8PYJAO4DJ9G3QhzEOwWwbMU/SlxWy9zlRTQgnuCqBR64snd0JZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5DffAy5; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5DffAy5"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-65c7492a2ceso3003259d50.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 06:44:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779198291; cv=none;
        d=google.com; s=arc-20240605;
        b=ZBuwZZdQ7Gxs15OVjcrSuI+wvW7gJlxb2920qJ6LlXqJhSuZAqcFy88rJUJh2qnjjK
         gklPP7Kfa6eFaeiLnNY8AeVm58lKK5+Lfw6aEIXWqDeaMdJVl8o1l8rI8mpcmexRsEZ4
         B5Xpv0ttcu6y0pMLIZ59pTr59Dz9c0HqLEwkI/fTYV5+huWF2/pcsPvQjrO6zwC19PTL
         ibG8BPyTzaBPynxmrZz1RhTP0wajZU0eRcGitKyF/SMkCVT8KAKIPOqW+bD+rDFhemAe
         IEm8acpKFuoWNbsOBGuYhkIj3F26LRh/5E+HgSdozQ0uvGXw61T+GCHhw9oVfujQpyJt
         +mCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8vQ2huze1xO1NqJdBFnf6nbs9kGsrUpnagEQxYLNrLw=;
        fh=eVAx+8uYUBXDbb1dHY++QUJgtikXXKvhiBPGXYFDdqo=;
        b=SNtoBMOWbmIEyyb8rfCWjoKAQYkVfmUMTCLh2QluII1c2IDAbbk3Ur69rO1Nrq4hUR
         Z+TRHQcIdwhJpMEfyPzi/Uk+fPguWmEp4PqEaJb+VmpXYlx8NhesyZS0G1MplSPVALcA
         39+cQnFwjlejwyI18lqUw/Bsg49wnoLM+4i2PEcTeoD5GAG6lK+vWln7ONOYldYJZihN
         +1+qRujDjWFg5R4PzBwf3uyLtWAG7cWiw9aKEknt1UfbIUThdaqWriefewXRNhU7zz4H
         hWZsS4ecIv3n3HqfQPYoyaLcYPZYJ93zQW+d3+Evy0BuZg6JvwvEIWRbGTFVCbgzFp00
         gvRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779198291; x=1779803091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vQ2huze1xO1NqJdBFnf6nbs9kGsrUpnagEQxYLNrLw=;
        b=e5DffAy5YmQTHnCkxba0f59RXxKgLjRM56xRjEt56UTVgdcmoyLfLbbjjl751b45Bg
         9IYFIbiyqN5DdOlpywDf6Ssb4Gg2oNZgX/6WpKBPV43CR7a/rfAeFZAlqW+pN73WLFGr
         ptdzW7ne1l2Rhrwp802akVViUwo/JK6MhvgDMM2ZJw1m6AX0tkOKSnd4/MBLWbFKuKHN
         zBMGyDcmKRLKyasmpq3ClzUbpl34hd7+Vf8IZqlps2gyT1/4rwklVtPsriByd/f3IrV+
         pt4Eg/4c34h0swJ7rX9wFoU2Ya/Ij8sibcssFB5SL4YQ1aoLSvv5eIE/LgRApxqPCzph
         DxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779198291; x=1779803091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8vQ2huze1xO1NqJdBFnf6nbs9kGsrUpnagEQxYLNrLw=;
        b=odHt3FsWgm1+Fh6U85NOOAESUYY+xMjeTkbv6w0jgYym9sI5dtlYFlnpfw3QCgQDsi
         xZft11uODAAN8Bqns3TSqtfpodfkN5MmawOWSPfs8DxMv+NOWoGN6M5cEHOWDXNz+HnF
         VEEuKD3XpQjarDb7qMlnsfvRKg5VeN11Un9NpCCDnhUqs/AaBloFqFknVOs9qmV5nTi2
         cQVb/3egy9P05bNG2GNkSWxzG3gP2x3Bx5GffPog/61OqPRFgi+iV747My3xm3HiPc9w
         /Tx7rTAola3Uo/OKErzZvLAY/C0vH9TP3lF2xLJpGoLKFAQ54tRceH+pjbb/2xvjCZaz
         +hbQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Ym1GeET6K6UMhWnqmaDzpLHzhagIbF6m6U1+d1YYwoK0QyvpocwC8dL1f1xg60iJE7xjGNjojWXm44sonioU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz1Wz9gpQ+x8ldnf1SNAkKHO2zxy+gtJ7Cnkyxnlo3cb23jPz4
	bpff8Ooj2QBk0zHEfaNvDtRF5Ym90vXMaA1VohU991N2d1/LkqUPNmsPFtSkrIugg2WU4sXtZXl
	rK5mfkWaBlWysqxr+qDqQrbaY16jyOEQ=
X-Gm-Gg: Acq92OGK4pQChLIysnr8+Mk44fEbb9U+DXpJ9MnF4DBzq3/7QcJf6/zGxwQOR0SyaeZ
	2a7CX1kKAD7ejJipAsP6eu1wpTuH8TpD+4ujPKyiP2doPImfbk5G1J4ohDpSY3bBRYa/yifuRPj
	EkJFhahxmV5PaTWAZZECcw1QC7+61J1aP3NP4Kn3dPTh8bUe0/Mn4wHpSwyzqS3eXABUkoKOiEN
	9tusn9vRG5heX4M1947dPCSXnEKzDZzVshk7NC+WdidKmzVyspL94JhWqk9OvOBvYiuWOrFC8e6
	1/j65q+vPZaoGQXxnnW/FYJSdd6NX7Vx90NEIY/YIxhJipoZlicH5dSdN4chSVx+A1Q4tg==
X-Received: by 2002:a05:690e:1586:10b0:65c:17fe:6d49 with SMTP id
 956f58d0204a3-65e2287ddbamr15415688d50.61.1779198291234; Tue, 19 May 2026
 06:44:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514172340.1515042-1-luiz.dentz@gmail.com>
 <f5cf1c30-48a4-4102-ae00-b74cf02e639e@leemhuis.info> <4946f5f3-b7e2-4949-89f7-6427015027c6@leemhuis.info>
 <2026051954-revision-sierra-6bb4@gregkh> <eb5301f9-3133-4fe3-b358-61f14d1ffa5b@leemhuis.info>
 <2026051909-impurity-nemesis-2f65@gregkh>
In-Reply-To: <2026051909-impurity-nemesis-2f65@gregkh>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 19 May 2026 09:44:39 -0400
X-Gm-Features: AVHnY4J8lmhWqH_MENNxHDU5i3eOmFVjrJt3J47QyY0UJsMFJDc4Qg43-D2Njck
Message-ID: <CABBYNZKKbTXc-okp9P2OncMYXHX9C1XC+pRC7XWOhv-8nPNZ5A@mail.gmail.com>
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

On Tue, May 19, 2026 at 8:07=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Tue, May 19, 2026 at 12:53:49PM +0200, Thorsten Leemhuis wrote:
> > On 5/19/26 12:30, Greg KH wrote:
> > > On Tue, May 19, 2026 at 09:04:38AM +0200, Thorsten Leemhuis wrote:
> > >> On 5/15/26 17:10, Thorsten Leemhuis wrote:
> > >>> On 5/14/26 19:23, Luiz Augusto von Dentz wrote:
> > >>>
> > >>>> The following changes since commit c78bdba7b9666020c0832150a4fc4c0=
aebc7c6ac:
> > >>>>   net: phy: DP83TC811: add reading of abilities (2026-05-14 15:17:=
12 +0200)
> > >>>>
> > >>>> are available in the Git repository at:
> > >>>>
> > >>>>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetoot=
h.git tags/for-net-2026-05-14
> > >>>>
> > >>>> for you to fetch changes up to 375ba7484132662a4a8c7547d088fb6275c=
00282:
> > >>>>
> > >>>>   Bluetooth: hci_qca: Convert timeout from jiffies to ms (2026-05-=
14 09:58:08 -0400)
> > >>>
> > >>> It seems this PR sadly came too late for this week's net PR to main=
line
> > >>> that was merged yesterday.
> > >>>
> > >>> TWIMC, from my point of view, it would be great if we somehow could
> > >>> still get the changes from this PR or at least the btmtk fix it
> > >>> contains[1] to mainline this week before -rc4, as it is fixing a
> > >>> regression known since 2026-04-24 that at least five people encount=
ered
> > >>> with mainline since -rc3 due to 634a4408c0615c ("Bluetooth: btmtk:
> > >>> validate WMT event SKB length before struct access") [006b9943b982 =
in
> > >>> -next].
> > >>
> > >> Greg, Sasha, that [1] fix I was talking about now reached -next as
> > >> 162b1adeb057d2 ("Bluetooth: btmtk: accept too short WMT FUNC_CTRL
> > >> events") and will likely hit mainline on Thursday or so with the wee=
kly
> > >> -net PR to -mainline. If that's good enough for you, I'd say it woul=
d be
> > >> good to pick this up for the next round of stable kernels.
> > >
> > > That "Fixes:" tag is referring to something that is also not in any
> > > tree, but that commit does have a cc: stable in it.  So do we need bo=
th
> > > of these:
> >
> > Valid question, as yes, there is a slight mixup here:
> >
> > > 041e88fb0c08 ("Bluetooth: btmtk: validate WMT event SKB length before=
 struct access")
> >
> > That is already in v7.0.7, v6.18.30, v6.12.88, as 041e88fb0c08 is the
> > -next commit-id for mainline commit-id 634a4408c0615c ("Bluetooth:
> > btmtk: validate WMT event SKB length before struct access") -- the one
> > that is causing the regression that I want to get fixed. So we now only
> > need:
> >
> > > 162b1adeb057 ("Bluetooth: btmtk: accept too short WMT FUNC_CTRL event=
s")
>
> Ok, but that "Fixes:" tag pointing to an invalid commit is going to be a
> nightmare to track over time, ugh.

Hmm, did we get the wrong hash or something? Usually, that would show
up in the verify-fixes.sh, but perhaps it didn't capture it this time
for some reason, perhaps I'm running an outdated version or something
similar.

I will try making the Bluetooth CI run the verify-fixes.sh to detect
this sort of issue early on.

> I'll go queue this up now, thanks.
>
> greg k-h



--=20
Luiz Augusto von Dentz
