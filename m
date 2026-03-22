Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E8337E2E3
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Mar 2026 21:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774215785; cv=none; b=tfEhX5OXGq4UynwixDoHLU6Q8g+9bGz7VCHPYU5L/ZQrVXjOt7py+Esjj4/Owwi1ZHB5grsggxbGsAJ8S3huhCwwUP7xd6Lw8yvxvVzkDIcbYbz2wJYTBcD1LULLS/8MGU9CEX1LSTwQjw2TvK0ve3DweonNTXOZmbafGaZCopM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774215785; c=relaxed/simple;
	bh=BmYq2ee7Lob6JZusTT/ASuAfoqLUseZvexv+4jQ43Wk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dNMWwGsXGhyuf9GJDCF+u7Dds0i+x1IDuAsXD65w7vtrqxb0bUy+Pxg23CLKFi8ygMShO0tXQHBqXhYeCTpTkULeizTDD9I1dCbC7qG9n0GhLVYdxPZKX2ZfYRyJsm9pJp+jksGPfH/GmkFF/TVseMl0UvlV/J6aihObkVnk7zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emAF1C4S; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emAF1C4S"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8c6f21c2d81so343167385a.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Mar 2026 14:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774215783; x=1774820583; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/XD6TfvjNdsfmwhIFbS6NXDG64dt9dhxhyGZt1L+QHw=;
        b=emAF1C4SmF66idmMz2P7rruHLfgzLoZcrKBt4F76mYn3gTpE8qRBIrvGJbrXxAD5Or
         /rKKFIH3orkafPysEmLRfgCdsFeIfsasIo+exKVJrplZKh2wnB5QIG0CZ/dgkcvSNZJ1
         CskR+Z/WXkHav97zj0PuKiF+yjailgvgf+J+v/ENvMsSz252m/Fu5bbREWeAbOoWqZv2
         rMdB4fAtrtO9Nqhkb2Iwbe++AleP5TvD+1FbGjHIayk/N3Gvdef/XMgZ6IOlq8mbIc+X
         Z7bQjHO1exk8vGlpNq2c4AiqJ7GIzfAlW/ihVE23F2WznGX+gBpHYjNuKKmkMbUx33dU
         h2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774215783; x=1774820583;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/XD6TfvjNdsfmwhIFbS6NXDG64dt9dhxhyGZt1L+QHw=;
        b=tD22Nk7wWGYHxsaPBY6ALwuYXqA2fQ71Jf3jPygZc65NNlGb1e5ijn+j4gOnhXmvDw
         82Bx5rMWMKJ2hHEMO2VpYJVPdby268ueMGLMr1yEbh8us1CWu8+/iohQv7SYAwVoIRjI
         nXPj4LAmEPqNRmyIhwRt8dN45N9WH+fbvi7ZbsBBLbXi/l7GPxLAG/oYcWpA4NN1fEDy
         AgfZp+WOEsdKApbG5dN9LnJ/7DrzX8hPa8KaLDSWb0EyzD6sLXH14IfZ7dyNIiuKDssQ
         Dv6Q2V+BaxYAAUy6KNCv0K1yNVsVjFtvih3oZQX6oqMPYHfnIjAB8hKyycvytJdGMMMK
         A3kA==
X-Gm-Message-State: AOJu0YzCwkZALJy116obPLkvLUx/x0lowso+Xpk/xAlCaGxXo16r3++Q
	9P9WB4etDDLTzOaFVVYjQ+X1lH5+23XcU4lACiL97hWgXPMirdltJUcgFkgsFw==
X-Gm-Gg: ATEYQzzktqzxWyMf2txAhczf3edAhAXUAx5UWdmVTzcmDn0+HRrVPuAZr1dFo3hYeqB
	oevm9nJjJhzv8FtcIXr+yNaLIm5LnWTghTgpruHy0p5eIKFp9JYldPA7WHoAFH8KtOwwKIy846a
	4HR+Kxnxcxu55h4n7E3Dc6ixDFi6kDQh4sWXxeag14qXekQcrWSofgzSnhKNUGKXijFq0Wgt9HN
	0Tl0Mog2QhG20ok4fVSGfG1dKApbyC9+7LSy4Dub2BaunxilYbgJVON7PKZbPe7IGoq1EAeis4L
	e8yPvQlUItQXlT0GluVgVD6ELv9C1JKPArvm1EHEwGtHM2DdoyzIbMFT0KwdIq5aPGEr5RMs21Y
	1OQ9efuyAvvnXioAdNypiS7UA4J50vH/7wSqkGJlRkSfGLF0IfDxT7VgRi94SF04y1XjtCPR93Z
	NYJce93zOgsJYUgNEDpt6ymRCBHS9d
X-Received: by 2002:a05:620a:4451:b0:8cb:5176:f00 with SMTP id af79cd13be357-8cfc7f4afd8mr1543702385a.45.1774215782667;
        Sun, 22 Mar 2026 14:43:02 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.70.160])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc8fa74c1sm637651985a.18.2026.03.22.14.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 14:43:02 -0700 (PDT)
Message-ID: <69c06266.050a0220.35f84.1983@mx.google.com>
Date: Sun, 22 Mar 2026 14:43:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4101616599211079588=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, abysamross@gmail.com
Subject: RE: [v1] Bluetooth: hci_release_dev: disable delayed devcoredump work
In-Reply-To: <20260322210849.68743-1-abysamross@gmail.com>
References: <20260322210849.68743-1-abysamross@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4101616599211079588==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1070558

---Test result---

Test Summary:
CheckPatch                    PENDING   0.39 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      26.40 seconds
CheckAllWarning               PASS      28.76 seconds
CheckSparse                   PASS      30.08 seconds
BuildKernel32                 PASS      25.51 seconds
TestRunnerSetup               PASS      569.23 seconds
TestRunner_l2cap-tester       PASS      28.00 seconds
TestRunner_iso-tester         FAIL      32.58 seconds
TestRunner_bnep-tester        PASS      6.38 seconds
TestRunner_mgmt-tester        FAIL      115.69 seconds
TestRunner_rfcomm-tester      PASS      9.48 seconds
TestRunner_sco-tester         FAIL      14.16 seconds
TestRunner_ioctl-tester       PASS      10.13 seconds
TestRunner_mesh-tester        FAIL      12.48 seconds
TestRunner_smp-tester         PASS      8.47 seconds
TestRunner_userchan-tester    PASS      6.71 seconds
IncrementalBuild              PENDING   0.48 seconds

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
BUG: KASAN: slab-use-after-free in le_read_features_complete+0x7e/0x2b0
Total: 141, Passed: 141 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.107 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.773 seconds
Mesh - Send cancel - 2                               Timed out    1.993 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4101616599211079588==--
