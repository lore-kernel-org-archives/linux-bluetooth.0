Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6526F3BE64B
	for <linux-bluetooth@vger.kernel.org>; Sat,  9 May 2026 18:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778351385; cv=none; b=A6DTWhrB8xV3fhwjiMZ1205HU4sw61TRcCRRc94a9ZuAcCXSSJaUm9E6o409oHgOK7oKm7tDx/WaWev0c9R/hvQzkwOMmJt9eOdPIhBOgdhHZjnqI/Gt3AVvBSjFi1oQ3+9ccb5pdpF5ei2Xu6C7kHU2v+2kNuyxvkspsaPRVFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778351385; c=relaxed/simple;
	bh=9tboLHOB7+/bPe6WjB3YCFv+Oqk80h8z9HHnECe6ev4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hzKbDUH+dsk1BP6GDnh4BwVf8CWOlYVK5bQzldoy5aiHtGH3bi2KPm8nzmoq9kwm1m9pzkEdy4PJ3Hk96/9aWH8p1eLm+GgGzzr1jE6XMZIClcNHBJtMqlceuxfYPJ0Wwb/+dGHh49bGZbG7eDN48nMT84bbQDPs3GkGMx/qqGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANym3iY+; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANym3iY+"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50d880e6fbbso36898181cf.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 09 May 2026 11:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778351383; x=1778956183; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3dm4NSatJulmQzOLH+YaysLTCpseTr4zZi0+py1Rweo=;
        b=ANym3iY+UqtpsAVS4kYwX2gxck7q0fmtohdneHJ3zJnkSIkEMIqwAmI1IHljlOUh3g
         ZtDYyVkQtIU532l53FiDCp2cbGktLfdeFAaymr/ZcsA5OxB7/llzeeCozNxkkjxzfiaf
         L7gCpEHTJGUrU5c2YMl5+bUO/8LqGZHiM0Cr6+SgUDfjEqqLI5xJiMKwNB9IZbbuaRfb
         H/t8LbS8LAUIMSjJBlLrCN6sPKihW3RxjDve2evX0GbBappb6BO71M/KCoZsRkj4/dCm
         tXwTNTIGX2LbLnrjBi9/935QgPPjteU0P7YaiIDw+NJBOgExQNj3mNafywljVI1vT8SY
         iEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778351383; x=1778956183;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dm4NSatJulmQzOLH+YaysLTCpseTr4zZi0+py1Rweo=;
        b=R6vlAvraJYCm6t5zrIsX08jhz0bfHq1aRttXxtxi7vVBwADd/apqHSwSbRJhreGu35
         DToLH99/39nJ7NVhFFpZ6oNqcGSpgWhncv2N+IN83erJRu+V4GLE322rX3/JaHxtaof9
         ARxQ4cfYOlpXoc4JLUg8+MHbcza80s3b3xoq8HVp+9KrMMBFmmg+WTrOZWfnwXHG7txt
         P3kkuKMeyk4ZqOCp1nGyjL+8wrFjHXFnzVH06IiuuO8RiGhvliGUDr2OcC9qLdb1EOGr
         7X11cyIcsXIuxvRevQzmKsuon4sBd0/x/sqg54aPHCgiOA5u/rohQbT8i/UoyfJrfs+e
         7vBA==
X-Gm-Message-State: AOJu0YxNX55YCF4XrEZRRfN5e1yYml2pSrxwOLpoL9w5QeomZUSOrapz
	lg19bWQKpVsUt+kaLtBLoTWNbiG+wbiBTP9NCoiPvd94KRzasYuTnSm3qvnQpQ==
X-Gm-Gg: Acq92OHq3CoWsHYT2vBx1iYfqJCZuy3GTR7dvM8WzF3yjB634k8AlGUjkX6HTNwr3PQ
	+QwY9SLjcma58IkFnt8BNBgiybXhmcDL7aPf1iqkoRr3mKs+ycD7CDwdH0xf9d/qGKc4OHFP4oE
	zDMudLzht8mk0eWloQXaV4D3Kpohp/+dSuUyE/9Ezad29GozjZpzJCCzgnOMOJfDQYfbnjAMyEU
	u0fN2g0ptoCv9P5A9xmVdqID3UG7PjytC4yHICrftKbHbe+iDUotg0sxauhF/ci+RvDAXpc4BsJ
	qKs8Aax8oUO9JyWIPH87L60PVYm0TB972WgmAy5oidVwMLWjGSfJPAa4KIpKjC/vfurWN0sl0M2
	T6lLCYF0FUaC2PJ5IN1B/NEuJaqitM6HFd1UJd6dvv9Ks0A6DERLD5RfTTq4pcQfe8OfLO3cWGl
	exoKPWQ2h4259qiS7z7eOeAKGVA2uIY26F1+oAgWTg4YA=
X-Received: by 2002:a05:622a:413:b0:50f:c9a2:1643 with SMTP id d75a77b69052e-51475b69990mr152435111cf.11.1778351383004;
        Sat, 09 May 2026 11:29:43 -0700 (PDT)
Received: from [172.17.0.2] ([135.119.132.151])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e68a963sm47129451cf.13.2026.05.09.11.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 11:29:42 -0700 (PDT)
Message-ID: <69ff7d16.c80a0220.177c4f.bd02@mx.google.com>
Date: Sat, 09 May 2026 11:29:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4021700843738845729=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, rollkingzzc@gmail.com
Subject: RE: Bluetooth: 6lowpan: Defer peer channel release until RCU cleanup
In-Reply-To: <20260509173745.413473-1-rollkingzzc@gmail.com>
References: <20260509173745.413473-1-rollkingzzc@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4021700843738845729==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1092079

---Test result---

Test Summary:
CheckPatch                    FAIL      0.80 seconds
GitLint                       FAIL      0.63 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      26.63 seconds
CheckAllWarning               PASS      29.30 seconds
CheckSparse                   PASS      27.94 seconds
BuildKernel32                 PASS      26.06 seconds
TestRunnerSetup               PASS      563.40 seconds
TestRunner_6lowpan-tester     PASS      51.05 seconds
IncrementalBuild              PASS      24.62 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: 6lowpan: Defer peer channel release until RCU cleanup
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#117: 
The buggy scenario involves two paths, with each column showing the order within that path:

total: 0 errors, 1 warnings, 0 checks, 236 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14563151.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: 6lowpan: Defer peer channel release until RCU cleanup

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
21: B1 Line exceeds max length (91>80): "The buggy scenario involves two paths, with each column showing the order within that path:"


https://github.com/bluez/bluetooth-next/pull/161

---
Regards,
Linux Bluetooth


--===============4021700843738845729==--
