Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E7B1E47A5
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Jul 2025 15:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752766648; cv=none; b=O2LrxnGmuSWXzP9ZFvOBn3HBAJuOC4tfPG8DqN9Jo7L9c4M7wF14mn64I7np3pzbOKqbndiNPTk2agH9E0Y33Ay7GepB6VczytNLZDyX1FYuHGUkBJALUgC3K1ohVp3IUbdAM6wsw4zvYsgqtk37jpC3dENUbujk1Pb6pQ6djMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752766648; c=relaxed/simple;
	bh=5S5r15zJmy+dxZOdd3GBeCSe8TPm3uikHrN/f/nj6FY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=iO7qRzZA99++00TUxaeljZZhdbq3ZhXuT0Cfhhc95guJnMKAYjyhHzTg1bhsCK0t6nwy4BuzBpqPd0hC5HgZsJtwFFsvZ5/Rp0iI+bzvCEDwFsGVkNnzETmT9+yuJ/0i2PJSAluIas2IaZkBTKFC8VVCbwAlxqA34tB74FAZaHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LeW/SCgl; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LeW/SCgl"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4a9bff7fc6dso10243701cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Jul 2025 08:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752766646; x=1753371446; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sB+7YgliaxoKD8E5fICfsHgwrCU04pDYKYYl/IAofsc=;
        b=LeW/SCgl99YywgYD9RueS4jms15TAip/JgjYs85iN+zVF29XPSgJQ/LGefsov8Czbz
         MVS0HFbFfxc0CUTMGIgyLjqxrbTI33IaEnxrB+loFzWv/iBtl1J7GyuFWx1bZ4AVHcJc
         IhPkerxluHLa2urat40fKjU7omtCq/+JRsTYWL3wk/cePe4xO17478kyGv8W6+fXpOWu
         kO4VfbWImEY2f7i6i6IxzH0a/60ywj7QJwaVcuowELAmoA3c39qMclQ9z9UHzTT1ePJx
         A9yA+LHn74OFaDhq4wNfEC6ni7Ktwyl9XpSeRhDREaTwr888kwW3IRVzv99uZ5NFtJ6j
         yMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752766646; x=1753371446;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sB+7YgliaxoKD8E5fICfsHgwrCU04pDYKYYl/IAofsc=;
        b=jXa80xHiuldWsMTQ2cS9vaLZ06Sex/LyIXZZ7ZcQvu8OUVTI/g2Ur20lURWET6Jjar
         PkrhnrDpcdQX+sLmouy+bwzZQtCBEPREUICqyHS+EvItXStWqhVOuMPhJN3Xsthkn4jw
         QgjN8YbFx8HipFREgjCwj6iGDarcXija/0WvvT5Zrjpvtw5tz+XzUMEPA3MmNihq5IXI
         HrphfJUlfToTGmPDnjChCsH2m29QP7jQSoCSFW8IrUrWyhej1EWWIb1NZnf+qeNLYuSo
         gwq9kL85nfMwQQcp6YQSEKAxWL+Y/6GSTFyF13d1VgoUqfc/Mz7hDZnCLsWUCRPjdnm8
         Z3hg==
X-Gm-Message-State: AOJu0YzYpUZtD/TTuJVlSdxbrl2S2SYzzFPu8Js+tqsTlQi+d/mEhqUP
	lYAu+YRkfDQUKtKJaiIjZffVnnQ7inZLFRihwb2mgMJZn+ToQ8/GUMCFPJ0O+g==
X-Gm-Gg: ASbGncvO4WC2OxstCP6C+ileqSw3QZjUljjYScNYq+wiAQpgptrhSYCiUYMZFnxJWeC
	lkbI3WYklDYMRlfWW76xfilrjuIBLPweHytu3rt3cnEiPb6RNEGybpBpI41NqTWzxSlD068c0jO
	XHh/MG/elsKuQ5ngx44Z/n7RCXEM7UIt8gzAVjGlW1taB+X/w9lxZZim/6YLa7MbI707Ogz1gUb
	aGj60kQyK9KK0VXwT1berAH3048BiFxTKveWahXlCiqDCRwFgVmFKbNqNgbBwv4IT0X5lSFsNuX
	PwyYPO3WKkE48QKDwcrIsmv6FBuLUVV4ortgERDYXbQ0ls8i+7D12CA6j5h8O2HLjqiA0En9lp1
	/FsVgzypQkW5gfpRhFuDv7fydbRc=
X-Google-Smtp-Source: AGHT+IEDVy7U5924wJe6VL2uqmE8e4PsdQhyyG+EFIY3I/e23Wuz8U9/Pk6ZPZ6UqC4PljOOpulwbA==
X-Received: by 2002:a05:622a:4a14:b0:4aa:105c:a0d5 with SMTP id d75a77b69052e-4abb087e94cmr4999911cf.16.1752766645576;
        Thu, 17 Jul 2025 08:37:25 -0700 (PDT)
Received: from [172.17.0.2] ([68.154.38.20])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ab5e847f78sm55730421cf.12.2025.07.17.08.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 08:37:25 -0700 (PDT)
Message-ID: <687918b5.050a0220.84581.6f36@mx.google.com>
Date: Thu, 17 Jul 2025 08:37:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0383314979924514285=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ipravdin.official@gmail.com
Subject: RE: Bluetooth: hci_devcd_dump: fix out-of-bounds via dev_coredumpv
In-Reply-To: <20250717151051.195106-2-ipravdin.official@gmail.com>
References: <20250717151051.195106-2-ipravdin.official@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0383314979924514285==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=983409

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.23 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.78 seconds
CheckAllWarning               PASS      27.04 seconds
CheckSparse                   PASS      30.95 seconds
BuildKernel32                 PASS      25.50 seconds
TestRunnerSetup               PASS      491.41 seconds
TestRunner_l2cap-tester       PASS      25.62 seconds
TestRunner_iso-tester         PASS      43.07 seconds
TestRunner_bnep-tester        PASS      6.09 seconds
TestRunner_mgmt-tester        FAIL      130.91 seconds
TestRunner_rfcomm-tester      PASS      9.51 seconds
TestRunner_sco-tester         PASS      15.12 seconds
TestRunner_ioctl-tester       PASS      10.33 seconds
TestRunner_mesh-tester        FAIL      11.40 seconds
TestRunner_smp-tester         PASS      8.66 seconds
TestRunner_userchan-tester    PASS      6.44 seconds
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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 481 (98.2%), Failed: 5, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.230 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.179 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.200 seconds
LL Privacy - Set Flags 4 (RL is full)                Failed       0.297 seconds
LL Privacy - Remove Device 3 (Disable RL)            Failed       0.260 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.040 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0383314979924514285==--
