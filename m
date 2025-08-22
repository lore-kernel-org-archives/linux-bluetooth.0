Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D657D393DE0
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Aug 2025 01:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755825930; cv=none; b=UcyikLz01DQOtMvcqQmj5sfrqmxLL14VMp8BhOgV2Rjo5mVY3wdNjNXF8jLjCrtL/61jSdnlTP+YutcEhJvU+nKUntAM0BonO2d0ImRHCnvXbk1LTJlUe4p5LIditm0eLP88HXBlpB7xKTqKzZMQU1SInYDMgrF8S6wzecnaUsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755825930; c=relaxed/simple;
	bh=5XUpmw+1GpB+rRGcdxjhdQGBWp4StOufb0SzJAnjK6k=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OCiVdA2elAhDp+tNZKuA+kUWKuhFQtrk5zuZrcLgBnJi9P2PHu8LIjnKgKDnI73Qix4uFYUM8RSdzrLleEeKAQd1nr7LnK3Jqincbzo5ueMtTFrUG1do1lDcWwrvWkrfhRElwUfjwPDtxstwlp7pRGf44QFlaqQAMWEIma8O+zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KbeZVzX0; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbeZVzX0"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-88432e6700dso25482439f.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 18:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755825928; x=1756430728; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=H/uzvQ5WJdv838HFYWlCyb/dga7sbIwe8BGG/GAwaas=;
        b=KbeZVzX0sEToepcdtpiXf8VzmdFeSGB57F3q8BGzp/0pCKZZatdswkiHvedQoUqEkp
         d89sjLZl25oOiydrXVN2otx3uxavbzrcDcycAeWzNCSCHwhfRnLF5GICq7jbefSvNDjc
         RN5LHq5fssYcvJzIvSBfvqyEpfQ/D1FnI/0c6yjos75MDEwUSs3xI9Jks+8KrNiIStpN
         ZS9UhRd6FrTEfZLnhulgizvlX3hZnK6iShdExai9jbMy+/cPsLHlzwoX3YOr9XAsX1dr
         lqF8DRR2RsE2iA3Lsh2a/rtZD0G1vYG2daJ7U98uin8VW048KJUFEv/rchqQY0nIHxdS
         R2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755825928; x=1756430728;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H/uzvQ5WJdv838HFYWlCyb/dga7sbIwe8BGG/GAwaas=;
        b=Zsgx/wUJbebf8jzFvgaE1BOw7M8jVRpcC6SVm/NBW8m+qqJiTmGBIL36zuj91Avkwm
         OHuq3XEco2Ky9nsPlIsf9+UBILMNUcwEV4pcAMhgnkSpLOO6ziFmJ/wpSFuJBiJmpqiK
         DvoAPWtkJRU2E9XsVlSWdbNmu7qVojmNvt1XOFrTDAiuq6Col70eZ7o5vZmX3PZEuwEU
         hPbGFbYLrd+9TdBZqEolLCIOOpDNVS0p75jNJrBAGdUckopWueJmnYkxPX9bFRuPotS+
         EDnWF450tXhzqUicrQdnda+YChj6U2X2TG2rUfDFEFhB4er7bZaG+J8Wdi1n4M3323sW
         kZTA==
X-Gm-Message-State: AOJu0YycCtopzAomzjz9t/kwJSUnOOZB9pElJDeFZkVyV4nwybZts5Ea
	QaXH+aW3ASGHemfEHysXm+3Hi9aMz/9cDmoZ7HDgBldRZd6piuovFPB6i68PKQ==
X-Gm-Gg: ASbGnctQXF4o0AGCQMVVkx75jSdpHAa6URudJmB/ad4h57fQlaDn6T2mJvC6guKwtkz
	NslgjEjKzuGSoWFuF9R7TrWEfG/r+21BUp8g0e1DKd6vN897xi2zXwR6EtOBbywwGfQAPesMfaH
	CMSPykIABAz1AI9QQucqaxS0zoseT7ENc6w1GCdxfK8GCF9wRfvukr1t02uUy70YOSXDurrkLMo
	hOydUvHbLbhVbL7UUBBN+Ty73H5x1tZwvlIofnn2KDZhuC9K7Tkh+K3W+oLvJxZxdf3Yd5GCoTK
	KbRbwlFM3h5r811o7vInhoMCXueuFwcIyc18yfP3FlrnXUO++RaX2IhO8km6TzbZV+h5hB6bi7p
	MNQbzpyLB0aQayaPSipzEvbOjiI2nB270KbLXv4DOJQ==
X-Google-Smtp-Source: AGHT+IEiNUZBBkF4KFBth3HmMC4d9/fG6q6e+NQ1ocvnEP/595N/2TftwF24nqt4TgN2LoUBlRv+cw==
X-Received: by 2002:a05:6e02:2581:b0:3e5:42ec:137a with SMTP id e9e14a558f8ab-3e91f74d1famr26761975ab.4.1755825927537;
        Thu, 21 Aug 2025 18:25:27 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.177.162])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8843f9c3334sm773348239f.22.2025.08.21.18.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 18:25:27 -0700 (PDT)
Message-ID: <68a7c707.050a0220.1ffd84.049e@mx.google.com>
Date: Thu, 21 Aug 2025 18:25:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0631352301192964399=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jgnieto@cs.stanford.edu
Subject: RE: Bluetooth: hci_h5: avoid sending two SYNC messages
In-Reply-To: <20250822003912.41754-1-jgnieto@cs.stanford.edu>
References: <20250822003912.41754-1-jgnieto@cs.stanford.edu>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0631352301192964399==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=994289

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.23 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      24.26 seconds
CheckAllWarning               PASS      26.93 seconds
CheckSparse                   PASS      30.17 seconds
BuildKernel32                 PASS      24.49 seconds
TestRunnerSetup               PASS      482.49 seconds
TestRunner_l2cap-tester       PASS      25.04 seconds
TestRunner_iso-tester         PASS      36.78 seconds
TestRunner_bnep-tester        PASS      6.00 seconds
TestRunner_mgmt-tester        FAIL      128.34 seconds
TestRunner_rfcomm-tester      PASS      9.47 seconds
TestRunner_sco-tester         PASS      14.62 seconds
TestRunner_ioctl-tester       PASS      10.06 seconds
TestRunner_mesh-tester        FAIL      11.48 seconds
TestRunner_smp-tester         PASS      8.64 seconds
TestRunner_userchan-tester    PASS      6.26 seconds
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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.101 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.200 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.155 seconds
Mesh - Send cancel - 2                               Timed out    1.992 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0631352301192964399==--
