Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB36A95E
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 04:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776745108; cv=none; b=V88sjYM7vbsancGDeZqzT7b0xrxx7DKRh7rvQzwYN5Ys7HK/BXj92X36E2y0VLojo3OzALgHuvtvXvTDbmdeSFQiDcq3jtIovP+P9habQeOeult6zwHRyMdHMf8NsdVo4LXd7BSoL/z8kdAY0dQORmZJOEXc3rDVvWiJaz4I2lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776745108; c=relaxed/simple;
	bh=pxlqwKGINRc+PuDsy85W7/3vKrqNnPXPxHTWBlF0TDk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ds4kjgTAI7TepmvBr//MD/RcQTm7eCf/M+rL1lN0Jwr5QQdL3YTZ9Zf94cALTR4ApEZLg/Smz0yKYsAdES7Ybir0dUfGvYA/o0LXGRteG1zLwmr5By0RKubTj5k7pDLGJGVPyvMgb20Wp+2LdK1Cij+5NTl+AwIMxpomfOOegQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVrmFMid; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVrmFMid"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cb3bae8d3eso328670785a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 21:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776745106; x=1777349906; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iliGwzEas+Ti/Ojkz7vELTGjozbpo8mkgdBvVCcBJv4=;
        b=mVrmFMidlNr+2pmPcmKC0jrax9rpIi3dYZ/Yi+ZiczBBQzw1HLbBZRRbtOCSRI942N
         z7xqwEamgew7i+2gzLwMnPFaFpXZjST5amnW1UlXY1HNbeNdOZ0zVNXmPdxKHPcA6gcK
         GlFWlY2f/+/9nzC2g1a8y6vr4NuAx+PAXHgJqXa3OzWyKp7JO0t4km+9IhThQynE9BaT
         9Hp1Ridpz3pjjEmIkcd5VgteQ4pTPRNOg/ygLp/OlTVgq+mGKOJXr+khKcgTPFXAsYy2
         RoZcGTyVd4LPcYL7NSKyZW1ir17ndzcGhNXMhGXp7wpJqq23TsVkgE29rKDjXzCA0fxK
         bqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776745106; x=1777349906;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iliGwzEas+Ti/Ojkz7vELTGjozbpo8mkgdBvVCcBJv4=;
        b=sGVBE+pd/Jij3xQdZIxCZaQE3rgX2OigJC8sx2OeNzuj4zQRwNh5Ls14VXFv3SIM21
         30kt8CTsW9P1a6R56RCJXDFH6DhYePxMaqFUhfCqaEDAj/9IXpI43FUh6FDF9P6D6ij5
         MvIa6b+m66225vuJBXBRqy0OBX+Ec8Wm6R03L0VRGVd57HE0cm4j5gwot7/z0nv4grwi
         d+oLgSNJUsaR7BXpbgxL7366QQv93DuujKIK8RNImEElN2HoICDjPzyqjek6aV6khcxM
         7avLi7n15pX6TOiHGOfTB7S6C8V3zkUbUe8bzYSa1swTFwerJAB89V4TybuXgBydsGaO
         eiWA==
X-Gm-Message-State: AOJu0YwB+m3zYtIpIeLwp9S3gC6QJJ2bkCaln+1MMA49Ou5rlpdOjlnD
	IzubFJcv1b7i/0jsIoQJGoi5NeDPtQMnaAlP5seHKnARB6nh9nlAlKguDgIvag==
X-Gm-Gg: AeBDiesVGNanabXKgOIQgGpc8m0oSb6riMd183AHwKyCtOLtOC9Q0VRp9lCKIA62ZbX
	1bjQ/rsooxeOeHhyIB0Sb4sW72qudeBkkmjGVmxMyhMTupLj0ZjYFhPAHI0NBnTOXqqPFEYAR65
	Uj8Pnni/Nc6+VoopFr+G26RLwmsT83MXox/TqRptz6ptAdGSY6yTxF4JiyqcdYLtcZtBKOb6Fzl
	2Y3W2avXuWwYF2/ajMlJ+WeUIxRAeLewJIYQT1MH7LgV2akNhTCNoQ4H9pfbuJfgZffijKvEHIB
	pj3crHP0sOguGFs1pqhftY5NMoNi4I1faRDusKkVzI9DPPlevUC8xtTWP3cQJzEmTvh3SQuQrTZ
	k1XCcNm7SpGoiJbcTzVof0xhbUKFEicXTJ+bjKF9wam2LStdbB1thLztnyK2jUskKFGgAnnFBM9
	Y/O51da0At3r7nDAx7mSn5UBWUP5yTegDosoqGL01LHfQ=
X-Received: by 2002:a05:620a:290c:b0:8cd:923a:87a0 with SMTP id af79cd13be357-8e79011cc38mr2464789985a.21.1776745106010;
        Mon, 20 Apr 2026 21:18:26 -0700 (PDT)
Received: from [172.17.0.2] ([172.174.188.181])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ebce6ef86dsm305177585a.30.2026.04.20.21.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 21:18:25 -0700 (PDT)
Message-ID: <69e6fa91.050a0220.118db2.b482@mx.google.com>
Date: Mon, 20 Apr 2026 21:18:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4174517719865729101=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kuba@kernel.org
Subject: RE: [net-deletions] net: remove ISDN subsystem and Bluetooth CMTP
In-Reply-To: <20260421022108.1299678-1-kuba@kernel.org>
References: <20260421022108.1299678-1-kuba@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4174517719865729101==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1083566

---Test result---

Test Summary:
CheckPatch                    PASS      13.02 seconds
GitLint                       PASS      0.47 seconds
SubjectPrefix                 FAIL      0.14 seconds
BuildKernel                   PASS      28.12 seconds
CheckAllWarning               PASS      30.38 seconds
CheckSparse                   PASS      29.18 seconds
BuildKernel32                 PASS      27.03 seconds
TestRunnerSetup               PASS      593.59 seconds
TestRunner_l2cap-tester       PASS      28.56 seconds
TestRunner_iso-tester         PASS      44.98 seconds
TestRunner_bnep-tester        PASS      6.62 seconds
TestRunner_mgmt-tester        FAIL      116.17 seconds
TestRunner_rfcomm-tester      PASS      9.66 seconds
TestRunner_sco-tester         PASS      14.67 seconds
TestRunner_ioctl-tester       PASS      10.62 seconds
TestRunner_mesh-tester        FAIL      12.27 seconds
TestRunner_smp-tester         PASS      8.89 seconds
TestRunner_userchan-tester    PASS      6.99 seconds
TestRunner_6lowpan-tester     FAIL      8.73 seconds
IncrementalBuild              PASS      27.11 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.115 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.394 seconds
Mesh - Send cancel - 2                               Timed out    1.992 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc7-g9259e7c11b57 #1 Not tainted
------------------------------------------------------
kworker/0:0/9 is trying to acquire lock:
ffff8880026d9940 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffff9144f960 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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


https://github.com/bluez/bluetooth-next/pull/107

---
Regards,
Linux Bluetooth


--===============4174517719865729101==--
