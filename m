Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E63232423
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jan 2025 04:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736915593; cv=none; b=GxxenRU/XfmDvZwsTrghYg24YQZFI/kdHBmo4J8yhI4QJFBkHYuUZ467Z6ilZHFm3AXk6ZrpLhUi/7Cpk3dp7jBQfG4HvV/P7KmTqZ93090IlPi5DSx2iTBjhmQcK7lKqRM65eiVnJ6jITxs5ZBtshxJupD4o0ELE29qDL6BZ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736915593; c=relaxed/simple;
	bh=3fDPgMhQu2lcB90Ck722s9/4XiqnatDs2lnZHRTw0yw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Du3L918cS1n3rSgynK7n7osGn7ku3HcIMSxWDIUkPHef6aXpKTLAHvJEBoJOlH+B87XNMBLqeiEtJUqZxUHrFpt/fHGI4AHrVKl07NKWyN1xCxD6Ay8gUBrxLT3J5N3txhE3Yi0bQcwAtv9B72Sk4VFGiYBjZtUOwASV5tAcq6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cq0uQgvo; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cq0uQgvo"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b6ea711805so788753985a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2025 20:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736915590; x=1737520390; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MLrkCdPkupNpBA3lUKno0xbFHfAkANtcJGenDkYCaqA=;
        b=Cq0uQgvo6sNT546PnBsH/hmzw6sSRPUKOrzeDM3K3fm7Oxk72khGJqmDHypHJrgm0f
         0UvPv1IQtNkIvlu9zfjatk31LLLgonVwVx67fbxP7d3pqo4wu+U+tOpwq8KYfmfBKwsL
         /TPhbJ9dW16ijUCnpQy7Kzt194ehO5vt5r+FMJPtu9ahVSKO54JnNYWV0XscNMa9xg5e
         dyfT9p55CZ22JV9Nble/GYFHc4w+/BcfrKsfNlrO16oByT44dzx1/GitzAtc5XCf5zso
         ijhr1OQc+wS9Gs6O7GM+HSQlZQTg+sgFqFNZ0rLSQj5ge28cROkG02lma2Gw5OIxXzMd
         igwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736915590; x=1737520390;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MLrkCdPkupNpBA3lUKno0xbFHfAkANtcJGenDkYCaqA=;
        b=PFPadUG4nV+E4q8PEUTDnS6j3xX0KPxjO12XiQN2v05c/QK+zYCzkVfGysEcNtT3dz
         qmfXV+rdj6hbLkipw6FBiAOJcGJ7Mx/b9/OmasJ3enLiTgVhe05p1kku6r0DW7fXcpsR
         kXJ/nEGhVvf5mU5NND6e3aMTz2RoshVXxq89JInqIZmbZ+6eDGjiY+TZWcOtrufDBfg2
         h7xXJ0vanesnegFb7PWfdS4ZTAOXfB47+nzJtYO1RQ9gfV+BKWTKnZZk4EnvDuHKw/1f
         QNLSrE8YyOHY9/wn2KSEcF5JCK7v/U4lqombG3viOVrH1Z5GQtiubBnl646RpRnDlKkR
         Agiw==
X-Gm-Message-State: AOJu0YwhcoICTUQP/XA/Hdf7p2KR7V67b2CUiibfACS0PSSegiybxI0Q
	qgkOVpEdUxidJknu1MfQkNmDPzwq3OoCpeIIpK35fvHvbm75FJxk4ZEGXg==
X-Gm-Gg: ASbGncvFGxSojaSMX82HbeT/0edP570TK0uQhIyAOzX31FwiZFG41cKtrzKNO739I+O
	rLgAo3g2DbXkwrRZ21vZX8rzINx08EBouWxzbHBBPfeWTq2e6smfY03agrnwVNL6sNZbzunctHk
	IW75Jelk8hz8ZYlamhyJtsN5v9h4FsgNOeimOuT+G34skqque0grHl3QcGItIw2kW9usrIWz/MR
	eYa2w8LxzvMPBh32JIjuJ8muATri5hWPzu+HigNoZ+PlRNaPl53VcueuWLs
X-Google-Smtp-Source: AGHT+IExH8S/3JReO/KyQsd9p1c9JGYvqEL/U9ZOFBomYyCtnr8i/lCkBtVCGfgWLsXvoDAM6E8drg==
X-Received: by 2002:a05:620a:6601:b0:7b6:d643:59a9 with SMTP id af79cd13be357-7bcd972718fmr3989412085a.11.1736915589941;
        Tue, 14 Jan 2025 20:33:09 -0800 (PST)
Received: from [172.17.0.2] ([20.42.14.18])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dfad9b2df9sm60292116d6.68.2025.01.14.20.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 20:33:09 -0800 (PST)
Message-ID: <67873a85.d40a0220.35ad60.6f32@mx.google.com>
Date: Tue, 14 Jan 2025 20:33:09 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8026777030025279232=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, en-wei.wu@canonical.com
Subject: RE: Bluetooth: btusb: Add new VID/PID 0489/e14e for MT7925
In-Reply-To: <20250115035014.208090-1-en-wei.wu@canonical.com>
References: <20250115035014.208090-1-en-wei.wu@canonical.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8026777030025279232==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=925530

---Test result---

Test Summary:
CheckPatch                    PENDING   0.21 seconds
GitLint                       PENDING   0.17 seconds
SubjectPrefix                 PASS      0.23 seconds
BuildKernel                   PASS      23.91 seconds
CheckAllWarning               PASS      26.77 seconds
CheckSparse                   PASS      30.10 seconds
BuildKernel32                 PASS      23.81 seconds
TestRunnerSetup               PASS      422.11 seconds
TestRunner_l2cap-tester       PASS      20.74 seconds
TestRunner_iso-tester         PASS      32.07 seconds
TestRunner_bnep-tester        PASS      4.88 seconds
TestRunner_mgmt-tester        FAIL      124.12 seconds
TestRunner_rfcomm-tester      PASS      7.65 seconds
TestRunner_sco-tester         PASS      9.44 seconds
TestRunner_ioctl-tester       PASS      8.21 seconds
TestRunner_mesh-tester        PASS      6.07 seconds
TestRunner_smp-tester         PASS      7.10 seconds
TestRunner_userchan-tester    PASS      6.09 seconds
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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.154 seconds
LL Privacy - Start Discovery 1 (Disable RL)          Failed       0.173 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8026777030025279232==--
