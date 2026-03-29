Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8E831ED80
	for <linux-bluetooth@vger.kernel.org>; Sun, 29 Mar 2026 16:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774803015; cv=none; b=mmLqKf733cEUgiinfy6AF+PvQpp967LOQ2KQChYajWtdtarA5J8h4qSwi8wxHXsryW6rpf0gz8vQtmfM4z2nD54RxzK/EQYxruBbEVAP6VrvIIZv1O7ywN2uNdfpiqOfJONR2xVldtyjAnMziBB69Koo4uUXMv6VGNCfUJCZ1d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774803015; c=relaxed/simple;
	bh=3tF5Yp9eGfrICBkFMzxKaUSEpkBzAS6iuDp0pktY+TA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=o7cMiPz6XEaZ0LEbuBoWhY5WLFE2wvNG4DPuyxU837G3PlyOY2XGQKXVRTLJAAOSp4wbuNtlFikoQiq5GgDV7BmTMmhgDBKDzNqQLe72+W+5lrxgf1nCmOFbcK5KbQ4r2wJe/OJOUHHokZELPp5jCDZwXadE0ou6NpoL5MdoHzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rLhHfDnr; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rLhHfDnr"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8cd8a189f44so346937985a.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 29 Mar 2026 09:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774803013; x=1775407813; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hDsgrC9wprx3rZk9R4iZURuUvTlrHZQngiR1eN4kAmM=;
        b=rLhHfDnrOjbQ1C47/YKGfzkZSvhPp1sDPEoufmSu0BdNtghCj16KoPeWbRkiFwpD48
         Vn0tghMGW1XUpKmqljjxUd9VmT4RSetWWFMhUlw5XMw7ufqk9xmEQcGZedldh03ZBEOj
         vsyHhzSf3CgJP4SA1vVb7jL0se/1m6HTiujGD06yCPvKiv3rtH2NdfjTMTTHDJeqgcoe
         AjyRoZ1heAtTEpccyrZrqrzqHK7PZNQAYY5EtAXMkG1kSN32ppIhgfuFFmp3Ts6/2j90
         Nppr1TViYMAgJOTxndFL/b2Pt13bfT/a9o7q/h+iwjTbn4ptfyY9obbI4UbB+kYRCFn0
         Jd0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774803013; x=1775407813;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDsgrC9wprx3rZk9R4iZURuUvTlrHZQngiR1eN4kAmM=;
        b=ahJdZKA+m1JfRxb9Z1dZM5kl66oS9TVqeZjoNaoGHe4fla6IRd3G/28EequXGB9OUQ
         qS5JmuI7BpgIRoXL7Ckx9iv5Q+PmPTvOJBDDE2Gq1XVrIb/0pU1xplS4lgRGoiVzZhjX
         +dk1ICGzOYsA30qW+nxhZKv+NIrsyhkGp+Y0X+vagqvcoXCxiKZLCZmkSHq60OTrW0Vc
         RSkDI6G0MzVAggRLrtWL8/Hvp0KahY+9DkaLIxk6N5R2rlCu4B06l96cvQzhBtucI8/n
         TihRSnkVGbL8vTFqDLGaKy3Y7nEfWWlq2/Z4ZSLglbV//Rqu+6Q6+wseDoB1XDekxL6p
         OxFg==
X-Gm-Message-State: AOJu0Yy7nRmisYfOuAl+L6+YhpJovhLq8UTxR8tllDJBMFbM2SW5Nit9
	da+wA/0kT9bJliiELPJABhbHUbj60lCJ+3k9bEiKumudeISip4aNC1lPwDve3g==
X-Gm-Gg: ATEYQzwyW9qV0Imsm5GaqSH7ZKjmILl47h4dn8L3REtGWRPcE3U/5aEDWSt4uclRph2
	1cOuMr6Djo/vYqBBBfg/Ql0bE6bFsXcgfGvn4d2dZ3o/YMfVWzCkoAWPF75lVcV0ps/ig/NqMA/
	9h+9I1uv3I7ebguId7/2RksZBlkt5RsUUgAS0ScAvvsIyTP0439pEK6+DuNW6T+J0D6QzLMrC+B
	K7vceYJI7/u7KpXOXTHxwAYoFTSKedfyg/l/62z0yzUyrtEaXvOIsJPZGKrANYmA6U2NTUCooui
	qZFN/gZKgFxVIgnlyHvkK0lzWMEf5rghHLn3L/9ftWMIr9lAefwHtdZkA9ByLEFbkq6z8Ml9qYs
	cwKHIsqa4SkphNeisQsYufRq8XzSRi9HxObh2Uv2mtcv9ATAf6+MEHXk86pjmRZINv/7FhwgcuN
	nHiejheikpR5kKN4HS/BNKIeu81bYTBA==
X-Received: by 2002:a05:620a:370e:b0:8ca:3c67:8920 with SMTP id af79cd13be357-8d01c810af9mr1248974885a.69.1774803012979;
        Sun, 29 Mar 2026 09:50:12 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.145.82])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d0280629e9sm459731885a.32.2026.03.29.09.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 09:50:12 -0700 (PDT)
Message-ID: <69c95844.050a0220.327730.4198@mx.google.com>
Date: Sun, 29 Mar 2026 09:50:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4084065065238919103=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [v2] Bluetooth: hci_sync: fix refcounting in le_read_features_complete
In-Reply-To: <160b4c8732c904a6e3d52c192a7620ac131f9511.1774798184.git.pav@iki.fi>
References: <160b4c8732c904a6e3d52c192a7620ac131f9511.1774798184.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4084065065238919103==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1074221

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      25.91 seconds
CheckAllWarning               PASS      28.29 seconds
CheckSparse                   PASS      27.22 seconds
BuildKernel32                 PASS      25.10 seconds
TestRunnerSetup               PASS      560.73 seconds
TestRunner_l2cap-tester       PASS      27.63 seconds
TestRunner_iso-tester         PASS      39.73 seconds
TestRunner_bnep-tester        PASS      6.25 seconds
TestRunner_mgmt-tester        FAIL      115.26 seconds
TestRunner_rfcomm-tester      PASS      9.94 seconds
TestRunner_sco-tester         FAIL      14.84 seconds
TestRunner_ioctl-tester       PASS      10.58 seconds
TestRunner_mesh-tester        FAIL      12.46 seconds
TestRunner_smp-tester         PASS      8.78 seconds
TestRunner_userchan-tester    PASS      7.00 seconds
IncrementalBuild              PENDING   1.00 seconds

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
Read Exp Feature - Success                           Failed       0.115 seconds
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
Mesh - Send cancel - 1                               Timed out    2.512 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4084065065238919103==--
