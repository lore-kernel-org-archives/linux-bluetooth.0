Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4A080023
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Apr 2024 13:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583161; cv=none; b=WmQqXoOmJs49VhggvWCIwpIX/NtLxAAI8TalXM5Rzavr/SF/3GjUMiP7fo0U+x8BiXnMioBZukJEmhCUNZxy0wyr/hArMnasj12QuYPmoFUwg2/5o7oc2bOSUEAu2o6WU8A3SclN0qI/GYdCv9+6VEdw4d5omH6hkAdI+dAiB9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583161; c=relaxed/simple;
	bh=3DoqPOUwEYWqErg+H8pv1pDJVrNAOX1gqJ0hII44Q5U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UIP/aEOsQ09cRphhm1yNs25hDCVhhKSJEFEK31arowJIGo6A/8MLisd/aoBzEWz4q9wP+3cBASdt7rewF6IYHUps26TMeMOfPzHzgvhCDKPLi/wxnw54zjVSu3zQY/lN3nH3a75mDok68hKg72/2g3SC69aiAUvpJNcHGw8dRjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbh1y8O3; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbh1y8O3"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ed2dbf3c92so780577b3a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Apr 2024 06:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712583159; x=1713187959; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=E2s5R6WG04IK2qNn4fCjBz8wuh1saGslo7PLTGJo2wU=;
        b=bbh1y8O36aNg11lgnULpwbOqM7VJUMuW7Fy7UdRz/+/iggIxZbYEgZzEtFpemBlPPi
         c1hL2hUG05Aee9YRs0hvLCKpZj/oBE0EUgSueD+u5CPixfqXy4WC8QlelJ+02T5VWQ3y
         CspaQlnbSKhCeDULl5sr5mQ47JwdDu6LvLZi3qh3FPU2CL6dIbA5BzEBbgyovwyCbihs
         38vrLM5+vhEeRXTQEeoUShnrnk6P1rgeltmygXa7PIf46x+/Od8CLhQZhhkFA+gnQi7d
         xOAdjN8hSpTy4/UgKD6Xo6Dx7KOF4z/33DasB2lwES/ujkBJeS579ToZYxT81vJbnQIB
         1Xyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712583159; x=1713187959;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E2s5R6WG04IK2qNn4fCjBz8wuh1saGslo7PLTGJo2wU=;
        b=bjdjYGgDKoOcJc6ji3GDIOsdUskuyZCqpcCwIj7y6n6P7ZLC+9WmyDCC4KgmUL37Be
         573chax5X3rNCDqfWovfVfIl2/broOY6qjGxfgSeKCMYhXYBmWGwcE+mO4OIQchV19TP
         z7Y9SV6XsxrwQvjc0EUED1rQidWl2TUAe+7J0e1AqPFsv9xp0pECenoalO3rANCiyTjJ
         GA9fuKS9GB5MZN/iMp+TpN3t+hkSLURxHl9xxqN6NnuL6sVIjAkH3g9H0jZTTMH4RS0Z
         D432/TDoiRgzN/4IEndGCYd3wZ8cagkDgBC+YWMheox7Pqp3rTzgE2fa/k5/XkWp7D6o
         ovzw==
X-Gm-Message-State: AOJu0YzG+f1hHeuS7MaawIuFydMaLjCkwHxjLGhVionMw29h0ya7yIE0
	DsqNAzAyYRbA9UPEINWfqrfmTXlOwsWjVPAiOcMXVVmfBXtEDPtU77FTKOyV
X-Google-Smtp-Source: AGHT+IF2ek2rS3ZcIg/VLT0PJYwayGGl1RT+x8aCPXZrbEbrtbXqrDfYEqQeVKTVBMuaS7Tg2864YA==
X-Received: by 2002:a05:6a20:9788:b0:1a7:2910:eeb with SMTP id hx8-20020a056a20978800b001a729100eebmr6796945pzc.35.1712583159260;
        Mon, 08 Apr 2024 06:32:39 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.75.105])
        by smtp.gmail.com with ESMTPSA id ld11-20020a170902facb00b001d8f111804asm6959846plb.113.2024.04.08.06.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 06:32:39 -0700 (PDT)
Message-ID: <6613f1f7.170a0220.836c.1ac6@mx.google.com>
Date: Mon, 08 Apr 2024 06:32:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4423647079683675599=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, surban@surban.net
Subject: RE: [v5] Bluetooth: compute LE flow credits based on recvbuf space
In-Reply-To: <20240408125806.12682-1-surban@surban.net>
References: <20240408125806.12682-1-surban@surban.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4423647079683675599==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=842452

---Test result---

Test Summary:
CheckPatch                    PASS      1.01 seconds
GitLint                       PASS      0.22 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      30.65 seconds
CheckAllWarning               PASS      34.59 seconds
CheckSparse                   PASS      39.10 seconds
CheckSmatch                   FAIL      35.16 seconds
BuildKernel32                 PASS      29.28 seconds
TestRunnerSetup               PASS      528.76 seconds
TestRunner_l2cap-tester       FAIL      22.63 seconds
TestRunner_iso-tester         PASS      30.74 seconds
TestRunner_bnep-tester        PASS      4.67 seconds
TestRunner_mgmt-tester        FAIL      110.12 seconds
TestRunner_rfcomm-tester      PASS      7.26 seconds
TestRunner_sco-tester         PASS      14.97 seconds
TestRunner_ioctl-tester       PASS      7.62 seconds
TestRunner_mesh-tester        PASS      5.77 seconds
TestRunner_smp-tester         PASS      6.78 seconds
TestRunner_userchan-tester    PASS      4.93 seconds
IncrementalBuild              PASS      28.60 seconds

Details
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
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 55, Passed: 51 (92.7%), Failed: 4, Not Run: 0

Failed Test Cases
L2CAP LE Server - Success                            Failed       0.099 seconds
L2CAP Ext-Flowctl Server - Success                   Failed       0.103 seconds
L2CAP LE EATT Server - Success                       Failed       0.103 seconds
L2CAP LE EATT Server - Reject                        Failed       0.091 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 7 (AL is full)               Failed       0.195 seconds


---
Regards,
Linux Bluetooth


--===============4423647079683675599==--
