Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C668161310
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Apr 2025 22:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744756466; cv=none; b=Q9avaDM1RGZM815c6RU2qw5OPa5GM6kptBdXcMO7h1nre9OdywGEMQezWJbe6bSE9GNbAFeixE4R1JmnYaxl9ZmEOH+/+m3nTD+kyEjErI6PJjTpAEN88p2xyRetJwpLIUhOCOleylaDFhDNqOzuQhNJ+SSZaIxWAftHz0FhQkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744756466; c=relaxed/simple;
	bh=s/QPtGdG6K3e+oLuph7VJN1yEmFrcIB4a5BdLDMS0ZI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WXpHtSTZmZfRq6O2qwLMvl9ypJMNI2TcEMAPf6RNWQi4cvzqfmNjtyFh6/6f4KBP0oYqP4pkXBwQ4g72+E/qk4p1B4CK1S2VF0IsJUsI+MIXKBYxP/GIq6VZ4hRkeESDf4hfRJE+KpfAgREtEAmNwdSXDk5z+oQhhU2zQSrPnoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUY/Qq0x; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUY/Qq0x"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22c336fcdaaso904415ad.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Apr 2025 15:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744756463; x=1745361263; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2g+8HlUV+/HBB3NP4qBYceKlta1u7fJTW9IWBmr4B04=;
        b=gUY/Qq0xR8tBQb0NOFaGpLl4W5PnBgMiWo8/phCGx4gC4TSRvSFgdkKCiwpy335ovI
         FH6iEpRDCEDHa1g78zr5Q9assIwvdl3RJO39z8cCKDyTvfub6Ve2eNz2b2N9Tt/LDN7g
         w6dG3nUdgWj0ScESiaKlh544X9pKr5Yqtk94knMN3/t9xxo8MYVUTyoPnna4dyMTYdX2
         dLNGKPSPrywQ5yjY2q+KmYk9wRw90xpLXq9eCt7N/OUm34JaaIfLx0WAIXdCWrsFSw+R
         WjnxgnqFbWPzzedZ7pfgSaGx91uYoyvC1lR4tIztrkrJuTK7Ov+ucGLttPc1DrxG47SK
         NFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744756463; x=1745361263;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2g+8HlUV+/HBB3NP4qBYceKlta1u7fJTW9IWBmr4B04=;
        b=YCDgGxn07ZxRFkSTEudx4luFopk+OkRqDd+vOAkT4s1GgFWWGCXzo1O69UF7GCY8le
         53GVTKCuSfpWQ2VGMkdxT9LEZdFgsKKGon6R3mCNTuaqtPBg5ryra3+g8DKCecdqJgeb
         bqg7KNrBDLVFdjYNjpgQXsvdc8c+kNqdPN5SFIZ3esYsybAwk1OFj937qe+f0+XjjbdT
         sYs9gTdW94thchrxgc9EvWLnyueS+rUDEE/w87Uv23t48LEaQw5EARl6QhRXvSVOpt1T
         gO9R3NY2h2tvyEQGIkJ/3wTQlIlUPghya4n5r1UOjlh+6lm+ZJpEMu/hi5ed/OCKp87o
         S01g==
X-Gm-Message-State: AOJu0YyKQqC6B3MH/OVFCtYhqNLAzNrkSvsHsgU4cl2ah7QYZ7IN4r6J
	v6vhFtr+57C4hPhiB9O5yXuyRhBWuFFkOgj60JiJo4mgdkLVBUlCt/4qzQ==
X-Gm-Gg: ASbGnctY4e+yCjPxc5ItwHduYM4qyqSuA8PzKNBeGLh5R3ueeg4W6A5lQA1zY1gS3r/
	cKtqnRmV6JE03WCdrCOZwDJqsC3Zaiqb4etXFRHQWOyNxZ5lrDFYGmmAZacKz+jCXwO+rCwsMgB
	A3a9tJ/tKc9iok3DGa1gmdER2SieWoAaHEMCQAk4aJZqHhF2fJN6PkZ9aorT22Shg0L41DZUxEe
	iG86scRPbqizBVr0WWD6oyzrCIflL4FW9u+gr8UFDsSoVGcvfyAP4JPAD4+GMpR2qnEaMKXg8Xm
	z9P7TatZc68IorfiOTUUUPzxE7nID4UTFrXRn4+Q6SMpVaI=
X-Google-Smtp-Source: AGHT+IFSmazYTfBSy92vGxBK1YEVEqug3EKLqNZncwHzaF1fBVRDWE/AOGaCfdZ6neOEP1k7IqzQBg==
X-Received: by 2002:a17:902:e884:b0:224:162:a3e0 with SMTP id d9443c01a7336-22c31aaac1dmr12387545ad.49.1744756463572;
        Tue, 15 Apr 2025 15:34:23 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.47.211])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33ef1234sm587295ad.14.2025.04.15.15.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 15:34:23 -0700 (PDT)
Message-ID: <67fedeef.170a0220.3b11fc.042f@mx.google.com>
Date: Tue, 15 Apr 2025 15:34:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4938559555171073108=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v4,1/3] Bluetooth: hci_conn: Fix not setting conn_timeout for Broadcast Receiver
In-Reply-To: <20250415214835.1678138-1-luiz.dentz@gmail.com>
References: <20250415214835.1678138-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4938559555171073108==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=953731

---Test result---

Test Summary:
CheckPatch                    PENDING   0.52 seconds
GitLint                       PENDING   0.37 seconds
SubjectPrefix                 PASS      0.32 seconds
BuildKernel                   PASS      23.43 seconds
CheckAllWarning               PASS      25.73 seconds
CheckSparse                   WARNING   28.82 seconds
BuildKernel32                 PASS      23.02 seconds
TestRunnerSetup               PASS      472.74 seconds
TestRunner_l2cap-tester       PASS      20.72 seconds
TestRunner_iso-tester         PASS      27.67 seconds
TestRunner_bnep-tester        PASS      4.52 seconds
TestRunner_mgmt-tester        PASS      111.71 seconds
TestRunner_rfcomm-tester      PASS      13.51 seconds
TestRunner_sco-tester         PASS      12.14 seconds
TestRunner_ioctl-tester       PASS      8.14 seconds
TestRunner_mesh-tester        FAIL      6.09 seconds
TestRunner_smp-tester         PASS      13.31 seconds
TestRunner_userchan-tester    PASS      4.66 seconds
IncrementalBuild              PENDING   0.95 seconds

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
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in run_timer_softirq+0x76f/0x7d0
WARNING: CPU: 0 PID: 36 at kernel/workqueue.c:2257 __queue_work+0x93e/0xba0
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Failed       0.095 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4938559555171073108==--
