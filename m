Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120111EB39
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Mar 2024 15:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709825552; cv=none; b=iYyntQ33hq67VBUIH+FPVhiUCstOdxvQOjksYFQweasCLQG1Az2Aj8d8TWorADbPxQT9FoTU6Qq4OKWHjoeD362I4VEM+HUD0aFnCvEe7CCY/TEDq7hm0I+rtqvn9t7rXYuRU64qBVdS6ODdHQQG2Px+/JB5AxboETp5al5ObbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709825552; c=relaxed/simple;
	bh=2fO3Ysa8WbTkOTFKBaCazjhdXghm9/19vPy+vkyTSvE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FXtWFxS4B/zHI1xc3/V7y7RMsvuIgv0taMYa5pe+/uqBbhNr1cboIFOYk3qhX9F29MiLditaLLSAa5hWkmnlDHgvt+H/Jhq7P3FZ1xlRwze2ZWu0aGH28KpjlFtN8I+elHGb5JL2uL5UrGPdDmZcqHIu0aMRI8eG8uASfxypHCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VxUXbmjK; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxUXbmjK"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-690ae8e6cccso739346d6.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Mar 2024 07:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709825550; x=1710430350; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9l5FRRAAH+BvcDOJ3pDt1nautCuhtZs6Ew0V2xrJJyE=;
        b=VxUXbmjK4U10Yjq2cWPya4pXNwDjPG9+9bQKW3Tw/N7kxALuo3uFTxlSQ7Xa+Gc10X
         N22Za5By1pQXKVRJO5bg87y8HYqMxtswuPpKLPqyU9nDncpzjLlGQfuGLkiVy6MmG6LC
         BmJgncvMKjoQb6jd/C7Ue53GfyHzwWznApDUxnpFLKKx5XA7r7XYZw1CUbOCNdON6jDq
         f4ovc2pyAZfj4YBqloeZW5I0ogWVgBiU3QA5UMzbd9DdJkbCssY/zkTBnd06D9o4N/Ir
         34GDkgp5WdRS20flo3g1W8NerMFwF7mIDs8PhsfVP/nHsDoEwcB7Ib8pUQ3qQkfs45bd
         /wBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709825550; x=1710430350;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9l5FRRAAH+BvcDOJ3pDt1nautCuhtZs6Ew0V2xrJJyE=;
        b=l+N78RluZAJmHTaXmzF6faxMhiOMba8R/UcroVGCp1lcMpRMIW3cynntVo2t103zOS
         pVi/4oeYQ8Lzl2ORUQeT/bQGCvOAbWrkleO0RB0Z/edX+9l7NnLPuYunG9eDKjn3eb1E
         QyCNEAmFZuTHHz5OmX/AunGeL57R57k76n8jby5tsYN1cDMu69pN43KS1gP6og6sQd0i
         ggeRsCBCxVXTEK+1GxmIcdPTqEvzWD0UY029PiKMIY3aQW0j/KzsZz9efjXmITY5r0nI
         db4ig7cpA921jsdJl71pnr/+OGN/fKA6Klr6ujTPOd0VgtncxHcQeq4IdHL3MslIDT0I
         zfVg==
X-Gm-Message-State: AOJu0Yzc3Mq81UcPHZPx1ikRiQwOvGOagE+x0oH0Zq/RvgnIBCUZ13X6
	r3y+JFQU4P3a09BJJm+KdZDQAgIQ1UjKOImMvoD7kUHJB8ZegJWyCJzCZaAM
X-Google-Smtp-Source: AGHT+IEEdfgLJA9P88LHTtZYPIFtzhF/srtsMls9JX+F590HP459krUm0tfFJR7yRT/HpBkwI15Jpg==
X-Received: by 2002:a05:6214:1905:b0:690:914e:8314 with SMTP id er5-20020a056214190500b00690914e8314mr6166437qvb.42.1709825549761;
        Thu, 07 Mar 2024 07:32:29 -0800 (PST)
Received: from [172.17.0.2] ([20.55.14.230])
        by smtp.gmail.com with ESMTPSA id om13-20020a0562143d8d00b0069049135a69sm8675649qvb.118.2024.03.07.07.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 07:32:29 -0800 (PST)
Message-ID: <65e9de0d.050a0220.8f802.490f@mx.google.com>
Date: Thu, 07 Mar 2024 07:32:29 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1630098515891951528=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: Bluetooth: Fix eir name length
In-Reply-To: <20240307145823.962436-1-frederic.danis@collabora.com>
References: <20240307145823.962436-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1630098515891951528==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=833441

---Test result---

Test Summary:
CheckPatch                    PASS      1.49 seconds
GitLint                       PASS      0.58 seconds
SubjectPrefix                 PASS      0.20 seconds
BuildKernel                   PASS      27.83 seconds
CheckAllWarning               PASS      30.87 seconds
CheckSparse                   PASS      36.08 seconds
CheckSmatch                   PASS      99.59 seconds
BuildKernel32                 PASS      27.28 seconds
TestRunnerSetup               PASS      513.19 seconds
TestRunner_l2cap-tester       PASS      20.14 seconds
TestRunner_iso-tester         FAIL      32.72 seconds
TestRunner_bnep-tester        PASS      4.75 seconds
TestRunner_mgmt-tester        FAIL      112.10 seconds
TestRunner_rfcomm-tester      PASS      7.33 seconds
TestRunner_sco-tester         PASS      14.92 seconds
TestRunner_ioctl-tester       PASS      7.80 seconds
TestRunner_mesh-tester        PASS      6.68 seconds
TestRunner_smp-tester         PASS      6.86 seconds
TestRunner_userchan-tester    PASS      4.94 seconds
IncrementalBuild              PASS      26.47 seconds

Details
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 117, Passed: 116 (99.1%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect2 Suspend - Success                       Failed       6.233 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 478 (97.2%), Failed: 12, Not Run: 2

Failed Test Cases
Set Advertising on - Local name 1                    Failed       0.103 seconds
Set Advertising on - Name + Appear 1                 Failed       2.149 seconds
Add Advertising - Success (Complete name)            Failed       0.105 seconds
Add Advertising - Success (Shortened name)           Failed       0.101 seconds
Add Advertising - Success (Short name)               Failed       0.100 seconds
Add Advertising - Success (Name + data)              Failed       0.105 seconds
Add Advertising - Success (Name+data+appear)         Failed       0.109 seconds
Add Ext Advertising - Success (Complete name)        Failed       0.108 seconds
Add Ext Advertising - Success (Shortened name)       Failed       0.108 seconds
Add Ext Advertising - Success (Short name)           Failed       0.102 seconds
Add Ext Advertising - Success (Name + data)          Failed       0.105 seconds
Add Ext Advertising - Success (Name+data+appear)     Failed       0.113 seconds


---
Regards,
Linux Bluetooth


--===============1630098515891951528==--
