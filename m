Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204F526981E
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jan 2026 03:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767929835; cv=none; b=ZIXdKDBTdENDcstWXDEiDdxLHomazo1OrlQEbR2A9yEM6O6xmiNehdhkGK81b9bY8xL2W/79ksLg1UrtNgDrD61UDF3TyFhQF8lHUwFwOYQv1DphE8aAeR2RSteZEiwzlmblsNhm8L9hBCwxkt9PkOAgawTKJ35nu0sU78MqNsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767929835; c=relaxed/simple;
	bh=E4GeCCPUKh7pbZ0xv8Il0PHUTIDmRn/OP/unxfMGcqw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mORxmwm1LSb0usSZZZJ3i5U0Rs7j3Fv9Oir/kecqm2JApBeUik/fELgHJlWA/D782wqESOQE5TH6No9mwVoL8Dfkjell3NVLB4zoMXUw3vKU5YuYyk2arBuVWt2clIRkhdorEnree2GqsGtLBATQvjJeN7vNuCC6RJCTyX0EHCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKVU5FFH; arc=none smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKVU5FFH"
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-8b2f0f9e4cbso227880885a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Jan 2026 19:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767929833; x=1768534633; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AeVD6ltZqsMJI7Hmg1+oetR/YBvtJHGGGklGaWaFBIE=;
        b=gKVU5FFH4B4l5PzevsmQYxPJeexqfjE4+looswXfF3+AN1QqppOF+YqfoLudPzlUSj
         ukSwKf4kR5NC6a91gs6qDW0uvxbcjxpt5zJvay6Qc8U7EhTiIDqujxPgtyMNO4Yurt36
         mGx37ukMSUkP7oZRJbCJNNUApfOpuWRMJD0EoBYc/xuci1nkvnPuIEPmF1iFjIpKrneC
         CENUrqnFc50/yEIMQPYnp8ANt5KwxJ2JDnRKxnVzSNvj+EICljHpUOFR75aku1uc7LCO
         hMTquzHNQeh8Ad1AvQTRk1o9z5f6Ap391q4PL1M0rH8318RGyUhI2WYP3Jw/8vI36ENc
         cujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767929833; x=1768534633;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AeVD6ltZqsMJI7Hmg1+oetR/YBvtJHGGGklGaWaFBIE=;
        b=V0ioIRjGFpo9Y2H6I7tJ8RDLOFVHX1d/neqcQtGvecv7hW7UHZryqAkhS/8OHIArem
         DKrjTuop0fwk20IIvBEDHsa5qhr4Evy2NQORQ26km/DIvV04RktlC5XpIuCzSfp4PFek
         FHjloHBO7BpGDoSlugbyqzu7q0jKwmB83PnfD/xrf6jcJOBpSyCcsFMEUTW+snPcbZQZ
         EedQFfes9KzYjrfYwpr+vL1UBH52aeCRdPZ4h5iwTaiPJ0ubSTfHcs/IpRWCL7djikUE
         zkuPSZzSq6KO/EI92PM75+6WdttXq0SjjHFqovYRSngzH1ioi17Ss11aHHlVBhM8st/q
         g8TA==
X-Gm-Message-State: AOJu0Yz/Kz03PdD9s49cy+Nyq5bBC3gEsHRolChjn8EfbdOtmjxdNDdR
	gtW3LsC2AaPKFL81NXO/HMzHI4zZgfNglH/rRGnRC7RiXb7NlqAGewUHrkb90P2D
X-Gm-Gg: AY/fxX62ZnfC+f1bfSG24oOm5WBpIepQNBGIGdCQHJvjcv4MtFw2sMANj/PAVfeTj/O
	acNlcONrb0c1qClz0IUQEt5hLw0c5lVKxUyoEHFQDsMPi6mltRYtaZly+egMAGcOjNBem+NsszV
	3uMp1aqOJyzUwDCW8tx2Xtpdr60LlBSv4MWGHK2qh/WzESGRB6O2BozFrT3w2ueNA/Hvj7VvNp6
	8opMWqJuR0tLRHiwOyfj6IaNlnIzYh+HMSWQASfEGwHWrJ2ozg8r06mO3ASfXpk3y1ZQCyFiHtn
	KPmNKuuT5mRrT+YFxx+FO8ujeELCq/xkMrG/p8FdNleM05PslrAe49Xagx1ZQKn+SF7AzO9qahq
	MzNNoW0dAJs3559zq/JEYVYmz6XyCOe6/okc2Z+nLCZn3YrXIuoUHENFrE1wh2YbO2y7wqbPpqO
	IVFVtDaunQU1bP57AD
X-Google-Smtp-Source: AGHT+IEamsSthi3oH7oQjbKdohzdDwRTjLFqRyntCQiIEDFciPNa7wdBQMSiSrzHwGGnHJUFtvPRNw==
X-Received: by 2002:a05:620a:4081:b0:8b2:ed3b:e642 with SMTP id af79cd13be357-8c37f53760dmr1701122285a.34.1767929832758;
        Thu, 08 Jan 2026 19:37:12 -0800 (PST)
Received: from [172.17.0.2] ([64.236.169.97])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f54427esm762184185a.48.2026.01.08.19.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 19:37:12 -0800 (PST)
Message-ID: <696077e8.050a0220.35cb9d.ab27@mx.google.com>
Date: Thu, 08 Jan 2026 19:37:12 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5514817096911018060=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, lilinmao@kylinos.cn
Subject: RE: Bluetooth: btusb: Reject autosuspend if discovery is active
In-Reply-To: <20260109020538.2803094-2-lilinmao@kylinos.cn>
References: <20260109020538.2803094-2-lilinmao@kylinos.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5514817096911018060==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1040194

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 PASS      0.18 seconds
BuildKernel                   PASS      25.50 seconds
CheckAllWarning               PASS      27.96 seconds
CheckSparse                   WARNING   31.03 seconds
BuildKernel32                 PASS      25.17 seconds
TestRunnerSetup               PASS      554.91 seconds
TestRunner_l2cap-tester       PASS      28.19 seconds
TestRunner_iso-tester         PASS      99.62 seconds
TestRunner_bnep-tester        PASS      6.29 seconds
TestRunner_mgmt-tester        FAIL      128.33 seconds
TestRunner_rfcomm-tester      PASS      9.65 seconds
TestRunner_sco-tester         FAIL      14.81 seconds
TestRunner_ioctl-tester       PASS      10.27 seconds
TestRunner_mesh-tester        FAIL      11.43 seconds
TestRunner_smp-tester         PASS      8.67 seconds
TestRunner_userchan-tester    PASS      6.69 seconds
IncrementalBuild              PENDING   0.64 seconds

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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_core.c:85:9: warning: context imbalance in '__hci_dev_get' - different lock contexts for basic blocknet/bluetooth/hci_core.c: note: in included file (through include/linux/notifier.h, include/linux/memory_hotplug.h, include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, include/linux/radix-tree.h, ...):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.106 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.826 seconds
Mesh - Send cancel - 2                               Timed out    1.992 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5514817096911018060==--
