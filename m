Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23AB2376E0
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Nov 2025 16:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763571365; cv=none; b=GC0dxIfNq5WZkq4qT0az3xH61pE4goCflDh12QibjjgGeEVxcdLhopp+X2P+ShbpiGZxhxKhlvL3arNlbs8UzTI0nKHOrm8gOZRwey8kED8QiGHusgh8IU7orutPobkGPHhGMXxMPhmhxw0E3qcHE1oNNZi0BnA3SQNbo8EfHVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763571365; c=relaxed/simple;
	bh=wTyh16gIsXOpmKxWomo5pL+6PuNstZOY3iV5Mc19Hbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TY/5F+HSLq9UyKuMcCAVDvg3T5mJZdQ4xJu3NJgakvIqaodEVL9qLikHjIF2fmrWCV1o+wJUdZuaqWP95My7oRj/w7yZKBPNbWk2jGC0BmZoxXgGp53fGSyppFKcqHDG9B6Mrm5F4fS48Hv9wrY3fQhL+LWjKfJ8OzIcWVcu58g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YwoujDoZ; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YwoujDoZ"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64074f01a6eso2497717a12.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Nov 2025 08:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763571359; x=1764176159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eD+YWMUVpJrK9KKDezI6svtkNq5y/cLTtamXj4+DoDo=;
        b=YwoujDoZu4TGk5qrYLnSX6+guOBVY7JFfCExhomz5Z5g7cRu+sQk83aApKQBExEQVR
         xpYasqI6TuXmOYTg9DX7KJdNZLBDgDi/Yq1I7Anv5VN9FnsdkjAAICbSdS+ZSHZEcCX6
         oW+SSeANhEKMlITLPDgAXcINprcV4NJCv2COQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763571359; x=1764176159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eD+YWMUVpJrK9KKDezI6svtkNq5y/cLTtamXj4+DoDo=;
        b=TMeMYKjoGoJ4WstDatcB62qQ9Hy4fHaLVEAE9SbhcO9pS5Hl7ZCEX4QAJWEq4fQM5f
         D3w2Pv2s8WaHRP/s5jzVXFzcJQPhYN0J5fjrUwD0KkKjmOCX+JELTj0o0p/PWpYX0XBN
         B3ju1qbSdvT+IA6w77JuJufowO/76z5jaMuhpEtkkn9jU3nmdLliZMqP0aWH8QIQohqJ
         Ln10jjhEQFFU5fgSyaJDbeBHB3SsykZWlnDp1lVzZmckVoGTtmkYAnjjY7moLpQPgLZ2
         UK+2V7SaoZ76xGUMk7je5M1Cq/QEUMPrQ4KfiM1UAOTskphl7LRQC90fnnDzcefvdjly
         bqTw==
X-Forwarded-Encrypted: i=1; AJvYcCVaTxcHSsyj2QM7+CqTWDL36167WZzCq7qjgccb5OUm731dJXKbFgf6okRrETSU9JI9fcWuZw6TjJyC6PnWXHk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3QXOiuDmyPtv7lcXQfT9JG3hK6sxEj8Izeevk0AXVjHHQcb1m
	+EPh9TMfYLs7KUl2cHLD+V9cWwwcZV/z0+qkgWTOK82rviojkLrQepm3C3y1XYVhjbJLS/i/P1C
	vOU58tViL
X-Gm-Gg: ASbGnctAJvTzwSYfSZv7aLgvNqlOy7udFnDEdilqeO4rt+mzL4hPFAXBzIMO2w2aPBH
	K2zovW/0iscla1XMdWWWeO1cHIs7fVMhkYVUlTOzDxNULBYybvF4uzG7UXkcEtSgVClADIoE0lT
	Riz0N4tNax0dP8CF+4XXG5OwUPyTnZNTr5ZgIlvtGtApVyQSvq2ZPURYpn2J4GyyeF5TZXStBfx
	kWxFGDO4wk0Rl9e0r2+0h29VDwkRZAaByPO8P+SpBVexr8A6EqFf7EaGyZHvVDzoBKAFueU8QM/
	MNKD6aW4qVo/VAMGAEvUHusVmLE+4CYz5nrkRiNqgbjonStSMgAcaX7wzlHAAJAkflWPS9nXApa
	JfvTFL3V62DY5PqrUISfMyMWsU/5DM+mmmN0QGdH9+ZLyf7J80I/QCxxIkRiWQ6q6m+lhKok/E2
	bm+lSBbLk68omdmys+r2EsdhaJTl412wlHRg35NW6f9uFsl6PsT2DS501gJt0E
X-Google-Smtp-Source: AGHT+IFammNNQsrfTAltg/K4db7980WIUmyFG4jeitq6bTOcz+WYZUwJoPuZEEZquSNaVWOH/j4DGQ==
X-Received: by 2002:a17:907:3e24:b0:b6d:5840:4b43 with SMTP id a640c23a62f3a-b73678969aamr2259674566b.22.1763571358988;
        Wed, 19 Nov 2025 08:55:58 -0800 (PST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fa80afbsm1640197566b.11.2025.11.19.08.55.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 08:55:58 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42b3377aaf2so3915190f8f.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Nov 2025 08:55:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV0PYsoFWmwWzaHHO04uE/TURPa1GXp5OGIrCCWPrXcpGmmSmSjZc+qeNXjhQwUK6iAM+ezUYJ3v0SBpGklxR4=@vger.kernel.org
X-Received: by 2002:a05:6000:288a:b0:42b:3cd2:e9ba with SMTP id
 ffacd0b85a97d-42b595a48b6mr19864079f8f.33.1763571356370; Wed, 19 Nov 2025
 08:55:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <jOB6zqCC3xjlPPJXwPYPb4MxHJOhxVgp380ayP7lYq-aT2iA5D8YCdMeCvq5Cp_ICZmqjpfgX8o9siQdlPu9DY4qgnL_zCjgqP23fXc-P4U=@proton.me>
 <1b59d3c2-1ed0-40df-a3ba-cca2316e866b@leemhuis.info> <a03739b9-3a54-4ecb-b55f-6aaa69da3fc6@leemhuis.info>
 <a380d061-479e-4713-bddd-1d6571ca7e86@leemhuis.info> <CAD=FV=Xt58+WGK_j_TvTxpUfXrm-=Cec1-oodkuf5xiDGrsKuA@mail.gmail.com>
 <T4YKnjuw-ZdA4uQjGVxQh-vqahAK_69kn20zfC_8R45iOxbdjo_tlIDwP5rTUyjn3NVUHYhG09VO2ryFtfLtgptBBhfXggFNAD2CVAwPcjU=@proton.me>
In-Reply-To: <T4YKnjuw-ZdA4uQjGVxQh-vqahAK_69kn20zfC_8R45iOxbdjo_tlIDwP5rTUyjn3NVUHYhG09VO2ryFtfLtgptBBhfXggFNAD2CVAwPcjU=@proton.me>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 19 Nov 2025 08:55:45 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WDx-WcosBWf2yd3sLx5pEyjOgbs_Y5RBF=+b=0q3dBww@mail.gmail.com>
X-Gm-Features: AWmQ_blPC7GadakNs8qCnRJFHI35OugoB7NfCXE2CsfE_EvbaJt_UoALfZIaz0c
Message-ID: <CAD=FV=WDx-WcosBWf2yd3sLx5pEyjOgbs_Y5RBF=+b=0q3dBww@mail.gmail.com>
Subject: Re: [REGRESSION] Bluetooth adapter provided by `btusb` not recognized
 since v6.13.2
To: incogcyberpunk@proton.me
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>, "marcel@holtmann.org" <marcel@holtmann.org>, 
	"luiz.dentz@gmail.com" <luiz.dentz@gmail.com>, 
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	"johan.hedberg@gmail.com" <johan.hedberg@gmail.com>, "sean.wang@mediatek.com" <sean.wang@mediatek.com>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 19, 2025 at 12:05=E2=80=AFAM <incogcyberpunk@proton.me> wrote:
>
> I can confirm that reverting the commit `Bluetooth: btusb: mediatek: Add =
locks for usb_driver_claim_interface()` with the following commit details ,=
 solves this regression that has been present in both the stable and the ma=
inline kernels since 6.13.2
>
> Commit Details:
> - Title: Bluetooth: btusb: mediatek: Add locks for usb_driver_claim_inter=
face()
> - commit id: 4194766ec8756f4f654d595ae49962acbac49490
> - [ Upstream commit e9087e828827e5a5c85e124ce77503f2b81c3491 ]
> - Author: Douglas Anderson <dianders@chromium.org>
> - Date:   Wed Jan 15 19:36:36 2025 -0800
>
> Reverting the above mentioned commit and building the latest mainline ker=
nel without the trouble-causing commit fixes the issue and the bluetooth ad=
apter now is properly recognized and bluetooth works flawlessly.

Hopefully fixed by this commit:

https://lore.kernel.org/r/20251119085354.1.I1ae7aebc967e52c7c4be7aa65fbd817=
36649568a@changeid

Can you confirm and add your Tested-by in response to that patch if it work=
s?

-Doug
