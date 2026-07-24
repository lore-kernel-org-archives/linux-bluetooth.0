Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314EB314D1A
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 09:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784886494; cv=none; b=H+HAUIUoWTl20o/4hTxGldxa/cfSvxYDzz9iHZ7zjCclR47p0x3bmpnFSOQkz1MFYHy/hVKR8rfmQSNw3TlXa/SPPKAp2BkaLp2D585TOJ4Lj3VIu5G0yZHgCJ1KuTyqx++lTr4+9bTWqKcILGOxc8sUjN3b1b2AK03IX9yzNKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784886494; c=relaxed/simple;
	bh=OIe2WxgNKyA3znDUhvGan3OcgDg02LSqEmHWVfcCxiY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rLaOR6jW+yLs0KT+5+8j8PVM39PjfQFBJ5T1GlOrGzd8k+FnbfPPkdpfR5GbaozuGPOGFftc+OMM9KnwZL0qw/fpKjcZBnIuRcVypFDGFzLJ2zg18K5+k1f6v+HtGhouaWWpqFalJfiPZzUnv3ejP9bFfL1y4yJs03SacWVkmcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qy56wLuD; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qy56wLuD"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-ca2fad0ae38so173787a12.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 02:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784886492; x=1785491292; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/5CieD73odUXuH9LzR208+m79ETS5i0VosNfsaPLOCg=;
        b=Qy56wLuD5oGHw2xPH7J7LYcsACvfjSXLPdCTsYQ/k43RVSbK7Z+JUWJ+tGwHBlAQ9S
         DcgYhW2L7jem/74wSLCWsT22CW0mcoHPGPUMxR0klcW6V8WKVh5NNH9bgusO3DWL4KBw
         nn7TLCmU6fgBLCDPBufnndY2+zgiK/k3rGGOuuZAhbhKsjb9oFsB3LI2hkt+cELQhUi2
         Lak9xyK5XXrZKtP7Ueoc7CBcxbd2Jfccuu/aH9XvkRkFQB0gws2RuBnDYZ8zT1YFRyHq
         4wp0f8dR4J2rlHz2cD3Dam1oA3vnpGHF4KUPEVBWlUprym9JOnYfhzjujwK1U2DgphdM
         1cww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784886492; x=1785491292;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/5CieD73odUXuH9LzR208+m79ETS5i0VosNfsaPLOCg=;
        b=eQjGFz4sf1mBoRxEE0NP4B4kfEZ31pMQ+DtfyuXICTQigm2UE3Z8umv8VxJZGQmxG5
         YW131aFTv8nokBivWow/9ahScklN6l3oS66PdsdbDfYT0jKVfUfUheEc5CbQCfWGKEMi
         qzlpxhFKDPiie65X59M+NplHXAZBgTpe9DJ86ySdiOIjKBnwt2n3q9bj/WloLUDRwm6C
         kOPGbmpdotrV8PLQwHB/iLyAEDQvJPvWKpCQJ55uwZZihapP3a7kfPJwaUh6oX/Eng4f
         vsHTytsk+3u1Urq8H33LPDTnQ3V9F/0SjY0c8VOKvLOBjo29hBytc94VRfaN/0u6hmj4
         TYyA==
X-Gm-Message-State: AOJu0YyD1Ajesjy2OzhvRYNfDUHcyvSGl2ZzjQ7bTQNDvgvP+zteNmYM
	xBZJyjACc4iIsYn+LV+1Xp2IHgcTZFt8lbT/cNxxhQuCjbC0MRJg4tukVb37BA==
X-Gm-Gg: AR+sD12mzpUhrXIWwD5XEAUUIcdv+oMA9lFxDLrYbyhIP5SA3GXT+aXAOAKGLXL/Hpa
	Ks1g/u2aPiWdZLt7Z6215yr8AFz8/5b1c65xbEvW2y6GXfY1L8xV8IaEy2i/szIR2MJpNfngyym
	M4tuibFjsODgHQ9BLXieiKPC/SRzwvD6zPQXyg9YPMmo+H/ZgIX/vAm1p8g9ZfhRhU/9IG2opgF
	aWXYxBmSJbCtt3znkYFjyTcz0KQE1fpw08ToZ21plAjWQgwaTV3h59YC1hkQIiLTP/UA5c1FIcF
	6qPp9Pj9n/FM6tXkkUMZDwW/E+WHi+hb1xCeDcVBOvzUiL8g8oKWkaqUHocnnb+CdoPKV/2LQkn
	Mm4PzHCsBEL6V5wy0s/O83wK7owSuh5Iy2ujU7XeyJS51NuAWdPSN5WyeyzxiX/Df7vMILsR1Ug
	xtgLLWWBGbzUpazw4tiUQ=
X-Received: by 2002:a05:6a21:178b:b0:3bf:6c08:fb85 with SMTP id adf61e73a8af0-3c44b1ecde4mr7863751637.53.1784886492415;
        Fri, 24 Jul 2026 02:48:12 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.73.147])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147dc193f8sm47593420eec.1.2026.07.24.02.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 02:48:11 -0700 (PDT)
Message-ID: <6a6334db.13be6df8.323b61.430c@mx.google.com>
Date: Fri, 24 Jul 2026 02:48:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2415912757132736804=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zhangchen200426@163.com
Subject: RE: [v2] Bluetooth: hci_event: Add HCI_Write_Link_Supervision_Timeout command/event structures
In-Reply-To: <20260724085406.1884991-1-zhangchen200426@163.com>
References: <20260724085406.1884991-1-zhangchen200426@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2415912757132736804==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1133794

---Test result---

Test Summary:
CheckPatch                    PASS      0.99 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       FAIL      0.60 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      25.25 seconds
CheckAllWarning               PASS      27.95 seconds
CheckSparse                   PASS      26.43 seconds
BuildKernel32                 PASS      24.33 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      459.76 seconds
TestRunner_l2cap-tester       PASS      63.85 seconds
TestRunner_iso-tester         PASS      87.04 seconds
TestRunner_bnep-tester        PASS      18.93 seconds
TestRunner_mgmt-tester        FAIL      223.71 seconds
TestRunner_rfcomm-tester      PASS      25.73 seconds
TestRunner_sco-tester         PASS      31.72 seconds
TestRunner_ioctl-tester       PASS      26.33 seconds
TestRunner_mesh-tester        FAIL      25.90 seconds
TestRunner_smp-tester         PASS      23.82 seconds
TestRunner_userchan-tester    PASS      20.64 seconds
TestRunner_6lowpan-tester     PASS      24.26 seconds
IncrementalBuild              PASS      24.03 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: hci_event: Add HCI_Write_Link_Supervision_Timeout command/event structures

1: T1 Title exceeds max length (90>80): "[v2] Bluetooth: hci_event: Add HCI_Write_Link_Supervision_Timeout command/event structures"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.264 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.260 seconds
Mesh - Send cancel - 2                               Timed out    1.986 seconds


https://github.com/bluez/bluetooth-next/pull/487

---
Regards,
Linux Bluetooth


--===============2415912757132736804==--
