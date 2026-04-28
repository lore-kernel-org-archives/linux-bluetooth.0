Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EC32FF672
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 17:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777398257; cv=none; b=s+P3LEFCUqaehxpWOx76zwNYlHhuLMhtyP+H+J+r41vk2o11CWqVj5I1cT9Ap7ry0gMniDXJyIXHQn7zzlHQhrQ1u9edc2scCa4m7VpQJntwqKGJVfdgla+8L4zDPVrGJfCJvV5iB5zrsVOfenzZZ5FJnjzh0plVtsovkSBxisI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777398257; c=relaxed/simple;
	bh=F8taSmDHXwGdZTRgD3zA3Qigg/s5gjhUTwEwBiJlWB8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XJZvDsBpgbadlEFgqiLTo2AGpKvcT35BeR0qB9Wj9g8rgiqZd0gsqfbqczaXzmjgqnaTjpRyLn6INhY1nmsxQj8tkV9hUnHWFRnFZiL7wrlsBBrl3i7nIRXWfKsiszX0bMEKjtm4GNd9Hw5itkChCEYtpvUEbvAjkbg9dLz18gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hihB8Xrp; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hihB8Xrp"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12c8ccc7755so12437581c88.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 10:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777398255; x=1778003055; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L6pc/fpoVUxmNkQyMG626sBjs5ojdxr2c2Y4dcWB/DM=;
        b=hihB8XrpczixCXjbUARSdxwYK6Y9qyCyKeeHPICM+nZWsn7awwk2PBUmRwvTDHC31Z
         EqdE97CxJNtKVc9xyaWVWDJ8CO3aa2IF63IquSyhxgNxAZdqojIYjktD7iaSDeUbGDHC
         /awyQpOHpieCV/0Tz7bMSAUXzqzQE5oasYq4L7orR+RYI8ozrJv1X8Le+WqGnaZIt7KT
         4bVQ4RtYifDt8KIfWBKw+MtUbB1sfuGtgDUI376E/u3pmbjbGOsdpAiL5JnSumtniyrp
         Jttyb8Fa8yX3LZgX4T0lO5NI1ONvaw4pgFEb6tM/YTc5KEv7UzOYynmdKl5IE0+YSzbB
         lV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777398255; x=1778003055;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6pc/fpoVUxmNkQyMG626sBjs5ojdxr2c2Y4dcWB/DM=;
        b=UDqTMQLIG657MwY/6sIC7IXiXDGYj8qr4uF+X4U+GKlCHGr5oDxELaFgwfdsohXkSZ
         vLW+ldU3hIf6FNHb6zKuUV8f/+B3BsuMEUuzgieOjmPg8/OQIRfDwB7isGHdqZY0uW3o
         LCx/dpzjdGPeQZQOCk/61IUtp8SVpRnEMedDrjJE5ccIpxjfLRnLWAtFubvajMqIE9th
         /ud7Hr8MyJhw0y9QnQN7DaVfsngFDNeyMiyc/NFLrmexwz8Xic8BP3QxtznrXx2l+6VO
         X7YsUGY4oXu/hbOxp5Vp8Oc4MNjxLQzFPwYFWPWrF5Opt23u32PzdQrgN8oilHM+PEdq
         UcIA==
X-Gm-Message-State: AOJu0YxgvHQBY+e3NuMdmxlE2jQDJqT0MfW49Dy7Nc9gv70SCuEi9pLU
	2lPDsmxBaEnFcGjU7ucYMfaQVBxGOPMzBAO8u9SyzZGA6HGAb2+bypdEwxOcNA==
X-Gm-Gg: AeBDietULTDG48G8/CWKzNSVCRvDfkpUa5tDsGutQ1hzLF9r+SD/m2UPnA7+eeZa+NP
	gVtjs7rMXiG5oAIVvSmiyhjdEfb7jzT+y1/W433onZzMWtUKRj6Ywd2/xFZX2tiWbLKSxDXpICO
	R8nzDQFZRo1JF0sk3u+DGKu44sRmUJ3sIfwrAb/cdijOB2US3OIq5TOryM7bO21swX8kw4o4KM1
	Gh+bcCmUihLAQJxIM/2OqXWBZ/BvIM3gJ4wJZggKYJO/HGcRuoEGjMLfA8tYwPlvSWGw5hC/CBm
	CYlW3sS0WE6wSnuIRUX3cvxfrE/q23LdoijV6Tnxg0kUE6m6OS0EyUdGXo/I2QOfN7fdqe6m5Di
	ArQu+xDVUY0nveKA1E8No7ZgJv9RvoHbhWM5gmwr9tQdreRj3LdEIQkOUt9cIfz5UceqXwh7LjN
	rIO1DOQQpSZlNiP2Mf1KWwkVWtNiA6ClfGN0D7tPLQ
X-Received: by 2002:a05:7022:23a8:b0:12d:c3fb:14a7 with SMTP id a92af1059eb24-12ddd987d73mr1980247c88.18.1777398254251;
        Tue, 28 Apr 2026 10:44:14 -0700 (PDT)
Received: from [172.17.0.2] ([20.189.181.74])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ddd9493bcsm3459699c88.8.2026.04.28.10.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 10:44:13 -0700 (PDT)
Message-ID: <69f0f1ed.050a0220.3cfaa8.08ce@mx.google.com>
Date: Tue, 28 Apr 2026 10:44:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0258184173746160473=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, loic.poulain@oss.qualcomm.com
Subject: RE: Support for block device NVMEM providers
In-Reply-To: <20260428-block-as-nvmem-v1-1-6ad23e75190a@oss.qualcomm.com>
References: <20260428-block-as-nvmem-v1-1-6ad23e75190a@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0258184173746160473==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1086909

---Test result---

Test Summary:
CheckPatch                    FAIL      4.55 seconds
GitLint                       PASS      1.73 seconds
SubjectPrefix                 FAIL      0.59 seconds
BuildKernel                   PASS      21.22 seconds
CheckAllWarning               PASS      22.13 seconds
CheckSparse                   PASS      22.41 seconds
BuildKernel32                 PASS      20.10 seconds
TestRunnerSetup               PASS      418.01 seconds
TestRunner_l2cap-tester       PASS      23.43 seconds
TestRunner_iso-tester         PASS      28.84 seconds
TestRunner_bnep-tester        PASS      5.01 seconds
TestRunner_mgmt-tester        FAIL      96.51 seconds
TestRunner_rfcomm-tester      PASS      7.54 seconds
TestRunner_sco-tester         PASS      11.75 seconds
TestRunner_ioctl-tester       PASS      8.01 seconds
TestRunner_mesh-tester        FAIL      9.97 seconds
TestRunner_smp-tester         PASS      7.00 seconds
TestRunner_userchan-tester    PASS      5.36 seconds
TestRunner_6lowpan-tester     FAIL      6.83 seconds
IncrementalBuild              PASS      43.58 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[3/9] block: implement NVMEM provider
WARNING: please write a help paragraph that fully describes the config symbol with at least 4 lines
#194: FILE: block/Kconfig:212:
+config BLK_NVMEM
+	bool "Block device NVMEM provider"
+	depends on OF
+	depends on NVMEM
+	help
+	  Allow block devices (or partitions) to act as NVMEM providers,
+	  typically used with eMMC to store MAC addresses or Wi-Fi
+	  calibration data on embedded devices.
+

WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#216: 
new file mode 100644

total: 0 errors, 2 warnings, 183 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14544435.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.095 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.054 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc7-g6ce4c12d8e26 #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff888002735940 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffffb204faa0 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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


https://github.com/bluez/bluetooth-next/pull/128

---
Regards,
Linux Bluetooth


--===============0258184173746160473==--
