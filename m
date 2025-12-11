Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358BB222575
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 00:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765411223; cv=none; b=Ibgvk/gOgH5cteDNhthIX66oY/p2Xa/ZCKLar4bTkHnbD9OXTj9E3Q6jxNarJ745nkxQa0hiKF7Lxn2xs2LXD7xIWWQlKFkACNkhrCiqwIMz0FLDaVaBZ49CEKcsawk493DdvniPESnMhs2NnQhJU1WtH2PEuzY0sdRPxdjM1Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765411223; c=relaxed/simple;
	bh=X7WzqB2MzrFZVXDfE+zrRziXGAgtrIqrIQyy1dHsizk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bfwUa1jAMjgWpro2LbIwt9kaGFOOjJXf4E3MSsxYUCT0KbAzJdGxF7wJBlZl2nvffAm3qam/oshkl6vRpmbB1HRGX6xZQhV3Xn+8FN04VLFYTTcoXDArnu2C6hIN0ST9kqOihkiJbGPHrhb55CdCuiQS1xfrWmT8qdYmqdnkdBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=baQw3/AN; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baQw3/AN"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8b2dec4d115so49697985a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 16:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765411221; x=1766016021; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=scI1PUQN75kfHsCRqvFGoV6l2075LYccTwwA1W3FQ/U=;
        b=baQw3/ANHjY+ERX8HUmB+moLmNWk/5fR7keOI71K25K3nKssChcfQXt27b2yvM2RJh
         PQJPaOfD4lwgTDC5ao0uRE34H6hgZFAE3QnbJUTw68N3hBSXWIZ34HnbG1RYgi1ZvOg/
         bWi1UaJhzyBWuI7QoDkiftlylMuJOhoR2e92+ufnPoLdIABDzKdFOnBPz9B8moVTnaQ+
         GCqnxWkzUutSROb2ErHjMnOy8Jc16ur3ja8H2c+gpxloq52JuJQLQJZ0MJjhzRF/mh97
         3/xVsp5XVF1IdkHDN24vgtDMNCgsHUh8SgHBDmLieYjvVhBZscBBq2uiLzXSveu/9HqF
         0uwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765411221; x=1766016021;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scI1PUQN75kfHsCRqvFGoV6l2075LYccTwwA1W3FQ/U=;
        b=opgjPChdVactq1nh1uyjkHN6Tlc8N5GR664jhlO9cXzwncPIPyfV4Im+w3KMlnts2n
         GklWPWQg+jTizi8Ia0jjzQ8xNOaixQObfZ5Ey4eBbtejFErA8/ifWnMIA3fpHCRxxETK
         1PvFyTVVgB+U0/3ZKiV+b4nflahjT835uVWSQ9Ot/1wvfw/i+jCaLIqnPIPghL4gMeP+
         pUhixRxMhUufehjAlJBHTdEXULewhL2OhDyDr/ozhw3AY8fNQvIW3VX/bgnXX33Y6wUr
         im5H6dtiuALApd115s0ZoO/eqzWxQc2/9NYeBc/75fMCfb1SB4102kPMmoWOEqk8rK4N
         lH+w==
X-Gm-Message-State: AOJu0YzqezjXO7vIgqVor8pfOAiF0QqR9rNtqLz0zpEdODfZz1aJO0Gu
	7yLC4moCAdam/mrxRXQeDq29o87JFAq/3J4vYY+rfCHieePeesPKEsK8iX36EA==
X-Gm-Gg: ASbGnct3dj18PVrqzKB+V57rjSk2kaCLPcIfITidBZrms3ILAmvw6WWGgwJbOHy96OO
	7HERx3Z2ZV32L9mgzGlZuWzArHEYs1kPrZNmOikCmfqXiBKsdw0zU4VtCtFwfnADhhv6zomnvTN
	dGzSw1ibS8IE8JAVEMq8GXB+o60TtOnKn2YF8vQMhWuITad8nsacGITm+tm90X4GdBqEtLtyJ5+
	Dx1NXmwOUQb/ZEckjgXs0WLgG2xOJK30bPUSVcVkpFEFWZ/6IXskjL/G3bsv/PJG9Sl96qVt3Dp
	VLNax5cPs7V5sZ+WPQf3zgKIVPjcwrhxuOZJb804+GTXmwrWC6djkeyWfbkCyrZOMkZOWWL6Rjs
	AvinWCTDPnR2FiHbxXxzc3BjdxeKF5TTFfJBjG2o67HiNHgsLnraqTuZuNtbBfNxjRMK5FBLzlk
	rfpM8ZG3pgCCzSvzO9
X-Google-Smtp-Source: AGHT+IF+tC5LJKmFx91oy9FB00RDl3xjFQKsWlMsquzdnlx3xEYVk8TvqWsWvjfZv38Z+A1S6WBezw==
X-Received: by 2002:a05:620a:2552:b0:891:9bb6:6b9c with SMTP id af79cd13be357-8ba39a5557bmr659810585a.44.1765411219731;
        Wed, 10 Dec 2025 16:00:19 -0800 (PST)
Received: from [172.17.0.2] ([40.76.191.131])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8bab5d4d3a4sm76003985a.52.2025.12.10.16.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 16:00:19 -0800 (PST)
Message-ID: <693a0993.050a0220.2d9bb6.2ca6@mx.google.com>
Date: Wed, 10 Dec 2025 16:00:19 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0077830243481378759=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vaibhavgupta40@gmail.com
Subject: RE: [v2] Bluetooth: hci_bcm4377: Use generic power management
In-Reply-To: <20251210232115.547729-1-vaibhavgupta40@gmail.com>
References: <20251210232115.547729-1-vaibhavgupta40@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0077830243481378759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1032114

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.19 seconds
CheckAllWarning               PASS      28.50 seconds
CheckSparse                   PASS      31.34 seconds
BuildKernel32                 PASS      25.21 seconds
TestRunnerSetup               PASS      556.60 seconds
TestRunner_l2cap-tester       PASS      24.07 seconds
TestRunner_iso-tester         PASS      61.71 seconds
TestRunner_bnep-tester        PASS      6.29 seconds
TestRunner_mgmt-tester        FAIL      116.56 seconds
TestRunner_rfcomm-tester      PASS      9.58 seconds
TestRunner_sco-tester         FAIL      14.40 seconds
TestRunner_ioctl-tester       PASS      10.14 seconds
TestRunner_mesh-tester        FAIL      11.45 seconds
TestRunner_smp-tester         PASS      8.69 seconds
TestRunner_userchan-tester    PASS      6.76 seconds
IncrementalBuild              PENDING   0.55 seconds

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
Read Exp Feature - Success                           Failed       0.106 seconds
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
Mesh - Send cancel - 1                               Timed out    1.878 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0077830243481378759==--
