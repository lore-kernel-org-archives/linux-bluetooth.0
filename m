Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495502D0C91
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Aug 2025 17:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756314318; cv=none; b=HjCpFbkIVhxyDK39NJSSC0WA8WsuhxFUskzVQ/8wR/M+ryOHuU4CEpAQeXQqABNza/Emw0zCHo4DKmweRLFacSJr7BtGDRPKA3s/y7lfGQZlYiNf/OFd+64/c7QHKnr4vuOUjaJnkX3GfMCvUYiSq2Xs71OIjJkJLIMYjU68su0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756314318; c=relaxed/simple;
	bh=UOiYWNHGwF3HQzR6F/uMprq/7yQQU5qtpadtgq4aJPQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dEBH3uUF4Yv55hBPvG04C8xTvmBigcexZhbTUrlX1Zm0Lx5q46dgdI1RFMEyNjA4ji1b9sqkoZAIiYQ8uoZX/lqlKD/gf3SEI4oJCUzdKEV3FVIkt5hhZX52sicg6hp6wvr+DP3I9KNNEtNGO5b99Obtx+TwYbgK4vUY5AtEoaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aRJVRacA; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRJVRacA"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-70de1230e87so1165416d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Aug 2025 10:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756314316; x=1756919116; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=twjivYKL2kR9r9ISN09IUSSdL6ph+APmfMgKhFSAzg4=;
        b=aRJVRacA5KI5YXRikYowhissiXoO+K3zUw7Zh0ewYESAbvk6o1vfTIU8KQqcxJVzI0
         3OoBiOJjeZd+nwQH4DQhm9uSPRjDGkWdVq4rUs4Y+xp0tYsHL4xCtqPF5byb7C/Okz0t
         QTxGqXJ3gqez7VUYSPCjN6nS1/ZKtWDcO3R0GRQHsYaKrrrX1F/DrEKqNFoksUeZZcmP
         CUXaJOA6PJsuYtnvG2fEmXgbdPATY2FK8qw5qcbbbqZ++pbmkb65vxFlS9lCwCgCb2J2
         x1fx8brUz02ql5O+yUZgBMUj253tjNHdrOe7KKSIk+oSYh5yeFiAA2kn93OqzNlboPh5
         j7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756314316; x=1756919116;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=twjivYKL2kR9r9ISN09IUSSdL6ph+APmfMgKhFSAzg4=;
        b=srkEFHO4whZ51AleVrtLWzCKJ3JWCFwsBAu/xef2Y3P7vvJdCMWegg+DVOziuhW4D0
         7WyeaH2ceJ+CaUBUBBl/KAYaeut3NqKnvk6RA6fDg9pqJEWUTyhAzo0S97bpn6YTZOqO
         gDj1wQm9JAlYAT8I8XhhsVatW6bNXd5EeUGKFufHYhyqXQVSqKzkIQaEP5zKPcQH7hye
         u5xpf+L4cdh3x3ZbYVYlwl/rzA//7XhDRpGTZ+D3t5n9HmNjsQ4KluCFUtkN6ZQV6JjG
         LoOSr4Gliy5OCBOZZKhgswuL3gkjmy+sIK+EqEzEDEzXX8W08XdqHHewD2LsSzguW8/H
         MVXw==
X-Gm-Message-State: AOJu0YzWh5ErIIbuUXJe2P+6y/anXKw+s5g8fT70bYDQHY2HeFc+3bC5
	FhVAC8Z5kWb5itJhVgTxU33ZhpjugQSIzTM3/gndZWDAymYKs0c2WqviQg/28w==
X-Gm-Gg: ASbGncuaJO01Q9elAid5ZB5nHAfcZt+DLceartAYGJrirmFRLpnOUgxO7h2FvgBOGZJ
	Q4dCbrnoELoKw9e4kJ4jiBk1u4scpvqFdCHeor4HDFuibHM9UnfsbqVTQo9KvmeONZzk7GScJ1C
	RWrOXjiQkIEha+U2Z6//Nlc0BdXWFCVnVY6+TUFlW9Ke6TPr+2PXNYizrIfovuYIN8qX/TmMoaJ
	xGrj42ETLi87KEWTvx6rLMwW0bDHKW1GeFjwGRPe/JxZYJPPeLMUP3qVIYM+rM1o2bnWVT7ph5n
	KvXErpYQON1mp5M0JRLla5egLey2a0IOO0xeSSD/KyR/DuPWdlikB4hfWj0YQsgeHSMOJL7jamM
	Od7TR+v965++gL/DW0lY52WkK+qXtvfezB8YwKWI=
X-Google-Smtp-Source: AGHT+IFjDouB5geqUJQWw1+s2fhN866Cr38vg79+t3xOsdbag6up1NbVugsmSeh5h7V/iORQlg3uAg==
X-Received: by 2002:a05:6214:1315:b0:709:cf54:2cb6 with SMTP id 6a1803df08f44-70d9728bc8fmr238889896d6.16.1756314315674;
        Wed, 27 Aug 2025 10:05:15 -0700 (PDT)
Received: from [172.17.0.2] ([20.62.207.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70de0887cf8sm16944556d6.25.2025.08.27.10.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 10:05:15 -0700 (PDT)
Message-ID: <68af3acb.050a0220.2ae1c8.4ebb@mx.google.com>
Date: Wed, 27 Aug 2025 10:05:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3641459116585795065=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, arkadiusz.bokowy@gmail.com
Subject: RE: [v3] Bluetooth: btusb: Check for unexpected bytes when defragmenting HCI frames
In-Reply-To: <20250827164016.363640-1-arkadiusz.bokowy@gmail.com>
References: <20250827164016.363640-1-arkadiusz.bokowy@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3641459116585795065==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=996151

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.21 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      24.18 seconds
CheckAllWarning               PASS      26.63 seconds
CheckSparse                   PASS      29.81 seconds
BuildKernel32                 PASS      24.09 seconds
TestRunnerSetup               PASS      473.91 seconds
TestRunner_l2cap-tester       PASS      24.67 seconds
TestRunner_iso-tester         PASS      36.71 seconds
TestRunner_bnep-tester        PASS      5.99 seconds
TestRunner_mgmt-tester        FAIL      127.25 seconds
TestRunner_rfcomm-tester      PASS      9.35 seconds
TestRunner_sco-tester         PASS      14.73 seconds
TestRunner_ioctl-tester       PASS      9.96 seconds
TestRunner_mesh-tester        FAIL      11.36 seconds
TestRunner_smp-tester         PASS      8.47 seconds
TestRunner_userchan-tester    PASS      6.20 seconds
IncrementalBuild              PENDING   0.88 seconds

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
Read Exp Feature - Success                           Failed       0.109 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.184 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.104 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3641459116585795065==--
