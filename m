Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7763D1715
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 12:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773923191; cv=none; b=XzKB9jTC48sSZl9wfObMLJpP+EsQ4cxCogiLbknKvR5ZPCb40MBJekN3Sk62eP7G7yCYLcEuP5ne4OFEEYwoJAcFeeyRQeGgREGeOhuaZardvEy6hYaEQV6qShB+YgMgofulFsnHQZH4mOJwMkI9Co802BOR/DWYhXaCj4zlsHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773923191; c=relaxed/simple;
	bh=uJOdQQ7B2yCLklkbjpNQvwCWdPJqRBFiuWYsmYK9PZg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=acDzN9E0HH8qdS+85cDsH+YCRv8rredKj9RS+2x2eT0QMHzmHbImAkIhcSQzg+hFEBXbvM0DIcmmgcfrjk5xjtmMadmUy6FGZwqVR5gcIPKI/y61ivZ1yfrD/bEE/05MKxecVfIhlar9hAcbFiQBTuOar5f4N42o7qTfrKpNv3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtWLUtlx; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtWLUtlx"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8cb20bcff5aso54728385a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 05:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773923187; x=1774527987; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wn4wwfL3xd1gqZtCjIVYVaH7kmNIpYyS5p7yJSi6f+M=;
        b=PtWLUtlxTthECn3EXE6yYMLbewzgRr8/J58X3/my65CYxWh7jbuVvhbnHm4ZXVMRK1
         70fgdyqAc5j32grYeY1RgW/4RmAsKl1cRSQGahfS2X9JJ2jSNOKqB6I3X0rRDRxd/Phk
         pws7X6cRv7MSbmeqNf+WvT3Tlfal1lzd5G2j1B7IdIUxrqj0YX6Vu3oVTTcWB8K4OKL4
         ySWuVsCho0Iu0CgwzYAt/B81/0ai7Wm0VkzC5TZNJ987Lvxt9TQ5Z+KRva3wrvzXVqUp
         2ByEApNQlXo35A+WcXc7LcdiQIYO7VkvpPI0QEkz8FUfQ6AmkXSPCqYqQAmE7rV2WE9u
         cj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773923187; x=1774527987;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wn4wwfL3xd1gqZtCjIVYVaH7kmNIpYyS5p7yJSi6f+M=;
        b=TuD5LKHPLjtjZf7QPmrknLsToa/27g44gRZ6FAhalPSHWVH0NXg6f1eev8xkTiKzAJ
         3NxxwPrF7bXxhkYj5Et/BawPPymaCI5pIE7pSmc20voC3OMzIfbuTxkc9sHN9amJvn0y
         EO4dkSQhOPwJuJcx1awOFMqtYGhNB7Zdc4leFlpkfYqEmEdauDXQzOtcg0ZlUCbqQANR
         r2/73QZgcpHdeb3uWHlk2m9Cs3rLjg4N7xDkjZlTCJa+jeJrH77cdcv9gXbrAkhQIFRU
         AikWqUzFnPl1CzNrm2VtCp97FWLgy0/Qw+eP22k32u4Sem2jiRBQbEIKxj766bgtc1G6
         Jz+g==
X-Gm-Message-State: AOJu0YwowwHY4eGO38Gv6SMDlXdJ/AGSvefzkv1tOgLZeKI/a2B8aH9O
	l3qq5/aBSTinIZtjWwbkB2O18x96Nmiv4br7yUQvbzw3tKYttRSiWymstE4RfA==
X-Gm-Gg: ATEYQzwYUAgREN25alUjH5jN8NmSqv1OOOmxbVP6IQdLG7ovl6I2yq6tTnZmVzEqEcv
	VIPv0TcB4PErekYzAmPUUgvZVmY44XOtTOiiFYS1Q0e7kIGgMKcogqjyBUVKCI1N816ZjBdJbEx
	kdhvjNzRwMcITTBQ+Dex3L0f/8kBmuJBTS7400OrdeyEV9wa3mQQ0KbCdvnL/cTfaihd32iIg5q
	jHpOB4XS5TTeQvKL4PZ/ltpxgWUO0TKIHvPIBR7cM++gO+AglFG2DO4jzK0M4v4M+1PQH4P723+
	Txm4/G9Z+11Vmz+X3hry+5JLS8HmSPRVQJ2bxyG4wGjN3i/gmyjUFHM6DdUZ/Cdtc9qTn+/CxWX
	a5ORLXUSG0j16FjRiuPubJJVmXIiKr6RvfT4GpqL7HrsqILxf0yjg2PlSf90bSyncy0RoL7hrxg
	/iu7jE17vPep/QzZKi+v8mdKWnvXqqjw==
X-Received: by 2002:a05:622a:14d1:b0:509:2414:6f79 with SMTP id d75a77b69052e-50b14753418mr91390491cf.2.1773923186776;
        Thu, 19 Mar 2026 05:26:26 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.141.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c6b9eb253sm45744926d6.41.2026.03.19.05.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 05:26:26 -0700 (PDT)
Message-ID: <69bbeb72.050a0220.2f06c6.3aa6@mx.google.com>
Date: Thu, 19 Mar 2026 05:26:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3865933083702877192=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, koike@igalia.com
Subject: RE: Bluetooth: L2CAP: Fix null-ptr-deref on l2cap_sock_ready_cb
In-Reply-To: <20260319115804.2160822-1-koike@igalia.com>
References: <20260319115804.2160822-1-koike@igalia.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3865933083702877192==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1069250

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.28 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.99 seconds
CheckAllWarning               PASS      28.48 seconds
CheckSparse                   PASS      27.29 seconds
BuildKernel32                 PASS      25.16 seconds
TestRunnerSetup               PASS      564.86 seconds
TestRunner_l2cap-tester       PASS      27.38 seconds
TestRunner_iso-tester         FAIL      31.73 seconds
TestRunner_bnep-tester        PASS      6.26 seconds
TestRunner_mgmt-tester        FAIL      115.57 seconds
TestRunner_rfcomm-tester      PASS      9.29 seconds
TestRunner_sco-tester         FAIL      14.10 seconds
TestRunner_ioctl-tester       PASS      10.28 seconds
TestRunner_mesh-tester        FAIL      11.48 seconds
TestRunner_smp-tester         PASS      8.45 seconds
TestRunner_userchan-tester    PASS      6.65 seconds
IncrementalBuild              PENDING   0.99 seconds

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
BUG: KASAN: slab-use-after-free in le_read_features_complete+0x7e/0x2b0
Total: 141, Passed: 141 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.108 seconds
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
Mesh - Send cancel - 1                               Timed out    1.980 seconds
Mesh - Send cancel - 2                               Timed out    2.006 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3865933083702877192==--
