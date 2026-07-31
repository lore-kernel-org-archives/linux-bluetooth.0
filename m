Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8E63546F5
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 05:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785475431; cv=none; b=sY6cP2BzVOnNR17um8XhV0d/g60Wf3/9wZ5FPf/FDedCBCrBb/rSw0nzLTbd2/zjrwGw91R8cOcFuGsZDXObcjLkAKqLflX6bb9ryGQv2W2hK4X3BXxsAtA71+YcKerrytJr4ItAWBSVlRh2pcO0+iGz9uejcj1OAR9RRsxHVik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785475431; c=relaxed/simple;
	bh=mYT1PF+hgAujxgAJ2DDbOf1eAntupRgaNMJLeNKKu7U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RNW0hb3K5P9eiOiPsLz3r3CqqPNZEboP2tMlfSJWouRLAqpNSKXX5/lSvT7N8UIO/2snzLhmbRCE63NHHbw4ChplXoaPbkKDBqcPY+k1XZ+ZVUZFP73wK+6TGwOvZVXfa2w83JtsuOIMxPigmoxp5EepjKV9ickRzFYIh7CcDoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6zSFeB5; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6zSFeB5"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c0ecfaee7so3418481cf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 22:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785475429; x=1786080229; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7zBDzFV9M2XsAFQBH1nK/ynVNuU2a6rBT03y1Xq1fio=;
        b=B6zSFeB5y5nPNxLzA4Rx8YjVWsozFBdv+C+80utEYNqahZPkG/Q8hPJ2b+lZkX2Kap
         5x0PHTM9aBj7bYd+T1xqvlwJSbR8npUNrU3/ES7iP6E+pANKsqeq/F1RNB9HfbYJzu3G
         q0BdgxTwn0y/Fm2/ZdwLzBFV3WgqYwgp72yRmBj9QQ03AuqniwlXYWwnOlENvjRos1SW
         5Y0svXGUURqqXXB7Vq8ZwXiIBhyu3VBniLU6RwGa2kjqd9qXNYX2VLCm9SanlpsJTi7V
         pkYNn4DSIhBiim4oBRy/uq6dgEJB9JoiEIEGSh3OZl0olZqfEBKRzvkWqtO4vFLNRGZ4
         tvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785475429; x=1786080229;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7zBDzFV9M2XsAFQBH1nK/ynVNuU2a6rBT03y1Xq1fio=;
        b=T39fuUAg7qvTaUTJsR2olOal9VO/MeLUoIedBYN2HEfj1rhWK8Ma/TpIfG3qUeX+QZ
         ZK2fYbaJ3QjQQtYRPP21G/bRrMcxx3Gnv3eyBOG5KCNg9p5TvSVyKJLuouAAiD0RpLNX
         eYmRkGQnCqwx9uz2MTwwaAlqvJbfcAh9iAk3ZsKxvQRt+nQhhJ/XqDxmBZyC5jn2/fJv
         U2ChfzM50T01TBcQK4A1jYnNf/5cQcjCmqltndmUJkzb/fU9fbEKcIb8kdkkRE0IpqC8
         GhCuNBLoEL+ExLWGc5ZLgnALYjV5o6BS66keccNhfNnmDOVHmut7DsuH05FIJ1mkwlvF
         xTuA==
X-Gm-Message-State: AOJu0Yzc6d6uv6b79oAcDFSWLtWYNxCmjGwAx7tOW1Pn01qrhE6ZUGgX
	oeFInRRSzcqkKiSiteGfjuSPgI+xcJU0dGVwcdXcgKZLGXJF7O5DztxL1c+enw==
X-Gm-Gg: AR+sD10c54b5fMheel1KEyLTVe2Qg7JJSDypTKI8YeCZg8anF3kdHG+XORs4cMArpI3
	NLBJ/zif6Yh/gPVzbScwt6v54CiQu7XaW56cYa/UlTppWX7ZNoNPHS+WmZQJG39XT4K53Ak4aYI
	TV6FP7Z+fhMXDJypppJiOieLXSc74IIMkS7Wk6UvEkhBqfDHHIqNIUwt6p8KWL0TirD/JSUoRHL
	4bPEpSaZ5DxC1GF0sZszkr0Y4as5mCq7uv5B2uY7781ORYr+a/TUxl60scqxmowvaLKbUllEwNq
	LJRJ2imPAXuaItsft7dt2r3eNG4HKOatoc5XPx7BdLH4XjYVovZiZb7bMMkX2VybBXBMgHapaZp
	KzWfruRj2qZb4r70yspAJF7+DqXW04wXxfJw6Q5wZoKZBpr+OgDpmUcfoeehRnrdUZknM2FpCBx
	IQYe/yxcnKw+FUJrmQNSYJqMH5i7lfoH+TAZIun9vfDdI0aduw90wMgPFGa+GuJI4AwJofIUUOe
	ijYmw==
X-Received: by 2002:ac8:5d43:0:b0:527:7813:a440 with SMTP id d75a77b69052e-52b4b026d30mr6919821cf.49.1785475428824;
        Thu, 30 Jul 2026 22:23:48 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.28.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52b4eb6a862sm1350711cf.16.2026.07.30.22.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 22:23:48 -0700 (PDT)
Message-ID: <6a6c3164.b5fdfa5d.65568.fac2@mx.google.com>
Date: Thu, 30 Jul 2026 22:23:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5334123962958294832=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, amirabudubai@gmail.com
Subject: RE: [v2] Bluetooth: hci_core: Queue out-of-order ACL packets
In-Reply-To: <3ebd064b6e7a9d3d8d72f1da618765affbd30cd7.1785459643.git.amirabudubai@gmail.com>
References: <3ebd064b6e7a9d3d8d72f1da618765affbd30cd7.1785459643.git.amirabudubai@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5334123962958294832==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1137797

---Test result---

Test Summary:
CheckPatch                    PASS      2.37 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.46 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      25.83 seconds
CheckAllWarning               PASS      28.48 seconds
CheckSparse                   PASS      26.83 seconds
BuildKernel32                 PASS      24.89 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      465.00 seconds
TestRunner_l2cap-tester       PASS      63.40 seconds
TestRunner_iso-tester         PASS      88.38 seconds
TestRunner_bnep-tester        PASS      19.60 seconds
TestRunner_mgmt-tester        FAIL      219.23 seconds
TestRunner_rfcomm-tester      PASS      25.92 seconds
TestRunner_sco-tester         PASS      32.07 seconds
TestRunner_ioctl-tester       PASS      26.64 seconds
TestRunner_mesh-tester        FAIL      26.21 seconds
TestRunner_smp-tester         PASS      23.73 seconds
TestRunner_userchan-tester    PASS      20.46 seconds
TestRunner_6lowpan-tester     PASS      27.71 seconds
IncrementalBuild              PASS      24.81 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 489 (97.6%), Failed: 2, Not Run: 10

Failed Test Cases
Set Low Energy on 6.2 - SCI Setting                  Failed       0.345 seconds
Read Exp Feature - Success                           Failed       0.246 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.522 seconds
Mesh - Send cancel - 2                               Timed out    1.990 seconds


https://github.com/bluez/bluetooth-next/pull/520

---
Regards,
Linux Bluetooth


--===============5334123962958294832==--
