Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8759E390239
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 18:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782237927; cv=none; b=sAXQpSLbTiTaSNJCIgyLx6WYxCms3Fj2Rx8H7uiFGylTVqwB8DDKu1ekZs6uyYjAMovAJlUkDXKilWrusl+8L8YzzQwu4Z8gQM+YFTWkn7kToK/2r9olZlIjlU/GuNDa7Dm9UwdqS878wHTFEuxKsDt+dQ/ur5Gtb/Etbhfi664=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782237927; c=relaxed/simple;
	bh=DRFk1Kq3LFbvg8CVdrjUFWcu2eSoWNScCVTW0oNoX7c=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fz8CFV3hM+NL/I0nhGX0hE5NtTrdrOGFQfcefFg1dq6mW/KJwpEmMWioPGr6VBsL4Te7LZc4NjQGGCOhWdX9KHXx9KR/gpYe4vjn0VZ6HqZEF7A4chBBDlKigpK+Oj96Hvtjtg2VvVzlSbK0w5qXiq+h7oQZMCKQtuTzsT3VKzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BiL7HrqE; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiL7HrqE"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-9203654905eso6007985a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 11:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782237925; x=1782842725; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Nh1kg+wjB9DbkTFK8UYQWccWwytEJch72Liw3XdDjDE=;
        b=BiL7HrqEGR108UFsnEMILk7+nFt34BKRddt6mLaFT9jbFo+XolPcEwTHqvW3WRioAa
         vRw2i4bfDh75KDbVXs9D+dLax0bicrLL/IAzYFQ4IIhDP8OXQd9Zu5mDolzOVwn7WI+/
         w2KzK4d0ux8mjO3m+EpE8xT//75MMlGEAp2FXqJuR6S4ucuwRa23V87thI+kZ6mf1fI9
         6i/KgbsiELkF7XGZTBS7iF1auNJgqQLyF3eipSlgqk05bhyRCQVLk91hHH/wVotROcVm
         PrlAXrmXlp4pHmFegMJpYUORXqcTlq07lUDbfq3UxPSOcN2gcwolFiZ00JUL6FAva3t5
         BYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782237925; x=1782842725;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nh1kg+wjB9DbkTFK8UYQWccWwytEJch72Liw3XdDjDE=;
        b=PChbxUOEZPAYAYG5GrwlmdfCKsw76TUXW2M+r+3Rx/uVCKbTszRbQcOFeCPan8jOui
         hGNXCm5VijWsDnxQ2kAowtWT1cYL4sFeAlLFCdRVFGc6Z6/xefnmjhoOk3NZhc8+rS38
         5LBDEXC8tP2nG4cdOO4PKaXEMg1VbRu6l3e2uJ5sAEz6oXCR17on3F+j2ziei7d2Lc/9
         ULYv/puJ1scSb4nJd1h6bPdNAvFTDbIKTIVf9Y3KwtykbpxDIAJtIUYbfsKceW/Fhhw6
         c066r7HfKwzi3+DCGt29Z28XDAj+kkLr7VUe1D8TyVKkOKbj/X1+c4jyyEiuutHrsYaG
         SRyw==
X-Gm-Message-State: AOJu0YwFZppDpRxQYQ+C6nQcgJaon+H002L2gf4uXOTfv7SiVfS0/uwS
	/oJJDeMI10oXcngYSiiIYJwA6CQQswqhhza5JunRPLbMfee8Ou1fmJm6fXJuEw==
X-Gm-Gg: AfdE7cnxUzdNTQu+/Oww9HBbLybWu7F2G8HqhaQqCXPLk1sn7pzddFxU19QPKebyHiG
	uBKaaCCbbe1CJxg5Hk7ecvFhwVi7awm+p8BjVlLiQ1ex+/AeiM06x5wfUpk8mKPAgBl95WTPgMZ
	VzKknF+z/6IufW03LQxc5Wovw2rWkE4HEj6hNbQti5AJZCLSOKTjks6c3mTO6twafoPSu2Tq/wO
	VLQeTUINQOGwEFGss/5YP4jGg9EeoDmT3uUcbi5KxVxv9GB6Ypo3+0OhVi7uEyqZ5Pif6rbFOTo
	Ozfv7//ls4V1Kx1ApUBHONciO+nEnEvORXUN2fk/jyb4l7cVNU1VDVo0Kw3OHtQhgjQIid91HMG
	EtB8wK7JyJn79046nPQhp3KqqVi7HbpyFTH8qTvMMCi6D5AXb1RGFHSoi642JrXEzPUHx/8YfsR
	S3OFyjHip6etNdAkQuPkd73EV6XKBy
X-Received: by 2002:a05:620a:46a3:b0:8cf:f1d9:ba20 with SMTP id af79cd13be357-921d0b35b15mr2369367785a.8.1782237925428;
        Tue, 23 Jun 2026 11:05:25 -0700 (PDT)
Received: from [172.17.0.2] ([74.235.90.87])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-926000c0c0csm333391285a.25.2026.06.23.11.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 11:05:24 -0700 (PDT)
Message-ID: <6a3acae4.04986471.10c9b5.d5d3@mx.google.com>
Date: Tue, 23 Jun 2026 11:05:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2516277314512564912=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: Bluetooth: MGMT: Fix adv monitor add failure cleanup
In-Reply-To: <20260623161328.2177234-1-zzzccc427@gmail.com>
References: <20260623161328.2177234-1-zzzccc427@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2516277314512564912==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1115491

---Test result---

Test Summary:
CheckPatch                    PASS      1.43 seconds
VerifyFixes                   PASS      0.25 seconds
VerifySignedoff               PASS      0.27 seconds
GitLint                       FAIL      0.54 seconds
SubjectPrefix                 PASS      0.31 seconds
BuildKernel                   PASS      25.17 seconds
CheckAllWarning               PASS      27.99 seconds
CheckSparse                   PASS      26.93 seconds
BuildKernel32                 PASS      24.53 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      522.08 seconds
TestRunner_l2cap-tester       FAIL      56.98 seconds
TestRunner_iso-tester         PASS      74.42 seconds
TestRunner_bnep-tester        PASS      18.72 seconds
TestRunner_mgmt-tester        FAIL      206.08 seconds
TestRunner_rfcomm-tester      PASS      25.01 seconds
TestRunner_sco-tester         PASS      31.67 seconds
TestRunner_ioctl-tester       PASS      25.53 seconds
TestRunner_mesh-tester        FAIL      25.17 seconds
TestRunner_smp-tester         PASS      23.08 seconds
TestRunner_userchan-tester    PASS      19.81 seconds
TestRunner_6lowpan-tester     PASS      22.24 seconds
IncrementalBuild              PASS      25.00 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: MGMT: Fix adv monitor add failure cleanup

32: B1 Line exceeds max length (96>80): "BUG: KASAN: slab-use-after-free in mgmt_add_adv_patterns_monitor_complete+0xfb/0x260 [bluetooth]"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 95 (99.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Server - Set PHY 2M                     Failed       0.244 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.239 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.035 seconds
Mesh - Send cancel - 2                               Timed out    1.989 seconds


https://github.com/bluez/bluetooth-next/pull/342

---
Regards,
Linux Bluetooth


--===============2516277314512564912==--
