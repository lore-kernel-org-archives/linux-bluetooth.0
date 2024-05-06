Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569173399B
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 May 2024 02:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714963610; cv=none; b=Su7lcdKcHvz77RfP7vV+8YtGq19QoPKHB+0gtezcstAYABrAvy27mzRTUhuLeAPhrZCzLHKy16GVH36AgHXsIK7Ckd9YP5+XxRPc57FskPXmoIYMyE6/Gx6Tv0yyej6XWMTvlSwuq5M7ChM1mur2Jn6KmB7CIFZ9vH3Vnnb2MkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714963610; c=relaxed/simple;
	bh=EUrEDy8yWqcSULeMyrUL/DaveX5Nzu1qnXXbwhbEsSw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GvjZTH/uqxgkAzOrKvn1Q6xAgLjF39vNmqgB0R0LqzO+wZ8eNWIKLyxNiFGARf56uGVO1wuCCyd3jQL3iWyZgJf0eYjRxrIOAEB/01RKdKyh7OyIMw04IjLZMQza67OsujqBz4CGfaUIjUsjRC80k0BfOsxVqwNisaCYsNDgLs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBJDMAj4; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBJDMAj4"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-792706dbdc6so225646485a.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 05 May 2024 19:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714963608; x=1715568408; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JD8NPFijzmUFKIuAcZGzqq4+jGlwExKColRKmscJ6WE=;
        b=HBJDMAj4vIC7YMjCX/lkGU3MynFFv1op9LM5BkPXrrTsvpczr9/GsXQp+J7Ynjjw+g
         1BM4U+z7L3fLL8PQZrNqzu0ekjYixwC4hxgF+3Wr38/X26ZAPrF2bjUoxUij0hzLt5CE
         jRpMbN0V8rlLAizTJzCWOidEd1nSBIlsLiJo4FqpJ830cDUtw3NZe8EbtZmxsHYwejjC
         5bpIao/3EHrw6HmEYW2AtGkVlcA5e4JwnWFGk9GdFm6qzilorWEvzkSOukveElK3xGPb
         JFxZQKt8jxEYLUc/jTvMaCLTKKLOrVXM4bmNOpe1XWYuBP0o4geuiKtiqBSoxFdnrSda
         sgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714963608; x=1715568408;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JD8NPFijzmUFKIuAcZGzqq4+jGlwExKColRKmscJ6WE=;
        b=b8+J78D3qSyKyNuWyArGwuoDOgisqeFgzD3ZX4LxtwHPYN52ObmsKMuHoSmTiw/RG/
         A7ooBIB+letq15yzJvd+2I4E9OWh4JL7eT5KZQnL7z3CU8WrCmB1d05tGj7lio9ApDZs
         4f+g+rV85LgH+yhxPCCEgb9jkMUER5YQ7nsIV83mEZRi6kPHFUjKkjaasIzp3wwPGdsw
         CSLJMYqxs97qFYAsR/yNLZFdSl9nktHxLvumoLkFTImuo/H/DrX2dKwoxk9dEzD1Mw8x
         OasitD/IEzKknn5I4rMy0IDZKHt67nTRx0QV7E0GzDlq2+LwI0YDWM+lxt8Rj1OJQxjN
         r5xg==
X-Gm-Message-State: AOJu0YwvWthsNBhNlfecbko0rQmWZEJUWbprNvjfurDQKNLT0AJalKmj
	7MJClaQxX8wt9VqwXZR0rRBo3diCQR0yROiiBb4GSFbwLOhB4h/UzmyWFw==
X-Google-Smtp-Source: AGHT+IELu4+BzT61akhCKJv/8yTqufx+bvyw3HpMeU1O13q/SO7E5ente4+2gcPeTWtqTRNASyoG+g==
X-Received: by 2002:a05:620a:40d2:b0:790:7f30:6c0 with SMTP id g18-20020a05620a40d200b007907f3006c0mr23530821qko.23.1714963607899;
        Sun, 05 May 2024 19:46:47 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.222.99])
        by smtp.gmail.com with ESMTPSA id u7-20020a05620a022700b007929363171csm1123547qkm.70.2024.05.05.19.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 19:46:47 -0700 (PDT)
Message-ID: <66384497.050a0220.74e9b.2949@mx.google.com>
Date: Sun, 05 May 2024 19:46:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7467111073348876238=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iam@sung-woo.kim
Subject: RE: Bluetooth: HCI: fix divide error in __get_blocks()
In-Reply-To: <20240506022035.663102-1-iam@sung-woo.kim>
References: <20240506022035.663102-1-iam@sung-woo.kim>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7467111073348876238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=850652

---Test result---

Test Summary:
CheckPatch                    FAIL      1.13 seconds
GitLint                       FAIL      0.54 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      30.07 seconds
CheckAllWarning               PASS      32.76 seconds
CheckSparse                   PASS      38.40 seconds
CheckSmatch                   FAIL      36.66 seconds
BuildKernel32                 PASS      28.71 seconds
TestRunnerSetup               PASS      517.65 seconds
TestRunner_l2cap-tester       PASS      18.30 seconds
TestRunner_iso-tester         PASS      30.58 seconds
TestRunner_bnep-tester        PASS      4.68 seconds
TestRunner_mgmt-tester        FAIL      110.53 seconds
TestRunner_rfcomm-tester      PASS      7.24 seconds
TestRunner_sco-tester         PASS      13.00 seconds
TestRunner_ioctl-tester       PASS      7.60 seconds
TestRunner_mesh-tester        PASS      5.80 seconds
TestRunner_smp-tester         PASS      6.78 seconds
TestRunner_userchan-tester    PASS      4.92 seconds
IncrementalBuild              PASS      29.55 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: HCI: fix divide error in __get_blocks()
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#83: 
CPU: 0 PID: 9622 Comm: kworker/u5:4 Tainted: G        W          6.9.0-rc6-00001-g38e1170f515d-dirty #32

total: 0 errors, 1 warnings, 0 checks, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13654829.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: HCI: fix divide error in __get_blocks()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
6: B1 Line exceeds max length (104>80): "CPU: 0 PID: 9622 Comm: kworker/u5:4 Tainted: G        W          6.9.0-rc6-00001-g38e1170f515d-dirty #32"
##############################
Test: CheckSmatch - FAIL
Desc: Run smatch tool with source
Output:

Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: net/bluetooth/hci_core.o] Error 139
make[4]: *** Deleting file 'net/bluetooth/hci_core.o'
make[3]: *** [scripts/Makefile.build:485: net/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: net] Error 2
make[2]: *** Waiting for unfinished jobs....
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bcm203x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bcm203x.o'
make[4]: *** Waiting for unfinished jobs....
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bpa10x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bpa10x.o'
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 7 (AL is full)               Failed       0.194 seconds


---
Regards,
Linux Bluetooth


--===============7467111073348876238==--
