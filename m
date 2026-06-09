Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F26614F112
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 02:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780973421; cv=pass; b=EUzQYGfS2uh8BLBmbSQswDoubBxclvpmcxlKF468YDXoMOFCIdFLDsnt5u/zQNVfXxLHFEb0aPqPw3xZVlOAk87tRaaod0gjO7/d3nmHRzoPkeGDSh5nQzekj19XI6D9IhWFc84VTB69xrEImxVpHWOpr6Q+7mjebQ8rv8z06Ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780973421; c=relaxed/simple;
	bh=LFbPDGnrVTyTaFn8grp9ThiCyUbU9GEh2HZ8TeH3I8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=IW2Il0qqigzoiSzRADEpm4sjGwRHN8wYAYdKgecLNW+2BIxNdVVyf1HIF365oLptgbrRjCbvB/yFSWthpcYNbdxqMShZZMNEVNL9m1e4Bzi/YTQXbU+EcyUwJkkhCNc7iNQpHj00NguOyfR00J+yOtqaDPPh1IdZn5U6RTPJJHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4PBy/Mg; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4PBy/Mg"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7e87602f26aso56139047b3.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 19:50:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780973419; cv=none;
        d=google.com; s=arc-20240605;
        b=UvSQonGOX8eqdJn2w5JVzIBjG0bmRwI7rIo6HyqvMJKwjsWRudF3jwG9RKex2ZS9II
         ogCTn6j59tv8spdW+ZeVyigsDYsA8U7K7gMN4yjoJFuYXA6GOyuRPZQMW+Ti3bxKVswb
         bU76IBN9M5Guef9rLpjQo1FLoIqLwaJcaeIvN99CVQB9qOBUC0hhzItu5RHtKCWHAStD
         F/fXTbvc335/PPr7PWXQ84uqUjoV9q4W3guTDIiReKXx7maN5ldXsSJzYhqrVVHkyfQS
         nxzSJba1iM0B1KSopsdGn7kwLGlgTiX4Js6R8u/Iz+1TF1haou1JaOlS64Whlb0Bqen7
         m7/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D6T8UfPXpKw1+bYWR7ePy2Fkl+ivZMiEpPMXasED7KI=;
        fh=4lGQI6056MBa4/oovMyIYaKLn+Wz/24RGvUivMmQP8E=;
        b=iYFBD8yMFtMAb27XO2OyAzYmqt78QUyGZKGXWGhV3/4bTTQqxhuuSK36p3NkpjXaAk
         LZMKC6uvz53cizi51fnne1oqq6PC/3AT8bkLn+/f0zZQ0AJOuih4LBgcVX6DLU7zv1za
         /rrWYluPcZySbfSbNfOk/cDXrjrC8D/5DEO1JyxMo4fUX/Cre+h9XUAcEFWBiAI5bWxf
         aFewCyzUhf4pxakDL80VXKLEBJj6gwF+UkgXS9j7BNk6NX/c/Nyx9zsES5CY3WK5Pm0Z
         warFZzxBCdwB8nqQ0B6fqsvcJG0L4zfMNlzDNfmMtZafsvPSPQ63iddzhuT9Mq1uUKs5
         Q+/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780973419; x=1781578219; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6T8UfPXpKw1+bYWR7ePy2Fkl+ivZMiEpPMXasED7KI=;
        b=W4PBy/MgqhGaw9wZFiVG0Cb8SCwvZC0XN7/TPC55uFL7s6fZlDuWQ4EYcSVqEhGlp4
         4rTEHvQN7LCVqxVvd9vtO0JPPeqi4Yn66460aScaj6yrw+qCbzutwSmB613WkXLSPuZm
         kBI6QL9i4K0LxDCnP6AsbaPvw0mo5vFDvVrFTgbVLPXIyQ/w1HN4nDV7IPbTSZ0BaRfY
         O80zXQ1XdEpULkyd4fe/bajdQljb5U7NamImRdstjoVT2UfNYHN1xgJCmOh2OkvDZIjN
         9RBuLJ65hcYXpe9Fo0HZ0OltxQDxLa4X8SOvbOofZveQIKanHuyfQHwH41fPu+hgNjl+
         gRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780973419; x=1781578219;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D6T8UfPXpKw1+bYWR7ePy2Fkl+ivZMiEpPMXasED7KI=;
        b=CpvGuACL4xH6uLj4S5E2HoCr+CCQL9UbHj1v3QExSEI8u+2gYmZ9Uf0sVzcRPJbdix
         98FUflAA0JZPL1r7vN2cCgD/qDFiDWJsfmQx1g5c7x46EXtS6rl/trrQib1+behAf58d
         kqd6eL09iaAbS2xMOGHUTKFn+pMdxpb7vDRFZ46FF1KNWj+THemxXWx9L2U+5RSwZJad
         kbXP110j2RhI3qgoq3+JuqQT6U7EANER/w0R/rdFZe0K31y5BdeAqtfGoObpkWmlWzt0
         pFNTqCo/c6owIADZpdqE/GFkqx1rxu06USfZXZU19lVNN6jPOrB2ERAtOiuoIUUyDCiv
         jsvA==
X-Gm-Message-State: AOJu0YwSmJ9CiPv1Gvsg3BcT91mKCx77TsaGaJZsGk4FhnxjIBtLVpgc
	/aifA2GkcFpckAHSfB0vTfOMc9QvGq+aT4DJ9Q4wEnib6kDNHEfck6enwm+RAIkY0f78xZJYv3Q
	YteBFjqKUs8J6p1XbApcZErvuaKdMQ5QajZahEos=
X-Gm-Gg: Acq92OHk0U937Qp9ZJWGp/yK5XV46NE3UOEYQlq7sCHPl5+DHuG2NQ7QpbvqEXp/tlJ
	O6/8WAVrwrr8aVHa06CFBFmvEXL09g1LGW6anLELNIyIm4oi9cYtG+sv42DiXnLzMVRUxcOWDex
	MZe6JXOuF+wfCKXqV8x7NFd/OKhuubabJNygfbNdwdv9bLrFWHcmLKwXvJ82FGun7JoLHYKoA4a
	nSr31wAVAq0aDCtRkjfQCEk+s9B+hVMAvDbznd9vOSyQoKABrVMdiJ+wURgwlKgVH/u2ia2/R/I
	JO2A/aReIbaRMR8SMLsB
X-Received: by 2002:a05:690c:2605:b0:7bd:7a1c:9ae8 with SMTP id
 00721157ae682-7ed531ba3c5mr122453977b3.26.1780973419461; Mon, 08 Jun 2026
 19:50:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608235705.1233510.fe2269cf0103.bluetooth-l2cap-connless-short-pdu-oob@trailofbits.com>
 <6a277385.e1c1f991.db356.66c2@mx.google.com>
In-Reply-To: <6a277385.e1c1f991.db356.66c2@mx.google.com>
From: Victor Yeo <victoryeo1974@gmail.com>
Date: Mon, 8 Jun 2026 19:50:03 -0700
X-Gm-Features: AVVi8CczKZ8DK6RIt_dOlYRSjHE1HyMQSLUQ3-h5qiDR_kYDfU6f5ambtHmj-dw
Message-ID: <CADX0rsaejoVCmOE_AaHGfjf5iMUb8h4OKeheXm1uZXFj2dnP_w@mail.gmail.com>
Subject: Re: Bluetooth: L2CAP: validate connectionless PSM length
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

unsubscribe

On Mon, Jun 8, 2026 at 6:59=E2=80=AFPM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D110=
8158
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.60 seconds
> VerifyFixes                   PASS      0.09 seconds
> VerifySignedoff               PASS      0.09 seconds
> GitLint                       PASS      0.25 seconds
> SubjectPrefix                 PASS      0.11 seconds
> BuildKernel                   PASS      27.18 seconds
> CheckAllWarning               PASS      29.26 seconds
> CheckSparse                   PASS      27.84 seconds
> BuildKernel32                 PASS      26.17 seconds
> TestRunnerSetup               PASS      578.06 seconds
> TestRunner_l2cap-tester       PASS      60.04 seconds
> IncrementalBuild              PASS      25.60 seconds
>
>
>
> https://github.com/bluez/bluetooth-next/pull/294
>
> ---
> Regards,
> Linux Bluetooth
>
