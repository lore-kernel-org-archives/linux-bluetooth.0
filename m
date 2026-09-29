Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B892F4E0209
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 13:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790687789; cv=pass; b=luWU5OymPfIzbCzi5vUDxy3ErTPGAjH7WQlxzydyGfpDI+1PGzvbGwDiw9Q+1l7hjcnU8dUlVBVGhwJ5fUIPA1RqgCS5sT3cPtY6f6DypNfbgRW0VW/M6PaTnLCFrHIzrurbaFwMyoWvJfOEs8a0S4J2sGt4mGuNAwrwdXR25k0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790687789; c=relaxed/simple;
	bh=CSwy1XOEG+HCusC5MeS3T3KXLWEOP8ZUJFsm7HQJluI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OZywia2QJlgCUlGu8pQsyxayeJ6qY+fOjCjOtxCn9a0WJdGni1sBUVuSSp07JoFs7YSaS3IjweS+CthPoN63Kz3m029aqHs3+IDw9AKXE5QkGg1uuSAyKf78TQLbiI7jFN3wXDcjSGr7ptS6CN5oEfUL9FbK9NCc6cemvmJ+0Ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYKHUEMo; arc=pass smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYKHUEMo"
Received: by mail-oo2-f39.google.com with SMTP id 46e09a7af769-8144632e066so2244173a34.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 06:16:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790687786; cv=none;
        d=google.com; s=arc-20260327;
        b=VW+znfF0izUL+hT9RR/9zZJ2dZ3/WqOthJBwKFRd0upLGsZXJ5GabJONTfiY3FKBWh
         WEeZp9rTCOUFNp0ba2cSb9OkyX59q4Ux871fkaM8mjkoX85ozG7MbM5Xt64qAqRRxfIv
         BARDJCIqDAr8usN7Yj33OlfTxBQveKKHXXLsycDKBdoQFYYL+1RGBwCGVQjjvbOu4mK5
         nEBooSiwqX2+O2q8J1FUdBIc8Pc5unvBRNE1YsL3sz3AlD4J+8PysiRdD8mPc5zvcYzZ
         YbsV7gXNsZ381eSk3a4wObO7uF8E42dAoCU+nacLFybX1VNOA3FN4GOJnlfoABU6Gbsm
         udSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CSwy1XOEG+HCusC5MeS3T3KXLWEOP8ZUJFsm7HQJluI=;
        fh=/biZHoHUC9w3tWp0h9qKwDMrfEH0u/6HO19PnQWIZYM=;
        b=VrlHRUUChLaXq+arT+vEBPWQN6/DgkC5xFJh6XhUJg/FAr8NhpjAMZ0TEWxCPi/Elb
         redmIv6qAMmUaWpDAMXRKBAYXqDh/poja0e9IUYLwC/fnIDMDcDplqP2SijSIChM2IUP
         TrZUHTlybZRbELvqLdhYqgrG7rFVKV9seHVsFOruDEvWYpBVTRDtJWdlzn829GiGSb51
         z3bOVYCaidORLfl5lGhE3QYrn7DkJxIJVObAH1LKjV1aTR9GxkUP9use7Wf66S1GEv0g
         /lmRXgBY1T25uiSExCatDjsVoBpHK4c2384hNYvu7X9o7TYk8uybAhub/szWpGl+sXTL
         9jEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790687786; x=1791292586; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CSwy1XOEG+HCusC5MeS3T3KXLWEOP8ZUJFsm7HQJluI=;
        b=bYKHUEMoYJ25wxUFkRMZ5uL+knLysLFGyFDRnDwIInISIIdBR4H3t9Xv14aAt9mW7N
         UJTKJLgaZFIY0fKXQIrI3xnSwWF44b8D4k1qKFPpW3YteF/+elJ1vWYAfWHIWLNipr0C
         3SH7r8KZUGju+aZ6+U33oAWxyJ+d1JOV6Os8CqMMH+CS3sGbT8szQKBiCjX8XUYE7BL5
         +6GKDp8UYBwb6MhnIipTyWWGFF9jk0xE2v2HJtUa2Ehy4makZnvOaMsGWEBhBhfJig3e
         kkTbjrnPD+WsanWUgbxfEF9vD6VK0UK0t1dUq+eixNAwxKzd/Zjer01LoD3PMuMWJaBY
         c91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790687786; x=1791292586;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CSwy1XOEG+HCusC5MeS3T3KXLWEOP8ZUJFsm7HQJluI=;
        b=12bw4/wciiPDQpQeZJeO476iBBJoYOtM8oFUuDD8I39N8vDdERRxAQcMSf9FsrT3UQ
         fKvZBLOuemk7Vn/MVCBWw73IBBGeK0nG6nEQsL3dNV0Q61a7q2bVnyXniIB1wG90NAPY
         Fj4h0FI8acsyLrX6aiN9ihyA11+sBESfdw9q3sS6QUf/SfjUbbJA1vTdke3oH7M+LWJh
         mJF2J38XhrMk7SsLCL/DYqPbihZT1WJckDPoolW2k9Zzqqi+Yop6XKkXKwegN8Ue/iG7
         fCEplPhGYTr6s+A31VKfStw3RGDeMjETiot1Dckdpn/suCr7C6fxtkcT79djSfJ7CaL6
         NoVQ==
X-Forwarded-Encrypted: i=1; AKwUvBwxSuTDgPpjWkPY7zNRKGGjM0K/9rd9YT37id0GBHz/NqTP/3zN8uP78ibIUg/TYXCRniHufprdeHu5tuQ2Atc=@vger.kernel.org
X-Gm-Message-State: AFuF++na1Nk7zAaQdG3iguUdUleuazXq1FzTOinZdERoSp/sp/TGpD3i
	wyYZypJ07Qn3Muw08mP3NqSgRpt3v8m8CS8O1Ec3EmeELhdjRHg8/N5k/xgt6FtknsoGFSub0Dv
	Hgu8lz/SCxBkSkvLsux23CjU7zQv5I3M=
X-Gm-Gg: AYBFou16QpEy6nF4TsGv/kW62UjD1CGn5dnoQAQLOr0yc+dkZ/ypDBNjMabQkXRs57L
	HTuIUPwt9c6n8FbGd2z1P5uYN2mY0xUpqchcG6LqKHwRZKsMzER6eY+5l4h3Seb8tPqYWNLy+CK
	x+Yh3AGf9Az9WarLYn8dyIovjaW5M+xt3LbIevpl3oe6+xqQAwyt8j5CO6ru288HmELNpObePmD
	WouFMoXnzkxNPpVfDvftlEZnGe+TQLYAc8y4StBsEE06IIK2UMfy0hun4ocT5TTwFN1PXVZ8lGX
	hfDoABZsQe8i2iV5oQXmI561yl5QNSnt5ffHUBFUA/uRXd+G+wcKmEVg0t+Jrygz2eyka4/w9dC
	He3O8eXsk4T+Hi9J+vidkKxUnWW+0gm+J4Vs/Z2C49Q==
X-Received: by 2002:a05:6830:6b07:b0:7fa:ac4f:79c with SMTP id
 46e09a7af769-81782889cefmr15806453a34.24.1790687786319; Tue, 29 Sep 2026
 06:16:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929122226.98970-1-mikhail.v.gavrilov@gmail.com>
In-Reply-To: <20260929122226.98970-1-mikhail.v.gavrilov@gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Tue, 29 Sep 2026 18:16:14 +0500
X-Gm-Features: AclHuK9qxyQVFpLMnQcNjSC0ID0ApIeGlcHTJ_B2ZSS6iYVlJWm0BraMGsEB3zk
Message-ID: <CABXGCsPUbEYq7cN+SyicG0W9311QRNRFvybbmQrPnFtMB7kfrA@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: RFCOMM: connect the session socket without rfcomm_mutex
To: marcel@holtmann.org, luiz.dentz@gmail.com
Cc: nicoyip.dev@gmail.com, pav@iki.fi, r772577952@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+74071deb72339c215b2e@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 5:22=E2=80=AFPM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> An RFCOMM connect() issued while a BR/EDR link is being authenticated
> makes lockdep report a circular dependency, and the reported cycle is a
> real AB/BA between rfcomm_mutex and hdev->lock.

syzbot tested this version against its reproducer on v7.3-rc5, no issue:
https://lore.kernel.org/all/6abbb59e.64639fcc.9812d.0003.GAE@google.com/

Tested-by: syzbot+74071deb72339c215b2e@syzkaller.appspotmail.com

--=20
Thanks,
Mikhail.
