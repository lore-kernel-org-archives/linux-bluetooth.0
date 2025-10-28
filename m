Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7289723506A
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 07:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761635490; cv=none; b=ex7ArAQfTO1s8BFw84DrAm6EpD+6Cn+mfvrMDcPRxG/KCKzN/AMclXuAUnnAvlUn/V4F0ADUt8kw9k/H3Oni694LjLMcNNKRjLANsmughMUVEP5byYSScZg/6xPTSsC923eoJ/Z6KwILFDOSjC6fKSosamh2V5WCahE3TKCXMIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761635490; c=relaxed/simple;
	bh=6C4liRbAh4eIvd7rF+vp/rX9U/MySyEE6Sy1SZHPPMY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PKSEhlFF7sbP8yOUvB/0KbhpSsnvByUc2eYPaG9ULuL18C8ri8VLQvaL/GcMdb0xqXWEfE/CztwJqYSptFSutntJPIFb+LsCIibDsO7VdIOcA+zAwefnRUxJqgt7eQSbGEttUCFcQDu5bz9yEt4jkqLR9dh9eD+INZQRptT9Dc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=il3pgcnu; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="il3pgcnu"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3401314d845so2125634a91.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 00:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761635488; x=1762240288; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0QHWchdfc1vZXI/L1Y3NCeK7lbgNv2REdODTHcWSsxM=;
        b=il3pgcnucbWHppBPI6h64QBT4sBG0OCw2fUhocvlVbZ6+JOxpNkXkeQB0j/CKFTjsL
         /H9YjOmwDm6J8g8cDsYKJmcBBFwEplqfTH87SAicUspyTWARVUZ62FpMVtW5G488qY1N
         UFf475XdhLTJJnn6QWk3bYYJxz50PReUZLiSB/liy4G75LdI5gGtJ31rbycEv0eMndR9
         x5ZS3uNNl97IOU1J+FvbWRPOxJjBHscXMA1nur+JtpuZDUnKSBYw4kkK/Jw2S/e0d7cA
         UplTmtuHOR7B4IMCTSfjwr3IIXwObbCpRgX5kYqIqNCcO3Nun0RbENNqXmN/hAJ3o3aE
         Yu9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761635488; x=1762240288;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0QHWchdfc1vZXI/L1Y3NCeK7lbgNv2REdODTHcWSsxM=;
        b=T+wBJY/qdldIE3t34s/aKsYpYm53lmGdgzqRf+XAxBlJlFMAyqycAcDTWGw11N3rTW
         DTAVgfx4cgi4qdKfb7jm2M/P7Vkj6+kCI90QMByNGt8A0GwPXJ8Q5KMhRgx4ETvZBn04
         tKD4yShOZ78v7O/b87ffaEmTKyopONaWckjup7jD84iiNzO9gYG4myagzCkMt0nhUbcQ
         5B1wMfdq7UxiNsxwESsQ+YMnFTzA8ow/hm6PG6QpQ8jn3c+rhcO8k4e6zWZWyYTID+D7
         3ASS/75PmLRoQ52/x36pg19IwdLvVcdePW/4ZGVeMFmOVrJMqouzugvBiQ/UwigFFDh/
         R7Wg==
X-Gm-Message-State: AOJu0YxuFzVvxH4u3TAyh0B3YcKYI0YF1nXjdDlkMon0+8WqdwN7to7T
	JpUUc7IXvJdvpBRTNj/I2i5QHA8q0LoDWk39Q+7frB419GEpZDG6SSPAdjEBrg==
X-Gm-Gg: ASbGnctSaOoivjK4w7uAoM33bVw/yPHC/rp8Aoswj6O8lnzh6YGwSlvRnJUDnhFV6ex
	SR9FAZ6o8jyqmGJpZzjLbq2ehvYiQOzOs5T5cXgawe95i3CirAr/2KMUFrVW3PuT4Kh3YskuGUx
	Alqebmk53E1ZMFwGdrkYnuDfMau3R/psmz+S+C4j9NeqquzD2AYqwJeJw4PXWHV9aY2uinXJ6z7
	eoOJV0edQXvk1u1eUMiDFREDIUWULcGcyFq2IrCsB3f0nLPklHQwXA7nOpP1f/1QYl6mzlnDOhm
	wAtBClb0JNiEP/XT4M/iGZirhaOIPmUsFmtF36aG8Vs6b3RpVFhBAFVXSe/Skb2J2Q9Db7KKta7
	jS3xl876KKnEyMb65UjPBOP616Hz9VSZzV2A5yp6AkfSVSgMmipVf3U7BkcsJEyCdLLetgCEeB8
	4icxKB/DM=
X-Google-Smtp-Source: AGHT+IE0S4x6372W4oNK9db/Qui8naFuStX9fBZFGMVkhv0b6te7FZOnrNVcDRW1irfjWo5jjAXU8A==
X-Received: by 2002:a17:90a:f945:b0:32d:a0f7:fa19 with SMTP id 98e67ed59e1d1-34027a7b8acmr3388626a91.17.1761635488360;
        Tue, 28 Oct 2025 00:11:28 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.211.71])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414068f7dsm10705656b3a.48.2025.10.28.00.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 00:11:27 -0700 (PDT)
Message-ID: <69006c9f.a70a0220.3239c5.2eb2@mx.google.com>
Date: Tue, 28 Oct 2025 00:11:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8121363194919032106=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, max.chou@realtek.com
Subject: RE: [v2] Bluetooth: btrtl: Add the support for RTL8761CUV
In-Reply-To: <20251028062413.252504-1-max.chou@realtek.com>
References: <20251028062413.252504-1-max.chou@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8121363194919032106==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1016578

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.38 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      24.56 seconds
CheckAllWarning               PASS      27.15 seconds
CheckSparse                   PASS      30.41 seconds
BuildKernel32                 PASS      24.52 seconds
TestRunnerSetup               PASS      489.36 seconds
TestRunner_l2cap-tester       PASS      23.22 seconds
TestRunner_iso-tester         FAIL      29.29 seconds
TestRunner_bnep-tester        PASS      5.90 seconds
TestRunner_mgmt-tester        FAIL      112.57 seconds
TestRunner_rfcomm-tester      PASS      9.02 seconds
TestRunner_sco-tester         PASS      14.30 seconds
TestRunner_ioctl-tester       PASS      9.83 seconds
TestRunner_mesh-tester        FAIL      11.45 seconds
TestRunner_smp-tester         PASS      10.70 seconds
TestRunner_userchan-tester    PASS      6.35 seconds
IncrementalBuild              PENDING   0.79 seconds

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
No test result found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.101 seconds
LL Privacy - Start Discovery 1 (Disable RL)          Failed       0.159 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.087 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8121363194919032106==--
