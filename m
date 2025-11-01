Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE472F12CF
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Nov 2025 11:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761994845; cv=none; b=Rtax8/0wSnOOkQO56c2gRN17vcKNzcCgGS66YNJkwxh5lrWsxlrQxWz4xgzp2FBre2Y4CUjkDRS2hMOGbkplWIgEYcYY2oYPoDcBNYwzZQm2yqELnfABk3TzEofTwbHqFWNWQtMI5/6uPMNNzBCOR62oTCXk2Kmr4YwVgGbsk5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761994845; c=relaxed/simple;
	bh=eu3+j89uWQiL1slQesaaom8WSJwanwvIAUSA284y++0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FGYbHzRQdfvKCbY2W06cXuwEUyyzSku8M01nalfSbIKXTfOh53LbqWPdj52ayIkVozDinjKz/s3LtGEsQZ3iPvSINSv6I4Je/+DFWxKiZamxc6H0Mwzbbec7rRO6sBVuxAZm3aRvBhmbTmSP4qJmfcXzoKa9HgmsVqP9BGoUwXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ge3t2fwa; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ge3t2fwa"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-43326c74911so48535ab.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 01 Nov 2025 04:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761994843; x=1762599643; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Qxof+DVZBenrjg/ubO94f2tG8YnLkqyhY3gb3OvEsYc=;
        b=ge3t2fwaeQKluMvnTX4MyYii2HfBcl/+4b1yHdTl/h28dt+6HBf07RtISR2lL7DOVi
         JUiQ12tYqg4N7fmqJnZ6o4rcIO/Cfpu0t4oP5y7j9vfOhoRuBVX2NHuQ+N1Aye4ymDDa
         oJo8lcuobWvJVp5faagqSdb95mX3tWOMzt5OiZg5VFdJLhf8L7P+BB8Na3rdGxlMBh7a
         H16myuyGioiXuvd1d0yf6aY8MfYrXkyKvsVjsmBLOph1RCK3VpuFIYdh2w3YsWSpF56O
         UFcaitTh6Mao3hqWBnFoGvl0AuvaNaalkB+/Eu9gVUonAUkoEVM4qxq+t+th3UmHeDzX
         J82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761994843; x=1762599643;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qxof+DVZBenrjg/ubO94f2tG8YnLkqyhY3gb3OvEsYc=;
        b=X18i4I8IzhXHo34wDdJ/iMojITvDhRvDYoB+KgBsAE9ADdRrH64z/05dg1F2MnznE9
         eV2Dg480Xtm1j0nQDUtOHLsw+xMtXCA+6SkBKRYM/lXs5Yjn1tWHwlzxtZayikbClOKe
         crScsa5tu3TT7c10ZioQSv6gE1xHOY+cZv3/c3lQK6JcX4+TOwN3KmOcaVkx+RRG2Euj
         RC3UMC1PpugFRRQfEJ7DG1sAWOFVQY1U/X+6nymxAF/bE90D7s7vSTPUJRSxR78ARZk6
         wRsVMgYjyMIK3KWAPZu67LfHwh0oFSS8ZYn1D3vO2FnEP0LU3IKwr3kU78t7RKx+RSEW
         00qg==
X-Gm-Message-State: AOJu0YwVhfkz07Bev3aajhrjOLZRs5ONm+0zVpqGXBI4ExCPOHdg4ec1
	BVGUUG6/LHwikpnglZozx1LUy6XRUqnLVajmgL8z1XybI7mlZqMp0yTgU5JDhzNP
X-Gm-Gg: ASbGncvxO8YK94Si98NPg76xgnT2UaZYXz+Xz4BSevLXhoCeGnhm3s3UdYnIfZiVY4m
	35tD6TO16v9iudvW83YfFL/6McG7K3Tpsx+3bafISZ7/cmuCocgsToZQ63hR2A0nMxUyGfXhu3A
	YyLNrMh1KPWI8gF61oi+ATYw0sBuGRh/HJ0Vsdamg8JrSU0wA3BPrGCk8TVxxP/cKiAp9c7MdGf
	cnPTRmBm4zfhwrCcMWWxQrzgreZ3RMHvXnn4/zXA6z3aUfH04tpWx7lFI3d91Ugd3uUHekQVw0M
	F6MHnHWvpNb+k8vf1Mh4lFgs9dxD3I5OaWpsasq0Ip9xxcXBiWwoGgb1rXzp61q80E8NuxBhmrX
	c1/GsFX3GjK9UGUU4ljSwB8qbQbelaqHQIODWxe9jSxBgeQQxQzR8uYGmZ/XYfR983F05EWdRFu
	+3kkE=
X-Google-Smtp-Source: AGHT+IFPX3jUVzBaux5i6e8LePMvS/O8m4Rz9CD7Ae5bfKVbLvDd0YzoK7Vm/b6fDSEqFOh0eGnCHQ==
X-Received: by 2002:a05:6e02:3182:b0:42f:983e:e53a with SMTP id e9e14a558f8ab-4330d2029e8mr104104385ab.29.1761994842873;
        Sat, 01 Nov 2025 04:00:42 -0700 (PDT)
Received: from [172.17.0.2] ([52.165.59.1])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b6a615da37sm1635608173.57.2025.11.01.04.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 04:00:42 -0700 (PDT)
Message-ID: <6905e85a.020a0220.2018ac.29be@mx.google.com>
Date: Sat, 01 Nov 2025 04:00:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2844142154897050956=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@163.com
Subject: RE: [V2] bluetooth: sco: Serialize state check in sco_sock_connect to fix UAF
In-Reply-To: <20251101103333.173774-1-zzzccc427@163.com>
References: <20251101103333.173774-1-zzzccc427@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2844142154897050956==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1018479

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.23 seconds
SubjectPrefix                 FAIL      0.32 seconds
BuildKernel                   PASS      26.35 seconds
CheckAllWarning               PASS      28.99 seconds
CheckSparse                   WARNING   32.93 seconds
BuildKernel32                 PASS      26.05 seconds
TestRunnerSetup               PASS      505.85 seconds
TestRunner_l2cap-tester       PASS      23.34 seconds
TestRunner_iso-tester         PASS      91.78 seconds
TestRunner_bnep-tester        PASS      5.97 seconds
TestRunner_mgmt-tester        FAIL      107.98 seconds
TestRunner_rfcomm-tester      PASS      9.07 seconds
TestRunner_sco-tester         PASS      14.22 seconds
TestRunner_ioctl-tester       PASS      9.65 seconds
TestRunner_mesh-tester        FAIL      9.49 seconds
TestRunner_smp-tester         PASS      8.27 seconds
TestRunner_userchan-tester    PASS      6.34 seconds
IncrementalBuild              PENDING   0.49 seconds

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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:153:35: warning: array of flexible structures
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.096 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.155 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in enqueue_timer+0x303/0x340
WARNING: CPU: 0 PID: 36 at kernel/workqueue.c:2257 __queue_work+0x97d/0xbe0
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.145 seconds
Mesh - Send cancel - 2                               Failed       0.127 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2844142154897050956==--
