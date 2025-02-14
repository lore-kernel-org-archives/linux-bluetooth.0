Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60889263F3C
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Feb 2025 11:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739533842; cv=none; b=l6Ypm/ocyDbPeBzkBkrSCGHbIyRB8ay/vT0PCGOM6Aka7l5uo/7SIgAniDdTWTgFLcndz5Ct2H7nWRbKVZOKK4Dcy8b9qSN/U8R4Zuttek8wGG8hiwU3agNf1+Wfxki5bFPG6wNtv2xVgLju0U3jOjxZKpfxAJYCnMhIzdkJs6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739533842; c=relaxed/simple;
	bh=0XCMhalmMJPFPWW3iaK/Y9DOYMq2KKkz8S7xX9MSkew=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZApEoNxM6qDhjmkaJkLjKihhz28Yds28qNdGGPhRnhntzfwz5zNJXCORFwLaHVKk6P4WFALHe1O0z9WtIcsTNhGxl29sZlXIcmsyTWne2LD4ufLIgrdvmrE1Nf5mq9ad2ebxb7dxJy34vza/7nSIGnBNmoABRF4vfOowsxbf0ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BdIHjEwX; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdIHjEwX"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220c8eb195aso37451655ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Feb 2025 03:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739533840; x=1740138640; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VtCtZaxAqIYtiSaTY8H9PaENVX7q/hxH7A8CE7xarRk=;
        b=BdIHjEwXcGtt7uDLvXFtF0e6paAIA+onzAVKCc/oVjqE8jUX8id0i+taV5Ubwj6v3y
         WnmCTuqC9nVtCk2eDEAgLfxTnp7jz23GVmnWKkZnbTyGC1w7mIBzoo4fqVHlx9x2hD6+
         P8bTg5q/QtokO7hfI1zO/ypAIexsej4YW55gNwzCC7JzsMdCIefI1bFLYus671QUKxCX
         nr2xevEeaETuIsAC+LcTmHxrBX8Ejwb44doh9aqFz6tLttZnCOe6oDNiHA+qStjqEsOp
         gm3NPn8AJtjpJ0AcoR7dOEMmszFQys1YV7s6nmL0xC2Y7MglkmmEmyKUSmmisXd8RpiD
         DN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739533840; x=1740138640;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VtCtZaxAqIYtiSaTY8H9PaENVX7q/hxH7A8CE7xarRk=;
        b=NTx7z2UvAHWH3a1IT9bSvgqzd47eKhlbMUVcKJuYQtBUzFDky3y4NssKL6R6g+EQUJ
         EwXvNm5DnMiCa/bhjZPtrgrt3y9iKUTRbOKJU45Du0vBNvY56bTlv3jvY5LiQUQ8JqgX
         Cp7OTX5k2Xh+t/IVYZKmv+gXYkqgxnZX1+YSF0r4aVCj12Rhl87AR64uH48lnEWhjWxx
         VE3aOyyeezztN/+S+vru5cDDGCwtzMbi6MTpumX1C9EpHPBY9oUFIIK4FpYUzqYGJTG1
         6orY86KD7pginGunN9EBSrAtjPaoVP66A8rWyJCsQC966CXEO6Y7n9mnwobAJlkdQfDv
         TiCA==
X-Gm-Message-State: AOJu0YzQvI539fTKFTPJF7YoOCtHqirtXY0C/KMQNRn77Jq1DiYZUyHc
	cRsXGq9sBBupJz5Ty6CR3jPHRIvvDgEqHnxZdn+wgKyNJOWkNrD4DD/d4g==
X-Gm-Gg: ASbGncsIvXGSvcnrb84KG4l98nBoi644ciuzA60f6qMET9tY7fDOhcuPDzIyPR/qKY2
	MED6VIYA0hFW2qL0LC1zpLjrNUcKCaG2ODpI5HdOV33bTGijLI9/INxboA8YPD8DMuyp/VURTuV
	ZXXBzOhMucN2KAPdJIfRAD3gFOPvo8J9lD/0EU8z1e8nqxBWntJRV4luxVsBt3L+Mh8/4VU55nm
	pi3STqlPzGXb4paY0vP8x7XznTcyrgNK2xy6P23DuRNLw6RdkVFxjNADMmG5t9ZYrAl/jvv5Z8k
	qs3NHJlsWWAN9hQyvjBy
X-Google-Smtp-Source: AGHT+IHraOf2VQCzjGXwAYgpbOMHnfmKw255GG6nhBXCQxNBufRnf5O34LUD2vVBcsRc7arMoGinFw==
X-Received: by 2002:a05:6a20:43ac:b0:1ee:3b8e:3439 with SMTP id adf61e73a8af0-1ee5c88f3dcmr18313362637.38.1739533840292;
        Fri, 14 Feb 2025 03:50:40 -0800 (PST)
Received: from [172.17.0.2] ([52.234.33.79])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242568a66sm2902354b3a.44.2025.02.14.03.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 03:50:39 -0800 (PST)
Message-ID: <67af2e0f.050a0220.22b41a.cc51@mx.google.com>
Date: Fri, 14 Feb 2025 03:50:39 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8861230627262758741=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chharry@google.com
Subject: RE: Bluetooth: Always allow SCO packets for user channel
In-Reply-To: <20250214191709.1.I6e9e94dcded65e4a9ed42ad23ca8a5d81f680382@changeid>
References: <20250214191709.1.I6e9e94dcded65e4a9ed42ad23ca8a5d81f680382@changeid>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8861230627262758741==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=933983

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.31 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      24.35 seconds
CheckAllWarning               PASS      26.71 seconds
CheckSparse                   PASS      30.13 seconds
BuildKernel32                 PASS      24.04 seconds
TestRunnerSetup               PASS      427.77 seconds
TestRunner_l2cap-tester       FAIL      0.09 seconds
TestRunner_iso-tester         FAIL      0.08 seconds
TestRunner_bnep-tester        FAIL      0.08 seconds
TestRunner_mgmt-tester        FAIL      0.08 seconds
TestRunner_rfcomm-tester      FAIL      0.21 seconds
TestRunner_sco-tester         FAIL      0.08 seconds
TestRunner_ioctl-tester       FAIL      0.09 seconds
TestRunner_mesh-tester        FAIL      0.08 seconds
TestRunner_smp-tester         FAIL      0.08 seconds
TestRunner_userchan-tester    FAIL      0.08 seconds
IncrementalBuild              PENDING   1.00 seconds

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
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:

Could not access KVM kernel module: No such file or directory
qemu-system-x86_64: failed to initialize KVM: No such file or directory
qemu-system-x86_64: Back to tcg accelerator
qemu-system-x86_64: CPU model 'host' requires KVM
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:

Could not access KVM kernel module: No such file or directory
qemu-system-x86_64: failed to initialize KVM: No such file or directory
qemu-system-x86_64: Back to tcg accelerator
qemu-system-x86_64: CPU model 'host' requires KVM
##############################
Test: TestRunner_bnep-tester - FAIL
Desc: Run bnep-tester with test-runner
Output:

Could not access KVM kernel module: No such file or directory
qemu-system-x86_64: failed to initialize KVM: No such file or directory
qemu-system-x86_64: Back to tcg accelerator
qemu-system-x86_64: CPU model 'host' requires KVM
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:

Could not access KVM kernel module: No such file or directory
qemu-system-x86_64: failed to initialize KVM: No such file or directory
qemu-system-x86_64: Back to tcg accelerator
qemu-system-x86_64: CPU model 'host' requires KVM
##############################
Test: TestRunner_rfcomm-tester - FAIL
Desc: Run rfcomm-tester with test-runner
Output:

Could not access KVM kernel module: No such file or directory
qemu-system-x86_64: failed to initialize KVM: No such file or directory
qemu-system-x86_64: Back to tcg accelerator
qemu-system-x86_64: CPU model 'host' requires KVM
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:

Could not access KVM kernel module: No such file or directory
qemu-system-x86_64: failed to initialize KVM: No such file or directory
qemu-system-x86_64: Back to tcg accelerator
qemu-system-x86_64: CPU model 'host' requires KVM
##############################
Test: TestRunner_ioctl-tester - FAIL
Desc: Run ioctl-tester with test-runner
Output:

Could not access KVM kernel module: No such file or directory
qemu-system-x86_64: failed to initialize KVM: No such file or directory
qemu-system-x86_64: Back to tcg accelerator
qemu-system-x86_64: CPU model 'host' requires KVM
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:

Could not access KVM kernel module: No such file or directory
qemu-system-x86_64: failed to initialize KVM: No such file or directory
qemu-system-x86_64: Back to tcg accelerator
qemu-system-x86_64: CPU model 'host' requires KVM
##############################
Test: TestRunner_smp-tester - FAIL
Desc: Run smp-tester with test-runner
Output:

Could not access KVM kernel module: No such file or directory
qemu-system-x86_64: failed to initialize KVM: No such file or directory
qemu-system-x86_64: Back to tcg accelerator
qemu-system-x86_64: CPU model 'host' requires KVM
##############################
Test: TestRunner_userchan-tester - FAIL
Desc: Run userchan-tester with test-runner
Output:

Could not access KVM kernel module: No such file or directory
qemu-system-x86_64: failed to initialize KVM: No such file or directory
qemu-system-x86_64: Back to tcg accelerator
qemu-system-x86_64: CPU model 'host' requires KVM
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8861230627262758741==--
