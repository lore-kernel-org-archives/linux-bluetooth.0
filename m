Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270FB345EA2
	for <linux-bluetooth@vger.kernel.org>; Sat, 12 Sep 2026 16:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789230307; cv=none; b=BehYGHBlfvjxrionzRfuqx9AfRtP8u4OLOLCKoAecL7trrzY8tu3qtYwJBZOM++tsEmpG6Q3Sb7D8efpBXulaz3ns4H4JTU7x1wgbnuzQ7fWV4nnQOR+YYL8vsuSimQKMUTqiS6MXQ7QbB+pk6BPTrRMvK/TSkK9afjEP3zpUBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789230307; c=relaxed/simple;
	bh=Pse8D2bCPBW8I16xioxZLbTZMYuAWNYdVXEuShT9rvI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=f0/v29d5RCVyRarEq5/s0Nyj+L6RTI0APNxQU0kUaVZ+PbVph6CHZGK3DooLqugibpTZWERQ5/YEdXfGYFuZgKk9HZsvfd5wf1GqhQDldLIbWsJw5tcR1YG5FvXPN34rBjN7Y3sz9tPDZiR1spbY6MO/kG6hRTMM1DKa3TxaLfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEHXMoSl; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEHXMoSl"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd53691be5so3725935ad.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Sep 2026 09:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789230306; x=1789835106; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=guxDaxWB+UEtwID3q9mmlhv8oZwzz/wencaZ2PUSjFs=;
        b=EEHXMoSl2XAGU/vTKx6flDEBkNQyP1dcwRJ5hMJ0ZXDYeIzj2vYIDX8Jfc5f7fpeAn
         VeZ7XrWiIdPHzy3Rtb1EI2uP2IuHszpE9MJQfoLY+oi4DiKiJMX2DgEO878DHHo8N2Vc
         tXDJOUViJbLV7+Pvok7/qjsVjUG+WEMOUpVCQzA7P4Pk0KRUJskzBPK9zSl26/wzsljD
         aFzIi+TsbcP+PJ7MgZBfKa8Z3dDimdxf8CbqsSTU0y/1P/p1m3h0HTVHIQEptogkLuNh
         R8f+7X8JtWnKC+R2OgJHkKPhxsI1rcMzY5meziRf31/vgKbxohos9KHyMEx1wbqdzuY3
         8tTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789230306; x=1789835106;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=guxDaxWB+UEtwID3q9mmlhv8oZwzz/wencaZ2PUSjFs=;
        b=ftTL9mFBera05cqEvrD/RnoqJI8zTln+iBSU5D7Sfh8zjhvZwnUYkrVz1+1ajowscn
         wlLfAr0mEhCCKWr2CPZ45wC+F9F887nL6ichYbOPkWNf9/xHe7la5fCn+A+C0oSdU1FT
         q/r00iwkLkLh752nb6DaVt2GnhDllj8jl05TlFSnzodMiIsOFkKTIxayB+m/yzn9gwiv
         t9nkPWDY53SSXWqpEX/rDwGh49RkaRPOtV52Rzas65e6sRJ5Et+b+xwLZroMErwAQWjU
         6wyDHgVmBsC+Fvf8j2+Hi5DL3uHgSDiYk+WP0JuQVe89SheIWrl2dwVwbpV7PZDdNglJ
         2fvQ==
X-Gm-Message-State: AFuF++mvh1xMzRdKMuDtcxqMjZAZn+cOaQSwLifLsYiII9WLjocAWeQN
	x1IvzVya1b2tXmMBUYNlepm82fLhvmV/ylBekLh5HNsAXQEO9h2r51n2poTvUQ==
X-Gm-Gg: AYBFou3uKsmu0FiHhD0yqK1KkGsU1sG+VpSk1kEQgHumkwiuYmDTvbX5bD3vYlfddPQ
	/gJuBOeYwIS7cov1p3KzNSykmm0uTPnKMknJ7jMoSo8rGkjQrlEqStfcsfzsn2fgEwW/SMNcnU5
	W+nQu/DxttVvlR5/j112AzZPLqtSjUMWoPZ+135BaMlqa9XqzheuacpdFj78uOk0qLoRBU3VEnP
	YLc6v/Ztxerk63evXFju4kO7l1JPp4FZWHB/IkOHIZGy7lJsXEHYWxpuEIIa/mJ3MzIeXxtXs8C
	Z1jXI7WglVxsxh7+O1qBgzabzr0+v4JkhIPMEmeuW1AS1WBvZcP/w+MHPaSugemT4AOkzRPS+gB
	6P85VFZLrbldUr6bSr40h4XjomV1w9m8WJsIY2MAay1rvJ4zfs4nPxmabWfUOLr/YzyPzgBh2UU
	nbqwljCCz5HUiUfEGc7n2weZyPSX1e4t2s36iD+nA4ZVWy6G6pafwTf/I00h54vuQcUM5qpYUs2
	TMRag==
X-Received: by 2002:a17:90b:48c6:b0:39b:29ca:3d23 with SMTP id 98e67ed59e1d1-39dbc6d20d9mr6381379a91.17.1789230305418;
        Sat, 12 Sep 2026 09:25:05 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.102.208])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365a59b18sm13965919c88.2.2026.09.12.09.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 09:25:04 -0700 (PDT)
Message-ID: <6aa57ce0.8e75e0cb.126d4f.ce66@mx.google.com>
Date: Sat, 12 Sep 2026 09:25:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4412172761945294674=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zhilinz@nebusec.ai
Subject: RE: Bluetooth: prevent wrapped eSCO connection attempts
In-Reply-To: <a45e40e8a5360391b24f8d1a3a0cc7d03e8607de.1789220439.git.zhilinz@nebusec.ai>
References: <a45e40e8a5360391b24f8d1a3a0cc7d03e8607de.1789220439.git.zhilinz@nebusec.ai>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4412172761945294674==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1163506/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.50 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.21 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      21.29 seconds
CheckAllWarning               PASS      24.35 seconds
CheckSparse                   PASS      26.26 seconds
BuildKernel32                 PASS      21.42 seconds
CheckKernelLLVM               PASS      23.48 seconds
TestRunnerSetup               PASS      561.15 seconds
TestRunner_l2cap-tester       PASS      33.71 seconds
TestRunner_iso-tester         PASS      88.69 seconds
TestRunner_bnep-tester        PASS      9.55 seconds
TestRunner_mgmt-tester        FAIL      114.91 seconds
TestRunner_rfcomm-tester      PASS      12.74 seconds
TestRunner_sco-tester         PASS      17.11 seconds
TestRunner_ioctl-tester       PASS      13.50 seconds
TestRunner_mesh-tester        FAIL      15.62 seconds
TestRunner_smp-tester         PASS      12.04 seconds
TestRunner_userchan-tester    PASS      9.99 seconds
TestRunner_6lowpan-tester     PASS      12.32 seconds
IncrementalBuild              PASS      20.40 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[net,1/1] Bluetooth: prevent wrapped eSCO connection attempts
WARNING: Reported-by: should be immediately followed by Closes: or Link: with a URL to the report
#116: 
Reported-by: VEGA <vega@nebusec.ai>
Assisted-by: LLM

WARNING: Assisted-by expects 'AGENT_NAME:MODEL_VERSION [TOOL1] [TOOL2]' format
#117: 
Assisted-by: LLM

total: 0 errors, 2 warnings, 0 checks, 16 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14810664.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.100 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.737 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds


https://github.com/bluez/bluetooth-next/pull/756

---
Regards,
Linux Bluetooth


--===============4412172761945294674==--
