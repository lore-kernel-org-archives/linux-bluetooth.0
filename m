Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0469D30FC17
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Oct 2025 08:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761727207; cv=none; b=OeLqOEn9vE5BI+6czdIEUTqTbSqpyv3pP8pQxYr3WzXSyUIYNBOHe9puY+y/6FvCaozpQ9IYkWHWTo9crsYXrDBBHv46S6bhOGJfmGzFgVSm+cQXGxVmPMCsIds36hDtEzLLLD3yOvITMp4L0x304l/YU6h/5RkSI7QJciV0GoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761727207; c=relaxed/simple;
	bh=iagRSnuZQkLp+pjvFcq6uG94kAnYYDpqeKKHHwmx5dk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SjpJEarTXztNjGcF6GMM2T9Olkh9K2Byw0RgYHqorQpjZ5sZHAciH1n56enC75bqgiWvoqnp/vmD9l8kRAA19Ifevj3Jc+minJ4GrTAbo3A87+bm79i9PBKEMxwTtcTq8eMFkoy664LS40mF5oM1VreHvAXC5HMleMIZYySTTEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjkBlD5q; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjkBlD5q"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b6cf30e5bbcso535659a12.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Oct 2025 01:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761727204; x=1762332004; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cxD8WDzgo8U5GmfkZb/NiH7VHxwhjIBJlaAZWJrp/kw=;
        b=HjkBlD5q0RJTYVtHSL/drpe/bQhpmKcScrDqKUUKVmlJ1ctNa7B7uFx19BTGCbGGd1
         V0kLLVqfuL8pD+l/vQFLZdBCKxxFC+hm/oL7eKJvCjl+ZHPcBCYvU1/AOGxKyV8Kbvpf
         0m5qm8dPPK2q1K1wr/Kc9Q+Bh2lXvBDB9npK7UCsdddtC4fn9Xhm9MHoEiTMj5UlrkBS
         poL52AMBbmhI1kcr+zfpDBvQXEVf0LwRoolvo0fMHlHsn/tsNVixwN+uxRxPcknMGIMi
         Kt+emCSL0Gq0U8haWKLVZisPhup10jKj7gK6o/0cKT47vVXP5RBMKnZJlD+VUHapN0rS
         Q7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761727204; x=1762332004;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cxD8WDzgo8U5GmfkZb/NiH7VHxwhjIBJlaAZWJrp/kw=;
        b=PeyPWgohCh901JCym11igql15WVdi5gynlr4x72ZXAAB98cG/azqn9P3USrxTedT2u
         jja96sWstZgI1XfRT7zCPbBUG68sZCtjzIm0r9A6/NrnmSa05RLgyo21gNJSz6xSbgcV
         gNMF7CjNtyMeQf2St7RXuM9qjS2W9I5jXaD4qeqOeyyvWL4t8TCfU6a1DlbGMo2yuvkK
         sX+gmp1hr/Aunx+hPkRbpn+M7ZBfXlqgFovPpjbkT9H8Sq7y8cR4RpDpa+8vStgHdToE
         gcd6Vlhoi+6v+wmTdLiow0RUT0WYGkadkyCsLVCervcqi4VAZJWldJP6gdgnL3Kvxvn6
         d/DQ==
X-Gm-Message-State: AOJu0YzNkX6h2dOfIUeAR5HmL5NGc06+Z4FG0e+bGW+6ZXgNrq4i0CAK
	vwx7O/ZMn0+fm+yVGv1oWzK+WbZ48PGdJuNoLC24RSApr03z42aMz8BQau+f2WUu
X-Gm-Gg: ASbGncv4SHHGNkBJQ1hK2EzeibAtg0dzwTIaXSzvBgUPL4enK7LAb6sUtnjbWY8dsCa
	/cEz7Mnko+xQjaKvdqp9BnbcgUPqH0YlJLidhABKu/Vs6eh+XHaY7BrKbsOlKdEUo2QeQzVOzGZ
	OZAyKdbdhHB8S3U/fLTMMGs6CFH3kSI5+9o5aNbhSqD0ym1DeFCoYAVK4q/8k9ORXBYJhcji+nC
	ApXL8fVKhgiMArfFcpuLPQYCA2LDDbqwULy7/Kd4z2/S4IvCFZuxcBS3X1rHzED3apPGFyAeIxk
	qhlrNU/V4icp1wJt7vM5ijdoMUvgMbpft54gijwHuZNC5XlvGbrDs8OC17Guln6y+6SE7EhSiWv
	NVJjwcYzeZCIuP6M4lUCEZSvof/mEB5eyQEGCmGGlouOWWZ4hUohV0GlYfBETPoAqynLPgDGIaI
	DWwGIvCQ==
X-Google-Smtp-Source: AGHT+IFsJeuACv/XD/bYzS5IPFChLJ4PRXUB0FBm15CIEea4cteNggTnYw7veLgm9zyEMHbcXMOcEg==
X-Received: by 2002:a17:902:e788:b0:290:b10f:9aec with SMTP id d9443c01a7336-294cc77a4b7mr70209655ad.26.1761727203864;
        Wed, 29 Oct 2025 01:40:03 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.109.83])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3465sm146272935ad.1.2025.10.29.01.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 01:40:03 -0700 (PDT)
Message-ID: <6901d2e3.170a0220.3c1513.43df@mx.google.com>
Date: Wed, 29 Oct 2025 01:40:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7272889264772330901=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, krzysztof.kozlowski@linaro.org
Subject: RE: Bluetooth: dt-bindings: qualcomm: Split binding
In-Reply-To: <20251029-dt-bindings-qcom-bluetooth-v2-1-dd8709501ea1@linaro.org>
References: <20251029-dt-bindings-qcom-bluetooth-v2-1-dd8709501ea1@linaro.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7272889264772330901==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1017088

---Test result---

Test Summary:
CheckPatch                    PENDING   0.41 seconds
GitLint                       PENDING   0.33 seconds
SubjectPrefix                 FAIL      1.12 seconds
BuildKernel                   PASS      22.69 seconds
CheckAllWarning               PASS      24.86 seconds
CheckSparse                   PASS      28.31 seconds
BuildKernel32                 PASS      22.97 seconds
TestRunnerSetup               PASS      451.23 seconds
TestRunner_l2cap-tester       PASS      23.15 seconds
TestRunner_iso-tester         PASS      52.77 seconds
TestRunner_bnep-tester        PASS      6.01 seconds
TestRunner_mgmt-tester        FAIL      107.29 seconds
TestRunner_rfcomm-tester      PASS      8.95 seconds
TestRunner_sco-tester         PASS      14.02 seconds
TestRunner_ioctl-tester       PASS      9.56 seconds
TestRunner_mesh-tester        FAIL      9.43 seconds
TestRunner_smp-tester         PASS      8.17 seconds
TestRunner_userchan-tester    PASS      6.23 seconds
IncrementalBuild              PENDING   1.13 seconds

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
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 481 (98.2%), Failed: 5, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.090 seconds
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.161 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.182 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.139 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.154 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in run_timer_softirq+0x76b/0x7d0
WARNING: CPU: 0 PID: 68 at kernel/workqueue.c:2257 __queue_work+0x97d/0xbe0
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Failed       0.117 seconds
Mesh - Send cancel - 2                               Timed out    1.976 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7272889264772330901==--
