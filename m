Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EEA4AA02C
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 18:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789582367; cv=pass; b=sS3tOZl/o6SqdXCsmaxqUED3TVPL+2SxPkxqTOgiY/JMPBAS7wfX0IdUN+Gt5Ls0QLDrU69nNgaX/+/UC9a9OG6xdjYtFd8sTh3yIOI3SRjZoo79PDOoMfVXqs+pnmXJFV3kWuWwI0QdKLODkFVBMF34RmmpnIemA5OBxVPIqPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789582367; c=relaxed/simple;
	bh=mu2tPus9QdfOxChxIrPwMgq6LJM/HiOoNaiArCUrrhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OQvd9r5BmAEz4Ew8kdZTCGDbc1Mk/eWJY1XbZX0V9VeAbNGfCOfTgbPeir5b4/863nCuVk3330UhyOdxfrr8tD1fgwS9u+yhDxjYhAF2uVxmhrmOPi7tdYlcApSNBbWNaCH6au/O+MD2J9enSFFbxg1m4yUq5no+N4U4zMtcqnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wl9ikd8b; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wl9ikd8b"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4ab2029eso1259937d50.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 11:12:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789582359; cv=none;
        d=google.com; s=arc-20260327;
        b=SJuC0ya6P03+Dguf4nPGF0jdK55H3kA/nlD4CZpqgmMdMpAqjj1z2vHW2ySdhTRxdP
         Ll36BL/F+VG+JTQvnwix2aW5GN+jgIuC27WoCUvzED0KJ7OgPOjQ+z+mGssF+TrycFwf
         22nMq6q29GOGKHS7BTgJOPsdcFFLQYbWmHMus/KZ+OU0MigD+/X4xwcDx+o+Bjg9+xrP
         zOde1k5NnC5oy2GYMAaoEQWJaMvW2T/wOJADwIrhodZIF7JxTN9oijePiKNOgsTGCiht
         Ppsz6h/OgMWX02HIdsji+EsXpGrVmPo69rkED3A3hVAsbKizQiDLw2QNhQASfZvnivDx
         IILg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RJUsWgqA9N6UNnQBce4r6dMBOkGwuuLMNggHMU0HA9U=;
        fh=cfRF/tryWta9MSJA+HZrRB2KOiqsbYwLU3QYBbxnhjU=;
        b=FdGjnkiYv4C+dXz5E7nO2lQUw0r8DVjD2d6rvSyTayRW/LOsYczSE1TfjZVBHYSZuc
         swwu6iW+LVB96MeakDkyu0xtdGf1wtkkvK7ITgQuZrELUz2CU4RexAIHR4K+ggW0Elp8
         MMXm6PE45P+B1hgdaw0HOZyGc/UFYF4Cka1aPwMhow4Itp7yw1Nu5Ibxbn4yaBmNwlT5
         KRepf4nqwZC0i5aW4KqoHW9Kdo968twdZ/zOps32i58sGA5kQO/Or9k+Drd8xphR+wcm
         xOQfjrLU88ATuaEdTL7AQFHXio4eo5fO5aoof7nY7HbJTZmDgOqjExPRNCT20/cqiGRm
         JWZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789582359; x=1790187159; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RJUsWgqA9N6UNnQBce4r6dMBOkGwuuLMNggHMU0HA9U=;
        b=Wl9ikd8bveTsHtdnyuIwH4wdhZQU/gUEZh3iOiyn2ykUWhqWNVR4Jd/gDlj4of3wwD
         7nKPj+gifypbOQu5m1+4kLuYT6cmRNRykMui/BLh4UrLRcBKsvjqgDQQLppL6V0xrH/e
         KQcNAb8gkl8Z0/kRRemPJBXVyVQVkXrzcfUNQquUU8veBsnWpeJvpOFKYTzAA6AFSRk8
         0yUpMCIcnFer2get73Nn871H0MLaUnLI2oSCend/HUeMdXLfMO9JYgsI8/Z3nRizG1jp
         HmZZJzMZfXZwyRu6fkCSwCehB9tOH0h1pxGBx7Ok+NQJ+GnJRMTAlxWQw74kdTFrtRAC
         AtXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789582359; x=1790187159;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RJUsWgqA9N6UNnQBce4r6dMBOkGwuuLMNggHMU0HA9U=;
        b=AH8w3wpiCCYtN5rKdFw4fb7h2ac1LeyA5VXZyIaO87XxLjQ154s/+YQVlF7kYV74gt
         QJLl7BwU4wsCd+SdsuzVp/BGfLoz81R/MJVmlMnYtSVUDWDIL27kXn5aKJNlnOcfy1ju
         gsVWSFDgH/SefZmT2PeYr//LRRZsyQeugKPSsj//V9NaQde+XQHukPUkCEX9jTWY22p7
         s/T1JhuvI8UeE2fkmiAohqkrmc2MsRvQVHIlOegDAHxWsBHxpZ8UM5kjGjRCbOSfRbNd
         1fTwQR74/PX2mMl7EjtM0uONKRZjXwv4mswVVKv9e+UkVtibu0LKtT6veQ8a8OJbvVpg
         AzhA==
X-Forwarded-Encrypted: i=1; AKwUvBzI8HecRoqO9hSivQCd8ga5zCKzpSE+B3yJgUekpSf2l1LhfkxzOhDmnnWyau9bKFtTRjbCKR1c+VmhMfBWWIw=@vger.kernel.org
X-Gm-Message-State: AFuF++lKhsy3KsBnCjruPBsqnu/V7j8djYyjRkRM8xyTyMEGUYchuls0
	Za4mtMl8DRweG2/NbQlL1KyifcgYTrkskYr8OSHm1vYDXt/WqRV8ylPGTA4zpCoNzH7SaNMBuha
	QKgxarJWYwxPpYkPVK1/XNpUp2TE21uw=
X-Gm-Gg: AYBFou3XG61UhdUSM5clT9G4/zcccG5TPirXW4yj3VaGItQPWQS1YFr99HeQ9eHneGS
	6fQvtB5vgPbY1TCBVrJbZWI+mo6+MOhScQbgZXyD+4tDGhHDknvT62eVAZ89vCRIQ46MsdyVtfp
	iRh/6ixP5hnmfUyS0fiivUI7SG5mtE+/vVX8RRMFsAMwwXXg049BGVtyuxaxrLT4Up6VzyCWurg
	xlfJHkY9rNbQnWsR6SoV5AvdBOLhhiQcGov7cBaDwjtETHaBKCmDqeLuau5O+aHS4oQFt88up9C
	HlwDRpPhkgv3Yn7xb11vsOd4UiyAKQFYATkeFDpIfKTq/9jI0243O9XcUYCeOFli4X0rHeTE4tK
	1isr2ougZnffICf79VY7aoplBm0lLst42V27uVtFHvnC3XNk9LOU/
X-Received: by 2002:a05:690e:d01:b0:671:b80:e8ed with SMTP id
 956f58d0204a3-67163216206mr1368981d50.34.1789582359290; Wed, 16 Sep 2026
 11:12:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907172648.457103-1-luiz.dentz@gmail.com> <20260908135708.552fcead@kernel.org>
 <a0e8bc1e-c237-41fb-b448-9594bd484cfe@sirena.org.uk> <CABBYNZKrSve8b=Acj2qu0YBuEZ9u9xHJe-ffRb+78x5KPY8Ntw@mail.gmail.com>
 <d5676b70-f60b-4ce6-b6e6-de564d5c0a29@sirena.org.uk> <CABBYNZLKnQsypBR8Kbx4QFL9KfnVXRhO9_d5BHYQCabVZSY34g@mail.gmail.com>
 <064ec40d-66bb-4f69-ae1c-65cfed3581b4@sirena.org.uk> <CABBYNZJWcrvkx=6DekHxZzcrGjHwiqmSuwXqzHNV1=7BctThGA@mail.gmail.com>
 <aqnMueXiCztLUn-w@sirena.org.uk>
In-Reply-To: <aqnMueXiCztLUn-w@sirena.org.uk>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 16 Sep 2026 14:12:28 -0400
X-Gm-Features: AcwNN1XUskie5F9ZoTyQMt1nFf664bs0X3J3oBE7p7QBFY7x0WdYfWBQGjvVDvg
Message-ID: <CABBYNZ+A+bNZ0THj0EZ4KfMj6wPMhD6hvbt5FP-exZnqxb4E-Q@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth 2026-09-07
To: Mark Brown <broonie@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Tue, Sep 15, 2026 at 6:54=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Tue, Sep 15, 2026 at 03:36:50PM -0400, Luiz Augusto von Dentz wrote:
> > On Tue, Sep 15, 2026 at 3:24=E2=80=AFPM Mark Brown <broonie@kernel.org>=
 wrote:
> > > On Tue, Sep 15, 2026 at 03:16:21PM -0400, Luiz Augusto von Dentz wrot=
e:
>
> > > Yes, the routine cherry picking is certainly part of it - it's not so
> > > much the fact that things get moved between branches as the fact that
> > > when you have the same commit is in multiple branches and then build =
on
> > > top of one or both of them this creates extra conflicts, often harder=
 to
> > > understand, when the branches are merged.  The more normal thing woul=
d
> > > be to apply once to the right place, or the standard fallback from th=
at
> > > would be to drop the commit from branch A at the time it is moved to
> > > branch B.
>
> > If I merge to bluetooth, then bluetooth-next won't contain the fixes
> > meant for stable/rc, so I will need to merge them back to
> > bluetooth-next immediately it order for our CI to stay current with
> > the fixes.
>
> Or have your CI merge the branches and run on that (that's a fairly
> widely deployed approach).

I incorporate the merge back into my workflow:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/commit/?id=3D967788508ba263e22d856f971c9118dc1a73f6ff

Hopefully this should stop showing conflicting/duplicate IDs at your end.

> > > You do seem to end up removing the cherry picked commits from their
> > > original branches at some point as part of your workflow (since there
> > > are hardly any duplicate bluetooth commits in mainline) so they do wi=
nd
> > > up being moves AFAICT but the duplicates get left sitting there for
> > > quite a while.
>
> > Yep, once before sending the pull request for net-next, bluetooth-next
> > is rebased on top of net-next which brings all the fixes already
> > merged back to bluetooth-next. Git is absolutely fine with that, I
> > don't think I ever run into a conflict doing this. Git detects the
> > fixes already present in net-next as duplicates and eliminates them,
> > so it really surprises me when you say you are finding conflicts, not
> > just duplicates.
>
> The issue is not your rebase working, the issue is that until you get
> round to doing that rebase anyone that merges both bluetooth and the net
> trees (ot Linus' tree for that matter, often the conflicts are with his
> tree) sees the duplicated commits and that routinely generates
> conflicts.  This obviously comes up an awful lot with -next, I am not
> rebasing the trees but rather merging them, but do I gather from some
> conversations that other people are seeing this as part of their
> workflows.
>
> Anyway, to return to my prior question: should you be a contact for the
> bluetooth tree?

Yep, you can add me as a contact person for both the bluetooth and
bluetooth-next trees.

--=20
Luiz Augusto von Dentz
