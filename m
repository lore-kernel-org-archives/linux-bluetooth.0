Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F11033CEA7
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 13:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778593498; cv=none; b=NuFKc6dTGf8EQLPblISWpja0r0iemrWd7YU2k4OS9081iowounLvd/zy8b7MRgoufvOXJF9ukn3uGl30HYCNfc/ls2YOIuo0gSWMdFqbLZbTkU45jSVVj7vOtGuGFRfy3kw1YodVZMnYJk9BQTD+kllwsZFHMG/o8II6CilZXjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778593498; c=relaxed/simple;
	bh=MZ16p9f1kgU9zHzSILaVGLArroZmvGgv8sdK8q6w/io=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=TG2omKI3Q+C7lKQOfrKcTOQr3xtZw8E7z4yqNjcKIrLm5mM3g3laz+42ftTsC+nNkjm4BZr+BPHlQlTbfCKbjQZyusSdGUiuknpsYpoKFWY4L7JQQKDiY9h54NJipRnwahe8/QvuvDUQXPbi1nUhhduYLd4/wgeKtes2VmQZhyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MoG5T6Eh; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoG5T6Eh"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8d65f4073bfso763400485a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 06:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778593496; x=1779198296; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cp9r+I/Vz4PNIUF2iWdk+M7H5B+A2g/5EC3la4UMb60=;
        b=MoG5T6EhA6xGd2RDahCXTGxG3HaLM2VPlPGycWoeQgX9r32J2HKac7rCibr+cphWK8
         ZrEOqYNLX3ulmUnj06ygFau7dIqbxfvHDNxGTycz6hoo4FruaT9G8CqK8VsQHp8FSAyi
         FN1bL9RDzgoGURd5W0E7imFvuGVy8/2tL5j10HjcD9JYO9hjYlkpjLQjUgMdQ1D3mylp
         Y9iQKkd0+YqvEqgeKJ1IdFK1kpTRu3OhMm7uaMAYVvMjQp4XZeFhCNKKdxqOraG3PJOV
         LfIQP/PoY0cbUBRiekp4SY/TkWUJGAEfSFauI8PuqAAto7+fK81PxrWuOUM+4xFs76Sf
         srcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778593496; x=1779198296;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cp9r+I/Vz4PNIUF2iWdk+M7H5B+A2g/5EC3la4UMb60=;
        b=OTqhwjlgX5f/NByjfhZ7tvZUhftr04OgXJjyacP21fQnDCOU5Wa02qXrNS6T7NeQql
         nonR68/X21ElQQxBywX46B1JxNzWJB4X4/VykVJ5JJe2MMqyGzfs/uiXTueIzeOoX1fv
         wjJvnU833dWLD40gpOsYpz1oED5UmIXpXj0xtQImDpH3tmJmIDKgme+zN/LNFDvq26tW
         lcCld2aZqlUquKT1oAAn8mgqZNjIWzFVccP/HdnlgAlrKpUHxcALjKliwrvoJRhr3mq6
         lO1vfGi9tPwTZm4U1gAfOAF6h5kLVuEfLHluQmGYt/np5x+B9x2hadpN90j31gijC5CQ
         UtiQ==
X-Gm-Message-State: AOJu0YxujZYCQYnx1q+WYscHB22pdEMO7745YyeKsgNSpSOBXd9O9PIr
	Lv9zy2LL5PaKUbNuWfM4Y16Y+X+BPu2BwodzePsd7Rj5v8Aqj7R/pzZO/yD19Q==
X-Gm-Gg: Acq92OEc0YdTkdEsCQiI2sNRQ7l9Wa4Dna8xfDUWk4kacXpskD7jC1z3WELPNeWqj5f
	xIpS+sHKavgQAwDzzZKiPaz4o37uwCHU9hcaWIYiH7R68XrleLToLgr80wPqS6/yBaPal13t1jd
	SkdeAd3wnvVs3cpFRIZEKGe4GJG0Cwej8HJfK1HcZTdMqtSevVXl2tOJArceYf9Vk3TJVvuosDW
	ZlBeoBzt/xoG/j4ue2IbTSuXqHkajgSfvZt9ZfAAYf8Pe+R9kV7LYBNP+ParoHKnJvALe0WAo+g
	c6kzVbuysUmffWxpPM7RzVYYWhaV0dTrKgl5ggZxorWYLSqWKKtgNS1XK5IZz2xGJ+D1tHr+o6w
	E9tQ7j2wm+r7SxoteGuvjM6NuBGE2A3Zpi54/NCf48nkeVSMJyjQUMpL0uULHj3lWqCgItx/mzT
	15GboQfnCRSYpW9ak9RGGnkg0/IuM=
X-Received: by 2002:a05:620a:4095:b0:8eb:605f:6ce0 with SMTP id af79cd13be357-90cfb3cbd01mr406969985a.5.1778593496002;
        Tue, 12 May 2026 06:44:56 -0700 (PDT)
Received: from [172.17.0.2] ([20.98.18.73])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b986aeccsm1324021585a.4.2026.05.12.06.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 06:44:55 -0700 (PDT)
Message-ID: <6a032ed7.050a0220.3ac775.b180@mx.google.com>
Date: Tue, 12 May 2026 06:44:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6212272982720126223=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, leitao@debian.org
Subject: RE: Bluetooth: convert remaining bluetooth socket families to getsockopt_iter
In-Reply-To: <20260512-getsock_three-v2-1-30b7b22ef14c@debian.org>
References: <20260512-getsock_three-v2-1-30b7b22ef14c@debian.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6212272982720126223==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1093480

---Test result---

Test Summary:
CheckPatch                    PASS      4.19 seconds
GitLint                       PASS      1.80 seconds
SubjectPrefix                 PASS      0.76 seconds
BuildKernel                   PASS      27.64 seconds
CheckAllWarning               PASS      30.79 seconds
CheckSparse                   PASS      29.76 seconds
BuildKernel32                 PASS      26.88 seconds
TestRunnerSetup               PASS      569.83 seconds
TestRunner_l2cap-tester       PASS      378.12 seconds
TestRunner_iso-tester         PASS      597.45 seconds
TestRunner_bnep-tester        PASS      19.24 seconds
TestRunner_mgmt-tester        PASS      2023.41 seconds
TestRunner_rfcomm-tester      PASS      63.64 seconds
TestRunner_sco-tester         PASS      141.77 seconds
TestRunner_ioctl-tester       PASS      133.80 seconds
TestRunner_mesh-tester        PASS      60.07 seconds
TestRunner_smp-tester         PASS      18.27 seconds
TestRunner_userchan-tester    PASS      19.60 seconds
TestRunner_6lowpan-tester     PASS      51.45 seconds
IncrementalBuild              PASS      35.29 seconds



https://github.com/bluez/bluetooth-next/pull/178

---
Regards,
Linux Bluetooth


--===============6212272982720126223==--
