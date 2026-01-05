Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AB3273D66
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jan 2026 06:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767596071; cv=none; b=Yg5Wd4Gh3uR1gaFmzZ6tPUQ1P3GnYZ0TAbw1PW9+QCA5zNf5gQchDU5C6Gm6541QCCE77mTHdNiQMt8epGip9CHuRrjx3GswcUS6PQwiCjpjyoXBldr6eRIMIu1DaMDUlRch+ikO6KFD5eWMyuaUhRoVXDn3i7dbSVTh5y/fPTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767596071; c=relaxed/simple;
	bh=tps7KzwrWA3lcvJh1aBdHW6eM4H6ZX+gWhaXL9n4ilw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ksl10hvxdsnIto1TW0zu0sodWESDzCLAEjNKv/EtPZTK+5I5SeNh43ZPWIbt0he4Z1aPwAEU3LGn3XiS5gCTS8HAGdKyw5fY2y1gr3wRm09WFC1cgSZHk/kXTBGhNdcfcgVDEthmu9sUh7RBoVR70DUaLppxGfPo9UUQcOMHpGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DsYhA91K; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsYhA91K"
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-bf5ac50827dso8842001a12.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 04 Jan 2026 22:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767596068; x=1768200868; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uuJIS624lB8mDh+dEgSLO2jTKO3ufHGYIxx9kOVm4sk=;
        b=DsYhA91KkElfKRCTUPhb6pVxrhLwGviyfh7v6Cv+W1BIIhFR6sbKkGgaqOR3eVdKqn
         vycVSbhOa5AJ5mtn8USoLuBo3PtkqVUjYvbr/BcwG1LjNfWwfrVhTDvuIfTK5Nnls/Qy
         N/FKIvZtbrwfe9ZrZaOlAZz2O/Za9wK/558qmEpKNYKZKAUXPzlE09y2FFfJTX9gZlk0
         pfVGRcX/3RfyoJlyyg+uZzSAllLU09pVWoVspbDyDJEJVotipjTSPur2bBh0asdiM46w
         iMWkyaPEytMegnXRwoMORhq+pkQlQRHfSqQAtGo9pmgH5McaV7qmLpahagXUiJTfVOTx
         oU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767596068; x=1768200868;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uuJIS624lB8mDh+dEgSLO2jTKO3ufHGYIxx9kOVm4sk=;
        b=aVsPU1QX2mX0whtVawdL7mLwb5GsY9oMbs8RFeUoM+3FhDQZftg2F9fyHwOAQIXG04
         QunNtTUnAW8HOLIL6/yWaE2GO7CrJRdkFErAvHe+lzJnm2AVjudCuip4K+qskfgBn7tE
         UKaIsOQ8V83r9gWr7d+vpNsZACmWd+/hCnOy2a1jMp3tzLZGmAqcK76WpzwEw7QfMEmz
         FVH8BG2d2XIhmx01BETvIF+tnJojaGR58gKt2QKz/PJlx6oqXCKhscepOdegQlSSTXk2
         T5g/JlAzmyHNPgHk6VTNK7j/5Jus+LMSmRaFnMYkSeBXvBYKCi4gRAxczYH/9GOIN2lW
         jtRA==
X-Gm-Message-State: AOJu0YxpuA+saM3mmG6JcKEwMmf6tK5HClH1nAqAHSbibC0u4PQzwdG2
	6FDUyadSPWyCXszywPNRAeDfPM3eUibXXvWg+jcl5oV+QOpRt8A5wIMsEzHGxSPr
X-Gm-Gg: AY/fxX6o6p+PPDzYYehIRRM8Ej8+j/3WnZkZl540nrvzxfY8XC6vHovFn0A6FgFQdXA
	H9WYOxOaSFwaXidSzor1gs8K1vEscqeTM69ESINwiy4sRwwoCWdQWicnx6RYFOhhWr6Uq4AnqpN
	Dt7/1gco1Xq+/iljvOH3F2NWe8E9t/AxbTNa3vKJW6gNDGaU0/umE67bHOQnDwkM6x3r2hmglBU
	73b3sVuXunYGdYRh3H/tb30GsKivuq3vr3FtTkfZnCJBUqHLUCT3nTUPd4hqJ3KNBwxOHUptLdc
	FI2vLncldE39xhiUjqqfcahUxPHmBVLCOUWbsz8brMxyethU7VbtyqAjb6TXCE8s1H/RomohyWt
	/zNIFCNHs6ZmsSvl2FG9AygP4s9A8MrK8Ozshmd05WJLQ3jQbykUFNoAvdrgOmO+lW74hoOPQp3
	itCK8dwNEH3NHn6Ejaig==
X-Google-Smtp-Source: AGHT+IGZtTPJxyDigrnQrPJhKohcwbQ/hyN0NylyoY3dPbRUYNZKwA2doc67MgQMFeBqSNAuOO4k8w==
X-Received: by 2002:a05:7300:de48:b0:2ab:c279:9dce with SMTP id 5a478bee46e88-2b05ebd0d75mr33321403eec.7.1767596068284;
        Sun, 04 Jan 2026 22:54:28 -0800 (PST)
Received: from [172.17.0.2] ([128.24.160.163])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b140c42e8bsm10897347eec.26.2026.01.04.22.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 22:54:27 -0800 (PST)
Message-ID: <695b6023.050a0220.52245.869f@mx.google.com>
Date: Sun, 04 Jan 2026 22:54:27 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2283533459281885582=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com
Subject: RE: Bluetooth: btqca: move WCN7850 WA and add WCN6855 firmware priority selection feature
In-Reply-To: <20260105055646.3816296-2-shuai.zhang@oss.qualcomm.com>
References: <20260105055646.3816296-2-shuai.zhang@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2283533459281885582==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1038335

---Test result---

Test Summary:
CheckPatch                    PENDING   0.42 seconds
GitLint                       PENDING   0.36 seconds
SubjectPrefix                 PASS      0.15 seconds
BuildKernel                   PASS      26.20 seconds
CheckAllWarning               PASS      28.28 seconds
CheckSparse                   PASS      31.63 seconds
BuildKernel32                 PASS      25.72 seconds
TestRunnerSetup               PASS      565.47 seconds
TestRunner_l2cap-tester       PASS      28.97 seconds
TestRunner_iso-tester         PASS      112.97 seconds
TestRunner_bnep-tester        PASS      6.42 seconds
TestRunner_mgmt-tester        FAIL      134.85 seconds
TestRunner_rfcomm-tester      PASS      9.88 seconds
TestRunner_sco-tester         FAIL      15.27 seconds
TestRunner_ioctl-tester       PASS      10.77 seconds
TestRunner_mesh-tester        FAIL      12.80 seconds
TestRunner_smp-tester         PASS      9.16 seconds
TestRunner_userchan-tester    PASS      6.83 seconds
IncrementalBuild              PENDING   0.99 seconds

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
Total: 494, Passed: 488 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.116 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.196 seconds
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
Mesh - Send cancel - 1                               Timed out    2.684 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2283533459281885582==--
