Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12D238FA3
	for <linux-bluetooth@vger.kernel.org>; Sat, 30 Aug 2025 01:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756516822; cv=none; b=eRMc1I7qf5YB8R9KlSkug0kp20ytN9dkcPEpEJ0KPBYf5V+nijzM5jLG1RgkJxe8QgblVRDfz4W72RnstXz5riETsLyS07kUw1fItqao2Yh6xo5Frac3QEcI89hB37XA0+7INU1zMLYSlWkscpcYfY/Gc0TDjxTvGYRirAIryTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756516822; c=relaxed/simple;
	bh=EFL40s4Sy0ByXwynvRZWeYbD1VphHFDR6nT+iDGy4+o=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cMJ1elGWyZ/iDS4UfTpJFp19XBRTBrpT8MNydj5zhfZ6rEEHlfZXB0QtPo32RP5b7ZJBVvp+uCfq+3v8FssjSKSJsV4u6sQ7ZW6PWuUE5x0eqOkN0QXybI9omK4Ev4BYb83KmUFplwSIiKknyHQcUcatyqXhm/T5hrvo3xLLYAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJbIwEs9; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJbIwEs9"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7722f2f2aa4so1507146b3a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Aug 2025 18:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756516820; x=1757121620; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q56lH1HckNE9X/14hhGgFIC7ILfTWpaAOeQ1Mmdpdj4=;
        b=iJbIwEs9lQJ0ovhb05idNqg8bNWcrZVhbLajN+tviw2b2rJ/g7bLi7krZf8mzUmOn5
         DwLJndWvKOJTzYWJr8E0e+vnsO1NpG6udl4zuAJG1Ui3c7OjlisTYZfww4opX48kuoNF
         BXFB78XXUGspcK/b43uKx0Xcf4LxN29YwANPlaKfsw5nlSnRCMKddZlGIvvOx550l97x
         bO9R7627EsaEWp6//ds8WmgayI8nbwNUYSagSSbO9pubwUBfpZMmFAtbwj53eDKZ5J92
         z33Ry+6QJL23md8hJ+nnqjTh2Uu4jlJLzEbwz/p/h1Ei10STZGQu7eTSkvnfrwH4Hii1
         w9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756516820; x=1757121620;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q56lH1HckNE9X/14hhGgFIC7ILfTWpaAOeQ1Mmdpdj4=;
        b=J+9wcKsovMG2LmpnEfO4s3YYWXv8Wo21PAwbjMg+x83+ySj7sZ6QHhpB9rPq1IJhfB
         nRBk2Pgqw8/NUCsleqUDUSv6XTdbgW/eCTDZ8+MQQgMFunjYEc1Epwdp6xo7/xUJLGps
         Mg8XRCuDB2DCV91YyJCSKFL2MPE/9C492WmWgNq8tVGAqqWLJrOYdo3xySCIr8yHcWqx
         QPEEPk+oMHPyiypxD9TZ63p0S3wr57zanDtcz2M9d7HlWHNRDvVZBTpFrnlY+q8nbqNm
         M3BlDl5mQtwdUi/+6RgAaQGfJN89TRcI7uo2AIE5YrWKmRjxCWIqJLQ+KRWVizQz+DDE
         Z5XA==
X-Gm-Message-State: AOJu0YzHEK6OE+OZTOV6VzNjjUHRREljzEaY6au/bOzqHeUQGfcMJx2h
	xHRfE2sHGKfXe1v3PATPKX/H8f0sqie6uVepvjzcQpzeml50maHlS/40HwwI8i/w
X-Gm-Gg: ASbGncs55ByKrBe31SW6lnn7deMT7Okc0R8QnBP98Vbsg/Wx3xw5Q+3H7XpgHD+e9aR
	qR3udPKFsgytVNL5B4w3rhc4q1hZtUKNOUCV4u42JifJ7Sl/7p5y7Yun0C5IOED7iwymknsO9cs
	jpF0lmLnTmxrQ98FkkG+poxoiz8KrBPBTIp/CDAG2rMQmG6clm6njZz+6Z7vnhzGWaAUtMltCQ0
	W6lvZ8HX/UqQ3hm8wtOYFuhNr7yBBSt/IfP/SmWq9AJ4zKEYcUERto5IgZmWrPxz/8w/PcHqE/5
	IbAMUs1lbZCcmKxpHW8cfw7B0RIET7cWknKc2eiApUp29bUcbef4Na4ftRFIW7/Uib1DdZwSCEW
	emzgNP+3OJm6uX2cTK5J1x7wxtag9lHTWl+SaKbk=
X-Google-Smtp-Source: AGHT+IHLurM8lZ9skFKVr/sFCEfzmTPjvsYnROSrVhFsASJsnhwxuT2qcgvsJMfjDM77jEduTSsZQg==
X-Received: by 2002:a05:6a00:983:b0:772:d15:5f55 with SMTP id d2e1a72fcca58-7723e406214mr845865b3a.32.1756516819762;
        Fri, 29 Aug 2025 18:20:19 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.51.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a269f27sm3697103b3a.12.2025.08.29.18.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 18:20:19 -0700 (PDT)
Message-ID: <68b251d3.050a0220.12855.f704@mx.google.com>
Date: Fri, 29 Aug 2025 18:20:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8369062851341986900=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, calvin@wbinvd.org
Subject: RE: Bluetooth: btmtksdio: Fix build after header cleanup
In-Reply-To: <b78a4255d17adbb74140aa23f89cb7653af96c75.1756513671.git.calvin@wbinvd.org>
References: <b78a4255d17adbb74140aa23f89cb7653af96c75.1756513671.git.calvin@wbinvd.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8369062851341986900==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=997085

---Test result---

Test Summary:
CheckPatch                    PENDING   0.40 seconds
GitLint                       PENDING   0.28 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      24.20 seconds
CheckAllWarning               PASS      26.93 seconds
CheckSparse                   PASS      29.87 seconds
BuildKernel32                 PASS      24.17 seconds
TestRunnerSetup               PASS      476.47 seconds
TestRunner_l2cap-tester       PASS      24.76 seconds
TestRunner_iso-tester         PASS      38.67 seconds
TestRunner_bnep-tester        PASS      5.90 seconds
TestRunner_mgmt-tester        FAIL      126.23 seconds
TestRunner_rfcomm-tester      PASS      9.26 seconds
TestRunner_sco-tester         PASS      14.81 seconds
TestRunner_ioctl-tester       PASS      10.05 seconds
TestRunner_mesh-tester        FAIL      11.43 seconds
TestRunner_smp-tester         PASS      8.55 seconds
TestRunner_userchan-tester    PASS      6.26 seconds
IncrementalBuild              PENDING   0.82 seconds

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
Read Exp Feature - Success                           Failed       0.106 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.212 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.141 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8369062851341986900==--
