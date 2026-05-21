Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FB73D8103
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 14:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373609; cv=none; b=RmOvamLa0MrsHf15KTGPmwWsCCImOi2NlbSxoYrjEoQiKWvAsCKIsRvg0eMAjTdJ4qQQc+daWmzrmqvGD3Vb0cGgP0B5zO/HAkyUjkHQr1CcDn4aUi+V2poUa0TCNKiwkM8IWZWyE5UYSvTMMRxx8d9HBXjkxlfBg3o1SpTD2RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373609; c=relaxed/simple;
	bh=47rUh59DOxjQyDGLlVVdfKwJdbUJs5dqHnAQdoQW2jE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=EMH+wF0FksZ6ydxIKYLbkgJQNuzOTv9R50bmh54vft39Vm+ocSSIjXEtXqeBL7xgx8Fz8cPq5X6JnEZO2bsJrSeNP090JWa9vOHVDgv9oQbrLVcMJnBxG7B4zbgNr+ojqpSIqMup6VT1YBxYHMJJ/jFxeAuV5anaga7rnk37x5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/dnAs9A; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/dnAs9A"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-41576c5c01cso4533107fac.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 07:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779373607; x=1779978407; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fV7BT3EzF6tln0RVXrazkDY4LgskIbZ+RwQiv1H0k9s=;
        b=c/dnAs9AQ03Vb0f3WT/0Er7iXImLr9e7OgiPixhEBSMKvrWq9Z2OO3bjNHWK8ml+ru
         DUtspM/USreTgHPmQZT4RjwO57eqzd5GyctuyVVOW1pn1rTcp+EeWqhZ71LgMxauRs40
         cwhenlBPzGhQQvKbSefRZhkH7yNShwP4MfCk8IkvXev7VdOxvsH10KBy+BbvRNbQaw8S
         VLSs2zfJ9+UnXes3UJSlJXRltoS7SJWU2tJAnmfxBXUCjueBpTFH3BGgKXn30eMHX5Dh
         LdNyzYrx1HvpbQOvqRLSzFK/7l+AM9o0vLzXYFxRXbJGrvDRAtlFZEt/JwkSpVivyUDJ
         734Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779373607; x=1779978407;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fV7BT3EzF6tln0RVXrazkDY4LgskIbZ+RwQiv1H0k9s=;
        b=LtNrJ7nbT4qqyNzTHgCYQhvAAGEKclbq8VE4jQ2Ml1+/t2M2v/s8YntavzGRdUCoup
         EnlOGbtwAgHq3J16QNJavO350x5s6DMuz6eAsgamWGqNCXdtkqgfWNfGvIvxq8QLiOWQ
         QWVWVM7Gu+xyxNUyxHGT37KnIdkQhmTpc68n0Y72A9CJIpGZd9WeURvjqGS0NKZ9guSO
         uJI8jD2zGxSGrhIYKIMbF5XYHvfYsKXAovWzNCsvOw/EJsXYcTAdgwyoqfXdsHOz4tAt
         LwU5OYwrMteUBcnvOMviVm1hFV6l3D1u5hCnRQsYJqYU416Zx0Fm5h3Ui0m1/92Hjc4D
         +n8g==
X-Gm-Message-State: AOJu0YxHyN8S4ykCqzzbuveiZobU0W6f7HtD+hcrc+XySLCg9vMy16Ug
	w7WobhahP235HdDtLSz0uTyDFzHevorQPnjxqnzIfqqmSegD9F0Qiftec47eYw==
X-Gm-Gg: Acq92OEBAP5NpBfLzQRtqBNgU21jdOFO26i57E33+xqXYbWEOE20pxrEYFpXCAPReAI
	2FE/o5lGVgR7k8Xg8zYkrqtbNCVkIGWYzGTm8reylf32nIPugzYxGtmolMCFyoW/vVoI2FWgoCg
	pTTuNXCmzXjAh+skoJnZeV/VzTgEFaYQCLE72L4TXalWVbhR8NGz8fhnkVTtZJo4w3O8FYeB66z
	D5bxuGdhMIMlzlIvbOBrxD1RTtay+kQ9dkTMd+Mv9zW63jZhiucrp6bikhW+BrPqmru2bjDxA56
	1aiqK1CJ3YD5+ylzOPmAACgJxrJ9mDhuy1swcb2przPUySAMU7SD/3WDD24yQCCAyBxJ75Syjn0
	pf68z0xSUbHm9dqLWy0KkjuMMOuqSrPinfpMTiTcmRxsbzaHEUl/vXUHfBatOOJysxL/89c7xtW
	I+Hr4buIPokpe3g243DhfqiK52FJxAVnI=
X-Received: by 2002:a05:6870:1761:b0:430:2495:5ec1 with SMTP id 586e51a60fabf-43b2eb10bfemr2121681fac.31.1779373607277;
        Thu, 21 May 2026 07:26:47 -0700 (PDT)
Received: from [172.17.0.2] ([172.212.165.72])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b4544de2asm596708fac.15.2026.05.21.07.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 07:26:46 -0700 (PDT)
Message-ID: <6a0f1626.821cd8d4.2b803.b3e6@mx.google.com>
Date: Thu, 21 May 2026 07:26:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2545167711089129910=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, oss@fourdim.xyz
Subject: RE: [v2] Bluetooth: L2CAP: use chan timer to close channels in cleanup_listen()
In-Reply-To: <20260521021249.3258069-1-oss@fourdim.xyz>
References: <20260521021249.3258069-1-oss@fourdim.xyz>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2545167711089129910==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1098389

---Test result---

Test Summary:
CheckPatch                    PASS      0.66 seconds
GitLint                       FAIL      0.28 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      25.36 seconds
CheckAllWarning               PASS      28.35 seconds
CheckSparse                   PASS      26.31 seconds
BuildKernel32                 PASS      24.49 seconds
TestRunnerSetup               PASS      525.81 seconds
TestRunner_l2cap-tester       FAIL      59.03 seconds
IncrementalBuild              PASS      24.10 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: L2CAP: use chan timer to close channels in cleanup_listen()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
21: B1 Line exceeds max length (109>80): "Cc: <stable@vger.kernel.org> # 0b58004: Bluetooth: fix UAF in l2cap_sock_cleanup_listen() vs l2cap_conn_del()"
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 95 (99.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Server - Set PHY 1M                     Failed       0.261 seconds


https://github.com/bluez/bluetooth-next/pull/230

---
Regards,
Linux Bluetooth


--===============2545167711089129910==--
