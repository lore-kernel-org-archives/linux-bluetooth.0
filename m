Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515DE47535B
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Oct 2026 09:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790934139; cv=none; b=TuLjt0Wa1aSFH5ZuveIVVN7kdo1PeMGDeUDqhn7hdPmXJj2tCKh5GaVAIOrpJiCGQOnVleT6CnjG/XUuesaP2UIPb9yY9FbcjfiR9XLJnI4I7qTSMNREhDpbFGA6qDKccrmwi6GzUluMmH8dkSHVZsoocm23DnrkSe5DS7ML1I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790934139; c=relaxed/simple;
	bh=ESSLyZy1vi7TJvlExPd4h/JHtX8rqCT4/sPU2vJ4N0Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lVf00eaCkuvWKDt1S481ph4a3RalHQ8s8l/AKejES9KIFlBYdskBZ1FpDLS47xXcNh0UzyP1MLTBS7ytMpWVNzUqRJ5bbwiPoNDV6/2A8+YwdC/PIJtvQy9nFc8ocyJkXNJorMzBxvjLdc/0dCm9E9ACzgLpsNJPGh1MWySt3s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YavVIPWd; arc=none smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YavVIPWd"
Received: by mail-qk2-f41.google.com with SMTP id af79cd13be357-93df7b21008so35702085a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Oct 2026 02:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790934136; x=1791538936; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aupeXbW+cb9XaS1HdJLhVIUSKXbl9NS7m29r9MyPpHA=;
        b=YavVIPWdD1K7r4oJqsAG1p8Ag5NBCGnI0HELWKEBucvkWXF3l6cRnVSt3icS1X2TM8
         FWlSSRYld3BQ/4ce0gymeup+RmfuuGWdWClba2XvxisnxKxVamBihOuePJc1loqEscLl
         zdgpVt4QJhjiSt+dgkukMBCTVR+PVd4c1lc1sDXetg7XrExSmtmbm+SWPgq+q3m3jgWJ
         Pm/uvEYtH2ty+xo9y3ZrNfbPXcELmQcmKyervhdyeAw/7OjIGyl6YsPbkjymYNcPByBN
         jqDD8vd/QlnAvA+fqdqwKfru5d7LVtSoRIRdz6tuPbIxG6LzZocqvvWlr59L5YYAEt+l
         2b5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790934136; x=1791538936;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aupeXbW+cb9XaS1HdJLhVIUSKXbl9NS7m29r9MyPpHA=;
        b=BAAcDEqzgZlJIkpal6WdbY9PD6fp4UvTblnIZFwJetoCmu0HqNFiV50HPDdvuPIwZ2
         rJUb0mwFJHSr/05mMHr8D3o9TwUyCA++qxwb+hItOVmbqbLSyumj/YMFkOjWLl1wJrJp
         zM1L7uycmNBZp8GnTf8jsldQxTmuhQ5YziCjQysAbgQuo4rnAp9Vbax3YHgJi0NhWR5X
         6+pob/bYRQopKXm0OeiacptUqZvUFdf7180/km/9yKs8/5TzCedRiIGRPlEQBG1TI18o
         cr0usCFSeQWrIiGO7QSfSCthbg1HLiRvwrGuDxpAGyQAChULl1qY2SIJkfA896t4cJAU
         gMtg==
X-Gm-Message-State: AFuF++mtcb2XnvL6PWpukJKfpIljnT+tAuQ93YpbcFxvg0Smq9Wkp+Ux
	afMCUc/wD/BtUDtPhnxNvxBwYeeQ+dG1x1EnOXSv3ohtzcy8Y1plhavo3w2Zsg==
X-Gm-Gg: AYBFou3EmLBJpmn5j3TvOLYBBRdNHyncqGGlkM7huySHrgZ9Gf74Ey43aJVkOfcEyjj
	yA6L9nLLWTerabf3C2W6+Bq6si1V5WXkl4eq2Wxm00Ee14iM++PRwaIXQk0Gd0azn1RuhUsPqTL
	978O8PCFPVqSxSA3QaAeBlxsDMLVzzmwHcnHKiC2UQZuA6QVNhbN22eAE4mTKpl31icSioqQcR1
	RaJxuyh889EaZRuWhGthg70I2Fl+njF2r9RnuSWwZ2wRn0z/Dv/YE777Y7ZWv1P9YbKbFhssEgK
	i8ZNYmKBa30Re0WTzmQkFyPfznMBccDgJiZeQtH1uSqeA/AFyERI8qbH386rGB22BI8b8G+QtGa
	Tnlh1DeT9oynl/32pDv5CpI1h3BaIieWlCLqk3CowAwsF7m/X/TpEoV2b4jQMo4aHHhcPzxiDAW
	qxA3dEjT8RiVowk8lFQlPENhwPn9/qSIkEKnSrRJDSPXC1gQlo6mKYP39Xe0/+f1basKB5hRbJJ
	OFhbsLogsxYYY4a
X-Received: by 2002:a05:620a:370d:b0:93a:48a:171 with SMTP id af79cd13be357-93cf188f6camr341901085a.51.1790934136090;
        Fri, 02 Oct 2026 02:42:16 -0700 (PDT)
Received: from [172.17.0.2] ([172.208.13.59])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917d565489dsm15665196d6.0.2026.10.02.02.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 02:42:15 -0700 (PDT)
Message-ID: <6abf7c77.1e090151.2e3a29.dbac@mx.google.com>
Date: Fri, 02 Oct 2026 02:42:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3839293298060094614=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, rabindrameher116@gmail.com
Subject: RE: Bluetooth: hci_sync: Cancel cmd_timer before draining workqueue
In-Reply-To: <20261002044810.80340-1-rabindrameher116@gmail.com>
References: <20261002044810.80340-1-rabindrameher116@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3839293298060094614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1178060/

---Test result---

Test Summary:
CheckPatch                    PASS      0.77 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      29.13 seconds
CheckAllWarning               PASS      33.26 seconds
CheckSparse                   PASS      35.57 seconds
BuildKernel32                 PASS      29.02 seconds
CheckKernelLLVM               PASS      32.88 seconds
TestRunnerSetup               PASS      780.92 seconds
TestRunner_l2cap-tester       PASS      12.76 seconds
TestRunner_iso-tester         PASS      18.75 seconds
TestRunner_bnep-tester        PASS      3.13 seconds
TestRunner_mgmt-tester        FAIL      61.09 seconds
TestRunner_rfcomm-tester      PASS      4.48 seconds
TestRunner_sco-tester         PASS      5.55 seconds
TestRunner_ioctl-tester       PASS      4.63 seconds
TestRunner_mesh-tester        FAIL      7.82 seconds
TestRunner_smp-tester         PASS      4.33 seconds
TestRunner_userchan-tester    PASS      3.19 seconds
TestRunner_6lowpan-tester     PASS      4.40 seconds
IncrementalBuild              PASS      26.94 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 503, Passed: 502 (99.8%), Failed: 1, Not Run: 0

Failed Test Cases
Pairing Acceptor - LE Security Level Changed         Failed       0.026 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.418 seconds
Mesh - Send cancel - 2                               Timed out    2.000 seconds


https://github.com/bluez/bluetooth-next/pull/850

---
Regards,
Linux Bluetooth


--===============3839293298060094614==--
