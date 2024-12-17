Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075B11F63E1
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Dec 2024 15:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734447635; cv=none; b=BAF51G1jYsa95sk8W1/w6Y162wF8T5oId5RqGk8wuQ5eZfb1MmEhOZWJzg0qJC9ywf730SQwv2I3svE46np8HefHevSRQN94yUORwPkNrYT8U46mk2EFP92AMA6WT9ar7ZroFqhLq1UwNKK0nfaDPOH0ZwOfMbOrxBQMOvHQFrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734447635; c=relaxed/simple;
	bh=fLSmr7hFsmK3qh5uxcPW5ZYn+ShuIR0qG3WeAkQf3j0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NAA+4lNI1RO71dG60tx//utae32jg7J1curtrOw05gsZ0Sbk2QuppVZNjxNdTKlvBwOoA7xeDgWipfmswV1kBFckNzG9PoX0PvXrfz4RhdXZF0CJon9CBLrGu/qusfkbgu06hLMx20L29tiWpVOgedpWutzZTNnIcGe+qh8N30Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+EQIp41; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+EQIp41"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b6f7d7e128so458021585a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Dec 2024 07:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734447631; x=1735052431; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ysP21FMmfaAOSAIY6FM2PLSCjYvMVjEqwXomWPa2lMU=;
        b=f+EQIp41JDQqC/dzmj9odDyna5DRPi07aWBfBa0gez2wAxurluPs1Thdmc+cY/r65I
         b6iW0qPchApfU5UzGFlcc6HPn1K0giXHBiTGTzjC0u413HD+7NmcJU/pHCmkYUIj3jEW
         wSjAPxRfV5JlkMkhJKNna03453uJHl0zH5jR8wndBYIT10t/0rgGhQ9bEq5dFGHUL5xo
         p6XREFn37OB3cQVV9p0DjxEuKF0NNxyDISCxKe247UnIfXAmS5nNqipEHsIvkSOUXV+M
         f6oj3EidHst/mt2tVH5OSqrkdhNbw3HfSmmWiusXT4OmDSsyezeeCsXs5UYeJKNDxRYj
         Eu0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734447631; x=1735052431;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ysP21FMmfaAOSAIY6FM2PLSCjYvMVjEqwXomWPa2lMU=;
        b=kecmyRSQB2kQvOkCcd92Kkf/lQav1sH1O3vO/PiBSIN7Hz16NJpemKk2cmTB1PVtHV
         GgmSqnYLpQF2voWufCqFAzJDZ+MK5xgtjfUthaV+VKJY5qoauG+OxOqfNq1Mdetyixvs
         UqoCW0285OCqNzGU/RseAVX4XYNf1jDjOeECPbG530CUQdioGKCe/bDTwPvbRoOHDaqw
         209ucQ4ko9fhF3xEwZ3jf2dXBrCATlwYPEyuAX/B+GDWrA5FNL2WqDvuDfmmNJI64ghl
         M4XP+B3My8SyTHi6WcK9dmC3j8DJjBxrmxU33QX8upG+hFJJFxPfPs7rbR9Ky7NmjWS0
         F/zw==
X-Gm-Message-State: AOJu0YxfBDAx70od0pZ1oBXH+8xG6u8RL8arcTK8OeVdZmlPjdT4kgpA
	3x2ypzvCXgu3nTQV4YGshnT+ebrXJWw0WInQ64fDLIzFYvo8f7/3LHiArA==
X-Gm-Gg: ASbGncsgVXMV5BFRpypvV7AIwaSRq+OInvfjseZz6xS3j2+uDrI+o9S9rmJf4BB0kP9
	gMBla4b7YN974cTpnhH+q/fDrDbSr+39ViIaaUOmcFfkNP4ovbo0vt7ealTkamswQiIn5CbEnOJ
	ofPTEgBH1iGpqb/I4VnH7YGBrmRvmW5SGpBBQ/2wZb6MT2n4YUwXzKmrh92sBZBhaEs+DkUJKt3
	DQx0DCqDZH9KXTpWdQ8VDH4n2MiP8yJfUx+sTMyQZ+pSo3gjvycdVGwshRbHg==
X-Google-Smtp-Source: AGHT+IH537TjKdC2zEEzNgB/ggrtn0mTxJD0sHtBn3DuN/t4OcuFgY63riLzCfbt6hk5hhvie3hmgQ==
X-Received: by 2002:a05:620a:2a16:b0:7b6:d312:c5c6 with SMTP id af79cd13be357-7b8595c4c4emr504821285a.9.1734447630367;
        Tue, 17 Dec 2024 07:00:30 -0800 (PST)
Received: from [172.17.0.2] ([20.75.95.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b7047d1723sm325729185a.32.2024.12.17.07.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 07:00:29 -0800 (PST)
Message-ID: <6761920d.e90a0220.8c3a5.bb37@mx.google.com>
Date: Tue, 17 Dec 2024 07:00:29 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1217071593945568729=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_chejiang@quicinc.com
Subject: RE: Expand firmware-name property to load specific
In-Reply-To: <20241217142454.614551-2-quic_chejiang@quicinc.com>
References: <20241217142454.614551-2-quic_chejiang@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1217071593945568729==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=918708

---Test result---

Test Summary:
CheckPatch                    PENDING   0.24 seconds
GitLint                       PENDING   0.24 seconds
SubjectPrefix                 FAIL      0.60 seconds
BuildKernel                   PASS      24.81 seconds
CheckAllWarning               PASS      27.29 seconds
CheckSparse                   PASS      30.85 seconds
BuildKernel32                 PASS      24.89 seconds
TestRunnerSetup               PASS      435.80 seconds
TestRunner_l2cap-tester       PASS      20.49 seconds
TestRunner_iso-tester         PASS      32.72 seconds
TestRunner_bnep-tester        PASS      7.83 seconds
TestRunner_mgmt-tester        FAIL      119.87 seconds
TestRunner_rfcomm-tester      PASS      7.65 seconds
TestRunner_sco-tester         PASS      9.40 seconds
TestRunner_ioctl-tester       PASS      8.19 seconds
TestRunner_mesh-tester        FAIL      6.81 seconds
TestRunner_smp-tester         PASS      7.05 seconds
TestRunner_userchan-tester    PASS      5.03 seconds
IncrementalBuild              PENDING   0.57 seconds

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
LL Privacy - Add Device 3 (AL is full)               Failed       0.185 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.143 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 2                               Failed       0.110 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1217071593945568729==--
