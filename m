Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5466E1A00D2
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Nov 2024 19:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731611661; cv=none; b=Z/hogQFm8dNF5IEeQ1gIGFNWsT0Ckto6l0Bi/dBf8Mnaa2HSg/MARsmpeCbUWtkwxXuboTTFAOkOwryTUUresjHyuVefLutEE4yWdT4PmXk9AkP/WDRCljtHd4csqjwYvE2P6TQ4URDb8MY7NtZ0pzlXd24E0cJtrp8jBT8isFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731611661; c=relaxed/simple;
	bh=muwmFFtQ9DQ50/Xs/BYCMtuqC1Q6v4DPYmswtHLqGBo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CYBP/Paep9o20o0J9LkyOXC1FGAGot1Nj1TexQsRB1Vhqvs7TAYSeUFGNHBHrr1Ezf97kd/2ZvgxGahYskuP73jZnR35KHkxnbp2sdrFDaum77auVTSN+PBEqPG0aGpMv6VzjCGYBBaWp4NBUaDO+TpMkRJVi2seup3kUH3NN6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8SZtbp4; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8SZtbp4"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6cbcc2bd800so8465506d6.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Nov 2024 11:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731611659; x=1732216459; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LSeycadDz/p8EpWaTiqtCIPYxIkFyIHJcEmf4eB3hJ8=;
        b=F8SZtbp4MqBQRU8oGk9nlLoHAa6p6rRp+rGtn0UF00rVEtplBdIPPXyFASMMEVYiDC
         Ytg69FiqwhOjXAcxQ34rS5R8ekqeftZJKzvdeMSr/Q2uWF7bG+UI5rJ8T86NM49TuC0o
         dYKpKeY5HN6aaEGCeOnzKuNFfR+UNuLQtiWedi8Tf+QOmyuU/ygsrx3C9h0HdSDHYhCw
         OGxwy9PEQYzB4atAHpVVH0eDcKxx8aqNbL6uU7l8BSlZNEUxHc11rQGN8yjuixxG9+l2
         tEszYWaRU89SSjoKrxc0Tfs9deE2WzAts2sATIdMGlP11egARHEHrwrC3rX1Fq39sBAG
         sRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731611659; x=1732216459;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LSeycadDz/p8EpWaTiqtCIPYxIkFyIHJcEmf4eB3hJ8=;
        b=dWiAY8jMNXYe5VSkYlBWLexyCAzqevW6khKMZ5eO2H9JxMg+GN2GgqXRRBlKmF1vi7
         kz0whO2/XqPd7QXwrnnzeXuy8dTn6Q3Zxbe+j8XNzjKG9CaBePUtJWtvbZNbwOHAyXVD
         wL7Su+8mxXmGgChayMPDadXsIWBdR8peKZ0bhQWNVaNVD2UayeZOqzBlhmi8eGhtLeOh
         0YpT3ufStO8xaBq2Re0Ij1YfoCcMhMfBLAzvpd/dOQ99HZHiQIAND9D4/29HuRf09w0o
         lODQe7aLQnPOLFzr5+lr28YNLpA5BIT4vnxS4lipPuQbIgpmXdJirzjRNsJodOGxR0Ds
         Pxag==
X-Gm-Message-State: AOJu0YwpWibLUCEnmTVzIjsIg422/ii7GrluPlaIcKcdfOfw1cnPy5AU
	2UkUdMLVTa7YtsmTZf0XDBrhwXCzUgkAQX+mnN6Nu6BMhqKrRpVzl6IOoark
X-Google-Smtp-Source: AGHT+IHVO5wimM5slpaHT4CVbe9EyUeTfCzJ19iOQ4bidzYzxZzcYOw7g3kEeDUEGQ1MihUItvwwDA==
X-Received: by 2002:a05:6214:5348:b0:6d3:f859:c849 with SMTP id 6a1803df08f44-6d3fac950edmr3429636d6.19.1731611658058;
        Thu, 14 Nov 2024 11:14:18 -0800 (PST)
Received: from [172.17.0.2] ([172.200.207.224])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3ee931f68sm8819986d6.122.2024.11.14.11.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 11:14:17 -0800 (PST)
Message-ID: <67364c09.0c0a0220.113cba.39ff@mx.google.com>
Date: Thu, 14 Nov 2024 11:14:17 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0865102360929523999=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: MGMT: Add initial implementation of MGMT_OP_HCI_CMD_SYNC
In-Reply-To: <20241114184046.1690311-1-luiz.dentz@gmail.com>
References: <20241114184046.1690311-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0865102360929523999==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=909735

---Test result---

Test Summary:
CheckPatch                    PENDING   0.24 seconds
GitLint                       PENDING   0.21 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.17 seconds
CheckAllWarning               PASS      27.64 seconds
CheckSparse                   PASS      31.12 seconds
BuildKernel32                 PASS      25.07 seconds
TestRunnerSetup               PASS      442.04 seconds
TestRunner_l2cap-tester       PASS      22.44 seconds
TestRunner_iso-tester         FAIL      28.51 seconds
TestRunner_bnep-tester        PASS      4.82 seconds
TestRunner_mgmt-tester        PASS      119.38 seconds
TestRunner_rfcomm-tester      PASS      7.63 seconds
TestRunner_sco-tester         PASS      11.47 seconds
TestRunner_ioctl-tester       PASS      8.29 seconds
TestRunner_mesh-tester        FAIL      6.21 seconds
TestRunner_smp-tester         PASS      7.02 seconds
TestRunner_userchan-tester    PASS      5.09 seconds
IncrementalBuild              PENDING   0.39 seconds

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
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in run_timer_softirq+0x76c/0x7d0
WARNING: CPU: 0 PID: 63 at kernel/workqueue.c:2257 __queue_work+0x687/0xb40
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Failed       0.104 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0865102360929523999==--
