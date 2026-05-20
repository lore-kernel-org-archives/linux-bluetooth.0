Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0508A2F549C
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 13:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285225; cv=pass; b=SvrPuYx4j4eEiQu7QldCVMLXBx2Hx6WcD/6cWqGOGSsivmLDvTJZrAFh5tVLlM1HOTvaDWWYlCDxhz1PW1jNw0SZ7Ml22k7Bdmnssl6lwV+56S9f/lsd3dG+8cDgaYp3tZht3m+nEouqD9hliNoCgUkKtVUve6kVjWViHTFLTVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285225; c=relaxed/simple;
	bh=ghMB5I3ZznM6B+uIBYnjRUhxHcZcmdpqsz9B+Q/n7tI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mt8jd+BNP6YQd6iEZwIY08+OmJjT/iDhgi2+GEcjdlJfi7ejYEMGPF3ZXnbrf69Ea2KM7TjUawpQwg9N9kXiH6KaXZ+sTZOwV+F6uV18m+ywJd1KDasVK2IcDwhH8Tkjhb/d7LhMY+0yYP5xZlbvsCNGu82W7T7QP7VrgrHURKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+WMwZvW; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+WMwZvW"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-65dead17c24so4600497d50.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 06:53:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779285222; cv=none;
        d=google.com; s=arc-20240605;
        b=Jqkk0slbELJ7qaASsDofzAcBxsbGIZARBraeiruhzLNGBmfxxfV+iB31J4+qSo4hg2
         2LXj3QEBEAkDhU10izSvMVCfCXxUeutvDCB3rzDNUwXLh+Ed624XzOnpkL595fdSJS9q
         UI9U+JvVvA2BwT8ZZ3F/fW26+c0Koy8HhcfDNOIcbVOBqUKKfmCx89clswpYKttchUr8
         SgnH+9SGnO/FCPGdndXaH3jsykvBdMZ6o+o3ilS5sv5PKAPg8uNAbQwb1nVo8H+5LOec
         Vkwiyh5khRRji3Nhyl22atXq6Z7bBZDVhw05ly+Auj5oOpPcBX+0O9Nt4PmD9sUeefDh
         qvPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FdYtmXr5yw5qje/D1jtPFpQx5oQHNPSqQ+7yc0yfv8E=;
        fh=9rMvedaFa+j5/ntKt3yeAtA4BsLToD9bAZohxH/jl2M=;
        b=AwpIacy/NxRzMZrg1BbFlTnBv8tHnEj/MznkAitUcahVR1JShMXc2MZA5b81o/Ux7Q
         VdDVbBxu44CO/R4vUB/Nb/rU73UBfnz/J+PuGi1+BJoG3UdyHwq/ZzvfYfVEiuJxcoP/
         jN1u1TWjZNnCHth1EUPC5F0lzTHcqQ5liNA1Sj0Om4umu4yMiGwxBATTAh0tE0E/ivml
         jSg8yy0sZMkM3PqX/nbWQ7lzywuIqYz7wnwWOmK8ndnCY8HCNJ5a5M5BaRTEy4/kEk9h
         hrgc75EjUC+ONeG87yYlc/vxkOscy3b3QymhHa6B7F74t0WtKbeIYCKxQ9nRigkvWmS0
         NwQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779285222; x=1779890022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdYtmXr5yw5qje/D1jtPFpQx5oQHNPSqQ+7yc0yfv8E=;
        b=G+WMwZvWwOAZjnjJinSzsWiknyErZJ0rmDpkLx2DfwUs0luhGtNBAFFk+5BCKOmBK0
         ofWrDt1W06hqHQPmpmok+qh4AsoP+7nG0s0OoHqOL+nciQWEuBRU/A0rjBsZkTiHIHIx
         8Z8tRQKieYPg9zwIn+0Tg9zHsNXmycGpPBj4WnGNyb/+fbSEFS+0+dndAvm1x7aE7grH
         jkZOniV01U7K8/6BLE5wlSB1YlIDXTj4TjoUoLA7jFv4FR1EC7QciKijYeCMGCPzJXc5
         MpzDPAFpHuSRgmBJfyjIay6ZSP9sNPoxEi28626XphFdQKJ+uJHZVks09mToBpXKQa6h
         Vjaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779285222; x=1779890022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FdYtmXr5yw5qje/D1jtPFpQx5oQHNPSqQ+7yc0yfv8E=;
        b=FpbgMOWTW16+7bEkyUBXcHHhFzHQCKcHuDApaKBfRkAqpV0w/DgDs7to22OzA7w4X6
         Ea2tCdj0AcrtywLkIzvJyypUj+6eZjoHdrYz99PXgcBJ5mDJwAB/VeDsWIMYLaFfXqDB
         V7EyzUWec/YtkLaUoSD95nXlR19OT6P/pzCNu20/kuTpIdCxSQ7SI4fO/+AyEe7xg0CF
         blOO5y7VX4En6JXJj0Poc7W+xFA47AQEKSmXiKJUP8YRR6W54AkL3URsRGCf82lURmH/
         S03gaKqLD03O0/DSDPhBCwsUssz6+3a+FEmTxgxgC/8DUaAJEhrWvYSDasRcQAnMoKnk
         Wjtg==
X-Forwarded-Encrypted: i=1; AFNElJ+vG7R5IsxVRhFINfQUtdyLObMegzQaKZubgx8ClYoQYBx/F14/ExFBG+GS4HfBa3Fr4I7pjCAqGLm6LlZRMME=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh6fyfLWfCxqxMk20hoelxwJD0rL9OZ3TJAEN/0LXp2w+Q7J66
	6HXufKAzE/nq77ZdLRQwy6+okAWFWJrCsZ9RJ2tmBqppxal29eVuQybEh4v4gdNwJ3uaWmQr4Hk
	9ZgM12LfsAaILJa9hVRKSGWliMxOjnlC+Xku44dE=
X-Gm-Gg: Acq92OFG2xQUm+pyhx+gKZ9Y8qEVC8CNSG+AWnCavMmAdbPysktd9NXdmWkEeFwgPqa
	Im6gmQkkqBAGYsKxcVFd6TMY0w7N1f9r/qTAxZz3ZsY6mIyUHEUpizM+SL1xlXxiK9x0621bgxR
	uxuXNgkP/w1d1ZvDdKinOaCTC63JIvVqRQrxzzbZF3rKactHgyH6C0sBsg9TH66zXZq0f3UmH7l
	ET8/67NsAD1Wv0X5Yl5lBsDCJKySVu2JcVvMteRIlzhINAuA+eyNlMgrvctyR3xyZypcVO+16TH
	835auJQyF4JaovJSm0NoNxqmpures4TqHxF+ZLIKVT3vy8Mrtii2BZXx9/2qComWkobgysgHpum
	M3Fso
X-Received: by 2002:a05:690e:4290:10b0:65c:2208:8c6a with SMTP id
 956f58d0204a3-65e227dfa70mr19056657d50.42.1779285221725; Wed, 20 May 2026
 06:53:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4946f5f3-b7e2-4949-89f7-6427015027c6@leemhuis.info>
 <2026051954-revision-sierra-6bb4@gregkh> <eb5301f9-3133-4fe3-b358-61f14d1ffa5b@leemhuis.info>
 <2026051909-impurity-nemesis-2f65@gregkh> <CABBYNZKKbTXc-okp9P2OncMYXHX9C1XC+pRC7XWOhv-8nPNZ5A@mail.gmail.com>
 <2026051942-uproar-drainpipe-6370@gregkh> <CABBYNZKzWgL3nmeA=CtN9s80LRyDiJ97aQXgvfSm9vYUBw_SpA@mail.gmail.com>
 <e666c332-e2aa-4525-a208-a4a08742d2e0@augustwikerfors.se> <2026052026-barber-espresso-1d9a@gregkh>
 <CABBYNZJ4woc+unpYN6_dzMLtxhFVUd5+ccv2+EQbDMkYuXQ12A@mail.gmail.com> <2026052047-silica-grub-0bb2@gregkh>
In-Reply-To: <2026052047-silica-grub-0bb2@gregkh>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 20 May 2026 09:53:30 -0400
X-Gm-Features: AVHnY4Kvielev57YNURsHMJ5Vco21acsoY0xKleOB6jrUgrO8TFy7dJIbwvPLM0
Message-ID: <CABBYNZKnrqHyASMOah795i9eteY7S5AfN3tCWssSRgqBXZwRMw@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth 2026-05-14
To: Greg KH <gregkh@linuxfoundation.org>
Cc: August Wikerfors <git@augustwikerfors.se>, Thorsten Leemhuis <regressions@leemhuis.info>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, Linux kernel regressions list <regressions@lists.linux.dev>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Wed, May 20, 2026 at 9:14=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Wed, May 20, 2026 at 09:11:42AM -0400, Luiz Augusto von Dentz wrote:
> > Hi Greg,
> >
> > On Wed, May 20, 2026 at 8:47=E2=80=AFAM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Tue, May 19, 2026 at 07:37:35PM +0200, August Wikerfors wrote:
> > > > On 2026-05-19 17:49, Luiz Augusto von Dentz wrote:
> > > > > Hi Greg,
> > > > >
> > > > > On Tue, May 19, 2026 at 11:19=E2=80=AFAM Greg KH <gregkh@linuxfou=
ndation.org> wrote:
> > > > > >
> > > > > > On Tue, May 19, 2026 at 09:44:39AM -0400, Luiz Augusto von Dent=
z wrote:
> > > > > > > Hi Greg,
> > > > > > >
> > > > > > > On Tue, May 19, 2026 at 8:07=E2=80=AFAM Greg KH <gregkh@linux=
foundation.org> wrote:
> > > > > > > >
> > > > > > > > On Tue, May 19, 2026 at 12:53:49PM +0200, Thorsten Leemhuis=
 wrote:
> > > > > > > > > On 5/19/26 12:30, Greg KH wrote:
> > > > > > > > > > On Tue, May 19, 2026 at 09:04:38AM +0200, Thorsten Leem=
huis wrote:
> > > > > > > > > > > On 5/15/26 17:10, Thorsten Leemhuis wrote:
> > > > > > > > > > > > On 5/14/26 19:23, Luiz Augusto von Dentz wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > > The following changes since commit c78bdba7b96660=
20c0832150a4fc4c0aebc7c6ac:
> > > > > > > > > > > > >    net: phy: DP83TC811: add reading of abilities =
(2026-05-14 15:17:12 +0200)
> > > > > > > > > > > > >
> > > > > > > > > > > > > are available in the Git repository at:
> > > > > > > > > > > > >
> > > > > > > > > > > > >    git://git.kernel.org/pub/scm/linux/kernel/git/=
bluetooth/bluetooth.git tags/for-net-2026-05-14
> > > > > > > > > > > > >
> > > > > > > > > > > > > for you to fetch changes up to 375ba7484132662a4a=
8c7547d088fb6275c00282:
> > > > > > > > > > > > >
> > > > > > > > > > > > >    Bluetooth: hci_qca: Convert timeout from jiffi=
es to ms (2026-05-14 09:58:08 -0400)
> > > > > > > > > > > >
> > > > > > > > > > > > It seems this PR sadly came too late for this week'=
s net PR to mainline
> > > > > > > > > > > > that was merged yesterday.
> > > > > > > > > > > >
> > > > > > > > > > > > TWIMC, from my point of view, it would be great if =
we somehow could
> > > > > > > > > > > > still get the changes from this PR or at least the =
btmtk fix it
> > > > > > > > > > > > contains[1] to mainline this week before -rc4, as i=
t is fixing a
> > > > > > > > > > > > regression known since 2026-04-24 that at least fiv=
e people encountered
> > > > > > > > > > > > with mainline since -rc3 due to 634a4408c0615c ("Bl=
uetooth: btmtk:
> > > > > > > > > > > > validate WMT event SKB length before struct access"=
) [006b9943b982 in
> > > > > > > > > > > > -next].
> > > > > > > > > > >
> > > > > > > > > > > Greg, Sasha, that [1] fix I was talking about now rea=
ched -next as
> > > > > > > > > > > 162b1adeb057d2 ("Bluetooth: btmtk: accept too short W=
MT FUNC_CTRL
> > > > > > > > > > > events") and will likely hit mainline on Thursday or =
so with the weekly
> > > > > > > > > > > -net PR to -mainline. If that's good enough for you, =
I'd say it would be
> > > > > > > > > > > good to pick this up for the next round of stable ker=
nels.
> > > > > > > > > >
> > > > > > > > > > That "Fixes:" tag is referring to something that is als=
o not in any
> > > > > > > > > > tree, but that commit does have a cc: stable in it.  So=
 do we need both
> > > > > > > > > > of these:
> > > > > > > > >
> > > > > > > > > Valid question, as yes, there is a slight mixup here:
> > > > > > > > >
> > > > > > > > > > 041e88fb0c08 ("Bluetooth: btmtk: validate WMT event SKB=
 length before struct access")
> > > > > > > > >
> > > > > > > > > That is already in v7.0.7, v6.18.30, v6.12.88, as 041e88f=
b0c08 is the
> > > > > > > > > -next commit-id for mainline commit-id 634a4408c0615c ("B=
luetooth:
> > > > > > > > > btmtk: validate WMT event SKB length before struct access=
") -- the one
> > > > > > > > > that is causing the regression that I want to get fixed. =
So we now only
> > > > > > > > > need:
> > > > > > > > >
> > > > > > > > > > 162b1adeb057 ("Bluetooth: btmtk: accept too short WMT F=
UNC_CTRL events")
> > > > > > > >
> > > > > > > > Ok, but that "Fixes:" tag pointing to an invalid commit is =
going to be a
> > > > > > > > nightmare to track over time, ugh.
> > > > > > >
> > > > > > > Hmm, did we get the wrong hash or something? Usually, that wo=
uld show
> > > > > > > up in the verify-fixes.sh, but perhaps it didn't capture it t=
his time
> > > > > > > for some reason, perhaps I'm running an outdated version or s=
omething
> > > > > > > similar.
> > > > > >
> > > > > > Something went wrong if we ended up with a patch in the stable =
trees,
> > > > > > yet this fix is referring to it as a different git sha.  Don't =
know
> > > > > > where the disconnect happend :(
> > > > >
> > > > > 041e88fb0c08 ("Bluetooth: btmtk: validate WMT event SKB length be=
fore
> > > > > struct access")
> > > > >
> > > > > I don't have that in any of our tree either, this is actually
> > > > > 634a4408c061 on all trees in the chain:
> > > > >
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetoo=
th.git/commit/?id=3D634a4408c061
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/co=
mmit/?id=3D634a4408c061
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/commit/?id=3D634a4408c061
> > > > >
> > > > > Or actually that was the hash before it got rebased on bluetooth-=
next tree:
> > > > >
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetoo=
th-next.git/commit/?id=3D041e88fb0c08
> > > > >
> > > > > But I didn't send the PR from that three so perhaps somebody else=
 sent
> > > > > it to stable with the wrong fixes tag?
> > > > I believe the confusion comes from "Bluetooth: btmtk: accept too sh=
ort WMT
> > > > FUNC_CTRL events" itself currently having different commit hashes i=
n
> > > > bluetooth (e3ac0d9f1a20) and bluetooth-next (162b1adeb057). The for=
mer
> > > > correctly refers to "Bluetooth: btmtk: validate WMT event SKB lengt=
h before
> > > > struct access" as 634a4408c061 in the Fixes tag and was merged into=
 net
> > > > yesterday heading for 7.1-rc5. The latter still refers to it as
> > > > 041e88fb0c08. Both are now in next-20260519 but only the latter was=
 in
> > > > next-20260518 which was the latest at the time of Thorsten's messag=
e.
> > > >
> > > > Greg, this means picking e3ac0d9f1a20 instead of 162b1adeb057 shoul=
d result
> > > > in a valid Fixes tag.
> > >
> > > Ok, now done.  Be careful of duplicate commits in different branches
> > > that are marked for backporting with different ids.  It can cause
> > > massive confusion (i.e. don't be like the drm tree...)
> >
> > Noted. I guess I need to dig into how other trees do to avoid that.
> > The problem seem related to using 2 trees: bluetooth->net (fixes only,
> > rebased on each RC) versus bluetooth-next->net-next (development,
> > rebased once per release).
>
> Just never rebase any public tree please.

I guess the alternative is to do merges, right? While I understand
this will not be changing the sha-ids I don't think it changes the
fact that fixes applied on the bluetooth-next cannot be merged into
bluetooth. Is there a way to retain the IDs across trees? The
alternative, I guess, would be to apply fixes to bluetooth tree and
then merge them back to bluetooth-next to preserve the IDs. This would
make the CI job slightly harder, as it would need to detect if a Fixes
tag exists; if so, it would probably need to go through the Bluetooth
tree first.

--=20
Luiz Augusto von Dentz
