Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EF9239E76
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Apr 2026 20:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776026759; cv=none; b=MAazh0sEdl+4IWLwCmsWqC8fBb43kwzVupwB6ZsKDvfy3ncVllYpt4yMXETNJlQQlzS/L0LAygidsIds3n8J4PwpSEPCgrtTKU1jnHyIvW3k6zGGvSdsYgNEisCO9PU0aXiKUZQsxtF/3kaBAJsZR1HgfK1B1OJCstjNlocN79s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776026759; c=relaxed/simple;
	bh=9jyWq2sKi0j2ILlPk9hhemP4AMhwBA/X3WCoZr0iPww=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RrDxYWN0mw/cdvNN7Y59d2Ixxnw/SwSaXc8ydVHh0LiBtx00VKOwFfUdaopzq3ssstH70unyHLn7jDGnQpkSmIFIF0XOqYlp2Fha8Hlx6ecx2iKjdJ4ZWi4LpJ+llCErQlhmjuetgneMRf1roAteV7z7sqexDQwSEkI0heeUHvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0ng9JdW; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0ng9JdW"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2c156c4a9efso5157560eec.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Apr 2026 13:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776026757; x=1776631557; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=o71G40RelPp64Tzqre1OhJ0kGXcs86iiiEz2HWGOUY8=;
        b=Y0ng9JdWSl9ucmcvSFesUFVkinL1NjN9nqIA0oq4NjSrqjID7GemSjlP1S0KlvWE73
         c2+huoddaTJ4m5t/mqRzqArUT8RNL57B0th4WDkICjgYoTgRAW+9EsLqSw+ft1JkVldV
         mwonNBtz+Q9/AZApaU0aryUDVTOe3djH3DTJfzkDeTYsp3Uf18cKLUwAnyf7PixNfeOw
         OR/n92Zgi4uJnAIXrVtC4gD45mtFKkcC/FU28SJnzc2sQCLnl4KMpCf2UixMIky4NRD9
         1MqIL2tTOcpkjhb09Y0FBiattCjIqRYypIPqGGdkKrP9J5BCh2oo6RIWsyTNgXzKyK3M
         b7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776026757; x=1776631557;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o71G40RelPp64Tzqre1OhJ0kGXcs86iiiEz2HWGOUY8=;
        b=Iha0RAt5Msd2yr/8K7U6tbwkA8+o4tqYhjlWGe6fFHSSU6dfFgLMjpEj4RAZyvQwhi
         gFnezZBUs6I7u26rbj9NuU5HH94pJ5jP4tTjIpFyRQRpOprAoOcS3hCJtR3LJmOM5XNX
         wfoeZZHI567PmoQ8/81iCSVYVB1F5OeurwWxFBJVxFjM3xMtEBTch72Uaw0QL5LwfQQK
         EEAmg8GenD2PSeSH41LvMwhhIzFdAAR43AfwsEp7h8xJqfHvctO1V1uorUJkxEBaO24c
         EjCkmrf5brGEa8l/CXCGaCPqCiIl3OEFleludHk9hooYRO9ZRB/PzHCmDh82CXHAXsik
         YZPw==
X-Gm-Message-State: AOJu0Yy9GCYnJ2FkA9/hRHlHKTQKBc9iT8Faf9j9EQXm/kZC1IYoZ/qg
	7Vza7a3wDYLL3r59cWZ6YwEmumWxN1ypdapah2Nh3SYxLiV1KG0nwEqiJwgl4g==
X-Gm-Gg: AeBDiesN3YcwneH0o6M+Dvb4ONL9bhdG2noNe1c3aa8yjB9+HZX1YgXs2sVxdI4r+Z1
	T+uTkjkKKk6oOu/wGuHZJkAplWIg1KQJrSD3kAwymW8wTaWuG4x74OYJI8kfjU1yGQgHWD+U5za
	YdQ4dj3+u4Z0KlMfczag8Ybc5pp4MZ7sSu6Qg2efdZcx6pIMPUqWjOJsKbTgMbR5uhP+8OqMA9z
	sSmtWT80xXT3YvlzCzmQKBcxn8jIwbVrMe6YFhSqHRPShAjiStwZiQmAuv/g0siUMArNjpikqqV
	I/F7tagIYZjV0qhHC25QqpCxvaPXHl1vnULJtprtm5Db3wx4mDdp15jy7UbsquKJkRFl5z6p0NU
	/BbH3k6f4U1UMlAdmQeCbVihIokJ7n16dFFqmdbNs6JCwtVbDYP4cNkHKkyGOVKhC+JF6sQtEXL
	fGthEJGx1cipUzDG43NzncjKsIwb2Tjw==
X-Received: by 2002:a05:7301:1003:b0:2c3:d51b:91c4 with SMTP id 5a478bee46e88-2d5876a4991mr5669259eec.7.1776026756953;
        Sun, 12 Apr 2026 13:45:56 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.212.2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d5632a2a06sm13376151eec.30.2026.04.12.13.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 13:45:55 -0700 (PDT)
Message-ID: <69dc0483.050a0220.164769.6778@mx.google.com>
Date: Sun, 12 Apr 2026 13:45:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8516517470636837160=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [RFC] Bluetooth: SCO: remove sco_conn and simplify locking scheme
In-Reply-To: <5ac8c40b96052cb320c4ee1083d37818ac5d90cc.1776025103.git.pav@iki.fi>
References: <5ac8c40b96052cb320c4ee1083d37818ac5d90cc.1776025103.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8516517470636837160==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1080418

---Test result---

Test Summary:
CheckPatch                    PENDING   0.55 seconds
GitLint                       PENDING   0.31 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      26.24 seconds
CheckAllWarning               PASS      28.84 seconds
CheckSparse                   PASS      27.61 seconds
BuildKernel32                 PASS      26.70 seconds
TestRunnerSetup               PASS      569.66 seconds
TestRunner_l2cap-tester       FAIL      28.28 seconds
TestRunner_iso-tester         PASS      37.77 seconds
TestRunner_bnep-tester        PASS      6.31 seconds
TestRunner_mgmt-tester        FAIL      115.37 seconds
TestRunner_rfcomm-tester      PASS      9.36 seconds
TestRunner_sco-tester         PASS      14.29 seconds
TestRunner_ioctl-tester       PASS      10.13 seconds
TestRunner_mesh-tester        FAIL      12.54 seconds
TestRunner_smp-tester         PASS      8.60 seconds
TestRunner_userchan-tester    PASS      6.64 seconds
TestRunner_6lowpan-tester     FAIL      8.98 seconds
IncrementalBuild              PENDING   0.27 seconds

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
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 95 (99.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Server - Set PHY 3M                     Failed       0.115 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.103 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.783 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-ga09fdde43cea #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff888002777140 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffff8464d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (rtnl_mutex){+.+.}-{4:4}:
       lock_acquire+0xf7/0x2c0
       __mutex_lock+0x16b/0x1fc0
       lowpan_register_netdev+0x11/0x30
       chan_ready_cb+0x836/0xd00
       l2cap_recv_frame+0x6a06/0x8920
       l2cap_recv_acldata+0x790/0xdf0
       hci_rx_work+0x500/0xd00
       process_scheduled_works+0xb16/0x1ac0
       worker_thread+0x4ff/0xba0
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
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



https://github.com/bluez/bluetooth-next/pull/73

---
Regards,
Linux Bluetooth


--===============8516517470636837160==--
