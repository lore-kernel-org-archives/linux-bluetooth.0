Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B2D4436B
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Aug 2024 19:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723577637; cv=none; b=VB82qv5Q9nzB1Rm0nWlgyon3Y/b2vcIBpdVDzATUX7EII5SmJQgb3JP3LFGembYugxSonlN0tStdVLx3dOd0GYmSzY8Osz3Dn+aW3r4MoAzTosMdWfILIgVe0PGgX7SfTsuCTN4RN2OXohoBhZo6VaD8ehI2WiESmfLF/e3l8Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723577637; c=relaxed/simple;
	bh=z+pOEgzTXSqEFQUqLtO9UWwKnN/OKYuc5AK6E47BE8U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WI5A7GwebTveR35itOOxR5cJHWuB9975oVshKs7yw2kc5MZa48Oc2t+ZR8MVsC+N3mb0USZMZfRhqkEcUJv8qXlDN62gf4H6ZLnjNSfDakqRTvPxQ6ligQvkp4MuY0MT3toguRQ6des5F+H08k4FmhKpYkGwFSTqwKcnJrQp0BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGv3Gc2I; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGv3Gc2I"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5c661e75ff6so3800335eaf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Aug 2024 12:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723577635; x=1724182435; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OS+kPKHO1SQ7cQGGldmMh1rg4zRxWqc6qh0xaVTe4FE=;
        b=CGv3Gc2IWPp9LMdKn8Ionrv7nLNGUlKxqexx92jlm/vJ8ytGXBFdJHtiAV5w8r7DbC
         k9qf6kpg0paihGYTQTBwMPNLgszryb5mr9TvaOfzBB2sl8stMO8WuDbkiUj/s4LoSb6d
         mOcdrUUBtfJ+GPZCWt136Vd9jO+xbUYE3EgGINl1UU0C+VDOfUhcy5NfEn6kShVfdZ2j
         bApaJMNX6b0LACq1Ap3kkHcdV1bMRBBs1qoiX5Umu3Zll+dyPPh/Sl+FPCt7uArD8PSg
         WCqoGZx9hq3osUILC3OqDiLmNEm9oqF9MlmRc/TXr732FZSHsRID+sz3JJpmkp6gQNUy
         aObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723577635; x=1724182435;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OS+kPKHO1SQ7cQGGldmMh1rg4zRxWqc6qh0xaVTe4FE=;
        b=DJXebLqmngkjCGszNjMXmrgqW1MgXr+P5amURsl8+zHiJRTKN3v+VGc81FSL5DtLd2
         I8kalLOlFSyJhe1OSABvoAmkqCRiBPf2auZBAi38nFz2I/dHayqRPukzetAF+fo6BFx2
         JN77ClLfXy9dIfjGKl/DYfpZT3IH+eLtblwCvwlEYHeAskzaIqHdQneTEYxPytgMnrZm
         JhrJ6iLvhwSP0KQYfVLcO+onQmaIrVnAUi6xcwU0GO7UA0q0GbPf4lolp60ZnAtYeiDE
         XN/MKErEBWo+dvjNZT6Z/oSoWN4QMHF5Ym2QnkIFbDsL7XN/efk3+zhE6ha4cMHC2/4C
         8Y6w==
X-Gm-Message-State: AOJu0YzvK3MBpJSnrghLZNQp+XUQx5vCD3p+qFwrpFzPH4oMWLPn7t/K
	BtxSWfcWmlKWEkH7fUFYbtRGqJ7j7dGQG5lYyo1WeO8nJHPL8QevfvbLyw==
X-Google-Smtp-Source: AGHT+IHLvURqBtZB1ZyUHsVqBwfC83g+fa5xg6lPJtK2NsTahP2EzutWvuhh8mrxgtAIagkyk7X3JA==
X-Received: by 2002:a05:6820:512:b0:5d6:79a:c4d6 with SMTP id 006d021491bc7-5da7c6c0554mr846235eaf.3.1723577634832;
        Tue, 13 Aug 2024 12:33:54 -0700 (PDT)
Received: from [172.17.0.2] ([172.190.111.145])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82e6c62asm36226796d6.142.2024.08.13.12.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 12:33:54 -0700 (PDT)
Message-ID: <66bbb522.d40a0220.ad1d5.c59a@mx.google.com>
Date: Tue, 13 Aug 2024 12:33:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2159858359307934414=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, brgl@bgdev.pl
Subject: RE: dt-bindings: bluetooth: bring the HW description closer to reality for wcn6855
In-Reply-To: <20240813190131.154889-1-brgl@bgdev.pl>
References: <20240813190131.154889-1-brgl@bgdev.pl>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2159858359307934414==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=879347

---Test result---

Test Summary:
CheckPatch                    PASS      0.64 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 FAIL      0.33 seconds
BuildKernel                   PASS      29.68 seconds
CheckAllWarning               PASS      32.42 seconds
CheckSparse                   PASS      38.18 seconds
CheckSmatch                   PASS      103.09 seconds
BuildKernel32                 PASS      29.05 seconds
TestRunnerSetup               PASS      528.63 seconds
TestRunner_l2cap-tester       PASS      19.90 seconds
TestRunner_iso-tester         FAIL      32.34 seconds
TestRunner_bnep-tester        PASS      23.78 seconds
TestRunner_mgmt-tester        PASS      110.90 seconds
TestRunner_rfcomm-tester      PASS      7.53 seconds
TestRunner_sco-tester         PASS      15.04 seconds
TestRunner_ioctl-tester       PASS      7.84 seconds
TestRunner_mesh-tester        PASS      5.98 seconds
TestRunner_smp-tester         PASS      6.92 seconds
TestRunner_userchan-tester    PASS      5.08 seconds
IncrementalBuild              PASS      27.94 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 122, Passed: 117 (95.9%), Failed: 1, Not Run: 4

Failed Test Cases
ISO Connect2 Suspend - Success                       Failed       4.245 seconds


---
Regards,
Linux Bluetooth


--===============2159858359307934414==--
