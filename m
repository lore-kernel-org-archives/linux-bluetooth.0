Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com [209.85.160.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69941168BD
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Feb 2026 21:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770412867; cv=none; b=uiJ/3MWC5vS4HvgtQ2DKzHNCYapVl83rc7jaEKikkNAPRGAa16isNyOqg90HSx4csJybp4w13rnzFjpzb+wGvquWeD7Tb8Zka/Sbk0DbmESh79AL2CD/TO0fNBh3xYD5VXa9OFNIIbvIMTyAVGYWdOPzHxYOw+ck4X55+e/53PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770412867; c=relaxed/simple;
	bh=gVMJJvttNlbXRXq3KdhSoqAFltalcmWlwuujFdhKThc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WIt+ATr/YgdvmYnP83vIVhu4R3A4mLKMqSH45Kr/08eYPyaUwUKZZbBIqnLckjVaqEbfxoIlGxtFMgCkpyWjwhu/ejGbuTMhbjL/1fyAyO3aIaw5lu88xNMy4xcaJV0HQQt2fOi3iyv1l88VYmFqczKzoBYY5IAsin5+rHDH20U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QW9S655h; arc=none smtp.client-ip=209.85.160.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QW9S655h"
Received: by mail-qt1-f196.google.com with SMTP id d75a77b69052e-505d872f90fso21374651cf.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Feb 2026 13:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770412866; x=1771017666; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VIYhVG9gWSOT9fwewCwx3UWJsrKaYM80VwbjPViRgxc=;
        b=QW9S655hLJQj3X+Mm2jpEvwKypN1/FVra6q1YuN6ALAU4sGEA+PhAOe/EGU09EiGFJ
         LIMyHvP7u7THwwK4gITvz45of6WaeLkI+tCNlaJCE5IhDfheHUbsK9oAxldukdMDt0iB
         4UUJFjjkTTOIXUhH5aYgdChtFDX+N63GzJE7pWeQvRzuthajyRzayjs0beJ4GHjj7/0O
         SMksGZ0I/3ERpAbpCZjhm7d2/KQWAztiNOwxaLkfSrxtSVlcJwJ1PMOqbqbaYqjOgw84
         B0D/l3JU0UonaxIHSU7ZwOa5iaaj6GpMDzZB4OBfJaBX58gOwD/A2WI3T+IOJopwkwLe
         czvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770412866; x=1771017666;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIYhVG9gWSOT9fwewCwx3UWJsrKaYM80VwbjPViRgxc=;
        b=MNEFso4AFsoMF4vL2xud9oIQak0VZCkOAWSfV/Bm8PVN1yc1uqnEFPP3qrznBh1GRs
         0mxNPofZ0VLuzn2qgu9ysK7iIbTRMZBKzR3Xyf4+jfz9M4X5MI+WPFn0RxiE+9pUQFih
         PO45AApgxlD8jRRbQbydeRi4K3s6VCZ9Lur7SU2FreBV6OeZ25lz2d/GmSMzCCTpeVsF
         OASDBdxwNX7zRLUt+FJTnz5Gf9wgDaga6V5DwGSFBdJig4tFDwiIC12TR5ogddZox2Qu
         KFkp0/5UsdmIns9ekByCmAWCU8E6/3pQ5hT0ZjfUc1BG7KEbVnimc0NVj9To6AOMhPU8
         Xvhw==
X-Gm-Message-State: AOJu0YwFIfKf2vTUYI1TFMXYOmCOeu6zt/lCs+cPOVOEN2apN+4ozafM
	gIf+sTzw0cOFv0JzWKFsge83jSnVDiuoBluOJwdzXAXL55uYmlreOr3g2wGxVkur
X-Gm-Gg: AZuq6aIzeURCdwXCgFZ9d+L68Dh7cBykNC4RMyo122rIkdEU3aJxECI/Zg2W+BoFaSH
	+CAMwunivRj+s+D7D049QWtSOmjslwr2wUmyDzWgxhICy/SIcZTZDoHS7vbDVvTSYbokFs/47pc
	Ab1Vlb7u17j40/G8yqoLwaIT7MT3VbaMkyhEYsb+AZnJGZkgp9Ns7xULvJqCCaVs8KZivpOaAZT
	PNXBdiLZXRBtxKUYG0I9OjqsQLYuZieRUAKDNn9JldIO+R/PIXTlnhu4H/EZSH2iuSCk7XMTevq
	DQu08oZtPUnb6TN9zNRvQBXH2GHvFMIpGQkJJLb0Q2LVXUA8fIGjthJQf5LHihxWdQPy3aNfdiT
	YbOIWsCym4TJsbQSbMuZn+cdi0pYxCl/sEvq1TNQhNt+NWmBFXX0wwFCmFKxLD0Pop/KDcn+1mD
	nXLgv6iihknC8+gOTTpub7s31ao7dB
X-Received: by 2002:a05:622a:447:b0:4ef:c655:2ff8 with SMTP id d75a77b69052e-50639a29c06mr51633391cf.84.1770412866036;
        Fri, 06 Feb 2026 13:21:06 -0800 (PST)
Received: from [172.17.0.2] ([172.203.38.244])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-506392f2e5csm23710181cf.33.2026.02.06.13.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 13:21:05 -0800 (PST)
Message-ID: <69865b41.c80a0220.2d1aeb.a0d8@mx.google.com>
Date: Fri, 06 Feb 2026 13:21:05 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4263797017247286524=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3] Bluetooth: L2CAP: Fix result of L2CAP_ECRED_CONN_RSP when MTU is too short
In-Reply-To: <20260206204903.345595-1-luiz.dentz@gmail.com>
References: <20260206204903.345595-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4263797017247286524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1051752

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.31 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      25.85 seconds
CheckAllWarning               PASS      27.90 seconds
CheckSparse                   WARNING   31.43 seconds
BuildKernel32                 PASS      24.97 seconds
TestRunnerSetup               PASS      557.73 seconds
TestRunner_l2cap-tester       PASS      28.22 seconds
TestRunner_iso-tester         PASS      74.21 seconds
TestRunner_bnep-tester        PASS      6.40 seconds
TestRunner_mgmt-tester        FAIL      116.28 seconds
TestRunner_rfcomm-tester      PASS      9.67 seconds
TestRunner_sco-tester         FAIL      14.66 seconds
TestRunner_ioctl-tester       PASS      10.25 seconds
TestRunner_mesh-tester        FAIL      11.48 seconds
TestRunner_smp-tester         PASS      8.85 seconds
TestRunner_userchan-tester    PASS      6.65 seconds
IncrementalBuild              PENDING   0.60 seconds

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
net/bluetooth/l2cap_core.c:7737:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7738:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7740:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7741:1: error: bad constant expression
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.112 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.783 seconds
Mesh - Send cancel - 2                               Timed out    1.992 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4263797017247286524==--
