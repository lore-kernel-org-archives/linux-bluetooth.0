Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B241B81CA
	for <linux-bluetooth@vger.kernel.org>; Sun, 19 Apr 2026 08:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776587875; cv=none; b=YDocqjQpOcDPrIW4Vu46hVLuxy2f00ME9jrEDyWG53WpiBZhFPmT5pvcit2WNIf+Z1175iAkQX9vmwcPX5B/un/cozTQEXYIGwN/G6ttqClUzijsmUItBjSngH14RETJPDdNFqYtRiba1jK18vpcVkfE6EXneMG3UGIuGBA28Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776587875; c=relaxed/simple;
	bh=GpIAnSD8m+MttpqoxPBzUL0lsJd9taIHGHO0OkNLG8I=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=m6YxD2X3/XpQMwf+OZokHwIA6v1zfSiZm5Upc5vSYnUbDxSonwWQYqi/cyAUpuwcNxYGhbD24cMlGbX2e71iRbj0Kd8i4hwLRHxAXMlWaG0odh07lsfX/0882Ui7sIWkdapYqo7aYOXPT1a7rXwiBiC+zDBa/lzO9sZOWITykbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4s8Qdj0; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4s8Qdj0"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8aca6bd57cfso22032596d6.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 19 Apr 2026 01:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776587873; x=1777192673; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=j2zrIVx/aLS8OySsDajMPDdTHg2wd+L/uU9X4BGjRgM=;
        b=P4s8Qdj08gRLSiOI+yt/X6H+ZRFl682QJulOdjXtC4wVDVJK+kPHvyULq6aLnN+BCo
         N5yY7ZQNnfhEK6CysLBsSQFKpmTiVu7l6yb5xfQPuZupOGSzmx21B0hS6NagLRiWoEIh
         6IJubyw6ph2QLKne7fUQxhVPxt0vROMBOk6wE98EHehrxlTE0Bqp8w7EQ8f4dpHklLat
         a/VeQwwuqGT/X9rN/9qkIRY09asrLw98rjJiwVFTDr10pCp6hmyWxSZVqz265BuI4P2O
         zKkI4I3Tspr6xqTcVTvYleoiGYjal8WBwS3IhSsQqwgaOYiDfFmCyro8YkLJxhXViZD1
         1IXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776587873; x=1777192673;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2zrIVx/aLS8OySsDajMPDdTHg2wd+L/uU9X4BGjRgM=;
        b=NUVia1boAwvAXHj5In42MiMBAhaeP0yOonGhufoEMdeUOVG41BwWxaepAM/2/I+frG
         6cJjsRLGPMF0DwQ13hnXDwkWs/pKyIfVf5sdCTq57s5JzFWttIkYXtscnAnqFmBMR42S
         TqDlr/loYPiMP6rxPBrznzxQMELiwq/ozv+KV4IQZiD2q6PZRuJhRdtASjSw9wKqLbxE
         XqJC9tx4s+Ujurk6ZahvRQ/gZXJJeViqfjAEloHTLwaLi0hmfUv7I7T4Yjn/M1qR6Lle
         +9JidVAYe7qtnSYIWS2lgZQEc8uGmtW8PkCsw2sqD9PIYyDmq6iTUe5fDwwa+B+vWU51
         WwLw==
X-Gm-Message-State: AOJu0YwxV7RnYEzXba1NarYqzl67nJ/zMAKeBoP/ZY29tGOBrdUHtTE1
	aYt/m244RiMyzSoZaTtlqI3QS+vuFMM5GUpHaV4Zb0wMnqk9wxTIDS7zFZBjrw==
X-Gm-Gg: AeBDievHjyCkqCphm7PAuN2HRjHYBe/0ZlKky6jF7nTGzMKgF7OsU2bn55EUyGCiXcH
	rACZAS1ClblBMYddFSoL9WTJFUqsQEB5xe4NSmSIZU6YHi6YLdqFw3A7vriXdCEsjkPoN/a9evP
	Ybclyh4ii/QhhVwQTQ8bKimurualHxVqkRrnaWSbKzG42vndgPmESgAtKla2ZfYwdZ/HI3QruzJ
	yZ/yEErrmtMEHuuU0VPqpcTcHywSMpm+P5bJJFrU03gF+oZVvsGpFBdYvcFKxgX+dyR+mk7SFOC
	c1PW4s2Beg9XrY/k7LAgIw2GNJF60GqmswqPvAhzY7S0VeyKp8IKBgHpx7sFQWy93tcfNwuXFkP
	MVVgPyvcu2BsGb4BfbcbkC9D2LFfiGEeHDsq90B6IpPIEYLfOY2c0+UanlzB4IOSJW9MBLnWaoz
	bxuLrauP0RB0QkXbjoSFOm3lUguCkrVesH9Gl1HnPr05mKkFBiA8C+
X-Received: by 2002:a05:6214:41a0:b0:89c:c2e7:97ad with SMTP id 6a1803df08f44-8b028160e4cmr156342666d6.43.1776587873096;
        Sun, 19 Apr 2026 01:37:53 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.132.65])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac6c3e7sm51390156d6.13.2026.04.19.01.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 01:37:52 -0700 (PDT)
Message-ID: <69e49460.d40a0220.2e3868.c024@mx.google.com>
Date: Sun, 19 Apr 2026 01:37:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1740321304092295960=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, condorachest@gmail.com
Subject: RE: Bluetooth: Add HCI_QUIRK_NO_SCAN_WHILE_CONNECTED for combo chips
In-Reply-To: <20260419072433.55976-1-condorachest@gmail.com>
References: <20260419072433.55976-1-condorachest@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1740321304092295960==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1082905

---Test result---

Test Summary:
CheckPatch                    PASS      1.17 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      24.32 seconds
CheckAllWarning               PASS      26.55 seconds
CheckSparse                   PASS      25.79 seconds
BuildKernel32                 PASS      23.77 seconds
TestRunnerSetup               PASS      530.52 seconds
TestRunner_l2cap-tester       PASS      28.01 seconds
TestRunner_iso-tester         PASS      41.60 seconds
TestRunner_bnep-tester        PASS      6.55 seconds
TestRunner_mgmt-tester        FAIL      114.18 seconds
TestRunner_rfcomm-tester      PASS      9.49 seconds
TestRunner_sco-tester         PASS      14.29 seconds
TestRunner_ioctl-tester       PASS      10.15 seconds
TestRunner_mesh-tester        FAIL      12.23 seconds
TestRunner_smp-tester         PASS      8.76 seconds
TestRunner_userchan-tester    PASS      6.73 seconds
TestRunner_6lowpan-tester     FAIL      8.50 seconds
IncrementalBuild              PASS      22.51 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.102 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.670 seconds
Mesh - Send cancel - 2                               Timed out    2.001 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc7-g83e51bc60491 #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff88800233e940 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffff9624f960 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (rtnl_mutex){+.+.}-{4:4}:
       lock_acquire+0xf7/0x2c0
       __mutex_lock+0x16b/0x1fc0
       lowpan_register_netdev+0x11/0x30
       chan_ready_cb+0x836/0xd00
       l2cap_recv_frame+0x61bb/0x88e0
       l2cap_recv_acldata+0x790/0xdf0
       hci_rx_work+0x500/0xd00
       process_scheduled_works+0xba7/0x1a90
       worker_thread+0x514/0xbb0
       kthread+0x368/0x490
       ret_from_fork+0x498/0x7e0
       ret_from_fork_asm+0x19/0x30

-> #3 (&chan->lock#3/1){+.+.}-{4:4}:
       lock_acquire+0xf7/0x2c0
       __mutex_lock+0x16b/0x1fc0
       l2cap_chan_connect+0x74e/0x1980
       lowpan_control_write+0x523/0x660
       full_proxy_write+0x10b/0x190
       vfs_write+0x1c0/0xf60
       ksys_write+0xf1/0x1d0
       do_syscall_64+0xa0/0x570
       entry_SYSCALL_64_after_hwframe+0x74/0x7c

-> #2 (&conn->lock){+.+.}-{4:4}:
...
Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0


https://github.com/bluez/bluetooth-next/pull/104

---
Regards,
Linux Bluetooth


--===============1740321304092295960==--
