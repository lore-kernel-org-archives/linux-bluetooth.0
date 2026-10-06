Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3663DDAE4
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2026 08:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791275558; cv=none; b=h6hBnYqj/2vwWw4nObLXSyEQGg8xmONoB8m5D5x6hanI6TVYnRSgTHN8WAPswVRTHPHQ6+u/UN0HwU6IcE46XIKCyTQayIuo/3t5njn27fR7NxMvYJDNQvVeaWh35Yaz/hLdz9AJ/yQIcTL2Ityzi79vSKgZ2SCO73zlbSEKONE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791275558; c=relaxed/simple;
	bh=JFqdx+BanuKnmqDAE1B3OTrr/dfmx51hYyz+BX2j8dg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mUxZCdpMi4CDUMxHKBQBKzH2j/KlkPUavNhoebcSBmIVU2dfnhjQwSHUY0gu5im94AlUz0MWW/wsQcrOSz98g29/Ohkh0LIeSsdhI6qVgQsj96H9WlLuH5QAK3emCMi5uMT1IxHnTltMrcMv/rIWX9MH3TAgBYyFgHb1ZOeIF7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmiVqQtf; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmiVqQtf"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso1444939eec.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Oct 2026 01:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791275555; x=1791880355; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Y9SLaJ9/9lrWc+A2Ib5x/BJZWc4vGaMSzsjZwcA2DnA=;
        b=nmiVqQtfLvoATGlwi71thIMDqWpsVHy0OEPJo1vstyh9Yb53j4z+YfCqYrvjo9ZURm
         MHLbzoFufDHQLLZgxEvJuU9g1j3g/hUOG1VI2ohbZ8cXQci9CJBCsWQQ6RATyomh4aua
         NI4Ou9v9Qxsgc7AWa2ixOkeNqH0lKiJqMPBbaXHsw06aAg8wFx0/OcHkDa2Rx0/9AY+4
         2TZW/EahBcPTMaIyg/J/hwnOD0hKyci+phR03MWykdc/TijitZq6U4jF+K4oWVvcgkN+
         TBRcxjJAcmmkRvqPgR/W2sV1mKFzrrfIXpDkPpDw8LSCf/D8WNoZt0WEjQUO0CxMCOgU
         +uNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791275555; x=1791880355;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Y9SLaJ9/9lrWc+A2Ib5x/BJZWc4vGaMSzsjZwcA2DnA=;
        b=sME3TSZjRuhhcaDLimiUVUl4Y3frkrEOnIXqqWJF/tdFL4la5hz3x8jIpcJR4+WSi6
         Unw2U8mERjFXBVPldaycZzpbCAUegasKGmgNeuIxolHALMLICLf+0Br8kUf8qj+xjlkz
         ldB6c/Mo0M+krfFi7FuWbcl3XEKRGc+/BHNnsdENGTVubjIbRbFcfZjuegc0CHJVIRFM
         yJax22wKEUtMd7KGZkPQUrtrZkJ0R6egxoUQuejkBw7K9DZJ56egJ+eEhUpk+MpRklUG
         4wDegukGbrvI2kVpuUb+ZsKI+KNIr1ueQPotnEn/hZlvjmRSu+iQG4F/ZUVtZi4XnJlQ
         pzCg==
X-Gm-Message-State: AFq9FYICvE6BoVgKasqwpZ1BKuEBPesUMUd9PKgH+fdINJ0WD5mpjKmd
	ko1SSMERiCDk/pwutaQ766phkkNa5fNJzGUcFQtD+d20HYMZpjI0xtS3uSdZU6nul5c=
X-Gm-Gg: AYBFou385DEzHjRmb4zH69qqogc2825lpP97P3ypZcMk+D05UHCAbfmoTsmA8C1z83W
	BbhRFj9t86QIm0y5eFuIUnPb5aQAdROG8EH+5MHUORoowvIib87ribUNFO7mdLWx8ys5YTC0dqv
	OyHkUXmY8AON39qOvxLrex+NARSLVcfvQB1Lg9rXbNfBXhVK5QcuxabFiH0vdtbwWbLwbuqU3Wl
	MJpGaSA7URpf9c0Agu3kf0uFh5EIyAFbAxQ6/5CZat6ACDc5aUPW0/pZf1NCglaYjIwuUNKsCXN
	T2bvEaJwi+J3wwMm+e7I18jYD3aGZIs727gL/nH0nLP194ATKCeNGJEdIEH3iF3chXg7Tbeg/Te
	0APKXc5dRKKNXtrT3hdL5jS4wFOX9UeBSzjIg/xuqIiZWC2Sx2L/hKbYpdLm2JYC2BqMUqko10e
	3WlXyrS5fVUlX6+NxoznarDPzD5BoJ3TCxI0nrZMOceQL7ZfsSkoVJNFX+irdsf2ds1WX6mwTPw
	QwOeQ==
X-Received: by 2002:a05:7301:2a8:b0:347:8d01:164f with SMTP id 5a478bee46e88-3514e34af89mr808705eec.19.1791275555358;
        Tue, 06 Oct 2026 01:32:35 -0700 (PDT)
Received: from [172.17.0.2] ([4.242.193.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351468b2920sm6355428eec.4.2026.10.06.01.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 01:32:34 -0700 (PDT)
Message-ID: <6ac4b222.695ff321.f867b.1d42@mx.google.com>
Date: Tue, 06 Oct 2026 01:32:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0730119233343282041=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: Bluetooth: MGMT: Reject quality report requests during unregister
In-Reply-To: <pm-bluetooth-objects-candidate-0186-v1-e03b4f1d5ba49b962cec@gmail.com>
References: <pm-bluetooth-objects-candidate-0186-v1-e03b4f1d5ba49b962cec@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0730119233343282041==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1180100/

---Test result---

Test Summary:
CheckPatch                    FAIL      13.83 seconds
VerifyFixes                   PASS      0.17 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       FAIL      0.39 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      22.40 seconds
CheckAllWarning               PASS      29.54 seconds
CheckSparse                   PASS      29.26 seconds
BuildKernel32                 PASS      24.17 seconds
CheckKernelLLVM               PASS      26.56 seconds
TestRunnerSetup               PASS      585.71 seconds
TestRunner_mgmt-tester        PASS      56.87 seconds
TestRunner_mesh-tester        FAIL      7.69 seconds
IncrementalBuild              PASS      22.60 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: MGMT: Reject quality report requests during unregister
WARNING: The commit message has 'Call Trace:', perhaps it also needs a 'Fixes:' tag?

total: 0 errors, 1 warnings, 0 checks, 13 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14869362.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: MGMT: Reject quality report requests during unregister

46: B2 Line has trailing whitespace: "    PGD 80a9067 P4D 80a9067 PUD 80ab067 PMD 0 "
48: B1 Line exceeds max length (119>80): "    CPU: 1 UID: 0 PID: 439 Comm: btmgmt Tainted: G           O        7.2.0-rc6-pmb-bt-functional-v1+ #1 PREEMPT(lazy) "
48: B2 Line has trailing whitespace: "    CPU: 1 UID: 0 PID: 439 Comm: btmgmt Tainted: G           O        7.2.0-rc6-pmb-bt-functional-v1+ #1 PREEMPT(lazy) "
50: B1 Line exceeds max length (119>80): "    Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014"
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.637 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds


https://github.com/bluez/bluetooth-next/pull/866

---
Regards,
Linux Bluetooth


--===============0730119233343282041==--
