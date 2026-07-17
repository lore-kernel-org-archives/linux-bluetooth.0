Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD393D5C0C
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 16:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784305437; cv=none; b=rFfTgNr4VjRyKuy/dQEbO7N2NFYpL+uUayPvC/YGlOyPAnoVMEfccS229FIthtq9YBGvzZtol2NZ5+j5KqV7vhQ0Z5ESnHDDbTzZXt0RiFUGeDJXTJj/jRcJtrL2o2VVaquDOZmxfDGmq+QgQGfU82P7wIUcnen9Huo4BAmgY0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784305437; c=relaxed/simple;
	bh=s5eXD/FvxLmYUKLV8zzYj1wUd09Br7Aeff4FIHuKyUs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HsyKuCqnWW92/YR12NdesJeg4Zek6sz4pUGZ8ndLq9BvnxkIpRO2vfQoGblwgA4knlBsVW+5/BGzAipUfew8GX4w/L6AlIMKaUaWFa3hVqO2eB9k7kxRA7pg/HmC0hOrdSwCnlT+SVOfnrNpp8h02RgeFeY2kJEkk4FCeaEeA1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJQ49pcj; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJQ49pcj"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7e9f829d75aso3003901a34.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 09:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784305435; x=1784910235; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IOE3IWqicj2yAUpiaM1ozRqBBfs37pAUOiwtzrqF9qo=;
        b=AJQ49pcjY3yb7mDFyuiUHO4Bbn/jZKRMt7sPHWyZxPCi4SBzFla7cncymBkxfIjl/u
         A3nMfm2g4P+Ztsu3JrNAnAWi2v7lEB0fjj+ssEO32LSTio3+wTo7eIPwXDwg1hz9TXg5
         PHjwppg3gnqx3UAqY+hvjq0zr7Ga7nYZjxOJ3J1t+5W6+swr1XmkHfa/vu7ddvGoRUs3
         5zKuEA26PRyzOFn2SakLNU/i4up9ve00MiU8kvh5Ts6gONi7h638wnlet+GmvlwlkEYJ
         kYnPoFtNcsv1vejLuZPpDqPU8t2CTSFRUghmI+gqg45B7pB5aQBDeXl5tJSuTh0wV+8A
         PJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784305435; x=1784910235;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IOE3IWqicj2yAUpiaM1ozRqBBfs37pAUOiwtzrqF9qo=;
        b=nna5aYewXKWaLq3PDmFyTUyl0NOEdcJ3cR/bRX5BbZFdExLAue+Xuw1LVNHQV2Zs+h
         p4uK8c7h2AR9NoGo9Npp+vcXCHpdIr7OSqYxeFvqUP9eMsm/rQEbB0KptWwUJ/Ijj+mU
         cnBkIDooRrEe0CxvtF7jUSU0M6OQ729ahvj8iv/ngynfsZSa3EdXoiVg8FT4bqUq4ljK
         jTL+s0jpdUwhqXIhO3Xwh0GLrV3QjfNtipB0cjlMrn3VBliwBuyiw62mBRSOooBc1E3o
         nnZAJEHm7pighJATaJ1fYIFOyWT5fwGmMGDIthyRo+2d/E35IMwg89yrvqH5+j/3KA+b
         t8pA==
X-Gm-Message-State: AOJu0Yzvjx3/01c04VJrHWozNmx6Hl9GB+/iJfrdjZKbtd68eQ4exd+b
	I3pTSK69HjxEwjtiVdPNoX9ppV65wMND71aODJzuZsyOmrY5RQy53ArPkWghFkEh
X-Gm-Gg: AfdE7cnLpnjj8Wrw3TzX6UAM3vAOe6oxJvUEdNz6tlc2qq/QszfWQakFB7NTVzkYmUX
	hrNE9DDk4klfwXhsiQuLVSyCd1THlYbFhKBoI6hjiEfuOhf/+h6AyKIpe8uGxghATU1WMCj2w7T
	uf9VAznbnRrncKNCe/S4Kr+jqzARb1uCAK13P23zlPMFZq0h1o+4zCI40lM1FjodldKKMwefpSk
	Hmyt2XG4HLlx79JvqEGEzo3ezDIh2dU7GUz/fvoC6SDSN0kkkV5OFaYYt+4UfeWTRFRJPy4K5su
	v1egsZteF+t/bCyOPVSrqg6k3bQcibBUHTz8OB+Cq/HBeCnEbTPn07pJBTwC0ZciuCevwTgKgn6
	Vqk8DIaLvvgwE21ZiUP0dBXqpRw1BngMxE3Mv2EjTpLHkuo7cBMcoT8HPtbbwcr4iUrVR2RDzK+
	eKAbRzl3gFP+1AZki/+A==
X-Received: by 2002:a05:6820:629:b0:6a3:691d:66e3 with SMTP id 006d021491bc7-6a536aa558amr1391265eaf.52.1784305434497;
        Fri, 17 Jul 2026 09:23:54 -0700 (PDT)
Received: from [172.17.0.2] ([52.165.62.80])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a51a22011asm1699361eaf.11.2026.07.17.09.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 09:23:54 -0700 (PDT)
Message-ID: <6a5a571a.0c0d0188.2e7c16.7362@mx.google.com>
Date: Fri, 17 Jul 2026 09:23:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0140531071955387334=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yaojiale02@163.com
Subject: RE: Bluetooth: HIDP: add missing length check for incoming frames
In-Reply-To: <20260717153238.2002330-1-yaojiale02@163.com>
References: <20260717153238.2002330-1-yaojiale02@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0140531071955387334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1129697

---Test result---

Test Summary:
CheckPatch                    PASS      0.58 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.27 seconds
SubjectPrefix                 PASS      0.16 seconds
BuildKernel                   PASS      22.57 seconds
CheckAllWarning               PASS      25.42 seconds
CheckSparse                   PASS      25.04 seconds
BuildKernel32                 PASS      22.34 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      408.54 seconds
TestRunner_l2cap-tester       PASS      56.29 seconds
TestRunner_iso-tester         PASS      78.41 seconds
TestRunner_bnep-tester        PASS      17.10 seconds
TestRunner_mgmt-tester        FAIL      204.30 seconds
TestRunner_rfcomm-tester      PASS      23.90 seconds
TestRunner_sco-tester         PASS      30.72 seconds
TestRunner_ioctl-tester       PASS      23.78 seconds
TestRunner_mesh-tester        FAIL      23.76 seconds
TestRunner_smp-tester         PASS      21.47 seconds
TestRunner_userchan-tester    PASS      18.22 seconds
TestRunner_6lowpan-tester     PASS      20.95 seconds
IncrementalBuild              PASS      21.80 seconds

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
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.232 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.977 seconds
Mesh - Send cancel - 2                               Timed out    1.988 seconds


https://github.com/bluez/bluetooth-next/pull/450

---
Regards,
Linux Bluetooth


--===============0140531071955387334==--
