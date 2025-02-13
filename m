Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946D8BA2D
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Feb 2025 07:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739433235; cv=none; b=Ql9EBix9lcO+HK65DmJVjAaZx/5LQKVTa79E1Fv7tE0VgdNAwX7hXJyOiakvvMH7t/Mhzp9gE+r2z51oa0OFBSZAh7QdziSG7x2Bs5EeUNfgSEaOVW61RGBhU/jlitCTA/OSb4rS2E1bT5xR0BnjYTa+lfq/UMHCo7E67jaCGA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739433235; c=relaxed/simple;
	bh=dDhJykGEeNS6u3/3kA5g04/rbSMW4m3g82jcAPbzgvU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gDlu/QkqyZuZnZzZJ4aeQqmvu0Fq27dIlvP1NzYDth0h+ka/Ouiejs6vcnpErcbuBfCQxMoZowBf6xWbEnSm4myY9+xpzwI1x/EGann5g1BrT0bhgF9wp1GWw+WPoXn/pJSh+uxh1BV+pvwuihGLTHzIqC40aARjxIbz/Uv8Gk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEymq2Wj; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEymq2Wj"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-220dc3831e3so2778755ad.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 23:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739433232; x=1740038032; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=owsj6/hChxVQicxOJCfAcFhIkOXbeKcKnmlSj+horWA=;
        b=MEymq2Wj8fAUecRuap2n2F5QPgE2frANwmq/c/oz0r8mQjD8quSP3W8B6c65VzJl65
         jG+5VhOm3NmSoSGsXwfiarSrPhDS6JzlyJAyNEXCqmjEs5Ng+P5mfVttucoMk25s1ywa
         hhrQxU8jKVUoiNvAbOgGp+9XxCAB4X4aW7sj3RSr1nhM0Oy9yBD+xPXC8DdwaLvDN0yo
         1DH7RAR4k6NQlG7WvoX8N0RWyYslUB3VlsrDCKlaGtoC4LdmMdNozmLtpRTXblKCvJOq
         iiY2rB/K6ASxXVrYeE11hBJ4XTuJONGcW+yxnT2UZZ6EDMUXMuRieCM3gr5V2K7BAP1t
         45Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739433232; x=1740038032;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=owsj6/hChxVQicxOJCfAcFhIkOXbeKcKnmlSj+horWA=;
        b=W5DKSy3Ys/y+3Y8qJrCijPk5jqQkStZnn6pAyfNgkEka7a8QBkq04ey4Oq5/3yeARh
         uy61G01cNYZvLYlcGAuGIKX/3BjOXhryPv/D4HwXOdDjmQhKkG7p9qcyM0vW/+SPh/Ug
         hemtl2cXt1StQJyl5XtxTI43oNWiHzKld8dl4e3LvuL4odU05KehT38sOtp9u1meOApH
         BfykNDZ+h04wi1iSc2RJudv68rCFUordu+LqHaqBVnKkhZqm2ikI1HzhAf2sItt6NMSD
         pIOk4JoD/HplfUy6ODVung2eT5s6PC1IkjkVHwJFwFEoVXB41LxuOUJkMBfO0HW9zW7x
         FeWg==
X-Gm-Message-State: AOJu0YzRs1WmaDaHl5kGQ5QPvawiBWuxWrvYk0z8QXQrydFjAIkwwa1j
	usnlhQHQDKex4BJ2A4OshdxTcy1hchkRwRO/QPfsfMRHvBvdEJxoebEyBg==
X-Gm-Gg: ASbGnctwl2l42FpGuCsoK7XCK8e2GPrAIn0DapyU0Dm1dLZcT8hGWbWHI5ApmxsoU0N
	F45Wh+fnXJythcCdSlAyVkRGQfWf5/jUYjZU/LRbWjE4rNUjUUtVxib4nUf6yS13maSx74AY2n0
	n/+JSNmddyF/akRRmphgvkBi37rslEV19JMD1aSpcWS3c9iWjtGgWz39lMcfut3/6544ark5Z0o
	YN6e303yljl1EpjpSW8EgF5uHg6kdevniV+do2mTP9E1ZN6HvUQNbTalLC0DzQMm4eWnVKx5+nY
	twrUiwRnljwzfqPRkrB0qQ==
X-Google-Smtp-Source: AGHT+IHk8C8slRvX2r+TDE1a0/cgMOiAoo63CWAssdPRV7BtYjcl0HYWJl94xq9ue4dl7ngO/PItBQ==
X-Received: by 2002:a05:6a00:84c3:b0:725:d64c:f122 with SMTP id d2e1a72fcca58-7323c45aab1mr2844381b3a.2.1739433232451;
        Wed, 12 Feb 2025 23:53:52 -0800 (PST)
Received: from [172.17.0.2] ([20.171.99.215])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324257fb92sm673352b3a.75.2025.02.12.23.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 23:53:52 -0800 (PST)
Message-ID: <67ada510.050a0220.2df130.1a3c@mx.google.com>
Date: Wed, 12 Feb 2025 23:53:52 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6992117633484338308=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, tatsuya.s2862@gmail.com
Subject: RE: Bluetooth: btbcm: Fix reset errors at setup
In-Reply-To: <20250213070520.9308-4-tatsuya.s2862@gmail.com>
References: <20250213070520.9308-4-tatsuya.s2862@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6992117633484338308==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=933490

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.22 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      24.07 seconds
CheckAllWarning               PASS      26.71 seconds
CheckSparse                   PASS      30.22 seconds
BuildKernel32                 PASS      23.88 seconds
TestRunnerSetup               PASS      429.93 seconds
TestRunner_l2cap-tester       PASS      20.39 seconds
TestRunner_iso-tester         PASS      31.61 seconds
TestRunner_bnep-tester        PASS      4.79 seconds
TestRunner_mgmt-tester        PASS      118.42 seconds
TestRunner_rfcomm-tester      PASS      7.59 seconds
TestRunner_sco-tester         PASS      9.32 seconds
TestRunner_ioctl-tester       PASS      8.42 seconds
TestRunner_mesh-tester        PASS      5.92 seconds
TestRunner_smp-tester         PASS      6.97 seconds
TestRunner_userchan-tester    PASS      5.06 seconds
IncrementalBuild              PENDING   0.91 seconds

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
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6992117633484338308==--
