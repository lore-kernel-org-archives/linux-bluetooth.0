Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDB44A32
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 00:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788825826; cv=none; b=KuLvv/c6vd4luFkC7ts2fLOXUxVXRXgDtHOUhKrbNim4WEqaJ1asw8GXjzgsm7YQzh1vSh+P74nVbcmmHUFyxig8aNKh3/YlTCRQ6zbl0iaEh1DAXZ9OU4GqSpyxYwjfJIATTVurUEST2i2dUtLh3HO20Ww8WsYD3WEOkwOom/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788825826; c=relaxed/simple;
	bh=PxbWAOfpmXyJs2qWNLJ+mtPcwsJ2Lgc0lFivejUqLvg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=vETjSyfdG3XjVRTpRc0Ig8SjL1+50u9CxiRzjL5k+1AXpuPpioA90BM/f6pU4A7czgxHNXqdqPYNvE6BtSY+NWTLoiZKcZtyXmHgphZTHXymqmUlY8IEmBYPx4fQp5hDU5UqhdrQbK2AC4WuirohLFD6iFbsRe2y8jUK9k5+VDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBxxOgI4; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBxxOgI4"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-9399daa3c8eso165683685a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Sep 2026 17:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788825824; x=1789430624; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PxbWAOfpmXyJs2qWNLJ+mtPcwsJ2Lgc0lFivejUqLvg=;
        b=UBxxOgI4Sgd94wFqWAiHMeeJLnhA0AnuiHaEouL+CxoQKqo1zVoRELpYWiHRHFl+wk
         OgXVeB7VOW/mfwSkqbb8Of46PnCRW3x6SwFDJcxa+dfyoIs3XvSJ4Txr5CuvPtBXGkB4
         tQPaH8XMRgjuSIAfXywNk4b7rCxImIf+B56dhrrFn9jd4fV7kwRT/ckFn5SNNIXJx2eg
         KUwVNpXP57cQgq8trL4LIoddk01DYanZTdMxqP6C/ojhTZHbsW2oqcj5YISpS0Ta3Y1m
         5WAVyLi/1Gm4RMnT0W4eaa1ylMtfJEZRF06NME+zntfVes9R/YrEABYji4Eoz18sE2X8
         SpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788825824; x=1789430624;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PxbWAOfpmXyJs2qWNLJ+mtPcwsJ2Lgc0lFivejUqLvg=;
        b=gstG9IRI5H6DgqZKde3k5ogV3OWMcHc813C4ksAltLfatrZoEUkaViJ/MYKed+Rl4e
         R7Z1dv8UYcBkgeSeDW79czMc8oL/P4ZXQ/HHDoay5KqO/nxWTscnV70zAOxy5eCevnzt
         1b8jGAoJ/NKAJVAAC/plm7ynQYoYNK/od7hJNRihjuWPy2vj8zS64eQDkcGXG3m18Lqm
         IUPH8r5r8ZkwiIUidMK0H4xXMfnJIylOh+d326k0EjCKSFMhHLPFWkE6n/8w4RPL2nHU
         1V5UVwDQx9T/gY5DZYcnJd+OVAQVVdyZC7NnJZ8GMz/qRviwY1DAmyQwT65p1oWe/a4O
         Agnw==
X-Gm-Message-State: AFuF++nPiPzurzBk/iwNXCOyDT4Zo2koIwnjx9+/CfALvwzWIh7N8ECi
	rV9+GqzfJdBjuWKLzSNFeNctLXPDjX7Lmwl1DzjaybfDS3aWX5UhWeP7oFvxMw==
X-Gm-Gg: AYBFou2etLYdJCeJc0KdEWpzcTIn/Yi313aY+3s9cTAG0Jl40aj+/+h1mwWbHWpZotT
	Agmy0b42o8SULnO1dSwIe8Vsz1PmjN390kWAOeZReMSNjHxR7+OfsqMfioRrh4McokE7z1BSxpa
	HYxhDjzFggjGenXJLcTUkxe/w32dMS6xTE+/7MLxoFMLfopZ2qgjw4rsVcc2QiSfjTSgk3PTWqk
	7AIu76vpVvxRniOgrSgvhmLv0ht5TEfO4hEtVpPeRm+Ob9Kv3XElkk03fDZqm+3MgHSFz/1eZhp
	3U63nm569VPM+jf2vyHqC/phSz2RV/Knke7x04RfVh3rEVOYShCBJP8ygfJvfkaU/80cLYMaAiE
	Rj5j7gpltdCbCr2yMCyEBI/rNKKseLNVEpduraX3lwJ6C7C7tmoBj/IFSvt/gDyW2VBsFHhOGeB
	42eYw8mAPz9HcemDEb/ADh9jppRs6Dgm85rt6tmgNtKjIea+PcHUHw2GzzbJNul8R4miPu
X-Received: by 2002:a05:620a:8083:b0:939:6dea:374c with SMTP id af79cd13be357-939804f9defmr2701879185a.48.1788825824213;
        Mon, 07 Sep 2026 17:03:44 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.133.195])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397fb6e95csm990469985a.31.2026.09.07.17.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 17:03:43 -0700 (PDT)
Message-ID: <6a9f50df.6f91ca5b.2182e6.fef9@mx.google.com>
Date: Mon, 07 Sep 2026 17:03:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7663596685888399565=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, radek@podgorny.cz
Subject: RE: Bluetooth: dial the peer's on-air address when we cannot resolve
In-Reply-To: <20260908012048.3681904-4-radek@podgorny.cz>
References: <20260908012048.3681904-4-radek@podgorny.cz>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7663596685888399565==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7663596685888399565==--
