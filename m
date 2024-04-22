Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6685028B
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 14:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713794441; cv=none; b=JXpaZ5ROzVWynpVi6hPciiw9d+zR5ghbgd3tu7q+rMykOEPuIGRNwHRUNCZs1fFYVbC2k2YH8oheNSOkkWRuE0IBnDproR2cc7VXap8LD+mf9t9F4ebIY7vGU7DsbHuiM/4OPorqn8mbzmaDIgvKmFKAkB4wQoNjyfxfgBlAFho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713794441; c=relaxed/simple;
	bh=rvLTwPVL2eye591GV+V4jOeqhvBheRAR4e6OBbOKGoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tkwC2YzQI3Lo3IZ4BS1oa7Bx4l4QKFBJqGMdVItTNhQEbusjFaj4tFARAsDVHeH2/Sx8Ka5qzgmnhDWpnVE01WeZGpX4PULeOUOIVM8aEPt4wVwzAedxEB+MWUxm+COA2o9/es+AhjDE6HrgM42Qyx6kSYC2uzWY0VfZcGenmT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tlb4caKC; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tlb4caKC"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d895e2c6efso67178551fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 07:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713794437; x=1714399237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HnLof2JqIu2jM1NdTS6ifu4tMrnRrSQ6Mqm7+AcL31o=;
        b=Tlb4caKCF9zFEon7AAMoyz88yyIJua77AVFt7H8rX3qNapCkaMMtx2axFCoQmK7nFG
         LKSCok1al4YDAbP7ggP0OSBUKAZry01BoHen/50/moBnXEnbYoxd6cB52WduFALv66Ma
         w6XOaAcYQrG+08NRaQKBjqyW8lHz8beZmKw8u2MSI/xrZudNBcBOQgCuJhELhUoUKmQZ
         O4uc0oybk012fpywEnn+ZBeSJH67N2IEtSX+fs66a00H+84Xf3N2LKXJv2xwbjpNLpp2
         n4UqpM2J2pJRJVryBD4ezrzL8ZIEQhUKTs1SahD/XxL5kTHZDN/xVvXe53WsdWP1pCgt
         hXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713794437; x=1714399237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HnLof2JqIu2jM1NdTS6ifu4tMrnRrSQ6Mqm7+AcL31o=;
        b=HoifRuC7pyMHiPAtNlN4c3ApZtY+18pv43/LXxC1R+Qf7OQrllHNABAnBlfFrtxqw8
         rxNYWfqCiKdEJzsvZG01CRu9eHVycrnkijqWjCSYCY6VE+GEQYm8jSMiuEv0rjoxQ1S+
         5xJCrSBLQL3vmpINIFjwVDOiK4njipJ5boBrZgKUzrtehZYPnu7s1nt4zYF0UfRpR6rK
         f5fcwipO7uUzyjQrBfCqdESQA02sppKPe8FzZKnsqPShAvcIywV++1zuYHd7bv2LrU+Z
         MSwMnuFRNGApGfVk7HvvfYvZBwy2RmqX1tJY6jTHWd19jD/wmnAGyVF5cRhAVckuXIjK
         NeAg==
X-Gm-Message-State: AOJu0YxSIuQa27rYBASFMmttT/8VRjL1ZYjV7+OmvsLHarDq7o1TsvtD
	BO3lqZRjVXcBskW4gmfnTSMZDFOS/U9P0Xqj45JbEVLOTq5Q1v+AkTj4MSvvIG1hxFKCwQUabk2
	hTzZhD/xuJFAOq7lzNkC/VnKsaUbisA==
X-Google-Smtp-Source: AGHT+IEGQgqu2ktq0b0x6mj4RFUUzu2EpRxpXJzx3YPwXSbu+TQ3VqLfJfYGL455fX88UmmDaXkWMOGOT5jAtL/JmBQ=
X-Received: by 2002:a2e:8903:0:b0:2da:6f70:56e6 with SMTP id
 d3-20020a2e8903000000b002da6f7056e6mr6091095lji.24.1713794437077; Mon, 22 Apr
 2024 07:00:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408125806.12682-1-surban@surban.net> <6613f1f7.170a0220.836c.1ac6@mx.google.com>
 <CABBYNZJsojUqyYc-ywcASyRZ2_NWyO_54t0o4Sk8dMuT9KbzbA@mail.gmail.com>
In-Reply-To: <CABBYNZJsojUqyYc-ywcASyRZ2_NWyO_54t0o4Sk8dMuT9KbzbA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 22 Apr 2024 10:00:24 -0400
Message-ID: <CABBYNZL2q90Ggq=U26AvhUKu00RSHkbdCi3-pa43MhTWrQc6yg@mail.gmail.com>
Subject: Re: [v5] Bluetooth: compute LE flow credits based on recvbuf space
To: linux-bluetooth@vger.kernel.org
Cc: surban@surban.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sebastian,

On Wed, Apr 10, 2024 at 10:40=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sebastian,
>
> On Mon, Apr 8, 2024 at 10:05=E2=80=AFAM <bluez.test.bot@gmail.com> wrote:
> >
> > This is automated email and please do not reply to this email!
> >
> > Dear submitter,
> >
> > Thank you for submitting the patches to the linux bluetooth mailing lis=
t.
> > This is a CI test results with your patch series:
> > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D8=
42452
> >
> > ---Test result---
> >
> > Test Summary:
> > CheckPatch                    PASS      1.01 seconds
> > GitLint                       PASS      0.22 seconds
> > SubjectPrefix                 PASS      0.07 seconds
> > BuildKernel                   PASS      30.65 seconds
> > CheckAllWarning               PASS      34.59 seconds
> > CheckSparse                   PASS      39.10 seconds
> > CheckSmatch                   FAIL      35.16 seconds
> > BuildKernel32                 PASS      29.28 seconds
> > TestRunnerSetup               PASS      528.76 seconds
> > TestRunner_l2cap-tester       FAIL      22.63 seconds
> > TestRunner_iso-tester         PASS      30.74 seconds
> > TestRunner_bnep-tester        PASS      4.67 seconds
> > TestRunner_mgmt-tester        FAIL      110.12 seconds
> > TestRunner_rfcomm-tester      PASS      7.26 seconds
> > TestRunner_sco-tester         PASS      14.97 seconds
> > TestRunner_ioctl-tester       PASS      7.62 seconds
> > TestRunner_mesh-tester        PASS      5.77 seconds
> > TestRunner_smp-tester         PASS      6.78 seconds
> > TestRunner_userchan-tester    PASS      4.93 seconds
> > IncrementalBuild              PASS      28.60 seconds
> >
> > Details
> > ##############################
> > Test: CheckSmatch - FAIL
> > Desc: Run smatch tool with source
> > Output:
> >
> > Segmentation fault (core dumped)
> > make[4]: *** [scripts/Makefile.build:244: net/bluetooth/hci_core.o] Err=
or 139
> > make[4]: *** Deleting file 'net/bluetooth/hci_core.o'
> > make[3]: *** [scripts/Makefile.build:485: net/bluetooth] Error 2
> > make[2]: *** [scripts/Makefile.build:485: net] Error 2
> > make[2]: *** Waiting for unfinished jobs....
> > Segmentation fault (core dumped)
> > make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bcm203x.o] =
Error 139
> > make[4]: *** Deleting file 'drivers/bluetooth/bcm203x.o'
> > make[4]: *** Waiting for unfinished jobs....
> > make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
> > make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
> > make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
> > make: *** [Makefile:240: __sub-make] Error 2
> > ##############################
> > Test: TestRunner_l2cap-tester - FAIL
> > Desc: Run l2cap-tester with test-runner
> > Output:
> > Total: 55, Passed: 51 (92.7%), Failed: 4, Not Run: 0
> >
> > Failed Test Cases
> > L2CAP LE Server - Success                            Failed       0.099=
 seconds
> > L2CAP Ext-Flowctl Server - Success                   Failed       0.103=
 seconds
> > L2CAP LE EATT Server - Success                       Failed       0.103=
 seconds
> > L2CAP LE EATT Server - Reject                        Failed       0.091=
 seconds
>
> We need to fix these tests as soon as we apply these changes, afaik
> you said they are expected to change because the credit changes, so we
> need to update it with the new credit logic. Also it would be great to
> add a test case that covers the broken behavior where we dropped
> packets.

Do you need some more feedback regarding these changes? Looks like you
stop responding for some time, I do think this is very important to
have it fixed.

> > ##############################
> > Test: TestRunner_mgmt-tester - FAIL
> > Desc: Run mgmt-tester with test-runner
> > Output:
> > Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2
> >
> > Failed Test Cases
> > LL Privacy - Add Device 7 (AL is full)               Failed       0.195=
 seconds
> >
> >
> > ---
> > Regards,
> > Linux Bluetooth
> >
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
