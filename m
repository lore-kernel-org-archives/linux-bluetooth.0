Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92408EEA8
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 15:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752075405; cv=none; b=hz15yRDPiwcA5N/7SsFth4bNMaiyPxPAzeMcImdgyHIVscRQm1QsfIXsfMINA2GN1MQ90zE4Osfz53bIrRpjoqcLdEJFXGPM9RzMUdNQGWhqYVyLCChGMbfLcHfUrtFKwplAyiyXZ3EwmPqBqCTJAxQApldvQ4ESMnxj0Myc3ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752075405; c=relaxed/simple;
	bh=DW8whahCd0Jza1lAnGUGVWpP8l+LUvl9nttHtIf7+RY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dxThdmCirQMA74W6uMQ2KAl+0vnmJFcOH7qjlRV2B8Bg/cI4eyCmwDuuGViqPf1eUBNqkLz9SHA9L5UzkLNHffmZAvncTqvaKwIYDnMVQFNB6nh+3rxdzCzRxmmiCiCBXVxu3kIfyuZM3/C9o+ZFBZ75PIfXmtVMdtM0EbB0FtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRtyZZY4; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRtyZZY4"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-235e1d710d8so710515ad.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Jul 2025 08:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752075401; x=1752680201; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GTTICwK49aq5469s3ysNRgl9Z9MZabOZtnVrIwXDfk0=;
        b=XRtyZZY4qfR/bCkzqlWgqkCKQ1SoOQzfqDZzoVy7Giwcj+E9Bn4KQahsAvJyTC6099
         q1UAC9p0FW/lrdlZxbjfS31amZRwYKyM7dSpxzeyL/0eq6l+C+Hd5pL+qqXTpwZNoUTa
         jN7+jg0SL/kiWf4TezDatYF/kLwQsQLrOvss/yYgZpbZ3y2N/rAKF+h+ihk4pCMZAdyL
         LdB6NrGVIwXrvGRsRBbRQaeGudOg7ThLKANn98gjO++P6lmYUzcSbt7fdjAJI3fkgmhH
         EpROdQNEHJ8/d71wGlCYxwvjn4mZ8X1vGAXYdAxa2CvIzjWgCpP/05OgsHCI8qcrCBhp
         mOIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752075401; x=1752680201;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GTTICwK49aq5469s3ysNRgl9Z9MZabOZtnVrIwXDfk0=;
        b=FnemqHSppO9gf7VBeDOpMMDwAT3nSUJahIDO7bGBrb7iu7xa6dO/6y2JZg9tl1jILm
         FGPZVfmtmV7UM4kvS52JmPOSOG6SJFkkWZjpnXoNWy391gj4xNcR/s6HqflRCboSSh6X
         N4WEvzvGdsoOyaepSPB+KfN2pPLi121189qJB0vkvOAfM7X0L3t+s5+Te8GAumrCHCcS
         5vtA9H1JStpE5GKDJtVxjjFw+UCMWlzITffXfj0qAKTa+9mpaw4d7dSXT/IhEXD1gg/v
         mgOVaVupJGrXlBzM61j1gmEPtpQj2hG6Y4BMfUKS2kf3XZsXDgrA3+Q26PY4vV9K+9Bm
         xBnw==
X-Gm-Message-State: AOJu0YwdZVmMt0ZCj95vPngrvDiOlCoPaN/VAkCcIX2cW6G40GJHOstn
	VNHyVLVYIWXAlEZPNhqtm35F3lbHki67gVhf3GN+myrbuNzPNof2Srqp05F9dw==
X-Gm-Gg: ASbGncuD4qjPecvi/trw1VuqgRslU71BS73P05YgwpmwM063zKBYqg0vFQBpbYz91p+
	6Cz1LI6t3x67xlhAPnBXsGm2OWMZFv0saq3NZngVQSWQoUqPG5eOgHAa+oIDz1HYObfaXuG/8uW
	Y+rHe0F0mme4XOQgfMJ9OwYOXb4qTSo6n0PKtVRCBqRTxP1axoOUD/uHX34hqx6vOJ1BRl8OPeC
	1QxjZjqmtPoR5k/kutl5xhyOAQZ8xzXmZzXE4Ji1iD/2yWqaNg9JGNUSTEFsLf7px3x+QXOykC0
	319AAmV3IRcrL4NSsMK2iZclxrYP6n+nXxpkTFAilYvHhF58Guhs+Mk0Ril8+Y0D1IBJ
X-Google-Smtp-Source: AGHT+IH8IGUU1/biRqEWnN9QdOlPJB4zli2oc5mJ7HCdUT6Glm790v/4fle5J8ixai5xzwozyu9cnA==
X-Received: by 2002:a17:903:15c7:b0:235:88b:2d06 with SMTP id d9443c01a7336-23ddb199185mr51993385ad.6.1752075401454;
        Wed, 09 Jul 2025 08:36:41 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.131.156])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8455cf60sm138307475ad.98.2025.07.09.08.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 08:36:41 -0700 (PDT)
Message-ID: <686e8c89.170a0220.f8121.2fcc@mx.google.com>
Date: Wed, 09 Jul 2025 08:36:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8777595707505058505=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, brgl@bgdev.pl
Subject: RE: [v2] MAINTAINERS: add a sub-entry for the Qualcomm bluetooth driver
In-Reply-To: <20250709144728.43313-1-brgl@bgdev.pl>
References: <20250709144728.43313-1-brgl@bgdev.pl>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8777595707505058505==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=980569

---Test result---

Test Summary:
CheckPatch                    PENDING   0.45 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 FAIL      0.36 seconds
BuildKernel                   PASS      24.12 seconds
CheckAllWarning               PASS      26.59 seconds
CheckSparse                   PASS      30.12 seconds
BuildKernel32                 PASS      24.21 seconds
TestRunnerSetup               PASS      467.11 seconds
TestRunner_l2cap-tester       PASS      24.96 seconds
TestRunner_iso-tester         PASS      35.73 seconds
TestRunner_bnep-tester        PASS      5.90 seconds
TestRunner_mgmt-tester        FAIL      132.80 seconds
TestRunner_rfcomm-tester      PASS      9.21 seconds
TestRunner_sco-tester         PASS      14.59 seconds
TestRunner_ioctl-tester       PASS      9.93 seconds
TestRunner_mesh-tester        FAIL      11.45 seconds
TestRunner_smp-tester         PASS      8.44 seconds
TestRunner_userchan-tester    PASS      6.11 seconds
IncrementalBuild              PENDING   0.86 seconds

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
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.184 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.103 seconds
Mesh - Send cancel - 2                               Timed out    1.992 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8777595707505058505==--
