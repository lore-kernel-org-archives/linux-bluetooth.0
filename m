Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24433A7F45
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 06:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786948735; cv=none; b=U3HRHvD8V7ry9N+fGy9DBLwIDZr7YvxQ9pxhPunuw7jSldkeyhm0W8dKt6ruStrhiTfzpHytrC8ecqlsmEz54o1A+EBs2RaPSP4XevjP6g3LoDC8wYkfhNrAUf/+idfiCnxzHNNPAl5etDIJPVO84epBBO8xzRe9we/E/Qo/V0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786948735; c=relaxed/simple;
	bh=a4sOdvq3HTh2z6fQUkhCyJ9SX08y7VLd0AyFt59Yujs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rG2Ol//87JSEfYq9r7nsw6DSyFo3r7c6gC+EEz40+wIoFZna6VQvv8Z1Nww+v98cBID7nZMUafLoCBQFRFhviPnvIj0RQagiH+aLMA0kGbCw4M28xfcPOkuKTubQ6NtAGbTip449XG37hHKTnf4vPl+rNm1KbapQs4ujj6ERW7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fe+RNk1b; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fe+RNk1b"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6b0ab918216so1648564eaf.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 16 Aug 2026 23:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786948732; x=1787553532; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ubz1J8alNI6NWl3QDiBoCr9sUnHuOLCyJvuVwxYSBYE=;
        b=fe+RNk1b2QZN3o2fQQygE08lA77HXz3aNNQOkItCfKVnbBoRBNsTFd0YQXoUmW/af0
         /ZAotSS44fyfQ+nXKcTvASriBZZFMREzQuzHxfkAH3vlYnzaB60VpVLgmTOE4BN4Ndov
         gYQj7SJ6UElWbkhYAHByYYydFNpkZE1rxzKbi01JQ92m7TeFiA/n6CtmuRIk8E9oMpbh
         riD0r9aAidovshGXz1oeN9QtGDr/YPyjlIdh3mVU03rYma2E3GM13G0u58A/K62lLllB
         Dj8qAMRi6oO1hTovlacB7TiKuxdjDvyzNTw1kl8VIBknBFRUkrYqZNofGsmsGdIRjha8
         4N8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786948732; x=1787553532;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ubz1J8alNI6NWl3QDiBoCr9sUnHuOLCyJvuVwxYSBYE=;
        b=l7y2YVSgDBapZeOTtjem0p2C5QmWKjQnx51nOZPdlPXcga4qvlGjuZ2qpx1T4E05/1
         3BVKavNVkvEK8lt4iKaKzlkrAfznX/xzrOYWi3wSOvfP4cyIAXXQWL0y4Jx5rXJ4v93e
         ZMR3h8V8mBURg5jxKtBa0jsSdb4iT25oCTPSZ57G2VUTbrn74iNzl0jCAQavBkrznQxL
         ObEMTEAFZYRSvCUlI83e3S+H1sQ20RwnomslD4s2vq3afZ5HC9CCMedhYfY3GU2HlheF
         ResxZDChes8dyTbh2yJCytdbVL+SIZxQ9bOT1u+TOTTn+DoU0ErIfeYjHveVqxe8iHu+
         Dz/w==
X-Gm-Message-State: AOJu0YwC6nyIwVqfMs/rEDUP6d7BGCAzF3h6p4OMupZEpsnWmInSmV55
	8dVVbSFEqnAWU/7z3SbCSzpgg7JBzWhjaebofffpvoZnklTYGO/1bCV2iloSeg==
X-Gm-Gg: AR+sD13ndvKE4dYbZFiqghN5/6hHuuBPYuqdftzT2/NZcgRS6AhD5yMCfsvK+2EYZRq
	fcRWvNCEHxXEosVhQ3HW/Ukj+bAzlOtjLTDp1uidImAi4pQJxw5Rct78duFG19NZcbjnhggdnHu
	yW6fJnZEXHfdhsy6BjpZkz2oQTOB9P3D/3zuw2tve2P6GftDZxGR/mX1793C+5w0obKAS8UCWBY
	XMFWh393pPofUybsFTeA8k20rTyocpASNVSUOoUjRTHA4IZZOyvUBkjgj8RKXlz8zabC4WEr0Pc
	iG4mDfGdrxodupijo/VuyqHx62lNkRxE3mKZaYXCWa0gQ4px+wFglCXq+9pnhgLc6PKRroxdiBh
	n2Ujz4EMy180mUXTTmYL8WIrimOAXN5/Bd4hvNFiy4xCjjV1AjLFzgkjJI3D6UczUE+y8RrVR5N
	VN22tVSyCXQ85pXEiRG/V1q5L4CZgUWrD8WxoNGNYjq/KFKrk0ARuzHLK1Ot9nM+LAf48=
X-Received: by 2002:a4a:ee14:0:b0:6b0:4199:3cc4 with SMTP id 006d021491bc7-6b0d68ec5d6mr21188916eaf.27.1786948732495;
        Sun, 16 Aug 2026 23:38:52 -0700 (PDT)
Received: from [172.17.0.2] ([52.173.163.36])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b1165ac748sm769496eaf.3.2026.08.16.23.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 23:38:51 -0700 (PDT)
Message-ID: <6a82ac7b.f2d4d140.35bd82.f7be@mx.google.com>
Date: Sun, 16 Aug 2026 23:38:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0645529838779474129=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com
Subject: RE: [v2] Bluetooth: mgmt: reply to cancelled mgmt commands instead of silently dropping
In-Reply-To: <20260817060134.3298439-1-shuai.zhang@oss.qualcomm.com>
References: <20260817060134.3298439-1-shuai.zhang@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0645529838779474129==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1146959

---Test result---

Test Summary:
CheckPatch                    PASS      0.65 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       FAIL      0.36 seconds
SubjectPrefix                 PASS      0.15 seconds
BuildKernel                   PASS      26.15 seconds
CheckAllWarning               PASS      28.27 seconds
CheckSparse                   PASS      26.99 seconds
BuildKernel32                 PASS      24.81 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      461.94 seconds
TestRunner_mgmt-tester        FAIL      221.57 seconds
TestRunner_mesh-tester        FAIL      27.18 seconds
IncrementalBuild              PASS      24.04 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: mgmt: reply to cancelled mgmt commands instead of silently dropping

1: T1 Title exceeds max length (83>80): "[v2] Bluetooth: mgmt: reply to cancelled mgmt commands instead of silently dropping"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.248 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.792 seconds
Mesh - Send cancel - 2                               Timed out    1.988 seconds


https://github.com/bluez/bluetooth-next/pull/595

---
Regards,
Linux Bluetooth


--===============0645529838779474129==--
