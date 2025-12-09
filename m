Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FE079DA
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Dec 2025 04:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765256173; cv=none; b=nABkiQ2dIjBcSoh1QX18UZPluUiLnrwRJ3aXGa3LzW/dr47tScqe1hSY1nTh/6EHLtNZWxSZ6cnuljOlZqOnlYrXsOp8hP4IU21XptjGXRVyiAU93HccgovggmHUZjqmpxdyBDS+AYQWzk9M2cBoY653TC7sLYO08mexxJV2dp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765256173; c=relaxed/simple;
	bh=ZuEO8GziloCVHSZeMwwmsC/Auou1vnNdrkIUIREjy+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bv6pw3Rk5AcFhw2HsvI+nQn4gmO5mE84VBZiF3y6OY0rqEzCYqICJyKPfuJomclVpC1xe9YHk9d+17B1offyx2Ch/o4YQWMN7Ywx2pH6CxGBBdaeYLsfbpwzIh1SIEDsOMFUoOfTSL4oloy5XDZXzqddmdw9aL6cH316zPk7CDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmXBrKna; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmXBrKna"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-63f97ab5cfcso4298322d50.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Dec 2025 20:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765256171; x=1765860971; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wXxpbO0MpKdFuAUzH9yIxsrnj05O3Nl98kUfu8xmn1s=;
        b=bmXBrKna7AXAsrAyfpFp96COA/GA2N+95GPq+QEspKYxTPsdq6qQk0KGWKdNnyC1aU
         NZsk5v244m0g4k4+t/+qolVvKyNZz8QTDUr0wCeShxvoVFVmxP3uH0LUbrI6vGNZ8v6K
         7dIs0L/rT0XzI1DhYlgBFyZqKM8vHm7rL5sxSCmTLk3yy7o6DQheZo53XGww0parVIJa
         f8K+MN4Ktz4GflwSTiUWz4axC/lYCn1gJbJvjbaan59LHS8QNoX74jy0GgwinS0VrHZw
         q5D3vZlih7sKq0gv9UocJ2uCXkBRQ87f3TkzKWXVRuh0yYzJcGcelDfdME09n7YDQJkA
         mvTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765256171; x=1765860971;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXxpbO0MpKdFuAUzH9yIxsrnj05O3Nl98kUfu8xmn1s=;
        b=HTLMfv7JBKthwt6uoPlSouKNTVI8MMvqjueG4j2f71+lEKaC9YXG7ayWG8PgMX+qWp
         I0hsBwdS+UBjPiW9R46xD5VNonVlx0bChe2tFJhvvouYAwnKCvUAikbLgGxU1kq+ncTL
         ieaLFtOgOtChvtAbN2/3zeKHGkk1ccHbZT28YE78yqFzMKrwQ6x8/C4xtK2tk4AxmUOY
         R/TcE6FVYNXaq4Hprlz5q1LYADHqa8VPvTcvIgbVl2cdBJkvzbEQve3VrRdpvNDODWNq
         fTT9G6cv1dxUw9hKNBfUfeeHUpnRI/UJz410oaogq5sLvRFLw7SlJ+/PNRT3LmvDl41p
         Icig==
X-Forwarded-Encrypted: i=1; AJvYcCXeNc3pket7R2J7w8NK0UIyxQOFoyl2vU85JoaswFoRPxt71MD8voNF3W6v0DaTAvMQNgy450lDMitCTMjQ0mY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx+YbLA9SsTmlc0sn5dWS0G7oyq5V2VMYw0KrCeqc7jyhCesnu
	KxFrmcAIg1Yzg0nCpVP8Cu/TF5fffIRKIuH7oBsh1EZWkvEoJznSzuDyf0G3unrRM5d6Pk6IksG
	HsyY5YsX4OhyRzUrwahhRVH3vXxyx4AlHyfMz1sBtUg==
X-Gm-Gg: AY/fxX5mM8Ph3Q8Ye8ZSYUKSMUL+xTSN0G746QbCskjH3ZwdsiMTm/ctRUziPXJdn9C
	K8EQvsQQwJjKxVUqXZ7c5aPYp/Qrd93EYaPLXQU6qONW58M01qbIK6ajL2h4rE/rSylWLfxvAlC
	qECLxbaAQ8gsHO2+WSNj3xQrWVrHfrBoc0UwEnqrweprugJKBgyDIlcfsuEHClZz8NzxcK0WxXL
	R5cS3RoMy9MKw5xLOW89GQzxyUQ8xVtebQmndj1yYqYymD/ifOKlEu0P5nzV8ZPp8N8zRncjt59
	z5S8
X-Google-Smtp-Source: AGHT+IExnYNZFqx+28V5tVk3hKR/niQ1jhvRXNpegU/jVnKn612w/YxED5hz/v/SehZQKG9DSWGBC3D7EvvGIANZ9O0=
X-Received: by 2002:a05:690e:4102:b0:63f:c019:23ee with SMTP id
 956f58d0204a3-6444e7629a3mr7916808d50.21.1765256170866; Mon, 08 Dec 2025
 20:56:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208095508.3481977-1-zzzccc427@gmail.com> <6936ab2d.0c0a0220.11bcee.8d68@mx.google.com>
 <CABBYNZ+2PxLJvbW+HuoGMcjFBh+=riMRKBXisRrZMvQRMfC+xA@mail.gmail.com> <9c08ba32021d20eed11c50ee5790c2ede5133f12.camel@iki.fi>
In-Reply-To: <9c08ba32021d20eed11c50ee5790c2ede5133f12.camel@iki.fi>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Tue, 9 Dec 2025 12:55:59 +0800
X-Gm-Features: AQt7F2pOU_bT16INjA80jsaF7cxlSvdv2AtKvnZtVIXU24oz2_JRbTdNN4EQ790
Message-ID: <CAFRLqsVsjA_1OOw=3grdPJm7V8mQ+Pa3WJgQHns=YSJjjw_VHg@mail.gmail.com>
Subject: Re: [RESEND] Bluetooth: sco: Serialize state check in
 sco_sock_connect to fix UAF
To: Pauli Virtanen <pav@iki.fi>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

For additional context, I tried submitting another patch:
  https://patchwork.kernel.org/project/bluetooth/patch/20251209025945.3555605-1-zzzccc427@gmail.com/
but that did not change the CI behavior.

I also reviewed a couple of other recent patches:
  https://patchwork.kernel.org/project/bluetooth/patch/9e5172cb82b9d4d130d83d9fc6beac9e496227c1.1764875787.git.pav@iki.fi/
  https://patchwork.kernel.org/project/bluetooth/patch/20251205175324.619870-1-katharasasikumar007@gmail.com/
and they appear to trigger the same lockdep warnings in the SCO Listen tests.

This suggests the warnings are pre-existing and not introduced by this
UAF fix.

Thanks,
Cen Zhang
