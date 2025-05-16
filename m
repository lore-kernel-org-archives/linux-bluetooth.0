Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0E126AF3
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 May 2025 15:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747407747; cv=none; b=OD5C19necQNDLxbGt1pMgEVG2N6P8bExSWfQhpnX9QSZCJGogN1PRd4qj5iShbnfwvb9rAHRSi7BdkJ1rWxrubwGtQsXsvMKPVHWH2yJRYpGz2DYsHYfTav0u+jPg0Ax65PR0MYlnx+CObPBACiwLa8djq5bBCyvJe4ejluTSec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747407747; c=relaxed/simple;
	bh=Tj3IshRFiZb+dpevi41qotbZZI1XvpJsY+qk41BhZm0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rZ/2zughkX7RnGwZMvW0J1RnakTQDErjEPDI0FszZfkYmvHTOTWWYX4gb6i0GiDiFhX0y8i+3X896YYCKBYXz+i+HgNOMRz/dFbxNJiMdrzj+8Dvdg9uhzsfAoL8RduRNaJgfbeRywi41Yjeqghb1FOm4XJPJpXYS6W9+vZohwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUdgsr2+; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUdgsr2+"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-30e57a373c9so2085041a91.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 May 2025 08:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747407745; x=1748012545; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CWmbgR95/PvJ4UDATiEIYWeRfppqv/ZSDN8tBjOsX/I=;
        b=AUdgsr2+egI9BfBs2HyIs/9UuGtZSV/pvT80+tOc8uEwR/MNxfrM/ucjVMVMnMWmCs
         /eU8pBCm/k/nvtb1BHcmpW3kZguvW/3eUe3MffiBLegXoJGcVswOYu0b85BT0noH3mFR
         Uotd6/cUqrlOfxmHQ4sTpHDXvb6oeETarGjy8TS3NOJkwDgF0rQKz8IILKIXwygBEqbm
         yHrZGlf++iVhrvH1pBVSBwP8anehaq2u7SSA1baCEtXD77KETp4e2qE9PBwvr+B3rBw4
         k6CbY7+NhloB9RU9mNcIOmrgfpttrHuy1xjTOhlNmNzcc0GYHZxLySxEomo0L6O8Eq7S
         GinQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747407745; x=1748012545;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CWmbgR95/PvJ4UDATiEIYWeRfppqv/ZSDN8tBjOsX/I=;
        b=HYFEFqw+pFf9dIlf7cgUyQB8OE0PjLH1/uZ8wiDrREs6eJrHepOTi4Ho/HOXNT1ICP
         Be1LkIKkCxk20M3YCmqoNe9GiPbpJfCrow0ErBA1c8KGGiq5thkjypO3j5CRrX65ijRk
         Qvbjl3LefO7Vm1iua7i1lFZXHjcQAQe2xZzKFdF34XRTGQZWqU+i8mBbU4dxoNa5t+Vc
         qyWFUh3aT2nY3Ar7fgDgcDFqx7fhJocKjRvDjwKQPOSlqhgBS/d1dCLV4ez+oL/rHk/f
         7Msdm4BN66BfFD0+IFwS2czj9SWLvM/s5wYy52Y3Zo8tcOHdPmA5krgXhvtwNF5gXvo0
         +NnQ==
X-Gm-Message-State: AOJu0YwmRs0oiMu8bQCMA9c7l984SUYE4aHBrlWPtl7d/JSJTp8LEZPO
	e7O0C5QdEhMl9zfRr1tufCq3Z/kOrGpqFldfRjxhh2v4BtIlxA51DDCX/LIUeQ==
X-Gm-Gg: ASbGncv8Te5julALxG/P14ihG7n/ov5NdekmnroYljpmcYvztRjpLnNYEx0vvj4YQXZ
	xIGw/f+WgFv27UZUyfsqvkMpfvI0KO5XTHiQLq+rpM356netluzGZ1QQdD3zxocm4OasM2qto2T
	fxzmlFMARDFKTLpzKZOhQmw8Wd9KyqXXbmtdwdXivlj0hzwAB5u38TA61LobTnLaqH+K8rmi8ix
	iyqxAD0Y3NjxKShSF9AJau2JbLkwFbcPSwcrlg1Jm+mBX67slyAmUv+3HSeBwsh5SDcHhO7091D
	8QurAnDYsby3/XABhU/zEsdcUEhhw11Xxoav0Mqw/LlFXL4syJQK3OO3JDg=
X-Google-Smtp-Source: AGHT+IEzyZZa4bX8EADbJzG4e+7SjRBsBcvGBVqWJUuO5DvNh7f6RJ0mWpWg/Ky0uTi01ob29+dKGA==
X-Received: by 2002:a17:90b:33c2:b0:30e:6a9d:d787 with SMTP id 98e67ed59e1d1-30e7d50b04bmr5872535a91.11.1747407745020;
        Fri, 16 May 2025 08:02:25 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.120.128])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30e7d4892c3sm1696005a91.12.2025.05.16.08.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 08:02:24 -0700 (PDT)
Message-ID: <68275380.170a0220.243f9d.1c92@mx.google.com>
Date: Fri, 16 May 2025 08:02:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7088668147842558026=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dmantipov@yandex.ru
Subject: RE: [RFC] Bluetooth: fix races observed when handling mgmt commands
In-Reply-To: <20250516142027.261617-1-dmantipov@yandex.ru>
References: <20250516142027.261617-1-dmantipov@yandex.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7088668147842558026==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=963647

---Test result---

Test Summary:
CheckPatch                    PENDING   0.39 seconds
GitLint                       PENDING   0.28 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      24.45 seconds
CheckAllWarning               PASS      26.96 seconds
CheckSparse                   PASS      30.42 seconds
BuildKernel32                 PASS      24.10 seconds
TestRunnerSetup               PASS      459.39 seconds
TestRunner_l2cap-tester       PASS      22.25 seconds
TestRunner_iso-tester         PASS      31.40 seconds
TestRunner_bnep-tester        PASS      4.84 seconds
TestRunner_mgmt-tester        FAIL      123.00 seconds
TestRunner_rfcomm-tester      PASS      8.07 seconds
TestRunner_sco-tester         PASS      13.08 seconds
TestRunner_ioctl-tester       PASS      8.40 seconds
TestRunner_mesh-tester        PASS      6.12 seconds
TestRunner_smp-tester         PASS      7.26 seconds
TestRunner_userchan-tester    PASS      5.07 seconds
IncrementalBuild              PENDING   0.63 seconds

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
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.199 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.142 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7088668147842558026==--
