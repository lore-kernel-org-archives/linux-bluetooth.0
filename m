Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B357C33FE33
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 16:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773938421; cv=none; b=X9s8LvzZ/K6a4EPWc2jpmPafX5DFDcIoCatniU1jpqi2xHHmG5zU3fqMpA5/QEhbH26rAMeNwZFP5H+NIDaJmm8foDmffMj+3A/MCkSlwFpG4ruldYLhCtUU3+++djccp+fe1mEdG64z2nTcMse+Fv4WUvYuENUW4GWf0EtTlgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773938421; c=relaxed/simple;
	bh=TM4X7eRrPR4aUIBHJ5sUpWOCywHhxRIuwY22kbSe+UI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LGCIOxa1OteNfrwB3V8yUFDROgh5uWAF6PYqwJwY7aF760bN8ZB3NAApDopuGxHxlZ/IAzdUVaQ94/9pa5Qkmnk0z/YIvdMvkghOYugpcHatjqBi1vgY5AIr1Tp4M50gQhE9Z0TREhoFDhSRFlaVMZsIs/3XMgywb5VCJY+azUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDAKDtDA; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDAKDtDA"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82a87ef7304so216713b3a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 09:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773938412; x=1774543212; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2YuiVqer4jIo1FPzqjEunHHquxe39BHAEl4U1YUc7qw=;
        b=LDAKDtDAkpNSIrBTRg/G7f+fx7ZuHKRFajt6ZJcdVMYf6Oq5JFlh+OwKrwQfQc63DD
         gIvrLeHqfosiL1tOVCQlG7jygZBUEQVUKamsa4Gq0kiaf7M4ByNU2e3GeihYiKCjl4hU
         2+6+AiZun3VwvqCC97RusqiwqGIZblQ+NuisihPEhD2bBLeaG7bM5cycPVn8sgkrhHU/
         roQvs59Ma5HyfOm9rTwpyHGWzuHhzan69qasAEGi0QAWMHM7QHa6rPGUzeem/KtuRjwR
         fuyM7CBENWElqrAmm/0PhDN1ilTBU0mUlLdn9U3zG8Ao1ic5/aa7OBURiWwgy3AXhaqz
         Tjdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773938412; x=1774543212;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YuiVqer4jIo1FPzqjEunHHquxe39BHAEl4U1YUc7qw=;
        b=kKAjDIDoptgYStj6P5rU103FgEUCi+Csl4b0iRnwNsfL+FWNGJZf/s1ix3j8Ctw9Fy
         xlCWR+JBFGn5ri2j9hsQg9GOTe87MAwHe9hk2+NQPwLtgjzr5wUxYorEwu4+wFPqAu01
         7HrG4QXzFh+nRvG72LlloloycHKAUb6PeQy6H+8k09rQtCK1AMNplB8SDH21WBuGa3+P
         v7OEIKh0wuk4GuLgidlKkQwM2Od7LvWpdMr2jKeTyuY/YYpqd61Db9kVixFvp/DCGDtd
         /JkR7SD91PMiRar2pHYIhs4FCpqpPQUFdZrAfJJolfpQC29gfWq8sGMqOGF5A2M2ZGT4
         uasQ==
X-Gm-Message-State: AOJu0YxhgL9qlofHJARb+WFUgESJz/uTcT4z27XEtMLIRhuHOqZF1Zc6
	3gCaI8/ebbWiWgtlXE3xAm9fl+yFTw0+QQZPofa4qTkiIY5GSO1lyzzUqE/2VQ==
X-Gm-Gg: ATEYQzyBHO7D8Oj1MWcVCWx1RAAtuH8JCH2/96xkFhL2mP3NYnOWi//PpN2S5GSz4Z3
	caMcmEmuXrlTYOseLDRtS/Et6VY3sKqoKZYo74/HdHuosOLd1Kbz2dYGKQBMlElkkA5cqZh9nCm
	DfgaoDpM+YdAlGfFYFF3DZ2nRu0yAN/o8TE8P4TUVryJdVSF++vIQmijIeyADC6bnNvR+s+xrr7
	lzAn73fWjXHvrcJpmfuVwWBpPCVZc/msTsDN6uaNrCwqNgXG0c3W/+60zQ+tnK0gLAt8Dy0zO6y
	EZFsXOeGXREa+PanwVQM+/PmDRAFsTnUvgG4BOLjumO16nQqFpePgy1tpoapt1TI/MQwLRDA+G/
	lRTOm9bkUJs9OSjsdEpb8IW1OG+TT08euTG+6PYQou5GAVOSspmy8Y5aDEPKRwp47iaJpBahBaN
	oCdCKA58AFy8vIhUTZulRz45xM4av3
X-Received: by 2002:a05:6a00:ab8d:b0:82a:14aa:795f with SMTP id d2e1a72fcca58-82a6adea191mr6896383b3a.35.1773938412448;
        Thu, 19 Mar 2026 09:40:12 -0700 (PDT)
Received: from [172.17.0.2] ([20.112.122.54])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bbb390csm6844548b3a.29.2026.03.19.09.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 09:40:11 -0700 (PDT)
Message-ID: <69bc26eb.050a0220.4e16e.6bdb@mx.google.com>
Date: Thu, 19 Mar 2026 09:40:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2211675971397977982=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, imv4bel@gmail.com
Subject: RE: Bluetooth: L2CAP: Fix ERTM re-init and zero pdu_len infinite loop
In-Reply-To: <abwTCkavRurEcEGO@v4bel>
References: <abwTCkavRurEcEGO@v4bel>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2211675971397977982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1069346

---Test result---

Test Summary:
CheckPatch                    PENDING   0.67 seconds
GitLint                       PENDING   0.50 seconds
SubjectPrefix                 PASS      0.05 seconds
BuildKernel                   PASS      26.37 seconds
CheckAllWarning               PASS      28.52 seconds
CheckSparse                   PASS      27.38 seconds
BuildKernel32                 PASS      25.35 seconds
TestRunnerSetup               PASS      564.19 seconds
TestRunner_l2cap-tester       PASS      27.33 seconds
TestRunner_iso-tester         FAIL      29.99 seconds
TestRunner_bnep-tester        PASS      6.30 seconds
TestRunner_mgmt-tester        FAIL      112.94 seconds
TestRunner_rfcomm-tester      PASS      9.29 seconds
TestRunner_sco-tester         FAIL      14.23 seconds
TestRunner_ioctl-tester       PASS      13.73 seconds
TestRunner_mesh-tester        FAIL      11.48 seconds
TestRunner_smp-tester         PASS      8.37 seconds
TestRunner_userchan-tester    PASS      6.66 seconds
IncrementalBuild              PENDING   0.70 seconds

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
Read Exp Feature - Success                           Failed       0.105 seconds
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
Mesh - Send cancel - 1                               Timed out    1.938 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2211675971397977982==--
