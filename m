Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808DE35BDDB
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 10:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775816476; cv=pass; b=AfXlhGlTfBp7N5gBSaKmW7Q8OnViq3b4wmz/kR7OH0ErXKKvEs3NDI0tILno8Gi8hehL8OckT2+RemxcaCyLDga9jzGpDuReE2AgNANjubli6wsNETg2PC5aaB3YpH/gxdjVtbUPlR0DdhcHvAgAk6N1vVuKZx5sTx8J1lRLIYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775816476; c=relaxed/simple;
	bh=j0OX2ghBqlh8u80dCwNpHqiehjj3sosSHQ9T+XIQswI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SlE4QyuBtDlgAqV6exLgkrKgju7YIFfC/QeIMERijmZns3Dyr7lYEyPeIgtQTsFFWgXk8dYOPm8awGOUeJVAXpuez1q4s/Al5IW3NZYibkgLyTbqTwM2SVRQZzJ0g8n8z0pX+ZcmjT4iucqd9+M+CXsoTOQ72PP+YzrtXf/g7J8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5/YcQzJ; arc=pass smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5/YcQzJ"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d7ebe11bffso1720425a34.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 03:21:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775816474; cv=none;
        d=google.com; s=arc-20240605;
        b=jv8iPMOQLKkeVs9wMFfgLypMM4okAPhj2AM59Pihc5ikmJCX+6r5b9BJfWLucbRIj4
         ZwXZTvqZ26uuUMuzxMTDeLT65aL+p1H/3Il9sHBWevAcDU2rB6qDlRXqi9hndplDv4yo
         XrAxpyRpJTLsIwlU5DsND3tRtXXjBJByd1qGQHVMy6GyJsD3xYR1LD3A5im1hwN17IVN
         7SBsmrmG0kOEiMLfKvHNMglB0+DgAwZyWsucgAHe1TbVk11zrAdCeBDGT763mo+4SDgO
         5IprzcpuCGBTtjZdkk4nYpQmvALRwtf5+NYtqQtMIBktFFkmcLgkrdiuh2v1XCPRDV+H
         H+Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HJi6wr2O6o7bvRovm7nlT45AsxKxm8Z2S08skDM8lBw=;
        fh=5pcMYRmMz7PpPbINbKWIiJCBnvoFrfNEXeIsg/qOZFk=;
        b=e1BV+SYEbI6zGJe4C6/z9YNtwRN/v9gb570zfq/D5E9ZzHpHp9fq4tuxwIYqYajeph
         pw+/5fHC5uEextkL+8DHJ55SNLmPEAQdTr922azbgGHIAwIq1PlYFMNkHsLGuCTEJw4G
         8hNfE2YKXLsbb6/ETefiSvUxVJ2V2G0DSbkQJJFCTT3Ei64pTzCh60leB9m4uk2e9zSj
         LrFLBXn5giHHwQIcLAAuPYYInfKdRTks1vBTUGy83ecRshc9AJQFdCGBmLnZoXebjQ87
         ANuNKtDcKbwgOdA0ZzbGp2w+i7vcM8ZCEqWVu6QehgfLcxdFg3SpGf/lOBS5PbJRHENV
         vQLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775816474; x=1776421274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJi6wr2O6o7bvRovm7nlT45AsxKxm8Z2S08skDM8lBw=;
        b=N5/YcQzJv1y9lwA7TT+OC+VNS4jJdXEXi1fyc5pOg9jxyRRxceyrXq7hUmDF7JoVql
         kv2v+X711B7KCDyQpn4SLtm45ufhDk1Ejr4vtkJ/CgTFbX9qG72OPSwHgMr5+Hfhw98e
         2rIK+LNEQIVhOazMnAQviaM9DM+83MB0CazfqVo4D5D4A8ZGguGp8xjcq4Lh4sRYunel
         fY77L4+AyDted+Pf0VW1HPlmK2dz+qbh+RtpsQJrJ4pd5d3l5OBDHG4gyMo47od7h23s
         mUMs+GuTJJpdzcSJd79UCwwtsMhukH9/a2No0k/ZSYLrxBRf1aMlxCUluA9qSvLhdmBg
         VFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775816474; x=1776421274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HJi6wr2O6o7bvRovm7nlT45AsxKxm8Z2S08skDM8lBw=;
        b=UzVBkVaOFsQ6FXpaGoQ5jGn4zCk84LhmqoDQ/XVvkO5M5I2g2mev235D5O4gh83Cqb
         T367vXR6T63cuziLMfjCWSrs6YW/MqK7IPT2ej+NrbVQLqG5bfPU3uq/EPtjhB6+QfHo
         QVgM0DdUThV/u0FzjPeBdqL1F3xvEUdz77trBXMkFYfL4/m43tZ2jKuPZZo2KTo5QbYi
         a0bIzQBJXdn5dNPe483NkFn5GZP+iUU9evCLp9OG5JZjf+gj3+Kud2lsUq2zFsHENMH2
         L3j3d91/fBnIepOsOJUPTooGlpYgDywYfc65Y+TcUAMVBIviUz3Q44zkeSfme83/n5rZ
         BZeg==
X-Forwarded-Encrypted: i=1; AJvYcCWG0FgjfMqiET8Hi6nkgM7+toi3YtP7R3u0Tc5jG7cmUQSPx4VT/noqEbzD0xxWoIXx/CeJpEbedQltD48+7gE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWrwYycB70Tw7MX+JbV8DxGUSxhXrV+4x7LKPHb0HLfFgmnVow
	n7p4lFZRmScX4KLgX6q8BTrLmQvW0wIUiXQregJKVOIvAXJIYvdk/mOpHxdmB01qMkWc2+/CWgw
	6IQvC126DmttzRctdKIqKsIoi2iYgPro=
X-Gm-Gg: AeBDievtvXaeQS0zruwGB4ykGktErjH2ZTfYId9vK7FxQAulZP6ef08KKTvmb1Fn/xB
	jP1G6i0V+JO4iHDaYOO68BS/aSD7+UUuRvp/DnNQaE3f+iFUKEoCSRry07FCOlQDo7F8BPqVeLv
	TYEhR5oqqLndT3NrOFRFunfm+bWGAU4Zu32ANRf4TNPvw8b2pEtJb+O0i1OogUNuYfcmfXZdqlj
	aACyFm6StXB5AD877Xy0wtxcVhNR7QgNvlc/ytbQvxLh2LThXdJHU4CIlXNxFiW9pw1SN6Uz1Tf
	hSHQi+5MyA==
X-Received: by 2002:a05:6830:828c:b0:7d7:da43:387 with SMTP id
 46e09a7af769-7dc27f1249emr1584515a34.16.1775816474347; Fri, 10 Apr 2026
 03:21:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410063001.94728-1-mikhail.v.gavrilov@gmail.com> <82e1f358-f5ae-4ad8-9069-2c46996abeca@molgen.mpg.de>
In-Reply-To: <82e1f358-f5ae-4ad8-9069-2c46996abeca@molgen.mpg.de>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Fri, 10 Apr 2026 15:21:02 +0500
X-Gm-Features: AQROBzCMY9KKkHAbimt6JMWOdPZ412gYZ_FU2GHcGU-Ik8TMudHbvD5cBEB_RKg
Message-ID: <CABXGCsO+x89wZ0XUGNvf4Nr6u=e8zMcyd_=tWmWcu0vVkYx-Bw@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: l2cap: defer conn param update to avoid
 conn->lock/hdev->lock inversion
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 12:29=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg.de=
> wrote:
>
> No need to resend, but out of curiosity, is the result, that the device
> does not work?

Hi Paul,

Thanks for the review!

The lockdep warning did not noticeably affect the FC-49 functionality =E2=
=80=94
MIDI events were received fine via `aseqdump -p 128` both before and
after the patch.  The warning is about a potential deadlock that lockdep
detected through lock ordering analysis, not one that was actually hit
during my testing.  That said, under the right timing conditions the
deadlock is real and could hang the workqueue.

--=20
Thanks,
Mike Gavrilov.
