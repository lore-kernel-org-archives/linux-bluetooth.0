Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A823085D4
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 04:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750306857; cv=none; b=AjqY/4ID8E89dzpb8GlPuKKN+QNZgCQoCniuy8auEmF0wAoJ+Id2Pa9pz3PTRwsXQ+1vx+zyyCV3MyPOpNF912dHzDdS2jOdWdCVDlCXOS7B9LP1mB7Oayeua+pWBi3f+sD27pMiwv9v/mmcIHfvERnPSjJHm2ftpE8AVMXOn3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750306857; c=relaxed/simple;
	bh=cCHDaTmuK+h4Ywo85vxmGDd2TahkCKFCaEP6dtJjKN0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BsFow0cdMKajLNVMRwJXGHn/W/cItbVkSKW0660UE1h45SzWLw0yQE80EA+RuKED+ultuWZh2Br2i3+PDjdu7ClrCPnu0qN5LJGuB6Ka+bbs54ANCUI3ah77XwR4ewOW5/T6LiwiH9XtZXTGbZgvMQeVvc2fKvgF+YwhdhNscCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SguVicAY; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SguVicAY"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7481600130eso381614b3a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jun 2025 21:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750306855; x=1750911655; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TCvdFQ4Dlholt+Ym12Ehycmap9/fhw0h6/Mk50NwLzI=;
        b=SguVicAY/noU7q+qFQb8HeAjK6APFmINAB1eeedQBxWZIF9aER1CXyIPtfmn6tokMU
         rDvhqP+10F14BDv55yjhFg4FR9N8/usLnXU8OGb1Bu1orOhCD+SSQtlTm45t1g67O3Ae
         R9wBeGEDZ3rPdFLIN6Y8evcRaLcEF8ZWF5gS3zwrdmnnwTc7L7bYyZ4BIFDPovy27tj6
         vUJ6D3bTGpjt8sRV2w0W0gGKPNW+7juGv5quHpC2b89p6nijdFA1DnAx3wL5a8WwxNth
         ZHVgzZ4Q4FxncMxkU0+0v2F+95uG26pExn8O49nseu5FB7ijFjpChXgwm0G8HGFd0497
         cw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750306855; x=1750911655;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TCvdFQ4Dlholt+Ym12Ehycmap9/fhw0h6/Mk50NwLzI=;
        b=o/NUy1YhfTLAzDce7s0qe7FegUf4xJ8kUSd2IMtunwXL1T6/tok+v5F+AZfPGlZRXO
         PaLt57DU+TVlDyumG1rs6MVfJCnAgkPjA/67tA4YuvTfiXPAP3oFUd39Jj1Y7VUtGnZJ
         RuqdIzTR8bZpSl/QCDgAYp4wr/WZ93LM/dZZenFhxU+DoQPCfjiLwtG5P5bS8dE5pei5
         Nj6esq1bK+UFXzvHL1heG8bf/+jqXpmYjk1XYQlpj7tjcWFVsfmSJAHssVPf3wZKnPqH
         FeAhnpEKZns+HY9hqw3OL1B3pgWIjeY8CgBaXKsFYsgnwnFsmpNF4w2j693bks1EFek8
         eduA==
X-Gm-Message-State: AOJu0YymsC3TTuQe8RbSHpHsTPYzYj6sA3JygHRhTWIiMMKKLVPOU56F
	56AkI56bow6HVlxTsfWCB82a5UW+3irJPxCydFjfyVvWJzqOQt7L4zVI+kUwvw==
X-Gm-Gg: ASbGncsyTgalGsyja9zrHkF+quNYpbJFpolfwoHI5YXknux4akszaty8ogSxTC0gNwe
	rmHPOTnrk0Ndup1+jcvwHF2CzxHYv2/Ve9hog47htButdV0srOIfAvwNCa1s/2dvA/JikAKxudr
	mIpFIQdRVax0X6Ni2u2w4NWyZ2Sq99bTk5/CTBfXUqLH1f44ZFnMXoNHVjPu1OipMrNxdBUr+dg
	baFQDdnC7OPIK/Irgf1oaGKAsE13IVpG1v+uotNZJSSjolhPGg9mMSjLxA+QCJwQvajpbPgDkf9
	kqfceeAlLln3oYERYcbZkT7/EbOpokCiQzpwtW04GN7DhCNtj1Egv515U1P3BOya5z5V
X-Google-Smtp-Source: AGHT+IEqrfjnqTY5psOT/n1hchiIsHOio2xF1glLa21hKXmzdnZwFRdGarHiUqUu/G8nc7aXPOOI8w==
X-Received: by 2002:a05:6a20:43a4:b0:1f5:709d:e0c6 with SMTP id adf61e73a8af0-21fbd5d3b75mr29322660637.42.1750306854756;
        Wed, 18 Jun 2025 21:20:54 -0700 (PDT)
Received: from [172.17.0.2] ([20.43.247.161])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe1680420sm10109710a12.38.2025.06.18.21.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 21:20:54 -0700 (PDT)
Message-ID: <68539026.050a0220.a9e80.eaa9@mx.google.com>
Date: Wed, 18 Jun 2025 21:20:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8046374334382167007=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yang.li@amlogic.com
Subject: RE: [v2] Bluetooth: Prevent unintended pause by checking if advertising is active
In-Reply-To: <20250619-bluetooth_adv-v2-1-4bfc32941e53@amlogic.com>
References: <20250619-bluetooth_adv-v2-1-4bfc32941e53@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8046374334382167007==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=973632

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.33 seconds
SubjectPrefix                 PASS      0.05 seconds
BuildKernel                   PASS      23.93 seconds
CheckAllWarning               PASS      26.44 seconds
CheckSparse                   PASS      30.07 seconds
BuildKernel32                 PASS      23.73 seconds
TestRunnerSetup               PASS      451.56 seconds
TestRunner_l2cap-tester       PASS      24.71 seconds
TestRunner_iso-tester         PASS      71.45 seconds
TestRunner_bnep-tester        PASS      5.96 seconds
TestRunner_mgmt-tester        FAIL      136.22 seconds
TestRunner_rfcomm-tester      PASS      9.07 seconds
TestRunner_sco-tester         PASS      14.50 seconds
TestRunner_ioctl-tester       PASS      9.74 seconds
TestRunner_mesh-tester        PASS      7.34 seconds
TestRunner_smp-tester         PASS      8.30 seconds
TestRunner_userchan-tester    PASS      5.95 seconds
IncrementalBuild              PENDING   0.63 seconds

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
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.200 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.172 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8046374334382167007==--
