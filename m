Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A601877
	for <linux-bluetooth@vger.kernel.org>; Sun, 28 Jul 2024 09:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722159602; cv=none; b=OjLoasWC+OnQs5pwFj4yo5N0VhRApXbkAwyNjuunPuZevxI7oyRXDTdZpRFSYnBFKVH+ojdYvA4rp9UUW1OHQRKR9JE+KGODlfJN0r4L81aYz7MZ+dNbsHrZJySq3W2NGPPVlVkJ6EHOhNa/AqXG1UpI0dx5dw1AG5UegivZzzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722159602; c=relaxed/simple;
	bh=23+aihIfe+9hg2e97aGF3KOJugJuq7cx1Qqv3hrXn04=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QF68gyS1aYc7oMMuV6j8IBSDrCAfHBv/k0ABdIM1gdz0SNnfsyzzQQf2yAdC5o9xMr51RvJO9CnyGtHUoQABsUxuwouEOL7TZgrrghY632j75GO2D+vfH7p5dqgfpr0clr/eIykO9qvpoITR0B+pmhnNklagCj+/N3vUr5aGVmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhVCCt32; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhVCCt32"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a1d067d5bbso148029285a.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 Jul 2024 02:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722159599; x=1722764399; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AsYIYqMqUIxFOMMdW/E1M7jhCHWeikJaRe9KHfx1/fw=;
        b=XhVCCt322V0rwqPFbb1PLwL8VvKAs2EbsrfHYYhtGuNx+EmncGVlZ45+fATMIb87Hl
         owIM1eS7xquMevlTAyuSFIU6rdYRf1QqattsweYLCtJgVyYiHKlhb6Yg+KwpUqrXB9q4
         2acd8A04HvoK4bO0V9VJcIotGa0CAiscd1XuRvzq3eH+okPMHQvlwFor9w5fwn5FvBpZ
         UVzL2xDd+9ghS6S/XHOTPU/gfsLLk15/skB498N/6pyd++H2E+737Ic+NNsBPwXSUhUp
         b5CheKlVHiotdYhIm16MSMgw6PJ7uqd+uiN/Xjl0WWqespNBPZyKFXBmb+cC3ie64Pur
         v+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722159599; x=1722764399;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AsYIYqMqUIxFOMMdW/E1M7jhCHWeikJaRe9KHfx1/fw=;
        b=v8l5HGmeS266HP1d1beezNfbBKtERXmC2wl9+z9PZSC94w0YygB5sp2ago0+jX5r/U
         CyixusdxUcCl7pm65ZjxVIfk85JYSqabG5gFJRaFP7EPSqpW0cIBfePPmW8OuQEuZDqg
         pfhAUVQCXJlNDElyadekF2NAnxtQLZa2vNu0rkY4BVXdf6ZrIaQ1p+CK+yMOo5lvWaXS
         40D4xqT3yk4yeOJOb3GraHksURYBHeBCamssB5guxx9YIuUOOPejI7nPh5sMNWEMsXbA
         OCVxzTaRfxeKM+00/YE7tMumjAhPY6j71gvxTsPKawjLxo+LzNZe1e22Q1YjuBtZWEHc
         Vacw==
X-Gm-Message-State: AOJu0YyENBEyd4tDvMpxrWnlB/SBWx/dx8vkabOjWewHbwKZe6oFcLcv
	OCEmFn8WPzpQWkgMxpfa00rJkwR5T2dPUYGIzUmjBE0J4h1FNlMjMPmu3w==
X-Google-Smtp-Source: AGHT+IHVs4+U6H53Qx02o/s6x3jcKCH/GtlWCsJGjqdH8Lk8Otf74gOsXJee/ksV4CioFxuFf1Bpwg==
X-Received: by 2002:a05:620a:4152:b0:79d:569a:699f with SMTP id af79cd13be357-7a1e52676ccmr550846685a.39.1722159599207;
        Sun, 28 Jul 2024 02:39:59 -0700 (PDT)
Received: from [172.17.0.2] ([40.79.247.106])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fa94f4fsm41425586d6.78.2024.07.28.02.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 02:39:58 -0700 (PDT)
Message-ID: <66a611ee.050a0220.398a6e.b525@mx.google.com>
Date: Sun, 28 Jul 2024 02:39:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4238981713928420985=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, uhrmar@gmail.com
Subject: RE: Add pattern matching for service UUIDs
In-Reply-To: <20240728075622.333056-1-uhrmar@gmail.com>
References: <20240728075622.333056-1-uhrmar@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4238981713928420985==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=874291

---Test result---

Test Summary:
CheckPatch                    FAIL      0.67 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      24.47 seconds
BluezMake                     PASS      1640.03 seconds
MakeCheck                     PASS      13.64 seconds
MakeDistcheck                 PASS      176.29 seconds
CheckValgrind                 PASS      249.80 seconds
CheckSmatch                   PASS      355.35 seconds
bluezmakeextell               PASS      118.88 seconds
IncrementalBuild              PASS      1402.63 seconds
ScanBuild                     PASS      977.20 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Add pattern matching for service UUIDs
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#89: 
This commit extends the pattern matching capabilities of advertisement monitors

WARNING:LINE_SPACING: Missing a blank line after declarations
#109: FILE: src/shared/ad.c:1370:
+	const struct bt_ad_pattern *pattern;
+	if (!uuid || !info)

/github/workspace/src/src/13743839.patch total: 0 errors, 2 warnings, 59 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13743839.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============4238981713928420985==--
