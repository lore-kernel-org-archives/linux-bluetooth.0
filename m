Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238A53AA4E0
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2026 19:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788377384; cv=none; b=NDfowR+5dB75zk/NhlId+WEWlFEQ8zRCCr/mlGEuvP0SGN4dnWi8EQL/N4vrykK4TTldCi8ZEBc7eLRbxOqy4IVSNmHU8/KhOk8K8onvZRjiOY79ok/tRlYDDC5/rgacr4fFiXHZUBSdHQ1qtsuERI6bUi+VRMOEHZeu3QTtmVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788377384; c=relaxed/simple;
	bh=/DI2KLM9txkaYzQdHpdeN8ohte1K6k5EHSuqxwLcLrk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SukyCAo9XoRCH8bl9BmMQn/MGEkPl6utC2mJYT1YJUmAoP9iIFGLdGbFqA85lbRl+eQeLE63KSO3g+fJQAknZOgNsYxSVGghIYuAw4Ug3RHxeLXA0G0s2+weSKP9cHJ17fGvQJkBWnxIIScwa5sFhVTJrYKmc0EhgWfl/pIHoVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbFtX1Wl; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbFtX1Wl"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51bfad59921so15295831cf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Sep 2026 12:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788377368; x=1788982168; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XIPbkhG6kmVoSwt7U4aaho9kktYDRkUtUtLjqxqjnNo=;
        b=NbFtX1WladlWtvTyT6Bdtxg0WnOJm6v2w1qsUfoqbrNNpmUjV9ORBTz4Ri1a2YV2F6
         ppUw3sCz7Yb7pEkdDiE7u5a/9XnEnKzmxHsRrRDeDdFFZEMHkz6ZpNX5elUKskqbhytB
         9CEqovY+v5hWJS1v64014AnHKfwODgYLy+3sclE28haXVHVARKXy6+gCc1lqrJ2rZkFt
         SmfgFq4IaxcjKQ34eqd7+zOjGnI+hsbSh/sKEd5mthDAH+xvEMbOU+QBwo/Taa8QBabs
         YadGdiX/6EGy81CY+g+BVDEi1Vkr7/baDWdYo9RdP/AzS4QiYcsawHh4PlW7BGlteHTy
         JQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788377368; x=1788982168;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XIPbkhG6kmVoSwt7U4aaho9kktYDRkUtUtLjqxqjnNo=;
        b=XV8YyUjxin9KN2F/6funoKKKZqROY10yW8UYy/xBouwarm6dkoXcX14CIWjII0inu+
         7UHEd9siBt9N0yXitfGBkq4gCTmInI2j0y545mOCnAW0KK9l7chtMopmswqhah4ku5ef
         kDZX69TX+TdOZ1MD056rk0aW/iu9Yc71jmL42XOd/Ju2P7ksw+QuJ/OYFd4wUVgRMOGn
         vIRmsxTQCPAf54KxXchA6i4Ntp1h3VlVGPcRduT6sg5ZzaQ7KMtQUApPvWSQkasqfqtX
         0v1DMppmBwVCVH8X//SR9Jeydr4GJGqapfBrLZOpGrmohl/r0ueLQi/gmWg8lFKrH7By
         Lt+A==
X-Gm-Message-State: AFuF++nVeCZOLx6aNTydYsvdqCZBrb25vl2DBPp2vRyYeLVXpk6geeyC
	FgHsTm1PQACYikN69iag/KYTZeGrEti4s909EwiiNO4ClPzOIFXBcCCx4/hWNg==
X-Gm-Gg: AYBFou03cNppXdej6Sz//73UA9QXeUdHrSrE6I8q9Pneeqja/PsOauV7NdgVlgVnC5+
	jcPwwYFhumMke9wqGIHgc9eeU8skboxeIPBHIpGOAFA2v4iFTKhkIDvLVThrBgJWWGcZ9wwZWtj
	+x42+q7V7t5XHorfDZEPtpU+6Ybxjhs8Rd7dC4mMcI6PtrbX+1RuFi4YvBS13k1jz4iDatGifmL
	wzlS2Wv/6M2Jrd42Lcslopr+9oQEivsptfiXTKJDOGLeVMQxureN4gpUxYTgafO/3nlS8Iqgean
	oDwIvliTVCumEwbUcZqvLMBRE0Ka3nmBIbGvjvjQAhNrwBcLU/1dQcwoJGsMsrJVJ9THc31uG7s
	hK+dHOdeSeiaIGXmVs8wz5Akh7gjkiTuVqJB7ieDWekLEH9YpXS7aLUwMtb0xRPHMvJVK3KmoU7
	8rE2hNeqjf7WGsKf1tR7m4kU/IyGBZwh6foczx3t1rKZk1Z5V3z/pG6/+lAV0DN9iZXA0=
X-Received: by 2002:ac8:5f10:0:b0:530:4310:5398 with SMTP id d75a77b69052e-53043105660mr17552421cf.48.1788377367667;
        Wed, 02 Sep 2026 12:29:27 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.95.161])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53033226cdbsm25639671cf.24.2026.09.02.12.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 12:29:27 -0700 (PDT)
Message-ID: <6a987917.043ad0dd.1178cc.9da2@mx.google.com>
Date: Wed, 02 Sep 2026 12:29:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7916647139816403883=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: hci_sync: Fix not setting CE length properly
In-Reply-To: <20260902171626.1711932-1-luiz.dentz@gmail.com>
References: <20260902171626.1711932-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7916647139816403883==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1156356

---Test result---

Test Summary:
CheckPatch                    PASS      0.77 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      26.69 seconds
CheckAllWarning               PASS      29.26 seconds
CheckSparse                   PASS      28.22 seconds
BuildKernel32                 PASS      25.81 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      473.35 seconds
TestRunner_l2cap-tester       PASS      65.29 seconds
TestRunner_iso-tester         PASS      102.49 seconds
TestRunner_bnep-tester        PASS      19.82 seconds
TestRunner_mgmt-tester        FAIL      216.48 seconds
TestRunner_rfcomm-tester      PASS      25.93 seconds
TestRunner_sco-tester         PASS      31.80 seconds
TestRunner_ioctl-tester       PASS      26.30 seconds
TestRunner_mesh-tester        FAIL      26.35 seconds
TestRunner_smp-tester         PASS      23.61 seconds
TestRunner_userchan-tester    PASS      20.21 seconds
TestRunner_6lowpan-tester     PASS      23.98 seconds
IncrementalBuild              PASS      24.79 seconds

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
Total: 501, Passed: 495 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.240 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.452 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.556 seconds
Mesh - Send cancel - 2                               Timed out    1.992 seconds


https://github.com/bluez/bluetooth-next/pull/690

---
Regards,
Linux Bluetooth


--===============7916647139816403883==--
