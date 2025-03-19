Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895E9219A7E
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Mar 2025 23:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742428565; cv=none; b=Ta/k/fiqFrq97G8VjrpJZoi9rvOt/bqDtdr0SPJtQkr886gryldRYE6J9ES7ixz1G+SekUKO3icw2G4CmjKzZCmOKA6zmy8lB+vlafpPCKkY10B+QLVBL1oFS2zZCvaQPQ3Q/PUottv4HeCauW2J93FfdBcm5cnX7guS0JjGS2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742428565; c=relaxed/simple;
	bh=vMzaNJH3TiXJfjZV9AllhkN6bN75oPjxCJbACjjWuOc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YVzQaJ4MqOQMoj9j9uN6i1IoEoMhbcsC0uG2odTvRxIfSOZeigG9FUqStXGsTOJBnvg+GTaqA/tGjAOw7tXmXQTQOzjkIgJnaSv//MB7JOCHsmyQo6oB+TBvDQ+nxaUopXdkYv94Cr8fr88QgErvAvirgoBNO3nEbo6AjjKv5P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZUPJk4ah; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUPJk4ah"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c58974ed57so25674485a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Mar 2025 16:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742428562; x=1743033362; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hiDqLo4oWCmxFXL8OsrRAnTqRu7F9c7zXD4ewqZvVcw=;
        b=ZUPJk4ahx8og76fjmiW7i02IIRnUmWzlPUzpOkyW6uSmUEaUiMyQwvb0L8ZGoSHtop
         YwI8rzBFgxtt5dW60s7BfDIaEJ4dQbbgo/xtQePe8Ea3qi6sXGMfwP4WjUuDwhk/nQ8x
         wHB9riVHaO9MT8JdEKIKoAOgfA1a0XJNKiuILmYWc7DByxKIAse73BDjSpPWvbmRa3CC
         3kEvftrEWMQebzgjR8DGtzowoStw7jdqeC2L9sNLDXO/xFMHg+ini9YC5LuzYPBCYfI/
         7oiDIj49oxZUk5caHgy4+eWjSoeE1T6hOa9sMJVxdVOryWgZD2q/xc3+JptLrezJKnte
         OehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742428562; x=1743033362;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hiDqLo4oWCmxFXL8OsrRAnTqRu7F9c7zXD4ewqZvVcw=;
        b=aRw+AemdQGXbAgefSjBNuIAI8JjD+JvoaQeHx4iM0bEti1lNvQg1PeP9+FeQBW5VM2
         3U+E4gpbIch0Ad6q+YWU8Ahl+VsCVjZz2Iw5C/uoj6nnCMBzNgz99N+2xRL7DSylya/Y
         Kl3CRK26QQ7hSbY3WZlRezeXzcEUaIZ28N+fPfys4CQGciuHHq1Vzy6L9H3aXbiqpbsG
         xmx2TWaeSL4PGNnV7LP/GBmxrbjKV3j4kNTeZg0z/x9Cb5gORcrRP/zJHX5nyxAbQLaA
         yl3fFFvxCYQfdSdHPjp1sjgNXIgLaAQo2poIOGUBqO9+ZzpaqYipY1zx338cg3+4cE3C
         HYJg==
X-Gm-Message-State: AOJu0YztHLqsJ9eS12zJ2SV214whRPl2EnnA1LDrZ9X6tHadhaq+m+Q2
	WuCBKSq6pt4LVSXqqwhkvFMKcH6QyTLO3uG4xJg7DIYjk8eCRjKNFhH+Bg==
X-Gm-Gg: ASbGncsrKcjISsrUW2Ik/qZ0IUkMq0UWspUDV1SbJN27lSAFWN0qAaO5c3bJ9G8v5O8
	KE7WM0GIQiVMz+of0NumG42c6Waj7+NYrOmAuiB5NWIutqZffYSHcqZtCSRh0GdwGFdPJwG9Uc/
	kBJ1buWclP7QFSXlgkGaH4CtUbw3vHvutWodsFOK9wdUVu6CkMG1qnofy5FnTIffl4N2zvFcIbA
	lb2rR7fU5TsTlqO9IExjcevfuBFKVfVUtMxPSdpKcKgenqTYPCILF1aNHi6Fe0/mQ7pV1/soXaR
	gswi5UAPgvTtc/wkVhcTaWrnBvRHAUa/vaYJ+yYpbQfHaw0+YWs=
X-Google-Smtp-Source: AGHT+IETwBdXXO0ATkt4xo7eJzMLO8S1NJ+85jmitFTi8N1d3S6tM/bJK/RTgv01Eprncr5OlC42Ew==
X-Received: by 2002:a05:620a:220d:b0:7c5:aeb9:b156 with SMTP id af79cd13be357-7c5aeb9b42fmr285946885a.2.1742428562061;
        Wed, 19 Mar 2025 16:56:02 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.192.133])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c7842fsm918353285a.42.2025.03.19.16.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 16:56:01 -0700 (PDT)
Message-ID: <67db5991.050a0220.2a36b.3729@mx.google.com>
Date: Wed, 19 Mar 2025 16:56:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2834438325400991185=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sean.wang@kernel.org
Subject: RE: [v2] Bluetooth: btmtk: delay usb_autopm_put_interface until WMT event received
In-Reply-To: <20250319231235.812700-1-sean.wang@kernel.org>
References: <20250319231235.812700-1-sean.wang@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2834438325400991185==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=945747

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.20 seconds
SubjectPrefix                 PASS      0.34 seconds
BuildKernel                   PASS      23.81 seconds
CheckAllWarning               PASS      26.31 seconds
CheckSparse                   PASS      30.18 seconds
BuildKernel32                 PASS      23.65 seconds
TestRunnerSetup               PASS      426.61 seconds
TestRunner_l2cap-tester       FAIL      23.55 seconds
TestRunner_iso-tester         FAIL      36.71 seconds
TestRunner_bnep-tester        PASS      4.68 seconds
TestRunner_mgmt-tester        PASS      120.49 seconds
TestRunner_rfcomm-tester      PASS      7.72 seconds
TestRunner_sco-tester         FAIL      15.25 seconds
TestRunner_ioctl-tester       PASS      8.07 seconds
TestRunner_mesh-tester        PASS      5.86 seconds
TestRunner_smp-tester         PASS      7.17 seconds
TestRunner_userchan-tester    PASS      4.88 seconds
IncrementalBuild              PENDING   0.47 seconds

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
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 62, Passed: 59 (95.2%), Failed: 3, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Client - TX Timestamping                Failed       0.122 seconds
L2CAP BR/EDR Client - Stream TX Timestamping         Failed       0.110 seconds
L2CAP LE Client - TX Timestamping                    Failed       0.109 seconds
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 124, Passed: 121 (97.6%), Failed: 2, Not Run: 1

Failed Test Cases
ISO Send - TX Timestamping                           Failed       0.205 seconds
ISO Send - TX CMSG Timestamping                      Timed out    1.847 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
Total: 20, Passed: 18 (90.0%), Failed: 2, Not Run: 0

Failed Test Cases
SCO CVSD Send - TX Timestamping                      Failed       0.166 seconds
SCO CVSD Send No Flowctl - TX Timestamping           Timed out    2.404 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2834438325400991185==--
