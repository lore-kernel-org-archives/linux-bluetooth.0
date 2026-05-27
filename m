Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA603A63EC
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2026 06:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779864113; cv=none; b=X+FgVJ9wo0T6Bg4v4d39pOW3YRJBfeyPfVBmFwV5PKY9xSq+ZBdftIbiAIqMnJD0AucWzmIrLGlCKOCBl+CIvcw4CTdl74rTLUvL2Yf+Pnr1Z2otb1+QuaIVy9V5H/JP4crwJxnp4/n+nr6tyFM935w6ZIuv1tuB0bJTqsLRvlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779864113; c=relaxed/simple;
	bh=4SUdAPoJeawFSI+/Ysute/BznMFHB3UqTudNdnen1yA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DojiRWsyzXQK5z2cX6p60VE6E+XuohL2BLW9GLV32Cj/5J2nygHjCf4vaQoq30OhOH3lxTBCnyFUvA4SaZDFdeH+Xo02aRNWhrZkKCH5UamZF1ouzIv17c5hvfzpPIluxF9yyUjhGqw9bIPMqt12KUme2kJmV6S9iRJf9llXmAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqnSdLNc; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqnSdLNc"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51306c9f2e1so133726491cf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 23:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779864109; x=1780468909; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ifX99mAPrfpKnKYO6X7fN9WKfW/9h3Sx8Aj+PJ3aHiY=;
        b=WqnSdLNcTOdNW7WGI17ioYF5ADvh1HrPX9E//v82LKX0j7CqQXH/eCeWBRzs8GyJPA
         axki2YwS2JqZOxOzxAeXFvT4NOudc+zpCz2E+12dM8NF7kKuL+PtC1WW+Vu3t3LscZeK
         QT9thTVPYUJ5o297CWa3w4lH/+orJlvNbeCTQYm/+O7VaeaRgq1vT+cQ7ZE3qpmaP/xX
         tGDGDkK80LommnkBfBAvYFB3958XmZVkhaU9U4Rl3MOG6yNyCFzevJ9TMQUj9HWyYyRJ
         1iUUUQ7xOZkHF54rLNnXR0v/p2bpf1hxGd2+mhfnuOVbhw4BFRkkKCJo73POiKQ/B4RG
         L3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779864109; x=1780468909;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ifX99mAPrfpKnKYO6X7fN9WKfW/9h3Sx8Aj+PJ3aHiY=;
        b=oMLO/tmFuiV3+jOeswzh4p3/xBAHbHvU2n8p1MbiRRjk665pV5kkUQ7gDZWAZOavHA
         7YraVckcFZnb2A6wKHONlTq65gLFiTGuezuAEuElJSH0h9FxcQXjm5aTc9f/7F4dlwhd
         9H5XyuFu/ZB9L/Jv9QmUAwCxbddhHNPxCOdGf4mjoa68T2bJdwA9/BV1y/uMrKwPTtFh
         NoESg/v05YAe7jrBKjjYU/epU1wtPL5IrSrMmnoFmhm8ua6nADMUtzsngxUPjQ3kr4Rq
         HSu89jkP2C/iDTmAG/nVOob7d5xqXg02d8g9LFwH9bo6C3YmLaQtaDCc7zp1wpHK5B7V
         3J4Q==
X-Gm-Message-State: AOJu0Yz3zsJOhA7EtUc5iLHEsKg990CddkHHvoPKJkS8iXlXkZ8KjjMW
	myYqXxbXXX01oLDOi+j0tIpv50KUVj9Cp2cpbn4Wz7fUzVpNST7kbZmmAjV8vA==
X-Gm-Gg: Acq92OGg+xr1UZqcBsRqBp3e4gFaEhVlC2deo4O+LIdZIY9ygFpf5cpYtq9xAEdASVe
	xmSH7tqUF6430q9aAntUDILDn95gCk+IZonM6WmBKjUv3fVV2RNmg+0ay26iin31G7aPOC8Bpv1
	ko7mK3vaiVDptV/AqJU0EogB1FQmXnN9pEcGchZzGHxpFa+C9Rv3jaePQKJFBRLXoD4bCKFqwlv
	LwrqVD92UYQSavKKUdi8sg8yMJ9X9BuAAx9fjltQV9mmka9VePy1G6tdLeMyOeiHfm3pC0RVNrA
	/9dof4+JHUX9Okav8N+2wdF9j/2n0DQsbPlUicpIgaqxa7NWfCzvRO/WH617JyG3QQH103paA72
	PIzTxIU02rKvCGVQdjWJpEviZTVWDzmrkltId45Y+CEmDf8Qh5PXzexqK9yu5v14ZWZ3Mnh52hM
	kB9xscB/4TuAhxuqMeFDGflNTw0cx+
X-Received: by 2002:a05:622a:408d:b0:516:d8c6:3e6d with SMTP id d75a77b69052e-516d8c64390mr308225621cf.39.1779864108884;
        Tue, 26 May 2026 23:41:48 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.95.96])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517069f2464sm36037341cf.2.2026.05.26.23.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 23:41:48 -0700 (PDT)
Message-ID: <6a16922c.d9dd1dc9.515e1.32bf@mx.google.com>
Date: Tue, 26 May 2026 23:41:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4770390701927697576=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, meatuni001@gmail.com
Subject: RE: [1/2] Bluetooth: ISO: fix UAF in iso_recv_frame
In-Reply-To: <20260527045919.39077-1-meatuni001@gmail.com>
References: <20260527045919.39077-1-meatuni001@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4770390701927697576==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1101377

---Test result---

Test Summary:
CheckPatch                    PASS      1.58 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      1.16 seconds
SubjectPrefix                 PASS      0.25 seconds
BuildKernel                   PASS      25.09 seconds
CheckAllWarning               PASS      27.91 seconds
CheckSparse                   PASS      26.59 seconds
BuildKernel32                 PASS      24.64 seconds
TestRunnerSetup               PASS      527.80 seconds
TestRunner_iso-tester         PASS      81.16 seconds
IncrementalBuild              PASS      26.12 seconds



https://github.com/bluez/bluetooth-next/pull/248

---
Regards,
Linux Bluetooth


--===============4770390701927697576==--
