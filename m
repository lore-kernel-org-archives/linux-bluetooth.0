Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FCC2BDC1D
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 14:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749564617; cv=none; b=q3Y9sBisNNQVqLJO6QcD5YGjusMHwPSjHr2MtirKQSguObc/fzR3CIT73U6/VWFc1jO8p/x5AZX29j9SgO5/2R96YXVt7vFJAMhVE/MArcxhP10v/QCaHXzm0B3tGgbPsX4dw5EeZP1TGxtwS99RmBDbAdet+AuvQujuxliZdpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749564617; c=relaxed/simple;
	bh=AWzhP6uPaQ5CQCfu5wPVIAu6rP2Sxg04EgQim/sNh0w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CTp+PPvTxILV9JBF8GAY76uUz8bSeusCn4yS9IOQpTXaWBlbsusIdtUAlPbwMfuUMNkmNkJv/w1s9z2BPHoVaKnWQevybcwr5BgdOgOPiZOM9c3yn2x6eDDJ66p7NrDYP4auP3R+wzxkOow6RDFIiz+gCrgMDmmEfaeAgzfyNqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWTlAFQH; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWTlAFQH"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7d0976776dcso514060185a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 07:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749564615; x=1750169415; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/awCMGyPGaKHzV5/5umVMIdhFvEG8YSqOh7b5ukzTBM=;
        b=nWTlAFQHHpNhR5i0SZbbnI5xgIPCafzbRGgSNhuO1F5tsa7pHxYWhA7CPYUIWRFwUh
         /nO0dRsqQ7coTRU3tqfNQiBIXQ8O/0lkb2J6iSkrD1vExRw7pzbr8AHpIul7F+0Z2dbR
         4/U2/qRijFqI3vW+xXL/ML1PSQGb2S94tW0lunjCgPMY6EEiKJhWyhj9sGgLqfI+Spfd
         KOqY55RnaVBs7RVM2vkdcQMfdfg0U+2YKZGs5SmD/OJxVGtFDVlrlsz7XGsRG0xI+Lgi
         WC9DWepRZuJyZ8rZWBHJgAVNU+bmLNlXXrknhCaSrUk+//4Ox2+TxgNnAqp7I9dybXAF
         mQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749564615; x=1750169415;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/awCMGyPGaKHzV5/5umVMIdhFvEG8YSqOh7b5ukzTBM=;
        b=w+Ndgnh8lOKpIUrEPfHxkpZzxtHg/H+OJnSxGnwtA9KAvp9XHEtri9eYJA3iR1PR3T
         pc+oqmGUloxuWlw2ZVCxq6CyMnFdBYNPeCR6ZHDSGwslbrXOImZIppBkq9k/8mDlezAK
         28wix7tl6QwXDHASgOUzxw5nXNGRmQ6QIDZa1IlkP11ef37EYYD23wHnif9HxtZ54Wap
         UVDaBnDXDiOuV24mSsPC7wIEqegkyJdVruqtKLLLk6Q3ymwHYRrHdZyxCQO5emototSL
         GuM5om82snA/A8UAZ+7oZMuxefpWGWkHiPYVAeYjoXd59rceqUyIX1BCKYpycPgy/QJU
         R+DQ==
X-Gm-Message-State: AOJu0YyuKjz7iLpEgMispaqBDO7dOPZAI7XSDJ/SFzs+xoGQC+GxKQFY
	LmyXAYD4uyVK/aX2IfAYWuQKaxFaWl4YPLXUFfuthN2NBE7yMSugeaCc8Q4o3Mu4
X-Gm-Gg: ASbGncseJxUFAQlmI72RPsjr3A8jP+AOliL+hziCN9iwhu29RmPzEENL+zxEwGY6Xhb
	C87MW6lNrMNTYIIdQczF90/t4BZ5hASfBVTHnuiqG6yACY1OMr8ID4YgKW1IGcSQStIl9N1l/DJ
	gcQzpy53T8GVfY7WbFGGHWWA8a3lnObcSpzi4WMgqc2Ja3sjlqmBy7br/wtGwoM5ushsv+qyCco
	nHC78CbjHgiQMUNw4vsWgZAh7GDluWVDnL1yPNU5pDWa0wfJNQF1K1G4EyRzywa5Z9zVv3Mrpjd
	z5NbvXad2lJQ8VcnvUBxN5wr8AHDRRNdh6eXsWJvMd6qqNa4Rpi0gFajaUCtvt5MTeZb
X-Google-Smtp-Source: AGHT+IFZ0ATGd1lEnOiCZmtxtyPyFHHCxcdnkog6oEleJs41rYNlFwMSAhwkUXT3/p/PkI33+tv7KQ==
X-Received: by 2002:a05:620a:4588:b0:7d3:907f:7544 with SMTP id af79cd13be357-7d3907f7887mr1454250885a.35.1749564614525;
        Tue, 10 Jun 2025 07:10:14 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.59.225])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d38e26a793sm416381585a.50.2025.06.10.07.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 07:10:14 -0700 (PDT)
Message-ID: <68483cc6.050a0220.19e634.93e2@mx.google.com>
Date: Tue, 10 Jun 2025 07:10:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2606956108568192778=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: hci_sync: Fix broadcast announcement size
In-Reply-To: <20250610134231.1021846-1-luiz.dentz@gmail.com>
References: <20250610134231.1021846-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2606956108568192778==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=970375

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.24 seconds
SubjectPrefix                 PASS      0.15 seconds
BuildKernel                   PASS      24.70 seconds
CheckAllWarning               PASS      26.89 seconds
CheckSparse                   PASS      30.44 seconds
BuildKernel32                 PASS      24.11 seconds
TestRunnerSetup               PASS      461.20 seconds
TestRunner_l2cap-tester       PASS      27.38 seconds
TestRunner_iso-tester         PASS      40.47 seconds
TestRunner_bnep-tester        PASS      5.98 seconds
TestRunner_mgmt-tester        FAIL      133.71 seconds
TestRunner_rfcomm-tester      PASS      9.42 seconds
TestRunner_sco-tester         PASS      15.00 seconds
TestRunner_ioctl-tester       PASS      10.21 seconds
TestRunner_mesh-tester        PASS      7.58 seconds
TestRunner_smp-tester         PASS      8.59 seconds
TestRunner_userchan-tester    PASS      6.37 seconds
IncrementalBuild              PENDING   0.61 seconds

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
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.248 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2606956108568192778==--
