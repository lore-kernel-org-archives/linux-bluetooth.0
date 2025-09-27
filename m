Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBD92E54A0
	for <linux-bluetooth@vger.kernel.org>; Sat, 27 Sep 2025 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758987680; cv=none; b=SzDjB110ocLgz0UOnAvt8rvzyiT9dNicmlVJfkfwLyHwJWD5OBwUGK1zEyyo0gcyBrGK0Qz3JL9d+kSTuI2MYDPIIS3MhkU0gZOIIEGVT09ijRlF6EpQXUh53sRrzsWYiy+7Adhq3w+BJc8Lr1Ah3VxuBCMO7ZmxShFxjzzljYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758987680; c=relaxed/simple;
	bh=MwQPpbtxqllDzMqIeGMKecP8ZVSyGm3WvIWyUvzamJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M4aq0PhuMx3ri3k84t8ezau5N5Q0mm8Uxz0Z0BkqwecD0GVAPG4haztPW7Ri4DPHHIS1AROYgqESKswIzC+Yp2I4Bj+40mcJdNVeSREYkjnsY6Yf3xiQmBRIYaZiEUh48fyoMXvNIEu30B3ND0mcjmEaW9+BIjKDhX+sSXO5lf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JdhSCfgB; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdhSCfgB"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-579d7104c37so4380553e87.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 27 Sep 2025 08:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758987677; x=1759592477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MwQPpbtxqllDzMqIeGMKecP8ZVSyGm3WvIWyUvzamJQ=;
        b=JdhSCfgBcA5uHWzjfh2C7zprZF84eVPI6T2L6vW0PU89suHTD+Hd5FbSD3hddg9hWS
         R7FMq6KsfDs9woLgD/AebzXCqByomjNzC0ak1Ga93NshHaqZrK/TPYDfCq/6I/R7IQWR
         aCROIveYRaKbTRzY3ospA9fkcYLVrmKmOGsNPuz7VdTogBpg166E6ReiK+afjLnLTwCJ
         lBnhPtlta9N9xi+Da3tGSutFPd9tc6jq1KFImY5sra7el9PnrsuKbGwS4NQVceVT7O2d
         5p7a4UyH7o4K/RjqorbnqfX5/GMSsAiF4Gf4ZHOw4Gx0bbCP4MIn/nnjnRZDansrLzrX
         tGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758987677; x=1759592477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MwQPpbtxqllDzMqIeGMKecP8ZVSyGm3WvIWyUvzamJQ=;
        b=EDg8syzcVjF+wRQFClhoQFMIrYJPoIDInGYMXf6ZWAqN95gBcUz0K0xQ2eH5kuigt+
         SeyVCSXMoVVPahtfqPOTgt+CU8mJVh7UrjxbmMS6dexp0v6y9ix2ciKaM6pb3BNgoCMJ
         xX5ta6jDGCd5Wr7p4oFIMaExB4wqFxRv7Re7ipSthW0fC1bVT5tygJLIEpguxLp1TZ0G
         vupOBhP9bXPlRKZrQVKLkVrzo6HZwoyRtwpLHhnY8hyW9RZ7ezU5yLscN/f3vqDhRGyv
         CsmpNOl7ftQ2NvCPzU6Z4xvsOFJKMgNk9+lwbpDUbugUuQYVQFdXU0nlPWjM6Oor/Tzt
         Srew==
X-Forwarded-Encrypted: i=1; AJvYcCX1Nt0R3KqmMHGpJeOhKRBfcumKSvWbyEK09zxXxi6VF/1m9ZkHmgJqAHS0ZtVnzseGQrSXlUnBh4ot9C9LBTM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0MrhNpLXnmI1dfNwKVpJtHViTd2tejP+y2QNDM0gZfRTNSSuw
	F6+G56Yg9eooUVP9ErQ2ZLV2QyCp/CZobbFQfXtitxq59USBJg7uUBDhxNra+ikDKBnTc+bq6P7
	a2j/dSSJITwEMgX1RjABNR1rMsvg0wBE=
X-Gm-Gg: ASbGncszeiMSCUFxGvdHsdJokOvUYFk/A5FCxJlk9MMEEFZ8dtyDOpDg5Npet2kY61r
	cfzrx0iyM7m+KU11WxFY2yp0vGP1+tRIVYkkdy9ikGHKdW61dTrFMUJVvT6mO11ScPi+YzwRASs
	c8fYiQGE5LtDfHwgRdN8BVZSHLwAUG2HQ6uBMVlinZ6e0T6sdoa7z2FooOzPFtP6JnZjBDNdoQE
	hHcqkwxjlxuXyRG
X-Google-Smtp-Source: AGHT+IGtbZ5a8e5PgEqpqmMCaNPGGJ1+l/uefZZJgo1GQDrYlHTthpkcQ/n4MVkDVeyHEa5MWB7xaoth40jIpHEceHE=
X-Received: by 2002:a05:6512:3a94:b0:576:dc1e:d6c9 with SMTP id
 2adb3069b0e04-582d092da35mr3581845e87.11.1758987677053; Sat, 27 Sep 2025
 08:41:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925145124.500357-1-luiz.dentz@gmail.com> <20250926144343.5b2624f6@kernel.org>
 <CABBYNZJEJ2U_w8CN5h65nvRMvm2wWHHRng2J8x1Cpwd8YL4f-w@mail.gmail.com>
In-Reply-To: <CABBYNZJEJ2U_w8CN5h65nvRMvm2wWHHRng2J8x1Cpwd8YL4f-w@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Sat, 27 Sep 2025 11:41:03 -0400
X-Gm-Features: AS18NWAlJuFqdeE2bGHSCzr2ghWJrQYAqHie5EJjH4eKDz1IuDZXR6u7HaRl8Sk
Message-ID: <CABBYNZ+98fYzySag=wQgHDnH=ZFZ8Rk+vvbozn=ZCr+QicrSxw@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth-next 2025-09-25
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

On Sat, Sep 27, 2025 at 11:34=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Jakub,
>
> On Fri, Sep 26, 2025 at 5:43=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Thu, 25 Sep 2025 10:51:24 -0400 Luiz Augusto von Dentz wrote:
> > > bluetooth-next pull request for net-next:
> >
> > I'm getting a conflict when pulling this. Looks like it's based on
> > the v1 of the recent net PR rather than the reworked version?
> >
> > Sorry for the delay
>
> Should I rebase it again?

Oh, looks like it is 302a1f674c00 ("Bluetooth: MGMT: Fix possible
UAFs") that we reworked during the last pull request, we can just skip
the changes in bluetooth-next, I will send a new pull-request without
it.

>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
