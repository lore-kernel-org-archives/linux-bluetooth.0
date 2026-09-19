Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6B733FE05
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 22:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789856358; cv=none; b=dJAQXeA1eJSLmN+h2HJPc2JKhs0ZZHb8UeZ5OdjZObqlQl+7ki0B/kwxNTN/SlccsDGooN7FZczX4jJMxMTUu/fjC32/xRMw3xHHPniR9GAua2ahawKkh08xJ3YwBUaY9QuHO1lbZZGiwY42OpKw4K7nRoSwKNvKxSAHtUuqq3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789856358; c=relaxed/simple;
	bh=RV8TUgacXiXYPsp5wwg8/nVujA/C+JnMVvU+EYTK/0k=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WMdpRPBUt7KzpM4M8gU02cke2IS4JHF2ffRhjsSeW/kOZpFRioOmorGjAOqgOgg25VNex2Huae20cJJuVmLOoevP7NAWK/54km8a0gTmVoNJCILgEZfbyScXKcVNLMGaD4UF+JxZZXa1u+Nq00JZUxxk8ibktzMfcPgHAanYqik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJryU76c; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJryU76c"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d8fbef5018so23856795ad.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 15:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789856357; x=1790461157; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sXmDVL0grA6JART2JPBXauI6l16ZMremMFYRbcRi9ZU=;
        b=VJryU76cOkXooMz+e3ynlwayhbD6JF0KkuJ+Ldvmpw4n1iGGG+6isjvQ5kRLuD7bHg
         8O1eujZ9o+oyKdMj8kgJNWlqV2PsmhG4IHNSBGxpqAwXYetLN8A/p//xdwHxqz4NSpFr
         0ZfuqE4MyH05UVAB4ar6QXG+pGgKUS8H4olOZcLkvKmU7AFlIHYkalsRQNgjhFcsUZA2
         2U8bNYiSIcyZR1irNa2joOcENkyMq/F38kvtc7ebxdg5CjUXeptgjyteBTrrrNqFodwt
         M74d2LwEElGJDlBVPuzdSRvl0KGfMAwH3vO6ZEY+nVOcqLiLzeBTBSdGVo7/uXOUQKo9
         qNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789856357; x=1790461157;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sXmDVL0grA6JART2JPBXauI6l16ZMremMFYRbcRi9ZU=;
        b=hA7BF4IV+Jha7SN53YZaboxZLeEV72GDsmFH1uT23wWQ/2dKYawGee+8ZIns04YVfS
         PNXXdT5JCncaNRViairLTDiq9rmIzA8nff80HOQ6W9pud2t5nMbPiVDB54N0PPCyu5K2
         0QVf9izEcYOJGSprIk7Nny1o/O0WMvJZdanJh3jNix0l4Hy3ArRqyFyslx/n2pjhpzLb
         HV+oef1YSyNhd7oZQsCQVZa9fti7RtC/BHEKORXMY256fAGLv/BWliooD18EmvboGj1N
         WE9HZgVflLZJr1dXOPPdroAydOMfxVyqO8xNIfNVBGC4k+z4II6YvKo0LxeQmctX09O2
         mD1g==
X-Gm-Message-State: AFuF++k5CAzMtJuWizRERuI2caMgJwtEEk1TMr1RYPnCIxG+eUVyeco/
	QAKJ8MI5V+1aI3rKNpKfUZLu2D5Xnk55dP3bwf9a48hOZKRlhjew662hX7IqhdKO
X-Gm-Gg: AYBFou1p0tNHHIoAEUVI62XaNqOnC8oG8KiaYxQYkIp0P/J0k2YyOgfS0bgaRuQ+TQN
	2q+MUEe8pGPC3ZEs3tUr4td75wbaOzJ4leAjz+09XaXE+sgXrnqjVAMRZ9OiulMvawslPZsc1uD
	v4xYFFfT6NuLlNsE3N6tmoPyeakzNAfygMUrUsVFz1l0c6acHyspI+7+NV6yU1dddsZqY2mcgZc
	K7nTymfBE6A+padt/qie3U92BYvnyEsVXQQtFYYVEFvdoupruffGhmBmCV6Z11NQ4QTbBgHzulw
	5zlggxi4YHqZbswzzzqj9cDxFX9ci7X+7wTfPlfGClQZJUGaON46mCYtcsaXRSt+ftXstdRkgQD
	pPehHR5TcXg1RQbpgq7xnPBM0kihZU6eOgKUuAGHxuLEFw+JdGaqtlgnMtKmWToXP5p99KP4lon
	2NxnHVLPStlOKD0fLdTqgm3bOYT/Ff3ui/eJAqjzxjBjphudxy3MSK8ur3l0HN7ZcuGfHkKFmJA
	c3Xnw==
X-Received: by 2002:a17:903:2f81:b0:2dd:c054:197e with SMTP id d9443c01a7336-2ddc0541cabmr55091675ad.35.1789856356587;
        Sat, 19 Sep 2026 15:19:16 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.103.114])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c331aeeddsm7847236eec.24.2026.09.19.15.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 15:19:16 -0700 (PDT)
Message-ID: <6aaf0a64.ed8a271b.1811f0.b705@mx.google.com>
Date: Sat, 19 Sep 2026 15:19:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6145216198469513345=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, benquike@gmail.com
Subject: RE: 6lowpan: add missing pskb_may_pull() checks in IPHC and NHC compression
In-Reply-To: <20260919213638.3314763-1-benquike@gmail.com>
References: <20260919213638.3314763-1-benquike@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6145216198469513345==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1169436/

---Test result---

Test Summary:
CheckPatch                    PASS      0.63 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 FAIL      0.32 seconds
BuildKernel                   PASS      20.11 seconds
CheckAllWarning               PASS      24.29 seconds
CheckSparse                   PASS      25.12 seconds
BuildKernel32                 PASS      20.40 seconds
CheckKernelLLVM               PASS      25.89 seconds
TestRunnerSetup               PASS      462.24 seconds
TestRunner_l2cap-tester       PASS      17.22 seconds
TestRunner_iso-tester         PASS      24.96 seconds
TestRunner_bnep-tester        PASS      3.13 seconds
TestRunner_mgmt-tester        FAIL      54.18 seconds
TestRunner_rfcomm-tester      PASS      3.98 seconds
TestRunner_sco-tester         PASS      7.11 seconds
TestRunner_ioctl-tester       PASS      4.04 seconds
TestRunner_mesh-tester        FAIL      7.72 seconds
TestRunner_smp-tester         PASS      3.90 seconds
TestRunner_userchan-tester    PASS      3.18 seconds
TestRunner_6lowpan-tester     PASS      3.96 seconds
IncrementalBuild              PASS      19.00 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.011 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.654 seconds
Mesh - Send cancel - 2                               Timed out    2.000 seconds


https://github.com/bluez/bluetooth-next/pull/799

---
Regards,
Linux Bluetooth


--===============6145216198469513345==--
