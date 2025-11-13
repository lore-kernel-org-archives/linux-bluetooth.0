Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFC42F39B8
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 15:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763048377; cv=none; b=UYTPpxaPskb7rka8aG7wOS5C3ZlrfYkgrOH748J8JR2YdjtNatWfi2u0x6uWKINmL9nGsjVtsArzWdWoFI+haWE/MDqMuIznJhUZ8LO+sxSY88ntVQAKjYZxFME4FBbV5lfiLuibUL03PXm+PKbyAl5dfjZLEkJi3LCCnx+SbTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763048377; c=relaxed/simple;
	bh=3GMtz6cR7CqVc5PMEjw75WicDwy17b/BrmrjeuAZOQI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YpWhgilwn1YyxWYVGpPRQIFRuWfRrLpD4/MmL5UWKrT6UqnJMDfyMmB5ZFvdUs+RUBR2ejTKrhJ607T/N/HgCi5s1tqTaRpyytbrG9/3LFivKSqdAWRFhsp7XTLp6xRROAQFWIXFsTdkzqkwFJxTkIAMSr9KSDdwbpMpfdEyAb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjgC1ngt; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjgC1ngt"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8b29ff9d18cso98256785a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 07:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763048374; x=1763653174; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LRVhHdkWScoDoXItu5tP4EyyFBEjhkGsPebLza4ev2o=;
        b=VjgC1ngtvY6/Guv3XHZxWm10/edL7gUv/vx8XgNot6Z1wZBrm++j+X+JFX2c9ugcFy
         cweFd4NTqotBtyQvgTooiTQqczE40c4w7JIYVrS7plnfKMHnDuGAMvLFzrpbHdHCuxs+
         4vAL32foJ8U6lvztZgPddXSlRgVpB0dkdNHlf7QziS/58I1XoeK30TGp+AHpGEvCg0xk
         u8Smr7/Pi2STt9oUkXlFbaJoMbMxDZnc6Co+F7wGaUSG2SoH9L2uKSsjG8DDD2Sd0xW9
         gyTuZTYCUCja1v8W7/q2ygeYeMzZoVLXA8zDjDV9dIpZpiRKMbftCU/C2NI548693RqH
         FULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763048374; x=1763653174;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRVhHdkWScoDoXItu5tP4EyyFBEjhkGsPebLza4ev2o=;
        b=dVNlct7gU7ukv5sgSfcJLihMxOuTdXV28kUOsrz10DIGXQfWQgL4T81n6W+B7NVqa2
         Ra9eO3kcwMydXNSvQbQMHvR2qzX0q4Cv7VwTU5KcExjqcSO+Voyjp4Li6t+FW2kLQ3N9
         aNMV93g2+VJkGdGeaU//BzjwL4c/dVJoUELDx6M15z2rvFO38xHMC9v48HQ9bPG4vRpQ
         1ke3dLkxhx0XUXddSJC6ZDgBMzx5ARdR6K3rccCqHjRl9bKaaUfnHTj5aPbyJiDDaieB
         tcA9brgCxne60QR//FQr6Aa74KHRZDyFTZn5KyQuWH4Rk74agWEdQ3eADjN7yrUI8hCh
         sgsw==
X-Gm-Message-State: AOJu0YzAviVNOAChiWj+AJ2+f/dqblMAKyXd2xzxXw2cl1XQEdRPGrbj
	gNgjshHyXkJ8Ww399gCC8Gp3+DINhCpAFbka9cxI/zswWgahwJ52xHIDLkTFTF0n
X-Gm-Gg: ASbGncuqPwnj8qaVaZgveQnbK21N4/nRk5BYwWl24FRJmTIOVLgWi+uFw/PQkUTePUk
	6ySVO+63ERZ9/eumXXuTo/DoR0m+66B/HV4vvLPzhHg+rVnJnzHCPOIKipjoUVLre5unvQzc8pg
	sKjAXoTGclodFAcqrAb+nL7pkXwTjI81kBfPqiDI7crwetnXp1TMERI/f08KdWzNNdqpMran0K+
	cM59cn0mZ2FuvCKrIybeLf5npML73ZtQMGiMKTKo2ilXGP+eFWX6HAKfStbUZKs3eGIBKxGlQD+
	pODPfljg4C6hxS283BOHeNhzXHK2d0bAgqfelEbzKDsGWykkc3SCK6185BCArhj7cEpvACzwDsR
	UyNWmS22Cohy7UcdKoxnyuuNxAvgxu4gi3T7dFViTAtGpgXR/3TLcyhfinQ/D0J/x7m5lZlDjQr
	YVas4pIfu5GMEXl5h5
X-Google-Smtp-Source: AGHT+IGPBGCETiSuQz4dNwg9KeRLyJSRbYZhh9/2dnrhuK8SkcGe45aypYeTD5vtl/5kjDOYBCZTJw==
X-Received: by 2002:a05:620a:29c4:b0:8a2:6690:2417 with SMTP id af79cd13be357-8b29b84c23emr888388085a.67.1763048373644;
        Thu, 13 Nov 2025 07:39:33 -0800 (PST)
Received: from [172.17.0.2] ([172.214.44.55])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2af0417e1sm149985385a.44.2025.11.13.07.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 07:39:33 -0800 (PST)
Message-ID: <6915fbb5.050a0220.1bde9e.4638@mx.google.com>
Date: Thu, 13 Nov 2025 07:39:33 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6380858625416517994=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: hci_core: Fix triggering cmd_timer for HCI_OP_NOP
In-Reply-To: <20251113151224.2598720-1-luiz.dentz@gmail.com>
References: <20251113151224.2598720-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6380858625416517994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1023033

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.83 seconds
CheckAllWarning               PASS      28.91 seconds
CheckSparse                   WARNING   31.91 seconds
BuildKernel32                 PASS      25.39 seconds
TestRunnerSetup               PASS      508.81 seconds
TestRunner_l2cap-tester       PASS      24.18 seconds
TestRunner_iso-tester         PASS      69.14 seconds
TestRunner_bnep-tester        PASS      6.25 seconds
TestRunner_mgmt-tester        FAIL      123.27 seconds
TestRunner_rfcomm-tester      PASS      9.37 seconds
TestRunner_sco-tester         PASS      12.74 seconds
TestRunner_ioctl-tester       PASS      10.06 seconds
TestRunner_mesh-tester        FAIL      11.91 seconds
TestRunner_smp-tester         PASS      8.63 seconds
TestRunner_userchan-tester    PASS      6.53 seconds
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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_core.c:85:9: warning: context imbalance in '__hci_dev_get' - different lock contexts for basic blocknet/bluetooth/hci_core.c: note: in included file (through include/linux/notifier.h, include/linux/memory_hotplug.h, include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, include/linux/radix-tree.h, ...):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 486 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.103 seconds
LL Privacy - Set Flags 4 (RL is full)                Failed       0.211 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.978 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6380858625416517994==--
