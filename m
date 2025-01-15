Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3981D1E991C
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jan 2025 10:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736937116; cv=none; b=eXl0OLKc+r5SQFt8Zjc2fq+DuTqcfw8gpvu5Ltm712p2Vtu7zR/UQdBIblqB3SIf9Tp6szX86NVKtsEqgEmJzyh/Zjc2KFVo5fEupUxQg7P5XSMkaNUJIvodS1PAsAKfQkMvmv/SdhISjl8NzUkXbziUV7rhI81VbAADo6aePwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736937116; c=relaxed/simple;
	bh=BngzfcX/xlg0KCGkXFpEC4VsIhKVHarqSHAyIlsfD20=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UODeManR3A11ewSzBgUVcrw6CglODzvH9kyL8DMq4vZJIVEGhT6trAcdCYOmoQixEguBNMZXfwzbO64PmlWZ8eZyErVRR6p3/dsyZGhTrxon/irk2k3qobGpvxrVhXlWGcA6uXXcoQlbHuNMjkFEbp1oiNJZzciwcoWWFe8Ze/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1EI5MVA; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1EI5MVA"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b6ff72ba5aso618816485a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jan 2025 02:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736937114; x=1737541914; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Xt1N2wwTqeuucYsscksp8xdNJ8Ro1ofdLOesk4lmc+w=;
        b=B1EI5MVAnjZx1hzDQj8NPU8F95IfzRL52B95HQL0Ld3ktc5Lroux9va/eHU6Trca6h
         8bTBtch0OYxTBnF9VNPbHSZXPZldT9H5GsqCtrYrzsU/LaN5OxlTO3GhVGBDEme04BfJ
         wl6tI+t8j7cwWmDWsZNBhI+LB9Ld1nSKDmlX1qUakJoPgIEg8ZJkdqhFXVmldHyhw9ke
         WD/59wy2DQijrxRWBAXk6mvIXq5FsmLKvytTDPLoVUPSjKD+RKQ9iOeZ3MoT2Gut2YgM
         AOgY7Fdh6Z0wmWMcOiP5tmBMYDodLB8Mf0y1kSgu+Kd2KTD19RDreCqL10d5y/H0G3sx
         KMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736937114; x=1737541914;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xt1N2wwTqeuucYsscksp8xdNJ8Ro1ofdLOesk4lmc+w=;
        b=sRfs1jUbOr2E9f3amCWkx1ZNjC83WV6Gg5X42qaO8irP/qXqmuGNgrEDh0cpTQeFue
         N90kVB9thovvDRLVXPyDjC39YYBXt1EU/xUmNAlIGItK+pIKYjPCNTfvgSvVSTv9WWKW
         IfmFDcJjU+tnWNXAXvnxOR6nqIwWRSvoUZoOIKOyQm0unC1fI2Qil4+sBLmLJu4gAiqX
         u7gePQ8+mGR2O3t5A/2I2W37JZ0ApiDMu4U4l5x6hRfHWH9gpKDS8v85qhT8/kmwcekA
         /sRrQ+9mcXND9zQ4H0kpdneuuXaEzxIjOP8esUXXmRZIRh2UHyFW/WgWuUngJCpQAqi8
         P6fw==
X-Gm-Message-State: AOJu0Yy1aXesx3vczw+zLMP0qPYBrYQMVgl4wKQ40P27jPYYZuK28Wi2
	e37dRW9oDn/JQtMXT7e7j6mtupG5G+8x5ilMuSdTNey1vFLj6ssdOMVPIg==
X-Gm-Gg: ASbGncu8H+jak0CmLUNZcQ96XWuolrZ9FdzyP6Y9CuJYNHa8nnLDr/KNpemDlgL7fR7
	oBfd57ObdhVGnoPb4O8hdfkhi9bNf8D/45evwQrUzYKyQYTBim3D1iMY+7x6vpsm6DNxgm5J+QO
	1bNpYf+pQzed2Ko3OudTBUEbDehP3Gm8H+DJdFxu1VjlrXN88BPQ24IiHc2TCfGRYDTTR4aWOlA
	jW6/sZ0d74RvT+PBfG0QtM/5LNrW8BP2SqtkNi6i4kSmS6ECODe+5KVMKzHffs=
X-Google-Smtp-Source: AGHT+IE5Wkzx1cEh1NdiE+hE1utk/fIh5VV8ffgTyJfhUGScHRcCzVICFLobm5ngNymg+ok6UInYHg==
X-Received: by 2002:a05:620a:178b:b0:7b6:6701:7a4d with SMTP id af79cd13be357-7bcd97b87efmr4877979585a.56.1736937113790;
        Wed, 15 Jan 2025 02:31:53 -0800 (PST)
Received: from [172.17.0.2] ([40.76.181.253])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce327bec9sm699439085a.66.2025.01.15.02.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 02:31:53 -0800 (PST)
Message-ID: <67878e99.050a0220.24ec30.b21e@mx.google.com>
Date: Wed, 15 Jan 2025 02:31:53 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4713614293898127168=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, eadavis@qq.com
Subject: RE: Bluetooth: hci_core: sync hci rx and cmd sync work
In-Reply-To: <tencent_E7941CEA8AEEA2CC0879BA6C2C2C956E2C0A@qq.com>
References: <tencent_E7941CEA8AEEA2CC0879BA6C2C2C956E2C0A@qq.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4713614293898127168==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=925634

---Test result---

Test Summary:
CheckPatch                    PENDING   0.22 seconds
GitLint                       PENDING   0.21 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      24.57 seconds
CheckAllWarning               PASS      26.44 seconds
CheckSparse                   WARNING   30.11 seconds
BuildKernel32                 PASS      23.78 seconds
TestRunnerSetup               PASS      425.01 seconds
TestRunner_l2cap-tester       PASS      20.86 seconds
TestRunner_iso-tester         PASS      28.18 seconds
TestRunner_bnep-tester        PASS      4.90 seconds
TestRunner_mgmt-tester        FAIL      126.13 seconds
TestRunner_rfcomm-tester      PASS      7.79 seconds
TestRunner_sco-tester         PASS      12.41 seconds
TestRunner_ioctl-tester       PASS      9.03 seconds
TestRunner_mesh-tester        PASS      6.18 seconds
TestRunner_smp-tester         PASS      9.08 seconds
TestRunner_userchan-tester    PASS      5.28 seconds
IncrementalBuild              PENDING   0.42 seconds

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
net/bluetooth/hci_core.c:60:1: warning: symbol 'hci_cb_list_lock' was not declared. Should it be static?
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.162 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.198 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4713614293898127168==--
