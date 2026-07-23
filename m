Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CD34766B5
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 17:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784826950; cv=none; b=eZFJyEuvMzBzYsAI3927gvGCbzwj8l7WoyUTzSlEtHSNa+99afsD29Bn3oTzsDopZftg7EO1HhfUhMQus+pMMhP18RJRKTEFk4lOE+evcuCdTJCAN1dv8ZIyymPOG1aoEG8zZc01Zgspe1Em64pfQBqRdf4s1aG4jtIkmhwXxPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784826950; c=relaxed/simple;
	bh=EkHqJbWBHoIivAE2J2s6oBO9ZgP4NmFIrroJW7sGWAw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=p9ozp+WgWQ3jqPusm5pjY0INXw2fXpq0YOfEBmj4G2pNQIeTUugmfIowXo1LtRPF7/AJdYk0C99S+JRlqVfNAekMwg1ERqFcPTgz/1oQIth9W0iCmWp5T+Cq4QZg8/KFZ7ENTMpwPJPLAbDuxkx8lhh7GvzgY5485zYHuHN8dns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEYVY9ML; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEYVY9ML"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-9034b6b7674so9759606d6.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 10:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784826948; x=1785431748; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cXQaINaZ2DlHN3JdmwoufNMq5NytR1Xxi4fVepPOnF8=;
        b=SEYVY9ML04Zg5lm9yKHxRA4pkxXG3QOMTSa4Wl8MVP5UEnfU+qv3GZnyGfRZbMTb16
         elgoKNKxEn/IebKO6YbTQkZ/3yCJpUwmmAJynq36Z3CslXMyBhvdAAEJ7A7X8ABsHDM/
         sYldfu7AejF/TRrWsnT81icAIWnr1ocIV9XDX1DC7SvmkhaNlUXBBH/AcFaaqHiNnhXv
         vPZKUv0d7pDC3tN0Pq4RznRJq8Uq8cGEo/c0HiNfIn5jdEzVWult+SQqlTH9RyUxAJih
         3paDC1VyMguehqFCGiy3UJQrKxLD6jYl9l2IrxDLHrQVV2hGH8rvbtwonXYIOF3alEBI
         U9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784826948; x=1785431748;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cXQaINaZ2DlHN3JdmwoufNMq5NytR1Xxi4fVepPOnF8=;
        b=cbi5ITRhHdGDGQVe0BZUbe2uFsnQ37JurX4JLS5EGesKBbGAWcqGoj60YBrJbQXWJS
         slX+whkwCjrudxUZ7/l2dKEDPoZY+4lt0JqwwgTW7SOdfLSyLUnApaS/82wJCg9KOVoG
         JKVBqpHegGn1VwMiQyz/JHV7xMb6wr1JQQ/A8AWge+OykYSIaNvywtTq44CWYXhiPaZT
         qyiHUpue4w+iOkkLSQ8e0ZDfDFuAF6i7tW+bsAxwRy1ElaJzVMN7st5s52yHm2UwD/K4
         pVVQb/ZIeRDrpHw0CPKHLakemjLO6fv/2JHPn3CoPdj4SenxXSS+ksxO+ygkhQ8yENJe
         983w==
X-Gm-Message-State: AOJu0Yw9F+ET0/oG7L+BZSAsYB98DMg0B2MmJb/mTOav8FMf0Mk80Mrk
	5xX1rXbcxa84G7M+Aq3mazm8MLWrdWF4KiJ5EtjObP8+dFUCSX+jQ0iIJNOe2A==
X-Gm-Gg: AR+sD11qj1mVzGnCzCMr/BH6IsBinJ+gJm/SiKoN6pdYlDbsxPMip5tOUyZyrJuBY1n
	QrcqC6+f0zDevCr808+kwGe6WBypCqmm/xeFNWA640yPW6KLTDPxAqQNnDnZR4mHZGftgbvUE0l
	hpPaFJiHB+1wz7x1gomGDwVA4aUa0S3P4Li7TZ6CIq0p28/Fwe5LMPw2xjOsbSINJPqVtFHAEVo
	NjzQnx1oi40lGp6kaxG9BoKDnjtHLiqcoQJhYZ+UzPBqGi6ugCwRaScNSqAKmml1HXhCl2mgiCN
	tliA4teoZgP9RA+J7UdyRckPQ+mN7X9yKSQbG8ar8T7ddSVGp8Umed3wap3Tveel85nifnjYraU
	Bsg4minbccdfMv+i4RS51fBX9j/eggeoeO2toSKPE7DbTbaFJcA3S1ueWa0ZaJT/6j5+eE9ub1t
	9/9kgI/56e
X-Received: by 2002:ac8:590a:0:b0:51c:20:aea7 with SMTP id d75a77b69052e-5283ddb75camr36804491cf.9.1784826948086;
        Thu, 23 Jul 2026 10:15:48 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.238.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-527d2e75f61sm38156961cf.15.2026.07.23.10.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 10:15:47 -0700 (PDT)
Message-ID: <6a624c43.0bddbea0.8c899.f22d@mx.google.com>
Date: Thu, 23 Jul 2026 10:15:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2405826496582352964=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, enjou1224z@gmail.com
Subject: RE: Bluetooth: fix pending command UAF in EIR updates
In-Reply-To: <4f040d289a0df7b7ee9e9035c8637d2b02083d7f.1784746530.git.zihanx@nebusec.ai>
References: <4f040d289a0df7b7ee9e9035c8637d2b02083d7f.1784746530.git.zihanx@nebusec.ai>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2405826496582352964==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1133392

---Test result---

Test Summary:
CheckPatch                    FAIL      0.75 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      27.53 seconds
CheckAllWarning               PASS      29.79 seconds
CheckSparse                   PASS      28.40 seconds
BuildKernel32                 PASS      26.52 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      505.05 seconds
TestRunner_mgmt-tester        FAIL      219.39 seconds
TestRunner_mesh-tester        FAIL      25.93 seconds
IncrementalBuild              PASS      25.68 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[1/1] Bluetooth: mgmt: fix pending command UAF in EIR updates
WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#131: 
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4

total: 0 errors, 1 warnings, 0 checks, 42 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14706753.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.246 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.022 seconds
Mesh - Send cancel - 2                               Timed out    1.987 seconds


https://github.com/bluez/bluetooth-next/pull/484

---
Regards,
Linux Bluetooth


--===============2405826496582352964==--
