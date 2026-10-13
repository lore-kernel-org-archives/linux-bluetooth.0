Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE02379C56
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 03:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791863768; cv=none; b=eSN6rzz2+cLn7lbh0V4iYIrXrvoQaV+HpxnZ74j9hPXa633gsreK3mcqVoSz7QV8BVeQy3xmdYhMR+zYlrumflJ6sW7m6ZEqUsC+XydqP76NNRccxV8YuUpG7hRiSiVwig4y3RaMO12FypCQhBzEKk1a73An870TS1vKLhI5+mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791863768; c=relaxed/simple;
	bh=B9af1vryC0Zr0JpSEzjvtJcbvAHvF4PqJ5O2atxTz3M=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ogM89mflyXXTyQ3NCW6IJhGg4LpNCQmStV/OA/PSxiymdYS2226nmdlshGpY4C7aJuARFPfhptcenDqWaJRgI/v4lagHalSUwQNG+pmeaJba67rGigRa0i+vEXdJWLHmjPs+yVb1HcPHp3dwIK9eNQK8qFeyuPNY7qLgcQrBYNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjO+U0as; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjO+U0as"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-917a20e9efeso37306546d6.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 20:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791863766; x=1792468566; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=B9af1vryC0Zr0JpSEzjvtJcbvAHvF4PqJ5O2atxTz3M=;
        b=YjO+U0asScHEGSCbXOMLa/b/kP7wLZDsuhZAprvjZbSv2lhwYoZkMtNiNWk2XaWya3
         e/nh5ewrump+Z2crup0cTrP9c1FmsUkDsJjm+KKbIAVo713zLxvaY3lJ4YIz0NkuHhaA
         a03ikytnxrs8QNg1tRz3Auouni9Dl0Zw+NzTJM27xXFvCuDJFAdcXSwVYjasejqsO/n2
         ygI1XFuqk5n0dzjinYxU8ImkqkTmCDGKcTusWez3AxmcgJ6wHR9cZPCF8EKwnF75eH0r
         f1gbWenXDfXWw/aQRXeYmtVC9uPSBmco8mhaA/au4A1IbnWAFzOWjRJxRu1m3KyQ8Ce6
         70Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791863766; x=1792468566;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=B9af1vryC0Zr0JpSEzjvtJcbvAHvF4PqJ5O2atxTz3M=;
        b=Evi1hHhyv5jMsYKRy8Wo29A8IFQQqXTr71IdKuEPsf+OzPHUvyCzygKiBI5xQhUyyX
         vlB/TpGegyCnRB2Cy9gNoDveILk8kApFi3bIWMqpwpHSn/CVlS7hzshQRqMbJK8xD4gm
         gAHitI98ozIAFkUxPp4M/4CGWZng4Q7wHvaT/U7HNOiy/88Go0Yg8ZZYRYE+YM+hrr3c
         Y9s4i7oi4UW+9iUHyyvPw6k8tWAGy9pjiUduT5FPmqMKuwh+c92lvDIcN63Lh6DayH2B
         gl/JJDLpfTgrhaTlCVZnvdUe0o0PVhZckdvf1cAjgNjh8+eEDqNZ+vXDFB8KOaGfhcwx
         nT3w==
X-Gm-Message-State: AFq9FYKVyRpsecvk9nfgh1YvJ1BZt/6IsA8zuxfKKdDPuC2xv2EWWxTA
	iD3N10fJtGjaCymzY7wVbQDWzFhpZEeL8AZp0HX6zqk0tnU7CZf755JYj/CwXg==
X-Gm-Gg: AYBFou1BNDOkc3sgXj7hsfZIgsp+1BSmaV7dpJBFbq+f61OnZ0VExSCzD5+B/HkC1Hw
	POQ0O1hzjlZTcUEzqz75A5/NMmxHdUkwlq4K69vMaml6MCpNYPyEkRniVcaYtVh1wuPpdrHHP4w
	OJic8fdJ75qkQemyNOo7yipe+f/g+GCk0yxD/LvouHR1JMy3NR5e6FRjA0Hf+bCTsoNzao7rsR5
	z9oX1D1uOes+Y6+8IeaDNsQmTCVbf83UXEWd8SStKf2ZEdtbVGf/FUinIDWJVyxdU8+cyZsmn3x
	1m0VQ7tD9qH38Wxd4lTvmsyFyIKFvdtxmwsCuktv1qSNkRKv39z4BIJMry0g8QHb9e3dP9ToBLD
	bW8pVvGb6PWhJLnnlGR4cHq8sCuhesHMoTuMH9Ad4wJC4azaVPvIGvLCELhW+ZXJIBW49PskbY9
	E1fTdvBMSfmXcEDeut2ZVt5i5iDlb1ht0tLB+DB4kkLk5qCyM5MAlaDqyPTjInSiknLbPbm8+hQ
	tG/71LwwZmOiSIDuOM=
X-Received: by 2002:a05:6214:ca4:b0:91b:5d3a:f130 with SMTP id 6a1803df08f44-91b5d3af48emr189877056d6.47.1791863766336;
        Mon, 12 Oct 2026 20:56:06 -0700 (PDT)
Received: from [172.17.0.2] ([172.203.254.210])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b9bda8643sm7686916d6.25.2026.10.12.20.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 20:56:05 -0700 (PDT)
Message-ID: <6acdabd5.8985da9b.14ceee.b507@mx.google.com>
Date: Mon, 12 Oct 2026 20:56:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1861458460166880715=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dmitry.torokhov@gmail.com
Subject: RE: HID: Hardening report validation and unnumbered report handling
In-Reply-To: <20261012-hid-core-report-validation-v1-1-e0dd5cb60b2e@gmail.com>
References: <20261012-hid-core-report-validation-v1-1-e0dd5cb60b2e@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1861458460166880715==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/hid/hid-multitouch.c:79
error: drivers/hid/hid-multitouch.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1861458460166880715==--
