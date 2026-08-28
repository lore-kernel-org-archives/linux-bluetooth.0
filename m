Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB5844236B
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2026 12:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787919942; cv=none; b=C8YIKiS3x+bGHJSpa7qmBgRx5LZw6zCSoPKrxzN454ySvgrfJ+zKkb4vczKBDKRi81ISXTboR4qyO5fUgyu1ltLEKR9pBFn4WNaP8E9zKsbFYfoJ7itt55oor++zwR2rGbmoiGR9T7UIh4+PVg++UzsiND+1B5ddtNfoIz89K6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787919942; c=relaxed/simple;
	bh=4dOHM4Jcyiynb24Yy3fBsCK4hNeRCYxIhYIo1vRb0qU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=M81ETgnPO3xhWGJALfpm/iS2TiIRmOBubnEC8RpZqgDHTzV1hO4F8KFL67NCcVyw5Ln6Ug2XUUvX1Ce5Od69EWGXtkxaKjcd7pfPQCugZFi7e6Jzl23g2xUHLRu2NFeYADcd+nzpIq3TZAWXcQXR5lyWZMWFk2teQaTZDcFM2a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3M0pczR; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3M0pczR"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-459281bc13bso853921fac.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2026 05:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787919930; x=1788524730; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Taeen07Ab6QBzP5rvV4V5up2Wbw1UZylpsmEgYYI6Bg=;
        b=l3M0pczR827auZ6g/w9N7cHyiSC47Sglbt8JPtqRlHZ8qwjEORW1c6OYoibMgC7opt
         igZ4Ue6u57MdfpiLCY6M8ABcvphbsraNcbZQ8EANDTJUa7boN+QdA5MknywSY8h7oJ8b
         WXX8wCzojoluY9vbjn+HusVSdh+JrcHSj4iqddD24Vl3dfHo4Kqe2NYq/L9+tBw9k1SO
         xyoY1smgjxulwRhy8OgzpGmwkVMqUkqfYuf7pJ7uqPdnbSCQNEDIGQKHKJr7PvRNv5Ep
         HN7dttqefS73JOWVmZ/UNWGSEY85AaAocxX8IJgVJGKstjzloQu6dRA/WrtTZja/HeLf
         F7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787919930; x=1788524730;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Taeen07Ab6QBzP5rvV4V5up2Wbw1UZylpsmEgYYI6Bg=;
        b=bqoBKt/ERi1RDFz6WnAgH1ye8/ZzXqqyy7L9OMMolJtQmExgTYov//r0YP3GtUWlJR
         9Egi91igaN46S8w2ICNbw19lMfsehrgfpWL5b2Ag4aDocIkaQ6Kp9OEolkGs/1dX6EdS
         zXmyUpPkkSxjKY+zVa1GqEdRm1+LK0gKHGDUmhWVYcJZcLJuw1fF51AQOkHfS7+tVSKj
         Ctka+nHX3/t7sJaCEd5ELlObaZqC+sa2uXIz2faxOApg2uAsb4KTIVllqUu36RjRiMMp
         bzeMiZ1RxUW1JsnQBKAOYTHzMq4Z0Ac9fZGy+y6hUlGAzykteEC5/vdh/TBWfzFLM28k
         b/Lg==
X-Gm-Message-State: AFuF++kU7sO6ZcUnBNCveROYHWhGeNto4wl+gINyZ9jJBO2ofTWM9V4t
	XMnJTf+L41AmWHZLikzDnvjvL7LdXEcXJbS02VPaMmmwlWOGNZZexUToCZddVg==
X-Gm-Gg: AR+sD13pUeNF/PUYPF2FHmT5D7EVg4/4HtVTqcoJ79WAlRcHVXx971g6LJUTop8mc35
	selDhGs1B2B0Q5D2orda+3kfdHQOVG+e9f8szErgzIJdX+zkIZX1bSTO1XEqeb/LPUe6xe2wmJ2
	b18D6/lh+d9+d29J9fVA4r6N6h7QbWhoiZGW85vW3B53OOkYep/BVqBExzmkz/iMehTag36LXCe
	ICbkjNgKU1tjPM+8Yyo6IestwIlsyz7y/loXgkJ25qZNNt+eoSAUa8POJFF+hnwwxkBFd8zVSHn
	G8xtgsaUPU4iq7LPwuOhEORFSNCPz6VYFWdTV9VpbPp/VzamRkgH36r82Sni5Lci9ZKjGRI17D2
	z+Q+g0FoVqop6qv5rc1MX9N5ORiygq7OnNknC9NuMswAcYKzebK+io4RuZKNmZSFBBUvImmEQV2
	LfXsgN0FLVG+cokQd9l+D0GZiRDBtAMuKx7ETw8SLqqQhue+if6ZMWrkchWxrs6rNK3+8w
X-Received: by 2002:a05:6870:a0b2:b0:44a:e7ac:b14 with SMTP id 586e51a60fabf-46837136d60mr7040279fac.11.1787919929902;
        Fri, 28 Aug 2026 05:25:29 -0700 (PDT)
Received: from [172.17.0.2] ([52.173.162.101])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-468a353d45asm1370173fac.7.2026.08.28.05.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 05:25:29 -0700 (PDT)
Message-ID: <6a917e39.566b9172.fde58.8cb8@mx.google.com>
Date: Fri, 28 Aug 2026 05:25:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2566281102231485205=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, syzbot@kernel.org
Subject: RE: Bluetooth: hci_core: Fix race condition during device registration
In-Reply-To: <7f282e86-b9fa-4a3d-8dea-208975771b35@mail.kernel.org>
References: <7f282e86-b9fa-4a3d-8dea-208975771b35@mail.kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2566281102231485205==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1153084

---Test result---

Test Summary:
CheckPatch                    PASS      0.89 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      27.41 seconds
CheckAllWarning               PASS      34.74 seconds
CheckSparse                   PASS      28.58 seconds
BuildKernel32                 PASS      25.52 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      466.41 seconds
TestRunner_l2cap-tester       PASS      64.57 seconds
TestRunner_iso-tester         PASS      132.46 seconds
TestRunner_bnep-tester        PASS      19.08 seconds
TestRunner_mgmt-tester        FAIL      216.23 seconds
TestRunner_rfcomm-tester      PASS      25.55 seconds
TestRunner_sco-tester         PASS      31.73 seconds
TestRunner_ioctl-tester       PASS      26.83 seconds
TestRunner_mesh-tester        FAIL      26.22 seconds
TestRunner_smp-tester         PASS      24.29 seconds
TestRunner_userchan-tester    PASS      20.68 seconds
TestRunner_6lowpan-tester     PASS      24.25 seconds
IncrementalBuild              PASS      25.80 seconds

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
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.236 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.872 seconds
Mesh - Send cancel - 2                               Timed out    1.988 seconds


https://github.com/bluez/bluetooth-next/pull/660

---
Regards,
Linux Bluetooth


--===============2566281102231485205==--
