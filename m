Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E9A3D75D3
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 12:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788180325; cv=none; b=p35+gPIkb+O4DXaVG/DAW9cYmIyLed2deuX2zPso+xVEm/XpNjFPjLlPWd9qHkhJkHmHIIW021Mvain4HLC2mzDTo8qZNB8PoWhJYSAL3AvC4KyOH6LG+nU2Lem2gimAsEk6VJasXR7H7snRhrlJ1zlMkz5HS176C1pEcbGrUQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788180325; c=relaxed/simple;
	bh=MbaVqCXj/LAVfY7cOuxmGzsRNH1mKU8iXxIh3PZ0pWA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=TEqCgUp97L9kTsls/eykANglgoX4fHlq6cK5FgYdue0JpkJv36XBJp3SElhdGXyQko4tzZAusSt6vW0/Q9D1NxI47FjN32P+SRY2+TOeRB0iRsH5R9bR0PpdClBTwhU/KHEcr7zODIefBtk1Mvf1YLQaYycd1WEyAo6bLVKh7+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWmz9VvZ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWmz9VvZ"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d7195706f1so33308295ad.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 05:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788180321; x=1788785121; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3dJNZ1YWbVbkYT2uj7UhVNJLLjmFkPi8ju5st14BKB8=;
        b=PWmz9VvZ3SWyEt4EXHL9UqsGmcEfFh+aOTJktnS6Q5xIaRx4PBB6fo8zt6MFWs9MTK
         YgWulPD2rxNIDQA0RptJXnB/L3z9tNihOqycgnrwB0Bu0MEU4GKoETKUTOs9a/zHzRgG
         KGHVkMiaw5PZA1sTM7FicGZ6ZNhy/9s32/TgKvz/LE/gIfsRIaWMbmZzDx8L0KPTyMcZ
         Qmax2RCvXXfWJMmmGsrxJEUD6VzRc3khOaPhuNyUiZSl9hSgQ1YHnaDTzPi/ik8LJHAk
         pzHNnwCb1thc7kOp9a5zzYtgYXguJWqDJeRT/VN9Q1vHdla6dUsNXIZAinLIcKfObL7X
         FNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788180321; x=1788785121;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3dJNZ1YWbVbkYT2uj7UhVNJLLjmFkPi8ju5st14BKB8=;
        b=Zgc+wet9GpkRllr1YHL/J2MbijRhk+UYQl0TiBcJor3mBGljM+amwbamN0NJ1BSHsm
         ZBIvQohwsoxJjQ75wZAqChKv5iigvl0tjxiobBJCqJZgDxNb3vfLicrza58IbMwnFgfb
         DH3mN4hkiy0XnqC2PoSOi3lOvAfhoox+RiWCJ1Rhww806P/IcT57vBxehynaW8PGvgkV
         BO8UKbJ28j2pjJV9RysFUxKOknwsJo+KY0Ageutrzrt4ZWUBm9ZzDQN9iJu6+NMjYWP6
         DVFgCQ7W2ttUJqJZ+XZOQHeX++TVBFUWBFVLPvKH8oA1RMKyz0Zzan99Xac0ZlhM9eNd
         ayDw==
X-Gm-Message-State: AFuF++mykEH/Ve5FqT6dnxv7bTdrwRH5M0jxHsmVLVXhfMJ3WMU2JJ9D
	No+cdh06jHCdD1RdqTe8Tfl6PfkQEW8AByU5VksL0YtbT2x9Lf8Db30H9tOTukoK
X-Gm-Gg: AYBFou2qieP6ec8T6gF/1bsIGycJwlZUPw95n+cga62DHGnucVnqpnQ13h0VKlYoomT
	ToQ2ixymVhWuaPq/z2REsrug+PzSO82z4jQwNrb9v8kQPIPCed5x0ddjm47uDJ1w4wrkHhfeQMq
	hqxzZSkWRWPyFuLEsAuadO2FhXiRg30a+n073URYEUBPl6FaD5HujynXpnansUCjo8Q39n2X4oA
	ZMfGo7YWprfoTFVp/BXIkDz8qgbDphe1BRgp5qsLzid5U66X02OzACs/SCNgZdgThjH84o8YJIV
	8/mUKCc0lhpa9GjSY4XY+rOvuT/yhbRSNgUfD0DGf0sgwkwjfLo/EZPND5/CfqirhXuaO394516
	HinzAcoiEMil8LM9W5tnv+CZJowquVjg29n8pyRVWNqKLhNE/+4TWGpz0uh1Z9bWDyqo05ygJz2
	p7S8LWOBMaX2vYI3E+ELPVKUC8zJQ13MsJBLEu2ibBFKBgXzQw1cxxrhLyovTyS8xZAw==
X-Received: by 2002:a17:903:3883:b0:2d3:716e:e2ae with SMTP id d9443c01a7336-2d94a73dd34mr5676335ad.6.1788180320980;
        Mon, 31 Aug 2026 05:45:20 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.119.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f8094dasm31568560eec.13.2026.08.31.05.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 05:45:20 -0700 (PDT)
Message-ID: <6a957760.3865fcc3.b1744.84fe@mx.google.com>
Date: Mon, 31 Aug 2026 05:45:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1985511276665852618=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zhangchen200426@163.com
Subject: RE: Bluetooth: Reject controller operations while powering down
In-Reply-To: <20260831084329.3141802-1-zhangchen200426@163.com>
References: <20260831084329.3141802-1-zhangchen200426@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1985511276665852618==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1154312

---Test result---

Test Summary:
CheckPatch                    PASS      0.80 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      27.35 seconds
CheckAllWarning               PASS      29.76 seconds
CheckSparse                   PASS      28.43 seconds
BuildKernel32                 PASS      25.98 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      471.29 seconds
TestRunner_l2cap-tester       PASS      67.65 seconds
TestRunner_iso-tester         PASS      110.72 seconds
TestRunner_bnep-tester        PASS      19.25 seconds
TestRunner_mgmt-tester        FAIL      236.77 seconds
TestRunner_rfcomm-tester      PASS      26.49 seconds
TestRunner_sco-tester         PASS      32.93 seconds
TestRunner_ioctl-tester       PASS      27.16 seconds
TestRunner_mesh-tester        FAIL      27.28 seconds
TestRunner_smp-tester         PASS      23.79 seconds
TestRunner_userchan-tester    PASS      20.44 seconds
TestRunner_6lowpan-tester     PASS      23.18 seconds
IncrementalBuild              PASS      23.60 seconds

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
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.266 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.768 seconds
Mesh - Send cancel - 2                               Timed out    1.975 seconds


https://github.com/bluez/bluetooth-next/pull/671

---
Regards,
Linux Bluetooth


--===============1985511276665852618==--
