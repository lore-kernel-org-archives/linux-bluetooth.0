Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C604C8E
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 14:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745244128; cv=none; b=DenuoaGdeVO0o4yrfBq+P4IUvyIvcCAIDSNgD5yGCEnGyh0DBJwyxQlVLQjaWpbm/3VauH4WIVYiZHMHEdSNb6hCvFvCJUtNyx6gU5izY5J94YmmbTj2BH9s1sK2avpjS34K0/qaRmc1uS7kDQYD2fA2NqQJ/Xaxpkjl9POVq2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745244128; c=relaxed/simple;
	bh=sEJN+UHpp2WL4IAwAWTC1Zmm+0gmN2IW98OoWWDRTCs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mbieb96+n38L0SoS29j6ej/5CqPAgATWNb2IUC4bgpcnXQ8I+1ukPw928jJfQAg1Zrh10GAfkbf1qaExcrgVAsa1dQ3RB8d7aYDbgSmyrmPqI1ifMkje05YcjSBOxuNLcLOCVLgevCBmfAzIUUrKKYXIP/Xrc7Cfiu/nI8imXNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hb6rcZZ9; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hb6rcZZ9"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2279915e06eso41320805ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 07:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745244124; x=1745848924; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=flz4GPUNP9Ijo2hySZU/0QcVsAejDqM3MT87E37xAik=;
        b=Hb6rcZZ9uwq7IymirpRl1qnu3S/K6ZnBmF7Cm7C+otxurWci67NLFgSw7Efkt59+kx
         Hntb0NhKo6CEuhbxEoVQW8ezK7Nijv/ofGkalznJX1z28Pc5MepWwh66uGkfxwvaXeMI
         y7YigL3awyMMJoVgSiVHrqo3xgsqkPc235nfsZB+ce9J3ZD47CSBpKPrVzk7TfIc7BJ3
         vl1yt5ytacyvpVD3Ed1ORpkmZqlXUGCqf9HRg1wCdC91RfjMt9rTG3E0JgL1X4SjCM4h
         E1+vELQjyghyNtQjtg6b9GIvEW97QrO3+Jibqx9RdEoiBcFqUCZ34JlwaiZzWnpewwJS
         EvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745244124; x=1745848924;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=flz4GPUNP9Ijo2hySZU/0QcVsAejDqM3MT87E37xAik=;
        b=XYELAcNZQvgL2mFtq58yvp7pYiPGNabjS1LX7HFMSIIL+HPnLyv6sONcT5/bhFRWMK
         wg/HHtpt1w7pjarm1otZLhBE99kTB1xtkc4yExwBt4Z+tEnK3ePfPsEeYaEXSy/0sb0Q
         3pMv6KIVTOGVDgU7ID1gVw+hoUbGdkxdgxwwWdlIF9ePdRMtXzH5F/N5gzTioPHhjb5K
         KwK64S8HLCoSYhqO6Sk/WwLfmyERQGpqG9ZnvsFO7jBVFbGpjqNOqvECsG3Ior5yH3/s
         cOzJeHKr8eVM6oEtC31cUM3n+Kv6MSyEcfWQ5eiKxVr5Ai1e8InvIaewHWAx/MC2DL4N
         k20Q==
X-Gm-Message-State: AOJu0YzbVqpoEWp8j2cEtEQdYvZ2zHYaYVOMiNRBeQzfjC52hgDTK+pX
	A3eFMrK5ht8O2ZjebaB53aFpIL/R0zurnL5TJD2KouuGhlLBNHCLQ4/ljw==
X-Gm-Gg: ASbGncuwjzVKOo7WPbgOZPP508ggkUrZai+CazH+rknI+1TtXwYQfvxxscFlFsiDZOx
	9YVeiInwJAkob6KOpoDMfsoAuDZdlK2rIh8Ei0KObiZ9p4EiKlogr1MjQdN2/Ypz0vxqdgsYSU2
	HP27uw9ibLBaIEDzwfjLZgbcPRypcFUVhhcdYyBMkpKPsBfXMkajTjBmbQ+SdD3KlXJayst8nNk
	lEZunMIHlA/t8gbI+ZMS9mSvcR+FZs6XfEQ3Hb0XaT8TF0eBgvIBQxrlPtxeDiSZFt0jtfTO3uq
	nJP1b8fqupipecwPa8bGIaIV3cdlQE4oBeaedPZSSschQ+k=
X-Google-Smtp-Source: AGHT+IEiBXOpuf3ADf4fN6D2ethyq/UoQyo4c/w9lThMmvw3OGLSzC1s9foPL0GSuN2gkZxzI6QQSg==
X-Received: by 2002:a17:902:f60a:b0:223:60ce:2451 with SMTP id d9443c01a7336-22c5359c344mr167860355ad.15.1745244124160;
        Mon, 21 Apr 2025 07:02:04 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.33.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf8e1556sm6575231b3a.42.2025.04.21.07.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 07:02:03 -0700 (PDT)
Message-ID: <68064fdb.a70a0220.2dbeae.80f3@mx.google.com>
Date: Mon, 21 Apr 2025 07:02:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6937256969366836373=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: btintel_pcie: Dump debug registers on error
In-Reply-To: <20250421092744.219097-1-kiran.k@intel.com>
References: <20250421092744.219097-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6937256969366836373==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=955283

---Test result---

Test Summary:
CheckPatch                    PENDING   0.41 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 PASS      0.30 seconds
BuildKernel                   PASS      24.75 seconds
CheckAllWarning               PASS      27.09 seconds
CheckSparse                   PASS      30.88 seconds
BuildKernel32                 PASS      24.56 seconds
TestRunnerSetup               PASS      466.92 seconds
TestRunner_l2cap-tester       PASS      22.01 seconds
TestRunner_iso-tester         PASS      33.67 seconds
TestRunner_bnep-tester        PASS      4.83 seconds
TestRunner_mgmt-tester        PASS      120.08 seconds
TestRunner_rfcomm-tester      PASS      8.02 seconds
TestRunner_sco-tester         PASS      12.67 seconds
TestRunner_ioctl-tester       PASS      8.51 seconds
TestRunner_mesh-tester        PASS      6.22 seconds
TestRunner_smp-tester         PASS      7.47 seconds
TestRunner_userchan-tester    PASS      5.08 seconds
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
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6937256969366836373==--
