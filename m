Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com [209.85.208.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A353264F5
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 02:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779158363; cv=pass; b=KoHB0Of1OObAlWn5HQmE9JTPBkMDZxe3F79Ua7RGWgEVLHmGl+t6rbfYRnwMwMDbbIrus1l1mgKGxbS6e9i12Uhzv/zMCL1oNY/vjtYR8AHoBajKNeF5L98iKeR5thWOVuc0QnYf9liaZTHlqwvoMrhbP2n10cyy0MwMmBxsECs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779158363; c=relaxed/simple;
	bh=W84MlNAfblDjJCZOfHHy2ydLeD7po5bQR2Fc7gEHsZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mG2kwqDkWwbZgvtLipZwuCn2PNWRnEawBAfaS7qAcntCykyuW0Uv4essklsoaZrpnMBtvMXva5F7w4cgBMFcci+j68SZzcCiQngum2WAhE2uuqKYOi2pQVszLPCm7cS0uKlfmRMya4p1vf48WGVSObAyeA6+bEh/uAgube/fK5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwhPny76; arc=pass smtp.client-ip=209.85.208.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwhPny76"
Received: by mail-lj1-f193.google.com with SMTP id 38308e7fff4ca-393a49d2e5eso28994931fa.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 19:39:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779158360; cv=none;
        d=google.com; s=arc-20240605;
        b=feCDEEbADsUrpeyE8Y17ePfHnCG9CZtfIaf+xT+gJ08IB3qAtj6/pDL6fLLmqKHZ6J
         UJknKAiiVVAnTHdZAa+nzfcaFcFexgCHEVVZmAqIALWliWH/cqBQsjNK6f6DtpfnUKSE
         qWZiZZPrR1YaEeinPSR8zSLxU5iaYrgkuZowUo7LaGK/yM5lVfFQ4VZzmzXTCrPC1YAP
         kt9iN3bO4mjcvqi2Kv5nKPGJd1mzHS2cwXmdLK/ptVLcK59ZW/ZO8usg2FdzGkpzJhtG
         BKhm67ARBBX+JSQL58ec3preN2staF5N3x1axN+njxB9+0AZJOyK0JgCWV9NQr0RF+JB
         Jc/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=W84MlNAfblDjJCZOfHHy2ydLeD7po5bQR2Fc7gEHsZ0=;
        fh=YNYODB6C1VLEItXXtpucUBrwJ24ZtttBt5xst8Zio14=;
        b=Hl3buPdJDfTcsNaMBxtDReviNJ3HOqRyoBhWVqL83B74OuMbtSFh0yxqACT6EzS2v/
         zQGajvqEJ8n6YCb3x94lwPddnjODb3PkA+tRV9+yCs6+61YfkvS9zs0kBAHB2weKNcea
         LNwjF/bQay7gPfWptm42kW5XDOznu7heAUi3biVVvcrSdMXH71rvSVjPovTE+Dw7pnID
         7qiAA3eO4P/71aUC2x23oIE4WIBeEssjnzyLXerp3wjzCm+kmd5Asve1ffhNBbRdS+83
         aeMlMWcNf8m3uOrgUFIKLxm/U8Oyb0v/9Sw0qTUXSeXca8A7S43lAbgTrvAisYG+KYSm
         KtcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779158360; x=1779763160; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W84MlNAfblDjJCZOfHHy2ydLeD7po5bQR2Fc7gEHsZ0=;
        b=lwhPny76ibz23Dvo+sS7gjkgBZhG4RB1wXZpEf4Eu9ETBLiCBM8Y6aGkrWuar+g8vV
         lR6pUKobk4B7X2Bax3eWctnN+7SYWzTvTVMuiQYRjYEkeM51PJ6YamXyFvbSv9hPEabS
         +yweSe7O07DXIhaDy0oE9iOm7Z3uFBRGfKvKQ6QY6MXNT2KNHYIoqK1e2itz6D2UiGkt
         CtNOhDsFk6odfh3n7xaUpmS/u3RVoW0R9aRFo0QEcwuYBlXE+P3YNzjIfwJj+yUoubP/
         XOeqWrrZuRKu3BICnEjA7tybAeFxqCp3epSveBzqxf3j0wzi85qtO8XGkZByUBbhlPgw
         Jqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779158360; x=1779763160;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W84MlNAfblDjJCZOfHHy2ydLeD7po5bQR2Fc7gEHsZ0=;
        b=i+4BMBCnBQ+9as36FhNByHV8Vp/ZmnI4Lj9l8Y9XmqslYmkfYjzT2uUvQoUg+ONC0/
         OfoTQRpAcco0C8QFidE1F2BirZtbiG7IcqR2th2zbC3FAaSLNkCX0tPgTDbzrkx/fJ2v
         wmnvsLoebBW8D6onxX8tIa5ggkV4olN0v3M6864Dkm3GMuFYN2+xNotloTMbX9Iopbbo
         ouvv5XZMYvlcLHV4EgXCbzqNTo1YmZBCISLgV3YowYr2nYEh+8ewsPIRqEm//+cwNkuy
         sEtfg4QddNZVGbeptuK4zEv2LTYHeuw6MHlVm//QnUQF5qw4EGBRftIL6wbGErpEVmS+
         gIjw==
X-Forwarded-Encrypted: i=1; AFNElJ8JwcJFm4/RU6y7Eljt8YFuEz6V4wWh8g0ObiLcA90QsTlf/YEsuK4bMfXrWM+8H2DCZYfYPDbo793ovXWrfpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwCIxINXAcxPjk37ZqLhRe+E1Dp6eL4m/oyZbfchn2yav9F2cK
	QfwcISWgBxcGkMS9TtsJFC2AhHT5oSZiezWcoW/bnYQXYdlW5nREJdoTqnocw7nV5yRWdqz9jTI
	vtnK1kyd8z2q1q0W7G+JJ3Jzk2Ofr//M=
X-Gm-Gg: Acq92OFK4/hOnPRrPDkgblPLHs4Ql5DXAWodJICiFm2sPZZEu00kBlk+sfKC8//5Oc+
	tNeeDxq/HkAouWTgwhhic3/8FbT9YIw8p2dR0y58S6EZ0toEJr9tnEEeaSwVKzhB/ncLfZfJaOp
	v4SExGf4L3f0CcGvkKN3EGMOcx27u7+AqjOXmMCxb82qZoL2r+cWuzbb0rCVJdciJTBxX1jCkGU
	TGubKd8Fir7fhiXdcSJDccMLa33AIQxnVCF7qWzD63sL0X1dblyuh233MWi0MXf634YkpKDFF2s
	zeOITWkPVfevkjVY9Ig=
X-Received: by 2002:a05:651c:515:b0:393:975b:5635 with SMTP id
 38308e7fff4ca-39561d47f97mr51912841fa.12.1779158359994; Mon, 18 May 2026
 19:39:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260516004433.3199522-1-rollkingzzc@gmail.com> <CABBYNZKC+Wr+0_aDUxpc2NmpfkM3_Gb7nvDxEChFPjdQZ0Dk-A@mail.gmail.com>
In-Reply-To: <CABBYNZKC+Wr+0_aDUxpc2NmpfkM3_Gb7nvDxEChFPjdQZ0Dk-A@mail.gmail.com>
From: Cen Zhang <rollkingzzc@gmail.com>
Date: Tue, 19 May 2026 10:39:07 +0800
X-Gm-Features: AVHnY4L6SzYj1whelgSZKA25_Rsgc_6gVklJxEp-T-dSydK78sjNR8ek2wHtAx4
Message-ID: <CAB7XQsGk2BRcQCLvrGe4Z8T5ttSvNodUwgeeKC_=Z+9G4TQdNg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: bnep: reject short frames before parsing
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zerocling0077@gmail.com, 2045gemini@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Luiz,

Thanks for the review.

On Tue, May 19, 2026 at 05:39:00AM +0000, Luiz Augusto von Dentz wrote:

> Lets stop using skb->len directly and just skb_pull_data and theck if
> the return is NULL.

Sure, that makes sense. I will send a v3 using skb_pull_data() as
suggested.

Best regards,
Zhang Cen
