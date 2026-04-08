Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EB0282F01
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Apr 2026 09:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775640099; cv=none; b=rue2q82/jahuJJ86XOkEk1t9hh/nnFbJgAQ1SijCMosUWNMQU7TP8LmWU7dobBWaJ3A7kIPLHi5TSu8agPWMywK2m4O/DM9rbsS8VBoqI2Bp/dik4RDRj7yi17aYaszk4b9YnpBBFLam2A1fdLzdE2ptnnKI3rHFIpKW2eioHUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775640099; c=relaxed/simple;
	bh=OxDIozv3kj6HMUuZMYJlNb9sqAym9NRG0pN429ys/hA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Yrx2nLtxAKmgxk5B9gcbHQP4dEoneF5Vwr/R+i2+VE4h6Lqr4e6rUEtvR9VCq4Vnt60UtzyOR/3BIeaa5vZpAnWgS7G7ne/hHEYdRkQgl72vHSb5qjghmdO4FwpdCZUIQVno20IbdCXECzxhC/GdI8eiW1UUdBZwIoEN0BzNfFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJlpMooy; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJlpMooy"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-126ea4b77adso7099458c88.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Apr 2026 02:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775640097; x=1776244897; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AwSxk6IL2dkcNzy19T6fVnRQdTKnR+9wBEUw7491lKo=;
        b=KJlpMooythrkF4TXeUIIxp6S5qnJqfG1PQNBnfnTe12OWVmGHUM7t2KKK944W3LVE+
         s8mvO2wpbzO/9EYeYvO8Iz45e0InpVdwmS2qcsMl7FdJ4asLAOkXfI5/N4IQLvDT9XMf
         ZQVxBg0wtuGqQ3/0+IL3mcMwFR6xuFq9Yl7j1Dg5I7ZPtRY3Pm1yZRzZI09xlHR5tzQa
         FlgWbhCZF6a4OnNcROjJEGDPU7PX94NY+OrCDFpu9ACO+YjLKj5RDH5VYf8Wc+FQt1GV
         Jqmw9HnWmijR4AaZf8Mz2IbEmUNdeQvI5PZ7vWhKZAT0tgLa5ZaAfVoOyGhY4U1109kU
         ssmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775640097; x=1776244897;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AwSxk6IL2dkcNzy19T6fVnRQdTKnR+9wBEUw7491lKo=;
        b=NRevN8Px82YiuF9kfH0WGryrUXUGy4NwZcVfUSQlqfJn3inL4J8xx3oLWGT+bOwWRa
         /jG4xtWVUCsoNRtAjDg5QcKgH0nkWNNVqI+Bpni/19zU6xbAcmizZsmxnnbka9OkECXx
         woWrZwWE2LdfNQ2FpngkPUy+9t1MNHHrQ7OGvlAmPrQYUVtoaBR6K5X8EIfcadrU/nL4
         QceHhWML6tfDj0AUatdNJ8/YD9XLczgGwykHkvaLB8ehb8eG4xa9mvEUAxtp3WfZbRTt
         trmSXU2JA91HDkTzPCiDZlic2adIkU4AS7yM0zVL5zJGKk5QxlPXcw+aFC8RmM+itzjf
         3gYQ==
X-Gm-Message-State: AOJu0YyBFb7GHRSUf2xfuniMrgxmPOd3a8i0YA0CRNR4APrwxy8XKzWL
	0utrM5WwfUjx2/RxDQPR/9PO8kjcEaXGeu1DMWMYbmoX5G/3D3bHTpdnFEX3hg==
X-Gm-Gg: AeBDietG4QHEbiMktDiniHHUvfOn59tV/rfPH/vMF1SjIIM8kz21ROmIFIZuFJMv3ek
	pzPR+INYAVUci20v5ihVH3YBuFvtYvQka7EUUtx6fFvg/NhL/7mHS898/mHy2ZF8P1xenCcOZFj
	bnNg0h8PBnlppJWJLHd15TKLe/hfMHFSpbriGOoWBYGSeeCgZwWwqd3SJAwCAAIqk/NEBbxZavD
	O0bBNrwcFCYGs7A8WIT2VyJYy7HJO/udX3vOi/cWLNXhIj2r7GMxJYTcn2l4djOWg7VHi8O1g+K
	4oqt2Bmvq4Vzfrg1xQinLV8Vm2I9zCe1duijAot3d34I7FQkSxOL2FhRj3H051dOnsnB924PLoG
	41XwGNWxUr3ceuSlfnGmmznuvylu8Gu4cqA20HkC++A1Fxom/VXHRlXnnlk/U6E70BP3i9/O80i
	D7a/og0Z7ExIS0yasyE22T1T8IpR+cdulKJK0p59XQkw==
X-Received: by 2002:a05:7022:b9c:b0:128:e0dc:6428 with SMTP id a92af1059eb24-12bfb760ba4mr10340852c88.17.1775640096849;
        Wed, 08 Apr 2026 02:21:36 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.126.216])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c05a7beffsm12259080c88.15.2026.04.08.02.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 02:21:36 -0700 (PDT)
Message-ID: <69d61e20.050a0220.3098d.8285@mx.google.com>
Date: Wed, 08 Apr 2026 02:21:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3027036183995213205=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kaihsin.chung@synaptics.corp-partner.google.com
Subject: RE: Bluetooth: Add Synaptcis 4384 Chip Support
In-Reply-To: <20260408083217.1915419-1-kaihsin.chung@synaptics.com>
References: <20260408083217.1915419-1-kaihsin.chung@synaptics.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3027036183995213205==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1078531

---Test result---

Test Summary:
CheckPatch                    PENDING   0.53 seconds
GitLint                       PENDING   0.34 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      25.95 seconds
CheckAllWarning               PASS      28.38 seconds
CheckSparse                   PASS      27.41 seconds
BuildKernel32                 PASS      24.95 seconds
TestRunnerSetup               PASS      561.74 seconds
TestRunner_l2cap-tester       FAIL      27.93 seconds
TestRunner_iso-tester         PASS      43.26 seconds
TestRunner_bnep-tester        PASS      6.38 seconds
TestRunner_mgmt-tester        FAIL      113.01 seconds
TestRunner_rfcomm-tester      PASS      9.37 seconds
TestRunner_sco-tester         FAIL      14.44 seconds
TestRunner_ioctl-tester       PASS      10.09 seconds
TestRunner_mesh-tester        FAIL      12.60 seconds
TestRunner_smp-tester         PASS      8.49 seconds
TestRunner_userchan-tester    PASS      6.61 seconds
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
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 95 (99.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Server - Set PHY 1M                     Failed       0.112 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.104 seconds
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
Mesh - Send cancel - 1                               Timed out    2.749 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3027036183995213205==--
