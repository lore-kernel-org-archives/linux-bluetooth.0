Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EEA1FC0F3
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Nov 2024 13:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732713670; cv=none; b=LCojma/s1M7iRD2Zi5P7qM2atBpLzO8FRdXMeYm2K5Mc6NQQoXdqoZrJjUwBD1IumvBLf0iMJYF9v9AjtMMNL134vPNz8lZvtPiCgcd8150nZ07GF0s6xPT0uZU0lpRLoF12TlJ2OZNIjJ067r9QfCg73Tw33hugARqshWwp/Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732713670; c=relaxed/simple;
	bh=o0x4+jhY++FBFiKCEfYLSye/uNryy8nRv37g/at/WIs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dvtd2zS9bEmLJHTHfHNTpgU5QvdwidhIhR0bMmJhw6Bhe4oTIgRan+49ZG/8zrKFmilqV4OXYGSoHMYDvtvZT8fx0wGDn0ClBWfn+aRi3+YX3a77OM+erc2T0FlBku1Qr5EUxVTcghAm+K1W9RrNFq/fCZ/da+l65ZmfAxOq0OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OlIVPNfF; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlIVPNfF"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6eeffdff41dso34053267b3.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Nov 2024 05:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732713668; x=1733318468; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PhgfXwi96s5ZGpOBJnu/NgkteuBWEpYuMflzyeFRwWg=;
        b=OlIVPNfFNjCuAsROoQ95h4zy1gZroYTGAkXSJ/BTVVefq3c2l0pOk0XGnWciAGz7sx
         QXVNyAuVrCXzPpymyBtqQ/RSBg1uVuqYKY0ASXKbUiqVUniAcCY09rkAJWx/7f5G5YdL
         /zGiQneBUM0UFaLqNSOtpxxPVKMGFaLnztwlh3+fdxc4Lm5xrNCA61TmA8cAAzY4pvMk
         mHYtP9jAlfUWioagni5KTWlvJQvpVDnl4PDZKjE9+4RTvT/CSFwhovHMTgPe3DfWLk28
         kJ9kTop4OSIG2CvEPsJd+7amRW0Tbb0mkVqEX0v0S4uhnPMQlzKZpP6RmglGAR2lJYML
         4NmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732713668; x=1733318468;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PhgfXwi96s5ZGpOBJnu/NgkteuBWEpYuMflzyeFRwWg=;
        b=YZ+hkKovdZZKHMcUTP7VtO72GSSAO6ycyJd75DHpIFCRA30V7WF05SmG1tzQvxleDO
         Z1VSS7FVHL2vN7+ZpASchpFUyHMc+WDjFDzeYZ2Dm4x+zMK9n2xyXwpo8YSYM7GLzReB
         gXNExDpovfiB4PTvMr5Lpf/TU9vc6xnqvk60PSwEF/08qcNFolzGV0ojKNv/MZwRDmFp
         7jldmrhE4S/b7ediOZXjAV5vztqrF3uBDlWjaXAkTVbux+ieG63CEVhh4ya1yoICdk5Q
         qynALF1w2Uzsow4Pj//xtFRQ6M2wa6XteDrK5r8f+bzuv4pqUA78s5U5b1pAbaKe5OYi
         8fjQ==
X-Gm-Message-State: AOJu0Yz2eMhwchhLusZgk06eDU0y95UyA0+Pt8BqrGU2lHxb5pbYObgn
	vtNe1508TNmWXWzHkvxa5++FBDHTDeBoWbp9MK1wW7R6oEnlh7NWiJOsRg==
X-Gm-Gg: ASbGnctSXkxiSaaOiwzgGldSN6e/3nRCa93tf5KJ+wD2WgrqClxlMPQ233HHu4vEBj2
	rM7E5SOBH9HZEXhqoQuedl2b3ok3WfcDu5f1Md/ktYWofpEdOCNwwguZ3YPCocXNKRl78tlPFT1
	Cq7Juvj97uC3tlCSF3jNx6sFpYbeWMnCIM/a65FQDzmQ+ZjxRokI26IOD7eb0E3g5XH5yTLNCCw
	6k96GgGS7JySBobuMrIEW1x3XioDwXlFgFs36eoXAk6WlH+YpHqv9l1UA==
X-Google-Smtp-Source: AGHT+IGakq1lEct5sxW3is0chWtBzlZhzhanqHRBLc53N4jCHNRJkbtgiA567Ob4MFe6MfwjGkkQ6A==
X-Received: by 2002:a05:690c:2502:b0:6db:d217:895e with SMTP id 00721157ae682-6ef3728bcf0mr36050187b3.36.1732713667941;
        Wed, 27 Nov 2024 05:21:07 -0800 (PST)
Received: from [172.17.0.2] ([172.214.176.91])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46694366bf0sm35480401cf.12.2024.11.27.05.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 05:21:07 -0800 (PST)
Message-ID: <67471cc3.c80a0220.25d60c.b7d3@mx.google.com>
Date: Wed, 27 Nov 2024 05:21:07 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2707138188161866843=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, avkrasnov@salutedevices.com
Subject: RE: [v1] Bluetooth: hci_uart: fix race during initialization
In-Reply-To: <a1db0c90-1803-e01c-3e23-d18e4343a4eb@salutedevices.com>
References: <a1db0c90-1803-e01c-3e23-d18e4343a4eb@salutedevices.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2707138188161866843==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=912808

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      24.87 seconds
CheckAllWarning               PASS      27.04 seconds
CheckSparse                   PASS      30.44 seconds
BuildKernel32                 PASS      24.55 seconds
TestRunnerSetup               PASS      435.17 seconds
TestRunner_l2cap-tester       PASS      20.15 seconds
TestRunner_iso-tester         FAIL      28.03 seconds
TestRunner_bnep-tester        PASS      4.81 seconds
TestRunner_mgmt-tester        PASS      122.28 seconds
TestRunner_rfcomm-tester      PASS      7.51 seconds
TestRunner_sco-tester         PASS      9.32 seconds
TestRunner_ioctl-tester       PASS      8.01 seconds
TestRunner_mesh-tester        FAIL      8.07 seconds
TestRunner_smp-tester         PASS      7.44 seconds
TestRunner_userchan-tester    PASS      5.00 seconds
IncrementalBuild              PENDING   0.46 seconds

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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
Total: 124, Passed: 120 (96.8%), Failed: 0, Not Run: 4
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in run_timer_softirq+0x76c/0x7d0
WARNING: CPU: 0 PID: 33 at kernel/workqueue.c:2257 __queue_work+0x687/0xb40
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Failed       0.103 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2707138188161866843==--
