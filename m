Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1AD4F8BC
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 May 2024 23:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715817371; cv=none; b=TRX7pM6YyNnKWlm7BKxHaFttuYK1WYXvxN9J0R2xASfPtZXjoAGorn28aQ27G+Z70B68TuYAqZBhT5PKzeVBgi//0/qSfgZsghQmFD+9uFccH24kM9kTdNBC1Jbkm1JyrLdyKVhVG1lHreQRErXrQkyOIocxu4m3erBhkrx3lUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715817371; c=relaxed/simple;
	bh=TysP2xjoRjVrkGeC+EMmm1M1/6+c4r6eB6EW7h4wKro=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Bgs6pMtFeYXuC7m78Zo9nOm45dRIP+K8fDmvQvuAbrnXI5Z0ZclV9dpef0mjPyku8h17pBBKNCGu6bJ6rngrXs52SqXLiPzzEJOgros3vqMXWDrJgURWLdV112/n5i3XsTIqTfK3xoS5fvQ5v/LocKo+SUgldmFNF5dqEHi4kfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBiLlx/i; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBiLlx/i"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6a0c8fb3540so50463576d6.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 May 2024 16:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715817369; x=1716422169; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aCnS1lyBor4Lo7T8HiHMm/Xnu6TNzoOMlRmDYrgZzMY=;
        b=fBiLlx/iNAa5XyJ3kX0czFTad2HG+F4nAuHpnqAnUyYKRX4MTdfSxOJWpAB6lmkZOU
         jlBJhj80aqiGtgj6nAsYwUfz0KlOVxI31ifk+Jcy2CMg+45qR3/mYexxVz1Uyz2r4UTk
         whRk2mI9n1Kj67L98jLdh2iVB0wFz3wXiBdx6EM12kCk6oP4MCuDiHz3yqwCJnuEymPK
         s/YRmACmlc3DCIZ0dckWDG3kjpmtxpDStUHJphJQL/D72bVljiBxxKg0ta1eeFsaDIPr
         +7an5VZLsjCk7jO8cHY3gSKGjOr4fUG5E1WqL7oh+EaED76DEQI4k7YPnFnmQzQuGsoN
         k3kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715817369; x=1716422169;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aCnS1lyBor4Lo7T8HiHMm/Xnu6TNzoOMlRmDYrgZzMY=;
        b=vL+HmM/y9LVsglkInQyk+UL/VgsAJsHylzPpgX5+mZN0QC4Wak3NJD26C8rMjvkZB7
         /ezRVHVhpppqNOXHeIrvA6MLpLBDtjxVtrzJeECpl4dBX7k0z0QvXVUTsetWs0FR60Hc
         4y821JNDMSmSLevDUz3VLYCUNf1MLlyE5dh6lQUerBoUeCOYkU8/lRYy/0D0vzgQ7hhV
         oEnOMyXPxtMarin+uHCBZMEElEJr4THjdKnqDwzLeVqTqCw6Y1LarAP8bOO3cGaLf8GD
         Y6W/5Cfot9l2GHlVKZaupKLDfFIMnd9lcttsMONPxYFF2rSZrN1Et2Q+HKzhajnRiAVs
         K7jg==
X-Gm-Message-State: AOJu0YzIN/NavecPin9UGfpOyfA1b8sM+5jWKeu6u++DOC4NAm07I6xK
	p/ga66bHSeUn3Bq6C4Y0ugg3WadJE4uKmqhJ8D9XsXN0qF/lH0DfoPO3PQ==
X-Google-Smtp-Source: AGHT+IHSfBtPansgk1UakASwYxFSHssTRaGluTbdHJmhokpvW6mrvSJiaqcPUJXi+JlfbRgLDOaXYw==
X-Received: by 2002:a05:6214:469c:b0:6a3:551a:db7f with SMTP id 6a1803df08f44-6a3551addfcmr80203926d6.21.1715817368780;
        Wed, 15 May 2024 16:56:08 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.38.204])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a35290b864sm17553206d6.143.2024.05.15.16.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 16:56:08 -0700 (PDT)
Message-ID: <66454b98.050a0220.58a8a.76dd@mx.google.com>
Date: Wed, 15 May 2024 16:56:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6066672689112332014=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sean.wang@kernel.org
Subject: RE: [v5,1/5] Bluetooth: btmtk: add the function to get the fw name
In-Reply-To: <ce0337178bf617d52ff320a36837d75bf537df2d.1715813148.git.sean.wang@kernel.org>
References: <ce0337178bf617d52ff320a36837d75bf537df2d.1715813148.git.sean.wang@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6066672689112332014==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=853525

---Test result---

Test Summary:
CheckPatch                    PASS      3.60 seconds
GitLint                       FAIL      1.71 seconds
SubjectPrefix                 PASS      0.58 seconds
BuildKernel                   PASS      29.25 seconds
CheckAllWarning               PASS      32.14 seconds
CheckSparse                   PASS      37.90 seconds
CheckSmatch                   FAIL      34.30 seconds
BuildKernel32                 PASS      28.20 seconds
TestRunnerSetup               PASS      513.42 seconds
TestRunner_l2cap-tester       PASS      18.10 seconds
TestRunner_iso-tester         PASS      28.65 seconds
TestRunner_bnep-tester        PASS      4.71 seconds
TestRunner_mgmt-tester        PASS      112.77 seconds
TestRunner_rfcomm-tester      PASS      7.28 seconds
TestRunner_sco-tester         PASS      14.84 seconds
TestRunner_ioctl-tester       PASS      7.62 seconds
TestRunner_mesh-tester        PASS      5.79 seconds
TestRunner_smp-tester         PASS      6.73 seconds
TestRunner_userchan-tester    PASS      4.87 seconds
IncrementalBuild              PASS      48.16 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v5,4/5] Bluetooth: btusb: mediatek: reset the controller before downloading the fw

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (83>80): "[v5,4/5] Bluetooth: btusb: mediatek: reset the controller before downloading the fw"
##############################
Test: CheckSmatch - FAIL
Desc: Run smatch tool with source
Output:

Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: net/bluetooth/hci_core.o] Error 139
make[4]: *** Deleting file 'net/bluetooth/hci_core.o'
make[3]: *** [scripts/Makefile.build:485: net/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: net] Error 2
make[2]: *** Waiting for unfinished jobs....
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bcm203x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bcm203x.o'
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2


---
Regards,
Linux Bluetooth


--===============6066672689112332014==--
