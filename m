Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBC319D08F
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 04:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776831183; cv=none; b=U2djFayZfdKf4QzXpe2K9qY4hGIDuahHf5h30bhUzYCWE8QObUlE/z9bmrulvMxbq/Vh/TZrqiLg//7WBBzC0ifXq4DlfRGEnzJs3KTPpA8LIsLaclkh4fGo8n0TsyhTnRecp8A9jMMzTVnHuGzjC1Qz0a57TA1Kk/0lfXBAOp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776831183; c=relaxed/simple;
	bh=9y7XRhJEp5wuYMvaxlzerJn65yq/tiXNQElUmHqc4F4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CSMneft03oEmsPo1FP8gJNSHZLPV+4OzGU4/JADm2ZM955AtXHLMbVck6xqTz5UQy3z+6ERnwww7c9cTQM1Ik+zOt2RD7dCkOBckByIXsMn9+sJeuWbNNuU449yiDxGQ6HfDV4gsWt3lTcLP9KBfDyNswRWX2oYVN65a7JHDUPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOoJdcLx; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOoJdcLx"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2c15849aa2cso6726791eec.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 21:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776831181; x=1777435981; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jh5leIYemjquIKDeoLUe1Rnp1ZNkc24YE0jDdmnMQCE=;
        b=kOoJdcLxUrALNdyyRHTjXct6/YLb2GR/Af22Cl374zWpmLGCeOMr2ykPu4miXpI1fP
         TsnLXRYrTXGOkK6xg9y90lv6ChRWexK9TSMjZRGMZrVHDdmwr+EATFcrINE3zyCueXsq
         uAL+cUXRPo+jzlSYwfBAos0Wj2Jk2UPKUpUkG9mRKKQoKBSZvYd5A71+sdqPNUfKPjgq
         teh26yaiPMlTkdbGOKHdBFbUx5L3W+qdXXUPe0u2YThbi0VFFNz6eFvI+NKnpD6furBi
         xWw2U8hzGA8KrhjjP9fTnh0Nsy8+D1vO3uVBDjm44LqyM7pqIzGnlc7VQbAENQeLrphc
         6IOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776831181; x=1777435981;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jh5leIYemjquIKDeoLUe1Rnp1ZNkc24YE0jDdmnMQCE=;
        b=esKjhYw4Pp8wS2bWYmzL8o3vZO5Lts9eglz+XlZmXmBJ7CwmwlcVHmsFYWZXD/Em1O
         ILPQMYvxaYiSB5TjD/XhlB3xr0UgEcQrJWXR3XSUAPDvUkq2LlEkov1VNXZe6TB2w0xr
         5MCVhzIdQUVF5YMwgj5Wau6hLfKytvIF3Mi/yYXUtidvLTI17gTXOrV1JNR+0xFgykik
         f3ZalMXckM427mNtM+Sr2221rxEzDwymMNiioPQCSYzasZuwZMYaGTrUiy1IrRxADE7m
         gtBPaS06Xw9+13n7rJ3TKpHnYJQ/NFFEYVz76wumwqzQR+yN3Ekkb1e8fkK8o7ul0quC
         1Jbw==
X-Gm-Message-State: AOJu0YwMEEtP9y7jwcn7sokksLLHpUT9IMLxkkwi4tmtiA+vm6yVuYsK
	7DAnvZVDJK+QZDcS36nc2VD6Oh9/ZPaqPYT3vo1Ka1pH0DtTbuz11DxuGfAlkg==
X-Gm-Gg: AeBDievV2cziSqmm88u+BbyiiepKa4M038o008mbH91z8AOtrzUeq0X9Kabdyjo+1sC
	noOYGkF/ctVKHQHa42Q/TRqJ7j+hQXBlEjNRwYKiODYpjWyYwoFzkuEc8inZBk5NlB7GWo3p6dI
	sG1Nxol0HOUGhgmbrBgD2cR/5VLgV2BVwZ/k6i/uIjE4K1PJOPe0lMV3w2D208lvsKruDd7QEcS
	h+0YvCSLx6K12NEEhvuqO84iZCKaJ8AX7jTCwXJ//69bSCHXPTQGQlhtItmtWbCvBnFBaA140v8
	cXoYWvzIm3Zw8kl2e/w6Rf5XtJFq1i0+zj3j8G2U3J7cYrAogH++GZf23WWQd60cRDlfbPrzqIg
	LnvgugMvhJnl9s5xMGpuj3hEGGSY8VMUMqcwfvMT/8Vb3WLt/q6eIzdCPNY5yqcY49jZPdSXdhp
	qBZuExG4CgtUSK03i1/CxiIq8mQg/cIr3EIrnpuvmUHZaYHA2yBiO/1Q==
X-Received: by 2002:a05:7300:dc88:b0:2be:171c:5048 with SMTP id 5a478bee46e88-2e4646cbd46mr9839251eec.5.1776831180806;
        Tue, 21 Apr 2026 21:13:00 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.174.144])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d8b944bsm21971305eec.28.2026.04.21.21.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 21:13:00 -0700 (PDT)
Message-ID: <69e84acc.050a0220.90519.d55b@mx.google.com>
Date: Tue, 21 Apr 2026 21:13:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4375540695261286705=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, michael.bommarito@gmail.com
Subject: RE: Bluetooth: HIDP: guard session->conn in hidp_connection_del
In-Reply-To: <20260422011437.176643-1-michael.bommarito@gmail.com>
References: <20260422011437.176643-1-michael.bommarito@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4375540695261286705==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1084091

---Test result---

Test Summary:
CheckPatch                    FAIL      0.55 seconds
GitLint                       PASS      0.20 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      26.22 seconds
CheckAllWarning               PASS      28.58 seconds
CheckSparse                   PASS      27.49 seconds
BuildKernel32                 PASS      25.59 seconds
TestRunnerSetup               PASS      574.90 seconds
TestRunner_l2cap-tester       PASS      27.87 seconds
TestRunner_iso-tester         PASS      42.34 seconds
TestRunner_bnep-tester        PASS      6.48 seconds
TestRunner_mgmt-tester        FAIL      114.28 seconds
TestRunner_rfcomm-tester      PASS      9.83 seconds
TestRunner_sco-tester         PASS      14.50 seconds
TestRunner_ioctl-tester       PASS      10.22 seconds
TestRunner_mesh-tester        FAIL      12.18 seconds
TestRunner_smp-tester         PASS      8.81 seconds
TestRunner_userchan-tester    PASS      6.92 seconds
TestRunner_6lowpan-tester     FAIL      8.68 seconds
IncrementalBuild              PASS      25.52 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: HIDP: guard session->conn in hidp_connection_del
WARNING: Non-standard signature: Assisted-by:
#140: 
Assisted-by: Claude:claude-opus-4-7

ERROR: Unrecognized email address: 'Claude:claude-opus-4-7'
#140: 
Assisted-by: Claude:claude-opus-4-7

total: 1 errors, 1 warnings, 0 checks, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14533271.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.112 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.627 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc7-gcdeca5510265 #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff888002735940 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffff9d84f9e0 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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


https://github.com/bluez/bluetooth-next/pull/115

---
Regards,
Linux Bluetooth


--===============4375540695261286705==--
