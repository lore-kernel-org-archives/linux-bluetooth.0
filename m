Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DC719004A
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Apr 2025 17:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744392744; cv=none; b=U1XrX96RbK3nYCROFq2k9YsXOxTY5hVQrgc9QcM88LxxdZ3QsqRwuDMEocuoP2B7jeHdKCO7VnGDqdQn6D1KqWMnRe6Javcop9ZkwkvWKX4/CMFFlUp/BS9IhFO3wLXKHAiID4OwQwCW+NYUmDNPZJwIuFQUcAftcjynWNRcQEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744392744; c=relaxed/simple;
	bh=1daLjpjlBE/D4NwIQFVM1o396cycn2SL5c12yYUMZDs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mzj4fRiLM7vKcxcOeC5jtmXureyVI5i5V047whysJsjAWpKwEWt1HBIFJ5IqKN/kJQXOvkOFMxOP3aFsN86m1IYTAxJsMhsuR31/f47g5m+B0BUkmkhGZBzsTBySJLE6G4VMW+NoyhFBoUGbCyfWMU5xOL2NQ9AqnZ9cq/awEqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+irkYpm; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+irkYpm"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6e8f05acc13so23977736d6.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Apr 2025 10:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744392742; x=1744997542; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8mpTDjzypvXFUUN5NEm8xWnIz8vY2UTBgqYX9kMjQa4=;
        b=V+irkYpmIvTWYaPeCKZmqrMxi/4uSo+AD3QcTx90ssxgTh33EjZ5FH1inW69JdXM4Y
         kIgzYFoKmjShANPoilLKIsuEwoQ3XeJ6JoB/vbgcgHwERhHm+pfiO5lDmP8+G98kUrti
         +yMUXupvhMxC5E8hp6BrnJvqYuplkxjxltqQszqfLoH8/pFbjIvMEFV1XiSc0xJIQT8U
         x0IAr1z5/fJT3foR/k105H8zV3aVNMvs+dq2LqKGtE2jryyt2UA4cy5eFopbQwvVy7wp
         1m7q1Na+luRiBxbTDAaz+l+UgY9Bt89XQfPmhTaDuJmq/MUl7jsHD8ZumfJjV49rFblN
         0csA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744392742; x=1744997542;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8mpTDjzypvXFUUN5NEm8xWnIz8vY2UTBgqYX9kMjQa4=;
        b=F1/RGoA6Hx12jT8hjxuyx+q16UiDfLSffiqmSrqt+ZdPVK5TGD1EXEKT5kvlF9y0dZ
         77HD0Ejra6PORJp4gad+El6xzB5dIGKzpjWsyLae1DoLdSqqKlr9PpxDEgVrp29ZeuIK
         Q0p58BQW27jq+nPrRv35i2sDTZUwOmZ8sglW0A5WHBnlAUhiBK4YRhQG9rXsD0qRsrO0
         n6hwcmMc5UuuUGw9W9LO0z5eXefl9Ayvx+KqYaWsbFJzWCTmmCwJk0YfQxL7wKa7doRw
         yxq7scYbe20p5qECLxt5dhEB0KGppyCy4dHZ1P275Jdg7CxVOEmg3DwFTCzwd0rnskdA
         2cmA==
X-Gm-Message-State: AOJu0YydiyxjzcgFyw0Rr6OMNVKAYCI3cMEMITqh8OYOsvpHT54D8m6w
	aimoCQWiniopNdogrVmKCaYoBz9DJyghtrfqZAXPLHLygnMKtd0jdLABGw==
X-Gm-Gg: ASbGncsuyQl9aLffsV3MCviykgRfYhReKlTE36YYc+XkuY4E8zh4gbgiKHLSCEmtHeP
	EcRBbJ/ghCmCtvvRO+/wHt70ew7i5IW9cxMEx9RWEnDFGMItHI68BAEybd1+38chAmHP+EEdlBw
	A1CGO/hCPEe6ga8/EaccyJTOKz7VPjyWo29WCL6mkEOnIK+8yZv/ePJKAkcHxSBifEf8KTUds3A
	ha39iDTD1AhZHRvL1CrMaBzDCcIJ9m8nVpVjfaUlhm8Mnkan79NCU5X+nIyhLIor6acIYpIyaTx
	UTuQVvISyraItS6c52pmjkjicTLhQcgRClyFXNpc//w=
X-Google-Smtp-Source: AGHT+IHfeYwaltq9Akh2NO6OHBtcBdjSXX+KUO5hrjQ8JbsS5mXZftGSSgrPFf/TXkz7e+aJVTI6iA==
X-Received: by 2002:a05:6214:415:b0:6e6:6598:84c1 with SMTP id 6a1803df08f44-6f23f164206mr50944866d6.42.1744392741564;
        Fri, 11 Apr 2025 10:32:21 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.46.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0de970be4sm39479706d6.30.2025.04.11.10.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 10:32:21 -0700 (PDT)
Message-ID: <67f95225.050a0220.2f2f25.cb70@mx.google.com>
Date: Fri, 11 Apr 2025 10:32:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8774185979266640810=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3,1/2] Bluetooth: hci_conn: Fix not setting conn_timeout for Broadcast Receiver
In-Reply-To: <20250411165608.871089-2-luiz.dentz@gmail.com>
References: <20250411165608.871089-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8774185979266640810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=952580

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.21 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.09 seconds
CheckAllWarning               PASS      28.42 seconds
CheckSparse                   WARNING   31.33 seconds
BuildKernel32                 PASS      24.96 seconds
TestRunnerSetup               PASS      471.14 seconds
TestRunner_l2cap-tester       PASS      21.62 seconds
TestRunner_iso-tester         PASS      35.32 seconds
TestRunner_bnep-tester        PASS      4.86 seconds
TestRunner_mgmt-tester        FAIL      128.17 seconds
TestRunner_rfcomm-tester      PASS      8.10 seconds
TestRunner_sco-tester         PASS      14.98 seconds
TestRunner_ioctl-tester       PASS      8.69 seconds
TestRunner_mesh-tester        PASS      6.58 seconds
TestRunner_smp-tester         PASS      7.39 seconds
TestRunner_userchan-tester    PASS      5.11 seconds
IncrementalBuild              PENDING   0.39 seconds

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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.182 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.205 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8774185979266640810==--
