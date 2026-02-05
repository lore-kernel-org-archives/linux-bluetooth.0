Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B8A32E758
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Feb 2026 20:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770324597; cv=none; b=dmOTgWZwUPIMXAIsSY0vRhCT4xYD5QMHGiPnLynJlycKnYlnenzKjQ8vvwBybelb9o3ohmKvESdEFJTtFZjpOH0HFWstWezuQW0S5QQEh/1Aq7zr9Sl8vzT6Fb081OtH5AAktWI48tUil2Lhxyg7480cwn4nTHfnnBpIF18qAyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770324597; c=relaxed/simple;
	bh=/VDgU2HDUmdLvpjfpTofepHDQfa9MgYER+y6YIK14LU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CNkiEvyayFET7cfJVN3cRGdPCR/DC85O01hgv0t7icgqJbWdB66/hGLQcV1EEFTWkT4RBEK1TXkLGM/bYnT3CxpDgLq7tMCkgBV9wyeIT6mfpezg3DY4tvNKPKdwrMih+4DxnOSo2mlTTjcFhLBoe56Bi0IMQ3V4ouUALYRi9Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DG6w3Ggb; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DG6w3Ggb"
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-1249b9f5703so2215492c88.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Feb 2026 12:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770324595; x=1770929395; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EkfoBtxwNSYseWrgb0Nr7x5dY9eoo93OqJ1tGTQRGbI=;
        b=DG6w3GgbkdYCwmVEEPTeG8cXBGeXfuk+rVaV6dH4SZzDB6HWpDvIkKQlcdQOgUUNct
         KRjlBaEwRT35Ko1/+FMDHQhVQigZlYUvYXjObvBY8b7xNwj6HuwS2I80qalWVjVzkVBE
         KOK2L+8RSq1+YueIbrLI8krbiTgj3oRp3oTZFk3LCoEXjM5Xz/CMYvw6LdUYvlxzc8N2
         VUsTIBiKrjSLpOU2WyyZs/CvzElQ1K2MygoQ4+HUsIwfXbI68j1/2VuBpK55xE6Dx8UW
         GTdHfVX/0y8Sn1vxyX4Qex/+G1rfRMIZxDKX0Y5brExSZ0wmpGjqgu90oNDvg1C51S/n
         TYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770324595; x=1770929395;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EkfoBtxwNSYseWrgb0Nr7x5dY9eoo93OqJ1tGTQRGbI=;
        b=o+tsEO/YzzccNGwJrP2Y840sAj0U/dvH5NtxEQhGvlXCamrh8U9ypmV2mrWq3rHLAT
         RHDz2752UOU7b5xw8n3dRkh/jx4ut8cZZbddZR5msFIja6S/vDq4FoiHPW+0ioDk7BSl
         vEARv6lT8KxVgPCePT+6BPoaicnnrXiGglAX3wY+/3ZbDGl8X3+BadI79w0NJsW1xO3a
         /CXJ6dGcV9ROMbEVzpG4xkZq05UFwS4hTJ2Ss8P5/CI6Q/eV04wPuELlfEd+vb/h87Hq
         Nq97Rs/NsQMPFGw2VkhcIZ3ou+SZMlTA4jf/DncoKhLJwdBVstYL9eAw7Bd8TNr4HbQg
         F6Kg==
X-Gm-Message-State: AOJu0Yxu5ZgLKe/8QIh/HD36DQ23QfIeHR6PwpnAvHn7llTRULp2a21A
	BQxCwIfDOvSJfNiVf2Mmmp6j87q94KHEocfKbd/eMPL+2Ri+OluWiYvS7C3hG8aJ
X-Gm-Gg: AZuq6aIISDU1vo6ilQCuZXfQqUL3rLsswA1uTphlbPSQn9UAMWeTtvNt9NQaLmw3RKT
	CwM6uhBom54OkXNBxYrP366peVudowfZOfJm1nUZNiEsCel3drqaPu4i/GsoFFd8VjZy7LRmFU2
	8PyIHJVLCeAUrzRoB/dkrjQT4HMbTN5REFgzgr4vvrcPQn9XnhWFIpVLcZLyHEYQI5unovYy8ct
	wdahRKh1aUfhYzUgUaM1UOIWuVx5F1R8qngr0Lz56eK8ZexX51OBbRdCPzoxep33vXi9RK5+SnQ
	bi7JOUM0MvR8dEPbIb4brjvIBcGCj6ElPqTsO/oINR3iBFIp6ggYmRzkwl2CQmZd/syeLsTECuj
	Tmq/30MmvXqR9+KzME9DR87zVf70SI7AifdWqh+v2LR+a9x7Ix5P+XfuJW/uMjf79aoqggmqSp8
	KZWU9aIOkOx9T1uaz/+w==
X-Received: by 2002:a05:693c:3007:b0:2b8:711:ae4f with SMTP id 5a478bee46e88-2b856463106mr192869eec.9.1770324594924;
        Thu, 05 Feb 2026 12:49:54 -0800 (PST)
Received: from [172.17.0.2] ([52.159.243.197])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b855c8ea5dsm401734eec.34.2026.02.05.12.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 12:49:53 -0800 (PST)
Message-ID: <69850271.050a0220.9a330.89af@mx.google.com>
Date: Thu, 05 Feb 2026 12:49:53 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8502456585957565519=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: L2CAP: Fix result of L2CAP_ECRED_CONN_RSP when MTU is too short
In-Reply-To: <20260205201838.58998-1-luiz.dentz@gmail.com>
References: <20260205201838.58998-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8502456585957565519==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1051297

---Test result---

Test Summary:
CheckPatch                    PENDING   0.64 seconds
GitLint                       PENDING   0.33 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      25.96 seconds
CheckAllWarning               PASS      28.41 seconds
CheckSparse                   WARNING   31.47 seconds
BuildKernel32                 PASS      25.15 seconds
TestRunnerSetup               PASS      561.58 seconds
TestRunner_l2cap-tester       PASS      28.36 seconds
TestRunner_iso-tester         PASS      77.80 seconds
TestRunner_bnep-tester        PASS      6.30 seconds
TestRunner_mgmt-tester        FAIL      119.31 seconds
TestRunner_rfcomm-tester      PASS      9.48 seconds
TestRunner_sco-tester         FAIL      14.51 seconds
TestRunner_ioctl-tester       PASS      10.13 seconds
TestRunner_mesh-tester        FAIL      11.78 seconds
TestRunner_smp-tester         PASS      8.60 seconds
TestRunner_userchan-tester    PASS      6.79 seconds
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
net/bluetooth/l2cap_core.c:7735:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7736:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7738:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7739:1: error: bad constant expression
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.104 seconds
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
Mesh - Send cancel - 1                               Timed out    2.080 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8502456585957565519==--
