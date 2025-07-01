Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A602626CE10
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jul 2025 08:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751359269; cv=none; b=XGVYlfhKwLW+qbkaPejn4h7uvudms6lbc5SYxgn4h1FwKwWRGX8qAh/iFfydrfLTy7dRpxMIZ98kx5ZjxxOgSEAb1R/sgbn0YSRV73TeEs/xfFGp7j6VAR16Hr2iIfbuPZIBtBByp2apoUgJ6idqgOR3U87ccl/Ikq9p7vVkcts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751359269; c=relaxed/simple;
	bh=gXobPw5+U23vDGPPYCVp8Vr+kYuMWxJQesksIOfr354=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IR1WfaG3lqEwC0o09zG0XziWX85aRBb4W8qzv5oN/aO1vazvF6hYPicX97oXXSDG3GQ7cwKybVPTFO4QXqvv7ELeD7vaxzcIsItsgKmzZzUCAYr5NVCtHRP9xf1vb+2MC5xtclvrvreXZnBtFdYITZ1yjPFr0RJQKlY8hY55h0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WglDK1nv; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WglDK1nv"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-313bb9b2f5bso5642003a91.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Jul 2025 01:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751359267; x=1751964067; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OWT/z68nTZ3hey4v0wjyqeZRlgZcygDuULMd+56HEnA=;
        b=WglDK1nvTEmMDMAjGKZOuPjUPsbGtD4SrZCPOtToYUamF7lfYxku3lH1vpQkpU0nuR
         MdAH9s4huWOZVEzA9SQwf8zNml8NyPi3V98wcMS6I6xD69iTrw/LRueiEZYNfaE2JsMF
         5jvOaJFY5mTYjvwiEYuibPmAn31FgAR7XLgiHiEAKeKCO2RD86+7EAYhI9NS94cndFdf
         5z3lUzdNAtNaXMZ3Y45V+PQL5h4524+NCmMO4GWSXa7SOA+I/+qQUnG6xdvArsXT3rUp
         3UWJrCwCfMB6xLvwJkc9XrgTkDNbc+o7Ks98IyxHkxna6w9cOwYYiEf487g6osy505L8
         iuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751359267; x=1751964067;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OWT/z68nTZ3hey4v0wjyqeZRlgZcygDuULMd+56HEnA=;
        b=vdfTjjMSfKOaFTBGcEc9Va94LNKMGr0VmGwRv24Thq9gol3VOz3OkeDnJg1Gq4ceMV
         QZMlp1VqbACVzubyLxNzn9PF1skG28/El5K68m2obLIjsfTbNjyLmSNA3kQ6DFKhbQxX
         aIP41ecr2WuwGTnSo1kdzLYChnju+W2L3iRNL2hnxYV6j3B/rU00mRHBcaR/eAHmz2al
         l/YGyjT845BAf1S0LZsXzufX1uSjnhrObv8zsAqWzHJqvzv7dyEPB4pmcGSEfoXsIOTl
         Z+I64Qr0Ock6vIS1mkDjgYGVCh9xrRB9x+QW37cI/IzfiSlOzfQApP3hpoTl/+ooZLvp
         YGIw==
X-Gm-Message-State: AOJu0YxIT+7XuIopRIv+ULzjLwZaIwcuQfaFOCCMWZPyx5L+c7s5rKks
	A+Aph/Cn0+86EXwxHsWa0fgsyUrUsM4RgDmzoluALnhT6Dsjizg7P03XN+yOvA==
X-Gm-Gg: ASbGncuKk8tw91F4OVKfFlqR6Eas/61ZS68IPzaOK8hAV7l2YtPk3jQxRYreyuWmmg6
	c+GzqizYbMH+XIR0tdF7G2LayuzjVmCAjTpjaF+1tghRG40paAOtGJ3niLkJ/x30gCij6kISLj6
	GU9zKEeEFf81bQrB5co/JvVU9/S9WR/ET7exhi7YmClrklvgHL6Hi+F1JEYJzj8RqXmuu3Ul4F3
	OevhmnLO7t4eFiWKNFs0+s1HltgPIJhUK9RwfY1mmyQZbjafO09VK9L+NKYaQWE9FmSEmVK3dvE
	ZtI7uAxAd/I2VKX/YLIv8QDDKr1vzxffLa8ZxQzb67RZj9p2ZXmWrEaesY4iQz0A3VEt
X-Google-Smtp-Source: AGHT+IG5ItW2fVn7rIGxySnlT/DiSEfKVftFzMgtSFeBaLHThMdMUKbaQ2zYQNO8DZOtWVHKpMaHoA==
X-Received: by 2002:a17:90b:4f4b:b0:311:f05b:86a5 with SMTP id 98e67ed59e1d1-318c8ce555fmr28631182a91.0.1751359266537;
        Tue, 01 Jul 2025 01:41:06 -0700 (PDT)
Received: from [172.17.0.2] ([20.43.247.174])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f5426bfbsm15213936a91.24.2025.07.01.01.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 01:41:06 -0700 (PDT)
Message-ID: <68639f22.170a0220.14b53b.67fe@mx.google.com>
Date: Tue, 01 Jul 2025 01:41:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8743996257013293323=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yang.li@amlogic.com
Subject: RE: [v4] Bluetooth: hci_event: Add support for handling LE BIG Sync Lost event
In-Reply-To: <20250701-handle_big_sync_lost_event-v4-1-f0ed2d77c203@amlogic.com>
References: <20250701-handle_big_sync_lost_event-v4-1-f0ed2d77c203@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8743996257013293323==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=977610

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.36 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      24.59 seconds
CheckAllWarning               PASS      26.87 seconds
CheckSparse                   WARNING   30.62 seconds
BuildKernel32                 PASS      24.37 seconds
TestRunnerSetup               PASS      476.04 seconds
TestRunner_l2cap-tester       PASS      25.32 seconds
TestRunner_iso-tester         FAIL      42.08 seconds
TestRunner_bnep-tester        PASS      5.94 seconds
TestRunner_mgmt-tester        PASS      132.49 seconds
TestRunner_rfcomm-tester      PASS      9.38 seconds
TestRunner_sco-tester         PASS      15.08 seconds
TestRunner_ioctl-tester       PASS      10.08 seconds
TestRunner_mesh-tester        FAIL      11.41 seconds
TestRunner_smp-tester         PASS      8.67 seconds
TestRunner_userchan-tester    PASS      6.28 seconds
IncrementalBuild              PENDING   0.90 seconds

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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.906 seconds
Mesh - Send cancel - 2                               Timed out    2.002 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8743996257013293323==--
