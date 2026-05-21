Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45A71D7E5C
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 00:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779322610; cv=none; b=MN2GbSTA3KlGWaISeOP8xNDWJLuufHyAbBWtoa+mXu6JBvRyV8o2Z9KmJOblNtyYB3lpdDownXBqicibm+bFMPzGvTv/0bROts8h9QFSv5VMs8U7MDB11+X/pPFcUd4543i40llK1GZSjZv49tb24IoSlsRydLvywS2Px+xX51M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779322610; c=relaxed/simple;
	bh=9vPoORuaUjDVGH1dkrwP1F1BPt3nbNlDzhTJ8Cn0SoY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bbq8iRCDCWgpX542fO0C/QkW67dWLcmovbS96DktDbYuRePJewFvbkQ+MeJnDS1xFf2aGSfmsDMHxPQrUlavwB5BTfOEmL8fzjYbdfDdbj3LlTs6oQS0ZCBoN928DyklOLMxmhFwrGOL76jpGmfTWaCCiYMIDlSQFGr0K431ENk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3aiylqf; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3aiylqf"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-69d5730c579so1047731eaf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 17:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779322608; x=1779927408; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y36PdkqonAPNUmgrob9ZhzBdMD3NERtYhld76spn2zo=;
        b=g3aiylqf/71Euic/TEIxJTp/+UsJFlhD8WvOoQJ+/ZJr9+ZV06Z6Zcrh3TmjryyR6H
         yYFfa+s02QDdKP+R/Qgjdw1fuPB/kloWOUYaGJFMqM9EUEmS/A+U3TC78p7AO5kbx7p0
         C8bgphhE62ynBvzE0uQ6oDReP0u9NRSgbIkmAW1NS0BXbQn59Z2vrjH/qcExNdybameK
         0G/04AcOAvjXks1A0JPWPRbamaxQuAf/0zUj4z3rTCG9ekNgAJxJjFtJIq+x/K8YEFgm
         9YlQAxdIKda68/c9SSFrPv/EPARoAf+MSo6qQOt+yfpD3HwFzym1a5tqQRMG9nkkOXf9
         PL7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779322608; x=1779927408;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y36PdkqonAPNUmgrob9ZhzBdMD3NERtYhld76spn2zo=;
        b=FNrVeghV7DA0u6UeDZ2ncYUePjU4ckhWnMcMw3ol9YcJCZgXkQ8pezGiytXxN3bTH9
         ylKuncNLyS7nfvhAuGVh7zkvn5aRQQKSGC08Zj1JYCnKEHk+Sth3sPw6IIli5FjmlJkw
         lkYi51M4K9D8RJ9E60ZcAcx2vLN3Orvmt1sqZkenIYXN15Ddy9BBnt97hBjUQBa4K91z
         IKe4A+qfBttY67N5UJbMaCkDZPAc3AGK5tmqUMB7RcU2qYoXOUGcjl+HbWAh230Yb0o9
         scSiHkhJeRyRwaid9EWNDLw5mCuD2HTXLH2DEwpnQuJuRM/DuD7VAgxDlr3UyORzJz7v
         XNOg==
X-Gm-Message-State: AOJu0Yz2Wc9dOdlMjokZ0Od/Mc2KMWK3yhBCpkY5Lm+4WP+p4zBZqC6i
	cgLB7Jqe2CGCMwrDLvWAEHhTnp9NOcOso3462yBRC/vmL8coqQSXW1uWXU7T9g==
X-Gm-Gg: Acq92OHKEkpNghsgWROJBlFxnG9yXaBAYSOrbG3RBUSOwtX59iPcswtZbxKh8y/n7FG
	ziTBBzWcGcb938dYi5EcrYCRXZaKOtp0kpL65LCfEaHJcB4zj0xw49k25nGRQi5JHw3rwqe0v8h
	T9mC6pQicb6j/mVWqKU3PtMeCzcQG/oBzIteD0eMXntgvLr+B40dMsszb1em9OcSbzpo8KjITbX
	6ifBmxpdEqiz8avYJu2HZ7SOceXnjBuNsd//846358+lTT+UkV+ij2JFfmhsTGPM4LWwybZ+EcD
	9T4zt6k3RJvW84cClYUaMIK2N3hIP8QgRpqqI32nZ7RjiBO1kxDeXfiVT2tXJ/HGIizPPhVe/IG
	OTpDC4YWWLWHSYH7sztofWvPKjn5XMUqQBkdQ2+rEFECT0m0hTfxalLk3dBU0q2Oa1SMB+oV1SN
	7b2i1U7h/+5fOujTmV33VgBE/13hh6Dr/0WOcwWXaU1w==
X-Received: by 2002:a05:6820:1791:b0:69d:6bbf:3fd0 with SMTP id 006d021491bc7-69d6ef03e4amr268648eaf.49.1779322607605;
        Wed, 20 May 2026 17:16:47 -0700 (PDT)
Received: from [172.17.0.2] ([172.202.100.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43a956fa142sm11590450fac.9.2026.05.20.17.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 17:16:47 -0700 (PDT)
Message-ID: <6a0e4eef.3ee1b803.2b2d14.6a46@mx.google.com>
Date: Wed, 20 May 2026 17:16:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8976751731974627801=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, meatuni001@gmail.com
Subject: RE: [v2] Bluetooth: HIDP: fix missing length checks in hidp_input_report()
In-Reply-To: <20260520214133.27746-1-meatuni001@gmail.com>
References: <20260520214133.27746-1-meatuni001@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8976751731974627801==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1098310

---Test result---

Test Summary:
CheckPatch                    FAIL      0.65 seconds
GitLint                       PASS      0.27 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      25.15 seconds
CheckAllWarning               PASS      28.02 seconds
CheckSparse                   PASS      27.24 seconds
BuildKernel32                 PASS      26.55 seconds
TestRunnerSetup               PASS      541.52 seconds
TestRunner_l2cap-tester       PASS      378.34 seconds
TestRunner_iso-tester         PASS      597.47 seconds
TestRunner_bnep-tester        PASS      18.47 seconds
TestRunner_mgmt-tester        PASS      2023.12 seconds
TestRunner_rfcomm-tester      PASS      63.46 seconds
TestRunner_sco-tester         PASS      141.48 seconds
TestRunner_ioctl-tester       PASS      133.21 seconds
TestRunner_mesh-tester        PASS      59.62 seconds
TestRunner_smp-tester         PASS      17.73 seconds
TestRunner_userchan-tester    PASS      19.12 seconds
TestRunner_6lowpan-tester     PASS      51.01 seconds
IncrementalBuild              PASS      26.59 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2] Bluetooth: HIDP: fix missing length checks in hidp_input_report()
WARNING: The commit message has 'stable@', perhaps it also needs a 'Fixes:' tag?

total: 0 errors, 1 warnings, 0 checks, 34 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14585274.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluetooth-next/pull/223

---
Regards,
Linux Bluetooth


--===============8976751731974627801==--
