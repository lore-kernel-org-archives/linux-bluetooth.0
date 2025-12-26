Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A136B285C89
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Dec 2025 08:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766738633; cv=none; b=EYYdD1PuzpbKNwua6c8jiijB6Mdcj1GhGK4MXLE3ARHTlLKYu1VYzCjaXTZT/fCCbvBy/ZLCXSGtTbrpXVCniaMiqHSRBvU8LOgya2NAQNwZGVV6nJL7Oh7u5Sv9YNUECI3fQifKMkKO0cvVKsb1DFP1b/Ttpzk9G4CwzhhwOcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766738633; c=relaxed/simple;
	bh=pTDPzzg7w/kTOgKhAI2opScwzDuJzlgpZUbJAQIQmMk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Qr+4Y+xj3ChDyTOl3gEQWSJpQJu0lhYOT/ddI5xJ4AMIZf7rnMIG9SshpeD1KESVlS4fbjlldq3aF4mmz7Sk+pW7IUm4f22J+YcdKC4Ka8sWwRzPw3zBJ4X14bj2m3D3Tkvy7Sd+aKoBPUp8+JxGb+1oIou+as+ZVK+04ZgHots=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHBRG6+t; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHBRG6+t"
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-7c76f65feb5so5180580a34.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Dec 2025 00:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766738630; x=1767343430; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KSPpsuLDlp4O6FAAg4OtOErCCjvxAowS3rw1BR+jdQI=;
        b=PHBRG6+tKPktYSaHjI74AEjmdDD0hJ7YWa2aqme9L3eGT0XXlRY0kKdHOx3uYF/D9Y
         DixO/+dE2rXLqpi5BwxrYvN6aTIaPcK9au6qI6B9NcL3YQP4DHjOSvod1fiYnjH6Bn0j
         eLSLe8uJ2wbVSMV8YfDn6Lc7oEEsV8smrnm9Qb5UDfMB1alj5I95HgRnr1Ysi45KciMr
         UuBhrQcY8NwNdwnXv+DCcmuujKtwpKFCfZX+453gVfj2ItjMwXpls0HGjmNfnDiYJ0YR
         e7vbPU0g1EerghtDCMgNY85LtGW/INPJFpBrycmerVFIUC8gWiE+MhjrbUK+uNUeXFtu
         kJRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766738630; x=1767343430;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KSPpsuLDlp4O6FAAg4OtOErCCjvxAowS3rw1BR+jdQI=;
        b=CnueZyVhXsBjflOqH1kfWGdkQh2UQX4FuY/OgtvWq8C+z89m0Znu9eoAWSQSLYeDTK
         3x5xy/A8eViJC4tQbLrbTVf+UrxdCCCA/YqWwl+9AFK/yf7BNucCY2FK5xAI5JKvqawZ
         dXtx8//CmjmwiLb11nXydEqokTyr75ENepmX8S5NPo1qZJyE5DXZ3yoVFV7fij9xViqn
         iAIJ87aOJ9GU3tqIs+xi7yvbQNYKuoOj9oS/OdHxZ+yH0ti5k8Q1Xm7sgHMSSTicFiAX
         /fDrwc/7DY8Ashou0Uc4/i/xI1p792OmwdIEBZrtVZiHVSITBA4wIlL3GE5/lItSwyZ1
         Ofow==
X-Gm-Message-State: AOJu0YyahMthm7l6RfIjCHq0NUwCfDccSoUogmoNLH2SVOG02WoLY8ju
	flVYw1jyh/n8m8eK77ApcaCGTnksiogzwGvsjJJO1mz7pBI2zWRGxqiV9dicC58k
X-Gm-Gg: AY/fxX6KvfcN5+QwNbWrZvFfSDjXNzOcL2a9idJLvIrb1BeRok530CwXaNKKih5wL/8
	KaBxVd6G3+UJDdGKb/rWSWkJD2RweiGjE5P7QZuRR3B6WzOXMSrRObD46DZiW6Ryi4heEB0PuU/
	jlPhCFu6M1sc8lzGo7/Y0W1ej03ke2+rMFHzJlO1NgRq7kcxgS/hqAO+efYkssigWQJhqlBmmgE
	2qOOPIFc3EVN3gjJpkiR8GhGMRJNy866L8XH26lQrmlRcOY5eR6zRsh6nqWDWLMdYYdjc8+YRcq
	L1AWd79/cfakSo/I+AvJhQmGDbTmJDoriIaeBBVNDSmi0+wwlbGwJKW3/KGi2syuCBpOG/h968I
	8IkFgaVQgpMNXVvUC3i/9UHOj+ksvNRsZoE6wnO14tHpQnlTI5+xgboL2w9OfaPWvhIVX3fwRm8
	Oxc78Y6UlRys/omF0P
X-Google-Smtp-Source: AGHT+IFLw08CR08gWnS7XDJKJ+5T9rRSmKSkf3eMlrHz4VRzFcIGa/K50H63g+7sRzoOTpq1Uw/ZDQ==
X-Received: by 2002:a05:6830:6d05:b0:7c7:6a17:ba35 with SMTP id 46e09a7af769-7cc66a49319mr14190091a34.31.1766738630258;
        Fri, 26 Dec 2025 00:43:50 -0800 (PST)
Received: from [172.17.0.2] ([132.196.32.65])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc667fa674sm14471691a34.29.2025.12.26.00.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 00:43:49 -0800 (PST)
Message-ID: <694e4ac5.050a0220.1038ce.96af@mx.google.com>
Date: Fri, 26 Dec 2025 00:43:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0347514878452133740=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com
Subject: RE: Bluetooth: btqca: Add WCN6855 firmware priority selection feature
In-Reply-To: <20251226075621.3223336-2-shuai.zhang@oss.qualcomm.com>
References: <20251226075621.3223336-2-shuai.zhang@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0347514878452133740==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1036661

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      25.42 seconds
CheckAllWarning               PASS      28.13 seconds
CheckSparse                   PASS      32.15 seconds
BuildKernel32                 PASS      25.62 seconds
TestRunnerSetup               PASS      561.92 seconds
TestRunner_l2cap-tester       PASS      28.15 seconds
TestRunner_iso-tester         PASS      82.27 seconds
TestRunner_bnep-tester        PASS      6.34 seconds
TestRunner_mgmt-tester        FAIL      135.86 seconds
TestRunner_rfcomm-tester      PASS      9.35 seconds
TestRunner_sco-tester         FAIL      14.73 seconds
TestRunner_ioctl-tester       PASS      10.29 seconds
TestRunner_mesh-tester        FAIL      11.65 seconds
TestRunner_smp-tester         PASS      8.53 seconds
TestRunner_userchan-tester    PASS      6.60 seconds
IncrementalBuild              PENDING   0.60 seconds

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
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.103 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.828 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0347514878452133740==--
