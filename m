Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7151A316E
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 19:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768935773; cv=none; b=Qi5qAvaR3ogLslzQHetJSAckcd6Q449ag3tQEmDRMP9O3KPk42/yNm+q3pmhR8QUavPRZUzJuhDuciltZQo6XYO84gVz9As/IsvUjcetoOb56JJrWg24AHjWYWNBBXKqHHPNGYVxrWRQUOQlYO5kH3o3giP/jkILBEKNU64X5lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768935773; c=relaxed/simple;
	bh=X7sWuEkYZdq7scXnn1qISLrhrsJfAxPojElTtJIXMa4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dn907Xacctp9y7FCYVV9Ke/1XmOOYDh3OwCpGhqeXFQsAv6v3hFcF8VKgs2W9gEe1y9v1NDrvIKysRITP1yOhxL0yTOBc5mITTRdKaUlzlPZVymdrQDATeXHbGS4+nZMa1zi3XMQUH2n68gYTxBcFn3DLYDYq9yNYBiTPFelFM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=By2h978r; arc=none smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="By2h978r"
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-8c6a001e3bfso348969985a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 11:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768935770; x=1769540570; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7hadpwWJNH/5SWdzCrqVrikMANNP9bNTh9NRlQPp4o=;
        b=By2h978rIgzPYxEakY454dwbqIDijMiKgFG823e9shtf4y0Qs0ApTSGqRkEwyY2dHt
         EpZMGJ2E988+LzNf0LDE5QTeRylyKuHlD0TWtge3uG6+QPENMMf9t722hzG/pV45RNKj
         FrcoF1rdiAYSz56kfOIEapJXU8Bhf6/9APHgtRJtGEm94kIl9jDb9pKTrMundo9u0ver
         fwEFYeGdPIg7dqrTpKDrheBxs15UWqhMigQrdecRO0oM01ZUeQBlO6nqaehvtOTUCi+V
         RZtPrb3bhRk40bDFaienxHVC7otG15stePRchqgI0wtzXQ2Fgj4ZI0wXZ9s4e0+zTNwR
         wkgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768935770; x=1769540570;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7hadpwWJNH/5SWdzCrqVrikMANNP9bNTh9NRlQPp4o=;
        b=BwM++4Hb4lne0eZud03+mBgFIbrPARMUdojXeSUXkoCeeqRtd3b4mhivtHE5Pgf3k+
         CDz2KwiBxgh0X1WtFilht5+wsOUspeiW1tTKcJplHVsEB+HcyArf0gxpTHcM3itNNapY
         WNUgfzdEGbN1+KaV0U7dtzujKBJzfNEK1+DLW8/goF5J5IlZFm4s0RVr3oauS0sPrRed
         HBLZRj5qEJtEerXFN2YItC94Ra0ewSCn4b0B2vhw+LMpbbyMf/5Jh3Y/AEYZPubmG/W1
         ONHnubB2HEdLTqwGAnZzLC+PEjKI40XpGX7aVUpUzyd58Td5XtjV8lxkwbtLSfEC3p/Y
         yt/A==
X-Gm-Message-State: AOJu0Yxt8ZffRZ/2N/+xzPKcw+X0OhYM/zhT9r1LdC1oS6D2f/unrB+x
	Q8WIgvouyyC9UhIxe2g9P6shqYJ+zM/qM7sWBJAhGzKOU4OLPstNWa1bqs87lia0
X-Gm-Gg: AY/fxX6kqsArf2dw3P85N0y21z9F+SRFN7kvvoE41aLDSgk5XenFh9UoYtNwqm+sFu5
	xkDgJSExZeYDCFkN1AxkXfthvTJQMsAVnB+1YAik3qbD2LLPlzy/3+v6gJHjnQgK10sJno85jQG
	IPnF+MEBH67Q/D2qOib83v7AVAEKT0zgWCKw/yykX3qv6N3/QFafSkoAcj4Z+m+pc+pjHcJ4NgG
	mQh/UOMKfZQ0A6Lw3Zr7byTV3ClvIKKhPto2iQtQpfEMiHbJrwNz1Cv4iZUGGSQxMFf2tSnSPEz
	GhIvawm5c2Z8wzsBJeT6m09xkSOILIaNZPOw0kMzhsDBH27AtH29ylrVJ7+JVN842oZw+tiOjiY
	fGSqpxjVGQZiLSqPVwr7VbqE+a0MmXgYZr3aw/uXRkhLOmWWwJrL46itTLv0mePWoN7p5iHV7mq
	1UWmPtRe3s5HnLxyziug==
X-Received: by 2002:a05:620a:4492:b0:8c6:b247:44 with SMTP id af79cd13be357-8c6ccf3ea3emr327467685a.87.1768935770044;
        Tue, 20 Jan 2026 11:02:50 -0800 (PST)
Received: from [172.17.0.2] ([68.154.115.179])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a71ab20dsm1103296085a.5.2026.01.20.11.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 11:02:49 -0800 (PST)
Message-ID: <696fd159.050a0220.38f6e7.faea@mx.google.com>
Date: Tue, 20 Jan 2026 11:02:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5014495729579502083=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] fixup! Bluetooth: btusb: Use pm_ptr instead of #ifdef CONFIG_PM
In-Reply-To: <20260120181717.2321998-1-luiz.dentz@gmail.com>
References: <20260120181717.2321998-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5014495729579502083==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1044807

---Test result---

Test Summary:
CheckPatch                    PENDING   0.39 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.81 seconds
CheckAllWarning               PASS      28.04 seconds
CheckSparse                   PASS      31.14 seconds
BuildKernel32                 PASS      25.34 seconds
TestRunnerSetup               PASS      550.69 seconds
TestRunner_l2cap-tester       PASS      27.64 seconds
TestRunner_iso-tester         PASS      85.89 seconds
TestRunner_bnep-tester        PASS      6.34 seconds
TestRunner_mgmt-tester        FAIL      128.94 seconds
TestRunner_rfcomm-tester      PASS      9.32 seconds
TestRunner_sco-tester         FAIL      14.51 seconds
TestRunner_ioctl-tester       PASS      10.17 seconds
TestRunner_mesh-tester        FAIL      11.48 seconds
TestRunner_smp-tester         PASS      8.55 seconds
TestRunner_userchan-tester    PASS      6.63 seconds
IncrementalBuild              PENDING   0.76 seconds

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
Total: 494, Passed: 487 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.104 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.155 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.139 seconds
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
Mesh - Send cancel - 1                               Timed out    1.866 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5014495729579502083==--
