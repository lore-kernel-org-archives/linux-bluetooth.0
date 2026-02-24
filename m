Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075CF3A63E7
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 15:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771948380; cv=none; b=LyLEnUTQjDkdM17DWjPH5TlUdSnEyW1eOlsRoWkFdP/xBR3YudwmkzwMD2L6xyvXwghWA9MWyVs9RqTt2rI8HTyAM+SQr7Jna40e+9CPfbMXiQSXptIL5ns6XJZHexw62bH4qqO+6PsVvu+1pa8iuNGknzfo/rsL6tjAbyT7eL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771948380; c=relaxed/simple;
	bh=pO4WQnFJ7iXC4D7KUun513KlcG9kSI3oEqH7cDKDtqg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=AwE2KnFhTj3/vs5TFrpMeTg34A0eOdNiOJuoA5zbw4/+czvkF376OHnx3wpB5SXm8bN9gGTbPDUaqImA1UBV6TQnG5Y6zEdk1FG0vAOpNlDa3U5vobu9zLKqXw5TwPOH3OlYO2rdvoUUiNpP7dVK7e8EN+l+f52OJnOajwWkqiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIguYtzq; arc=none smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIguYtzq"
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-895341058b1so70967326d6.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 07:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771948378; x=1772553178; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rgY9Zyajt5FsLaHokcunBJEYpKmEpBc6eyYJGt8kLH8=;
        b=QIguYtzqfu+RujXR0JvbM7jDFX1F1vB/0qk2fFG8er2bzHWaKkJfL/WBB8yRtrwGkD
         PpM9ljOzF3xQLRKitMRM7P0bQznh0V4HuQi+d/whXiTyNKauUAQuDlvUjVdqi5rMKzuC
         YixB3c2l+f/t51L7WFjKH3rI7B278YBfrsU2a+xxvwo+NGG8jNBH6RwSLBCgnsCzdEoW
         RQ02+QviRtxsu36n0uIVvNcMbQ6eMvFrCTe00hc1HPseQNlibHsSosm5d9WIgkgGAK/E
         90jrXZ32W52ALoYznnYqhm/qiAjWn/NM/zVz4hTg/tC9qFv5SJiyqTHslzROPoOyS3DH
         bOQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771948378; x=1772553178;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rgY9Zyajt5FsLaHokcunBJEYpKmEpBc6eyYJGt8kLH8=;
        b=Gy4NMJboUON24RnaGFUSJaGp1qZIq9GpsHwXsaL6nPxx7zqjBKSBwOmQFDj0BPMzTo
         vXTkRkWvyqejnfIQW8LX9UXUbBUndtwdczCWuJA9J4gI7088zVWsf4YBWyZV0jbWg1QS
         3/a4qhabtY9eF84HzjayqEddGJpqCFIhYW1CtBP2kvAlwUEA+eSmTzoWuHL2Jitpwv4D
         km8xVn5tWDWbfbPdsRC9q8LkVlgySfEfy/FW8Fa4THwPzjyFHihnzdnHLikOLXCoS6+u
         uhXoZxTNdKyQnYe+QwvyFzA7Wfqb1bhYNfWm7pq0oP0+HT6VciRWNtglglLFPyq8EK7a
         OJ7A==
X-Gm-Message-State: AOJu0YxG8HgLODtHtjIakc7djvSqjB1USiYGcDevYGcr5xRFQeXA8cXr
	HnZXiXMS06dpWT2erKkQ7YAf2QV8cq6otdxLpstR9q3KiTTzjSUjOCSPGRjTzgs4
X-Gm-Gg: ATEYQzwWSQjEyq0LFMFUuWAacXrujap8bmbvrd+tDInFotlhh5wX+EtVDl+nctkRZO+
	SF9SNN2Goinv3N2kCIFP3N3jpfjONDPztikh2qr5LtvuKf4gWqdsPU338rWUTJbQayMCww9a6zk
	7LMjZGIkPxmXdrtWK347y2yUUQeOGbPRC7jzweE0/2iP0iX/9M8H9HPigf1TdGnhnMQnsosjj7Q
	1/NKWG9qhuJczZMrE4Ceq9KSDjk8N7N985OPUTidqQi8yGYWjunDewe4cv+Egb37+BKsFj+MI7m
	W7asfUKeob41ddpIgTdfc0EqVNV85BxSBZv++lJJUV8EVdDRuP4jKWOuIxu/HD/CE1ny1pxeueQ
	C58IY0UuDG1TYglucRIOVjqHpAZt2XrWXOUSVm+70EIOIVF6VEXbJ0tXTyZt8IQSuZ0Ja4XLVMt
	dG4StdCjBs4vAg1s1eTI5Gi9hjEc1rrcnkE3udZ74g
X-Received: by 2002:a05:6214:2463:b0:896:f767:9673 with SMTP id 6a1803df08f44-89979c56443mr189930926d6.7.1771948377688;
        Tue, 24 Feb 2026 07:52:57 -0800 (PST)
Received: from [172.17.0.2] ([64.236.153.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899a71b28d0sm20297866d6.49.2026.02.24.07.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 07:52:57 -0800 (PST)
Message-ID: <699dc959.050a0220.4ae31.8faf@mx.google.com>
Date: Tue, 24 Feb 2026 07:52:57 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8904235583545094912=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v2,1/9] Bluetooth: btintel: Add support for hybrid signature for ScP2 onwards
In-Reply-To: <20260224153449.193551-1-kiran.k@intel.com>
References: <20260224153449.193551-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8904235583545094912==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1057282

---Test result---

Test Summary:
CheckPatch                    PENDING   0.45 seconds
GitLint                       PENDING   0.32 seconds
SubjectPrefix                 FAIL      1.06 seconds
BuildKernel                   PASS      26.10 seconds
CheckAllWarning               PASS      29.57 seconds
CheckSparse                   WARNING   32.30 seconds
BuildKernel32                 PASS      25.35 seconds
TestRunnerSetup               PASS      571.40 seconds
TestRunner_l2cap-tester       PASS      28.45 seconds
TestRunner_iso-tester         PASS      86.63 seconds
TestRunner_bnep-tester        PASS      6.36 seconds
TestRunner_mgmt-tester        FAIL      119.88 seconds
TestRunner_rfcomm-tester      PASS      9.43 seconds
TestRunner_sco-tester         FAIL      14.50 seconds
TestRunner_ioctl-tester       PASS      10.18 seconds
TestRunner_mesh-tester        FAIL      11.51 seconds
TestRunner_smp-tester         PASS      8.56 seconds
TestRunner_userchan-tester    PASS      6.67 seconds
IncrementalBuild              PENDING   0.51 seconds

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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
drivers/bluetooth/btintel.c:3867:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3868:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3869:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3870:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3870:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3871:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3872:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3873:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3874:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3867:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3868:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3869:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3870:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3870:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3871:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3872:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3873:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3874:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3867:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3868:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3869:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3870:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3870:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3871:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3872:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3873:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3874:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3867:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3868:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3869:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3870:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3870:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3871:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3872:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3873:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3874:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3867:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3868:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3869:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3870:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3870:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3871:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3872:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3873:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3874:1: error: bad constant expression
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.110 seconds
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
Mesh - Send cancel - 1                               Timed out    1.828 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8904235583545094912==--
