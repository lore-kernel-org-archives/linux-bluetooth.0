Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D1519D065
	for <linux-bluetooth@vger.kernel.org>; Sun, 26 Jul 2026 09:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785059734; cv=none; b=CHZpDplxgLw1gI2jNanPuJfB9uFBgcvAbpeMKOPnGtzpTExN1DYEV/wZOcAUecuSSVbmnp/l9gMcWtZSAoCf2vhATe+dM+qsjvSCR3zedGx/wwCOrqfm3J+oDMg7efspKWVUgyU+XDxXp7puTCvM4x3898/5Uwc4oVnjsOwqdUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785059734; c=relaxed/simple;
	bh=KYeUB7c/bEzl+hfjDEWlw0VUvZ1O4Khc7XMWGp0JkXs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XaxcvXSDegIDFZqlD+slnHDwKmcNMU9c1k69ejyoECjX9ee8EivpWu+h8pdnUbEtfHxUKEbWRu3BUNgCaFyD1kWUP2JJnSyNuOyogNVrNfKqqbdZsJYJkPWfxmWic+q04yoGCA+pgjd/Azjtdn6PAYa5ZAqmzDmdQDN3Bf1RK20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEgTyEh7; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEgTyEh7"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92edb12cdf2so112940885a.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Jul 2026 02:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785059732; x=1785664532; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=b44n8bLOeFA5P4NFg8GFcE/5c4LMlSqR6OjsS7QlQmU=;
        b=HEgTyEh7C9OQyhTbzPEnwFnc/ATQhSWTe2uW8RUznvVW1LKim7RspW2Go/tLxOkzWX
         cRx0YLA8P8dTLYoBL7lqp+1iMeYiNqQpvZaGHkGYiMwZFRp3kezooAD9vnaFSK7lp+lx
         JmWv4WvJLAwuaMaaYPKd9BR38SECvPPUlmCMkobiYR/tra2gHs2G5pA62hDivpxxGFMS
         i2wgAni2SRYcVCGSBASyxoA0NyS++n7UWyvZBmbqISap1lkKtH7QcX9X2jyjXrsl1eCj
         AnafBF68pEpQtlkWdLDIZggLA+BjILXBNdnFmLTwYqesl71u2DPRPN1mvk5/nyZlC3k2
         yekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785059732; x=1785664532;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=b44n8bLOeFA5P4NFg8GFcE/5c4LMlSqR6OjsS7QlQmU=;
        b=Rv8Safyj3SAYEGE9MvPghEbU/cgjaYHXZKxvSpf9fpqBXbHhzmNJD0gud3sZNF/MDq
         2qnx0dPdnMMJTIeA2E5SVPI5e+ZGmLyt4WLXBJn3qXSvg8xHdJPGaLZiGfO1U+gC/AC+
         vqSumAdETcnVqJ1BQFzOeQgfZVIFkgSHq/E6Ztj6DFRVTaDI9yWim/IdmdetgaNaS81S
         gpCsnYlddb61uMm75upDVZkbV8PzDb2GgurYfwJYibduq0Ej3k5XTzMc3m1YLQyPusJC
         I9W6sN4HxIjUvdJQp74qhyCbmc1Kq61ooUmspbpvtAqwddX0aufBPlfnHIengHnAjH2b
         A4Qg==
X-Gm-Message-State: AOJu0Yw6mmbzIa9EBu6Nhoqy4R6eCmm/rtvlG2eYGZS5Ga5yYkOkuw+e
	MwGfRUXksvBKUjVCZ1ddu1vwCUP08oVzzWBjoqWoIspeCFKjiMV18IDrE9st/g==
X-Gm-Gg: AR+sD13wgkExccAXVKXU5c8/GxEkv8RiohbpJy1bUuPLiVn8MucVrcIYAgh3rfBeytv
	RW/UeU6izd+vC90NPKw0DmfhRBKaimyUK9keKKwPL87dEhLJyO24nvDC9+cttIWJ94ESQi6mQ2+
	wEUqmZfeQi+H4GXv8DSsnAsLkkGdJM0s27/bF0aCe4MdvUt1oxYGyIHWOaAvYMSuRfHNiEwXQiD
	RwNjXm13Aelj44K1SdEYjEyxAsbf77OsCAHxqkZSygt0N95PR4S1mtwmCUY+3w1AuCcAZZeVVNc
	gkbv8m4QCwIZUGEnZ98XKOV/xFUWFo/4QonJjriwcr2y7u0Z2sO7inysqbBtaOnKFxEdsmG9XA1
	tfPNHMJ6XEw0csIMshhDlxPAZnt3f36QxaCXkxJEGJEc3w8Miy0ETWxkBc/BnA/Rey6epfVRc4n
	B4zNlSSomA
X-Received: by 2002:a05:620a:19aa:b0:915:675d:a2d with SMTP id af79cd13be357-932df6ea2bfmr438096085a.51.1785059732194;
        Sun, 26 Jul 2026 02:55:32 -0700 (PDT)
Received: from [172.17.0.2] ([172.210.0.102])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-932de635b7esm343495285a.31.2026.07.26.02.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 02:55:31 -0700 (PDT)
Message-ID: <6a65d993.6f91ca5b.260d6e.480c@mx.google.com>
Date: Sun, 26 Jul 2026 02:55:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8896677854022598038=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, baul.lee@xbow.com
Subject: RE: Bluetooth: SCO: fix sco_conn double free on outgoing connect
In-Reply-To: <20260726055431.42350-1-baul.lee@xbow.com>
References: <20260726055431.42350-1-baul.lee@xbow.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8896677854022598038==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1134537

---Test result---

Test Summary:
CheckPatch                    FAIL      0.76 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.36 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      28.19 seconds
CheckAllWarning               PASS      30.75 seconds
CheckSparse                   PASS      30.22 seconds
BuildKernel32                 PASS      27.15 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      533.50 seconds
TestRunner_sco-tester         FAIL      35.18 seconds
IncrementalBuild              PASS      27.47 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: SCO: fix sco_conn double free on outgoing connect
WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#142: 
Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
Reported-by: Baul Lee <baul.lee@xbow.com>

WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#143: 
Reported-by: Baul Lee <baul.lee@xbow.com>
Cc: stable@vger.kernel.org

total: 0 errors, 2 warnings, 0 checks, 40 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14710765.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
Total: 30, Passed: 29 (96.7%), Failed: 1, Not Run: 0

Failed Test Cases
SCO Disconnect - Success                             Timed out    2.151 seconds


https://github.com/bluez/bluetooth-next/pull/497

---
Regards,
Linux Bluetooth


--===============8896677854022598038==--
