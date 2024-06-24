Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C28819AD68
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jun 2024 14:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240992; cv=none; b=MH+FksxJspnIkE75yeGmTjLUaEwQVq3714cVJ6MIV8cJAti7QorEqyGc2doZYW9S6RVlo/9EJ1+Up4AJn+I6N0qWLrpD6o65ISEmZBQ53Y12XLZpiGqhe0F2BwShvzi1HnfpoeKKVxf6fz5ofmDD381KnjglSfMETxnKOB0izZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240992; c=relaxed/simple;
	bh=VsmSNQiI2bOeSrGVkX1Wl7M+sC/exogINbD1Vrmm7bI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ECB2iLPuHWWd3SJM42DSheJoowGORkZQjkrNToyh9vxTPxELIAonoOTOlqeQthTk63pWR+pMG4bxYWRRSxiF8XvKnbAmxdiJy8O2RF8wT3BZuubBhieYG2JAWVSFCnGbNUD8TphCz8DZvDqrCNJjkY6b3G+4v4/LtAh3lbfhwE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GiNlUryB; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiNlUryB"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ec4eefbaf1so33755211fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jun 2024 07:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719240987; x=1719845787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1AshNsEYafiYe22RGOdFPAXJwqLyK3//BMLskB4lyLE=;
        b=GiNlUryBMgCu4uunt0EY+2WivK+/Ia/C2DYtFBsfvlK17CCnms7oGk4FJ1IgBuy+4S
         eS3wnLkgxkjCZBSD0L/4eaCwSphcmTAUtGJ/YlWGBaPpvG7W9lLvnT8MaaBi+L8Bp0vW
         B/JpKt/tasGPSSqdzb8VQq7DFn7I9zngqOEWwuZTqScaOrQrzS5ETZG42dRL0H6N/x2r
         G8rF9pLrMAbQxYETGIIQVq4vmATq549yzKTwLCZShHm1Diyiv8zimR2zqQXDE27TOJ0T
         RcRC4Bb7/vm+6T8ltgIiwHqUW7SF1MbtySl6PcH/7byDAE+LzLSXnYA0LEWxmIFZ8kjj
         UvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719240987; x=1719845787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1AshNsEYafiYe22RGOdFPAXJwqLyK3//BMLskB4lyLE=;
        b=XETleTmeIgf2THgbkU7Ih5flvbPv0WLQ0BcZQZGmQ3y2RhA8Hg5PjmL+PyyAVInpt+
         M1ihEEJtyGZLkoRitcOTLYuv/ZGglVUrBKea6Eg5mCJ5dvs3Wsjne+KE+YePwICJyVHc
         KvkqEebW6BmcbDvDUyC9z0LULAK9AuiIbginC8c30FAM1P9l+FluzyrfUND9JdhY7Kf+
         pSAyfG+QUWz7GcQ7I85afvC7X+GFp0TcWrAb1UhORq+dvdD6ugVnnHEZm4wldf7NQk43
         Ri2HdaNr91Ke32KDFNUV16ZHvA0odPzAfn41NvNW52GzjTK+1oYy3FC3iTsxJU52W88h
         QtLQ==
X-Gm-Message-State: AOJu0YzbgQqrv6Y1EHu1DnKlW8MiLbxXmxVOgFX6cJ1q0x+BYAinhBw0
	wJz6lhWr3A5ecFdIUvnvYAeL4P4P0vwzKaPQSr7ffLviIxwm6lDqogCrU0YYx+6bE37fwRqZJ+S
	L0i387d2OxHx90L44dGY2Sj0YvWA4tuKN
X-Google-Smtp-Source: AGHT+IFXABgdeQNlHTGC1Einjrz80Ex3xPzLS5I4TjE07mrQgATwB+hSndOzPpsz+o0umUgcml9FH4+mHkyV+qIns4c=
X-Received: by 2002:a2e:a17a:0:b0:2ec:42db:96a2 with SMTP id
 38308e7fff4ca-2ec5b38b432mr29690141fa.29.1719240986822; Mon, 24 Jun 2024
 07:56:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624134637.3790278-1-luiz.dentz@gmail.com> <667983ff.050a0220.5ea4b.fb53@mx.google.com>
In-Reply-To: <667983ff.050a0220.5ea4b.fb53@mx.google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 24 Jun 2024 10:56:14 -0400
Message-ID: <CABBYNZLAn0VeRx5Mvqwu9=FSPuGvdKdtggk42xrhrdWxU1hPBg@mail.gmail.com>
Subject: Re: [v1] Bluetooth: L2CAP: Fix deadlock
To: linux-bluetooth@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 10:34=E2=80=AFAM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D864=
924
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.74 seconds
> GitLint                       PASS      0.24 seconds
> SubjectPrefix                 PASS      0.08 seconds
> BuildKernel                   PASS      30.23 seconds
> CheckAllWarning               PASS      32.83 seconds
> CheckSparse                   PASS      39.01 seconds
> CheckSmatch                   PASS      104.85 seconds
> BuildKernel32                 PASS      29.39 seconds
> TestRunnerSetup               PASS      529.98 seconds
> TestRunner_l2cap-tester       PASS      20.66 seconds
> TestRunner_iso-tester         PASS      43.64 seconds
> TestRunner_bnep-tester        PASS      5.10 seconds
> TestRunner_mgmt-tester        PASS      114.35 seconds
> TestRunner_rfcomm-tester      PASS      7.63 seconds
> TestRunner_sco-tester         PASS      15.29 seconds
> TestRunner_ioctl-tester       PASS      8.05 seconds
> TestRunner_mesh-tester        PASS      6.12 seconds
> TestRunner_smp-tester         PASS      7.05 seconds
> TestRunner_userchan-tester    PASS      5.11 seconds
> IncrementalBuild              PASS      28.12 seconds
>
>
>
> ---
> Regards,
> Linux Bluetooth
>


--=20
Luiz Augusto von Dentz
