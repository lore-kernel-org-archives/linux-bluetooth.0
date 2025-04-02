Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B519B1DB13A
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Apr 2025 11:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743593442; cv=none; b=lxX147+ABEkSnMWSIvVwKgWZmsnxUusP34eRVVmgVAvFTZWpSsxzmJssMbe7OggWA/nCAtHaA+tsvYvSJqYNQPYISZn3hytRAlKw835ErTrh7KzmGru3ur3X++u8WYsiDOCtNqIh5OrsWVd7vTd9efoPNOSYEqwRk3Sw5v6bohM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743593442; c=relaxed/simple;
	bh=mgNtf8pFFhdGXX1EdnrUQoDXDdm/u0WbHiZdfz1NgBw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=iwpnUFC68/LbX5NofcKpg1FQFuk5OQP2BoZ/LmKf67KfIGTp93BYJK1tI3O/0X+lTabJSUCPCe4oeyza5KWVJadgPfl0Mu40iXvkYmNavYGL+Yy3JUYUkh+Ayzt222+9WJke1b+ACPnodef7lniOj+rH0+fscwcu3v5mtUKWab0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cprzQqfd; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cprzQqfd"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c081915cf3so804478485a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Apr 2025 04:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743593439; x=1744198239; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KmcrOYxp2EN6DLj8WZBH2Nt0J7PK2eMrpbeihVokRR8=;
        b=cprzQqfdJgDm8JEAOtFZ35wSeRQYHxeSAwnRL5mwJlV7o3ZaoClqXtHPNEcZSq1EjF
         l34CoGlP+cOOUCN/eY1XPCFB2ClDPARuzNVXVfFyG8po1rFtTpD28+f/YxQcZ+yjG/XQ
         +SDFMsM9x5rXj9KwhXK9yr/6k2O95L3EFzZqXiT+fbwUYntJCaSeUb6c8FYP3QAVBQLJ
         yaYmw4WWy84J7EK8xmbZy5jNU1C40TWgANYmarvav2dBUZL6zaVdAYqNGu2f1t5yg+jg
         vXBdoz8LhsNTRMrfxghdApKhDhbs1Bfq77w+jgOEnk6/0ZdistLPl3pKMA0WAL4q47mt
         IDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743593439; x=1744198239;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KmcrOYxp2EN6DLj8WZBH2Nt0J7PK2eMrpbeihVokRR8=;
        b=hhrmPvSBXYzmQhxyn8Dkd1za7SL3y2ggC5q24yQaW9Cpo86K8lYvPW/WEfQoA/9//g
         eaTs74OHeV0wMcvDZRRRBtZoeDmuJOEfK5AaL4BT6EjJV1omTihkf7LKKpTUYo7asAKf
         PG5o7ippoA19In+6i0Pd4gOjzad/RzfIsbCPIYjY72WHZL4L8hvQ5c65G5J78jyGEZpQ
         qRkkaa9pA1qF+ozyMGjRKJBzc5uNP1BsoVpZVcqxVsQv8lv1QOfvCq7MSZFpsqyaanjQ
         EnTzZyJpjg7CbzQabw68rO3wjWv9VuPGPAgAC2o29FG0z0EZKoMKM4V5pi6egK24Y/HR
         lVRA==
X-Gm-Message-State: AOJu0Yx1gJoT6/XnEnQL4rzt5HB1NsZgI6V62pTWSkkjPS/Z5XJCDfnv
	zHD9YRvqlmJnAKxGmbHtgF3AjYKiMWGKWntHfNyf+ZRRTWkjKO338rIx7A==
X-Gm-Gg: ASbGncsvvxCWKwMxRetv/5b+ZI2Ptp+y/XSMrwAWS44WqyzSHd5/qxCKyBzvdebsEJg
	jjLR4lzowemdXDNCc5TK5Wbef+1iXMKdPI9dTx6WNQilmSQDFM14VXIt1hBuTMcuVc6wWASvLks
	oLQREL3xm6/aATg+H02uH5s4TeLNlbM4BE1OJY1ddlGImRCheof5BMbbGJpSY2h/gUFYShDG98/
	iazKIj7oXF9kwttUML0ZcoouSzDLQIqvKXm2iNhhLt4bQOVoXowjJqqj5P/u/B4Mgx7KNTKfi0d
	6JOo/vInNey4I3owGMY32QwmWRtuq9apSXQmwbjPH8x9R4fPjA==
X-Google-Smtp-Source: AGHT+IFWLdYZslpH5M/cVjp8fw9bucw5BXb+1Cuh4I1qj0CIO8fAtrmrQo9+Ijv9s19MJXwOpzx5kg==
X-Received: by 2002:a05:620a:2903:b0:7c5:6a04:d0a8 with SMTP id af79cd13be357-7c6862e5bdcmr2253288785a.5.1743593439396;
        Wed, 02 Apr 2025 04:30:39 -0700 (PDT)
Received: from [172.17.0.2] ([20.246.78.17])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5f776510esm781406385a.72.2025.04.02.04.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 04:30:38 -0700 (PDT)
Message-ID: <67ed1fde.050a0220.2e9726.b254@mx.google.com>
Date: Wed, 02 Apr 2025 04:30:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4863846819594458677=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dan.carpenter@linaro.org
Subject: RE: Bluetooth: btrtl: Prevent potential NULL dereference
In-Reply-To: <0174d93d-f3a5-48ed-a755-ed7f6455c1bf@stanley.mountain>
References: <0174d93d-f3a5-48ed-a755-ed7f6455c1bf@stanley.mountain>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4863846819594458677==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=949268

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.22 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      24.66 seconds
CheckAllWarning               PASS      27.27 seconds
CheckSparse                   PASS      30.53 seconds
BuildKernel32                 PASS      24.45 seconds
TestRunnerSetup               PASS      437.44 seconds
TestRunner_l2cap-tester       PASS      21.50 seconds
TestRunner_iso-tester         PASS      32.92 seconds
TestRunner_bnep-tester        PASS      4.81 seconds
TestRunner_mgmt-tester        FAIL      119.45 seconds
TestRunner_rfcomm-tester      PASS      7.94 seconds
TestRunner_sco-tester         PASS      12.70 seconds
TestRunner_ioctl-tester       PASS      8.43 seconds
TestRunner_mesh-tester        PASS      6.15 seconds
TestRunner_smp-tester         PASS      7.26 seconds
TestRunner_userchan-tester    PASS      4.98 seconds
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
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.195 seconds
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.169 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4863846819594458677==--
