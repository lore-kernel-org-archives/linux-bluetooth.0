Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01D54A23
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jun 2025 21:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748984422; cv=none; b=qk1rBYmMeglCIxwfOgqmT9NEj1KnX00SvB7PMw3HjvmP7q+JWZVP1azOpRGxT1BWkOLH0UXoRLXJ1dZV6xdvAXG4nKgqpNK9tp2uNgB5jahDlCB506m3SjuRVIEH7kiBziw8JI1M9Nc2qrX2CA27/3xxbMVNE2rIDyde1f3+PrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748984422; c=relaxed/simple;
	bh=2nRADYC7CerA9GN2CxZXzYUYkdyooR0zqHpwknN1pRk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Tb9ennHVtR/ULQa0eVAYAQjidq4l/R5rR+9tKx0tQ4NbWWKJaGYkvA7JwTAuXLJggEQAEPnuXXH28GLCqZ2Ch6EtICIQjGgFm6QBpIo+G+3I5ehO7t0985lbnDr5BYjwHro8Cqc8XC76WLlay1LYVq5ufoCLa9rpqwjAPpudxjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXWb9uKG; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXWb9uKG"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4772f48f516so2980361cf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Jun 2025 14:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748984419; x=1749589219; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=22U6jyBXF7ZJNQ5oMU7THi3Bjl5UhnMt9BDUar57lGk=;
        b=EXWb9uKGrGwV4DX97e0i8WX4YqlNDNkxxabkkTqoxeC2KXPYUT7YgBaJ1W++tFXi5n
         oomS4i104IUTNbf0fkk1bgMqyyzDaYBGxepRECZ1av8Pdem1LmVv/J+4PTsW7dUyqj7D
         mNunm8rCED9VX7fz7F1Ndfst8TVUDUms9RUxhIgva8hdK+motsrCjByp/z1dD9MgDMOl
         JbKIGUcleaXfcHDyoPc5LNBtGPU5nzehuM1Fq9U4UWiZPeKUx5K9NvBFeCzjSSLWWRJf
         clUrUHxvdS2XLlBAmF9EKf6OBSoPgtKFhnh7AZHTWIUHy+iFRBRLKdoYcz2Bul3HBa2a
         z6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748984419; x=1749589219;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=22U6jyBXF7ZJNQ5oMU7THi3Bjl5UhnMt9BDUar57lGk=;
        b=RCktR6zQmUU3G8BLoGeWBuVkTaX3qWJ0ro5ipTWPwYuDeldvdCuCM8QPdj19rpAiL7
         VDHgET7xZZdnHK7jY43UpSmzkiXA4v9pVPvlQ++XXUE1TFPkmmx1pU7o85jNeIykYYXH
         in8opcPt6VIP5pW9eNuVR7psZQYbLwPK1fBLoSLPriz4IKQchYoYejOZqvRPwtqkZ1rn
         1gEmeE8HsSTbE4pD5OKE1ppLC0Ye4LbmPILANFouNLsJb8RHcKeZgqDUYxnL70MHY5W+
         sT4pQeGxToXjPM9pwnIonHHdtgpEgt1qhxTQG+4N6OOkhigxUoke7j2X1yENJC09P93o
         ei/A==
X-Gm-Message-State: AOJu0YwhtI2bIXgfcKnIAHVoaUW47MYVXD6bklXo3lTfPi90LT/hFwkE
	Sp8BAOiFaX5SpEVi9DDatmbNbNoI+iyGngc5uRh09M/BPOzFc13fHITPVimRLQ==
X-Gm-Gg: ASbGnctmHTKNKSOm5c9fO/IZmbLc68OVQ7SHUjpOIeZzpM9eT1f5QebU43u9raXB6Jd
	IDe6l+JqNnLMm9IG0xePHWKZDDVV9LBJKc857F2G+Vciu+fKE5wM8o21lme4ol8JnJipagWT4lk
	5DvglOXbMFiVD7TOSfqNFUqckgzNdldXfpXpIKqmm3LsM+BrsTTMM9QrVBilo0Dx2gDbnmQaSjz
	PIbFuX7ejdF1Pu6PnO2aW3zFSnptXodEJGRxixUYjM4nuxNEWyEA9BLTivW2tVBe428SxHODJ7C
	Kh19Vgj7zEfBh553enSvPvoYmVilWqVolUt7hR5d9M3z+RzNYA+UVmCE
X-Google-Smtp-Source: AGHT+IHS+LISl+uMNpB9gYCFUlnoghRaYBKRixICdPFnxf42zkB54U2m+/nLXysDHYR+8rzlRG6z0g==
X-Received: by 2002:a05:622a:1f93:b0:4a5:8387:8b8d with SMTP id d75a77b69052e-4a5a5717675mr8175911cf.21.1748984419080;
        Tue, 03 Jun 2025 14:00:19 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.192.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a4358eef6csm81804741cf.48.2025.06.03.14.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 14:00:18 -0700 (PDT)
Message-ID: <683f6262.c80a0220.340d98.bc04@mx.google.com>
Date: Tue, 03 Jun 2025 14:00:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5619506921756409413=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v4,1/2] Bluetooth: MGMT: Fix UAF on mgmt_remove_adv_monitor_complete
In-Reply-To: <20250603202921.267083-1-luiz.dentz@gmail.com>
References: <20250603202921.267083-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5619506921756409413==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=968399

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.21 seconds
SubjectPrefix                 PASS      0.18 seconds
BuildKernel                   PASS      24.20 seconds
CheckAllWarning               PASS      26.63 seconds
CheckSparse                   WARNING   29.85 seconds
BuildKernel32                 PASS      23.70 seconds
TestRunnerSetup               PASS      450.09 seconds
TestRunner_l2cap-tester       PASS      24.76 seconds
TestRunner_iso-tester         PASS      35.57 seconds
TestRunner_bnep-tester        PASS      5.75 seconds
TestRunner_mgmt-tester        FAIL      128.65 seconds
TestRunner_rfcomm-tester      PASS      9.21 seconds
TestRunner_sco-tester         PASS      14.52 seconds
TestRunner_ioctl-tester       PASS      9.68 seconds
TestRunner_mesh-tester        PASS      7.33 seconds
TestRunner_smp-tester         PASS      8.42 seconds
TestRunner_userchan-tester    PASS      6.06 seconds
IncrementalBuild              PENDING   0.92 seconds

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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/mgmt.c:5393:59: warning: incorrect type in argument 3 (different base types)net/bluetooth/mgmt.c:5393:59:    expected unsigned short [usertype] handlenet/bluetooth/mgmt.c:5393:59:    got restricted __le16 [usertype] monitor_handlenet/bluetooth/mgmt.c:5393:59: warning: incorrect type in argument 3 (different base types)net/bluetooth/mgmt.c:5393:59:    expected unsigned short [usertype] handlenet/bluetooth/mgmt.c:5393:59:    got restricted __le16 [usertype] monitor_handle
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.222 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5619506921756409413==--
