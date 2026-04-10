Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D0C3D093B
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 14:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775830619; cv=pass; b=PPohpRiqDkLfeUQplzKD3MzLTGwIYtUmTENlEvNl4gpQTbqR2FEGYO/FocYSZCWKU7bjD2M0aLbvtRI5EZMfjMhO57xOIWzPDPsm3jMx6rvhU96detOPDXpJUPmCFjHZwnirAbVVT1d2E/FBq9n9dkNC18ucUtwhseP/PhsefCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775830619; c=relaxed/simple;
	bh=Cv+0itOnHUicdKrky6BTxwee03Mn37quTaBmYUmqVtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i6sFVACLVF9A+Vsgmx30US+yuVVRaLMcFeCZwhNS3PvfgimvvgM9ecqtPwi9oJh5QCzD/H12QDjPNyV+EpTOvdtxXEDFN42K7oaVj70TeWT68/RC9zqKJ+HLqKLiV90lwdpxOHMboBd5DXjXwvwN1QamxZqkihyHxpRNaDy0jTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XxNdOscQ; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxNdOscQ"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-65006c99d38so2338712d50.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 07:16:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775830617; cv=none;
        d=google.com; s=arc-20240605;
        b=FdX/dW5wIyBZTXBLeqGxSgaBnvO2Y6S6HwQL4BmhR8czpdj6KDDRelulhW9obiJ3GI
         41rjOkfHQzx8QXakKldlxuz9ccJm7iFffoRon5HGkLptdAIYyO/9EiFIHQwS3Yv/uoQ8
         KSUhz5/U+RqJarEj8WxGmTmVrKE80S7Vldx5pb4rDta3DEdfyl55bbMEsYhXAeQN3eaO
         UWpvn6El4DXNj2SQGHsCCd2mOAQjAfGNLzcG/xSWnNUYJcmi7bhO1XTNrfOW2RlFjzpQ
         cYOoxRzeanjHcIFblkDrdpHOj3SLS3sQWlbsBXY1LpHqabFY7X77hT67nH93R5mYhE0h
         Nqhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iP1oPQ5EX8ps7ZKx4qRn9HIQB6cPrVwepuv/HoCBtqY=;
        fh=f+1EwU4EEYKjWihoqhLYAkIyCmWXXOaiTzVkdrZFC5A=;
        b=aztF5b5X/8vZXq4LpqGW9nEqC10v4PWaIMdpqyneumFy+BzmI7ezH7g/+5cMPEKFeh
         WyaOoLv8e+9Wf3RxD5SzAepTxwpJ4jx0ityUV8MFBt25TpyZwmr1dObHUR+L4cZYftbE
         37yXuBZwRiJHoQKs2+bmLv2Ade756EfdlyA0BwOLCz8pQGmyJDgdZm7qnO7evSgUGTu5
         gYakoA/dwPKw5HZMvT+MxhwpZk4Kwd3H82tDhfZDawvVah++OtW+Z3cp03BrNZProIQu
         f3oyc2wxYh0NBB56clyi8pJ9DfBLFB2zKOMDLvmObbS3jFuqIAPjaiG9dx9xppN6ynzY
         k2Gg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775830617; x=1776435417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iP1oPQ5EX8ps7ZKx4qRn9HIQB6cPrVwepuv/HoCBtqY=;
        b=XxNdOscQhSM4DOOBA1tkypDGmVBa4x+5N/H4hXwRmeb2YyQ4CujAPZSC2ncSl5t6id
         EV9NlR/4BqznfyTjxckEvhzv/TODFBgepboutfM81/ml5mobX7jp3sPiks8VGQWHvJbe
         GsnggCf0cJecH1MnWvSQ3vXr1bq27cAwXZ/ezHiOCggqV0Vw2Zr5qhy29/CL9ZTpLPCs
         MhKYT2p3zVHwY7JSY/YD97oo1KacWowmr8RtzFLd4q6KkZc48yG0+LGGbOlR90GPWfyn
         ZBRKqR3f+Sm0LnSCl3SIgi34S5yNRaVsAqQed0Uo10Z9KHdakFj1ccEqROki5wAfgYCo
         /CkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775830617; x=1776435417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iP1oPQ5EX8ps7ZKx4qRn9HIQB6cPrVwepuv/HoCBtqY=;
        b=fOrd5WwczFqpI+aoNusUrfwOlZ8Ctus86JNszFF9emkXfjHSl127TAuC8qIenVXYol
         6aBpMuLnFwzHJMZAQn/Aj52rzPUaQn9wHXnQD3WcdWB5DAyfjDn8Tke6dpo9wAn5ev2x
         mk1Sh4cr4uABmgRywBZp1uF4TjsClcDi5UomFTORvDF1p4R9BGtsV2s8mr2lmV93CWnN
         wu/8rIfn5fGM86zFT9aZvmZLJFUjUlVumHBKsr3qf0Evo9bJw0gyPVD1+zoDTK5dJS1q
         PqzXdha9vRXI6pz1kUQy5yMeLIDr669jGEYxDQzigQdCmeeNdo9VGo0wlppWfVSA1LXJ
         MWNQ==
X-Gm-Message-State: AOJu0YzHeoicpwYxAmtnokcTlGZaiIVVeXKW+TELGeKpUfD6a0tUDpiZ
	FQa1eXrbdb24NlzJlgsLVhdRFW6i0JC2lIw7IoZVeL0vDCO1ip7+BDKdqFQHcXq6El34m1q3Hqv
	fB9ZLyQOT66HZ0q65nbGi2uA3a8KouYUycjXFO30=
X-Gm-Gg: AeBDieuZI5cGNVZ1EMhFd2Uu3OoZjMJneB9omWv2ezASquZ2K9qztHK1SBHBmRwzEpw
	kDS5PzN8gxclSVpCoroIEg1R4Tr7WFSVCEvfrG5OcTU9yeEA3SP9wavUkrPkFLDYCcDELo/wA9+
	+oVucXNs/soEe/tGKHEM1uaUCS8DdRbU+wX8v71oY6FlWhivcBHOUIoJqKZkhb1f7mDaG6348qv
	2F6bVEQIysRrz2Vx7DipDY0W2bkE0Y0bocWnxsaeAFJao/F1rkjhSZLBbSFVXuz2UrI5Y8vrOuQ
	yC/FsPo04/s27o+boh00SXFrJRIIbS71BDytbUZ/RY6JQD0VGY79K+YDt4QRdt3zO6N6Wg==
X-Received: by 2002:a05:690e:4402:b0:650:1aa5:8568 with SMTP id
 956f58d0204a3-65198b9cda0mr2155670d50.55.1775830616787; Fri, 10 Apr 2026
 07:16:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409013035.1923003-1-kaihsin.chung@synaptics.com> <69d809e6.050a0220.3d3bda.0507@mx.google.com>
In-Reply-To: <69d809e6.050a0220.3d3bda.0507@mx.google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 10 Apr 2026 10:16:43 -0400
X-Gm-Features: AQROBzAHEJHtB2T4zvMkzgF6roARu6CosrJfPoucPoatGm7oHJKCaDCR64LBu5Y
Message-ID: <CABBYNZJ3VLTcjLx+AOcS=x3r0pvrrEW0kAZEfT5caND7EJ-_=Q@mail.gmail.com>
Subject: Re: [v3] Bluetooth: Add Synaptics 4384 Chip Support
To: linux-bluetooth@vger.kernel.org
Cc: kaihsin.chung@synaptics.corp-partner.google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 9, 2026 at 4:20=E2=80=AFPM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D107=
8977
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PENDING   0.51 seconds
> GitLint                       PENDING   0.47 seconds
> SubjectPrefix                 PASS      0.06 seconds
> BuildKernel                   PASS      26.48 seconds
> CheckAllWarning               PASS      28.63 seconds
> CheckSparse                   PASS      27.53 seconds
> BuildKernel32                 PASS      25.59 seconds
> TestRunnerSetup               PASS      567.27 seconds
> TestRunner_l2cap-tester       PASS      27.85 seconds
> TestRunner_iso-tester         PASS      38.54 seconds
> TestRunner_bnep-tester        PASS      6.42 seconds
> TestRunner_mgmt-tester        FAIL      113.62 seconds
> TestRunner_rfcomm-tester      PASS      9.34 seconds
> TestRunner_sco-tester         FAIL      14.29 seconds
> TestRunner_ioctl-tester       PASS      10.37 seconds
> TestRunner_mesh-tester        FAIL      11.55 seconds
> TestRunner_smp-tester         PASS      8.52 seconds
> TestRunner_userchan-tester    PASS      6.59 seconds
> TestRunner_6lowpan-tester     FAIL      8.58 seconds
> IncrementalBuild              PENDING   0.34 seconds
>
> Details
> ##############################
> Test: CheckPatch - PENDING
> Desc: Run checkpatch.pl script
> Output:
>
> ##############################
> Test: GitLint - PENDING
> Desc: Run gitlint
> Output:
>
> ##############################
> Test: TestRunner_mgmt-tester - FAIL
> Desc: Run mgmt-tester with test-runner
> Output:
> Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4
>
> Failed Test Cases
> Read Exp Feature - Success                           Failed       0.107 s=
econds
> ##############################
> Test: TestRunner_sco-tester - FAIL
> Desc: Run sco-tester with test-runner
> Output:
> WARNING: possible circular locking dependency detected
> 7.0.0-rc2-g4eb3d58cb92c #1 Not tainted
> ------------------------------------------------------
> kworker/u5:2/117 is trying to acquire lock:
> ffff888001abe240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_=
connect_cfm+0x358/0x8d0
>
> but task is already holding lock:
> ffff888002090c20 (&conn->lock){+.+.}-{3:3}, at: sco_connect_cfm+0x22d/0x8=
d0
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #1 (&conn->lock){+.+.}-{3:3}:
>        lock_acquire+0xf7/0x2c0
>        _raw_spin_lock+0x2a/0x40
>        sco_sock_connect+0x4d7/0x1280
>        __sys_connect+0x1a3/0x260
>        __x64_sys_connect+0x6e/0xb0
>        do_syscall_64+0xa0/0x570
>        entry_SYSCALL_64_after_hwframe+0x74/0x7c
>
> -> #0 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}:
>        check_prev_add+0xe9/0xc70
>        __lock_acquire+0x1457/0x1df0
>        lock_acquire+0xf7/0x2c0
>        lock_sock_nested+0x36/0xd0
>        sco_connect_cfm+0x358/0x8d0
>        hci_sync_conn_complete_evt+0x3d3/0x8e0
>        hci_event_packet+0x74f/0xb10
>        hci_rx_work+0x398/0xd00
>        process_scheduled_works+0xb16/0x1ac0
>        worker_thread+0x4ff/0xba0
>        kthread+0x368/0x490
>        ret_from_fork+0x498/0x7e0
>        ret_from_fork_asm+0x19/0x30
>
> other info that might help us debug this:
>
> ...
> BUG: sleeping function called from invalid context at net/core/sock.c:378=
2
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 117, name: kworker=
/u5:2
> preempt_count: 1, expected: 0
> RCU nest depth: 0, expected: 0
> INFO: lockdep is turned off.
> CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-g4eb3d58c=
b92c #1 PREEMPT(lazy)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.=
1 04/01/2014
> Workqueue: hci0 hci_rx_work
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x49/0x60
>  __might_resched+0x2ea/0x500
>  lock_sock_nested+0x47/0xd0
>  ? sco_connect_cfm+0x358/0x8d0
>  sco_connect_cfm+0x358/0x8d0
>  ? hci_debugfs_create_conn+0x190/0x210
>  ? __pfx_sco_connect_cfm+0x10/0x10
>  hci_sync_conn_complete_evt+0x3d3/0x8e0
>  hci_event_packet+0x74f/0xb10
>  ? __pfx_hci_sync_conn_complete_evt+0x10/0x10
>  ? __pfx_hci_event_packet+0x10/0x10
>  ? mark_held_locks+0x49/0x80
>  ? lockdep_hardirqs_on_prepare+0xd4/0x180
>  ? _raw_spin_unlock_irqrestore+0x2c/0x50
>  hci_rx_work+0x398/0xd00
>  process_scheduled_works+0xb16/0x1ac0
>  ? __pfx_process_scheduled_works+0x10/0x10
>  ? lock_acquire+0xf7/0x2c0
>  ? lock_is_held_type+0x9b/0x110
>  ? __pfx_hci_rx_work+0x10/0x10
>  worker_thread+0x4ff/0xba0
>  ? _raw_spin_unlock_irqrestore+0x2c/0x50
>  ? __pfx_worker_thread+0x10/0x10
>  kthread+0x368/0x490
>  ? _raw_spin_unlock_irq+0x23/0x40
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x498/0x7e0
>  ? __pfx_ret_from_fork+0x10/0x10
>  ? __switch_to+0x9e4/0xe50
>  ? __switch_to_asm+0x32/0x60
> ...
> Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
> ##############################
> Test: TestRunner_mesh-tester - FAIL
> Desc: Run mesh-tester with test-runner
> Output:
> Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0
>
> Failed Test Cases
> Mesh - Send cancel - 1                               Timed out    1.859 s=
econds
> Mesh - Send cancel - 2                               Timed out    1.996 s=
econds
> ##############################
> Test: TestRunner_6lowpan-tester - FAIL
> Desc: Run 6lowpan-tester with test-runner
> Output:
> WARNING: possible circular locking dependency detected
> 7.0.0-rc2-g4eb3d58cb92c #1 Not tainted
> ------------------------------------------------------
> kworker/0:1/11 is trying to acquire lock:
> ffff8880026e5140 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockde=
p_map+0x75/0x180
>
> but task is already holding lock:
> ffffffffb6e4d7a0 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0=
xd/0x30
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #4 (rtnl_mutex){+.+.}-{4:4}:
>        lock_acquire+0xf7/0x2c0
>        __mutex_lock+0x16b/0x1fc0
>        lowpan_register_netdev+0x11/0x30
>        chan_ready_cb+0x836/0xd00
>        l2cap_recv_frame+0x6a06/0x8920
>        l2cap_recv_acldata+0x790/0xdf0
>        hci_rx_work+0x500/0xd00
>        process_scheduled_works+0xb16/0x1ac0
>        worker_thread+0x4ff/0xba0
>        kthread+0x368/0x490
>        ret_from_fork+0x498/0x7e0
>        ret_from_fork_asm+0x19/0x30
>
> -> #3 (&chan->lock#3/1){+.+.}-{4:4}:
>        lock_acquire+0xf7/0x2c0
>        __mutex_lock+0x16b/0x1fc0
>        l2cap_chan_connect+0x74e/0x1980
>        lowpan_control_write+0x523/0x660
>        full_proxy_write+0x10b/0x190
>        vfs_write+0x1c0/0xf60
>        ksys_write+0xf1/0x1d0
>        do_syscall_64+0xa0/0x570
>        entry_SYSCALL_64_after_hwframe+0x74/0x7c
>
> -> #2 (&conn->lock){+.+.}-{4:4}:
> ...
> Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0
> ##############################
> Test: IncrementalBuild - PENDING
> Desc: Incremental build with the patches in the series
> Output:
>
>
>
> https://github.com/bluez/bluetooth-next/pull/56/checks

Ive got the following error while trying to apply this change:

Applying: Bluetooth: Add Synaptics 4384 Chip Support
WARNING: DT compatible string "brcm,bcm4384-bt" appears un-documented
-- check ./Documentation/devicetree/bindings/
#22: FILE: drivers/bluetooth/hci_bcm.c:1597:
+    { .compatible =3D "brcm,bcm4384-bt" },


--=20
Luiz Augusto von Dentz
