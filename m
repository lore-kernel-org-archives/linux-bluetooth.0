Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9A035968
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Feb 2025 13:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739799974; cv=none; b=nAqfnhTKHmpvgGC14OelnpBkJGatDXOa5O2BhYvnx9Ov07e5TABj1Cey0pzejmA2LwiAZT0zefMZdecpYsAeJSaCUW9ebLRMeyctPEqTqg3y+OmZoeMmzaoxri/3TTEXoa3i4jdMQsKUodvx6htbkI5f7Bq70tE1g2U4JFVUi3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739799974; c=relaxed/simple;
	bh=N7YasQX81JhoIjnbuyWeytSRedAwCq0ziU6qqBMQaaA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XAedp0O5eC1v0ds56I26Phbf2v6aYrfadonOM+PZyEhVpX3kkaD7G3gZftND6/aLssfDGvsk51dJLXh1d4sDYjp8573KL8A3PybOX5htSHQjb2Lnrhsgj4IItPHymgpUwWLANZB4hIqckfNxFvXOtQ11+KnlcXZLGSaSk0U+dMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epFDmfBh; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epFDmfBh"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c0818add57so321496885a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Feb 2025 05:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739799971; x=1740404771; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vHacJykXcRmjo168ZRZxSI1ft4QpEjQCnkOe1lDUbDE=;
        b=epFDmfBhpBNaH/y2VBe7nf6plvjJU11xMaPZCizp/5F/iiWX97m6xsKMnPK/ytLovF
         2C0qlLOzEDeCTIm/Xxl6ik1nRzAtRoDS1Z1gTxdvz+dAgLL8Twr8Eqsu0q0lsRgYHmHU
         syHJJtrm/2pof+0ZAiWYzq2D6umJDUd2Td+jZAgbBEVIzgAdotHFwg+WYSzcpXZpdJtO
         ye34x3yYe67ZFuvbKKHpRzbOqq2xN+EZqnsoQxg6/yOWxPImdMv087ONi8TVhr4ZgkX1
         12iB4x33xspNLMFEOCYLCkvVKfJOAKtSIbYsXzn5l9anydAZyof+AuAsfVGf1UWBbC23
         qFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739799971; x=1740404771;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vHacJykXcRmjo168ZRZxSI1ft4QpEjQCnkOe1lDUbDE=;
        b=EzR3jPGm/CBuUeo9gxGR+Na6smFlR7ZcO9FkwsISvv+jobozqlTCBjmy+YCuoeKX74
         qO8N0ftrxawLgbL++a2YqTdCpIq6vqvAjTiDHyYDEBDcJGvk1ojeHZ0vbgtLILlN1SmK
         ED0sC4EWlWWbgalBgdgcJea4+ZNJo77W8+qXmkVGaI6tHbf5FSlqBvKCY1mhZ7b+TYwz
         YJ/SFV3Nz2cZ6mKX1WtChU+y6x5dfdplYGbG4VzTL8/dHAQtmqckOk8CA4K70Vn4y2Ln
         n0OdEAX/npceHZs2xTpDhN/DgF0SSRgOwzdljATabKhd5Vu5Nn2tFFlGofQY6WHOhXsS
         kkzA==
X-Gm-Message-State: AOJu0Ywh4ZBirAqLMn1MRrD69jUTBl4N8pSWmNrRHOJ+EXAaxHZOKBzf
	AbjK9em1Vk6rKFUOoKuu6x9S25YTZ7sQ3cKJjztafuIKp7YuyTjwD+5hXw==
X-Gm-Gg: ASbGnctWGQ+g2Gh41ISGqHJMSORFlV7+3NqmCmzqq/MKCJeO8sEW3i5Oz/tBGJmmqr3
	Va5/IYyefTVzeb7XlUSMxJ+h9FIoCJ163woqx8bj2Lhzk/WV9V7nfXq1Az+M/nEnfLku0UizeAw
	It+XUpDxcokOJXBvvGpuftjnPL22lvvwpiSVru8nfrpWW5MoOrB2oTi3qeB6cTQZQAiv5fi+MPB
	dNjRud1GYofnstUoGFGwGjHsIKau+hN9cyh+D0jH+jfwoVEZJCFcIb4qvayUCOO40BVHIi1pG9t
	uPhm40/qaVnVdlH2pw==
X-Google-Smtp-Source: AGHT+IGbtGETNtVGQfyVnLh01J08QBvol2fbiNblQ9KheoU1fYZ4OFRF5uGQtJbSrboVlNeudZIwrA==
X-Received: by 2002:a05:620a:372b:b0:7c0:8341:31b6 with SMTP id af79cd13be357-7c08aac5e51mr1424257885a.49.1739799971301;
        Mon, 17 Feb 2025 05:46:11 -0800 (PST)
Received: from [172.17.0.2] ([20.57.79.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c07c60990bsm535026285a.37.2025.02.17.05.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 05:46:10 -0800 (PST)
Message-ID: <67b33da2.050a0220.2f49e9.2266@mx.google.com>
Date: Mon, 17 Feb 2025 05:46:10 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3430313159892902875=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, loic.poulain@linaro.org
Subject: RE: [1/2] bluetooth: btnxpuart: Support for controller wakeup gpio config
In-Reply-To: <20250217131046.21006-1-loic.poulain@linaro.org>
References: <20250217131046.21006-1-loic.poulain@linaro.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3430313159892902875==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=934718

---Test result---

Test Summary:
CheckPatch                    PENDING   0.23 seconds
GitLint                       PENDING   0.21 seconds
SubjectPrefix                 FAIL      0.57 seconds
BuildKernel                   PASS      28.20 seconds
CheckAllWarning               PASS      30.23 seconds
CheckSparse                   PASS      30.60 seconds
BuildKernel32                 PASS      24.28 seconds
TestRunnerSetup               PASS      430.65 seconds
TestRunner_l2cap-tester       PASS      20.59 seconds
TestRunner_iso-tester         FAIL      142.23 seconds
TestRunner_bnep-tester        PASS      4.85 seconds
TestRunner_mgmt-tester        FAIL      129.41 seconds
TestRunner_rfcomm-tester      PASS      7.85 seconds
TestRunner_sco-tester         PASS      9.59 seconds
TestRunner_ioctl-tester       PASS      8.27 seconds
TestRunner_mesh-tester        PASS      6.29 seconds
TestRunner_smp-tester         PASS      7.18 seconds
TestRunner_userchan-tester    PASS      5.03 seconds
IncrementalBuild              PENDING   0.72 seconds

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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 125, Passed: 109 (87.2%), Failed: 12, Not Run: 4

Failed Test Cases
ISO Defer Connect2 CIG 0x01 - Success                Timed out    2.679 seconds
ISO Connected2 Suspend - Success                     Timed out    2.751 seconds
ISO AC 6(ii) - Success                               Timed out    1.900 seconds
ISO AC 7(ii) - Success                               Timed out    2.502 seconds
ISO AC 8(ii) - Success                               Timed out    2.516 seconds
ISO AC 9(ii) - Success                               Timed out    2.502 seconds
ISO AC 11(ii) - Success                              Timed out    2.500 seconds
ISO AC 1 + 2 - Success                               Timed out    1.971 seconds
ISO AC 1 + 2 CIG 0x01/0x02 - Success                 Timed out    2.003 seconds
ISO Reconnect AC 6(i) - Success                      Timed out    2.021 seconds
ISO Reconnect AC 6(ii) - Success                     Timed out    1.994 seconds
ISO AC 6(ii) CIS 0xEF/auto - Success                 Timed out    2.002 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 482 (98.4%), Failed: 4, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.147 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.150 seconds
LL Privacy - Unpair 1                                Timed out    2.183 seconds
LL Privacy - Unpair 2 (Remove from AL)               Failed       2.546 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3430313159892902875==--
