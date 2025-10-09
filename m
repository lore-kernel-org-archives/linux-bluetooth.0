Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EE554654
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 17:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760031251; cv=none; b=ATI7AmNVWG+IqtWtpDbTtClJog9yzD5iH/7UOTmAFtq+AE2A9LgkIES+OlT4q2SGh5twcZdV0FjKQYOVMzcIFzPZ7pLlry4jZIBHr3mESsl5vXXCiLidKmX98nLl6p65kAFRGL+bnd1U7giEfDYv8r/qCx5B5q8YT9P+cuvF4Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760031251; c=relaxed/simple;
	bh=hPiRoLR/v8fe1RUygoTbjojjmg4hFQCCtoSel6OKozQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lwA5mvjJiYAAJkv/nN802M2DxxzQIM+mejuugqSXe/hUGhJeOb7lPEPhRpUZbio0k1AtpU/Spq4aYPsM0WbNTXq368zd0PV5hYpYpgBkrCf8tPaoxa4mrm72vJwxr8Vcsh/Sl52+hiA2JG9EgW8Qo8Tl+6JEC/NTS4gmGOgRHeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=deNBdpA+; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deNBdpA+"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-79a7d439efbso12202646d6.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Oct 2025 10:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760031248; x=1760636048; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=q6wQhZtNBHlUOm/w/8K+IKZEYq1v0T4iWSgyalD9rJg=;
        b=deNBdpA+RjgUAcsw0//uckrAyKdpzVuXR7fwXlSqZWerYq++KreIWaWxo6S64sSnWc
         GOB6WHf8ESUbYPsCmGMfT1G2pCzD05n0LO7KCYWEm0H1q4Ck3e8th0Z8AMCb2shM8dDE
         pPdvERNoklh+ZoyTl4fJ9VD6kiGL+Bq8LsqaAzlSd9+Qlnxvy7811Tlojn+IvBUh4EFt
         bzyogdRY/4a7JmdjxRk+Xz4dIvpABae3C7UeQWGRMF4mEAmBq4re70mDB1Jnzr//Xd75
         mQ9cv1251zAukZX5mdWjcZqWmYhzvZwWlWFxlUE+OXQ2pS4s//MHN0RltoRB6RSVORYs
         T4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760031248; x=1760636048;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q6wQhZtNBHlUOm/w/8K+IKZEYq1v0T4iWSgyalD9rJg=;
        b=TI9iFCNW4FJsE/seKWWOFk7Uhfr1tVWZ4EgEPI7rWwLiswdFTMrEBD3RFahP4aHake
         pPxBmT+CfU47sFVsNo0hTSr5A2eL+yTeba38PXlZM7otwhmJs8dWaU8OnoX4ORv8KXNr
         O3IBgTftnLdFj0EQzfaa0jWWk6Pqw5A23V1E6H5D3yV++90OZ6SMAkuABbkKSjBaGIQB
         Q98LdIXDnA4kgHnoCjEC586LqwDXIm1lh+2TpGvw/TQklB6E2rJbRlvcIKA8yupC9nfB
         XH95g8AKyYJq3awAulmgwSjLTWCWnKmjV3Bw5GGLl0qBcQvBd//SxRSopuYRNHb0RBVD
         BQBw==
X-Gm-Message-State: AOJu0YyV8NgJv7cTKC+oZqeqnkb5h+nsyocdfybm0J8wwTgfZnxpPxHL
	U7b4XtTm/6xxLVMg9t3cISuIb6AzoUSTPKUAgFNPgrJ31z3RHpvl6MuFUXpjUA==
X-Gm-Gg: ASbGncv/jixt1M0D4ESOqhc0ywcGdkdM8rnov6C1tG5cvc3TxEjC77L5VcjK6s3LwC1
	5CcmsFNmZBkNFSrZhXoGj6dyfPtJjQFumkFEJt6Lq0DN2iSDqgmTgjJBchml/ZQ/wu6y5fcZAbl
	4J4wDDre0MO+G/BWf+jU83FLw0T1bmsNKFYlcDfzSvghVoE8nU2kOkNdDdfpshIA58nS09tu2y6
	m0rHltJ33mTOPPSWQmt8JQMurWQhwlMaOo0LOe9ts5IeKUqkma0AJA2DTM9pjyTLCMPmFYk4WwX
	I/rCBzaT5Y4x6tYCLB26H4WeolM34KLBKAB7It70Qi5IWXU9f2y8a4afavVtJJaXStcPVmfD3kW
	d+AE6EFDV0Cyy9dN/U+wNFCKtRBngTadD24hCv6l8YVDJKYDq2lv5Ui1sbP579nw0vg==
X-Google-Smtp-Source: AGHT+IFrYx47ydujOWPC69EoZm7ZT8IDBqISfnT8ORZlVJEgfK5EMMhxRxu0JAfYL7yOPyTJLz+crg==
X-Received: by 2002:a05:6214:c49:b0:874:34d2:db8b with SMTP id 6a1803df08f44-87b2107df8dmr146454476d6.28.1760031247917;
        Thu, 09 Oct 2025 10:34:07 -0700 (PDT)
Received: from [172.17.0.2] ([145.132.102.179])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87bc35ad1b7sm10006d6.58.2025.10.09.10.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 10:34:07 -0700 (PDT)
Message-ID: <68e7f20f.050a0220.25afa2.003f@mx.google.com>
Date: Thu, 09 Oct 2025 10:34:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6409205466577442627=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, eeodqql09@gmail.com
Subject: RE: [v4] Bluetooth: bfusb: Fix buffer over-read in rx processing loop
In-Reply-To: <20251009164817.3762787-2-eeodqql09@gmail.com>
References: <20251009164817.3762787-2-eeodqql09@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6409205466577442627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1009817

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.28 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.63 seconds
CheckAllWarning               PASS      27.40 seconds
CheckSparse                   PASS      31.09 seconds
BuildKernel32                 PASS      24.65 seconds
TestRunnerSetup               PASS      492.93 seconds
TestRunner_l2cap-tester       PASS      24.15 seconds
TestRunner_iso-tester         PASS      72.15 seconds
TestRunner_bnep-tester        PASS      6.16 seconds
TestRunner_mgmt-tester        FAIL      113.15 seconds
TestRunner_rfcomm-tester      PASS      9.37 seconds
TestRunner_sco-tester         PASS      14.31 seconds
TestRunner_ioctl-tester       PASS      9.98 seconds
TestRunner_mesh-tester        FAIL      12.37 seconds
TestRunner_smp-tester         PASS      8.55 seconds
TestRunner_userchan-tester    PASS      7.28 seconds
IncrementalBuild              PENDING   0.51 seconds

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
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.106 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.181 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.775 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6409205466577442627==--
