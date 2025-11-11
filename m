Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B57B2FFDD6
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Nov 2025 15:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762873509; cv=none; b=fYiG22upYeD8R3wosZOsW4t3TQBKd2sCiOdpU2/iihfI5c1SIWritpZ3hym+j0dvQ8bpdo0exnq8/p2BgY/yE1GtxUTqokai3hLw4xF4hSgGNU1xkatbT8cYyqEPlPCTzDFdHks0VaxnxHNwj9TtMex6UA5blUFO7sMY4Da9eO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762873509; c=relaxed/simple;
	bh=UNw8iYA56iSanWLmSjuGDdDUyWydBp43ej/cZjoiSMo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=g04GlFJKhC3VOluyjR7P7/HmBNyQK+ixBYjpFtG3iUNabsVvSqkvx4CIqV38KY0GfVSdDdR8L61Ric/Q66chXn2Za6hjMGLClUd9UwBLv3yk22xq2WpQNDzvyQ9uBgKOHx9qcPq+7RfW9p0BDw6bkI4nJNIXltPUG0+SLbt2dEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFf2Kh/S; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFf2Kh/S"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7869deffb47so41506797b3.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Nov 2025 07:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762873506; x=1763478306; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g7cDYpzg9JClbVEEIkK4JBl3mvj0rwpe79ufitZNra4=;
        b=eFf2Kh/SLgJ2HiLQjl5eIyzJ/5qSQMp1mvsiYmwWYdP9MLtQhsYR1zcKUX8Gdjpq7k
         qbp72pB/xW7KlD8CUfwHeYPjvdlI1xHPDsGklP94iPoykimgMU6pfpmMKpcHzd9bo0OZ
         LsNXug1lZ9XZ2oCbCNnleGNgOMTcZUhP1q+JEbfp/svtnSj1NwJVOD02EqA+CSJxLWi+
         hG/OY2hsORIxRwcaYI9qviPEnNvUq0HDhQMpYwI3DGGrUk8hK8kmcz6gsTU+PsWikMT6
         QZLDuTbbNWg6piDDEue08U3IUQ0E4lzhH4FkoUZx23VEOQrl0DyORBBC2ySyBS69uPoU
         w0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762873506; x=1763478306;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7cDYpzg9JClbVEEIkK4JBl3mvj0rwpe79ufitZNra4=;
        b=sKEhrgENEJ3BVwmYJRBVvoAVB9s0yxURpvKLxnNcftRmtC7GAEFMnx+8BIEPRX4Wps
         HCL7ljdB+gzU4C61H29eGG3/V2kEQXTNEiqAqJ70EumAjHq70DlDDWuvgMjAwfkSVIFd
         aWBNboPxlpFpnPvd/76NNWtHsBcyY3OHKer5eN28F0T0Yipn8a1fQLdbbT0gp+V6vio6
         7bOiHJxIoa6afMLExCY1dXLjxUqzTwTygDoJeol70b5BNW7tuRVDeWUNygVltOlB3Ut9
         7+lAoMKVJc8vcqYz+HLwXE9kDsytcROj/jdsGbiZtvE4MMXsUp+x8mXQeC6QPc4HwESR
         bW3g==
X-Gm-Message-State: AOJu0Yz3CFI0rfTUrFYAxaDoYvatpf5sjFkTBw82Xw0ws30vS5OTkB6r
	rLBs2/6pvWuyEzzDmac5wR8GJJYyi4BvTL4NYwt9uiVnNXNjnF6VN7WunUdy9g==
X-Gm-Gg: ASbGncub6hYPXsvmsUbpBJz6NICAs3i8KRIKn+6jkiDctqA9OxuCDnyNLC+52dvqViJ
	LgErByuAlpzR1BSQZN9dl/Ilk+APL2KwQeTbQq/qW1yzM0ekmbLifNttmGDAvUGmeJPi80t56nb
	iQ8VD+kB/ijmKQIyC3gmwOiTNw03YkHO9bEgY8jbOv3bpmH/aJcCkHd3ZA7RWOmwcUSwgNaFC+S
	4p9cVJW/974MAjIZ2ERnjlkO2M2g4lkg9t6uxPc4TGYLhqcIYpUYangGZCB1/BFJOtLlAbMEJgA
	lBQfTHQSMngTKwc2ANgFtjBMZN6pC4dSVlTmjngOmUSMTjEs3Zh/0Z8i8vvsK0PD69wbsUrAZdU
	6/o3/skexc/NIj1cMJEMioh4hpuXaeHtQenI1lXnbjP5jcFht0+ZH5iDcjqeKa/9btMXn6896j4
	PYSvWGpz4tJYzwDQ==
X-Google-Smtp-Source: AGHT+IEltHNcqzDVhYESXU1upvwiYrnpPJKMd4XMErYOA6XjJyMLU9Vo/AssAFb4CZa95SR3rqbqrA==
X-Received: by 2002:a05:690c:4c07:b0:786:506c:3cd2 with SMTP id 00721157ae682-787d5350d3dmr121846917b3.11.1762873506366;
        Tue, 11 Nov 2025 07:05:06 -0800 (PST)
Received: from [172.17.0.2] ([20.49.61.48])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238b2936asm73046536d6.31.2025.11.11.07.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 07:05:06 -0800 (PST)
Message-ID: <691350a2.0c0a0220.c0843.0b65@mx.google.com>
Date: Tue, 11 Nov 2025 07:05:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5280846276206655006=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ayaanmirzabaig85@gmail.com
Subject: RE: drivers/bluetooth: btbcm: Use kmalloc_array() to prevent overflow
In-Reply-To: <20251111142041.229145-1-ayaanmirzabaig85@gmail.com>
References: <20251111142041.229145-1-ayaanmirzabaig85@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5280846276206655006==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1022104

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.32 seconds
SubjectPrefix                 FAIL      0.42 seconds
BuildKernel                   PASS      25.16 seconds
CheckAllWarning               PASS      27.78 seconds
CheckSparse                   PASS      31.76 seconds
BuildKernel32                 PASS      25.01 seconds
TestRunnerSetup               PASS      503.28 seconds
TestRunner_l2cap-tester       PASS      24.14 seconds
TestRunner_iso-tester         PASS      101.52 seconds
TestRunner_bnep-tester        PASS      6.24 seconds
TestRunner_mgmt-tester        FAIL      119.83 seconds
TestRunner_rfcomm-tester      PASS      9.33 seconds
TestRunner_sco-tester         PASS      14.45 seconds
TestRunner_ioctl-tester       PASS      10.09 seconds
TestRunner_mesh-tester        FAIL      11.54 seconds
TestRunner_smp-tester         PASS      8.57 seconds
TestRunner_userchan-tester    PASS      6.59 seconds
IncrementalBuild              PENDING   0.54 seconds

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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 487 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.102 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.883 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5280846276206655006==--
