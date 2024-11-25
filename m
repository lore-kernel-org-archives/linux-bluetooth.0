Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6AA1B87D1
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Nov 2024 18:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732559797; cv=none; b=DvGKYz0V9IshpJSJndaNkFmvyScZjVAXZXYKrJbY51aLLoKA/P1hwsAMhIt0EydJomU1TBPH1HagZjRJz3Be+BYplwe4GvC0YWMRR/g95aDN9yy35efa9GkMgU+1iezkuTXLZBEYgC6Qn1EsLVzlsC/COxe0fNaSSC7dL0DY984=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732559797; c=relaxed/simple;
	bh=IBa89x/C5B3r/SPs93QJHAYnaP0d/0X0P2hybrhSAUk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CqJHq/WvZfvyfEVlyLe9WSRve96hrQFMrUxYD1GJRaqebLAYl+f8u/A2gZy5kLBXRowTDUYd1BF0ZW2mi6aYYIxwfy2b+MScSidhF3b4+S6XF6A8U4P96xXZsnLEmE4iiPDMhUTtVxGIT+qcOv4M2h7KpuvvjjYfBcpKMaHo7xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1jKgTF3; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1jKgTF3"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b66d20e9ccso54620885a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Nov 2024 10:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732559794; x=1733164594; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5sWoWiYnnNi8tbgtLuxunELCRWoMf27NC18AZa0nsSc=;
        b=d1jKgTF3xIK4UFEA9B+RblydXhtJPFqLsUp2Sj/YC7LFRNw7dZkxgtRvYTonfM6mJz
         UaAM+nXYFmv/d5hBEFsld4+WRw4zF/atVBUWsGk23RDHCY7M6PyGEIu+NnOvlo62+pYk
         ZT6OkpPqyq8/mvKUEHYVng5Eimh0Ix32y2m1eQ7gYzx0cNdfVwHXkRD6bCB7YrH6pg1F
         zIvGYuAt1qg6cLXdph0I13YPfZE2ixJyOLz5EZKlaScjYd05/lmpbdke+eNzLWKxOEsT
         YYvl53EH5ES8IKfazHZbqIeYBDL1a71ux39mkVlnGdo3Ze3dHd7uxOiVwXDfg5MA3uSi
         4wMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732559794; x=1733164594;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5sWoWiYnnNi8tbgtLuxunELCRWoMf27NC18AZa0nsSc=;
        b=ZnhpN92Fzbdzhk53TPdd9b8HVcSC5QVnkO1UcSE7tPFYzYhSBWAXbYUmFX8ij34SCY
         e4uVNiV0B28oe7N7cselhvtzmxXptJ95fwIkLNnInLzDehxIBjjCAYKcaf3MRuaCbfk+
         v5Rv9QlXbBPUsiTW8EPzVN2aabUxRl3BelrPY+OzTdA1/Fkr7CBcKTO0fc12vQ1kYnEv
         jmUW5FGq/YUGSvCDhZ+484T0GdJ0o2GuhnB6l3R/brBffjCe1KCTG6e6sUCgJkakxjcA
         5yvYpraRHPzjysX9Ts36Ip6oiYG11nvERrbb243Vpel+2ENYMhB1oIc9URsx2O8XbfMq
         tiRg==
X-Gm-Message-State: AOJu0Yy5Fh7Ok0zMt9ZT+NjQPe+fbtTMufyIYZjlV2JqYz/8KGG+PB+/
	H3aHAHezv3ckvNXy9Bt5unHOd+kxMUgOBeEWMCtGpD6WN+pRrKYM4J5uFQ==
X-Gm-Gg: ASbGnct3C3EcDJdiuXriXSmNQce2bVYMnPjjzNGb5P0KeX80E4dBk1MqX9BHpEMUYn4
	HsNiD2UBhp9x1tHW9fjalp/+Mqr34jcXXhYXAOygCpWod+r3EozqA+dxF3sUNUE1pwA1dJP5M9R
	PbUAxYATmn400vjo6DL074RzDqNa6A2nfYbLJqB0aE53lEbNZ2u7u0SrmFkIif0CvyCl7PxjUZl
	C5h01U40CpTPqAY+opvJN/4WlOwfvp2WBOIkZnsVnLCnTtjG+jH
X-Google-Smtp-Source: AGHT+IHcrep9TL+qSDipKpzMNX9s5zb8txPC4u8tJ0/Za+M2QtoNJ7GuL+/COzjBh0GsPoO0/+ph+Q==
X-Received: by 2002:a05:620a:2552:b0:7ae:6ba2:faba with SMTP id af79cd13be357-7b51453eeb1mr1731007485a.28.1732559793988;
        Mon, 25 Nov 2024 10:36:33 -0800 (PST)
Received: from [172.17.0.2] ([20.49.54.7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b66c8d41d8sm117653485a.95.2024.11.25.10.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 10:36:33 -0800 (PST)
Message-ID: <6744c3b1.050a0220.2479c1.3819@mx.google.com>
Date: Mon, 25 Nov 2024 10:36:33 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6629434491539040831=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_jiaymao@quicinc.com
Subject: RE: [v1] Bluetooth: hci_sync: clear cmd_sync_work_list when power off
In-Reply-To: <20241125175111.8598-1-quic_jiaymao@quicinc.com>
References: <20241125175111.8598-1-quic_jiaymao@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6629434491539040831==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=912307

---Test result---

Test Summary:
CheckPatch                    PENDING   0.21 seconds
GitLint                       PENDING   0.20 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.92 seconds
CheckAllWarning               PASS      27.10 seconds
CheckSparse                   PASS      30.41 seconds
BuildKernel32                 PASS      24.32 seconds
TestRunnerSetup               PASS      435.36 seconds
TestRunner_l2cap-tester       PASS      23.17 seconds
TestRunner_iso-tester         FAIL      30.76 seconds
TestRunner_bnep-tester        PASS      4.89 seconds
TestRunner_mgmt-tester        PASS      120.54 seconds
TestRunner_rfcomm-tester      PASS      7.64 seconds
TestRunner_sco-tester         PASS      15.60 seconds
TestRunner_ioctl-tester       PASS      8.23 seconds
TestRunner_mesh-tester        PASS      6.14 seconds
TestRunner_smp-tester         PASS      7.08 seconds
TestRunner_userchan-tester    PASS      5.32 seconds
IncrementalBuild              PENDING   0.41 seconds

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
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6629434491539040831==--
