Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3593B52F8
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 18:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787337600; cv=none; b=u39coDjEXJCxGivdrOMfnx2I/7sVAAmp/MzfddNP0xRbUaHLgRi6SxzGb7yvECdycgtSh2JALq3g4VCPtJSMGfhqvUWD+F1qpmTq3P1mJL78YrcqKzsorHe291jftxW1+pGfCe242BL3jfWaC/yaxZ648scahucWU+FeoAk1KEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787337600; c=relaxed/simple;
	bh=4/YQwMB0rglYHRd7GW+hy1727/h0jbK5nwyuazzCCnI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lEXtXCgYMEpM67ALtTIz5WJP8K++rjT0o2+mpDQ6P4y2YjBtXa+m8TAUOR53ceONtARcmhpklSLG9SXa2+0TohZgmkO4Tkb9MI4hV2yER86vMPtHQROhPwZGzyHk3K377p3JzVzQ3Gk0BvYSbhTWzYQfICPd44hEEgpRd7F3Rl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RkvWTf5N; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkvWTf5N"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-52d7ef16f91so6415781cf.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 11:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787337586; x=1787942386; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dc2iu/To7QEKheQ1spIEGViuHBsWnpkl3oaXYWz51MY=;
        b=RkvWTf5NAEUsyzWCIteF069VEQhhQ+MEhbcqaZ/sxMvzphPXh2m7dKPwZQcrGQtABo
         rgroS4ublROU9yVdSeEapus5LK50hDHgE5s4kGgusZQYBreVIKryH5+edSlJKNiQi3Mc
         dz262RULTZxVGztsoISgSY4qKGUoZiEMuF5OQ7tCn0f00+smg987H51TaIQDPLjNo3V/
         UW9+J6T197Oa1uFXrhlNH+azjm8gSaGPmRwbI9WZosy6jUc3z94rR3HQFbx0JgPQBz8q
         FwSOyL4fKxxTPSZd0/mnpIiWO5OrouXM3NkEWaCk+iovcEVPg3AKGQdE0vmOIbG/lF6y
         kQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787337586; x=1787942386;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dc2iu/To7QEKheQ1spIEGViuHBsWnpkl3oaXYWz51MY=;
        b=SiEFOYL9iaIYgehlQZngS6EoluKFhB/UGCbn9pLf0UTlT1YISzShfyZZiN/ZTPNNCn
         78362rhE3uf6HlxK7jcoVtEju6wu6b6l4xASoWBK53n2zeBUPbtkvSWiGvGy8t/PhxSt
         kLCzgQlFZa2uHOE5JttbjufjsSjF/mn4kgMoP+CKZDdOqmpImUImzvlEkO6BvAol/NWj
         rESqyprFrNwfvqOrvHz1o9fHmSA6psFtx9NzR1GLY8K80wXYbMMXFRH/i+3EYpz++Fox
         qG6WCf74mrml9QhC6VRmRD4CYQAlG8pTMfdQW7jC23AkIqNyHNvmIQ36ja09FgJOIzVX
         q4Xw==
X-Gm-Message-State: AFuF++n+qsMiiZBiBxl7YVhLY6Evx10VBcLXbQ5nM0kH1w/brY5WvCeJ
	CQQDECb/nwDsSDQ5rHD/kQj/iqxG3QfTxXsdrwcarWRGjEiIsmfFZqPYdldO1L26
X-Gm-Gg: AR+sD1004PjU99yiARbzYljrRhgGqK8JE7QucLFpQycHmArAMc+ckkpKkqqmJaF1cOd
	JPxrEvi1VCJJiqbuIW94JU66eeWBOedwTeb3hM6yTEvJcyv3GvVIB72L3ZMGW4rliv3AQIYkCk7
	22rIOpaptuTCE23A5G9reo8p81xBks/LWGTygLir5fi/qNjgygh942q0N72WH/fFsMN/I9UzttF
	OdL03Ld+jNZNAfsBl/GVv75DclscpO7/mzrIqvaRfD2AUgPLRYlvnkYvzuH6yy+BcIw/OOBZF01
	AoIjR4EUgca7pYf8cLIP/3pU8OLDMaE6pOkDE2R05LL0msscr+B+zGaNhPHDBHaib975/oVAJ7A
	b7lTHxZWhpFQQggWCGQO8Ya0WiDrii26FQJ6chlxMRF0CQVNa7tH+AE88J9vm1vITOlAhdRiH8D
	95x6/PWG414hROt1aFbtWFWfpXwJ2AlSiO8c1c0pvZqVpabfEgYNtTkh7btzb08gEmfWo=
X-Received: by 2002:a05:622a:1919:b0:52d:844c:b0c2 with SMTP id d75a77b69052e-52e09b9f24bmr1809801cf.12.1787337586067;
        Fri, 21 Aug 2026 11:39:46 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.36.236])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52e099baf17sm827371cf.12.2026.08.21.11.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 11:39:45 -0700 (PDT)
Message-ID: <6a889b71.bfbe2361.15a23a.26ce@mx.google.com>
Date: Fri, 21 Aug 2026 11:39:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8865149279233907410=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nicoyip.dev@gmail.com
Subject: RE: Bluetooth: hci_sync: Serialize local codec list cleanup
In-Reply-To: <20260821174350.3034506-1-nicoyip.dev@gmail.com>
References: <20260821174350.3034506-1-nicoyip.dev@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8865149279233907410==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1149960

---Test result---

Test Summary:
CheckPatch                    PASS      0.72 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      26.27 seconds
CheckAllWarning               PASS      28.87 seconds
CheckSparse                   PASS      27.54 seconds
BuildKernel32                 PASS      26.00 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      471.98 seconds
TestRunner_l2cap-tester       PASS      78.99 seconds
TestRunner_iso-tester         PASS      108.23 seconds
TestRunner_bnep-tester        PASS      19.14 seconds
TestRunner_mgmt-tester        FAIL      220.33 seconds
TestRunner_rfcomm-tester      PASS      25.53 seconds
TestRunner_sco-tester         PASS      31.73 seconds
TestRunner_ioctl-tester       PASS      26.14 seconds
TestRunner_mesh-tester        FAIL      26.17 seconds
TestRunner_smp-tester         PASS      24.10 seconds
TestRunner_userchan-tester    PASS      20.12 seconds
TestRunner_6lowpan-tester     PASS      23.38 seconds
IncrementalBuild              PASS      24.45 seconds

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
Read Exp Feature - Success                           Failed       0.252 seconds
LL Privacy - Remove Device 3 (Disable RL)            Failed       0.424 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.684 seconds
Mesh - Send cancel - 2                               Timed out    1.992 seconds


https://github.com/bluez/bluetooth-next/pull/631

---
Regards,
Linux Bluetooth


--===============8865149279233907410==--
