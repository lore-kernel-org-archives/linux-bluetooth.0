Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5823CFF6C
	for <linux-bluetooth@vger.kernel.org>; Sun, 16 Aug 2026 10:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786876130; cv=none; b=Nnk2FFNBap7zPcGJsY/phKm/8TsBC/+gTV5zXzoirEtEoH/BiXVIDC/fQyK6XlIg4a/GpLnnINFooMtTgj3ailUN5899eCpx5U065Mt8SX4S6vw7L71dghxzYNOsOaxmbRjn5xBis9DOthdgYGDPW+N0O/Kr1nhmSXSsqtz9qnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786876130; c=relaxed/simple;
	bh=+dmSdO1OU+RaVP6dQZLtXukcaTBbu6pYwEMjHd3v9L4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jte+BRJazQTAYr4P5Mqjm7bHDdDQmpQntbdJKNcnrqtXISDoyAC8tA/NUluOasYzcj2BO5dDrEpo0NPdfmw92hb0PHlCGGqnlyoZoqcKxwSSYxTbklQQIllf0g6UWMWvCoCXD0yyMO950ZB5N1PAMlLVarUlfaT/FXCYSuRzRv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMHodxrx; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMHodxrx"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cc97653887so41462545ad.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 16 Aug 2026 03:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786876128; x=1787480928; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CLjGqUBrmZp4G/YMHNy6wDQ1bzOa7DnWHJ6j80Dsb6w=;
        b=IMHodxrx62yF9EY/+cBpjndIYTGMSi8t3kKasQFH7Uvt2zaVyCObxIWotknguZwS69
         MG0GoejfmTpOGBIrnXE6w5wPMGWfixvjybMdHE2qSosSfX8LRP6wnaM6YTp5esn5BYJm
         MzI/6O4ocPw4QLeLu++rw9mdbYlbIqxHpQ2vnoXrJfbJtxFaxf0+d/Fgj092b7z4cGGU
         ewTIHM5iFMblEyWNJ4l7m62QVM9x1xGz847LPTOhbKp7BzD1ENGsLJByXH7vt9ChKbK0
         GrMf3WaGeKzsVmCSG8nVUu40MSlovXXaXBXwT51Xab9vNqW1fuCsINrehnJbDL8SGMDS
         F3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786876128; x=1787480928;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CLjGqUBrmZp4G/YMHNy6wDQ1bzOa7DnWHJ6j80Dsb6w=;
        b=p62Lrjsj9g95Ju89ZppI8KojcBmE+JtIi4J/y9WzKEPcm0A5y+KOt2l7XGidBZSm5i
         BY2VPsJ8aYo0uLq30aUjZvnzzBbsR+YzXHQBmQl7ZvcztszugS3xRt1TilYUYKWu0ED/
         OPbqSekXDRIRZKkdX6HA/Bl9mPmkyU3vuC5Fle0Vjpm7RLh6NHCxzK3wmfvPGrerwD1+
         bbo1ajAhwkm1X+hkGAqqcN1Yw6hoKuwBxym+cc8+Dp+0aTjBySrTL+11izaMMi4C4zUF
         IYPC799YelvcDvg9myb2P3kigRgkk0Emec/N5PYtAj6qUuQmPzUnTlznoLI4Rncv0czY
         I8NA==
X-Gm-Message-State: AOJu0Yy/P6JIF9Bm9ykxRTlamnLFgW/6hk+eHLBFyps3UBk3JfLyTfQc
	0zRN3thu8gqet6AxApfLyvdAtJsoIUwLnVUaJCmBAY+5LlycybtAi+kg76qGFw==
X-Gm-Gg: AR+sD136vEn2A7lt+bVwVX6dlWG+lLt/tuPL0iwS2BzwP4KzZFMGPXZXopeEGZ1nZqP
	5dt4WABlilnG9gLGXeNUS/8qvBeglKRymAxQdZmppQWGpPKv8XhgBpka3xyHxFm1tPIbZMUBcAs
	BInjWf+/6phH2ZIWW1JVCbJ5vO1ZxyMRheSrkmWZ3hwbE9TYhEbR0Rjqr6RoyLJ4n0qV5DgKUqq
	JbmkTg973hz5AKFWtwkqPf+L3WVCz/hTlLtPGED3/ydSLjIwpGCrlvC8rPHRmX3k+18eoQRHCCk
	DEFFVg9PHKyNn2FgKp63Nsa0uuhg5dhdFyJC1kVIutzv+8rlO43/LeN5KTxHpiroPi2XvzLYcyK
	JmmPv7bE4UFAOiEf6VcnJS/Wajs4FnqtEZzr0qtIe/BBqniDZ2CejN9Y0JWMMSLrOHv3WIZKF4d
	o1gsjFRLUiDcJi5pIqR4V20hiFzzE8H4L3h390uzmHUye1ocFwxINCJKS/rZVBUrJgUZM=
X-Received: by 2002:a05:6a20:3949:b0:3c3:8651:b317 with SMTP id adf61e73a8af0-3cc71ced4d0mr17569920637.10.1786876128046;
        Sun, 16 Aug 2026 03:28:48 -0700 (PDT)
Received: from [172.17.0.2] ([68.220.58.154])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1413889bca5sm41167154c88.12.2026.08.16.03.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 03:28:47 -0700 (PDT)
Message-ID: <6a8190df.af6ba3ed.36a4ef.8ea0@mx.google.com>
Date: Sun, 16 Aug 2026 03:28:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0611961138586536301=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [RESEND,v2,1/3] Bluetooth: L2CAP: avoid maybe-return-locked in l2cap_get_chan_by_scid/dcid
In-Reply-To: <35f8d2856ef35e1c6314101ee60b16af39d88e78.1786871620.git.pav@iki.fi>
References: <35f8d2856ef35e1c6314101ee60b16af39d88e78.1786871620.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0611961138586536301==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1146711

---Test result---

Test Summary:
CheckPatch                    PASS      2.57 seconds
VerifyFixes                   PASS      0.16 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       FAIL      0.96 seconds
SubjectPrefix                 PASS      0.28 seconds
BuildKernel                   PASS      27.52 seconds
CheckAllWarning               PASS      29.83 seconds
CheckSparse                   PASS      28.43 seconds
BuildKernel32                 PASS      26.06 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      499.40 seconds
TestRunner_l2cap-tester       PASS      63.93 seconds
TestRunner_iso-tester         PASS      83.06 seconds
TestRunner_bnep-tester        PASS      19.55 seconds
TestRunner_mgmt-tester        FAIL      222.28 seconds
TestRunner_rfcomm-tester      PASS      25.22 seconds
TestRunner_sco-tester         PASS      31.94 seconds
TestRunner_ioctl-tester       PASS      26.15 seconds
TestRunner_mesh-tester        FAIL      25.96 seconds
TestRunner_smp-tester         PASS      23.44 seconds
TestRunner_userchan-tester    PASS      20.01 seconds
TestRunner_6lowpan-tester     PASS      30.89 seconds
IncrementalBuild              PASS      35.40 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[RESEND,v2,1/3] Bluetooth: L2CAP: avoid maybe-return-locked in l2cap_get_chan_by_scid/dcid

1: T1 Title exceeds max length (90>80): "[RESEND,v2,1/3] Bluetooth: L2CAP: avoid maybe-return-locked in l2cap_get_chan_by_scid/dcid"
14: B2 Line has trailing whitespace: "    "
[RESEND,v2,2/3] Bluetooth: L2CAP: add locking annotations for l2cap_chan_lock/unlock

1: T1 Title exceeds max length (84>80): "[RESEND,v2,2/3] Bluetooth: L2CAP: add locking annotations for l2cap_chan_lock/unlock"
13: B2 Line has trailing whitespace: "    "
[RESEND,v2,3/3] Bluetooth: enable context analysis for headers

13: B2 Line has trailing whitespace: "    "
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
Read Exp Feature - Success                           Failed       0.244 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.004 seconds
Mesh - Send cancel - 2                               Timed out    1.987 seconds


https://github.com/bluez/bluetooth-next/pull/592

---
Regards,
Linux Bluetooth


--===============0611961138586536301==--
