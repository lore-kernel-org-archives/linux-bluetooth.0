Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794585869;
	b=HCDMWN+XcD9GwjYKA0fMCwd1RprpLzK90ZdcDYJes52dSMjb2ep6pjPEf+SKKVWRi3pH
	 F49CS59bLrFrz/wNseAKO/Ll/1O2z8/pY+RaLpqmHMLuj32MU/GoxQNdBJyNpICD/Mqyg
	 X9WoLKZnXsYh3QbCktzrwRSLkLAQtOCvh73RYXmNQgj7tAiQg2pb1S59zxWhBcDEvFR+5
	 nzqjcySdiobOUd/a+XHY8gQSNkEB1RoM86jm8JBKJ1P94pcEhXQbYLDFr8CbE9k2terLA
	 OBuIKDqXs1DoLRwm2/vUlMDylqOZrupr3rYzSe0BlLgse5D8kiMqRm7xvFVZU58/czw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794585869;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=JDi24OqDQ8Z9O3lEHsGgkvjEfFHFsvbWKLVFDQF01S4=;
	b=bsf1jEXwkwjTYCUpmRHWYSrZ+O0mOX1cQ96JOqlnAWhjR7F4ocSQfNoLkrd6eufJrvsn
	 KLMwdKUvsB5/97+HEi0rQquLobDB2vW41eBi1NAlYs5H+Ku0Hn+BEZ4nDpWHphi2YnCH9
	 IVlX3qavdCmQg6XEhz3REUKHhkxKf911DQxVBvuQIeQZ6gw4x5UTw6Jfcc4yAAATVg4Cs
	 lBo29s6V1FI0d3rXOqp7G/z19IYT3UXVkg/VkLue9ruaE/Xo+8+8X+HkyjjMZjo6WtDWT
	 nDXrJHc7eETKor8huDP/mZz5YjdT8U43TB5Q/3UgaTkwDCT+AnK2fQ9YIVXosdBd9BA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ap9jUcTT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CBB606EA80
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 16:04:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14CBB606EA80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ap9jUcTT
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-67c02c106e6so1058252d50.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 08:04:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794585868; cv=none;
        d=google.com; s=arc-20260327;
        b=g3FM7N9BJLqunX+BNZA6TO/7rDcWwdMFmWgteNRJvs9K6uYQMCJLZSu5Jp6oIHaD8y
         vzpBiN6AapZudH09V4x8QGam7h15otk6vy497pGuUVPVdR0ku2avhztkC5vfW6aCD403
         M3ZBqPMvSY4JFMefukTv+FuYJKZLX8mUC+ugn2JFcb4ZXNdOjag/hInmHmFTc1SoRpHc
         YSV/QGgMiDgovbfXSi8SASnABr3FI6EwmDNEF8lQN2JbJpA3FGn0sowITT0u4xaPzWn/
         B00MU2j9iKluMGCs5W1U6OxNXbHmgKt/fYa8cJZSW5TUCXs6203bcb/46GNlDUqbtej1
         duHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JDi24OqDQ8Z9O3lEHsGgkvjEfFHFsvbWKLVFDQF01S4=;
        fh=j12A6dFsw4ZaF0o4W2Lgqk52O/Ajryg5H6GooMJyqJg=;
        b=lz36N0J0dVgeZBP5Cso5xvopRFpwC3zKpj46J+fbey4XyTK+u2fNZ+LTnPTCJZnbVp
         H8ii3PGh30xWrymGjVEBQK1qKLon2fMyqJmIL5LVW81xNFaVK3WVr3Sk1AoEhe83qY91
         3xA74MuqPOPp+2u/eM/e833D3gNVo1VMTaIrHzOWZEgTe/IF7vBxcnEAFg3Iz4zXgrzA
         bEEMT4OYGukO6duCHGUc/8UZK1RdrKAceaaZggR73kTpiLcTNDlNJuUWNx7/6mK975Pg
         67cUTgzq0pSnLMCNsD9SBwJsV9d6ZqbYqsDA8Dm65rEI/4kRv0uBy2W6O0F6G1vBR++e
         Bm0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794585868; x=1795190668; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JDi24OqDQ8Z9O3lEHsGgkvjEfFHFsvbWKLVFDQF01S4=;
        b=Ap9jUcTTbj6MJ7bns1OYOhgn6DwRaxgVBuzaKmyyrJcrUePDNBwCD1LIRnyXuYuMXy
         ajlmmDQqufiWVVTt47IFKVDCXsR8Ruz6TGaibEUjvWAtLGpKA3vI5QqAxiPsHaKIvf3h
         uab5Oz/Vigz/9heP8eqolBeONB5xwdPML2/WHFF4WqLQvBvudkjgKlJLJkSatPPjAZ6v
         5jRIp+v5JSdxAf08PmwHFa17JoDNFWpkYYa3zbpzZeX3wfxON1tfacGvxTPs3I1MOBpb
         eEr1CIPmKNBrdCgzuQXMqjSp/U0JFWc/leCE7bjH1WuZlDqo16//R4Cu2T6nF5/Gndsb
         QT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794585868; x=1795190668;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JDi24OqDQ8Z9O3lEHsGgkvjEfFHFsvbWKLVFDQF01S4=;
        b=mmYvlWkqkpxMTkwx+w56gRFCNS1cvE/x149b+epKX4f8it5qOGmRqcc5BPvS/wjVM5
         ZqykchHUNoNYrf6/Z8QYh9SPVjnweWz2vhchtqIhx7j9Ne+nHBU5mnjlC0lHUtSaCBg+
         wyQtSz9XNVHZ/4xul2DLqQmA2pGi3rNmbd6pzih8W0KmTuhl4fcvHgs4Q1685+D/I5yF
         MdoYbr0UyrA/D/4++QO/M7kEwCE6zTstw3o8UVuuzQEtCb+DXdJgKlX3eG6jej5a6KpV
         PtBGzpx29gu3aNrEM8U2w1WWS7JBGbeZ9h89+ifxbFCO6ofx+8W/gsGaJjAKX8fEF1Mu
         aACA==
X-Gm-Message-State: APuU4Z9+a3fDL3x90AWyR3RUMwfwqWLWxcCW9EPSbru4GgQPD4Uif/CA
	Jf+/2f0J/EY+y+Z5PxpyNB2/G4LmCWSQjlLSgPc7YGmrk1Cet0vibuDezhZX8dV9Wj2eGrJFy0i
	T9w6uJslQVr0fs1LsOwcYJsH0IArU8EQsVyqbH8VCkQ==
X-Gm-Gg: AYBFou1xPeUE1JE1v9Klt+pMhz9WxPiZK3MsfAxWZbN5Jz9xRMjGdm/juT6Mif+Rq/k
	4DAu+j3Ly6usFFEnB0YXFH0NA+ax9ZtxtqE+OUoNCSOb0y+LLJBQ9vstGjnuwv2W2jj2QRl2KHT
	9keS/ZGNLJB88+YMzeIR8YPzXPdEfBKhWpkNJfRer5sQZ02uluePrOUmxujPEmUWOmSNFrGRzvg
	CAtb25s8DtRAoJdKqDURE6wIc+fiWIwF9ST2977gyj1njvH/uRrXyDbPvY9+GozGfdRrYiJszg7
	pqZKtB9ge12MEsnRkSTkw4VO2r2RETlo+WXy0oUCSMZC1c2HNbPVBDI8R/r6EKaQUZsvb+9MjcX
	V9Nphte8Mp7lcnoyY+XV2eIShxGwUH6Vq1YbXMTu2Ci7Gkpr2OBEGysfLmRJLjHKB87TOjZZJZC
	ocXiLwhG1/MUaqaFnekDxr2uY8ySZlCO0X4bwe2zYNse2wHLxvh39AQlvseLK6ArTbmnvULxcoS
	IfTEsC+
X-Received: by 2002:a05:690e:d45:b0:67c:70d0:1db2 with SMTP id
 956f58d0204a3-67d896d1e61mr1647555d50.38.1794585867795; Fri, 13 Nov 2026
 08:04:27 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112-svc-chngd-notify-only-v1-1-c7db7ac47acf@gmail.com> <6af68961.ab57093c.3191a3.e109@mx.google.com>
In-Reply-To: <6af68961.ab57093c.3191a3.e109@mx.google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 13 Nov 2026 11:04:14 -0500
X-Gm-Features: AclHuK9CUUB7TDoy3xVcw3o2QwOKRs9z0GsrW4xdlw1TEXGaSOhxwzT_IBQQ0Lg
Message-ID: <CABBYNZLW9vNnP+o46DMV7WzuGSphMEyJdaznhNU-FgEMeUW3UA@mail.gmail.com>
Subject: Re: shared/gatt-client: Fix init when Service Changed lacks Indicate
To: linux-bluetooth@vger.kernel.org
Cc: marianpoltak@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marian,

On Thu, Nov 12, 2026 at 11:13=E2=80=AFPM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/series/1209830/
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.06 seconds
> GitLint                       PASS      0.70 seconds
> BuildEll                      PASS      21.45 seconds
> BluezMake                     PASS      334.11 seconds
> MakeCheck                     PASS      14.71 seconds
> MakeDistcheck                 PASS      158.82 seconds
> CheckValgrind                 PASS      370.80 seconds
> CheckSmatch                   PASS      333.70 seconds
> bluezmakeextell               PASS      100.48 seconds
> TestFunctional                PASS      1199.57 seconds
> IncrementalBuild              PASS      347.86 seconds
> ScanBuild                     PASS      1188.30 seconds
>
>
>
> https://github.com/bluez/bluez/pull/2817

Copilot flagged a problem:
https://github.com/bluez/bluez/pull/2817#pullrequestreview-5894233165

--=20
Luiz Augusto von Dentz
