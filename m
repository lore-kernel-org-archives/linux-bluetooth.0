Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E43335BA1
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Aug 2025 13:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755523996; cv=none; b=WcmDhRfBFig/LUWaJho98JPtS2Q/clbbUdRg2wr0qwLgfJK1zxF3jSXFr7/LJWGIZhSGKtjLlY2LOVan8BRCJvZP6f9c2Fxfkkt0nwMwtD0+Yhfp1ubPEOYXyI91xXabIRbU/qn4lHkf0BuwHaeWZcsiCWFkqMy0ParSXk7YRCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755523996; c=relaxed/simple;
	bh=U2SGwEr4+klwK8Zutn6w2xMDnzzWpbWJAtAjL6wUIB4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=REoCxrEoJRp2z6DTSGCs0aU/W3pijnTB3f9dejRcz7R22Hy9k51lgYvlyz8eh5gVgMFnppne74OfXTRsfpFsFJVsguwxurBGYo3yZcrtUIo1cl5FjmMHgmLKV95XtLVGqYO9qpYgOpku6+XloXJ1L5fV93Tt71Qq5Fux2MO73+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUCvI4B5; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUCvI4B5"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-74381ee9bc9so3055578a34.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Aug 2025 06:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755523994; x=1756128794; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=j0fJEeG3/MyqoZ+UsJASBWXG9HGrZSAaQWdvacJlZCk=;
        b=KUCvI4B5O2biJlk+zIBbGc1uiQsSbHcurBNl7B4XQY7kW9ZgMUn8YloTuJWKjO29IQ
         3tU3NYlC0dioLpTAdO/KIKklknI9lnd2WjboHmigdyx/4YNW/xKHHLjvgdiuW17/7/L1
         UXipwT1ZRypNQ38iM9xGYBYs9ndT5+/G83z8cS301a/jCG9dzYdBngkp6SKpXOMTKLf7
         xxvYmvpP0iAJgYJ3TyAb5cq7KX5+KCM7GpMyHe+9cbCM/IoR9RZaKx3nkgYCiSUXcy5c
         s3N4+nw9CoSvu6GZBFSvKfCgPxr2w0q1afidcWPifKTGCZNsh40GTCT27x78snW3H5rl
         he2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755523994; x=1756128794;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j0fJEeG3/MyqoZ+UsJASBWXG9HGrZSAaQWdvacJlZCk=;
        b=lho6ga8EbcZ8MdhnM42AZ7zjwSHmxveTMKucoOZ1Bko7v5MGBN5ZoQdNXnVhmaCS9k
         8XCQlBVIJmkOuPOyrh7xOIRiC6SF52hSZ56XS1sq02gufXNVeTzUPf+4njxap5jlHiA8
         qvtj8uRZWU1kKnVG20FgEFQMvPDjz2hYcelws/ETf9FVxv77GmTMV4WqiGHCw8XrD4wV
         EegOY9Lg0ThYO3Ubg7Mrjh1rMl/oJh0UkwBDyRu0xMnwVDY3j37ZuBoS1vHLj06m8nQm
         IR74Z5LHmN93U/MNppm/Lh3NtC5ex6VLEtzoxRpCBXT2van3Yj/o/QZ+qN1TOeZEXqzM
         hNXA==
X-Gm-Message-State: AOJu0YyYE2BQNM0d0qY75t7ieUQ5HI7RFvzVUucb1Rdz3ccatvEZ2U2a
	p9hCABKnwIdz0pL2LEtaIg2RdxHe2pztnEqLzWXfnp7LchDR36HGAfAT07Mlrg==
X-Gm-Gg: ASbGncvVHl1gse5xiUfV5M6m1EwEHnD2HkBAtmbV/PjFSPmbw7lCVxlEdkyppJi0Snh
	+B93/7DInT7obN509btULIO9IRFwJtNxZeFxymueX8wUcJfVRCSOzRCTZSKNJVkzJPjWwRXvSwp
	oFtTY9H29CEhEc9JViGXCbc6l4+9JCjLDO//wvnlxLWIuO5u6EJVPSUXzt3aO9xEK9AXVoSmHZO
	0V5ktJLtXUc2EJKYRPXD01D7E638TYzN3D4hCaALfmPUrRA6xwyrz9esB8UKnKP9mEbf4nG6mVW
	4vri235Mixcpsk3sD1+iAIQiI/pDg3b+0FLd6Rhpm3DufEfaLALUfcCE+/5hut2sR+P/ntAF040
	MIxw5v00zT85VroavZb7jAQVn17/2Eg==
X-Google-Smtp-Source: AGHT+IHKzSw7OlmeCBOqunPwYSzWUnliKtD5kVDZTFxRVl9sfTvy5gABdgRLiw4blRF4tPBDLiUgcQ==
X-Received: by 2002:a05:6830:7104:b0:743:968b:3440 with SMTP id 46e09a7af769-743968b38cfmr6913129a34.20.1755523993651;
        Mon, 18 Aug 2025 06:33:13 -0700 (PDT)
Received: from [172.17.0.2] ([172.212.165.73])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50c94781d32sm2543654173.10.2025.08.18.06.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 06:33:13 -0700 (PDT)
Message-ID: <68a32b99.050a0220.2d0950.39be@mx.google.com>
Date: Mon, 18 Aug 2025 06:33:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5082374759119624881=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, liaoyuanhong@vivo.com
Subject: RE: Bluetooth: hci_ldisc: Remove redundant 0 value initialization
In-Reply-To: <20250818123638.635566-1-liaoyuanhong@vivo.com>
References: <20250818123638.635566-1-liaoyuanhong@vivo.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5082374759119624881==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=992533

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.36 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      24.11 seconds
CheckAllWarning               PASS      26.58 seconds
CheckSparse                   PASS      30.04 seconds
BuildKernel32                 PASS      24.20 seconds
TestRunnerSetup               PASS      477.02 seconds
TestRunner_l2cap-tester       PASS      24.97 seconds
TestRunner_iso-tester         PASS      36.96 seconds
TestRunner_bnep-tester        PASS      5.98 seconds
TestRunner_mgmt-tester        FAIL      126.60 seconds
TestRunner_rfcomm-tester      PASS      9.36 seconds
TestRunner_sco-tester         PASS      14.80 seconds
TestRunner_ioctl-tester       PASS      10.03 seconds
TestRunner_mesh-tester        FAIL      11.45 seconds
TestRunner_smp-tester         PASS      11.64 seconds
TestRunner_userchan-tester    PASS      6.36 seconds
IncrementalBuild              PENDING   0.81 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.226 seconds
LL Privacy - Start Discovery 1 (Disable RL)          Failed       0.180 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.993 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5082374759119624881==--
