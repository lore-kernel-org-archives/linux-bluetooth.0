Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421514A7C94
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 18:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583461; cv=pass; b=eXHNDE1mG+j3gS1KYSSuB3YJRcSU0Opp1KzRy7uhG+Klv4nscVo3QgTM41wyYRAZQeCkTtYVkidowo+uJsYgpXdtQYGCYn23iCl9+5pX9D2GDVOVaYLXcxZERVLTXARSuoOg1I9cPnPsNY3cdqtxwVELLHXRshazVd3aaI9C8Nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583461; c=relaxed/simple;
	bh=onmKTaBroLnQHSziLElRNTVusNSumHu5B2jtCHXy5uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YNGU/2+1ZpRQyj0KDz7xiVd5euLH8LmLTbC63WyAzfG4ptc/1nkR5+SfcZNJVC5d75i2D3MP/r5acqH+tGTKhmUQUg2EbapoHzGn00DcguhloamS5No4ctPF20rpUgYIUm1Bwjuwt8tKsE+H4vwMgw82sgrd84n1QevYOALLFTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4DpSgXx; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4DpSgXx"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4aae314aso1233316d50.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 11:30:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789583442; cv=none;
        d=google.com; s=arc-20260327;
        b=jDEGUxwCuspZcEjgBHT3ZymkDxaZto1vXypa9mx9Of1BIhwqtbyJdnJ118VPyCX0X3
         ckZoCH3slSwK6XOVmPEV8SO+nxiqkhrMxCCBjCTqsZeGUNIxuNW2Hxwpkf5jHUDl2f/W
         GCOzH0ELqOF3RlgRVKDnfwROUx0jGXCdkZffZb43bYqo/UWP/8qyUAzltfgo3I5JxfEj
         hOz9fXagUudbqmHGqmWNUdk0ylCJs8/Cl+OHxjmAXLLCTv2kUpq166IDOwydq3wGK1LB
         IlTGsjjGC4ejT9s3x4ygNs/ogC7teYuYaaK0Eu1iMdn8+b6VWh3H0HSlBkxMOf9a7nij
         KaRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AwudpkD/kJzzZP+/2SGiHye4aqMnNy3/NaZ41CzM5dA=;
        fh=rwJ6/0kKRJwyuP1anTCYF5tWh1cVj7JR206fZmQ/vRw=;
        b=eHt9td3Ry8S8bN4gc9gVPNkWx48cTBpGtYwV3AzzP0tpca9+4ZUJrzpiOjpZW5jMPd
         0Yf2w320SJzwaWeM8gNogQCrtFUusnaEsfBtelpwytTQxtIapSBIaDiSpnT6IIvOEaXB
         hPLtGd1+TORXb6iOq+1RtsjDrYpG9yEPPPiMWvvYsmhC5759hm0eQKA2V6HTwlKmvUik
         0TLTgFPu16nWJjUnDvXnSDas2vNmLWJh2FPT+sZUmYwze2aueaZxMAoCXMdnkE7GP/Zc
         95ejSJPPYl6dgRSHl/wGWRgGhb65Zuq5g03FFfRVbfC+Ja7gpP7MDLxS68J4WN/GRj6e
         nRww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789583442; x=1790188242; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AwudpkD/kJzzZP+/2SGiHye4aqMnNy3/NaZ41CzM5dA=;
        b=h4DpSgXxRjFr3lhQ1mXtQ6XdyZHLWxt0r3RiKrmpoMEjGjmBnkB0JkvSCaBstsyntV
         iVa1hSs5F/5+hp/31nfIG9ocVIMoOKIrTTjbHIfMIhoM/2bvYsSUJfWNkmUHYHdnwL+/
         Y759HMx1lWZ8OAW3JG/rn1DlEb/3E3sEP5ri1o3wBKtmUKuImRAeN/sodVD8C5ahUj1A
         wy1P0idF7VSV29AMW9G1QjVBiogKPCDP6fUoS2lkqqwfb1xAYR+TGvnpiSFv4+COmtuj
         JJ2qHgbptLV+lWxLhUwmeJaitSGK7I+CyfXxfRoXIu2Dm/1lhcpwhvC5EIPYuxMk27yy
         MV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789583442; x=1790188242;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AwudpkD/kJzzZP+/2SGiHye4aqMnNy3/NaZ41CzM5dA=;
        b=Ux+NOdLOPn3xYA18wJ4ArfCG6rtG7K+zykS7E1BJtVn6vyEeGdBWTprw/LT1HTymIM
         kuLH30vH9DdVpaTD3jIBmRdagjaMLhEaH51kaJxELMN0ujbMP5VcHTFygnCxBTptvcml
         WGOspsSs/iramwpOUmtVxFo7Boed8fqb19A7DVs+Nagdhrn02pZiD5wUPWPUWrL7qcMb
         Du6zodgBiDyQ63dzJ5Fe/FFN0H5vv7y9iwwtHul8LpD+fLWp4nPBLDdBDx8uXtwTSMFX
         mskzYsUcMUrBHSvPsFB+5gIjBwpTfjixmJHAcwPGmKNe82AoqRqkPIzjd7lctGlc+NEh
         5LAw==
X-Forwarded-Encrypted: i=1; AKwUvBzN/p5cPZzLsFFrV3YhWEVmnScrfobiH0Ni9MsisZN5P40jzpS2Rc1W8bqB/bnIC8plQrW2DQVlRcP7d1sMgVI=@vger.kernel.org
X-Gm-Message-State: AFuF++mrJBLvUhNw+AHgW+PjfqFvQ4Bai8r3nhJmOSG2EWaq9WLGMiuE
	yU8QE5xlEjTns+87OhlxLG/fkTPPIj3s+8E7bFWilb9A4KDPCuSMHaqIN3RvhC+aZOLC1JvRenN
	A1mkhSI7257O1i2NutLYi4hpI6PUCpvU=
X-Gm-Gg: AYBFou1aDMUAWYwLjQ41ggETxuQhfPrZBoaH11f3lTkqi6/YqCgieHBIF0izx+onbYg
	67HQ5ets+tlzYyUpVbSAOIXKd1EvPDeWn9ik0StpGv2QaCdQxXQLQ/p2hqw1X+cSQFlecXUpVwW
	xWcAEj9yTmeRqAaEjpyvpt7wamvD06i4Fk33Ed0403BIu3hAglSSuBI7QXU+dMODDmp5ZZRYVkI
	gnmem9q9DIR93YLVYysVdDlQ0dn7QrgdPTlUrJXmu4Ff93V0zmBjH2Pe1dnDETudHB+Dmt513l8
	lZz208ZSOxCcHfV19YflJLWLgVFuxwoeVrHX2UGDdocbi80NbMzTJE+n9BWkkFAV2r3dtB2hc4n
	LnLlPkrAYhGRPytSjs8TNCaWyy9uSJwQCzeCBnCIc7Q==
X-Received: by 2002:a05:690e:108a:10b0:66f:7d56:cf77 with SMTP id
 956f58d0204a3-671632a1448mr1234859d50.26.1789583441801; Wed, 16 Sep 2026
 11:30:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a0e8bc1e-c237-41fb-b448-9594bd484cfe@sirena.org.uk>
 <CABBYNZKrSve8b=Acj2qu0YBuEZ9u9xHJe-ffRb+78x5KPY8Ntw@mail.gmail.com>
 <d5676b70-f60b-4ce6-b6e6-de564d5c0a29@sirena.org.uk> <CABBYNZLKnQsypBR8Kbx4QFL9KfnVXRhO9_d5BHYQCabVZSY34g@mail.gmail.com>
 <064ec40d-66bb-4f69-ae1c-65cfed3581b4@sirena.org.uk> <CABBYNZJWcrvkx=6DekHxZzcrGjHwiqmSuwXqzHNV1=7BctThGA@mail.gmail.com>
 <aqnMueXiCztLUn-w@sirena.org.uk> <CABBYNZ+A+bNZ0THj0EZ4KfMj6wPMhD6hvbt5FP-exZnqxb4E-Q@mail.gmail.com>
 <6ce3c671-12e3-4057-9610-23efe14832cf@sirena.org.uk> <CABBYNZKiy+t_GC9dL6nraiH26m+2U=kuAF8NMAPNW-BhtOSovA@mail.gmail.com>
 <1add998c-b408-45cf-9442-0fda2674fe32@sirena.org.uk>
In-Reply-To: <1add998c-b408-45cf-9442-0fda2674fe32@sirena.org.uk>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 16 Sep 2026 14:30:30 -0400
X-Gm-Features: AcwNN1XJ25cFXVjQc3Y6QUUrVUjgBedc6Z-Ottn4dwnykw-MCWmOOSeYEK-qb9U
Message-ID: <CABBYNZJn-ZYkX1DrOg9QWQHLWP_Pzh62M__X_jd0eXrKQx-K_Q@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth 2026-09-07
To: Mark Brown <broonie@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Wed, Sep 16, 2026 at 2:27=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Wed, Sep 16, 2026 at 02:17:35PM -0400, Luiz Augusto von Dentz wrote:
> > On Wed, Sep 16, 2026 at 2:15=E2=80=AFPM Mark Brown <broonie@kernel.org>=
 wrote:
>
> > > > Yep, you can add me as a contact person for both the bluetooth and
> > > > bluetooth-next trees.
>
> > > With your luiz.dentz@gmail.com address?
>
> > Yes.
>
> Great, you're added for the bluetooth tree now.  I note that I only have
> one tree for bluetooth in -next:
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-ne=
xt.git
> master
>
> so your fixes tree is not covered, I can easily add that if you tell me
> where it is?  It'd be good to have it in pending-fixes.

Fixes tree is in:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git

--=20
Luiz Augusto von Dentz
