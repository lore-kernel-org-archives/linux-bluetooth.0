Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BA4274FDF
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 19:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786132758; cv=none; b=jRgGBzQ9AG++tk97w9eTCmpmhtnZI30ryyqRgMuLONNvj32EQW3ZqwXSJLgrublfamghZzL8qq+AJ2w67jslmoAXvc/Drb35LemgsGr6jEoAJIB1ceDTW83G6ZPCF6sK5vF6DNCaOxw5SG9IUOz9yt62YfAC4uhriu0mtvWaYhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786132758; c=relaxed/simple;
	bh=b4BHj+4gdHwW29zVyxM+8Ti+NCymQMVOXc+AY6iYObo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=c0GxnfqWGeJp/YnGY1o7IQSPYy7GU9dWT4hWZqF7uCdNkBPox6LU8uccljtLWAtcEgK9NLaseimexB8SdDS/YD35VezvbSmZaUMqv6U6o9YLl/H5tdK3B5tD0ZPMeuKt0cnUZBUOh1HUj+qzDzdAZurKn13dicRadnrcD2brqaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbLXyau8; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbLXyau8"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-448de0cc236so2575922fac.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Aug 2026 12:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786132756; x=1786737556; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Dkj7z4IAYKakvv67Y+YL5o7M8mzR/Pim0eCM7vHZ1Xk=;
        b=kbLXyau87DHB+7QN/WKuxTC6FoAtGR6i8MY/uB2gJ6/rBcIdugsVDEazwp7nVWlCVK
         o+vw7rmy2R2vsfQwIN2cyihokENWYG/rykS05lPSZ2q8Obo5hsxcKNMDjxJ0Ao8BBFvN
         THL9PK1veS1ZEUx1plX/v4mlNFfyVAKcO2tXDAtOMkYCKq/pRDZPIMBe6cmLfpEIOCQ5
         aJ5/284os3lPN9hxH1vPkf20gwYRZvsZ3ZDZaDmu74yoTBml/nQyKa8umeu9zwt4DD6L
         hrL+V4tnc/m3NvWNfwsoBhcPfP82U5GOcTiCt0j/psEB7cMmHkkrrFNyVxOPlnF3tQRv
         JvkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786132756; x=1786737556;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Dkj7z4IAYKakvv67Y+YL5o7M8mzR/Pim0eCM7vHZ1Xk=;
        b=CySJCjgyIaXCxyXXQ/cN4h302XxXJAQsP5fWmrm7Cu4Q0aPisl/o2vgjIudhaHPNZA
         M8OsRhWFE51/UltVDZvUrj6EYHYrG8jJSAGLP/GpKtLJvbq97njHu6lbicla2I5yBKuY
         o912GOtLE1WbGl6B3i+WDyE+CNbas2RrvjAkPkXGUoC2BqBCN9QZ+v4sUmosKnzY17ev
         P2LLt03CQZUH+jaiJazTmwFBmhkFzWU5FWurowYQAbUp53gVPZEi18hvwXArbMBFBaPo
         078JG17xX2pxwpZdko2RxC06Vriyg6kpJJjRvmxtZo/tWsRP89+/7NXmIpgGf7lPps+6
         o0Ow==
X-Gm-Message-State: AOJu0YySOC77PuXtj1aumX/hElJm6HC5mqnQeS5xbD1E8YA2aV5bFlxY
	/cLFTpbYB112V4dmBrQn7+Va061qJgKlFiDyKSSvL2MJaYWaY39+af/9kGzmMybx
X-Gm-Gg: AR+sD10Tdd/GC/PIS3JaYIZSJ+2mul7IxFpkA4QTmrMXtt1bO4mnw02yjpRmAVFxRSN
	B9HHIqQ3QSDk5IDsYpChC0LMCDrk5KxcH6T4zi4adABESdzaEJaQxpWcidR7hvOtZxLWPf8fFOH
	2e/I2n/HYLgKTcGeV9LUOzlPXO3rBX2Ls/mXBKGqrVd+QieKlvY7rbPNU3/bBsUWlssg4MREp/G
	EdE1Sv6n5sOfKZErDzOnT/WC03KXCoHN+DHNKbGCFGaiwB0Ii6h+IP4+rrRlFsDNl1K1+CIU+L6
	8oC5hzdsQBQEvmbC+u6a2jZvBWqUjfpAkd5N5OYycAOZndGP5Elft1w1GIEGT4FARDsbL+d3iJP
	Cv6jRrT7Rw9adkYjEu3va74xLcuqaQiC18xZ2/cUn7Q/pjT8dyE+E+8/i6Eg8hOv2Pit0l5K+y2
	2VGY8xV4B+ltP06Bl5fHl002ryL0jqYBAW9TvBwIMFELOBW0qYv/bcADDFu7UBLMt86jcQ
X-Received: by 2002:a05:6870:b2ce:b0:43b:4d09:5bab with SMTP id 586e51a60fabf-4599eab02efmr13909822fac.4.1786132755749;
        Fri, 07 Aug 2026 12:59:15 -0700 (PDT)
Received: from [172.17.0.2] ([132.196.80.145])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-459f1e2d668sm2745093fac.14.2026.08.07.12.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 12:59:15 -0700 (PDT)
Message-ID: <6a763913.997c261f.28bb30.29d6@mx.google.com>
Date: Fri, 07 Aug 2026 12:59:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7713565807498427101=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pashpakovskii@salutedevices.com
Subject: RE: [v1] Bluetooth: mgmt: fix 'hdev->discovery.uuids' NULL dereference
In-Reply-To: <20260807185456.336042-1-pashpakovskii@salutedevices.com>
References: <20260807185456.336042-1-pashpakovskii@salutedevices.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7713565807498427101==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1142386

---Test result---

Test Summary:
CheckPatch                    PASS      0.80 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.26 seconds
SubjectPrefix                 PASS      0.55 seconds
BuildKernel                   PASS      24.26 seconds
CheckAllWarning               PASS      26.68 seconds
CheckSparse                   PASS      25.40 seconds
BuildKernel32                 PASS      23.34 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      450.69 seconds
TestRunner_l2cap-tester       PASS      63.40 seconds
TestRunner_iso-tester         PASS      79.90 seconds
TestRunner_bnep-tester        PASS      18.53 seconds
TestRunner_mgmt-tester        FAIL      219.06 seconds
TestRunner_rfcomm-tester      PASS      25.06 seconds
TestRunner_sco-tester         PASS      30.81 seconds
TestRunner_ioctl-tester       PASS      26.04 seconds
TestRunner_mesh-tester        FAIL      25.87 seconds
TestRunner_smp-tester         PASS      23.13 seconds
TestRunner_userchan-tester    PASS      19.44 seconds
TestRunner_6lowpan-tester     PASS      22.71 seconds
IncrementalBuild              PASS      22.52 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
BUG: sleeping function called from invalid context at ./include/linux/sched/mm.h:323
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 37, name: memcheck-amd64-
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
4 locks held by memcheck-amd64-/37:
 #0: ffff88800272c240 (sk_lock-AF_BLUETOOTH-BTPROTO_HCI){+.+.}-{0:0}, at: hci_sock_sendmsg+0x409/0x2140
 #1: ffffffff87ecdf58 (mgmt_chan_list_lock){+.+.}-{4:4}, at: hci_sock_sendmsg+0xb95/0x2140
 #2: ffff8880028540b0 (&hdev->lock){+.+.}-{4:4}, at: start_service_discovery+0xcc/0xa70
 #3: ffff888002855098 (&hdev->discovery.lock){+.+.}-{3:3}, at: start_service_discovery+0x77d/0xa70
CPU: 0 UID: 0 PID: 37 Comm: memcheck-amd64- Not tainted 7.1.0-rc6-gac83b5e5eef3 #1 PREEMPT(lazy) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 ? start_service_discovery+0x79f/0xa70
 __kmalloc_node_track_caller_noprof+0x2c3/0x560
 kmemdup_noprof+0x21/0x50
 start_service_discovery+0x79f/0xa70
 ? __pfx_start_service_discovery+0x10/0x10
 ? _raw_read_unlock+0x1e/0x40
 hci_sock_sendmsg+0x193e/0x2140
 ? check_irq_usage+0x5d4/0x9f0
 ? __pfx_hci_sock_sendmsg+0x10/0x10
 ? __might_fault+0x112/0x170
 ? lock_release+0xc6/0x260
 sock_write_iter+0x43e/0x4e0
 ? __pfx_sock_write_iter+0x10/0x10
 ? __wake_up_common_lock+0x41/0x60
 ? lock_release+0xc6/0x260
 do_iter_readv_writev+0x3cb/0x780
 ? __wake_up_common_lock+0x41/0x60
 ? __pfx_do_iter_readv_writev+0x10/0x10
 ? __import_iovec+0x382/0x5d0
 vfs_writev+0x20d/0xb70
 ? __pfx_vfs_writev+0x10/0x10
 ? __lock_acquire+0x50f/0x1df0
 ? posixtimer_queue_sigqueue+0x171/0x230
 ? __might_fault+0xbb/0x170
 ? find_held_lock+0x2b/0x80
...
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.248 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.647 seconds
Mesh - Send cancel - 2                               Timed out    1.982 seconds


https://github.com/bluez/bluetooth-next/pull/551

---
Regards,
Linux Bluetooth


--===============7713565807498427101==--
