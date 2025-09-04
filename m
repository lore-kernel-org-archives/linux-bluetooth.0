Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7FC3596D
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Sep 2025 08:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756975097; cv=none; b=X1wRoTvU6V2KtlV90wQlQYSxd87bIEBryMpzmyrqZPUdUvk7entDv74ndwW/vyqZCWtrE6ut5wpeyI19E08aU0JdRp79hS+hjWMcc6KVAJ5afeU/C2/fpyISR230PG4IQ0B10rr4WtNpeIDnsB4I7vn1p/QfaX1VS2VZ5gdijw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756975097; c=relaxed/simple;
	bh=INv4Adzs7/WZA9pos97Xo+sRkpKhIhZ0P6N5xPQsfHc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bw6VpVOYYwAUZvHzfqW3RlTY5Uif3kB5hOc2odtcKRGiJnlX06vBI5vkd2+Vs5Egp6b6wTr0ksuC639pOmpMyTXBhCYQgPEDiwU8jzAWoMwpZvFr+sfOic+oaoZx3lDXKPRa1gI5fjjkxyEyuD7sRdJrapSvSCVJ5xXoqvLAfEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EaX9T1nU; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaX9T1nU"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-804437f9470so205346885a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Sep 2025 01:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756975092; x=1757579892; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ea+q1eoLP1dXa6ldfggtIWQhZbHsOGC+9Ic58U+rmv0=;
        b=EaX9T1nUyZeyIdcDmWzTKSeVTqX+xzPvxJu8PSwrSONiajwdmiaUQOcjBnd5msoNm6
         HHc679NfbDPvIt+IHS9LjLJeUCAA4eN1BbmyEWynMmzFu0m96mkBwO9mcQF3XA7nwXRK
         mh/bNp2BuBZtokUUiVd491hdRx18Dc8XhwfTaNgfVMwIaExWkJJBv59Q6OapQINrRUSF
         2ka6AHYd0JuT4nKqE3dPGcuee4/1SFAdCf3ihfZcV+LEcBqmzxw1I+rVlGqIJNb2EYvY
         KSKrNCVNAIyy43eZyIjwlUb7XBE7Y3bDsOyO22GixHmeJYiUlOVccF9qMzYcqpKnnf/6
         XIeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756975092; x=1757579892;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ea+q1eoLP1dXa6ldfggtIWQhZbHsOGC+9Ic58U+rmv0=;
        b=hZ2MC5CEF7DaGwNLpv3DLK4L/1Hi/2ZNpMLtJhr6kobr26QBoIXEv3f9H18S5X/Kdk
         mkD3tSXF7wVBrmYJOjHPKR8do8KkDFsfUjsBUjrD63ngB3BrMKUK5rBGRZj33Dzeus8u
         NeqnGtVt4/9f8h043FG7ZuuR1Z0tl1lWnfllsDzHoDP/MqP0heveF8MsZfaS1cnuxFkN
         oHo/qEb4lKmr7a3LTVOSyCYXugdQVzaI9d/LDRteNlAAQI9UE9LCCY/0sDohCALHfMK9
         pANPQS26fOy+HKVtd1L320n6B4B8sg/GY5FBt+O+xOujlZR2R7+htPcwK1QK80eo8lUY
         Fw0g==
X-Gm-Message-State: AOJu0YwIQ0HQL8BcClsLw3qfTIMfpkQV5cM2J2ShICn4V8oRQgAVTos5
	1NtMfHnfWI6nGH11pwJhilcgPLjtoYEr+r2/xZ9KAgH66DANv1adcT48mBieog==
X-Gm-Gg: ASbGncvuOFqikZhibIMkNma/6ZMLPlvdyRg6Cl1m8/UsxNqvKvq7C3MgNcu6sgwKv1q
	piFf6vaBhoNDxPas9IIXq0uADzKuZw6DAYnl8Kn46JgaHXKsMvjioKDljc5y0RCXrjvlB1heMzm
	Vd7cihE97sdWvpB3eH7WcFAL3uwv9vvMkRyGS+Cr5bnVTvd9Mi6yNS/OBoNaaz2cEDiObaEmQjk
	sy/aOWy1DMixfigubo373hTHs1nwUZo03O4zvto0VJkUC4665E4houVMCINkVuN5Bx3fhWV3zyu
	srjSiQu8sbp2m9eGnWLaUUa3DOLA+F4/cnSz4tpMy5hGJdNGo64lIyiLLyB5SHSA4iDN27Q8Jxg
	l64tLJSDY2rYzk9x4VT6TZsnS1/OU9LCnE97+b75C
X-Google-Smtp-Source: AGHT+IE5lKCrY0aS40bt+yol5kRUCPXBeIIC428aE970sZ1LGuLbCBd6FyXziq2H4O5wyW/IL892fA==
X-Received: by 2002:a05:622a:5445:b0:4b5:146b:2cad with SMTP id d75a77b69052e-4b5146b4d91mr22815861cf.12.1756975092492;
        Thu, 04 Sep 2025 01:38:12 -0700 (PDT)
Received: from [172.17.0.2] ([172.214.45.248])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f673fecsm24563351cf.21.2025.09.04.01.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 01:38:12 -0700 (PDT)
Message-ID: <68b94ff4.c80a0220.372acd.8c5c@mx.google.com>
Date: Thu, 04 Sep 2025 01:38:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0065431693718638644=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: [v1] Bluetooth: btusb: Add new VID/PID 13d3/3627 for MT7925
In-Reply-To: <20250904075800.690494-1-chris.lu@mediatek.com>
References: <20250904075800.690494-1-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0065431693718638644==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=998746

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      23.98 seconds
CheckAllWarning               PASS      26.53 seconds
CheckSparse                   PASS      29.80 seconds
BuildKernel32                 PASS      24.03 seconds
TestRunnerSetup               PASS      475.58 seconds
TestRunner_l2cap-tester       PASS      24.81 seconds
TestRunner_iso-tester         PASS      42.64 seconds
TestRunner_bnep-tester        PASS      6.01 seconds
TestRunner_mgmt-tester        FAIL      127.97 seconds
TestRunner_rfcomm-tester      PASS      9.39 seconds
TestRunner_sco-tester         PASS      14.63 seconds
TestRunner_ioctl-tester       PASS      9.94 seconds
TestRunner_mesh-tester        FAIL      11.36 seconds
TestRunner_smp-tester         PASS      8.63 seconds
TestRunner_userchan-tester    PASS      6.24 seconds
IncrementalBuild              PENDING   0.69 seconds

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
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.104 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.117 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0065431693718638644==--
