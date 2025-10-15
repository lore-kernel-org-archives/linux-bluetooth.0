Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2F9BE49
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Oct 2025 10:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760522446; cv=none; b=lnM4sBWOAK3Yt481sGvCh1eyKMv8v9iTuW3ll6ijC+pi4VEA2TbZBXat8/CwnEFlyXVM2xStvKcutDQGeJUmxQaz4Pwoyw0uQbs+WhdA9yJEHAy8LKnnzQOMlv0/M8tX475muoWBgc1vPX+22paEAXH6NHYobKkpBVGGdHuLaVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760522446; c=relaxed/simple;
	bh=BH82jFmnLbMa3vA0DAZ3+i7O3xZl7ALWW877E8pqwGg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=e577MWnZ4CJYyHjK4G2dZkuRi7aRS/P59tHSJZULNb3pDGDQKijiJA7eyVNDOWgkrAY+bePXdFs4tY8s1r3pZQ+HYuOtNWe4f4J2uXUd6m1u58cycF1A/KPF3Lr4DB2b/IwQzQ1EOO3xXzfMkOUUHYFpHwGw/RkghYP9xzM24DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3V4tE9v; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3V4tE9v"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-7957e2f6ba8so84426416d6.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Oct 2025 03:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760522443; x=1761127243; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vOVm57izC/5EfdQXpJ4d0kzUC3dqzNkZAIh+QW2XQNo=;
        b=U3V4tE9vQglCd1MUYQf0ipDZn+pepWIRj9q1ovxcE+vunDRwUupNqryGI7RtcCEvR2
         L7E3Nb4txMpqJBFhBfY4LBtfI2qTVMvJuV/qXKOR9WEpHmC8YZ+rw871KY5UMAs6NyTE
         e//PMG7QIKlnSXw/uWzxjaSrZIiBPlxM9UigA3PmRE+HyaKqvbRAZOENCieq81taGWVr
         HN7Y7XHchBOUmZWJVrX/QNBdmfUSF9O3kc1rIPurwch69NESpg4+tYX+adeCrNg8ypUN
         ZEozSxXGSIX1u52gmkW31iT7ioxhwyFsOjkQmLlyNvLpkk4kMh5PmpVuu9XoHnof9hZr
         KowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760522443; x=1761127243;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vOVm57izC/5EfdQXpJ4d0kzUC3dqzNkZAIh+QW2XQNo=;
        b=lpqnDHeBsLPqz0/zM2NjuxZEjIvOT3Utj0FfGoUmLAvoNMluCReQp6icIFIlfz5r0d
         wawKgiNdQb4DuNrjVlTLkXzQI7RL+Y3TJf0ZTykdt06fNnEXrof2yh3sKMrAOTbW7HZC
         stnARP9omiwUHptP6bFR1hJ2dpG8M2QgSmGThgAtdwqwKA2RDWWylzpZ2gXvvVkdYeKn
         FqTQPBP80l8HFicP27e28dcmVuO0AUDj6P/INvGwNzr31hw/MKRWNrrjTnW51EtoLPdf
         P8hRjxAVI9iszImGsAR7JqhbFADC0E6WheaIoJA1dsKC7vzRa7ciD0JZkb7uivD5POkr
         86Gw==
X-Gm-Message-State: AOJu0YxOMmVX600nARcXC3XbYzktB+jtT5O7BpiCVWEpRkz9VwEsM62y
	139vLY7nrRoaQXTDeaikeLvPbnxyDDHC/kNUx7rtrGtsOxIjjGP5AuU2Zk/5ZA==
X-Gm-Gg: ASbGncu/PrWvlU+QqW3lJ9ZYtbt+2g2Di585T6li2GhvOK+29EAIdjoszNhhNaax1sb
	g+8zQzDE45xho72s/eT6y8kSUS/2c68CWXHR5lcNWyPc4gjALX7Fy1PXkiEu0Z48if8W8/JQiXA
	yMtcH/3zaVztBWKsgpATnrvBTWpjyD3JduAZFWZBbyBpja+LPpTxBgEE0CO2Y0cX3VspMQQZs47
	VrtJm3c61sVOv9FeK4mXMymvCh7GfPDNoWpT76+Qc+ZCoiaxpnb+ESY02wnCnp8RZa4YBEsvPUx
	N6pB3stqfiSBeW7+BbOke6ppkSCb+05LRqQ0+vZXn+hHqcE69AccF5z2TTL05k7uFThaY0Sn889
	MydPJjXyxZZiFZL6kVM49WHWkvqXlShlLR5V6cWcmMGyjIsjkUG6xaq+VEolH
X-Google-Smtp-Source: AGHT+IH/QdH4NuM+Sb1xfRPtdxZG9q9+QL+dKLpHilkhWJAv+U31pn1o/+4av/yPk4t72mCcXvpbjQ==
X-Received: by 2002:a05:622a:13d2:b0:4e7:2504:d255 with SMTP id d75a77b69052e-4e72504d74amr135846131cf.10.1760522442850;
        Wed, 15 Oct 2025 03:00:42 -0700 (PDT)
Received: from [172.17.0.2] ([172.178.119.114])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e881d00935sm15349921cf.25.2025.10.15.03.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 03:00:42 -0700 (PDT)
Message-ID: <68ef70ca.c80a0220.1a1a4e.4453@mx.google.com>
Date: Wed, 15 Oct 2025 03:00:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5237436550155277220=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ravindra@intel.com
Subject: RE: [v1,1/2] Bluetooth: btintel_pcie: Support for S4 (Hibernate)
In-Reply-To: <20251015093903.480282-1-ravindra@intel.com>
References: <20251015093903.480282-1-ravindra@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5237436550155277220==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1011778

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.46 seconds
SubjectPrefix                 PASS      0.23 seconds
BuildKernel                   PASS      25.34 seconds
CheckAllWarning               PASS      28.15 seconds
CheckSparse                   PASS      31.67 seconds
BuildKernel32                 PASS      25.61 seconds
TestRunnerSetup               PASS      496.68 seconds
TestRunner_l2cap-tester       PASS      24.29 seconds
TestRunner_iso-tester         FAIL      29.76 seconds
TestRunner_bnep-tester        PASS      6.32 seconds
TestRunner_mgmt-tester        FAIL      125.60 seconds
TestRunner_rfcomm-tester      PASS      9.46 seconds
TestRunner_sco-tester         PASS      14.51 seconds
TestRunner_ioctl-tester       FAIL      10.38 seconds
TestRunner_mesh-tester        FAIL      12.39 seconds
TestRunner_smp-tester         PASS      8.67 seconds
TestRunner_userchan-tester    PASS      6.63 seconds
IncrementalBuild              PENDING   1.02 seconds

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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in iso_conn_hold_unless_zero+0x76/0x1c0
No test result found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 482 (98.4%), Failed: 4, Not Run: 4

Failed Test Cases
Pair Device - Legacy Success 1                       Failed       0.202 seconds
Pair Device - Sec Mode 3 Success 1                   Failed       0.190 seconds
Pair Device - Legacy Reject 2                        Failed       0.165 seconds
Read Exp Feature - Success                           Failed       0.106 seconds
##############################
Test: TestRunner_ioctl-tester - FAIL
Desc: Run ioctl-tester with test-runner
Output:
Total: 28, Passed: 26 (92.9%), Failed: 2, Not Run: 0

Failed Test Cases
Connection List                                      Failed       1.059 seconds
Connection Info                                      Failed       0.143 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.776 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5237436550155277220==--
