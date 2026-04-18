Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE50B2561A7
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Apr 2026 06:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776493027; cv=none; b=C9anb+GY8yNy20W7RFKLID1p5iN3EFivIxMK5W9L39XAbYhueL8Vjf36cbqPYu5U9KJ2mDBBfFnsnmmL1mzaWxb5LPDII/a3xWpF/GJfCjlBnx8vv2oeXiK5+xM1wFd6Q+uT2PhCBVjmsidbJ+0gb+MaxueDjcR/e8xgnkydiHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776493027; c=relaxed/simple;
	bh=tsSIN1CqfLMSwiXQH7bgDqn/JnpXXAf4citne9q1Jz0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GH57GxKOzVnNjzYe+R4O5322eursgn83L/Dv8xm0hJwF3uTcjQKcJR3q5/55c/6y5BmbBlYwAdWSad10/EnZIjhrTXspjZUhR2IXH9mVzsYNwOCimsg5qGRkNpNhbh56awaNGgZCR+o1uRBUilSDgdYTBgUuDIBX0PXlaC31xBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgKQNYwq; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgKQNYwq"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-506aa685d62so7449791cf.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 23:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776493024; x=1777097824; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vKjQTAqdDN+Yf+1PRW0yidG8PLpIpcLnTA4qsdUwhuo=;
        b=XgKQNYwqqfybhxecdA9lNS4aTQQH7NzRT7PsEVOKxxZHmjN7i1NWLSnGM8We0NvQkO
         n64O11HhZxO6DSdvt5QQWFaFiYqQsZ2MvqjJZaEsWcmIwwPAIOJ9l5p35lhx7TwlV49n
         fG79q99lh6qdV/MMFSPkBS6m0HCD5xdyFSO+DNwoRUmQGC9YM5E8btvECkkWjxGOrVkF
         07wS+WwFunl9K4xQ/LqM5DUDSsbDMgBXTIs0Zoej8WGFm8Fn2ORe9dY+RkyORlmRfWoi
         NIQhltspPqYs0he+R7VcOQpHXja5zJb9MT40MsyVRqmsAWB7VhqOGLfBG7EQWP9DZlc9
         Gnzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776493024; x=1777097824;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKjQTAqdDN+Yf+1PRW0yidG8PLpIpcLnTA4qsdUwhuo=;
        b=qXESUJgQStVAUCAV2BFtKIlPzFEDyxY+RM/NZv01xhjWhstzyRPWx+C6ZUN6B0abrK
         NoF96YmdbIhTC1ErayFIAKyconajnAoSeiuKWSUw8Dh9VLE1FWqJ4lPhrofpxr/GNVZt
         NBaodooRDRByylMldXesgkE8c/X0QdWzMEdEqcLthhTJjcyk2dHsdtGbaWvFHVlLKZtv
         F88QlRj9h6NYU3vVLft4krKtwfdS0VaIk/Wfjmh3+2djZdpbMaPw6Fcuz9oKSKsUyoVA
         xQLMlxxJo9KowmnUhAX56Lcn41W2JQRpO3L6EpulQqSF9Ck8GqxA1oyhA18vD8UXRiyi
         40pQ==
X-Gm-Message-State: AOJu0YwGsaLAacjea5ZM4GeT2cCmc9Uf4jtwBwpsgHVWk7OCj4fnn6RV
	8Tgt321InHEfGAbxtgJjOkPnJQao7doqO1EzuWYTVKTE/wjbqTaWyPZPE5UgBQ==
X-Gm-Gg: AeBDieukzF2w7hMAg6e1Ysnjt3rHkTdRWCXeh+DJESm2tG1ryOuqA3p4OL4YGyNPQdJ
	G56gV0lnhBFirpH5cHSeiHJ6l/oLBwqjdeK9JKYxAX0EZv6xArKiLAZ4x+yA4n2t4T+HohDK1ND
	bZCor9crU6PtyVrU/G9wRi9om+KJ+jZz9GepDfpks3AVLfSwdgAgv1cD/DIjnWe3H/P9ttsZv+w
	/7eamFT9zuwByaKw7rtTzyqvZ4gr+08F+7e0Zq0UMKXImfBw3JMu5YzVGW13JGfXZ7ytqJBPwap
	ghpxQHUeqDpEMWC9wDRiLnH4sCSbWxl+FedjERQvXhXiiQI/olCqfg9CyKYYGdyc/YOTWCbeQa+
	GZh/KpdPYcIHegTtDseIK2oEiQuR/Eogfev4tyjzi+btfb3/lVG32ksb6t8UqX0jfQt0WHQfMxt
	gn1bAjM/Z6XWcVrkgPwm7jR6HCfl6SXHEtW3t9a3+B
X-Received: by 2002:a05:622a:59cf:b0:50d:a8f5:1bf8 with SMTP id d75a77b69052e-50e36bd6471mr82902461cf.37.1776493024357;
        Fri, 17 Apr 2026 23:17:04 -0700 (PDT)
Received: from [172.17.0.2] ([130.131.71.17])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b031f65a27sm15360386d6.16.2026.04.17.23.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 23:17:04 -0700 (PDT)
Message-ID: <69e321e0.d40a0220.2b89.18ee@mx.google.com>
Date: Fri, 17 Apr 2026 23:17:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0185708600202387794=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, suunj1331@gmail.com
Subject: RE: Bluetooth: ISO: Fix KCSAN data-races on iso_pi(sk)
In-Reply-To: <20260418053401.128483-2-suunj1331@gmail.com>
References: <20260418053401.128483-2-suunj1331@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0185708600202387794==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1082745

---Test result---

Test Summary:
CheckPatch                    FAIL      1.15 seconds
GitLint                       FAIL      0.53 seconds
SubjectPrefix                 PASS      0.21 seconds
BuildKernel                   PASS      20.74 seconds
CheckAllWarning               PASS      22.73 seconds
CheckSparse                   PASS      22.00 seconds
BuildKernel32                 PASS      20.52 seconds
TestRunnerSetup               PASS      414.87 seconds
TestRunner_iso-tester         PASS      26.97 seconds
IncrementalBuild              PASS      22.15 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[1/2] Bluetooth: ISO: Fix data-race on dst in iso_sock_connect()
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#132: 
race at unknown origin, with read to 0xffff8f96ea66dde3 of 1 bytes by task 549 on cpu 1:

total: 0 errors, 1 warnings, 0 checks, 19 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14529234.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[2/2] Bluetooth: ISO: Fix data-race on iso_pi(sk) in socket and HCI event paths
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#156: 
CPU: 1 UID: 0 PID: 334 Comm: iso_setup_race Not tainted 7.0.0-10949-g8541d8f725c6 #44 PREEMPT(lazy)

total: 0 errors, 1 warnings, 0 checks, 137 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14529235.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[1/2] Bluetooth: ISO: Fix data-race on dst in iso_sock_connect()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
29: B1 Line exceeds max length (88>80): "race at unknown origin, with read to 0xffff8f96ea66dde3 of 1 bytes by task 549 on cpu 1:"
42: B1 Line exceeds max length (100>80): "CPU: 1 UID: 0 PID: 549 Comm: iso_race_combin Not tainted 7.0.0-08391-g1d51b370a0f8 #40 PREEMPT(lazy)"
[2/2] Bluetooth: ISO: Fix data-race on iso_pi(sk) in socket and HCI event paths

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
53: B1 Line exceeds max length (99>80): "CPU: 1 UID: 0 PID: 334 Comm: iso_setup_race Not tainted 7.0.0-10949-g8541d8f725c6 #44 PREEMPT(lazy)"


https://github.com/bluez/bluetooth-next/pull/102

---
Regards,
Linux Bluetooth


--===============0185708600202387794==--
