Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58FA24C679
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 16:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739378159; cv=none; b=Ablv58WUXGC36SvqJA/LZndAS5KvpYWk9FedeBDsj2a5j5SlQVNy9UpdTlHC2/GVa50mFU1sLCNLVSCg2BcKURljB0G/BtVtPxuaKtlOOeX9He7pC86nKiYIsBGsX/Yy5HMjlLAp0i2TBqVungrYKYdAbnhzQxQXfmIxJQCoUbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739378159; c=relaxed/simple;
	bh=RtMEa2bHwZs86n1xWziLSDYRyk0H4esIQmNsyKjwNr4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MYymD9Oct+mzm4FBL/2WI2QYk/jic72SUZBgaOLXgOhQd/Rn1Sj8aPfy2BRJr0NwFIko/Ye0T143qj157EgCMpvPjzhg/GgYkX+l4jOaqC/W10j+w2OP8wSXfr8jdPfM3/h1gHxD7MRhIHeKLl7YzcgK9zKi0qd0BHOleG0wRDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNhLDDDo; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNhLDDDo"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fa1a3c88c5so9403798a91.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 08:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739378156; x=1739982956; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8E60vSeEXE9lisz7tRq1NFcY60Z0zeaHNLSRi6G0E4I=;
        b=QNhLDDDoEcGXOoNWv2UGzSm/Y3gbeB1juObdVlACxZReRI9zmXo1rabZ/96I3N8HU7
         8pfguQ8Pzr1C6888R44u/NaVG0oljxt5y25wjv4xxgbboRlUflAcR/kIu6oe+jpqc91W
         nRf6eGLTdjNQgMsfQqKa90DT2hXvRT96KU8lbBY3MdftW97MgBwc52GRCBjkkjsSAGv4
         tEOHTZdgkDuR+vRkQlt156nl1x9SGp3jLj39SHjTkdj4wSvxdlwB6HCl7z7D1AO9drmw
         eKKfMhFKQqr6f0u0O28Ia9WxPIuKPbC9dTG+xk2VqBiii2+YL/fiSae6gdfqT3fo8gje
         6SrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739378156; x=1739982956;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8E60vSeEXE9lisz7tRq1NFcY60Z0zeaHNLSRi6G0E4I=;
        b=Jr9MmOG6pjZDIbP4my1EDHVFQ7idowLs92yRLbbfK0c8WiSVO1F5dGM0mU1TSYJYdI
         jtRAAWxUFnSfZY3orhQtjhFDdCvFzGiJTlAtq3lahiHRs2rR7VS2H9M3OV3LDApSatID
         4CnQwfboFkzLOiiTwhfWU6jZnmC5iw5NlicS+s6PkxtuuGgQVQ8tslVvtR48AEIm9Xoa
         z8tMc6WSTTssqAPWibFam9+qQi7j/BVUydK880oy3hv8QP5KpKin5agZRD4kQec7wSn2
         lnPxZU4kvngeKDPj1THRsshubtPeuwADOyerDmASkcCNg6zDxgmYCWVefWClwyDKEVjy
         Jd8g==
X-Gm-Message-State: AOJu0Ywp+JWT2E0KDHDJbG8XAYmQccZ6cKjsaQOXJPZGoC5EqEg7Gof4
	P2NtxyMTHf1dUDk7UASCl+4jxuFjK30uDvbFslo0xx4XaBQU831KGkVgTy51
X-Gm-Gg: ASbGnctliRu6g1tK+lSUEPfC8TmTg+1kgPln/YAG1xOlm4rimM2271RBjVvIh8ILAwm
	26iXXxiXBOieT6DnSRlICadR1IOuB6UJoTsQiebQnJ0Tv0uI3TYjatcQno515tijTdgAFz/m0bj
	6JetkkGL8t5Kj/m4LtieBqJ3g5ZxS+d6cVkHJWftuzlnP+UAcomrHcG04xxAitIBbtDoAhNtHTm
	SP8HKe6yTTNf2WsmVrcxZDnXFbKD85U9JrI1q5Jh28H0+6MPZNSMky6cbvc3ATEhun5WnOHVLcP
	WAOeuWEZQc7gWgLyTl4=
X-Google-Smtp-Source: AGHT+IG2/zdPJAZ1JooysGEkupyTVDzfMmKq+Yts08dvZgZUewUZkcMa3Ui5z8WmGanOo/aJvx1bRA==
X-Received: by 2002:a17:90b:364f:b0:2fa:1e3e:9be7 with SMTP id 98e67ed59e1d1-2fbf8957ef8mr4668182a91.5.1739378156576;
        Wed, 12 Feb 2025 08:35:56 -0800 (PST)
Received: from [172.17.0.2] ([52.234.7.23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf999b602sm1703814a91.35.2025.02.12.08.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 08:35:56 -0800 (PST)
Message-ID: <67accdec.170a0220.3315d3.ced1@mx.google.com>
Date: Wed, 12 Feb 2025 08:35:56 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3122928533810165229=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, avkrasnov@salutedevices.com
Subject: RE: [RESEND,v1] Bluetooth: hci_uart: fix race during initialization
In-Reply-To: <c7f1e8e5-e752-9ea7-ffe7-0ecc282bd92a@salutedevices.com>
References: <c7f1e8e5-e752-9ea7-ffe7-0ecc282bd92a@salutedevices.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3122928533810165229==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=933244

---Test result---

Test Summary:
CheckPatch                    PENDING   0.41 seconds
GitLint                       PENDING   0.30 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      25.16 seconds
CheckAllWarning               PASS      27.80 seconds
CheckSparse                   PASS      31.43 seconds
BuildKernel32                 PASS      25.03 seconds
TestRunnerSetup               PASS      440.87 seconds
TestRunner_l2cap-tester       PASS      21.05 seconds
TestRunner_iso-tester         PASS      32.42 seconds
TestRunner_bnep-tester        PASS      4.93 seconds
TestRunner_mgmt-tester        FAIL      117.81 seconds
TestRunner_rfcomm-tester      PASS      7.76 seconds
TestRunner_sco-tester         PASS      9.54 seconds
TestRunner_ioctl-tester       PASS      8.47 seconds
TestRunner_mesh-tester        PASS      6.26 seconds
TestRunner_smp-tester         PASS      7.20 seconds
TestRunner_userchan-tester    PASS      5.15 seconds
IncrementalBuild              PENDING   0.86 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 482 (98.4%), Failed: 4, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.205 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.154 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.191 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.141 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3122928533810165229==--
