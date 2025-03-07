Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFAF14AD0D
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Mar 2025 03:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741318941; cv=none; b=HZ2+ga+WfIJhen2JYAbOOBUUlR29viO8b5YQkEnQJoBm5vEQ60eXdEgcdR4oteUl5Vkxwdru3luXXvGNnGRz/ky6glR3S/9vC0m6r7OorMvg4AlYGiJkkwksGNMGpH2syzN1zE+m4YATLg2Sj5blIJhXh0oMPVZVJSQkB52cho4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741318941; c=relaxed/simple;
	bh=P4hzEN7QU8jT4hrAVJzCFgLJ37FMijyylmcYZlCACh8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bEGHvJNDzskgt+T1UEQ+gkWpTD8+TgEUYwdBtqfhYctdKA36LuTzJCwyGMY4XmkD+nIaaPbeBuBW/tYpHtKWbe4w77B0z+Wf7JquYurdsJ73lMOPUfhZVLiG09pjEyhQkGZ6u77UXHzbHi+rAIwUqateIcPSxreM9vPFEia+WMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVYXl8Je; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVYXl8Je"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6dd049b5428so13586746d6.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Mar 2025 19:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741318939; x=1741923739; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rgaHswHpQ5CW37v2FM86vfLAG0HHcNdgCiQhgwYDvak=;
        b=bVYXl8JepDJJ3yMV3F0vFKv+Q9E+90neoV+S8hcR5e3dEEpFxPH+Mq83nXWICI3Bjn
         VUdDQtRHQYFw/RI/SZEd7vVeEbIRnUacyxwfcEbSpApMarOHMM5Q0/aK9amuO7tAZMka
         TIVyJUCPJuZBO+QYHvRrIncnx6PljtE8i9vU4YGxfeIPWQdWcHMjXffv2nCmjTALtrxD
         l6Ppym0jFFne+RpVpfHROfQ4ihE2HBk4YGkZ9DwK1syoex5h+Z1a7GiGdZoXT7yNcifs
         CSAjJcEqRNSZryK5xglk+0rTLF8uq0K/S8G5sys+mTKye3OKJUTSqYhhIdmV+VWCJdPT
         zVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741318939; x=1741923739;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rgaHswHpQ5CW37v2FM86vfLAG0HHcNdgCiQhgwYDvak=;
        b=c84Ov+uP2o075YqmcP0DwW62TdZRRvgbncbkWlywut0obVw4+F3Lw6o6+X3/Zj3Us3
         NX6sGfOdyHGSH8kgxic34iJ1clodej3DDiibG1DimasTzHue0uGC50se70V8Ia5i/BoJ
         CZKc3gS2ZHhpyGfh5I7QvDdjQbpALTZQwHdJF7/yvJnoDKmtO/Hzv87QXyXVzRR2RBQa
         I5MBZkPnm7NzSM9B3XUHixAfRmdh+rliBHZF0Wcku3C7AtvDSHSjfZD0uePuZpnbIHg+
         fT4dBN9a98UUaVZBNXouJiVc1mJ0SK8H8MP/FzgELTsy516UrzTBLQm+ms0q3yETX0R+
         sLwg==
X-Gm-Message-State: AOJu0Yz6o73UcZzrgpL0rR7VGj+wJ76PMkcgyI23J68iE4chZqpfsZmq
	fvZHMEWY9o0LPBBUvZXx/edVWe85gz2xbo7zmCPykP/PJdQ9V0dDTWHKRQ==
X-Gm-Gg: ASbGnctGNKaPq3TVYiMcfzfDgdy5WO+HKdEFUQPAqF62F/eDJpNTTv5sfR0r5qAhvNK
	QykGZ5zgKY3EnaguLhT5H/ed0WkeADjfwGS1mgPuYLU2M7VDb9xY/8VtdL3qJgvwFyGJhCDIpXD
	RxbzRstkbg7DBXK6c6p7BVVflqwr7nnY1bVO5aYfSIa7ThH6TIV1RTYRZj5ENypHQYsrqkWDa8Y
	ICADWIVBaEMwLmVJGhe7AEmR4tBnSeJRhVa95sD2PINsBdGp9DQXQ3h5B6vKOSi108L2h7oTPA1
	7Fp0EdCNYAS1ij0HQvjowW3RG0Ds2A/JxDeMZRrqUSGlSvxMFTn6+Q==
X-Google-Smtp-Source: AGHT+IF7RKoJ+2KjRQ5M/mB+413hpkH5Aoe+GIoyGWoQHGkbxip1ZnZpbZ1/6C+27470YIrx+lGJVQ==
X-Received: by 2002:ad4:5cca:0:b0:6e8:f038:39be with SMTP id 6a1803df08f44-6e90063d12cmr19964376d6.22.1741318938823;
        Thu, 06 Mar 2025 19:42:18 -0800 (PST)
Received: from [172.17.0.2] ([172.200.181.134])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f707c61csm14677826d6.4.2025.03.06.19.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 19:42:18 -0800 (PST)
Message-ID: <67ca6b1a.050a0220.745cf.58b4@mx.google.com>
Date: Thu, 06 Mar 2025 19:42:18 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0761957809216195095=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: btintel: Fix leading white space
In-Reply-To: <20250307031055.285027-1-kiran.k@intel.com>
References: <20250307031055.285027-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0761957809216195095==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=941316

---Test result---

Test Summary:
CheckPatch                    PENDING   0.23 seconds
GitLint                       PENDING   0.18 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      24.16 seconds
CheckAllWarning               PASS      26.55 seconds
CheckSparse                   PASS      30.02 seconds
BuildKernel32                 PASS      23.97 seconds
TestRunnerSetup               PASS      427.66 seconds
TestRunner_l2cap-tester       PASS      20.90 seconds
TestRunner_iso-tester         PASS      36.62 seconds
TestRunner_bnep-tester        PASS      4.76 seconds
TestRunner_mgmt-tester        PASS      116.12 seconds
TestRunner_rfcomm-tester      PASS      7.93 seconds
TestRunner_sco-tester         PASS      14.00 seconds
TestRunner_ioctl-tester       PASS      8.25 seconds
TestRunner_mesh-tester        PASS      5.90 seconds
TestRunner_smp-tester         PASS      7.64 seconds
TestRunner_userchan-tester    PASS      5.70 seconds
IncrementalBuild              PENDING   0.49 seconds

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
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0761957809216195095==--
