Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2333D4125
	for <linux-bluetooth@vger.kernel.org>; Sat, 22 Aug 2026 15:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787413481; cv=none; b=S4xhugopqn2bU1x+8Y4fC+RXEM5aXa8H0xWT/1nTm1IDyLzkwwEz/96GbLHy5cwU3KfyecPh+QHKLQEKuMePWQSfqh8D6Z2ByQcb+CXusH46k+6c3Ajn+TiZbheOsKkV3FzUMYD3gZbKzmA1kUxtiht3zpkCoV7B3HNOity7qXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787413481; c=relaxed/simple;
	bh=3rWey2kbJON46ty/V2b+C6M9MPwHON/1TWhC87D6Wuk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Sbf80YlQLFt77mRJ/ip403BfXJCD9r8l9BzplZ4BZe7PejCvCk7xeUmhtBJs93LsoEAcv62em3mWAmUeVl13AsgV7qimg6PjEHGifxznXxnhptClR+iGqpvLoe9A4ed5zLeJ0JaNwuBUxcvHgbD55S3Ng0lQ89FJ7KlLJE+RoyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLNbnUF5; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLNbnUF5"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7e9f69ee6f4so2571695a34.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 22 Aug 2026 08:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787413479; x=1788018279; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KHCqsRSgT58qZpR8A9ckmMBhpSqGPvMw7wO0wMym1NQ=;
        b=FLNbnUF5YIRFUpm/mTSQASBOH/9dkxveYwp51HsoJRb0Pa52Yguk/6/AiMVI12bZIT
         Ms6c2ZwsEecOCw0qD82MLZIGZN7aK7CCtRdrQmUE9fGsNURGV1qQQWiZjz0ipFQYyThS
         E3RGUjIBBE5PL1N88yGFWYioO42q5t8Bvymwetb89udLTCR2P264/Jt7JaT2LjiIiHg8
         JSTL2rnUaYnDa8EAXMlki9ME3tDLAmkM2OdmvrxY8uSp+3u6mgo2Gsl7SIN1ZYPftzVN
         J2fzfCONuYYyDSginQ3E3DV/W6I6gwmgmOFkD7e0HvU8zJJzJWHgCNfHLj5Gq8t3nJE3
         rM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787413479; x=1788018279;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KHCqsRSgT58qZpR8A9ckmMBhpSqGPvMw7wO0wMym1NQ=;
        b=e7pvsU545vl5I3OOlJhWueZSXsKrtMM6RTgIjdmcVZtqIGy2fr7RG/H5f9873G+BbT
         OQrd0fPhX6abVFU+hLLL2sELxpfUPx8zOuG4SmSFEaebbsNuretXnJzEzD1n+VqJzjum
         S5dET0h8NjVuCwwkyzPbuetaNFg0emcHIu0CaguZaABl2EVUp1n4NxSQD15qwxT5v4/u
         PRM1Qdl0w4ox/RevjzpYSl5bEdMMGkB+jLivMhQ3+bq7ZsWVhWhOI8Uf/vPMgdjdDkdQ
         xV2DOEDG/niI06O8h33KG7ZSkQtJGiroPFrR7SHicBEMFv0Bauw4ry1ls8MVfHD/4tdu
         EmMA==
X-Gm-Message-State: AFuF++nxOqnhfWu0nUcjB2BDWbmx/7OOoh6/LMyCMqtkfkAseDeOXnba
	OQTn9Ue9ZDp8FrG5F89tZzuE6eKkB6oj5Yo2/pO17xSsNALWKmjHb6AE50dCLP+2
X-Gm-Gg: AR+sD12MMqygv5BCXSnTq1d32dkStWK2WYBGe09VXNUtkkpf5BMYfydJ34+F4HF7gE2
	8nnuVf9d4O+/gF9kAfuR/qH5AAFay99RoSkjrrXjfAThBIuJD1upwmtzUU+Etbk8bDO2FiZASqD
	VU4PsQa/XrqjkAuUOKHc0O+aQsWszYo+ElEdvOmcf3uLKZYOOG5j/w90OxyYTDDi90RkPttUyvL
	TuZu9o7OVEvwwFA63/VpVHndJ6aolQZb+M3aRHcqpXTJ4kQjI6ooSvf98iH+JV8sUpX0npXLaZV
	SbCgBCDRF5ZV7JOjzj4NACJ2gYyrUbV350snf5gI0aaOl8DFqQrU1EmPqO8jBigMZq7Vaa3CAVX
	R9URrHqtMy+RJmPodLka043ungVV+HAiyKniiqxuSIzp7cY/piqKapeXKQjDyJr2wACbgyLLOSD
	Ebmfc28MB5fYnyamQzQsa1d3wGI2t58E1Qx5XaICldvA+/JbAjes8v8bG7S+J7gSMnaXyN
X-Received: by 2002:a05:6830:25c1:b0:7f3:78cc:c4d3 with SMTP id 46e09a7af769-7f46178238bmr16929214a34.14.1787413479279;
        Sat, 22 Aug 2026 08:44:39 -0700 (PDT)
Received: from [172.17.0.2] ([132.196.35.65])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f440023036sm10733182a34.16.2026.08.22.08.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 08:44:38 -0700 (PDT)
Message-ID: <6a89c3e6.7d648931.a3005.683e@mx.google.com>
Date: Sat, 22 Aug 2026 08:44:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3076973219276637465=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nicoyip.dev@gmail.com
Subject: RE: [v2] Bluetooth: RFCOMM: serialize session teardown
In-Reply-To: <20260822150619.3684599-1-nicoyip.dev@gmail.com>
References: <20260822150619.3684599-1-nicoyip.dev@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3076973219276637465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1150209

---Test result---

Test Summary:
CheckPatch                    FAIL      0.50 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      19.49 seconds
CheckAllWarning               PASS      20.25 seconds
CheckSparse                   PASS      20.09 seconds
BuildKernel32                 PASS      17.78 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      312.51 seconds
TestRunner_rfcomm-tester      PASS      18.63 seconds
IncrementalBuild              PASS      18.67 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2] Bluetooth: RFCOMM: serialize session teardown
WARNING: The commit message has 'BUG: KASAN: ', perhaps it also needs a 'Fixes:' tag?

total: 0 errors, 1 warnings, 0 checks, 10 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14763029.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/635

---
Regards,
Linux Bluetooth


--===============3076973219276637465==--
