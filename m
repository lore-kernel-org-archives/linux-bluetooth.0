Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3285D1C861D
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 18:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761676952; cv=none; b=UW78IPgql72IybvoAXtOGgq+8Y47S42h+gBvwx1MwHVf1GWheZ8WdVjt91R6VJrXZuKiIgap6s/BZMJyk3PCNNyr2jfyZh3k58iJjiCP9efLT6A3QXbQcEx8UrAdaGHqYSHmJNPij5D+6DR7V7QjUOWDFweQZXJar7Sw6lY9e/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761676952; c=relaxed/simple;
	bh=Pr1OY4KhEKtGH/Yo4RZFcgyJtsNT9S4oILwnL3gFS8M=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FoO7qjkcQ6QL/hpGBbKYzzSJwdw0dwUWvebwlDdkO3KFU4qKpTmpf4naJWUgDG55AzLoTk3jhtKILCrCbsCzWgty83a9G+BXl+IIy4dBs4X34U6NDxxqAhJOpc1v8c6/60TG10z4LKwHVN0lw4dwmAEPoL6btHd3YLuZWa+EBiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bp8MQcKI; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bp8MQcKI"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-87c20106cbeso93717376d6.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 11:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761676950; x=1762281750; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8o4Yb/fcZJyXL47Q0V3s1PBW3OWaFwrwELB9apCeDIw=;
        b=Bp8MQcKIotsJNzjS0kH7ECgbjawXHOoqyfcXite5HEkSl49eaNApieVJfP50HNCZZQ
         ++fUynlsOo1KUApPVYLzi0lB/jR+7suu15Nq2xIsVSh6sQD1pgNMK3cECQn4fDhjX/LS
         Ig1ZD6J5lXQgtuWF6YzAqmHzawYyRkrIpfBHNZQAZNTHGh/+gb9VjN4u41fCu+eVwxDA
         /AJFVsMXnoh98H0NcCha9Khru1mW4G0AKNh0FrX4wVipmTFojE8AnRHi132Mb9fGisy5
         5L5pmThZEYX+Zz7yU2Jal/qGomd3dZq4iLnmEBqyX4b5ATyZ05Vk80jzzk1y5D5g6bEv
         Xipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761676950; x=1762281750;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8o4Yb/fcZJyXL47Q0V3s1PBW3OWaFwrwELB9apCeDIw=;
        b=qKNRE+uh1wS+DgosPYOD8nxgEg5p4f0JBoiNYcM7eYTvsG8s7DmcOESuHtf5ajFhez
         afErs5g3tkclME2cj8Fi3UCRhccgBBFBOmogfig7QGYYFDI/yB63aEp3zcex+dGUjEkj
         gKUTBH2eoLeD5IIIHoi8jvZGwVxvqcTjrWrwzXi/HUUlF8qQiYPtdmDUH2qmm4jeXViY
         A462s98VAc/+wUYu9d7teVWja/vLATWEkGT34SSa7SRmYobKWKkKCA5jywMyUE3yFr7S
         TLBRtN7qFap2m9kf7QlM77fMghNnyO4fppOze0OA6whTYf2EzV9KJLkhyAjCQCFuoUOu
         xKdg==
X-Gm-Message-State: AOJu0YydTu0kWfXSJ4fkfxMtNvTiKMWQNhTAusEVIpL0A7y641f265DJ
	ekhk4cL3/Gwtcc2MFBcd0m5AqMiz4oB6LSfB54g6zgrLKzQXyEbxMj6bXDDL3A==
X-Gm-Gg: ASbGncuJT1Q/ywSi0Mkh9+YRYayjDeg22ysiu5R/q/hpzY/GJv+G0lLddUcLB/HUhVc
	ulV8L5AmjoeBRMbKYXNs/eDZgBBcFU00DTCMzb+2g/Spyc3jzmGYkOIHzd1VQVqRmSPS3ESIE96
	VfYDS+0dX0azeh7tspSUEmqtyTKtN0J98YxoqedHgd/5K+pazY+5JyX4B8qHZxmeZG/MfJT70MR
	zSaRAS7IAGAg/fYIv+TM2kwCEBcWBLw2bUH0WGHZmiWMy3gMzbg6mQ30g51WljuVF7IsNzfnkd6
	8yPGOQ7G8a47irs3Rf49OgjKGxdvqTQgzKdmls7hi+kbgQyhj0cHaiw13Cx5n0Wl8CmuSMqCVHF
	r4riFBf0j1a8zD5cVMHcEcxio/hfOj/xN7U0Is8SQYt+BTalW+9kAtSL1XozqUo/QrF7vpuBDcq
	qMGxVgCfb8iadAty2S
X-Google-Smtp-Source: AGHT+IH1X57o7sHu/Fbay3xSK2+YdHmu5vwbXiVtRyg1/hiLK6+Fa3Yn8jfsOsyF1MM5MkrCU9urgA==
X-Received: by 2002:a05:6214:3016:b0:87d:c996:1be5 with SMTP id 6a1803df08f44-88009bd2ce2mr1317206d6.41.1761676949807;
        Tue, 28 Oct 2025 11:42:29 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.58.231])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc51e3809sm79094646d6.26.2025.10.28.11.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 11:42:29 -0700 (PDT)
Message-ID: <69010e95.0c0a0220.3692c2.f5f9@mx.google.com>
Date: Tue, 28 Oct 2025 11:42:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3043742205034800649=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nihaal@cse.iitm.ac.in
Subject: RE: Bluetooth: btrtl: Fix memory leak in rtlbt_parse_firmware_v2()
In-Reply-To: <20251028175632.146460-1-nihaal@cse.iitm.ac.in>
References: <20251028175632.146460-1-nihaal@cse.iitm.ac.in>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3043742205034800649==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1016868

---Test result---

Test Summary:
CheckPatch                    PENDING   0.40 seconds
GitLint                       PENDING   0.28 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      24.81 seconds
CheckAllWarning               PASS      29.72 seconds
CheckSparse                   PASS      31.85 seconds
BuildKernel32                 PASS      24.62 seconds
TestRunnerSetup               PASS      495.91 seconds
TestRunner_l2cap-tester       PASS      23.79 seconds
TestRunner_iso-tester         FAIL      40.99 seconds
TestRunner_bnep-tester        PASS      6.07 seconds
TestRunner_mgmt-tester        FAIL      111.02 seconds
TestRunner_rfcomm-tester      PASS      9.17 seconds
TestRunner_sco-tester         PASS      14.27 seconds
TestRunner_ioctl-tester       PASS      9.94 seconds
TestRunner_mesh-tester        FAIL      11.50 seconds
TestRunner_smp-tester         PASS      8.37 seconds
TestRunner_userchan-tester    PASS      6.49 seconds
IncrementalBuild              PENDING   0.75 seconds

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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.097 seconds
LL Privacy - Start Discovery 1 (Disable RL)          Failed       0.173 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.053 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3043742205034800649==--
