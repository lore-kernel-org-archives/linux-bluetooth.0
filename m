Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D20F1ACEDE
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 23:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789861750; cv=none; b=u57LM5wxmhvDxE1tfSYwsNiE4YpX1oQbB1OgLXJ86Dt9iTmjnmNZZAYAKwOI6DMDyv2rfWhI5sIANmQGO/vS0f6pkK69inyJQbvG6ZsiqJuyvrYkY7fLnipJjI6dcuyRnAiXNOJIonLNbm++8ZAOsSvKbYaIhT/qIaAMw//2PGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789861750; c=relaxed/simple;
	bh=vSCFpFWecz4g6uBY4ylCSYKsUjwJqouSG48WFRSAE2E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=N4jlUDwdbFlmbCz7ObBGzacEa0NR3y8iAOjE7EdeDj2jz+hHiEPM+OrmHCAMXm2MYjmXIMeDMYUDCi3yyvm+haU08/sZn/ViMC3MCYOKAciBWkl8mqynvkHmsYz0yX16jsYO5jkFHq6CXiOXqAN413rhu9y/9r67qYM0dYcnmUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ms/jK3Tc; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ms/jK3Tc"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-91235f46716so19251836d6.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 16:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789861748; x=1790466548; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vSCFpFWecz4g6uBY4ylCSYKsUjwJqouSG48WFRSAE2E=;
        b=Ms/jK3TceHTlFTA4w5Z0ffTHDLuF6q9xy9jHnvtlAeWusN6WEj1pgMkqFTWd78qOHC
         7R8hzPysaGkFjWejEHCK5B2QoCia8R6hSCy44HT1WyhmX5z+tcWppTgjHVMNBfroU6RA
         KkE76Qfg9NZJ5hthULpoemD8oKowZJOfI7QzK5voZBGPYU/rkrL9ixT1Wahw7JlPH7Ch
         NvgC2RUsZPXoa0264bJqLxqS5sw4Tb3YQ81PcxfSdpm+OiMSOLKyw938WJbHUekQUaEy
         0LAtIQBxImjg5ivPHabYXCBWBm/yxNOn8BmndrUwOYK3e0ltr+yUm9yKyTQYDfc6Kq0J
         PHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789861748; x=1790466548;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vSCFpFWecz4g6uBY4ylCSYKsUjwJqouSG48WFRSAE2E=;
        b=o4CBf8w/zlITfCPlqlPrj9/Leq1cVGV8Wj2hAIRovT2QhdcBEZvywXP3h1V72q3ywM
         PkrZ7Xm1EWx5JHkwAGI6VeTpi0xEMpyEfvy0ibkE+uUkwnKhM/6lz3u6ES1MWr2YcXwB
         OUYBAt05JMVEG1CYcZ1KaYjW5EngvBKwqt8Lk5XCFIidcpPhGTrPevYZa8dayYh298fs
         6o5NQBvVGDSHxu956tQW2Er1tDkztykDu1vQZa37hKvGKEZaT3mB54ADBqLIMiDWq8fK
         sDS24YkA/vp2pnxwWOqffBpVP0/EkQvalAxa3ezzWaraFcvRGQfHsVUxnrmekYZ+hXRZ
         wJiQ==
X-Gm-Message-State: AFuF++nIuntyigOxyn372keHJj9/YnZjxsB4LSAFfrUGfV99vaOIBGni
	6qiRvJ9bP+8T2dXtu/SoQMY5TZ7a55hzPRqY/1bJhby8+vAefSk5dO2bBiX20vVm
X-Gm-Gg: AYBFou3FnbUq8K9M6nI5JLHr8y2EzDa+4HZF+K9dlEJyrw5xcaa9gPKCjv1HDEalJly
	Ge7hLAnHec2V17MVRm1IcDUFj3jx4/5JAtHiYcy04E37UV2VD1SItGEqiS5Q3pYnzVF4lvEEFEt
	Zg8mQ52bAPhSVFCeeYHgX59xCeFC/hUU7YFvRuPGZ272pSjdpEpFecmXV85wqIvIa96Cfq0xZPq
	baXyGCeP4T/JE3u8w9UvzHimA0ZXZNgf0w+r+ZB/GvglpboeZjCVwwaY3FAgJIL6enb5yGUY/Xu
	qDX2kQKoyLf/a7RZk4PiwaAs9YD+s429215hwydyIT81I4QUVou5R9KM9uzpjxkMdHyAdVh0MVP
	qyOa+9oHIhXT+OsBgcaUm1Dfm5JlSuUHb9inEUX3BolFth2mSj71vkCREsoPogD/2zVELejzQYJ
	0vq6HEaydXk2cdkChlN94WMzXQW/I2kPSF0gVjtA423F0VdvMmQvQOJNzo6PeDVwSABOEL7QIhl
	1D/jes=
X-Received: by 2002:a05:6214:449a:b0:912:517b:90a with SMTP id 6a1803df08f44-912a986d4ebmr36748356d6.41.1789861748105;
        Sat, 19 Sep 2026 16:49:08 -0700 (PDT)
Received: from [172.17.0.2] ([172.190.119.40])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91260bb5fb0sm30951026d6.48.2026.09.19.16.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 16:49:07 -0700 (PDT)
Message-ID: <6aaf1f73.46adc49a.2299e6.d1e5@mx.google.com>
Date: Sat, 19 Sep 2026 16:49:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2388412826367104490=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, benquike@gmail.com
Subject: RE: Bluetooth: hci_sock: fix negative cookie IDA free and short event OOB read
In-Reply-To: <20260919221739.3708895-1-benquike@gmail.com>
References: <20260919221739.3708895-1-benquike@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2388412826367104490==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_sock.c:177
error: net/bluetooth/hci_sock.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2388412826367104490==--
