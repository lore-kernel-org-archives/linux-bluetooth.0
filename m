Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE04A34CFCA
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 12:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776341166; cv=none; b=gxCnvFYPNd6wg0VN7+cGrmfOJUxwxRbNTcdfhkyK/u/JpWCdQuSmBFspMFXI4H3lGBGLw9vq2wMhw7Z30TDRNWqoB3RdpjTtVgiL68tDcMsOVq2Krg1846kuWayEY/Y26pGWc1iHj6D7VzAtgCH/Sex4V8zQLNlm1FOpojSy92o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776341166; c=relaxed/simple;
	bh=Ck+SXkNDsTSTtHoZCZZQM4HEdtcQ88/XIzavzgZgpas=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=g0gzHZ/Gt/Uuxs40Mt1KAw+QyNTyyfD7vLwfz8X8E3BLi8VN9k+i+TpdtO+L/tmqvNUazpE2iAF6A18Dq+0VGBbK0oPspMJPwIYkg8VfO9yw2oqwimAb4TiBxBJFIaV2W9z45DOZPNdaSKOPOSt8u1XD010t+H0yAGUgfWUlTbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CtfA+K98; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtfA+K98"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-56d95bc93e3so4695525e0c.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 05:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776341163; x=1776945963; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y8hwdKfcmB5LzedRGFceRfqYZ6Z4G0OTyyjfH2iu+As=;
        b=CtfA+K98xd7gIyoZ4dP4u+DqpZ98LVEP1kbb9CcvhPOkii1Z4XOEDMNKV5GLaQ1KUA
         qjat+xNulHs6BCb6bNDouF9c2W8/QZc21GEwXcBHol/Cp8ob6ZHjWqSSnkpcubX3Qzp3
         CYspz7GYYzGW8WiZ9f+nkzTo8f4WQgXzYChi6OAJmViAcpOypnemXBGLWpNbjrvLGsOo
         3Z8g2D3NlxmWy9SUoVqxoaTbczU8HBHhcrlkb/uegJ6TnDiJPVx7URwM6Uq2Dz1hn0Mz
         9oD4EZuyyP0wR3HY7sehlNikuyC40KDIX7KBZKrlQNM9BHZDlcFfRRUdLQ1w1fyiOaRt
         tqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776341163; x=1776945963;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8hwdKfcmB5LzedRGFceRfqYZ6Z4G0OTyyjfH2iu+As=;
        b=XDZCzigpEXZf7rI089Z6MHnsUAcLG6dXxboaOB75j6Pwvwi8Wr36XxLF95Ciq+V5A/
         uFU+cX8x5wQcgRhFpyaEiX3mzoYzwDzajFLOWbJ36FWFOrOUv3QzvNjy22k+K0Vt1OhO
         cL/OVHaVDvbKf9ZT9sQlVNDgQNAjAsuvFS4VxkGWW83GZ+g9i1sYOsxtFluHcDV+J3D8
         rHGg5I7SZWrrcd5aVh5drEvPnE5T03uvHOh9Hff3R1byWHFkdhvKqXkmi2myb2J8q49a
         erXLHmJV01sgMi2sTiFWaW5XNMYDWcSFzJl+DeM+FAW2N83cYqkKvz2ELGOrdua/R+l1
         iqYg==
X-Gm-Message-State: AOJu0YxMk/6MZTfzBua5/rFQmDah5KtCKGuKwnNYHs3wAs3eywprT05C
	iq5emlr8qwEekH7wBitj2tuKl875nXkHw7vc/csnHo67K0HWr1vcPmbzsgDtfVD+
X-Gm-Gg: AeBDiet7NuzdCRjzHcDWqZhcwbm0Iw2ZVBpjm0Rp7oM6MSGZDPQqOr3MfJf7gpXwUOo
	aUA5VgFu8ipT2irL4UDTx1rZZO188bN9mppd0h3La7cElk99GNSL+IgwQi46k0UN4kbb51dnIPl
	UVT+/gN5pmlrhD+K9Qy1DoFNz1xaDDU9VWHlgmHj04o4vWMeqaECgbhUk7nI2V17d1j9AwFUrwd
	QNKR7fem5Wdh/i2EezAxQgH85gpwuyIg0q5naawfGb24nq0iaP+o4wuKIfiV3ZudlTkj68ywsLd
	t+2v+Mu9+pBLWTFZZqFQH0QU2OJ9e4L7Nq99egHT8FIg3FAjbh+ADjJX3GL4I9YJxxC40dtdEja
	aGd4Fo8t2e8P7sJ2GG+GqYVbj3Rj3UTgTddXDmnlKq/D+Y7HfxTF8OKX318qv0VTDiBq+drUZnF
	1KLXZauVx3eVI8UIJ/wMWe9/wNkvKf/fZALdkCVxseSwWWmORiumf7
X-Received: by 2002:a05:6122:45a6:b0:56a:ef51:4cae with SMTP id 71dfb90a1353d-56f3bb8a321mr12673308e0c.4.1776341163308;
        Thu, 16 Apr 2026 05:06:03 -0700 (PDT)
Received: from [172.17.0.2] ([135.119.236.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ae6c93b7e2sm34840486d6.8.2026.04.16.05.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 05:06:02 -0700 (PDT)
Message-ID: <69e0d0aa.0c0a0220.2313ac.ed68@mx.google.com>
Date: Thu, 16 Apr 2026 05:06:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3946892756762260452=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: [v4] Bluetooth: btmtk: add event filter to filter specific event
In-Reply-To: <20260416111607.3161032-1-chris.lu@mediatek.com>
References: <20260416111607.3161032-1-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3946892756762260452==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1081995

---Test result---

Test Summary:
CheckPatch                    PASS      1.15 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      26.95 seconds
CheckAllWarning               PASS      29.74 seconds
CheckSparse                   PASS      28.13 seconds
BuildKernel32                 PASS      25.23 seconds
TestRunnerSetup               PASS      571.64 seconds
TestRunner_l2cap-tester       PASS      27.84 seconds
TestRunner_iso-tester         PASS      40.67 seconds
TestRunner_bnep-tester        PASS      6.35 seconds
TestRunner_mgmt-tester        FAIL      111.93 seconds
TestRunner_rfcomm-tester      PASS      9.58 seconds
TestRunner_sco-tester         FAIL      14.11 seconds
TestRunner_ioctl-tester       PASS      10.15 seconds
TestRunner_mesh-tester        FAIL      11.21 seconds
TestRunner_smp-tester         PASS      8.47 seconds
TestRunner_userchan-tester    PASS      6.75 seconds
TestRunner_6lowpan-tester     FAIL      8.36 seconds
IncrementalBuild              PASS      24.48 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.101 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g6909264eba12 #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff888001abe240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

but task is already holding lock:
ffff888002141c20 (&conn->lock){+.+.}-{3:3}, at: sco_connect_cfm+0x22d/0x8d0

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&conn->lock){+.+.}-{3:3}:
       lock_acquire+0xf7/0x2c0
       _raw_spin_lock+0x2a/0x40
       sco_sock_connect+0x4d7/0x1280
       __sys_connect+0x1a3/0x260
       __x64_sys_connect+0x6e/0xb0
       do_syscall_64+0xa0/0x570
       entry_SYSCALL_64_after_hwframe+0x74/0x7c

-> #0 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}:
       check_prev_add+0xe9/0xc70
       __lock_acquire+0x1457/0x1df0
       lock_acquire+0xf7/0x2c0
       lock_sock_nested+0x36/0xd0
       sco_connect_cfm+0x358/0x8d0
       hci_sync_conn_complete_evt+0x3d3/0x8e0
       hci_event_packet+0x74f/0xb10
       hci_rx_work+0x398/0xd00
       process_scheduled_works+0xb16/0x1ac0
       worker_thread+0x4ff/0xba0
       kthread+0x368/0x490
       ret_from_fork+0x498/0x7e0
       ret_from_fork_asm+0x19/0x30

other info that might help us debug this:

...
BUG: sleeping function called from invalid context at net/core/sock.c:3782
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 117, name: kworker/u5:2
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
INFO: lockdep is turned off.
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-g6909264eba12 #1 PREEMPT(lazy) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 lock_sock_nested+0x47/0xd0
 ? sco_connect_cfm+0x358/0x8d0
 sco_connect_cfm+0x358/0x8d0
 ? hci_debugfs_create_conn+0x190/0x210
 ? __pfx_sco_connect_cfm+0x10/0x10
 hci_sync_conn_complete_evt+0x3d3/0x8e0
 hci_event_packet+0x74f/0xb10
 ? __pfx_hci_sync_conn_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_held_locks+0x49/0x80
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xb16/0x1ac0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2c0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x4ff/0xba0
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? _raw_spin_unlock_irq+0x23/0x40
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x498/0x7e0
 ? __pfx_ret_from_fork+0x10/0x10
 ? __switch_to+0x9e4/0xe50
 ? __switch_to_asm+0x32/0x60
...
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.902 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g6909264eba12 #1 Not tainted
------------------------------------------------------
kworker/0:0/9 is trying to acquire lock:
ffff8880026e0940 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffffa024d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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


https://github.com/bluez/bluetooth-next/pull/93

---
Regards,
Linux Bluetooth


--===============3946892756762260452==--
