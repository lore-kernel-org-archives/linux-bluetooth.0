Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616B12F0C45
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 22:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774911075; cv=none; b=REUSPM4cjNAghrSZNkpmUubRX56iAmjL6y84TNSTFm3aBg1Ltjv7ijlq2lNkuanBxxnamD5x9rY+wPmRqt4M5jl9PnKEsStEpHYPjPQzicWf9WCS+qe7llednf5PerQsaopPW+Hj26wR0rm2Ky4g98NC9+ka26YyW2OjyhjOuDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774911075; c=relaxed/simple;
	bh=s7EhldC8NnNr/7zmSfihqZKUl12TLpTS8HosmxPwXVE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=aPmDVLz4dGQouTsNsn/Q9FwvnwKLIF7wtR8iScx6vNRNX0GIJtjZVROIaIxpOGGafhfFvcwfmAtPh6GvG08ytroiH/yghxNuguwB+o8874bo84krm+wo0NZX9nXcJmw1VcFaKoUKixmEJtYawxah2YV3ajMu3U+u1mmV/ovkzhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oj3c/xxd; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oj3c/xxd"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cfbfdabf3fso504477285a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 15:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774911069; x=1775515869; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YscM1drlyQWd/iGJ4nRXD+Xu8NZC2GOPeROzW197dZU=;
        b=Oj3c/xxdi1U4vYcCxwGRy2tTc5qyPtTAlDqfycJOg9mIkDqDR3W0o2H5os1hYEbFkN
         7U3pzZ2qYbCcE7uW+ssmlwojPItIuRqhmrky9BsOUqyNECF38V0v+lVRs1SgNd8jN4Mm
         q3tJLF/Vno0BwrOjZA8F52Ckgtu/E4SgTOm9FBnK+1GQcjybJa3erltQemA9ZPQocKXX
         gStkkhOqQ4HtgiMZCL0yEswMt5hqg4dgx0MpUfF2aTFmxSOKc2O80QMKnosl13V5OouV
         UVZe3E1JVZBKEEj9gGJKz48KgD5TeI8fmJKO3XfkdgwK2LwALUJcuvoBztlZ2/w1bvk9
         qApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774911069; x=1775515869;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YscM1drlyQWd/iGJ4nRXD+Xu8NZC2GOPeROzW197dZU=;
        b=jvBzIIDVxbRuivDxHdWVgRTnwjAzec4sRZlLL13W0WnqQzaY+vXP5qX0xW+wyDRZii
         90g8+dnnMb8iqYPSqZVj8INwPx2zthJMjco3gT9Qtw7wG3RDS3KQNe3hlNPkd38jAkbE
         5n+WzPM5UmqO6PPlD3Q9VWsRf1joAuhU2Q2wUP6uRs+axx4vepk709tqI0mG6uqTxtHr
         XNYFTW2jYImTNS+EkstEMZrFS6UBeoijEgQU0rrB6T8iCWplTgtKV8vEoMd5sWScYXEm
         WgLcu9qhuab0vgCTtHH7+C8zA9xcZ1noY+jDZz3jqNUsalgYuBoKXuP321ah0k1AE5r3
         EUsA==
X-Gm-Message-State: AOJu0YwoahKYBrbMXg+d5BJvrawIxtNQyUtgHi2F/05jqqSTz7G6gkP0
	X347UXxcPad3/4RhHZ6W4ftXDxffsozD4DgxHdY//iAoV7HrFDvQ25OIM9R0oQ==
X-Gm-Gg: ATEYQzx5FVqkCqIuG0nb8j5J/ykWz0J2w+6m0hjoxLXIvBCL3QIaGKx5wfScTJgV+4B
	oGD7tKTILGR82OZLo+Rxw7epkJrR4FgI/AHZQO43sVnowbWvV3YdAI4F6kCQLSGgvnHmSbCsv5T
	C0News48A71JOoBxyUvmNUBRbdlYBBwkMPdWlDyqkBzKNzp8wGFay1l1YNrGRK6GDjCAyvJLt/t
	3AIr5+DiJcbTcrImBU+kHfyg0hj3XpjlLlwUu/Lt4nv7Zde084M+A6dIHrqvzz/jlbCLKt+FY+L
	rENu17CL0ia2fn/imNTPFbaSIcyk5kqdNNILZik+Cz7RkU5N6t9Yk5/da87IJ7vdABUerFdu+0h
	rEZeRIGpzma1z5e/pT/KmcyD6Dz68OEDXlPI1OlklZtgi0NduSqLEQWOV0925pc0billIHj5HiT
	Py1maC7oNwklebO2KF/7RbF636GxTn6g==
X-Received: by 2002:a05:620a:46a7:b0:8cd:96e5:f7be with SMTP id af79cd13be357-8d01c816da7mr1944387585a.69.1774911069218;
        Mon, 30 Mar 2026 15:51:09 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.133.97])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d028086d25sm706013285a.43.2026.03.30.15.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 15:51:08 -0700 (PDT)
Message-ID: <69cafe5c.050a0220.282a5f.8e62@mx.google.com>
Date: Mon, 30 Mar 2026 15:51:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7702440857685502159=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nathan.c.rebello@gmail.com
Subject: RE: [v3] Bluetooth: ISO: fix NULL deref in iso_recv() ISO_END handling
In-Reply-To: <20260330221015.322337-1-nathan.c.rebello@gmail.com>
References: <20260330221015.322337-1-nathan.c.rebello@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7702440857685502159==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1074833

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      25.95 seconds
CheckAllWarning               PASS      29.27 seconds
CheckSparse                   PASS      27.90 seconds
BuildKernel32                 PASS      26.13 seconds
TestRunnerSetup               PASS      568.66 seconds
TestRunner_l2cap-tester       PASS      28.07 seconds
TestRunner_iso-tester         PASS      34.21 seconds
TestRunner_bnep-tester        PASS      6.51 seconds
TestRunner_mgmt-tester        FAIL      114.56 seconds
TestRunner_rfcomm-tester      PASS      9.62 seconds
TestRunner_sco-tester         FAIL      14.35 seconds
TestRunner_ioctl-tester       PASS      10.48 seconds
TestRunner_mesh-tester        FAIL      11.71 seconds
TestRunner_smp-tester         PASS      8.83 seconds
TestRunner_userchan-tester    PASS      6.85 seconds
IncrementalBuild              PENDING   0.61 seconds

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
Read Exp Feature - Success                           Failed       0.100 seconds
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
Mesh - Send cancel - 1                               Timed out    1.821 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7702440857685502159==--
