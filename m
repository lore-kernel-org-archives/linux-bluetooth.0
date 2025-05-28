Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CFB243953
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 07:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748417643; cv=none; b=jXABFVouwLvDMo/QWrGcFFn7BR13OiVrzZPd1/zNcfHH0W0th7yaddb4RLv57zOBiZd8gBH8t/WwMHsDo6wX+3o0Dny0hQJLxiAkljRH1ettcuLiW8Z18VRrdsenFuz4RZA+i053k1+uuG3kLCmizBbSThMqTSJwbOn9/wGmlDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748417643; c=relaxed/simple;
	bh=YicMnlEZXfbbJtX86k1t7nCbyngtvPBwkRO+10oABpA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=syyvZT498JQo8rVYO1j1xmW25Sq0LoYXdVO/v9nMEuc6hoCmrpdg/k3tBbX8efO04lGvSAATowfe7+2RXs5NznNvfe3ME5/uittakVy/sMhC7+0v/H+iXUzCJB4yfS4pbHdRgAYXb8bWM40yWj4H+pDIz7Ih/qHIjnwQn12yVA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eSmaKVDR; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSmaKVDR"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-877d7fa49e0so2610520241.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 00:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748417640; x=1749022440; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=m4NCpc8R2+Sh4j/J+wYUiGrCY/42wVp5lV96KBFwB/w=;
        b=eSmaKVDRNV8BpOwMugkbXj0y+4vTxdUKeIJ5uLNElmea1xMPg7I0eXKewTC86QTbTy
         6cl20wD/s8rK1k+0oZyw0g7ITnF/m71SfzwyDX/uLj5Lvue54liOqcEmLoMRJ3/q0jJl
         wEafHOKymGb9VnbtECL3ms0k683GHXbXAWnB55dH2Ao8PmYgQ/c1lQLXO1cB0AXmhoCl
         sQwkFAd5zDhpo7gYdANSd49p1dU1FgE+fs0nZJMaNllUgHCa0Nb3bCZohK7U2x/bKutj
         V9hrfKr/4GkrfiQFNJX8gVoul4dgLGa+vADa7xuIxCRx/26kkgaJZEoJv+s528TYreBh
         gj9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748417640; x=1749022440;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m4NCpc8R2+Sh4j/J+wYUiGrCY/42wVp5lV96KBFwB/w=;
        b=IPCeXTx+9yEJUzaOfG+VQDqoA5YvkFFkdJdeLjpzfV0t/Eh3ofu5vHE4tePo4Hkeyz
         f0tkBM0kvrpc/qZbSgpMfQ64CfJq07t6mh1zrI1/W8AoSl5r8If29vjaLkxjyfkQbgIx
         ShKJB0cjEjLwIdVf1eWkPGMMw4JW0fJD8xC4EJZCmH4iCr36G5xV8HuMgLDuJ4Ssw0te
         AE+NMxemk3Wv/LDbQUyLeEXS9yxbhyNt7I9Prmmii5JxyR4t1eStjEadS8KjQhzGiSye
         30xyR8/3X/yUoxkEp+Qd8kAVQTfLvvwnoVyHgmHykym0pWhM9Y8s41Q439zvaYGCOntE
         ibHQ==
X-Gm-Message-State: AOJu0Yw0xIyQdS1a6JJK4l50K0+DbxCPZ5vmC0GBfBa86vh3RC3Uv1fc
	Jr+HsOlSVa2Czc2eotu1viUE9A26qZmJYwQb7iPAh/z1WXG77sGaoIt2X416Uw==
X-Gm-Gg: ASbGnctyBD3xZQulGa9JcoQ8Ukm1QD7GIhEj3TE1a0fa8kLSKkBQM+nKdbIU54iHMkZ
	nzyE1aWT7iqMaSaVx3Kvu7BHy2EO12AzMCo0sstVyrRLd6hG693IdhH+zKKqj4gtF2J57PhB/+W
	AImO1m2tLCXSujBXVlXW19XTnHjNHAZVfTyzfhTa/DJHqrZGOg4UZvkZW/AexhiET/tCQ204MQr
	9Xd3z1qIM/c6PUSlCgK9QF61rGrhcKVniElrmgCCIZbS+tOzhRw/JdogfUrZF1aO6Iyzu26vWhy
	Slg/PHlaqzOLrf+VXr3y/gI7E//P+iM2EVoQ6ZvFKUs3Aisq8ty1ddZQjg==
X-Google-Smtp-Source: AGHT+IHsPYuhHXaI+1KofB4yJfM2W4zMDs56FU+EIpCZlfiRibS7wkVXre/EkuoGW4MmOTNrCtzF6g==
X-Received: by 2002:a05:6214:2b0d:b0:6f8:8fdf:f460 with SMTP id 6a1803df08f44-6fa9cfea4fbmr235795346d6.9.1748417629821;
        Wed, 28 May 2025 00:33:49 -0700 (PDT)
Received: from [172.17.0.2] ([172.200.17.89])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac0bb9c55sm3399446d6.78.2025.05.28.00.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 00:33:49 -0700 (PDT)
Message-ID: <6836bc5d.0c0a0220.190d3.069d@mx.google.com>
Date: Wed, 28 May 2025 00:33:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8489484643092221584=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ot_zhangchao.zhang@mediatek.com
Subject: RE: Bluetooth: BT Driver: mediatek: add gpio pin to reset bt
In-Reply-To: <20250528070323.14902-1-ot_zhangchao.zhang@mediatek.com>
References: <20250528070323.14902-1-ot_zhangchao.zhang@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8489484643092221584==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=966883

---Test result---

Test Summary:
CheckPatch                    PENDING   0.23 seconds
GitLint                       PENDING   0.24 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.37 seconds
CheckAllWarning               PASS      26.94 seconds
CheckSparse                   PASS      30.20 seconds
BuildKernel32                 PASS      24.10 seconds
TestRunnerSetup               PASS      453.81 seconds
TestRunner_l2cap-tester       PASS      24.84 seconds
TestRunner_iso-tester         PASS      39.88 seconds
TestRunner_bnep-tester        PASS      5.92 seconds
TestRunner_mgmt-tester        FAIL      132.14 seconds
TestRunner_rfcomm-tester      PASS      9.36 seconds
TestRunner_sco-tester         PASS      14.65 seconds
TestRunner_ioctl-tester       PASS      9.94 seconds
TestRunner_mesh-tester        FAIL      7.55 seconds
TestRunner_smp-tester         PASS      8.45 seconds
TestRunner_userchan-tester    PASS      6.13 seconds
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
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.155 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.201 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in run_timer_softirq+0x76b/0x7d0
WARNING: CPU: 0 PID: 68 at kernel/workqueue.c:2257 __queue_work+0x93e/0xba0
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Failed       0.136 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8489484643092221584==--
