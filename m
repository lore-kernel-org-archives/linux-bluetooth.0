Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683971FF1D0
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jan 2025 17:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736357423; cv=none; b=JYVz+587VBeHhsCZafmwgbGxcYX1bF0wIW5l4UBkdhFEjFZ+ZHADk9xc/F9zzU+1hDzdFP+YU5xODenGVauyl5T7GXgBZTNUUmZpyQ9C6FXBF7IhZoZu88wfLDfByuNrAP4Utfp24LyYhCJcL9OnvN1qjbNs3GrOwLfpYQC/U3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736357423; c=relaxed/simple;
	bh=/Y+zyounKocQIwgeEwaQUkHO4v+M38OG/wwQ9ADz/zs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UldD/WZEjnv9Oti805OC8MnMk9My88KnefpRFa/bFLVGYphwvgLGmjPrqpkSm3d0K8cp+H0wqR7jMFmjhuFyRgURCf6VR16WdYFXj/qwH5ZjwCaKbA0YKLpW7yqN9gx4FQCE7vM/6VueO3fz3WhPgM3XeQm23hYnyGQHVOHGgIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJem2XhL; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJem2XhL"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2167141dfa1so613605ad.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jan 2025 09:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736357421; x=1736962221; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TwtINmxR26V6PfpszL84iggtrQJb/ZY37AO70FDjhFs=;
        b=CJem2XhLX1hQVzrlCPqcd4l/8g2x1WVS/BTMAMu5q1EJB7vqcGdwM8QqmKxhFaj0oR
         86XtaG4/VXV4a8qyo6p+MxXrTj3q/2k7u9brWstcBCrAg2DhjKVzXD7LrrcwpAl7L+vR
         n7LYffhVssWM+J0BAcpUz9UDOxxeo/EzJGmuA8hLT/yU8DM9n8pjEajPuImEAdD6M/e2
         BMlz1xykDiRM/+F66voKzjBh8L6Wl5MmlVNQSLXnedT8qwz/LZmK4HIBqoNo6ebi6K6M
         RmA5IMD1OnjuYYCP5aw/QoBn793u4rfPxFU+iSqo7AL7elWHPtpMRrxYmJX1cs8VbkB+
         6RPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736357421; x=1736962221;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TwtINmxR26V6PfpszL84iggtrQJb/ZY37AO70FDjhFs=;
        b=xDgnkH8470yxTnvZvlOU/3CeFKxKPf2yACCe4ovufrQJWNSWJwrp+nyMepA2SxxhuP
         dkmluhddcH3QJJu4uUmvIJcOnmywyyoY8De5quyhrOZjTpYs7Edg5/Pl4jrnt5NmH8aJ
         08t+CfxiOO6hoXNppmaHoPLn9aBtaFQ59q8lbSecLLOMTMalyITH+Wx+FtU2Ams5y3Ro
         Pz+waIcWKrV2+2nqJ8wUbgdP6bmaOMSOOzuAco/NeYZfihYMZRs48tYuYC4vr0ag0Og9
         mdPt60SFkpS9OIg9ZbAbFWL19yIhRdNkLNRSYYvrdnVpA9oecSYxpTJgs6KpkzLRrbjg
         jX8w==
X-Gm-Message-State: AOJu0YwjIwaA03UEAhU4AIuDGadA02ijiWnO13Ar2vLRl3tMd60RG3QN
	fZ17+6vGixtRIRuNtv4bQ2aZTklpBr7PzAA4K/GduO5iFw8nvrcPGYrzPw==
X-Gm-Gg: ASbGnct1xSdsl/SI1pz5l8QmPmBaSQ+4tOm9e4wkvz33Ycv9//A8rhBTGvPYj9afefH
	N64kCZ98+1cExD1Vm7Ef7MfsYwNnkPJ2y9PNqMVylxS0h8pjeMx9IhssBPBqWuucF/JbekiZw7N
	xyeXUi4t89QxErO5CCl1z8HB4lqbaqBIjYdUjNHoqcf0e39gV6xqX+s0IS8iiDuauaqgVq3RIVx
	WCEr8csOl8J7aKuh6Q80AEznlKCorPZUGcl0qeGlOxY90QIdrI9AfVQ4E+Q
X-Google-Smtp-Source: AGHT+IFjlMSRhY2Vw45cNjy2blUsUURYjV3/tt0SdMLMvcebSXIVUpbszWP4phY+HZpPGOKWNVTJew==
X-Received: by 2002:a17:902:d485:b0:215:a56f:1e50 with SMTP id d9443c01a7336-21a8d66c594mr1857195ad.8.1736357421292;
        Wed, 08 Jan 2025 09:30:21 -0800 (PST)
Received: from [172.17.0.2] ([13.91.68.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca013f4sm329682745ad.234.2025.01.08.09.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 09:30:20 -0800 (PST)
Message-ID: <677eb62c.170a0220.352a47.be90@mx.google.com>
Date: Wed, 08 Jan 2025 09:30:20 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7513057723076682990=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, tcrawford@system76.com
Subject: RE: Bluetooth: btusb: Add RTL8851BE device 13d3:3600
In-Reply-To: <20250108170111.16824-1-tcrawford@system76.com>
References: <20250108170111.16824-1-tcrawford@system76.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7513057723076682990==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=923470

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.37 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      25.31 seconds
CheckAllWarning               PASS      27.94 seconds
CheckSparse                   PASS      31.63 seconds
BuildKernel32                 PASS      25.22 seconds
TestRunnerSetup               PASS      442.69 seconds
TestRunner_l2cap-tester       PASS      20.59 seconds
TestRunner_iso-tester         PASS      36.21 seconds
TestRunner_bnep-tester        PASS      4.81 seconds
TestRunner_mgmt-tester        FAIL      123.81 seconds
TestRunner_rfcomm-tester      PASS      7.55 seconds
TestRunner_sco-tester         PASS      9.34 seconds
TestRunner_ioctl-tester       PASS      8.11 seconds
TestRunner_mesh-tester        FAIL      6.11 seconds
TestRunner_smp-tester         PASS      6.91 seconds
TestRunner_userchan-tester    PASS      4.97 seconds
IncrementalBuild              PENDING   0.80 seconds

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
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.162 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in run_timer_softirq+0x76c/0x7d0
WARNING: CPU: 0 PID: 63 at kernel/workqueue.c:2257 __queue_work+0x687/0xb40
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Failed       0.108 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7513057723076682990==--
