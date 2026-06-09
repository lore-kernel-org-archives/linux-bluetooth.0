Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBB03CF1E9
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 19:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781031898; cv=none; b=iXTaoa0CmKY+wlfQq3W6ebi6sJEo4jx2aQ/1GIqtSBwh3JFvCqWVhXVRxxU6tpB28L+CxtMZf8XrwbbC83Sw7IzR9DAovhlmJKkFuSgmrMOBJb8K2Q89tCMYhM+IoVO3SOLK9wKAkz2gY5e7xDlAiQ/+x+rsskXzoCwgelzZje8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781031898; c=relaxed/simple;
	bh=etulXDzOe4sOMEFadW0vh00LulhfbzJBd0J8Waj0/mA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Yui6bfqu2zUITnLrAarAOJjTPreX4e2pcQl1+SsAwTZ1ZqvhQ1ObBfjGPHnil3QG525SIs3UVPhEJ95c53OJEezCGVxPgWdvwcgoFnY9A9VPD/XErRqRPAT1opKwF9vZvXrejUjvGv12QLbudfXaO2lE95TlY2HNV78XsJ4uSmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0OAD1Ep; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0OAD1Ep"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8ccf181a52bso55900276d6.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 12:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781031897; x=1781636697; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=etulXDzOe4sOMEFadW0vh00LulhfbzJBd0J8Waj0/mA=;
        b=V0OAD1Ep63IN8BMjjuHLUPRGlnFyNZ4WJOcQ94gAj8m4OnEs0imQ133VAb6kvCGAqI
         GHWQz4H7N2EvBmTKrC0A43DjGPhzoto3AIX7Y2AZ+aBk/WyBincLBnhu+f8LdpI/jrOS
         McU9zBvbV/Ond1sacRIR4lq3yVItutlZB1xajDMRd8/c7neI+Ii1JnSQujAlfedIdcLN
         FtIxIFNblIVVgBtf2QaP1KZHFwa0IkS5IkSgoC/09vx7oQPiNf/pV3X7D0CxWw5Y0zwX
         hJcWaDPLI/PVPZ1GvnAoMVBOVHBqQd81bDEP6voc6Jxjd3CMSqs4jNjA9unakvvcVIPw
         ULhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781031897; x=1781636697;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etulXDzOe4sOMEFadW0vh00LulhfbzJBd0J8Waj0/mA=;
        b=MWWF0RlF94Ck2Smu8VQHBDKr8sTIH3pCDUb2cZ7XxzPKntek0UTOgF3HtZlY3OugyQ
         tGS2JGCGr/tUq1W2QEJ/X+nWDIXx75U0S9jUfGMiBbhnqctylbGngGgDjEIUpYuKpVaT
         XXezvUMRPoc9tqf7wYBhlzkYhZriHmHbJw42Zqi/CwISH5HkF6WZ9lEfmXxbASJOlZAX
         QDiA7Y66/7cQSuuaEnJh/bud10lzy+A1/koSlyHmP2x4+AAaaSSJZOsGNezNTP8TDCot
         5ZZuRmJ5/lK/lnyK7dW+NAcVXTETDHX5we4jWrkzwOVAmpcvf3UF6poOTWdEZLTrLg7O
         7o4Q==
X-Gm-Message-State: AOJu0Yweu/0CrLdIns850SqwCd1PGIg6weBDOq+BcHZuZMsLR3MoSmpp
	Gl8l8i8t9et8ElsX7HKTnIVafN9S3o4n1AzEwXTJNRYRegmloMrs948eyj1nu1bR
X-Gm-Gg: Acq92OF52e0ceLlrRWJJnGKyDlglZqOPgkmXcUM8HkCvga+TqdcmwmQcH7VF+1F10gx
	9uFiKcDGvH9lltLpSCK+sva/sDOdhaavwrkDwOiKwtm2z06t7b+GC6T/kGLbluUaVBGSstTXfqh
	OugrzU4CTIgQZw8jNK5rXtCytqBMPoOzrei98dQEbjqlUEqAvYP9OlGy7RuWu0S3xRmbzaL6tGY
	P3TQIzP+6x1H85OiGnaE7m9zxjpmjxEvmF04SWGuOlwQpmIEY5MjovggSAfsI50/49vibiobzrg
	6WMMHo/4/CMw1zzQQsyPyLWB9TgA3B3muqoP1QwuGEvvJ3IjmPXGqCZt+UYJKTINPYsqmbtKzwu
	rJhf/1Cr8x0X1N6WDGyQ4tEKElI34N0v45ay1mKeYNx8lLObbWQrAKuuiqeYwHiF/zp45Xg2Qcg
	eBsF1sDCcI1NMzfbHW8nVGWEtsWn+LasTVWpfSar8D3A==
X-Received: by 2002:a05:6214:f63:b0:8c2:f420:4d60 with SMTP id 6a1803df08f44-8cf1dd02ce0mr63220796d6.38.1781031896639;
        Tue, 09 Jun 2026 12:04:56 -0700 (PDT)
Received: from [172.17.0.2] ([172.203.213.84])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd277070sm208956436d6.48.2026.06.09.12.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 12:04:55 -0700 (PDT)
Message-ID: <6a2863d7.12a24f9d.293174.5408@mx.google.com>
Date: Tue, 09 Jun 2026 12:04:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0425804125691775313=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, bugzilla-daemon@kernel.org
Subject: RE: [Bug,221629] New: Bluetooth l2cap: ident leak in l2cap_chan_le_send_credits() stalls BLE CoC
In-Reply-To: <bug-221629-62941@https.bugzilla.kernel.org/>
References: <bug-221629-62941@https.bugzilla.kernel.org/>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0425804125691775313==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: corrupt patch at line 21
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0425804125691775313==--
