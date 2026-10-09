Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FDD1FBEA6
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 01:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791508303; cv=none; b=RpBZeqkahzU/uSpdcRlm7NwyrAy6Jsg1SKqaQ4yqMncYMVhfrXB+o2BVcpRfm7Jjt1FZSLZYXJE4TSHWcv9A4FOBGdz1lte3jSC5sIKDiTjuUChSbjv4acdR/MLOh3KMh3y7Dn2YqzUPOczJ5B9RokV6f37+Ox+GJLQeLbUZDco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791508303; c=relaxed/simple;
	bh=nAk3Mqbgll431F556Z7ThWhU4895tmtNWzf5ig8AIZQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=H8QD/tyH0MSNc6V722L77Nc5lX1woP2hlVc46WySqxm3DAMu+bDUchsFtLBacFMTDCbWQajrIc9FTXqYaESkqfH4l+qv9oQQKOGA9fqVCwDwHI2TWQVQnWHbwABwrS1CyxknDXrQeieqEivNDcpdUCMFSpXlKjDLjLjeqQfb35M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U25rDKe1; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U25rDKe1"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91b54d1e9cdso2011376d6.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Oct 2026 18:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791508301; x=1792113101; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iT6OkIQMMrM7x4xR4vBQkQ3jvrzKX9nhWZ9BnUZcnyE=;
        b=U25rDKe17EpeIvxdOuFxQ8kR+MvoCPqhUHjTQz4NvJNHcQbCmOc+zSZCy1UE7dMPsU
         9APf80vg8+gohG8vkBXe8lHyyCX8rT5i/u6e91ayZ9Jd82ZbyIyudGri5H5v3NywHxqC
         hTHgSThJMRajkZVzWxgc7KJ2431VqJibB9/E5QyIBk0r1pzFMJNpGvFHkc2Mjo9c2CTb
         G6Rk1vQwE93HwNALvLgEdiHnTxb4zRnpgFNvWuwTIjT0ITV0gh6cd39T/w/MZUQC0fcs
         8nt+2aIYTaG6oSUy77kp1HsMCffOtZncRQwoaeFE5cr+/fiYbIDVW3pc7uL5OP5uZWSE
         sU1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791508301; x=1792113101;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iT6OkIQMMrM7x4xR4vBQkQ3jvrzKX9nhWZ9BnUZcnyE=;
        b=ytPiVR3WZo6m6LPl1C0EzbUocwM65WVlxLITWBH7xhlyOAV8GEA/tjW6xhP3clfak1
         pZ7TbNUVam20fZgMn1tSEcGQZ55WJjKbiamT+1QI0LFLW3YncK842V2y5lI8vzfrFanR
         W2CKkeLicoXhxP/mcorNB16Ega7Cp+1pCdX5LAstjhJvn63YLKFj2CBkMlhSyY+skFAB
         QVKN9TL2aNXKTBb3QXw2F+ZxrtL7f/vO/fBdBQloZRgt35+1Yw9Hp/tt+ADLW+xgFO53
         1TFLgcW/+kubnddN6G0VuoFMO+0JSXNUrr8zYzjS2LjQ6E8jOO8w7IMiNx94+xi9i+zR
         iO6g==
X-Gm-Message-State: AFq9FYIYd4/xnqSmB3Cpg4JDFTJj+u/erTwSueWBNwoDSY2GwAUL3oBE
	lLrfPvKJ6jVp8TJ0Kz5gtFrfGHMBChXA/l+TdJojFHeCPSm42skttceHNkf7hw==
X-Gm-Gg: AYBFou2eXZWvC7qj/zliQutNR+sgjKrUbSDI64xra8H/cS+ZZ+iXbtbcrIrfLpQEDaH
	9p4IQTDqoQIH/5RaJfLlpM43u8OtLL67ZE1t79hXxJTbC3Mm4rLd7l0yN7P9agyiLi8IlmwpdQt
	qRlVRB1q94q/eiHaAYO6oGIJ+XQLgMWm3bvm0l7uEEboT17B/sjyLgFauaNmSapyq/wjnJGTObl
	Exu1pIdWwNhHyUNuvJ9A5hslYAHGmRJfDLlpt8WcXFKTzDIdx5pO8rNLLLcwkCasQ4Zu2hSi4HS
	/xOqV3X9K1C0Exs5/BjWw4Tv1xKP3uIUEpCa7ICOMGuBy6aXcRH9AcHia8F+tV8V5tGQneTq5B5
	AB7EgBUOQg3femRNLFsqvqcaURb6toRi60JH0imhT6F1FyrSAih1DZailXtiVmEFTgRa+RH3DQs
	ACV3jP/9rZHxCh8lsn4jqC/7DqjbIRImUYtJYNowxrFdZVNEN8s4HcCIzf4rHqwfXP4Jb+QfvrS
	i8xmg==
X-Received: by 2002:a05:6214:ccd:b0:915:e65d:3aa0 with SMTP id 6a1803df08f44-91b555695b9mr8309086d6.28.1791508301413;
        Thu, 08 Oct 2026 18:11:41 -0700 (PDT)
Received: from [172.17.0.2] ([4.236.173.161])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b5504e8d4sm4998746d6.26.2026.10.08.18.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 18:11:40 -0700 (PDT)
Message-ID: <6ac83f4c.a4ef0faa.3cd013.f020@mx.google.com>
Date: Thu, 08 Oct 2026 18:11:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3198916080265834124=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, enghitalo@gmail.com
Subject: RE: Bluetooth: Fix SCO setup failures after an abandoned setup
In-Reply-To: <20261008222616.2780570-2-enghitalo@gmail.com>
References: <20261008222616.2780570-2-enghitalo@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3198916080265834124==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1181908/

---Test result---

Test Summary:
CheckPatch                    FAIL      4.68 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       FAIL      2.01 seconds
SubjectPrefix                 PASS      0.72 seconds
BuildKernel                   PASS      29.53 seconds
CheckAllWarning               PASS      33.73 seconds
CheckSparse                   WARNING   37.15 seconds
BuildKernel32                 PASS      29.38 seconds
CheckKernelLLVM               PASS      35.39 seconds
TestRunnerSetup               PASS      779.04 seconds
TestRunner_l2cap-tester       PASS      12.84 seconds
TestRunner_iso-tester         PASS      17.07 seconds
TestRunner_bnep-tester        PASS      3.11 seconds
TestRunner_mgmt-tester        PASS      61.19 seconds
TestRunner_rfcomm-tester      PASS      4.49 seconds
TestRunner_sco-tester         PASS      5.38 seconds
TestRunner_ioctl-tester       PASS      4.64 seconds
TestRunner_mesh-tester        PASS      5.51 seconds
TestRunner_smp-tester         PASS      4.36 seconds
TestRunner_userchan-tester    PASS      3.19 seconds
TestRunner_6lowpan-tester     PASS      4.41 seconds
IncrementalBuild              PASS      54.47 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3,1/6] Bluetooth: hci_event: Don't fail a connected SCO link on setup errors
ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit a13f316e90fd ("Bluetooth: hci_conn: Consolidate code for aborting connections")'
#111: 
A link that is up can be the first one on the ACL since commit

total: 1 errors, 0 warnings, 0 checks, 44 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14875449.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3,3/6] Bluetooth: hci_event: Disconnect links that complete while being aborted

1: T1 Title exceeds max length (81>80): "[v3,3/6] Bluetooth: hci_event: Disconnect links that complete while being aborted"
[v3,5/6] Bluetooth: hci_event: Disconnect an ACL link that completes after its abort

1: T1 Title exceeds max length (84>80): "[v3,5/6] Bluetooth: hci_event: Disconnect an ACL link that completes after its abort"
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


https://github.com/bluez/bluetooth-next/pull/891

---
Regards,
Linux Bluetooth


--===============3198916080265834124==--
