Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8E822DF81
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 20:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744835726; cv=none; b=TCO0t7u7T64ALjVgBVviy1+Ioh3DBH3mtuULEiUWghiAyMPQWAn5OSq64u73mMjKZBgQK9P1QNpndz5WssSGpp6ZeytR43JTw4oHhxoukcFfyGDI4oUez6v8jQs7n15/mkXijDdaKWAWrdSAy5OE5Hp3ETzAUMfjfEgxnYRaRVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744835726; c=relaxed/simple;
	bh=aIcD9Hy6G+gxvl0GkfaIrXxk1N+X8Cx1QGNff1r1MYI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=kPH1lyqv0oJyBcLdOStOfI5+EY3vOze8rF2yUNpBZI2/IGZnEnyD1CakEbyYecVdxs+uTxEg8JMSSSg52fKAUfXJWD2a3pI488wM+R6l59EIBZW1Q7aBYzTGrHIWyTfTIdSuQf+/LUwiXJjO84g3fRT2oOqC2Ush9YGImKsFCE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CuvsXxuD; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CuvsXxuD"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-603be85490bso6734eaf.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 13:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744835723; x=1745440523; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4NSPNY6wM6CvGEuHXAVMbnAkfzNvC5+MGYwPQechppM=;
        b=CuvsXxuDCc2x1j58wAJYCc62AkJQ+mfivz9USuszYQ6okKklUZp7FEJ6iFHlEIlbAA
         mqBzpfJbjjtrajSb/MfbRk3D0UIs3fXxIg4w9XFYy/VhmYzDfYiR7eif/zLpzqaJyWQ8
         gExsJH6n6yq7HPlpdq1c6tf+NxHHTB+nbAYhLud+c+QtSgNAk0C77effWAQekuHtLbvy
         EIUCJltD++UQt8FLCU7IeMgwpsjLHVjSX6cuCxWnhMbWlcIOvV/Lxl1YKlmjlXyhszIJ
         GzAX+vHZvKGW1ENkcBwJxNc1rS43wRSjSrp0FvUfp1d46Xxh9O/zcBjjkaJX7WGsdKjx
         3flA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744835723; x=1745440523;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4NSPNY6wM6CvGEuHXAVMbnAkfzNvC5+MGYwPQechppM=;
        b=IzVDotq7bmPY1+3SdsllV0Hhr1TevKTpk7151atVBrmh9R+s/SUWJeaJ5EofVdLQd1
         WLs9o94BbY5e9mFwgbyvQ8I3oLSz7TZ5K9vMGCQb01hthDEcHiJYgiojw9fKu3Fk+raa
         IerCpDA7EkiJoWUE3jehmJ3u4SVKJvRZFZn5FWoxMO+rFquD/94sQwLEpT9Li4X172zn
         CUIZIL0fsi0Op0FdpgRzgesCGzehYxWe4llfF3pog7oZGN8bce5zoFcBHQqA3TdiLmGS
         tpgRWKGkwfe4Yg81LXALmmCAqgCTeG5/JUVMNR3K64cHtThZX0qKSuAmfPSlBi/DrA4s
         iwjQ==
X-Gm-Message-State: AOJu0YyMV64Zg/otCoOUHy3ftZ5j0OYAYhkFBptTB26Bssautc64iy7z
	PBXBTGVy9BBWG/9zbDg+R6R1ZCDduHlOhfubzxMFZap1iUpqfSvp+CZ8Dg==
X-Gm-Gg: ASbGncteHtlGDlpYQ9wfC6G+nCnMXA2RBURLE//aRxFjGgIO+RJuaNKgGgHB1oITrtV
	3QJN88VDUG08tx/TVo7jZNugUItq6ICSNjG+vyjrt7b0gjjt1g74FafjTexyEN0KGjVeuPfgIVx
	5GKrrv4qMAuFn8t3kOGOeANUn0y/0FpoIR2CYNVjMnt+pgp8A6uiqdc7hGguf+wwjXggufnz9ov
	UlCb1DBPNVyE8p3K8pktAqjsDW4LpQqfZLBnA18oq1if8lHWXwW0LmJOC+xJjJa4H9Hc2BDynnI
	k3CuwBnQv/kidGlzHVboYewRnPyI/3xpvXE6MWfpTvW3PEs=
X-Google-Smtp-Source: AGHT+IHtEeXy9Uw6F9lEwFs0DaGnE5axHs0FWtmdu81vcZtyEnS4e+zLX3te4XIifqQFw8MBzZ7q4w==
X-Received: by 2002:a05:6871:a98b:b0:2c8:340d:1076 with SMTP id 586e51a60fabf-2d4d2d4cfb3mr2246352fac.32.1744835723541;
        Wed, 16 Apr 2025 13:35:23 -0700 (PDT)
Received: from [172.17.0.2] ([23.98.188.164])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2d096955205sm3449848fac.14.2025.04.16.13.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 13:35:23 -0700 (PDT)
Message-ID: <6800148b.050a0220.13b7f9.c9b4@mx.google.com>
Date: Wed, 16 Apr 2025 13:35:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0030123803045306241=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v5,1/4] Bluetooth: hci_conn: Fix not setting conn_timeout for Broadcast Receiver
In-Reply-To: <20250416195526.1989143-1-luiz.dentz@gmail.com>
References: <20250416195526.1989143-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0030123803045306241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=954159

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 PASS      0.39 seconds
BuildKernel                   PASS      24.81 seconds
CheckAllWarning               PASS      39.30 seconds
CheckSparse                   WARNING   34.72 seconds
BuildKernel32                 PASS      25.04 seconds
TestRunnerSetup               PASS      456.94 seconds
TestRunner_l2cap-tester       PASS      20.81 seconds
TestRunner_iso-tester         PASS      30.51 seconds
TestRunner_bnep-tester        PASS      4.70 seconds
TestRunner_mgmt-tester        FAIL      125.08 seconds
TestRunner_rfcomm-tester      PASS      7.76 seconds
TestRunner_sco-tester         PASS      12.52 seconds
TestRunner_ioctl-tester       PASS      8.29 seconds
TestRunner_mesh-tester        PASS      5.89 seconds
TestRunner_smp-tester         PASS      7.15 seconds
TestRunner_userchan-tester    PASS      5.03 seconds
IncrementalBuild              PENDING   0.84 seconds

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
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.179 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.189 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.155 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0030123803045306241==--
