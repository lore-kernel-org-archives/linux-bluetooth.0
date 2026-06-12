Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139601F151C
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 15:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781276431; cv=pass; b=E0g4MFRkkG7KtqwiiF3O2NnE5bZYsaOjrg08U1MOGSFQC84VyxwiQvXexPIRzvrRYuPizzJYO5hmFHMXCHA9q94LXlSpOAP38bSs1BdoRENvPj6KOeT/1b2Mebh13/9J+1McYxQ82kPS0v/2Mk4ltOsrgXb1X7Wld81NW+GgePY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781276431; c=relaxed/simple;
	bh=Yb1avHp1oAumCqSgwa6dvrj6QSmjNEyJgIVzKSU/13Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F5HF2zND49GvRpbK5koRUMJVPlE+rI4A9+ua9jIDirKxb7DfWqFohfAvp1nDa9aEyId902eiE7lucN0K4UIA9Fjv/HgBF9BRlarzL7JRF4Aw2raXHS0C7kVU37anTuRoWWo5FL7X3U5fC6kncg37Fk/ZjzSbb6UyT3vB8+xNs0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIlplk57; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIlplk57"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-66062a414fcso1192559d50.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 08:00:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781276429; cv=none;
        d=google.com; s=arc-20240605;
        b=SVGsCULazSqyUtDeLriCJiCgvim+v9Bgko3GblaRtrCtU8Q0FyqMi8v3pd+C2ITHH0
         Z1xnMzb94M/73Yjrr7yG+c/uxo6ccBzL4A7ATG1y/EqaZqCKqtFdXySMIjbxskKAlTef
         4WjvWWcSpdMbAzdoWnhYREXgdhXLqOHcJMUFEjoWljTsW6S5oHifkarT6gd2xXxXmujY
         dZ1agYxsOwxM8qvb8YOYiLDLaiO6Ooq84jaUrAhhR8+8uUKTRVdvf4QLdo7tkNY2gs1t
         FVIjQW1D0rx08SuEyH5QLcujgeJ60KLYeM6AEC9Z8ynAn/EoQz4tpoLgSDd9ozk817jH
         AIfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Yb1avHp1oAumCqSgwa6dvrj6QSmjNEyJgIVzKSU/13Q=;
        fh=8H86giGP8UyruoOkodB38xgLkH0tFuZUiZihicAgRfo=;
        b=GTAfbov7GQ5G4alLatT2j2f/Z7y7r9r88DgtKaf6gnCmekuIO6psE0IMAs+vqmJ+CD
         6iLXyWTtaERJD4zfg3OdzNozHK9ZxtQH/ODzAtsKfgkKgcl9h3nb7MpcrYRqLdWs7Fsl
         Bw/TwSnXhKHgHQ4ABqMPfiew9m9ED8R2pyjEio8dGhhcyP7fG0TVdADsX876dc+HDBzp
         JaaRcVV+DMjwz5znJqrs466zUYT1A/6s5Vuy9hhtUYFArjjDhYn4nJplRgUwdEyqRcjW
         YdngZjndFWxw/pRPw/bQ5m1U4J/py7OysTjqGHljq86/QkHBhhHABMlqH5Y4/YWlaX0J
         +IFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781276429; x=1781881229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yb1avHp1oAumCqSgwa6dvrj6QSmjNEyJgIVzKSU/13Q=;
        b=fIlplk57e6LLkbQWUQDeXzgpeQH/z1VDoAhyastOwXmeJ7xnzfVGS4xKGyNs8KEDyf
         e6FAGdOehlrhHTDVKv4LazJ1qqkZP/0DaVc0l/OBRMlsgeYmyQjpLJppRF6DsZ6Z842N
         /bKfhG0NwmU1x6dzrobw+jgsJj1MOnVUwtVmm3zAokQOdOpOO9sMryA0TfEwO639gDNA
         NFc7wJS8eN9tcyhgzz+YCJHvfF6174s0CnerjIPMH58VU+mRL+Wbe4uRFuTZZM6ZHM5l
         r7ShC8i16vZ1VA1OilJnDMHYH9rJNAodQaATQkJomChabXd11xBCSodCZ/c9pPOK5VDV
         jCVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781276429; x=1781881229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yb1avHp1oAumCqSgwa6dvrj6QSmjNEyJgIVzKSU/13Q=;
        b=rgpou9zJBx2Y0lwYoavSIQKkSyrT/GtTm43/MJkaa3taVHTN8FAApd/GqyXa8weYOk
         Alhjzm+qI0EjEJmVfLB0uZm2RsWbdWSbMny8f5UdAj1QXupLKc/0vd4LpRcM7Z/2Y4t1
         3ztpi575fa7tNXp0xTIF/EUl7R8YMvsoTzisPtIrT4DpVeYCVQemFg0lfz2NhgZ9ZAYu
         L9+Sf2wdXhjILswrzGQ8Q6kRodF1C/sIwLOBZZ3zoWwRN89iUEEtVPi8LdHKwBRpo9YN
         dXmvMYHC6v+4JpofgS7Kh9fQhwEt1vd9WB9Vcw1g3KJlgo8e9HXtuLhQtwvTcti0A7/t
         shuA==
X-Gm-Message-State: AOJu0YwRKJEITmqvNmjPGrLb9B1TKEhkp8UMclgoo6BrdYEi6Be99DBY
	0ZRIXYZ7zvB/S5k4/e8iplf6fX5RRwGTAMuQG1xNHQDpfI6ZALEbkVind8hJSyUK/Vnq3lU/pPm
	awvmyMnqxdBcpxuBsHwfC0M2jNwY/EVsBkHDa
X-Gm-Gg: Acq92OETQKZ/pQsXaBACn3DAT+A66dOQwZ83Q1RlGSrMZiyB+YQVYSLkV1u5PL2akXq
	zJi6YBOmZofI9GGfcDE8g1opnsgkpIAzLrz2cjPWQnwqq80GTqub1IDjnJUFxYo/BmNjwdBD+Zz
	cSCz8uNEKn0Qr7CtuBODO5PcCtxYhyKNO7ziHocmssdgMNd9/rNjVCbcTztNStLnHhLeGFJG+jO
	eHYyVP6HXclt8R48TGOGhMQORjq0Su7Jnw0bwKYbuW6seq5OCMT5AFyYTLtsJrlZZPwymLvJIHV
	3FnD1WeaUzqoOHlxjTW8Bvlkqs814rFGVohJvr3IN9X8ObZJ2b+CuGpb0MtEONIWeUg3nQ==
X-Received: by 2002:a05:690e:439a:b0:660:4090:90e8 with SMTP id
 956f58d0204a3-66277fc95e2mr1930357d50.29.1781276428899; Fri, 12 Jun 2026
 08:00:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612143818.167643-1-stig@hornang.me> <20260612145809.181685-2-stig@hornang.me>
In-Reply-To: <20260612145809.181685-2-stig@hornang.me>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 12 Jun 2026 12:00:17 -0300
X-Gm-Features: AVVi8CcBcfZb6e-hh9n8AgLIa31g5t-WMuI62_b0BnYoFCtbMVC2F1i39sYVHC8
Message-ID: <CABBYNZLUhedTTRcUeDX+2_0Nr3+xCXeUq87EHnK6sweybQmUQg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: L2CAP: fix tx ident leak for commands without
 a response
To: Stig Hornang <stig@hornang.me>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stig,

On Fri, Jun 12, 2026 at 11:58=E2=80=AFAM Stig Hornang <stig@hornang.me> wro=
te:
>
> Found out it was already reported and suggested fix here: https://bugzill=
a.kernel.org/show_bug.cgi?id=3D221629

There was not a proper patch though so Id just add a Reported-by.

--=20
Luiz Augusto von Dentz
