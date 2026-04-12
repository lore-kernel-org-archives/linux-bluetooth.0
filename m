Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95C335B632
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Apr 2026 19:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776022454; cv=none; b=cEptooyhNrjRGnjI++f8c5LgxTGriHiI2vDACCXEpE3CD0x88Xai+VG8r+0pyTsBcfbuDGw+a8gU5lgY3eTuLTZHBpgTkn+BnOAQ+DuHNDN3rpkLms0SyV0neJDEIOJk7okh9IqutiEhGYZSNVbDkCvl4Z8xefAT/I/r8U+2EwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776022454; c=relaxed/simple;
	bh=K8tXk2HA0RDL/brIYcp9zB/m1HZ6I2VGWwX7CwdFLb4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=AgIznHma962QigPLzbUj0iohPPYs+ma58WpajHjGKvZbyBm05T2YY3k9qIbDLMj3/q3ocUZh8HJmDgEWRzrY8+HKfJmARss+OwpIyhi4dFkeRb90qD9J8gQZUQhYYbqBVTUA2ZjSldb67zRrw9kmrYMfsMFYstGxpHdhraEwP/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDpPQ7Lg; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDpPQ7Lg"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2d8fa0fadfeso133462eec.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Apr 2026 12:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776022452; x=1776627252; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6eAOHazhsAGr9mdXSWgJ/04acR0evkybVrIcfKCwd+k=;
        b=QDpPQ7LglGp7OQktnjdrF8BWFER5zFmUso9aycpKyntlww0BbmZ3dXvBKET8uydZ3X
         XNJLcTsxFhrNDYCuWVxrNH/GBnq8ryjaBxPpIkTt0vhrJ2Ba9lHAoiPAwibEcSQ5wATf
         0B+X9QlDMWGMqeOhwK1LYPZP2nBrFkN1hRmuJYNb65+LHHjoMXAy6JjqyVsdyhemluGo
         TWCaXx5HFZCTu3H9XEDQ1Iu6MENMKwfWt1Giy0JcWH7fzWiGyQqTLRi5J94t/OGu2u/w
         CTqo0xkV+9GOvs8OdxP14OuzC0EM67VDl9jmHShBfk01SFRa/nD4DIg42ywfyPxP1+d0
         paZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776022452; x=1776627252;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6eAOHazhsAGr9mdXSWgJ/04acR0evkybVrIcfKCwd+k=;
        b=Dg47gMjjgsDPekJI+dN7qcHl6ZGETYiSs/1bcuah1sCoxVaxB1HaFdHzlrxX7wd9ip
         vEIdhujhtNkWsxYOAKoQnAd/tjNNzEUXb8g9/8SOCWNP8YWF4Sdni/3iqyC5psWVc1Eh
         U3596I7XtvJV4KbwFW0pJKN63hFBcbRNjSS7myFcz+oLl4BazoFRfjwrVuNY3dgJWRHS
         fy2csYDmthADcGxbkhHm9Hd+hKdfO7uRVrnBTPubaPGRXrX7m/mRHxQQe3Gu7gN0Cijf
         X4qt5YqUom03LGVVGf0Svm/N1kPiRKDZIBWsCOJNl9vbxejL4j9wOymVE1WjMyIQJw4m
         AhDg==
X-Gm-Message-State: AOJu0Yzu82rh+qgXWY1DFOtp7YcATe4LoVJVYpf4fpHgf7fO/bKv6kZM
	oK8u2GiVTv6EMuKUwZWgsNWjxjoEjmXykZn3peDZ5wHoi1RVdcXnyRe4BRFaYg==
X-Gm-Gg: AeBDievLbDdGIEYOuB18le8bYas9tPk/p91buvqPKIosvymVMuqVF2hJ/1cwskL1bjp
	lLi91o/Q6SySzcbOkQwq9SlPJCmBXDmLBhYVUSbB3NZTfq5FLPl7qUEhEBeJBqJhuA9lGPex6Lz
	HM64NBdLvkgNNbQHlYE6GstiabElnmQMl/+TfjYxA22Z1r//7IC9AmzOluw1nHVSQF0F4i7yWJG
	rfvwtMr8+gPgFo7iin5B/Q4an87XgrT9xc84Zt6d8imRrh8pC3JUDNfT+6UrSZcswDydgmsvrFf
	fhS42RC2OXGmalhhyhI2rPqGFl+dTiJ94jXVnIVLfMnVxxlZyIKTxje3AT1CJr+UDHoRax8z14X
	GDfu1Slx11/YXkpMlLPmAuyM/S0FA+6e4xb1vR+NokIFcOlKYEGK5UgVVSnQKO/rzK3VjePcEEw
	upAwf3uu4QmEJeV5CtetKMKXXOjfdgLA==
X-Received: by 2002:a05:7301:718f:b0:2d8:4705:aa19 with SMTP id 5a478bee46e88-2d84705ae0cmr925020eec.5.1776022451619;
        Sun, 12 Apr 2026 12:34:11 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.72.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d5621d5e43sm12997033eec.21.2026.04.12.12.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 12:34:11 -0700 (PDT)
Message-ID: <69dbf3b3.050a0220.15b6ff.f45a@mx.google.com>
Date: Sun, 12 Apr 2026 12:34:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8910220196371495662=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: SCO: fix sleeping under spinlock in sco_conn_ready
In-Reply-To: <9f333a79da3f0f552ca735d549ea3e8ae0784220.1776019593.git.pav@iki.fi>
References: <9f333a79da3f0f552ca735d549ea3e8ae0784220.1776019593.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8910220196371495662==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1080410

---Test result---

Test Summary:
CheckPatch                    PENDING   0.50 seconds
GitLint                       PENDING   0.30 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      23.67 seconds
CheckAllWarning               PASS      26.30 seconds
CheckSparse                   PASS      24.97 seconds
BuildKernel32                 PASS      23.06 seconds
TestRunnerSetup               PASS      517.43 seconds
TestRunner_l2cap-tester       FAIL      27.72 seconds
TestRunner_iso-tester         PASS      32.92 seconds
TestRunner_bnep-tester        PASS      6.26 seconds
TestRunner_mgmt-tester        FAIL      110.65 seconds
TestRunner_rfcomm-tester      PASS      9.28 seconds
TestRunner_sco-tester         PASS      14.05 seconds
TestRunner_ioctl-tester       PASS      9.98 seconds
TestRunner_mesh-tester        FAIL      11.46 seconds
TestRunner_smp-tester         PASS      8.44 seconds
TestRunner_userchan-tester    PASS      6.50 seconds
TestRunner_6lowpan-tester     FAIL      8.83 seconds
IncrementalBuild              PENDING   0.30 seconds

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
L2CAP BR/EDR Server - Set PHY 2M                     Failed       0.114 seconds
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
Mesh - Send cancel - 1                               Timed out    1.829 seconds
Mesh - Send cancel - 2                               Timed out    2.004 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g48abf361eec2 #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff888002767140 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffff8844d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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



https://github.com/bluez/bluetooth-next/pull/72

---
Regards,
Linux Bluetooth


--===============8910220196371495662==--
