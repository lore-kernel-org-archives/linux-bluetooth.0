Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8AC26B0BE
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Sep 2025 22:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757457138; cv=none; b=EVJpkrQCLDmx6w0nVWbBjVHY5nj2XBW7Ec2V2BXMbR4orddyp4Ig2aKKcj3JJndHrGHo2QrgPuXMk0j5v97SyLLMomCfs5KC4izC3ndrGYFlhIOzQ/LMrbEQlPa3lJS0qttEJnDdpg0qLE/BPXmCNqA5KuQxbNpdTDUjjPFA52w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757457138; c=relaxed/simple;
	bh=SUtpHwVXlYPyNfb9chq30zIvuy4q8g6EvD001rLCQNU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=AcU66qot7tgGFA6AoOHZMm3bOHW3bVQrniTE+SZ+TK4XERBbe9GBcP3HiLiDy6GLVyAw/PvQvigG2XMJuH4k4PYOaLZuFhW41ucgGMONcB/NTAi12sDa6r731nwA61QFKLNLmmFe+qSxRGPxIX7Dyr0IPJ4JNALRs2tcSRXMI7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBnUMp6I; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBnUMp6I"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-70dfa0a9701so69257226d6.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Sep 2025 15:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757457134; x=1758061934; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qrWufdycASx6BsnWnDy+6Lc/zGHMW0gVc9i7aGSYGmk=;
        b=SBnUMp6Ix9QmvZCQkqobQXdd7MbDPHXqJl2J5YN0rIt9c1maSZG5CRqXw4iuyTKqOa
         PyLDUzswHMZImGJRQhnDZfBzsq4fAEe6N03lqk7ddHLXkDtu09Jx5xmtm7BRg0w5sX87
         r3cF3XwcbBnoJHNa/D7YGcD1s93VEwzztmO0Y/920oQ/X9QLx5H5uimlM2qWfCRsqNc5
         vsiydLzeU4aBZvXZ6KSgSNWC/nsFMVyCjNBu/U/A9mdaTOY7JcBEVNUI111UF+mD1udM
         6BmGP9mmPVNBd8sK5CUfta8c62R/VbWaDp/zcFPhAOU+6m6fitcHs3pbMcWPnaLZOrfe
         KwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757457134; x=1758061934;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qrWufdycASx6BsnWnDy+6Lc/zGHMW0gVc9i7aGSYGmk=;
        b=MJUvp+awR/s7oJYVUI4Bl0uT6Glc9q8PWYj6d/SeI7lxppUKS6KnL3nmqjACnY2bfw
         2FY+jfGnYmDBs36uKzwUESmekSj+Vlw51UqrlwHqmWRQSE52RotbiN3/ojlxr4s7k2SJ
         7F5Rjk1ojQZLoKn1Ep+yJHGw7qvHVrCU6cpO/gE4hkXwHd0ksMZO4cGs4xXUInP42scp
         lqE09uBmEj9VDE5spqP1SeSG1p0CuZis90h3bcoPgqeZStAAygsxrWQGqh3jhpxYYFdL
         iFLzWhE06kZdzMf54SEEkJlN4x9IWTOpzoFMr9Xh0Du2DvKm++2DiFRc07eYI6V2fnm/
         yTQQ==
X-Gm-Message-State: AOJu0Yxkj156r3dTLVbBG02LDku3xkcoS3/ykZYldrpL77yP4pUAKDwd
	/8rreYxPc5Bgljv9+YgXlEsDUnDqehfIwDv5VlotBvifMtR3fFwhS9FBrLgVgjLm
X-Gm-Gg: ASbGnctabE6i783JzTsp5IYA/lwMpiEWsmK4w5sy7lb/QVbH2H04R1U4mT/TyrKE8FA
	gb0K9YTMRZZS5v4j6CVx8+OlqmQdMCnEW1Zs06qtWedJc7Wkx9pvV28kgZ4jHbF5roKXifjvZwL
	sq16BwQfliuGYP0FY2VMueuGc6zkRxlKkOI/7KYmzpHHSDdza3ZoD+i8q4WkyCwgj91CypNgKml
	m/SQVp7JNhg+yZbPfGTA5/6MBizobsHRNhfZOFaL3Pa4/pg4RlpHEkYCMFsP5G3XTl3xLwO0tX7
	XeU7VVojPxffaUy0nnEtE03uDdkFDzQ4Yl7Hpkf5bWD82OIMWsQgqbzaGGL+c+8Q0vlhfJRknF8
	TDpzstNCO6QDlTDrG1IAr0MT6WGW8Aq6vv8kRAPFpS0CGBSfyvDU=
X-Google-Smtp-Source: AGHT+IGnBYQtcpoQwb1tm8gi6POVrEScxvQiXjQVLxeGa8+t/oQyx5F7+vHErMGlrY+TCEP9QQ18Ig==
X-Received: by 2002:a05:6214:2508:b0:70d:fd26:f22e with SMTP id 6a1803df08f44-73924e241c9mr131816226d6.15.1757457133760;
        Tue, 09 Sep 2025 15:32:13 -0700 (PDT)
Received: from [172.17.0.2] ([172.190.93.133])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-72a2d06b9b5sm108769676d6.70.2025.09.09.15.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 15:32:13 -0700 (PDT)
Message-ID: <68c0aaed.050a0220.2256a8.ce98@mx.google.com>
Date: Tue, 09 Sep 2025 15:32:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8861379246148634531=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/3] Bluetooth: MGMT: Fix possible UAF on mgmt_add_adv_patterns_monitor_sync
In-Reply-To: <20250909215824.1739006-1-luiz.dentz@gmail.com>
References: <20250909215824.1739006-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8861379246148634531==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1000734

---Test result---

Test Summary:
CheckPatch                    PENDING   0.42 seconds
GitLint                       PENDING   0.32 seconds
SubjectPrefix                 PASS      0.34 seconds
BuildKernel                   PASS      24.77 seconds
CheckAllWarning               PASS      27.67 seconds
CheckSparse                   WARNING   31.13 seconds
BuildKernel32                 PASS      24.86 seconds
TestRunnerSetup               PASS      486.13 seconds
TestRunner_l2cap-tester       PASS      25.12 seconds
TestRunner_iso-tester         PASS      38.96 seconds
TestRunner_bnep-tester        PASS      6.09 seconds
TestRunner_mgmt-tester        FAIL      127.93 seconds
TestRunner_rfcomm-tester      PASS      9.53 seconds
TestRunner_sco-tester         PASS      14.85 seconds
TestRunner_ioctl-tester       PASS      10.20 seconds
TestRunner_mesh-tester        FAIL      11.39 seconds
TestRunner_smp-tester         PASS      8.67 seconds
TestRunner_userchan-tester    PASS      6.36 seconds
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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.104 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.002 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8861379246148634531==--
