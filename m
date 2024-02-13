Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472F12919
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 16:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842160; cv=none; b=gb0wddfU2eqKIdUxnhPyJ3W+3rsih31VJGMgtCJa3aDi+1+H8I7nkApkAreY23Gs3evv3A3wPyh3Ha1/y6ENg7K1TPudQD603S44RfhwuiDwCXSN2e2KITtT21JUAO0poi0cCwzbNajOqJ7O10pUGvNvEETmLekvHIs/R9UwHtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842160; c=relaxed/simple;
	bh=Ik27gaX7hpcrgSSOKJCqeAo+bUo+Hb0Xy6Gnu+Y25iI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=eqp1ZoAZJZb6G8Ulz9S2BaNaHMZ7R6XaDCBoTpMfodAbSQJK74vZc1/qPZlxQsC6Lrn0rOUJObxj8MrC4EITkn2a6qZv9BMXT3v1g1wc/SWRUpsrrShyWetGlG8azJRxw9vaNbYFkjezmfIbat7bK+ZZ4qMukwqSHT3FE4Gidyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4LmUVEC; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4LmUVEC"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7810827e54eso280954785a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 08:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707842158; x=1708446958; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8WBGgFx9oW2+hkYq5JTmIAoT04LRGh8ZP8IZXmHYL1Y=;
        b=j4LmUVECuxOiOvzx8P+BnWlSzELqccisTz5y3p0Hysyq6X+6b5VhQvdw28tqS8YuLv
         Kdd2QWCROh3F8F+BY2u8G+tIoFSB0wtwzgpRhuZc/kh0/139A2eGJQdoGrwKY0Dgh4O9
         VW6FPmRht5tjDqTfWcIxiJwbqeExXs2jw/+JmZMtAAlQcB+2VpuH+/BnXunrx9HXpAty
         SbpKgVj6fRHig1raJ1JnNPVZ28efvFcJG2BNcEuumal/Jf8RRz2K3Tgg3O46xSIBjW+U
         ZAQwotXLt4ZTer/Bit/uhU6cGBUPcdhzyb2QQv+bfOihNF9UdX2tBmxseTdJuYXk0CBP
         mTGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707842158; x=1708446958;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8WBGgFx9oW2+hkYq5JTmIAoT04LRGh8ZP8IZXmHYL1Y=;
        b=Gyv5ZRBa/CqllT5xZF6oimW8pyyGr9wwHJ4QHRHSzTPhK0kd6rCiWFzL22elQZXDO3
         K38dH/R/e4BCtn4xXvavGR4l6CaOJw1whlfrBQlspXf4V0uwXEdL/NOG3kiehBmqX3eb
         HhCfppzuSFvjC4946kHhdOIPYrKFaYAnXJMeg+s9ChFRrjOr5wOjA3pY3FyIcmbQAie9
         G8LH3TPX6WUsRAmxjfREMZWKEPMaCpQAtd0r9Q9tpvW+Iz67pF94H8gVEF18fTkIwYqB
         4vbuxiRqYfJOePFhT4KxRFGPbz+vvl5BuUe7HADBWv0LlIoK2d2+CZl8H6RILstysiGv
         TXng==
X-Gm-Message-State: AOJu0YxyZInuFBmCC4c30aW133olEoAzOVDtyJG97f2KvSRIzaCBmEOT
	k6fS+xZN4FSOflnnU+e+dULFczyk5i0TWSjfGioz4XVDEZhaVI/ZK8e5emyx
X-Google-Smtp-Source: AGHT+IFpRwyMp0YLv/Od5JdVEGo2aNqyxo8anjaH/rqvQXBhJvWDp6mzCb/3VEiCbVEZHa6/EQIhbA==
X-Received: by 2002:a05:6214:2aa2:b0:68d:1859:b1c7 with SMTP id js2-20020a0562142aa200b0068d1859b1c7mr4961238qvb.3.1707842157976;
        Tue, 13 Feb 2024 08:35:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUOsO7+bml3UzXNbCfB7kh+FgzSG2ep9aAnoCs2ZslOPtP5DOyiyKDaOWfQA7O5kCHjrpN/pSyqv4BIVRCdPjNwew==
Received: from [172.17.0.2] ([172.183.131.98])
        by smtp.gmail.com with ESMTPSA id pj10-20020a0562144b0a00b0068ef930fbffsm214281qvb.140.2024.02.13.08.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 08:35:57 -0800 (PST)
Message-ID: <65cb9a6d.050a0220.a6838.29b1@mx.google.com>
Date: Tue, 13 Feb 2024 08:35:57 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2490982571844891292=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: btintel: Print Firmware Sequencer information
In-Reply-To: <20240213160152.2836131-1-kiran.k@intel.com>
References: <20240213160152.2836131-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2490982571844891292==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=825702

---Test result---

Test Summary:
CheckPatch                    PASS      0.67 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      27.91 seconds
CheckAllWarning               PASS      30.37 seconds
CheckSparse                   PASS      35.88 seconds
CheckSmatch                   PASS      98.23 seconds
BuildKernel32                 PASS      26.85 seconds
TestRunnerSetup               PASS      497.72 seconds
TestRunner_l2cap-tester       FAIL      12.19 seconds
TestRunner_iso-tester         PASS      28.46 seconds
TestRunner_bnep-tester        PASS      4.84 seconds
TestRunner_mgmt-tester        FAIL      171.45 seconds
TestRunner_rfcomm-tester      PASS      7.39 seconds
TestRunner_sco-tester         PASS      14.97 seconds
TestRunner_ioctl-tester       PASS      7.80 seconds
TestRunner_mesh-tester        PASS      5.92 seconds
TestRunner_smp-tester         PASS      6.84 seconds
TestRunner_userchan-tester    PASS      4.96 seconds
IncrementalBuild              PASS      25.81 seconds

Details
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 486 (98.8%), Failed: 5, Not Run: 1

Failed Test Cases
LL Privacy - Add Device 4 (2 Devices to AL)          Failed       0.115 seconds
LL Privacy - Add Device 5 (2 Devices to RL)          Failed       0.119 seconds
LL Privacy - Add Device 6 (RL is full)               Failed       0.144 seconds
LL Privacy - Remove Device 2 (Remove from RL)        Timed out    2.510 seconds
LL Privacy - Remove Device 4 (Disable Adv)           Timed out    1.843 seconds


---
Regards,
Linux Bluetooth


--===============2490982571844891292==--
