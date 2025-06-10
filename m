Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0702472A8
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 18:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749580803; cv=none; b=UCfC2DM2hY23ZuEganXLcBBa9OSLNHrwzhA9nFkJzDtGAEySZURY9mfX1LnuNzCobLPzWOEHqo6BnK6TyiZW6hdOe/buw9ZOjFPafp8PtpqKjuZTgfrZIwLeImqXfEkQOsK4wL0e8UdHVLzRgEwvbR8l7da/Ngr+kfjwg+EVUf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749580803; c=relaxed/simple;
	bh=xj+J3Hpz2p1gwdMzKVE5lwsObCAP9sshxPQmzuGqQBs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=uNLKsm+dRJZVC04qBjQDXCEaUW/PyIMuSevBo9Uz3RBMvMbC7QalGjqDxmFXJ6MUkvUN30Emk027ZX6aWOkI4mF6CvxIYQG1Qn4Qi+a9m08fEgbEksjEMzo1G0Pw7M6k4srTu7VL9tkwmSu8Or5t0rma7Ws0QCJsfay1L3JXIZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UclbAQD6; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UclbAQD6"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b2d46760950so5690035a12.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 11:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749580801; x=1750185601; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Fi9keVUMON5oaol9KVY52s785CJD0NLbr4KbhJ01ZOs=;
        b=UclbAQD6XaAIr9MjQJEe0DYxHwHhNoaa7IGG9+yM31ujicDf+CwulovT/JV0StDaLY
         yfd/4qJQTkLqU7FTaSyzZRmE0d/w4PLe2DE+VfKKZEgyvasDLkiHAwTjP983dSNA/fdo
         2xc8SWCPxbyBmFJZb6sXtZWZ0xdQTDE8KWoaElcmZu8uPC/cR/KyK2WZXitTaAzU5u8t
         nyShaoNQxgNRgfNPf93573gV8s1iaSblM5i/OQVDxZO59RELvZ7QW0iVcoWYjXj9Xcmp
         fEtpRoS4yBC9Q4ZH7pC4iU+M1iwkO/AE8rkjP2NvgUuaV+0gTLGkWi/CSXpDrzVf0qbp
         QbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749580801; x=1750185601;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fi9keVUMON5oaol9KVY52s785CJD0NLbr4KbhJ01ZOs=;
        b=q3ALZ35Q6MB+Z3EETO3b8h9z5puSbu+6iDB61b0qPSclUKQSsik7Qf7N1Ydnm4APe6
         qRqrgqbJMlYySsW7MEaXjeCUUTblwZrRtau71sNNf1YNGy7TyAexLUq+yNLWrWATc8/W
         gEte8yuh5d6VhmE8CpYdSM4b1lLA+GqKrDptHzZv9tUNqH3PUurD4vDegT3FEIzSE/gT
         7yfe6p3bbLxfcsH/I/X/Prj9LSl4hJtMZf24778ErKdgt/uazoNFrbANoiY+M6MuPdaX
         6FR4iWlxoEvx/rr2E+kGklduzVq+d/Oow3O5vZU6Ukt5gYHhcGQc1B8QT4cvAqK0FGgJ
         ry3A==
X-Gm-Message-State: AOJu0YxcBgdIZKMm1mdZROLys24un3owEN/AcRcD1fKOmedObrjDJL+G
	UmkVKAHl1/B+Z8yiYyON2Nb31DSK1VaJoMInR9EAEoIfF34qgnHat+dkHc/rhA==
X-Gm-Gg: ASbGncswuMuAFHeDZGDcFgiVm7jBAFUneFJ9bCNfTYutKh2PkiGvgCGKZrjO9Hbrc5Z
	G8tir5siXdWMx4kF7aqmVa4BjXfzdLV24o620C5mLftDPrn3kSaU902VRrBS/VwIxk1GeHQQ3Gw
	FXdXoAzcPS7MVpaONeV+SuSCH0w6VbSVugv8AsABEHhcvSPlV9MHRSGsqzr0T1EKD8dvDg08Jwp
	jkGCd3yhKsHueckZtgxsxKRsNUWNpKBbbvwGmDTSPBTb2R8tXNGCMTCEN/+bPvK7Hy2rIbqzhxJ
	TJ3v++jEf8vd38d5uiWP96P3PonTxtB3TpVloGnmtfZQV5vSQtOvDYjNZ66s0ffWLnY=
X-Google-Smtp-Source: AGHT+IGJv6yJ8edaVqWWsfjRvMbTpnNUh1QisT3TCh3emWu0x+XLqMp1dN/uczqLBIP8iZrgAMw0gQ==
X-Received: by 2002:a05:6a20:7f8c:b0:21a:ef2f:100b with SMTP id adf61e73a8af0-21f8671587amr935643637.24.1749580801020;
        Tue, 10 Jun 2025 11:40:01 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.14.35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b0836d4sm7731286b3a.85.2025.06.10.11.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 11:40:00 -0700 (PDT)
Message-ID: <68487c00.050a0220.196d02.613a@mx.google.com>
Date: Tue, 10 Jun 2025 11:40:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4707739431361564559=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1,1/2] Bluetooth: ISO: Fix using BT_SK_PA_SYNC to detect BIS sockets
In-Reply-To: <20250610180359.1133739-1-luiz.dentz@gmail.com>
References: <20250610180359.1133739-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4707739431361564559==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=970490

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.23 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      24.49 seconds
CheckAllWarning               PASS      26.78 seconds
CheckSparse                   PASS      32.77 seconds
BuildKernel32                 PASS      24.18 seconds
TestRunnerSetup               PASS      461.66 seconds
TestRunner_l2cap-tester       PASS      25.16 seconds
TestRunner_iso-tester         PASS      38.12 seconds
TestRunner_bnep-tester        PASS      5.90 seconds
TestRunner_mgmt-tester        FAIL      132.54 seconds
TestRunner_rfcomm-tester      PASS      9.31 seconds
TestRunner_sco-tester         PASS      14.61 seconds
TestRunner_ioctl-tester       PASS      9.74 seconds
TestRunner_mesh-tester        PASS      7.18 seconds
TestRunner_smp-tester         PASS      8.34 seconds
TestRunner_userchan-tester    PASS      6.14 seconds
IncrementalBuild              PENDING   0.70 seconds

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
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.204 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.164 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4707739431361564559==--
