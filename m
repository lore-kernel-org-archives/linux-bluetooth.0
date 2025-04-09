Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6681E266EF5
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Apr 2025 14:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209289; cv=none; b=WU/OZQICf2kWORCsyZ1GXyfAz9c4z4H/wmxaJpeBGMcL2K64Kh3ELmMcBmMb9JVkmlJmU5640RMQS6f68fWB0tND3R7CToPOwoCsunebACRaxj2sCbzUDvv48ws/iIm2sFXooVgnPEhqQSoVcFWI49ON2yVSUoPqCCnoM9F/MsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209289; c=relaxed/simple;
	bh=ZlAvXAFffpFVy7YgH/IMxMQHQdSecsZ6L3o2Ygq6TYk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=R+T8QKlB+xmQYQg55VJhCkTDqquVGJZxWA3JabHBvuxyNiYS6XQdAc+hwtKBHV2G/AfwM/E+XxmPuKRE0bKQOzwXqOleVvO12timg1UWOPL0hq/ZDTr0XBJz6889xkmxZw6fXI1k4TQ7h8Wu1HL/HwQydhtNnVWJD7QNAuNALwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2osJJur; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2osJJur"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c5675dec99so726462485a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Apr 2025 07:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744209286; x=1744814086; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YC2A7g5EwxyVo2IbmQOQFFUBV1Ig19tV3i+rwwb4UIk=;
        b=G2osJJurLPol0SCCuF9sgnLCMznCr8+h20VsPAG1njCm82Hn3GYxhHiV/H9Zciofpe
         5tj/z+GGSjdJwBckXxphf8uyAdXYdhncIT7t+pFQmIBXwO7sRJRHwabjUkdcj9DgLSND
         AWp77sAOQBRFeYD8fozOtHARxQOVa/nWWDE54uF/fZds9taNlvUA/FJ+QOuNDhyQ2B48
         aP0FiiJ6VeEqtLWzm7IDn6RWRBDc9VidcVhwin4ajv6mw7QD9Imjl+rOsHHS+TlDgCV3
         hZKrO48Sk1r1U5rIOayx/yOkmnKRJNgu0eX8VnonNURCKyxtxsDJwTVhkvYIt9cTla47
         6eBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744209286; x=1744814086;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YC2A7g5EwxyVo2IbmQOQFFUBV1Ig19tV3i+rwwb4UIk=;
        b=Hrj3Z3IRZ/WEeZtcGhoouXjndEgzJB8dqdaq+KgzwLkNPJ/RoJunOgPJJBzee856pk
         LH8nVi3YEVOtowOWX0s0IX6pC8RULIfJgwWmKrNL25fTlfIn1ZYy+oar66yclJPd/g/+
         f18rhUhzZtAYHTnsZus/UA5gdCue/CtHNWr61amZs9Zt7Ufdc0MsL0KutLzwGwmkw6KU
         mVFdc051a2iyWVqU5NOoUivdPPW6f3wrCGNaNT4hrOst8HKsREsL4Gf5uPv7ON0gbH3U
         tuqNaJZnSUqtc1mb86wB8FJT8wZLe7ft2TKV3R7n63Ohyirfqnb/LBkbm9V8fuAVT8qI
         aKdA==
X-Gm-Message-State: AOJu0YzIat83XvpBjLoMe8pjuViTwY+0bzd/m3ijEnV71R53sajqqYhi
	7h9JsIKx7hk+JGnPKZIICiuygt1Qg7oAoQsBkSynCZmh/0FSe7646NUCoQ==
X-Gm-Gg: ASbGnctSSVo62KkH0Ud6aGjUtHtUEWVzicsmeV4DPXhOIKeiyrb3ip+vx+aFkaBduMC
	S//W/1LFTvUEJQdxZeHwsK53uuYCnb0rMDFvnGvi85AO0+t3Ko+aYgLKywKK9kJCAGfQ3DpczSa
	y1vqGvzk8fyMZOMxU/E2joXofNAbxiKAiNHjhEOVgmmtsUn91VKDJfnY5aVJvLrXy6tRViQhSEq
	/4NNX19mDfHeAI421COXSF5VX/GeEf3E6en3E0QlF/iLPAgScxQ38TMfS+IOuOEoks7yqJB8R9Q
	1duLm9pLWjSkHDs83FjY4DbeSZ8HIIeneD3t5fhJ277bn2w=
X-Google-Smtp-Source: AGHT+IEU+mXFzZCZS278TEbjNlSw7Hm7uepqt6orj8BYaw0c5zxBvmQ6bQuYe3OufBxalzd/tKPfKw==
X-Received: by 2002:a05:620a:404d:b0:7c5:5394:7e9c with SMTP id af79cd13be357-7c79cbe6c83mr445512385a.32.1744209285932;
        Wed, 09 Apr 2025 07:34:45 -0700 (PDT)
Received: from [172.17.0.2] ([48.217.44.212])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a11ca09bsm79647185a.70.2025.04.09.07.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 07:34:45 -0700 (PDT)
Message-ID: <67f68585.050a0220.139665.295b@mx.google.com>
Date: Wed, 09 Apr 2025 07:34:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8833523636843767323=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: hci_sync: Fix not clearing cmd_sync_work_list on power off
In-Reply-To: <20250409135402.212535-1-luiz.dentz@gmail.com>
References: <20250409135402.212535-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8833523636843767323==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=951571

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.24 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      34.02 seconds
CheckAllWarning               PASS      45.11 seconds
CheckSparse                   PASS      32.33 seconds
BuildKernel32                 PASS      24.56 seconds
TestRunnerSetup               PASS      463.45 seconds
TestRunner_l2cap-tester       PASS      24.52 seconds
TestRunner_iso-tester         PASS      30.95 seconds
TestRunner_bnep-tester        PASS      4.79 seconds
TestRunner_mgmt-tester        FAIL      120.96 seconds
TestRunner_rfcomm-tester      PASS      7.90 seconds
TestRunner_sco-tester         PASS      12.65 seconds
TestRunner_ioctl-tester       PASS      8.48 seconds
TestRunner_mesh-tester        PASS      6.08 seconds
TestRunner_smp-tester         PASS      7.17 seconds
TestRunner_userchan-tester    PASS      5.03 seconds
IncrementalBuild              PENDING   0.77 seconds

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
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.178 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.150 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.181 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8833523636843767323==--
