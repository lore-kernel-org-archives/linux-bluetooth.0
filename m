Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FC339B4AB
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 17:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776965198; cv=pass; b=UBaTyNYSsnStvd+eCrlaF1D062phTWnoY4cRVI/U1HMjaOn4XJaVTF93DoqPjd0Ls67RMPdIzd4NqeFT8H+tdCUBvOVw+KC0GpAPWLZHJwBDALuFkO24Lk/pLT1QdN0zI5LnKfOaGzNsbY3XIrDESUHb6PzK6lEv+dSlW6siRS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776965198; c=relaxed/simple;
	bh=FEHFci8uKEfcPUWRFFUCnUxeCXKE+NI/2vZWI7kEE8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PVZbhfsTWBHsNvp3lfMGGTx/YVS3fFm8g+OdrWR+7ariGqU3iwIO//rpE7HSNpjF7j7NM0BxuBXGStdhkRcq+6nwWSQaQjtbF9H9IKv5j6M3ZvJVC0prXGjBXufrqDPDI+54hULKWj7XFYFZSR96sU4zIv80+MbHVz6q0t6Lm+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GEmfxvlH; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEmfxvlH"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-651bc8f864fso3952945d50.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 10:26:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776965195; cv=none;
        d=google.com; s=arc-20240605;
        b=Mr2APNpPS4bMGwOoXNrar1AVvAcBoAJutXF9mYfDKKGgfXtSjMUKuAPHZPMZXJbOrU
         msWAxNXAd7QvHYUmmmivJhl0o9n2FDtDWj5YALgOltjJkbJajWtjcL0ZQfI5z0LLozuq
         2SWff1+JGl1D01adY/n+GTq7ibWk7vPafmpoxmfEZYHvbIuUJ/IYK4gk5WLNtIbKyGxq
         5pA9gHn1fWDeoLF1UjdaGEA01dEEPQQFSuZipB6gFJyHvVXFF2mUL4ONtdMsZrnpoNA8
         2d69zwv7Hexfh2eT8M1Sondls4M1hDgRNiYakDNzGedwpziu6ffQu02Dg23wSVKd0EBg
         xs5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Vb22X+CTPof0jq+Ho5FPRTYpfcbjJjYuP6tugRrM2kM=;
        fh=8rVPiVml4XFJXnX3mlV3QG+mjvYH8SEW+dkfP6BwBGQ=;
        b=DqrqWWjxX0Ck0pVs/Id+tPGFgXqEUb4X4DSwm5BqsDwIZoL8Zpgx71rOY/9m97QiGr
         Zjyra52tjF7Wwac8l2Q7UuOgRCuRT7kwdEAfHearWvCBO9mIE7MCuqo8h7igaM7TdG7H
         kN7Lo7qov+exG51ch5w0MxovTSwizdrf3HzY35TIxxgzRVydBN2YKqcMxV82zrclRMb6
         zvBfQ4/3x33rzZqgHCm50BY6d2kafBQuX6K8E/+RZWRBDGcb0/+YPaV6Y1y6XwEsp3qX
         sVW7cfDjzKYa1cU8lZVpt5oxH5LGrRMqxlB+xG7cYHkykNw/eSNxJPEbh28OFXeOdYA8
         5YLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776965195; x=1777569995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vb22X+CTPof0jq+Ho5FPRTYpfcbjJjYuP6tugRrM2kM=;
        b=GEmfxvlHi7j6WuexDXgjgy3UplZr/XXxnKJMuc2+TBxVYO1JUkKUmE55Db0POfm/bR
         Gh3CRSHW7jDLvJRjX2d1B7l/jUI6yiHTyvC9LOIjvwRuqliS1NizfCzzkg7GhW+PCIKg
         kqlOWq+K1dEwsSYCsAi7/Y7kDIYefHBuuT3OV2FtSMzjs/x2jRfHiSgRnP8Wm2h0pu5C
         ahNff5+gbP1GUqY4uVfQglGpLLuMi7xscXYneveiYrBfMTkPdnQcum50rTHrkqXTaGYY
         9tMa94J5opW+RadnvKPnWRGyVDSeOargyM5zwaY+z/QV5D++mAIipE2Edxebo/pqzbbV
         I2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776965195; x=1777569995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vb22X+CTPof0jq+Ho5FPRTYpfcbjJjYuP6tugRrM2kM=;
        b=OU30XSDGKMcEg7lQv/14EeK67NQXOsMfemPfJToCjRk9ecmFPbW/Kic2o18Zx9Isdq
         4c8tO9W+zVsuQtwkWHendbW2kqMZfvfXpK0PXu2fsLJJawqavSNJMHf+FsleoodnzN7b
         7aHBcg0/RMOZlEM1wGiT1SV3WQVaTmpNOFWt1NVR96L/Bejq1KxfyCQUg5E1IOn0NQWJ
         IL1NuJu8YLR1Ph+ZsH+ylJ2gTwm0vf0/xOeZv5idZpTh1rcieHvOwI0BNYpn6RC99v9/
         ftw3yETtY6fTnvSrbGb2T1A3xbdSVstOU2Gs5qBf7q9KUvBo/y7Hz5BfRr6f6ziaSqJm
         kBWg==
X-Gm-Message-State: AOJu0YzrNXIA00vgi738B38TDyhiXDFEepJ2UjTbmrtnSibp/ht0L7XO
	0DhCnblAkqEtDjWYnNFQqVkef7Nkmt73Dpze8iNy5IBx6KoObimY9K55f4GFG3z0rkEPCQJPNWy
	wlc6tWsuSn9kNdcT+I5ciABGms2iTgZQ=
X-Gm-Gg: AeBDieukO7orOwI736tPkzqgXx7V+0Y1SrxLHu8Ox+6HP4Zy27/rmHPkFiNvf2gc4XF
	lpw0HE67WZ6PoDqveG8IOydMu7/N2f2AL3Kmo8BJTKpTmIU/I6YX0lRs8FiANSgiwcyKWLopeCe
	8VMFGKZlZsdxsZBzgzzrxiCTToMhr4QG8rJ6MJSm3fP+DzX2HKZTJMvUgZPo7+cn/bJjF/jeoUk
	0ZfU06h53hvJnjh36kcA72edjJ8tUtcvtxre68SdrHnm7Z5NM3Db+So181/DUpVppP8ikmc91/k
	DRYwrPxsMRVxOKFfaMuMqpEkEiDuITnenO8zS3/FYDvU+81WLiU2Q062R2IbuBmgRc2AurE4Omi
	gUJiG
X-Received: by 2002:a05:690e:2501:10b0:651:b47f:99a2 with SMTP id
 956f58d0204a3-6531087668amr20705576d50.22.1776965195291; Thu, 23 Apr 2026
 10:26:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421230917.7057-2-ebiggers@kernel.org> <69e81184.050a0220.343b8b.d048@mx.google.com>
 <CABBYNZJHdfByt_Tg7WV2S-fZ9xxJYVH4MyBxT3MGTNkbX5f4rA@mail.gmail.com> <20260422230256.GC2226@sol>
In-Reply-To: <20260422230256.GC2226@sol>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 23 Apr 2026 13:26:22 -0400
X-Gm-Features: AQROBzBTtXASCKUxt1UikdNVgPkVNdCn3rzrsRS-oaMbDTtt2Yl0C1lQfk2VSZI
Message-ID: <CABBYNZJA3kG=HORtgPc_kj6xSvd2=yFN_P1_BrBXFQdz_wQZNQ@mail.gmail.com>
Subject: Re: Bluetooth: Use AES-CMAC library API
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Wed, Apr 22, 2026 at 7:04=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> On Wed, Apr 22, 2026 at 11:11:25AM -0400, Luiz Augusto von Dentz wrote:
> > > net/bluetooth/smp.c:25:10: fatal error: crypto/aes-cbc-macs.h: No suc=
h file or directory
> > >    25 | #include <crypto/aes-cbc-macs.h>
> > >       |          ^~~~~~~~~~~~~~~~~~~~~~~
> >
> > I guess this is expected since rc1 wasn't tagged yet, right? In that
> > case we will probably need to rebase once rc1 is tagged to integrate
> > these changes.
>
> Well, the bluez.test.bot seems to have ignored the
> "base-commit: d46dd0d88341e45f8e0226fdef5462f5270898fc" and applied the
> series to something a bit older.  In that case, yes this is expected.

I don't see that on pw:
https://patchwork.kernel.org/project/bluetooth/list/?series=3D1084071,
and even if we did support passing a base-commit that could create
other problems since the test cases (which comes from BlueZ userspace)
are only meant to be stable against trees other than bluetooth-next so
we might be able to build but fail test cases that were recently
introduced.

> Once the bluetooth branch has been updated to v7.1-rc1 or another commit
> that has the prerequisite, this can be applied.  Thanks,

Ok, I think we are still in the merging window so tagging RC1 will
probably need a week or more.

--=20
Luiz Augusto von Dentz
