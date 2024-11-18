Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67D41BD4E2
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 18:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731955003; cv=none; b=WKH7egU9Kt5XWHysR9vLYaHfM3tnPyq8AP6+RxkrD8wRNZ8ZaxpRBjuw49/GsNb+VznhgqJoY0EKgLYzjYNR6w4ICvVK5z4ujIZZbh6rczQ2aIrZU6uDSPCH+JiCC9u05jLDsMq/bPnPAf+3ti6VXct2RH+EJMJqSKhUJUVOoQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731955003; c=relaxed/simple;
	bh=wz9uarCcbnkVjTPb8m20cMoJabMdV0+EfVAnw41rioA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LRqGYYLUWb2PLCvVo5gFIKitRqIOEJH2GttsWTJuDQyZpQFeeE8ppDPRttU11DrO+LpDIw2AdcTKS2f5LPNkbLf+srAZ2SCkIj6PS4wmzZTXdBdG9w6meIEsi8hvaeQkvGiA7yGkByoaqbi8BOs3H+QiHCJEYh8s2/o1MD7usWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=As9BFdvF; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="As9BFdvF"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4608e389407so1083221cf.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 10:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731954999; x=1732559799; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5KObH3cHFslfHhrpH1jlYCIOk7n3y8ITCgHqZjOb2q0=;
        b=As9BFdvFuWOL5zyGl7/9m8cw17nuQlwgsHAJ26u4b3+bq1vpLBMqC6HgaPrFrvVtuL
         cWWefoq4jqCeXQWcjJnOOH/rRIbIVGxFcQcIitI7aaEX6gFzE9rJWJGkDBQOuE26Znw7
         ie1SJr+KPjJM5wNqI1g+mZdZBgJph1tbzhhgFc25skWEKjYBDk7xpxh/QRPLcDSPw8oB
         ddCFJohEXXfHuIxW0pDQTHv3s0BkYpUQxIuMQJbKVC0obEg71nRI5W4vpr47bkdH8wLj
         VQ+rgxVev84ccc+WCyr5HaZ/Lzlnl6xtnQ3Z/8A2MQ6mogcFhjdQ1scG9jwZgtJC2NAV
         2unQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731954999; x=1732559799;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5KObH3cHFslfHhrpH1jlYCIOk7n3y8ITCgHqZjOb2q0=;
        b=Sc9SE/ILxnx+AJC+8fctcsv1mKC6kWI6m3Q9Vo91Dj2EBIRymY6Cvu98S/YqDls2Ru
         FpgzPAdCYHHmR4yjekAG2A0FZycFxiEwsy2ITok4CawB4G1S1gBJZx29DI+/TgV9yrlN
         OSJaWjoYb1V1P3NqT5Rulg9621y/yy88CbOoftQLuhFW9UAHfGDwcBOwDsLLKynY+Y/8
         MCYYK1Koz2ryiq7hJrj24hgRo3w2DQTWhLoFtpL7JZA2vJE4rubPTfJddB+w5IJfEMQQ
         W7O9jExm6T4ocBLADH5L22wIPCTDMAhJTTFCJRTM+PN/14reIexcD2N6bUZsDxh2zCGi
         YO7A==
X-Gm-Message-State: AOJu0YwEeqByqFLHl35PLKqxOWSJcVb976z1/jdR/MbXrWD/9+/NCXOs
	MJ3g2bAcL/wWb7eP404tfoN3JJ0ZV9OUPghAnvc7/3A59PXQCAZEX2tcOQ==
X-Google-Smtp-Source: AGHT+IFp8R/kFNbo8qsuCHVitBxckdDyulSZRrYBhiCiGr3wyUHA/7CWkREyCsJpGvXkzFi9w/Rsng==
X-Received: by 2002:ac8:5802:0:b0:458:3a34:b7b5 with SMTP id d75a77b69052e-46363e3104cmr172318401cf.26.1731954999410;
        Mon, 18 Nov 2024 10:36:39 -0800 (PST)
Received: from [172.17.0.2] ([172.183.39.65])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46392bada34sm1576821cf.29.2024.11.18.10.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 10:36:39 -0800 (PST)
Message-ID: <673b8937.050a0220.29c034.0852@mx.google.com>
Date: Mon, 18 Nov 2024 10:36:39 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1023249776799013123=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v4] Bluetooth: MGMT: Fix slab-use-after-free Read in set_powered_sync
In-Reply-To: <20241118174026.2627359-1-luiz.dentz@gmail.com>
References: <20241118174026.2627359-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1023249776799013123==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=910708

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      25.42 seconds
CheckAllWarning               PASS      27.81 seconds
CheckSparse                   PASS      31.24 seconds
BuildKernel32                 PASS      24.87 seconds
TestRunnerSetup               PASS      441.10 seconds
TestRunner_l2cap-tester       PASS      20.85 seconds
TestRunner_iso-tester         FAIL      30.76 seconds
TestRunner_bnep-tester        PASS      4.90 seconds
TestRunner_mgmt-tester        PASS      121.66 seconds
TestRunner_rfcomm-tester      PASS      7.59 seconds
TestRunner_sco-tester         PASS      11.46 seconds
TestRunner_ioctl-tester       PASS      8.13 seconds
TestRunner_mesh-tester        PASS      5.96 seconds
TestRunner_smp-tester         PASS      7.40 seconds
TestRunner_userchan-tester    PASS      5.07 seconds
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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
Total: 124, Passed: 120 (96.8%), Failed: 0, Not Run: 4
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1023249776799013123==--
