Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C5D7E105
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2025 14:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736865069; cv=none; b=lg4Ldfqp3kM8J8Y9tb9W0LRISsXpnPeVDoE7zW/nwJFS4eaotd/Uf2bJ8oVpXpxNZulHSnVmSDeIRVjle5+5KID9RzynN2lOAACM9KPFAqngzKrgwZr70cXsyYC6hSAu+AFlSlpa/SlsBqk9m0J01QxAQJLduPYlFyT/1g68J9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736865069; c=relaxed/simple;
	bh=EwerTauMV1gM+U5FvkdwkKChFeCeOm24v5+YfiyQV+U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=APatMqVhsZqr6ENi7DabvoSW1HVXEorBMfHmWa+LppKO6dO/G5L9DwijOLyCsGxNU12aBfhoLv/NDAaxiwvyZlwPuEDW1MuqPXSX10wYvL1KSKObbdJiaop4xPhmWA0xjCC/174uJ+O3uPoZy/7dwjeyq2GWcq57g46SDuv2LP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VobM2WX9; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VobM2WX9"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-215770613dbso67536795ad.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2025 06:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736865065; x=1737469865; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=o5QNA2SutN7iYos/+XcLyvDA+XWELNxGdUwrGGoVxlM=;
        b=VobM2WX9gONbEEIvgHBxPULBAhx66Wynu7HrtmjWxuApUNQZ0lQpLAuU/zmg+wdB0b
         zTD7A2cwDxuTKEHyumSV4weXqclmvVPafd+CWzN1C3dsvkwwRJ2i5hEar61Zc33mJsvK
         odbgUcjJag24R1ZiN4j1nznD7KwsnAUNEbnFQdVkz9koptQhH3vs86FT4Rkdzls1SA7w
         kmAzVyJnghpGtXo4Vc+P5P9uz156BqjuY349EKxbgc6EEBeYexExcUBaPlvAOWB0DqhE
         Mi4uTzqI+d2z7De4T26lbdaF/jfjVw7SGkEBApGy9fsiuHqG9H031cuARwEL57hVNLcS
         KhjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736865065; x=1737469865;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o5QNA2SutN7iYos/+XcLyvDA+XWELNxGdUwrGGoVxlM=;
        b=dwur3TneFhvTK8uZ17k7x2LnBYsv3bXxliFKlCHQ/BXEDHAL7KJodpdwIJLcE1TOkU
         AvxBBJCyH2CIH6+xeCcGPFg1NW0DUrA6dK4D6t5lG1qjS1A3oP5PQcD/2+8f/6Du7SIM
         tsVGdj26rHsiJeUAmPyVpHJP3B9mR8QyhTiyeOkp7tgHymBeQOf6f0SHv/algY+skGAZ
         /T+0OB8frHrdiM1FDqp+v8AxbYjl6GRFcYt8rqdFG7VKZ+22Gfx1O7Z1q/kt6gRQQIc5
         O/ayuz0rRywz/90oVHv/MSSr8Jo8XR+yRLiqnwwCkOmDxgazCOF+mdrPNjoJQVdmd3Q1
         QpKQ==
X-Gm-Message-State: AOJu0YyhtWzL2IugbE61jIESgj67fv5t/3uAWlBr6yyxzeFdUmq6nydo
	XlMcYBAxDDx3mc05+7raWQYaJNN+HLp1zlSIMUtERkWY4cGBqoKnYrV+0w==
X-Gm-Gg: ASbGncvkexUEYos+SwQJXUQq8wmNBokLqgOvPxljgjETiCx1f395g1XVHyL80A0FmYg
	4x5VIP7grIPmqFK9ztwOfe9ikpF5B65TvyJ+MrRryLXT07Q1fJYQRvVtB5WB3ff446y9wQ+mMju
	tCv7WLBsW1YgGaKbEIXaJayFOy3A0aPuC5qo9LmWEzT4bUywr9mOCV0/b6r6/hAhTqDavld7V5e
	ytA4CvPaIRDiv0oLoP2U/gMyxFZUUizVLab8ISxYbYYfHedZRIggKXW022otQ==
X-Google-Smtp-Source: AGHT+IHMqnWqmQBDD3lPylxNIjXTsnwGKn9yIl31ANOCJWeBxfQVa3Ty3wi+PuTj6tDaLJ9E3PdfsQ==
X-Received: by 2002:aa7:9a87:0:b0:725:ead7:fcae with SMTP id d2e1a72fcca58-72d21fb1d57mr35898156b3a.18.1736865065441;
        Tue, 14 Jan 2025 06:31:05 -0800 (PST)
Received: from [172.17.0.2] ([20.43.247.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4067e677sm7447258b3a.121.2025.01.14.06.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 06:31:05 -0800 (PST)
Message-ID: <67867529.050a0220.2d898.8b9c@mx.google.com>
Date: Tue, 14 Jan 2025 06:31:05 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5979701503519869358=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v2,1/2] dt-bindings: net: bluetooth: nxp: Add support to set BD address
In-Reply-To: <20250114133548.2362038-1-neeraj.sanjaykale@nxp.com>
References: <20250114133548.2362038-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5979701503519869358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=925266

---Test result---

Test Summary:
CheckPatch                    PENDING   0.40 seconds
GitLint                       PENDING   0.31 seconds
SubjectPrefix                 FAIL      0.38 seconds
BuildKernel                   PASS      25.27 seconds
CheckAllWarning               PASS      27.82 seconds
CheckSparse                   PASS      31.70 seconds
BuildKernel32                 PASS      25.89 seconds
TestRunnerSetup               PASS      442.09 seconds
TestRunner_l2cap-tester       PASS      21.32 seconds
TestRunner_iso-tester         PASS      33.23 seconds
TestRunner_bnep-tester        PASS      5.15 seconds
TestRunner_mgmt-tester        FAIL      123.21 seconds
TestRunner_rfcomm-tester      PASS      7.72 seconds
TestRunner_sco-tester         PASS      9.47 seconds
TestRunner_ioctl-tester       PASS      8.15 seconds
TestRunner_mesh-tester        PASS      6.04 seconds
TestRunner_smp-tester         PASS      7.07 seconds
TestRunner_userchan-tester    PASS      5.09 seconds
IncrementalBuild              PENDING   0.66 seconds

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
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.209 seconds
LL Privacy - Set Flags 4 (RL is full)                Failed       0.291 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5979701503519869358==--
