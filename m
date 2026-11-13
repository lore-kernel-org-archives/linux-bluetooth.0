Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794587593;
	b=Tr2xnHG37gPAQzUX0vl6s7Q7g0tvwrp5ZYMo0NWIfQUS/YhVQqeAqFIDC0+hlfSXyq0I
	 wrAlH1vHBfckshc6gRcDa0JU14lQyeHFHnbA0Arn6kDVqu47wpbyqu+2ZEGTsWxgtbDll
	 JuB4GrIpEdU9NnW2IGct1hcIPZwjpxc1ML54JVmEZfm/GCJontG64OS1qyqlaS8nQi/Vs
	 191vTXdJ1U7HVNX8hnXM7tytb+xDlOB4q6zLrLGVo44cKkzhg4gHEAaMQ3BwbmiR7U5q0
	 +PoQsI5uaZuIDczVfWQ3Zt9UYpEjwxuJ09QY5QEL5VSaVhx9GE0JiIPxbMm36HtXpvQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587593;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=baR+59Y2mE8hUnwSU4h/EglmHTzJDMGvpfXOzUgEWh8=;
	b=e5rEiZJFhYyOm6dW+rzYzPh2W1j49tt+lUdZsHHgo6CusQLU88cfqaB4utcwV+S4Ukft
	 s08dlfXFSFwrzizOAwnxoBPcyrCFrYHbSrxFYgC5gzTvFBnqfNoo+SsVunDQiin0igm1z
	 DnbxJEx7yXjBd5kd1snCgfsZOQ3QCyw7dY0EcDfZjn0ED7V5qYPJYGpEcBH51HnqDuXKx
	 2T7iSEsDonYLiQK4hVtTekXGHqv6xH+G3KTtBizJZB9YJGeCB5S7dsJJqn/ZzywceriFv
	 BemPtUnlPKXcr+AMA6iPcZpk8LeTtelG+yQxRc3Amh2IYawFCTfYBM7OvhzauYJj0Kw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RHvuUNgV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.44
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C423606A32D
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 16:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C423606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RHvuUNgV
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-4ad4072943dso349430fac.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 08:33:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794587592; cv=none;
        d=google.com; s=arc-20260327;
        b=QnBJpKPf12hhF877gH1v9mZZBCQv8ZHfZNAxlXXiBj8b9iU/IEVcC41zKn8egW5fFA
         D2BrPk7Qg9tMp5ESSAQ+slGG9gEPHfIhtph1RGsQgQZfHL92xVIauJJvaQQGpQR4W+l3
         74cJggakTIhnIZyUIgbqI6guhQFWBrH603HO5FJjf+ODTRoCULuB9VK/cI/T/+YPf7HD
         oohsOUv452PtzCFtmK/FvSyMFCUpU609uR1ojU4FOcYefED7AlLy8GD0mO9hGdMln75R
         RHP3nrJcJrApxVsOjVqGdZWALBqTaALrgqRjez5fKa1yq4ahTjMjjQQHK3+A8cAnmtV/
         VNQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=baR+59Y2mE8hUnwSU4h/EglmHTzJDMGvpfXOzUgEWh8=;
        fh=dss+mvtVWWcCKjYBBjtoOwyfdbc8Dj1NBkicxxfSm3A=;
        b=h8l60uJzSB1XyMxG2Z7CKRjgyURB3/pWksNcebBniDYHTuLCyz4exixlYVdGPpC+Vz
         jJICs2hDmpNJYmH7PGF3H8YMOFujiQEmvPYWDZlgQbconRQEJIKrBOyl53ELUFWlbmfB
         w/X0t7rS5yxyheKGnUoOf299tV/8cKsrT3772hb3GByMOCQv+C6wfrJ6tOnce5EElGlV
         ZcdKIcl5OcxsZZjd5yzi5WbDvB88ftjjDlABzUNlPwJTKazHBknFR6bz1JckENzD/xcT
         U9fQEbdNIIs1pXBsmEDrqiyjfbxjEfNyz+ke/Fq/QR5NfArrIsW/b22KO1HJyAwxSKqv
         BuTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794587592; x=1795192392; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=baR+59Y2mE8hUnwSU4h/EglmHTzJDMGvpfXOzUgEWh8=;
        b=RHvuUNgVnLpWg+6fnkM8oTmCd0rIy0NK2+KwghjphMGC0cPbrlftzzG7RYrfi0m80Z
         LNUqDT/aasYMcyrkRnhRmvewVy1HdXJtOb4hoijScUkeBAWb2tjYSGi9K+LAmokvW1hm
         kBZ1VCwuGq4YnNHR6nPUBFqvmOJMzG6cMKXUFcm8EuznfEvioibErYyjjl1KAXQ0Xufx
         /B+ypxxMWtU7xpxRSCt5UTQnoAHoEmnwGbFkDvpBzGhvEVVxixBL+SH179ZLuGev3J55
         8W/VEiUTJF1N/CVn4V8LIOUcu6LIGQ6pO+Zok3HnWz91LAAOsiqvUaitVLgVTivI0aX3
         B71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794587592; x=1795192392;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=baR+59Y2mE8hUnwSU4h/EglmHTzJDMGvpfXOzUgEWh8=;
        b=x109rW2lqxf9mbvQS8Gqi77yxk+MDNEOU3oy44Q8aODGdkdIR2/Va0kN/9V5MLiW0N
         6wXTtg/taQO4YDWkC71YuzV1lQZad0XNUg5c5jDHxL7D+WIfIccGjsXqnKKESY3BeStf
         /gG8DpWLfI7HumrF7mlEpVuXlz1RU4EwtjKBmkFq+CIbPMXzm3uY8GPFde5BQhyX5W4O
         l527A5WkXJJoE/Pj+6NX7ekcOzCotNWRE50+zwgWY45qiG4MCJoTjHTQ6mz0/w+AAfwh
         m/qnz64OlXsautEL6BN/Bk1xNfvdcHvXst5R8LnZihqsMBYaZ2YjVfhipExSbunXw76q
         /xTg==
X-Gm-Message-State: APuU4Z+H3QuXzhLOeCTAfvt4MUxGbmFUCu4zPc3EXxTqw7iWQ9FDescs
	xJoJ7WCPaQVylZTpQKsBnY5IKHPo0zzktyTKqbp4IgRX40uXxZWMvakG5GrDzpQmxH6+pAE8A0j
	jznzXiE0l7UJQnBtPF+LX66jILYuowmQNwCHvdlBAEw==
X-Gm-Gg: AYBFou3BMGFFrSqfiBaY6eUOTKv2SFVWIVUBoV41e9ZkRHk2z4N7junj/yk54A1UE5i
	Co4Y2Sykp+iwJ5K5eGVLiGKuGLN8dbCFZvIzxUtWhQWxYoRdPrO9jYRFldOHf7XWwZAouVDEJqC
	wKBjUfTX+9A046/D7rjNUZa+Mcasi/Ev4U2W8p2J8otYEiq45Cj77i5CM/hYJNxrlRTT9pd4ux+
	U8Cx6kqH3sWnNUSD6pFSRQgUT9Tq13XkuFIxpP2uXz+RAIs4zQqmAJQAcD03OfXLj8YQd1/zyCg
	bzfXVNh51tVYhCFdq0InHVffHsmkloC09OmBj7R78Cj/PMCK09dzLRgQfwjUhZbkYdIimP6hIia
	okj4BGgvbeBsQ0BW3hIPlwUOk0kH/azsmt5UJ9ZG0nUUMJMAPQpGuUbqd0g4ckIIvqtfLEvzqvE
	JjSG05ylh22Zhkw+JXq6m0LxA/fy3BoXwAP95jvH16/0LKomT2Xw8gWVwUgbkgJg/U9r+8yXzVG
	lmk89Cb
X-Received: by 2002:a05:6808:3010:b0:4d6:92b3:5c85 with SMTP id
 5614622812f47-56e6572a069mr2422516b6e.66.1794587591764; Fri, 13 Nov 2026
 08:33:11 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113051438.75230-1-kevin@simpleble.org>
In-Reply-To: <20261113051438.75230-1-kevin@simpleble.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 13 Nov 2026 11:33:00 -0500
X-Gm-Features: AclHuK8J8z426NNJhNcqJYX1NisBL17rLHi8dpfjX68gpC7W4JdCxsOv0Z1wu1E
Message-ID: <CABBYNZKatNkuK1=ontKC=NPMk0aeA=Z0isbZEkQPtdt-6bFajw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 0/4] Bearer.LE1: Add ReadRSSI
To: Kevin Dewald <kevin@simpleble.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kevin,

On Fri, Nov 13, 2026 at 12:14=E2=80=AFAM Kevin Dewald <kevin@simpleble.org>=
 wrote:
>
> This adds ReadRSSI to Bearer.LE1 as a testing method, for diagnostics
> and production testing, as discussed on v1 [1]. It is only available
> when D-Bus testing interfaces are enabled, with bluetoothd -T or
> Testing =3D true in main.conf.
>
> Each call sends Get Connection Information, which the kernel answers
> from the controller or with the value it read in the last 1 to 3
> seconds. A call made right after Connect returns fails with NotReady
> until the kernel has read the remote features.
>
> Changes in v2:
> - Make ReadRSSI a testing method and mark it [testing] in the
>   documentation.
> - Enable testing interfaces on one host in the functional test, and
>   check that the other host does not export ReadRSSI.
> - Rebase on master.
>
> Tested with the functional test on bluetooth-next 3f425f95ba39, and on
> an RTL8761BU connected to an nRF52840. With -T, ReadRSSI returned
> -48 dBm; without it, the method was not exported.
>
> [1] https://lore.kernel.org/linux-bluetooth/20261112032250.37687-1-kevin@=
simpleble.org/
>
> Kevin Dewald (4):
>   org.bluez.Bearer: Add ReadRSSI method
>   adapter: Add btd_adapter_get_conn_info
>   bearer: Add ReadRSSI method
>   test: functional: add bearer ReadRSSI test
>
>  doc/org.bluez.Bearer.LE.rst    |  19 ++++++
>  src/adapter.c                  |  22 +++++++
>  src/adapter.h                  |   7 +++
>  src/bearer.c                   | 111 ++++++++++++++++++++++++++++++++-
>  test/functional/test_bearer.py |  42 +++++++++++++
>  5 files changed, 199 insertions(+), 2 deletions(-)
>
>
> base-commit: 20ffd285b58facfd1f2478d159a5f941b09d5be1
> --
> 2.54.0 (Apple Git-157)

Copilot flagged 2 problems:

https://github.com/bluez/bluez/pull/2820#pullrequestreview-5894592293

--=20
Luiz Augusto von Dentz
