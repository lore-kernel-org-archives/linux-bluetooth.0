Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CFA3B7742
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Oct 2026 20:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790974070; cv=none; b=GyR0jL1KWSZpbxpV4VQUGzZnFY4oRKK8hybRO+9B1BORuhrKmRnaxURoLAaJ2QeCszxQnL3Tr6qwPdeOS+qntOPXThf0wF6jdnhHdk/h+g9SJSJMJymw7pUZTo5E5GoeQvnogjUwZulerS+ygeH2R9XPNwA+XqIljdP7ZQsf49Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790974070; c=relaxed/simple;
	bh=m9VKWx1qkjkk89wEwskPmOJGFmeRRNR/eMfQhNr7r1I=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SjOTrrlKOYs39iVC5e6zpr4uMyaXjqZC6QlDUJBf/AYN6fv4b7e0+x4KLMHkL1KjFYWmnXV7NC2WjZLFWRCQ+rdAQboaJ5nCYap7f3KM5rseMe4dLcgoVe+wQsIj8NiO0RNzvJeGhFOuzCqCUQR5Z8BAdxehHJCLXFhxi3/FLYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kg0Slgq/; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kg0Slgq/"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso2582538a91.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Oct 2026 13:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790974062; x=1791578862; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=C+V0eMKtn+q/Tv+kHhfuSbblVQcnDvodbmRRsOxb1Eg=;
        b=Kg0Slgq/EIm1mEvO3szEn9ommDykIiedvjPZ0OaCNgHHQBbl4uKtXS1vd/zmgKoF+z
         BhgDNtRNggF9SbA2s+2XUpHJkDRutUc9Uy79kemfzD9AtjUV0VKyu+6Wp25U4CfYpZLp
         bBDhWvJ3hl/Pp09aqIVYVEj3xz9V84is/yi5zHCIiPtZerTKKjwI9tIVUghSQlbtVW+2
         i/E9OKhsTW5iBeZfIqZUJgE7UkTpB6Z6hAo9vUpD2v7USwH4AxOHqWR4vka1BuWHT2iA
         j8Rsl14Mq0DAHtm+nPjCZfpPWU3JOy4JP/lKsMmrynbTa8i/CUA9+cJ2mwKGzKj2aGWi
         7G7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790974062; x=1791578862;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C+V0eMKtn+q/Tv+kHhfuSbblVQcnDvodbmRRsOxb1Eg=;
        b=Ri9VxyNOL+022n+jxXjw6xZpgZtjZ+VXXCE/cmEQ+2BpyrBjymPLZGorMjApkZCv+Z
         7GpWHuxzFE36+w+dimwvZqTVjJpeceh95WP6a2kue4YNIuFlbhHXIor2WA7u3Dm5LLyH
         on9Dx2x/Wun+a1wDd4v7AwzbdtWYJZeuP2vAEYc1QaO5WhOLRcEGW8Vav/gnlo9Dk+JE
         Zu3rVHPh7o5GYUctjAURqFnzJ/CQ8yZvjLJGNAZFvFQJSk+YkpxmosaBdeTEAbiOozyM
         hCdpSq1HqeMgRrzKOqR1J7EaWeMKs1v3zxwqdmfV0GmbXss8gsyPRlBVySigml8rNR7T
         0OKQ==
X-Gm-Message-State: AFq9FYJFFXcPhQ6yXUZS5Lsnz93BAY887T9QhWLFQGLf8VG2Sl7WjTmq
	6F/0ZKNT4nNCz81smg8geI4Iul7gLKkZ8MM0M9mXB0PJKslGAfQCRoO41ZzEAQ==
X-Gm-Gg: AYBFou3C19fwXlcKjo+xULokV4jS9FeQnBMaKvWZvb8j7UNSO6uIGux8uBOwOoF8Onv
	toz3DVMm+vtGETssyHtku76IS+dlcl3Ynvn2ZDPuY2/IBakd6ewCFYnzIcHySj14QS3nqT8agRy
	04szYOH7vbDdPJySggk/31Lft7OGBu54ne6Gj9b4ujuqswvledZc3LJeSILUrXjPmfcHbwDp0Fd
	bU5A9Ra7MD3nVrIWwBtTEbhvZbfZN8xCpMfTb1miCXHs4X/nOo048qWKBGH6lqsf0DRRQTrCIls
	v1ng/MwcVE00KxItnVtqt9vYOY7TdbdE+IMp1bjtgjgc+qIVEEuwX/k+JKW7Fmizg9ePcCPOnmO
	BfbKb4zFZHtYdp5YYf3ti4nermX1I4wc7fXQl/MgtOVgl5PgPbI4tJK0xb7gS/xjXRNYDoE6E8u
	GqDoqohmAYyhpWVaEQ+D3glEtLWw8+q23zTPiGlLE1hq2bk7ekq65SlBQLk1q3EdWMhiIb7voUe
	YKF0g==
X-Received: by 2002:a17:90b:3c08:b0:39e:6c69:9b8f with SMTP id 98e67ed59e1d1-3a78752226dmr279498a91.52.1790974061813;
        Fri, 02 Oct 2026 13:47:41 -0700 (PDT)
Received: from [172.17.0.2] ([20.125.48.161])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78d7cd47csm11348a91.17.2026.10.02.13.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 13:47:41 -0700 (PDT)
Message-ID: <6ac0186d.00feb36c.a9616.273e@mx.google.com>
Date: Fri, 02 Oct 2026 13:47:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6919389971555692050=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nicoyip.dev@gmail.com
Subject: RE: [v2] Bluetooth: L2CAP: Fix reject-list lookup UAF
In-Reply-To: <20261002171603.3368121-1-nicoyip.dev@gmail.com>
References: <20261002171603.3368121-1-nicoyip.dev@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6919389971555692050==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1178498/

---Test result---

Test Summary:
CheckPatch                    PASS      0.82 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 PASS      9.38 seconds
BuildKernel                   PASS      30.18 seconds
CheckAllWarning               PASS      34.31 seconds
CheckSparse                   PASS      36.86 seconds
BuildKernel32                 PASS      30.03 seconds
CheckKernelLLVM               PASS      35.32 seconds
TestRunnerSetup               PASS      804.08 seconds
TestRunner_l2cap-tester       PASS      20.24 seconds
TestRunner_iso-tester         PASS      12.88 seconds
TestRunner_bnep-tester        PASS      3.37 seconds
TestRunner_mgmt-tester        PASS      61.33 seconds
TestRunner_rfcomm-tester      PASS      4.46 seconds
TestRunner_sco-tester         PASS      5.61 seconds
TestRunner_ioctl-tester       PASS      4.61 seconds
TestRunner_mesh-tester        FAIL      7.77 seconds
TestRunner_smp-tester         PASS      4.31 seconds
TestRunner_userchan-tester    PASS      3.15 seconds
TestRunner_6lowpan-tester     PASS      4.38 seconds
IncrementalBuild              PASS      28.56 seconds

Details
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.394 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds


https://github.com/bluez/bluetooth-next/pull/852

---
Regards,
Linux Bluetooth


--===============6919389971555692050==--
