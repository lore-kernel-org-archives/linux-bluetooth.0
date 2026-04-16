Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B6431714F
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 18:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776363074; cv=none; b=jjtzHxnvZOJAdgzsM+PMwGvQF5btSKHjIfI9WPO78PlqDcLbYBSDesxCUpvyFJRxCsIuq3cQEYJa0Nbdb394nfR2sCmiAtqHnc5T7evqlIuWfYHn+B70tcZmhaCZQ+jnFrnFeNbnQveGTPB4boW/2lmQrlofLe3T66GKAgsOh2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776363074; c=relaxed/simple;
	bh=UNH1TS3ZyXL9972Hbs9t199T4JpWtWHOnmloZRYYeDc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=P1MqZxkFC4G+rvpxgHJlLqTOptt0lsTBfVi9IvK3r5RfaHhv4zyKrCvtQF2laO+byuagpIWPA1rCY0W1rYeG9AU3n7vaGtbNy1T3mXQszpY1a3yjlLkLJcIaj3usQ1GDfoG+ZrClHUpKFoxIpX2Y4jZn6CgBEDUQCcIjvtx46Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSoBvMoP; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSoBvMoP"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2d96243c91fso2049996eec.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 11:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776363072; x=1776967872; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G537djRavLl9rKC90gdsy1EFKERlegvHjqa5+8ebn2s=;
        b=FSoBvMoP7GoE5fk6n/kXPk9fhPqhaM4b8282KA18puBeKXzmxi7WtCvt31LFKrQVDn
         uBg2+vSJF/FpZukHy6gV6b5i2TycHk9JU6Ay41CO7Wj0cDwsXQDxJScqC/YxeJtvHtQL
         kAHFAt4RKy4htvtyX6yV6vuyUCQmPu4xz2RIheqoSTizdjqI+aAKPtcVDAVxj2u+alzc
         cEmKoO9Xbj2OPVozfohGwet1C9HeT9SUe9kX8RKSD57jxqDohm/FIHiuwiMMl8VKBZtT
         iDtXVy8KIWfMHsIKk9iCfWPxrOE+LovZy60BPLmpQfJ/MA/7uPh9ZbLA+9W/VrvwuSCo
         lpAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776363072; x=1776967872;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G537djRavLl9rKC90gdsy1EFKERlegvHjqa5+8ebn2s=;
        b=G4hWG3PrcEutzKjnP8Yx0xQYwaS+6IIGHhmkpb1k+MgTZ2ex0dWgJCiLATCVe1Mbi3
         7oELS/+mvuzdnMcZt1elS4LZXMfAnBpN9aHKU26WlwyJqDYGhpMaVA2boHpJkRoJBn+Z
         o4hJ5yedaLRMGmkeGXy83l+YNz/txu0oUt2cLPaSd5ifNCRvE/ALvflMVc1rDd1VNoVt
         TUVh1rUefLTmmopkYWP7EoS1sxdgQkYlBj49mC2YMgd3pyvrExGhKebWtdeCN8WxZ8M7
         cmwk68dpdFwbITwL7V9ucNVlaogNr58Qe6+vzplG8rAFucLnQiCDzdObBYHlwxu9I/1l
         E1tQ==
X-Gm-Message-State: AOJu0Yzj8itDvcFDq8gvQNP3bDQ+OlM2K7I/QPW/dMZEVmZZWs6QsHTF
	ZCWJuzhDU6Cklfyu6ezab6X8eKzIPAP2TR6PvYYZUF1GmXv2hQ1+34atKPNu8w==
X-Gm-Gg: AeBDiese3DCHbfXhLeuppGhVD13jqZVX6rpv4DbrydyqG7ag+9gqXdUpxtoWG41h244
	YCnlR2MM6w0UoQyNVdminQBYloZHHHEfgfF/ywU06E07Jhwg8gY80GDLUvAk8YtUCIaI5Rmdoai
	Lb1D7WIc6VNeXZD2AyRya6geX72a5uj6q5tps2y+r1oYAV7GigOaJBBgHHnHVJo6Wi79npwQRha
	34Xq2PFBaFysPq0kiRL0/Bu9VSgUfI6QvAAb7bxkMzFC7bEzL+7POpFwFSpnUm/5nsKNE6tOaRj
	/ShDSUIZG7ObRS0vCli2TaEPE/dEcBDglJawPqmZSdXkLDnlOkWq3eS81LbqKOat7hmItKco8YA
	aTXwpLXy4l5z6r1M8Ny//VrX+/m/Uw8+dx1Bb6/w7QKvkqC89D17JYdUxiR9/j+hy1Vjmq1OKwy
	MD7tYiFu06/aDjKctl8+PnM4AL4bnWKXX6i8iWdRK7tPWBfDj8fDA=
X-Received: by 2002:a05:7300:a10b:b0:2d9:32c8:2b69 with SMTP id 5a478bee46e88-2e2e68cdef4mr155862eec.28.1776363072084;
        Thu, 16 Apr 2026 11:11:12 -0700 (PDT)
Received: from [172.17.0.2] ([52.250.210.72])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8eb84673sm8465193eec.19.2026.04.16.11.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 11:11:11 -0700 (PDT)
Message-ID: <69e1263f.050a0220.1ce00b.e0f0@mx.google.com>
Date: Thu, 16 Apr 2026 11:11:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7276367595190811572=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chandrashekar.devegowda@intel.com
Subject: RE: [v2] Bluetooth: btintel_pcie: Fix build error when CONFIG_ACPI is disabled
In-Reply-To: <20260416153524.1405955-1-chandrashekar.devegowda@intel.com>
References: <20260416153524.1405955-1-chandrashekar.devegowda@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7276367595190811572==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1082111

---Test result---

Test Summary:
CheckPatch                    FAIL      0.46 seconds
GitLint                       PASS      0.19 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      21.40 seconds
CheckAllWarning               PASS      23.48 seconds
CheckSparse                   PASS      22.69 seconds
BuildKernel32                 PASS      21.57 seconds
TestRunnerSetup               PASS      420.32 seconds
TestRunner_l2cap-tester       PASS      23.32 seconds
TestRunner_iso-tester         PASS      34.58 seconds
TestRunner_bnep-tester        PASS      5.01 seconds
TestRunner_mgmt-tester        FAIL      96.59 seconds
TestRunner_rfcomm-tester      PASS      7.48 seconds
TestRunner_sco-tester         PASS      11.88 seconds
TestRunner_ioctl-tester       PASS      8.47 seconds
TestRunner_mesh-tester        FAIL      9.96 seconds
TestRunner_smp-tester         PASS      6.96 seconds
TestRunner_userchan-tester    PASS      5.33 seconds
TestRunner_6lowpan-tester     FAIL      6.73 seconds
IncrementalBuild              PASS      20.92 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2] Bluetooth: btintel_pcie: Fix build error when CONFIG_ACPI is disabled
WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#95: 
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>

total: 0 errors, 1 warnings, 19 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14527116.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.076 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.143 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc7-gcac561d0a38b #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff8880026d9940 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffffbd44f960 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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


https://github.com/bluez/bluetooth-next/pull/96

---
Regards,
Linux Bluetooth


--===============7276367595190811572==--
