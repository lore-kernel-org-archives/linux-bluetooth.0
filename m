Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17B912CD96
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Jun 2025 07:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750489591; cv=none; b=qHr/dJVJg5nJPjsA5GiuiGpWHZi7j2/xHGqyaPU0UzpYxkcZIfUH9sLo+EqVx/v4XdU0cqFZUuzYkb86xcgLS4F91FHs093FipSWv/7WcNAusw+Qpm1BhwNu0tK8SpdGl1/7tHYPxtN6LF7RDG+0b7tchH5HBBgbefBAHhonK5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750489591; c=relaxed/simple;
	bh=gCLv6zo83QGJkHbxqJWGHYrNHdx//3CscIFZrF+gTiI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MQNXpMiZjvYArLXLrQ5UC62ylk1xFULW1NuxIFdpHBf4N/JqYjL0lMDW8NPfgqJOt+ynpyNUBvfgg3efV49ptNe+lm5g/RgImQKt3IsjYziTpeib0Ia27LtuJYNW9zTWoDbRllyi+SsHXH+nRdMsMCRxPX7OXxlXQth0OiAU/FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxXNfBI1; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxXNfBI1"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6fad4e6d949so13639626d6.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 21 Jun 2025 00:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750489588; x=1751094388; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L7GyT4dKdsyO1Oy4CjvfKrLQeFX2pzqwBV1VirWEvvY=;
        b=gxXNfBI1ax0cOlG7Tr/cNFPIB6AjEYphna5LLJYMuOQ2LSwoQpR9NF8DauYiu5SQkT
         7BFJAAx1ocMMqqJp4tn/WZANUqTQZ3rZNxpeYk1AsKC4/Uj8e2/AOvELDZ1PP759F4FO
         Y+10CFHVw2Cj8JzaNc+gNo8m9qSGzTEU66ruRjO14WqU2Bxfq5+JTRRjoyygB+83qEV+
         oi+YMmOv01b9mO9w/uj8PsP4ygQnm4G1HjCQVgSpi1OlulqiE3iv/ntZxhy1oB4ewb8H
         JvYOEyGARVTftRROHXszizHpqGwSbJ3SzTA708DTE84cnyfDd3tZlDC6Y8q66gtdr+58
         Lgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750489588; x=1751094388;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L7GyT4dKdsyO1Oy4CjvfKrLQeFX2pzqwBV1VirWEvvY=;
        b=T+r35HvCnZw3Wj/GFHHvy/pW5RMIrkmCtx10Ca80a77y4P/6ZS64f1rude2fHRZ6ar
         swTdCyVArPP32O0tdq9lILtY/bGcD0NqyH5Z57YPQ8Btd1GhSUCJgPp44MmlhA1VmFLt
         6mOUf5q1uBjmZkDtXZ2sMXWLCtLHASHSxa9uvCqGj7r32kRpBDgugeL11Ezw1c20OLny
         n9h4aWzVqTR/pR+PRTu08bBMZvN18oFfMUOLc7mEwnpsS0QExTzWbDywe52HyG1klpDu
         JJkDaxY8nhcti5pcfmoHNjTk1YNSdX7NmgezhkkAUPUnF5CWIbioHb08IH7ThmGCQAkc
         PTLg==
X-Gm-Message-State: AOJu0YwIBZPfKchbLatg3NrYO0wQ799VxEu7ak4goIeGk2VHmFTs2CRD
	v6vhU6bN49hN8vSSaaVY3j+Vh31RCQBfYXAnM/e0vBpXuoq/v4AUtODF4rGJ5Q==
X-Gm-Gg: ASbGncsSJuzsnsrTrBAJubynXwHnR8HyYYL/t9r8r3em7VRPpJArXptyW52LwUfcDyO
	NjT+3ft4fv71Zg6Ly1K+Z9yncVQWvwrCbjnA9IV3Hi5vAUxJc344gU+g+Em+fQX2Omc48VTfs2E
	5+18Te88Fyv7VJTE5VDtkl2d+ZQtDC9hQQT8PRzLAaJN/PzNDskHK5bKP0tyidywuu6lXPmb+u5
	Di6RL7eaTU9hNaIR43YZ/yIIBrHzEHdeh45TdrOjdqyPB1pabg5+zmcJK4iKxXRlx66HB+u1iVk
	KkxY71fTqR8kbsK8cq5gtwkX7LDf49wjiCQjzBVQOKwjdXWO/+oQuaih/l1ax5J2vfs=
X-Google-Smtp-Source: AGHT+IH1/WHNSqfN01IXtrmL1PLR/k/XEXRSZbHcq0gx+1xs/FNQn6iIN3nH7H3pZ3Rk7O8eYFTT/g==
X-Received: by 2002:ad4:5f89:0:b0:6fb:14:5e82 with SMTP id 6a1803df08f44-6fd0a55e58bmr65657836d6.29.1750489588313;
        Sat, 21 Jun 2025 00:06:28 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.192.81])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd095a7073sm20492446d6.113.2025.06.21.00.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jun 2025 00:06:27 -0700 (PDT)
Message-ID: <685659f3.050a0220.297667.7bb3@mx.google.com>
Date: Sat, 21 Jun 2025 00:06:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3081625575295071044=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v2] Bluetooth: btintel_pcie: Add support for device 0x4d76
In-Reply-To: <20250621064013.781631-1-kiran.k@intel.com>
References: <20250621064013.781631-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3081625575295071044==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=974466

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.20 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      23.87 seconds
CheckAllWarning               PASS      26.26 seconds
CheckSparse                   PASS      29.48 seconds
BuildKernel32                 PASS      23.74 seconds
TestRunnerSetup               PASS      462.89 seconds
TestRunner_l2cap-tester       PASS      24.72 seconds
TestRunner_iso-tester         PASS      37.33 seconds
TestRunner_bnep-tester        PASS      5.78 seconds
TestRunner_mgmt-tester        FAIL      130.27 seconds
TestRunner_rfcomm-tester      PASS      9.11 seconds
TestRunner_sco-tester         PASS      14.62 seconds
TestRunner_ioctl-tester       PASS      9.99 seconds
TestRunner_mesh-tester        FAIL      7.54 seconds
TestRunner_smp-tester         PASS      8.34 seconds
TestRunner_userchan-tester    PASS      6.14 seconds
IncrementalBuild              PENDING   0.55 seconds

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
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.169 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 2                               Failed       0.143 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3081625575295071044==--
