Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D66412E5B
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Apr 2025 11:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745754894; cv=none; b=Zt1VkgqyOi1pAiZGwRCBBWnQdRDRoKqZ8a32ejg4xjsfO5bkwWK43g6itpKVvybSfXE8j1f3jWqHjWkYUWqcIZo69PM5v+Xs5Bt/Nxfx8lr1012GljdBQSdJZ/h/99+sEv2bXZQJMvukI2Cc0ULCBm3cIR2F7cRIpJorpJaZoUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745754894; c=relaxed/simple;
	bh=gkTjttoK4dY4w7pDKd2m28ZgOhXNihS2yu1r2G8noY4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Ea2HnuRiNzIo/PS8kx755TNZzIzBfGPTTyAbiKqZ+DHV0m9BgO9Xw6T7Psy3R49/Kj3p0FPjtt0slolVW9hVuRzgVGDqEMoe/tE+eXQ4yDwoabwzFzE5useLzKlXyGa+RNBwiMGsGuaq7XleX6qj15lewPgYH/Mnrooxoe2EC+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5Y7tOl9; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5Y7tOl9"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6ecfbf1c7cbso72501826d6.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Apr 2025 04:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745754891; x=1746359691; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Yq3jqizUpG49LzA8wMFhMnMp2XbaWGz4BPYEu+ca/Zk=;
        b=l5Y7tOl92txmwNQvTD22e3jYjLwPYCm3rxGR7bhynKBn04u79ImjuRbItTZvCV+YFB
         /ePIrSoo6ZxejTVIZoRttJ0KcEvvI56JujjPHoHXtvZl7mmLxAbCOWGAl39KiMt37e8L
         1Ux67rUmNJfqLM5Hw49ooGEEWkSuCaLA3Dx2qC5CbZhtrmRF2B70h398MjpQGQvFLE5x
         bjQ0pOot7c8W75el/dXiNC9nhk6sP1hs4+/8JTE/6x51rxCyLkkh/OIzmdr7gqOC4jA8
         TOwT5bQFbDUCQxG36O9Cv/th6LD+vf9hMvsmV+Kp4dNbeB2WS1Cvf3vrHrgNCTrQWjEd
         YH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745754891; x=1746359691;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yq3jqizUpG49LzA8wMFhMnMp2XbaWGz4BPYEu+ca/Zk=;
        b=kGWnJT3RECAZyV6rfZa6Wv/Q8VWHvvpDz/tjfHulP6PreZcxwlavFdbSvXhvyAhk1c
         +FwwHYgItOZnfFL/0gx7aUfidNxoFX77WelMySc57zWm5b1Z0NnEfAkXfpIXhw/KBdBm
         p92zJgipQ/jr1E2IFVKbuYaJ61kUUAPcSzCw2ABI2E0b5WXShFkQ+4kTx2H1bEqa8xcg
         r8/0xhzThWZgslT8yWfXT5UP1/iU12GmHZzedIP3uq/WB0ngpAKJKXRdjXdfsRsYQbP5
         IJHbVRunsb/zrxzL7Y1BUj/O0kOOowGao7WN62zbYgvI5gcZAt6UUL+Y26cD0RyUZ9iT
         aQvg==
X-Gm-Message-State: AOJu0Yz2V83IEsFIhufVgk+Glcj7YClqWfgHosDKpJYvLCIcMx8a3Ay9
	/aJPkoR55nGbSxm4Hvv/T0w5if0hF47304PXhRvXTbfKkQqf93NYd+r9DQ==
X-Gm-Gg: ASbGncuxdCTUdiuidRuHO2aITOTwbvMiFEWTrP6ULdmEO5NnICkj1QdHDrTMm1mpw85
	0Hn3e3fAROME9iIsCeRa6EpQTRGNP5G0QVDHmJuFDKZfrMJeribCCpV1ovrw/XozgxxYBT3atMl
	KYeQGvCV70btLQwv4gvc3mWiRn9zp+QY9hAhmF0zxtKBcFihMzWMSVIqxD/SPa6d+GjjUDCNJhV
	iKZ8+j0cuLfpIKzUWxy3teRpZrKyU71L6srlPj7CtPd8wHXzlCJaI/RJ0QI+GooyqWTSRR789HS
	lkCfj6VE0cBy9fFlogZelhRzbRcr0Rt5drEO8dSPxBLdow==
X-Google-Smtp-Source: AGHT+IGRwfNiHICGcQPWVVFtOZFIKFUzHDL01vjprIIYU/7KKgTm+wfe92k18WKwv2MJTEW8LEojww==
X-Received: by 2002:ad4:5de8:0:b0:6e8:fa72:be4c with SMTP id 6a1803df08f44-6f4d1eee1ebmr88467606d6.1.1745754891171;
        Sun, 27 Apr 2025 04:54:51 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.192.57])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4c0968ed0sm44231956d6.67.2025.04.27.04.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 04:54:50 -0700 (PDT)
Message-ID: <680e1b0a.050a0220.2ae2c9.bdf5@mx.google.com>
Date: Sun, 27 Apr 2025 04:54:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5441072937238578002=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [v2] Bluetooth: add support for SIOCETHTOOL ETHTOOL_GET_TS_INFO
In-Reply-To: <20867a4e60802de191bfb1010f55021569f4fb01.1745751821.git.pav@iki.fi>
References: <20867a4e60802de191bfb1010f55021569f4fb01.1745751821.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5441072937238578002==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=957490

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.22 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      24.31 seconds
CheckAllWarning               PASS      27.38 seconds
CheckSparse                   WARNING   30.50 seconds
BuildKernel32                 PASS      23.86 seconds
TestRunnerSetup               PASS      460.43 seconds
TestRunner_l2cap-tester       PASS      21.56 seconds
TestRunner_iso-tester         PASS      36.01 seconds
TestRunner_bnep-tester        PASS      4.81 seconds
TestRunner_mgmt-tester        PASS      121.41 seconds
TestRunner_rfcomm-tester      PASS      7.71 seconds
TestRunner_sco-tester         PASS      12.31 seconds
TestRunner_ioctl-tester       PASS      8.17 seconds
TestRunner_mesh-tester        FAIL      6.18 seconds
TestRunner_smp-tester         PASS      7.08 seconds
TestRunner_userchan-tester    PASS      5.15 seconds
IncrementalBuild              PENDING   0.78 seconds

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
net/bluetooth/af_bluetooth.c:248:25: warning: context imbalance in 'bt_accept_enqueue' - different lock contexts for basic block
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in run_timer_softirq+0x76f/0x7d0
WARNING: CPU: 0 PID: 66 at kernel/workqueue.c:2257 __queue_work+0x93e/0xba0
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Failed       0.119 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5441072937238578002==--
