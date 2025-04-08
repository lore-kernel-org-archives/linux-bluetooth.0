Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACAB184524
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Apr 2025 17:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744133695; cv=none; b=bx+4FoH97d5A1E/cx2v7O0rBO6HOZhy5c0SQ+k3iquZeLapvCmxDmW/36u7s8rk/JOdzSkKtkLiVHkKEBoCiXfkCGtDV8dg79/VBZ7KBgJ5zSp1hSwoKbl5irnm/junwstKuph+VQLTfIOl8goN0PeJO8v29ez3ffpmvg9E6zbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744133695; c=relaxed/simple;
	bh=nUWe8Ou+5doHNJKLW2GlnfltdWXDtUyYlkcv8PdK7Hs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VqORn/d6ZxNYArucMud2PXPr8ryXjg+LyX/BNfTVD5nO91l/A1g2vr/gcp/yoWFGc91Ruz+/j5rmlkUCJBMlQEs6H0fBKSikjOiFrzkv3kIPd/c1vudCu9veO5M03LjvbfXAp1+s1yEtTMTuma1RYzuHZe0uCRLmcwmnJTfggVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDK3NrXP; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDK3NrXP"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c55500d08cso549330285a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Apr 2025 10:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744133693; x=1744738493; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2DOb0dvbNmvqnEY0NU/IIA+TeEfJQS2OE5iiA+rmTTo=;
        b=QDK3NrXPGptOWnHS9f4FgMmJ7NWyRflHonjbdXPi5+6eN91tcDSZFhJiscu2PvMrK/
         BqD3Vo5JFb8kQu30rcNpje7ZULR6tdf+VU8DON/2w3vJbTqzavZQW5ZwOUhlo3b+/TZ+
         FKnkG3NpNh7YHI1QCXq9QfC5dJHLaiwhpeaVEnJpz9ru1QKvPELlKdlG73UWs1RyBHUZ
         jpHznbAcG6v2d0vrdyU+p4Iu+rUeUDK9wUgRWEFXSWpZxtpiPzShI1Cqtri3HL5fkRWY
         z/CeqUf0+4DJNjAkHhbt48QC10OP1r14XBuQVjYqLoKxUqvQxq7zK2bCIEu1gImXrKJT
         VGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744133693; x=1744738493;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2DOb0dvbNmvqnEY0NU/IIA+TeEfJQS2OE5iiA+rmTTo=;
        b=sBjksYcql64e318w+vODjWPKnpl/Y55SBzdhqS527rdvIVkxeoTOscAZ9HUvgei0MX
         XEzQPJmv5rPVunjM9eF7LVikvlIeeEBFyA7jZ/8tKQACYOwGOJK+MolMOzYQ4qiob9m3
         4cVzubYKkc5NdXrysaW7HSO5sRx9Y1bQuzP01k7rojUw8uM7Pcr9VIQxa190V/5SVrXr
         /7EQ9eagxggridhkXC0Gf8mRejGpy1vqM1kEQR9Tpt9VUxk8EQJyn1YEp7HeliX6v4uk
         hSISWA1kNXaJwr/FtD3r1l2zMQ6INQzafWYQw/dqxOuSSHgIEVkTQ5B/ZiGW2++d8O/A
         EwBA==
X-Gm-Message-State: AOJu0YzRNne5SYptmuxG9adBhTign+yCN0cH/icBLtTYcoutk1SwZ1rx
	9nwuot2tX+j4MUXlkmqf2GQs29FEPqdMA58eBKqEJYOk68uBmkld66rWHw==
X-Gm-Gg: ASbGncvbQTghFHNRwSxehwPI2UxG+5P2+nAbOkYS9QoWZ4AWQKB7GXrVbZoPlQkVcwn
	DNVS+qKdmXmaoZ6wX/Ke55PHWzSoAuXhCqz9cZZDZf4i50ci7NL458KbC8YBqOdtHZz12IVCddi
	E3TgRcCbNa52Q0zE4NVCxCnwdrN4VktobXDKuezfloGN+iHZRP/AwZtRFN6HIRUBQ2h9/yHJGFZ
	AvUrpIcC696nQyYegHW/abppZ+gEmv7VahTJvT+l20luSDwf2BiCoJugopZO5UTlCBhn/De6eDO
	Q14+BwvdJbey6kBaqk7H/c2ye2Unq+G50oG1j12Fjp565WVpV5YfNA==
X-Google-Smtp-Source: AGHT+IFU36MQHqpxMfXsoK6Uf9EOHakdLuUZq97ayx37fxmfUfTn9Kmt26mjbke61IXTsukL/P5hYg==
X-Received: by 2002:a05:620a:4409:b0:7c5:5584:dc1b with SMTP id af79cd13be357-7c77ddde0f5mr2685442485a.54.1744133693010;
        Tue, 08 Apr 2025 10:34:53 -0700 (PDT)
Received: from [172.17.0.2] ([172.200.199.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c76ea8b7b1sm786903085a.108.2025.04.08.10.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 10:34:52 -0700 (PDT)
Message-ID: <67f55e3c.050a0220.23b5b9.887d@mx.google.com>
Date: Tue, 08 Apr 2025 10:34:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3656264972077028678=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: Bluetooth: l2cap: Check encryption key size on incoming connection
In-Reply-To: <20250408170915.623602-1-frederic.danis@collabora.com>
References: <20250408170915.623602-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3656264972077028678==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=951217

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.23 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      28.75 seconds
CheckAllWarning               PASS      29.00 seconds
CheckSparse                   PASS      45.36 seconds
BuildKernel32                 PASS      30.55 seconds
TestRunnerSetup               PASS      479.36 seconds
TestRunner_l2cap-tester       PASS      21.96 seconds
TestRunner_iso-tester         FAIL      121.76 seconds
TestRunner_bnep-tester        PASS      4.90 seconds
TestRunner_mgmt-tester        FAIL      131.22 seconds
TestRunner_rfcomm-tester      PASS      13.00 seconds
TestRunner_sco-tester         PASS      12.71 seconds
TestRunner_ioctl-tester       PASS      8.54 seconds
TestRunner_mesh-tester        FAIL      9.33 seconds
TestRunner_smp-tester         PASS      15.16 seconds
TestRunner_userchan-tester    PASS      6.96 seconds
IncrementalBuild              PENDING   0.79 seconds

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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in iso_conn_hold_unless_zero+0x78/0x1c0
Total: 124, Passed: 123 (99.2%), Failed: 0, Not Run: 1
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.190 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in run_timer_softirq+0x76f/0x7d0
WARNING: CPU: 0 PID: 36 at kernel/workqueue.c:2257 __queue_work+0x93e/0xba0
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Failed       0.107 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3656264972077028678==--
