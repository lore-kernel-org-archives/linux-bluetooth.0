Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B264AD4D7
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 19:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790278389; cv=none; b=LscdTol3G0FIX3hs8B6wH1V5uJYg8J5JXL5dWHcygL3+/pO2zsXAxvwjLyzjY79YlvoG8QuaP0gi11ABd/4s8ajqEQBT6XR+Ac55OWDma7ZgyVADySru3T4OlnTqZgFvndahR02EbIlgU9azxDdCtl0j7bEKmp93KGILyJqha1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790278389; c=relaxed/simple;
	bh=4xKbW9jNkJch5XmgItvPJMY9bqK2baC84b7NoMu3Byw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SvPHEP1uIesp8pmBxPu9BGiKRCZjTFJiekprc6A4NeWaN2NADI+l2yLxLhxbXN4sU32fu+uNPdxVv8e45vk3qmsb3D930pLopzhWyaQ5EvjtfoDHlLRm/77W7SPErm7rRTgAOWhhTsn7pR++ayokegFQdsQy6AJ4Lu6VAMWqsZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FlIUN0Df; arc=none smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlIUN0Df"
Received: by mail-oo2-f39.google.com with SMTP id 46e09a7af769-7f4f0cfb33cso116237a34.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 12:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790278380; x=1790883180; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ek+pwANrxwTWEZi3/idKrXjcariVs7u27DlMM17OR3Q=;
        b=FlIUN0DfJPWdwI4u0Ey6X4eILDmUOyTXUy/aXU1aWGjtHlG91CStYBV6eNQge1wVXs
         FhkxPW4j8AJlx4oTqr1wv9OfoEzodo9psa7XNAyqMfoi3FLfGYU7ZFB7wTldVpcarXXa
         bLfy0F+z54HIWEgyGrH0O+wg/13wiz18gaCxKY2t4LAkrpyhGO628mLcldjKKUR5Pvvy
         AkBG7MFScBSQrlCDlao6VWhlqF0jyWTZm+wCIoCwWP3jJup1l5JjB7gs9avlH4U4HQBo
         rfu6i06bCjOylAWgMqTx0aTQUifdHFvGC4IB1ALH91Lf1Vwb1rPvgwQ2nor1UupZw54o
         gdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790278380; x=1790883180;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ek+pwANrxwTWEZi3/idKrXjcariVs7u27DlMM17OR3Q=;
        b=hjRUrG1N5ENjrsVgsfUI5JLPKmy3e+TGhQoFFy7P/8qBsHl/XbKDjks3mOvEVsv5mi
         xFe85Vg8iiHQokEuew0yQwX+w10AZKg5vp40HwVz9U566xoWJlxo5VmEBcVu+HW3aOF+
         dQlHrhrXlkbLQoGuT4us+bzhFkSYHEA+Ly1F+o+ccicCe0puAXL+gB5EAYRF4ETPhYZH
         Hq6LoaN73SNBYQCzwwxWgXAdCvtfJGJ9RWext+TQ3vyEiK2pmluW3aRGAajwIwcE1pab
         x8fxrgY2J0cYxq8qgN4dbyQuf89mmmvv4jdDPV6ovzxfscPw9qV/XqA6yy4Fj4/nxAjk
         Z+RA==
X-Gm-Message-State: AFuF++mkHndTZYIA97zHujqNMDDqVCkjV24zSpKefI1YzSnvO6Phigd+
	/+0Kg7da4XwV5a10Ngcqy6K4CbEAZJKYphtToiOpxfWz00j4tw7NaopyArM/Mw==
X-Gm-Gg: AYBFou38pv4NzLMwG/JUqSIL0dRwagFDTsrYR0NkcxR+iJvtFdn+Pp157cM7LS0Ee85
	3xqIjylD9JPdI3fHUyliBOkUoKF3qf6BBTp8sriIG4N52tUGToV2o6r8aRJaOusyRnfWWSw704L
	L0nMWwT13peOmMQNG939lAu96UL2S+z5AC6n+44c37DjOolFcVgO+hpo0DCEQeUJA4lyf3igQAL
	qjySrjRLpdb5x2cDlSReQgtA0LbbPG9aq2jjEEpWtyqpi44+xjIn1wjHrfG4lrrQmuaud4ur2c1
	9f8u9e7Jlq5v4KnCT/jSkGoDmtT6y5q42zYxqhNddKRsnsYC46JTQKvW5xyVv8Mh5BvxQpImwOK
	riZKiRr+v35De42NcPR00isWlbIGAxJIT7YXB9zwfKNbXai1RziO1sX0unyL5EnXJu7OmF+/Be9
	J3Yeaz4mzcbNlwUQEaAJes5+RFL/0W6+NvoBFruR1z622jpaAybdowQlV2cDwlFJSlO5jabr4e4
	aicOg==
X-Received: by 2002:a05:6830:440b:b0:806:fca6:f3d with SMTP id 46e09a7af769-81782d8aa21mr3796052a34.15.1790278379921;
        Thu, 24 Sep 2026 12:32:59 -0700 (PDT)
Received: from [172.17.0.2] ([20.186.238.13])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-818e98b1689sm211660a34.24.2026.09.24.12.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 12:32:59 -0700 (PDT)
Message-ID: <6ab57aeb.5ed50510.3ae8a.f93c@mx.google.com>
Date: Thu, 24 Sep 2026 12:32:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1209026390531191982=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yaroslav.voytovych@gmail.com
Subject: RE: Bluetooth: MGMT: Fix status of pending commands flushed on power off
In-Reply-To: <20260924171158.804136-1-yaroslav.voytovych@gmail.com>
References: <20260924171158.804136-1-yaroslav.voytovych@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1209026390531191982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1173305/

---Test result---

Test Summary:
CheckPatch                    PASS      1.16 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      29.54 seconds
CheckAllWarning               PASS      33.68 seconds
CheckSparse                   PASS      36.48 seconds
BuildKernel32                 PASS      29.51 seconds
CheckKernelLLVM               PASS      33.97 seconds
TestRunnerSetup               PASS      794.16 seconds
TestRunner_mgmt-tester        PASS      61.30 seconds
TestRunner_mesh-tester        FAIL      7.82 seconds
IncrementalBuild              PASS      39.25 seconds

Details
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.421 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds


https://github.com/bluez/bluetooth-next/pull/817

---
Regards,
Linux Bluetooth


--===============1209026390531191982==--
