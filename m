Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3301929346F
	for <linux-bluetooth@vger.kernel.org>; Thu, 31 Jul 2025 08:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753951363; cv=none; b=Bd55tlTH7g9EXcHYF8RbJ2tb085qADjhoWUUehTIBXIcQP0cwes78Nvi54C0hs1sfBSAta0zKpJlZqURTwDYhks9xsS/Ok/HRjTv7lD9zz9Bzztdi/J7oAxh3wR9vNVSDvRfVeGTtg7ovRBxiVLPy9WWsraENAmDcADzhKWv2vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753951363; c=relaxed/simple;
	bh=MTvhvAaf4aw05R0KGayiI7xR++fT0Ounb5hx9VhDlQo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=U9eoRPGv0C+n0c8IIwIrj+W8WStXdOb+BidFMRoc2Py1HF2Q7pns2Ou3Vn+ZRWDxzo7K2C8Vs7gJIvVF4xaMRPW3ktoCmuGUoq/YZ3iK8Q1gw+hftPwA2/SqrZR5EW8skMfs1RAPBUEOmJyaG+4ZhMksG9giBSS9RHezWhFSv5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ppzqrj4m; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ppzqrj4m"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-87c4bacb68eso2565439f.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Jul 2025 01:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753951361; x=1754556161; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iUN7a8xyDBNpRmAnMEpz33sh8tMcdmTzu+5FWF7UTbc=;
        b=Ppzqrj4mJFbkkbpPFTidEHEAwlArcpPCqUzdXcCirOMbuidnVUyo4FqDYISfXBrYnn
         wvCrvSp+Xk8DxIKnwaLsIZfUcjUZ/QRZX+v/pV/jOOeTDqc/X/SaNYixr3isu6CuazFF
         AtwLysQG7Z03W/U0iEbm/gxESI+1/xRV6tS7K4/zKtwLnZCfrXegALxTMYxbVBZ2nIno
         SKDpTk+yHKmH2KL/kQjUHJ8FnXjlne10oMdLPKf9qvyZyDpIKPtbp9h+u7TGKfftmTP+
         xrJAp2U+sSBYOkrmJm3pNxrvppe98VSHp1iinH/8C+1FMSzhAozAb5SrmQ8578WE/hnp
         nUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753951361; x=1754556161;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iUN7a8xyDBNpRmAnMEpz33sh8tMcdmTzu+5FWF7UTbc=;
        b=DkvHK9aHAPou1+OZcCdn++LW8aU3zwoqV63WJgiPDwT33TsC2WOYjbjmzjr0Ymiged
         092/oojEVV3rG+DYMGBwhY7XXHxSAWt9YVZT/4LlU5sSc66nzyZnPS4zTIm8++96NxeY
         mSEIzu4wbPVsweq94CexxoiWFKxDsrzGLNBFL/YIjVYap4NZdgy1ccM1MIUWvIF/iIpx
         4oMMjQBPuoU32NeP8hUYF+nWyGOSFn6lggws6xgI0O0LOoLS9vGw4KOWYWdweix+ruwS
         Z4qPEbJdBBmMH3bx+kb5orcVOk3J07fO8S+Bn5ynm/2GVMehxCyOVpxEDznWuB5cSup5
         Tjhw==
X-Gm-Message-State: AOJu0YzKvRAvJ64hlDw4yrZXfvOakC+Ud0+cGjKEYUJ1G39+LOwZK4Il
	FNDxFGHPZgnBPfsRegrDXMDiPDLyjGW3EapdxgxDFV+plDYKnHJV0M9w2D8QRA==
X-Gm-Gg: ASbGncsPbOn1k0Bu0b75B6LC7+x5xJEsj3CSMiM5hyzLKK+eaV1CPlX0CCaOdZlcQ5O
	A+/CchysSScf1iS97B0YM+R45imglhkh3rcjN8DNq2oZBqAASEtofmvWzI5TeFZxWZZi3IPPVsD
	/m7MgYmMVmhkGo45qkWqHJzbh0FCofXAWY5RUk8JghsD4Tlnw5567uFo6Jh27+fsS+W/4DXtqgb
	E84NUWdRdf/prd8pThDgt4N1qHmeuVX/74msQKsRuyay6AsRIIEiMEVJbsXvrZ39qkkT3hYdhdb
	rWj9dLfQsh5dcOSXtaZX0ImTP5TmqOGc9wqKZvxIAExoBoFkH/9rZYao9wZ4q/YhjlmbWJRqIyt
	pxv+4NZQPIX0/NZAwozk1YhgFG1jzTHm6YaHILLeg
X-Google-Smtp-Source: AGHT+IF3aABYREK6MBdj2Nhl6UEjHfQZG07S6S49FB3jCLjjAf7bFMRHweo1Jfj7ZtS48yvsiUD+Jw==
X-Received: by 2002:a05:6602:2dd0:b0:866:217f:80a with SMTP id ca18e2360f4ac-8813785929dmr1171439139f.7.1753951360975;
        Thu, 31 Jul 2025 01:42:40 -0700 (PDT)
Received: from [172.17.0.2] ([52.176.125.118])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8814deda475sm32512039f.4.2025.07.31.01.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 01:42:40 -0700 (PDT)
Message-ID: <688b2c80.6b0a0220.394666.09d1@mx.google.com>
Date: Thu, 31 Jul 2025 01:42:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4274601335988829259=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yang.li@amlogic.com
Subject: RE: [v3] Bluetooth: iso: fix socket matching ambiguity between BIS and CIS
In-Reply-To: <20250731-bis_cis_coexist-v3-1-1f9bd60ef712@amlogic.com>
References: <20250731-bis_cis_coexist-v3-1-1f9bd60ef712@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4274601335988829259==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=987260

---Test result---

Test Summary:
CheckPatch                    PENDING   0.40 seconds
GitLint                       PENDING   0.35 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      24.55 seconds
CheckAllWarning               PASS      27.21 seconds
CheckSparse                   PASS      30.76 seconds
BuildKernel32                 PASS      24.68 seconds
TestRunnerSetup               PASS      481.00 seconds
TestRunner_l2cap-tester       PASS      24.72 seconds
TestRunner_iso-tester         PASS      40.13 seconds
TestRunner_bnep-tester        PASS      5.99 seconds
TestRunner_mgmt-tester        FAIL      126.50 seconds
TestRunner_rfcomm-tester      PASS      9.37 seconds
TestRunner_sco-tester         PASS      14.63 seconds
TestRunner_ioctl-tester       PASS      10.06 seconds
TestRunner_mesh-tester        FAIL      11.53 seconds
TestRunner_smp-tester         PASS      8.62 seconds
TestRunner_userchan-tester    PASS      6.23 seconds
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
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.200 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.054 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4274601335988829259==--
