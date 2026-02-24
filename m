Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928671548C
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 00:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771892293; cv=none; b=dX0zMvFtNERPxTwAjVLIoY2zzC6QLd+mr6SAlHbu/MeX0k11CbhxA1nETtNo1w3Sd+9d9gMOBwrx1Cf8yba9/+TqMl4+0UrxLsdGo6E/+FsmVEvuIWu4EReUIy/TOvRDfb1itCHIK71BWuIN01Z+974WAxryVhYLKoBPEcyDQR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771892293; c=relaxed/simple;
	bh=FDNH/cRX08GBwo1n5UPkbZYyzIT/fXrWniKexa8uCRo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=L+vWmAVMCLr/ZQnNnWrZ9NTql7htIZCa4fZJW9iewg9dnVke8/N2kftmCn+Edv5Hznm8RrBPIRYmBgyAsQSJRLVPqK6Xhe/6mC63iLG4I8unNnNa0F0phQ1TVbrlZ7BarF62E5FBU2bQXbQnxnCO+g3gi1Jst7Nr8igAUjpQXmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvX/IgJn; arc=none smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvX/IgJn"
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-896f4627dffso66688336d6.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Feb 2026 16:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771892291; x=1772497091; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hhfcVFZUynCfub1WOU3JF4N3LJrNy2flUNaZwvNMmmk=;
        b=EvX/IgJnIl8qs8iEmOopiaAm/ZIQWCMy1SLA2wHMEo2Xe+vaCaboojtmNhrVL9zdGZ
         lIO1/g/05ivHrDQQbW9FtdDfTnpMRMzB4JgqotsleK500ootvVxhtRLCDlDq8ZVx4NHJ
         A2VeNxsaf3AsSuLkNmZocZkrU1l1lIKZUPtNzdadOWwkU0zti1WCv/C2Dftq0FA8HIju
         +J2B7BbWQWRbB/2WmgRa2o0R89Qu9ZWuoi1vJDB/utH982s8gTfr673J6SkI0exnQW2M
         +mmBQ8Ci6WkhjlYA4fifF41QJfePqilmXBi89ZENVc+CvbVp6tdsJ0tsZ+RX6DHBhQUV
         UxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771892291; x=1772497091;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhfcVFZUynCfub1WOU3JF4N3LJrNy2flUNaZwvNMmmk=;
        b=rQ27PvZuauMP38xH5KbHTDlxukGp2zDHnOTTdevtkn1kQklHC328LST9tNqzY/dtHG
         AS7pOLgpwi18g+z2spU79U0v8jOLqB2sWwwZ1jhC408oaBGW3QgYMUv5hVqh48KZHsys
         PYCeYpnXgzf4Abu3qKPds013d/EArmmK4A460PpvNSPLCU2H+b1t8Tv2yPcAMo9SdkFF
         FyFRu2v353zZivNjnLe+oe2GtR3i4GeWusHxLV+QS5K7To6We1kiCULHzo/UGU+5ZyFh
         tcnHLrfeRzp+8ZHp0w0kP/XqIVlkZ7iPX7zbqEiz8+81iqDyI790H17PSMR/dkDaYrqv
         wIGA==
X-Gm-Message-State: AOJu0YyVuA93ksI0KcY8pZuKHKBJymAvRF3T6K/InJ3tW94q4F6aMNw1
	ToFSaEPlLewtmbhK1rTmrCBih9F7tHONhMHrES7NcIOFbM0W6EWF6Mutv2B8gbgF
X-Gm-Gg: ATEYQzxpApdvzdlPU6o7v6QMpykKWgVCzbhXE/tqpXEDbJsXhfFbIqCYveAFZVKVcZ/
	IwqU3pEk0kSYDzQUjq/6f5Oj/myMRScbllq2P1hWkt8JzhssDgpjbob8xwTU2cUBv49tOZ3mCXr
	0J0+sb3Lzb/YXYQOccoKhTj4NmWuJ5xh+EYLe1NlDeVZnrfz/mnpwdPfQ44RlzLC0l2wbxtlb5b
	Ips+4gr4LMQpQkh2oshyw2K/KHrqPx9nhZMXDF8SDfit0fvO7H4yDdmt5sdUS29/HyUjr6zibac
	WVM56bxSFQflN9FFJFp6cMrGBI8Xw55P1GoYTw+wfKsQ/YdMlJ2NlBysP78w500uX0sPifeVP1a
	gf72Tk9v+uFKP6dX5+21HTTcVIsMJZitYXNLInbEfzbNwheS7CW9L0OoOa6KHfBAfe9OCQsZ2mY
	KPc+FjtFULpGipS2S/AWWWoIiqc5K9
X-Received: by 2002:ad4:574d:0:b0:896:ff3d:18d3 with SMTP id 6a1803df08f44-89979c74aabmr156437136d6.23.1771892291210;
        Mon, 23 Feb 2026 16:18:11 -0800 (PST)
Received: from [172.17.0.2] ([172.172.87.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899a55a1b05sm4420296d6.14.2026.02.23.16.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 16:18:10 -0800 (PST)
Message-ID: <699cee42.050a0220.22548e.5774@mx.google.com>
Date: Mon, 23 Feb 2026 16:18:10 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7074022310146396126=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, thorsten.blum@linux.dev
Subject: RE: Bluetooth: btintel_pcie: Use struct_size to improve hci_drv_read_info
In-Reply-To: <20260223233341.426067-2-thorsten.blum@linux.dev>
References: <20260223233341.426067-2-thorsten.blum@linux.dev>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7074022310146396126==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1056905

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.28 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.71 seconds
CheckAllWarning               PASS      28.26 seconds
CheckSparse                   PASS      31.34 seconds
BuildKernel32                 PASS      24.94 seconds
TestRunnerSetup               PASS      555.80 seconds
TestRunner_l2cap-tester       PASS      28.49 seconds
TestRunner_iso-tester         PASS      108.08 seconds
TestRunner_bnep-tester        PASS      6.34 seconds
TestRunner_mgmt-tester        FAIL      117.06 seconds
TestRunner_rfcomm-tester      PASS      10.04 seconds
TestRunner_sco-tester         FAIL      14.47 seconds
TestRunner_ioctl-tester       PASS      10.26 seconds
TestRunner_mesh-tester        FAIL      11.53 seconds
TestRunner_smp-tester         PASS      8.66 seconds
TestRunner_userchan-tester    PASS      6.78 seconds
IncrementalBuild              PENDING   0.76 seconds

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
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.105 seconds
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
Mesh - Send cancel - 1                               Timed out    1.822 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7074022310146396126==--
