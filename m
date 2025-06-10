Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F4C2BDC2E
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 14:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749564623; cv=none; b=NL9qIDa5sX2ZNK/FKjVBuZ7lpsbhTSqMYMIQ8UWtU41qFK+hoQ1XsBaCtkM+DP8ZV4zvVxoAc8V5/+1cKBEGB34FcK9ydoyUzN0mFQ5v/hcS/wvy3joS1+1NNdKAjtTjh4SgYDQSiFuiIpslwjajThP8lY5GaugKbtssWe9ofEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749564623; c=relaxed/simple;
	bh=8kUJRkXBtzPA1v9Q9BYy52SQuzBKf0MWopdethVzt8o=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CE3WTGyUfRfJQHuw7iRBCIS5jjXtDiLrQPdeyewSdQ6YZ1OJuG3RFZLDCpLbAhl6gVdoqnTOn/dOguV0qFdWGlbtiiJy8Aq9KrD8OiyZymAv5eU4Y0gxzsVRqlnLWvR7RlyckF7oZiEtgXml2SMzhn/mWdKWQLYUrDyvZoXguXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XkQbgZ24; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkQbgZ24"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4a4323fe8caso38574011cf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 07:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749564620; x=1750169420; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=M0EWUohAvq1jaJKNAkBEKw0ltDmkR5VDL5nxwikqLAU=;
        b=XkQbgZ24OgKe40OEHhTUjXGCD6k7/rYzFfTNU1V8aiL1KQBizsgoDfFisRxqtPJw9N
         cVZD9IXC+TqRYxMe8h/CWbpH84nFQO902jxOKlN66XELSrGTXUkHGErxxg/YVwj8EUEy
         KaqotLlps6lPejC4w9OrGOCtp+68nNR+Jngb0L9s1fV2/bJP2BDIddRmWLK43dCxcgNV
         I3i0tef+U59d8i0pHqU4J1aFMO0rTr54MYT4XkPG+zEQ7KGVlnIIHKbSjHQJTWemRh/S
         w3f1LYKhyBsGYnKFi9Rhvxhj+old/VuZiodBmfxsKKVQfSYiTLnAjT2cvCwIqyzZ5FTk
         DoKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749564620; x=1750169420;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M0EWUohAvq1jaJKNAkBEKw0ltDmkR5VDL5nxwikqLAU=;
        b=QnINyjDyV/S+rRWQYAKmlRTXsxiUl5xhJ8/96KtoImg9Me/PzC43rDVV4/IpnZyZaV
         FPeKZGxmL4OsOObjral5ai0cRr3UbBzl/CXof11yACi760T8em+8QcB5lsfJ6/pbzkeV
         LzAJlHcETcXyOb/g0TjLTvS1c7q6LM5tGMWkiEfxLV7Iw4c73lYvUaFBZPH6TFWGJEq9
         6H5iQlewk2b4RYNeKskTSEVlsVfCYS4Q2b8FeoZdGXZdOpCg3W+MhGRqE8MYgzuJmnx7
         9jNf84hCRnDEia3HdHWlB+Uyr+sYgSyq5eR0ZBHVe+8yjDJBbCBmJvICqXBcTJYziKR0
         y/qA==
X-Gm-Message-State: AOJu0Yzd3EhmpJ7jhHNWY3ynntM0B85RJb7keWCVCjfufoAFQ1ngqWCs
	zscSHmWfsgjVVrAMUA8JTMeJAz094jVutcLQfs+2Gm3QdqWUrp6d2p2lqtRYGA==
X-Gm-Gg: ASbGncsleS3hFk0mN435uJ+nLaX/sXpQU/VodoXwyOgBNmGTtFIMBrMIUWnOiLN/5O0
	1yegGFWkZ2uNbCOxtbJdvDL6Skm6xTxHkO3qmeNr2XcQWMOoJZr1Y2CjIFFFUf7Mw4nzOXKQHRz
	KxpidYaYjlkqbsCEPvnOUxsbnkO+b/AKCo2UEZWQQkftYuQ9yK0ocJIkSbTwmqU/HJlhEoyCo7s
	rCHgXXqob7IJr4QBh/8Mn2rJJVIKQKnkU/jYB51sHVCYg/uQ3/ywLJvbRV8KkpqnhPJprQvF6de
	ycIyTVcT3oYcCPUZ9Wd+GvILdcTCC4ilyooQeAa1m6H+b4ICXb9ShCM7zEvH2kPCgT/f
X-Google-Smtp-Source: AGHT+IGnDNIFXxQhIwzefE4Haw0N44ac/tAnlpvaLkVbGTW0UZvRF4udIMi20HMq7GB7vR4ZgQDeSA==
X-Received: by 2002:a05:622a:4a0c:b0:4a4:3846:6eb4 with SMTP id d75a77b69052e-4a5b9d925c2mr316307011cf.35.1749564619897;
        Tue, 10 Jun 2025 07:10:19 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.192.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a619865918sm71676901cf.59.2025.06.10.07.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 07:10:19 -0700 (PDT)
Message-ID: <68483ccb.050a0220.2d7259.e15e@mx.google.com>
Date: Tue, 10 Jun 2025 07:10:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5896017919547559044=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v3,1/2] Bluetooth: btintel_pcie: Fix potential race condition in firmware download
In-Reply-To: <20250610140038.696091-1-kiran.k@intel.com>
References: <20250610140038.696091-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5896017919547559044==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=970379

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.24 seconds
SubjectPrefix                 PASS      0.20 seconds
BuildKernel                   PASS      24.97 seconds
CheckAllWarning               PASS      27.17 seconds
CheckSparse                   PASS      30.71 seconds
BuildKernel32                 PASS      24.63 seconds
TestRunnerSetup               PASS      466.61 seconds
TestRunner_l2cap-tester       PASS      25.77 seconds
TestRunner_iso-tester         PASS      38.91 seconds
TestRunner_bnep-tester        PASS      5.96 seconds
TestRunner_mgmt-tester        FAIL      137.16 seconds
TestRunner_rfcomm-tester      PASS      9.41 seconds
TestRunner_sco-tester         PASS      14.87 seconds
TestRunner_ioctl-tester       PASS      10.02 seconds
TestRunner_mesh-tester        PASS      7.38 seconds
TestRunner_smp-tester         PASS      8.62 seconds
TestRunner_userchan-tester    PASS      6.19 seconds
IncrementalBuild              PENDING   0.98 seconds

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
LL Privacy - Set Flags 4 (RL is full)                Failed       0.302 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5896017919547559044==--
