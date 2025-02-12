Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DB5209663
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 18:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739383847; cv=none; b=LDoYFLVPGQhuSuS+3joR9R0jpOlGxLggCPsITPGJSUjWZe2lbEw3M6B9/5tpPoll+4JkhVPYIIE5tzmflPi2h0dTJKNvg55YtACJmxiBAVikwuqrvbzhcPRlBGZP7oTMH0QJmn9k2Td06xBK9a8gIIuKOP3lYdivJDV68pC8NNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739383847; c=relaxed/simple;
	bh=FXRryJrNmUGTAbO3yZ/ilXzREtiBfeRhxCtThn3lrBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=na5/6MYP92A0Hz7bYCgMuh+T7S0GSXolpgneH5ot7lQCHKRjNtifiM45I+hXk1UPY039CQeFebFD113Q40UsF78P4LMO+1yKyRZ6VdYiJwoaiH0/U5eIc9pgq0zVoXcXsdPgExOZ+dZFEwgkh1/w74HuxBwuIH8/em0U+PM5kQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKjisimz; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKjisimz"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e4930eca0d4so19303276.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 10:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739383845; x=1739988645; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FXRryJrNmUGTAbO3yZ/ilXzREtiBfeRhxCtThn3lrBU=;
        b=jKjisimzPZz6aa8nvA7G2tj6H5AHS8j9vYz9aBI+8YK6B+E8ikY1bTR206j9YRWA3P
         wzuzDO5v9wi7aqRqu2yc9nCDoVahailENWN9fPdMabJOkkvLLgEAo5SWyEZW2o7saPkg
         0gadtmVlx81xRiJ+QRpmgrTSsK+z++qFjYDxdrDi/L00vZbpw+A1XATc09HZHV1NDBir
         5e7iBXuu4fAbuZQYWzrLlRtUYGtnktTmaMD62pbypGj1Gwdc9JlFYuYfdkOy2PkXV+E1
         Q9heSQuzM210XjP0ILFymz+j/u+jMQYsow5WgMEZqxKBNNzVr4sbHWQr1L6Yae53529p
         MMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739383845; x=1739988645;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FXRryJrNmUGTAbO3yZ/ilXzREtiBfeRhxCtThn3lrBU=;
        b=NQIifzQfy0aaMS6S2DTQTruvDlBOsusWSKtD2apP0SYpevveqZRsJo7h/XB+Tizxz0
         YNoPsKu/Sr6jqWl9VakmkOoUTRKVXLIJ4K7aXx4VaGu3AtnEYVaCNIlD5q/Z5edPdgc9
         a2b7fUN6+fEhXK1iAXFHJK9iFNRnWhLonbOjG/GxszGxyiD2PYWbzln87doeiqVo+rvT
         PZnHDPO2GPaa5iM7JQyquQw2gbOCcy6FU2K9LAEGULLa07+At/Y0GrSb5BBMI/ht4v1+
         /jWDrRUKJH2SMVheOranBeYZV60lOVrMq1RpH5pc3fgnkWfQH2xjguQlow8UFKiutrgA
         wddA==
X-Gm-Message-State: AOJu0YwsWzc/musWv95+wyv1vOd6B2PQGP+NtBUrkQvMRtVHtm/6pXX2
	m6kodnKE05jcaedGYnpJ0do8jNOFty1kibUM0G0byyENTR9vjhEm9L7WzkUHuev0mRe9J0Y+4pC
	pAD47hoq+JUPDXNlMHYZEyqdBbFQ=
X-Gm-Gg: ASbGncttP/Kcvkzu0kxUG/98iLzC3WI1GQbGH3+9RcSeIPrjQBAdsuP1Kkn8ep5dX43
	NVJ1NHdWgFJZPaePIaJiUUgc2YhBU+56tJnQ4GKuObFtaYdvuaLjwCgwm8ybPV6ldWJIny8aRiQ
	==
X-Google-Smtp-Source: AGHT+IHJjq+oJ9mJuu87NnRBLdeO+blpcq1F5D6NO/ZF50qzlmH5Hb/AvU9UhldCzbQZfJfXXv33Z3dyknzSaEbFtjo=
X-Received: by 2002:a05:6902:20ca:b0:e58:a221:3a9 with SMTP id
 3f1490d57ef6-e5d9f17214dmr4595675276.32.1739383844533; Wed, 12 Feb 2025
 10:10:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABBYNZ+SYtZ48Rc5mife8bLV12ri4EvqL7QDJLnxuSNBmV46rg@mail.gmail.com>
 <20250212175427.131356-1-arkadiusz.bokowy@gmail.com>
In-Reply-To: <20250212175427.131356-1-arkadiusz.bokowy@gmail.com>
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Date: Wed, 12 Feb 2025 19:10:33 +0100
X-Gm-Features: AWEUYZlz2PUyC9PsCeH7u4YrKX2UUztTr0OZnMG1Foc4hqBkp1Uq3y4Q6MHsnAM
Message-ID: <CAGFh027qyNyE+h3g+nxLy8A3eXyAE3TDYZGXGg4sRwM8XUpMEg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] btdev: Broadcast EXT_ADV packets every 200 ms
To: luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org, pmenzel@molgen.mpg.de
Content-Type: text/plain; charset="UTF-8"

> > No, it's not an optimization for my particular setup, but more
> > generally for CPU load. I thought that it might be better not to run
> > advertisement code too frequently. But I guess that lower values
> > should also be OK, e.g. 100 ms or 50 ms. There is one "issue" with
> > that, though.... Now, the advertisement packet will be sent one
> > interval after the advertisement was enabled. If that's indeed an
> > issue, it can be fixed by calling the callback function in the moment
> > when the timer is armed.
>
> I'd keep the initial logic of sending the advertisement immediately

I've fixed that in the v2 patch.

> Btw, make sure you run the testers to confirm you are not breaking any
> kernel testers.

I've run the test-runner to verify everything (--auto). The result
seems to be no worse than without my patch. What do I mean by that?
The case is that I was not able to run the test-runner on the vanilla
master branch with 100% success rate. There is always some failure
with my "setup". However, when checking only the tools/mgmt-tester
test, the success rate seems to be higher than without it (but it
might be just a fluke). I run it like this: "tools/test-runner -k
~/linux/arch/x86/boot/bzImage -- tools/mgmt-tester". Anyway, I can see
one test always failing - "Read Exp Feature - Success (Index None)" -
it happens with and without my patch. Also, I've verified that the
advertising broadcast code was executed (by adding some prints to that
function).

To conclude that, I'm afraid that I don't know how to run the test
suite properly... So, my verification might miss something. I would
advise you to verify that patch with your setup as well (if you can).

Regards,
Arek
