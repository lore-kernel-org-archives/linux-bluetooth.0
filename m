Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978DF2B9A9
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Feb 2025 09:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738403597; cv=none; b=tQ3SkBmJxJza920DEUExj9TDCMlQEBdX9vwGzs4pteuxx6f7gUfUvaSdLr8wlrLUg2/cYjgSwT0Ygqtb7p1ixRHkIMPNBJk7qt5TfHHlYKJGeZSWeNgE5UJbSJZUq3jt+Fwiw//zOwWnACndjAoo00r5bR9HMn+C5VhBkYDBPLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738403597; c=relaxed/simple;
	bh=6qiqdqI8zdqvj4dRAYMF052S3fhSGS9EwhmSlJCrLRU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=vGqzyTzLggH3OkDJS1qXlrOeJ5gAZPEgozvuR7CfUxjqoognQkPJ5TqnMtbZtwqkphbvreHVG6OmwuZgnzy1vDbarteyCBUuA5Frwf3UJfne6UrLMU56xp6DNf3U7kGPnNDApMaoE3CbCGaHOq2NBgCP/LbR1yadr6lbiTGf0Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QM2qP5z4; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QM2qP5z4"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-216426b0865so49694175ad.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 01 Feb 2025 01:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738403593; x=1739008393; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=07KK9Oo061uOMvdWduBamdyd5UyyaigubIrmXf+53FA=;
        b=QM2qP5z4QfceCLII3N7ZI5YUUGv0HMsg/phs9hPVKVSImV7P+1CEpVSt0AoPkovmvG
         NxpYcTtufPMRjl2RxHBU98TTSm5f4VZ4YahmUdgqYP9elRGwZy8mRZyixQl55bccQ3tX
         +XQ+yiW4pcTqXjFPeaEsNWnIWuMojX3A2I50PaN6+z+IVXxm/BiX2EHfCr9ppXbv3yO6
         OgqbPGJm5Hb+l1GOp9FZPAj84bQPFqe3proAAGmXlg4cfGqix6FPR3KRhPg5uSerM4aI
         epeYU6x4r+x7/Xz5G/jV5UGmVKq0VEgT8HkVZcQe6eCMrIXkUOpSxcJ6dMhhH2keJ3zm
         i79Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738403593; x=1739008393;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=07KK9Oo061uOMvdWduBamdyd5UyyaigubIrmXf+53FA=;
        b=rGP5XtJ9zWXwBU5tk/p+2YyWSORIslIZtyOBnCV7C5JYDbYWwgTetis7R6ErJZGeMX
         b/Q4P4omEFMrSXfG1wIz3Men+4spFBE8ddsydrMS2O3RTkI0t70KXOITPkHYaH4PHApg
         fBjFPKkFC+h9qHWUc6hvpMaLLvFkYAPCEbj//kOVjLo7j4BCoC0DIlssG1uQPZZJcw6+
         jmO9MFOvea8xo3wj1WgN7EHgvVaJDb6zVsCK47IelyR9qo+i2off7YagveHTLhzmlIin
         BxbvRLSzXWZXMo0aj/Din5QlSlsXyk8LyDoNAHjpR/2NziiE1F+6AqvuXUy5Y/WYs8c1
         4Llw==
X-Gm-Message-State: AOJu0Yyl4T+DtzPpUE4MYNFhNznn4CprHsneCcOwszxu8qYx6g/Q0GlS
	6gtQUOyntMbLfkMVWdjw05dtv1S+gCm7WfIPdJ6y6zejwXc/xL1QddUK3w==
X-Gm-Gg: ASbGncuS7P6gK+XUeIMd1CaXhLhTPTHZe5dspeNoM2Q0x0nCfNFbWasLbQxj8L3Kpym
	0eFA7LYbf4Y0AGGRkv9o14g5tvsuluwknWYtOXdm1UNQ+G6g1RJ9Sd1KmmcTV4x3DbRuV+AD1ib
	JNPfFaZ5svKr3TqKrf4ECyTbtC5qoBujKQbYdQlna+qJ6FNJtBUXXFRR/YB5CIvt+cDcCj2l/eP
	uMMD3ai3N+rHLzYcaKNnFqY4NbsMhhgai8FuBsjjRhGnfH/loPLITocmOVl6Pe+7iKIMpBZpNDp
	2P1KJiXV97BA3tv8Tieigw==
X-Google-Smtp-Source: AGHT+IGx1p6FsrZkS7oVrjv+rfqAeHfo5Q0ER7ZIXmLLct4CWCXHzQLaYUip+Ve9SHd2IhrsXq/CFA==
X-Received: by 2002:a05:6a20:8429:b0:1e0:cabf:4d99 with SMTP id adf61e73a8af0-1ed7a4c0a16mr23464789637.14.1738403593470;
        Sat, 01 Feb 2025 01:53:13 -0800 (PST)
Received: from [172.17.0.2] ([52.234.41.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acebe94af26sm3759138a12.45.2025.02.01.01.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 01:53:13 -0800 (PST)
Message-ID: <679def09.050a0220.15ff31.9072@mx.google.com>
Date: Sat, 01 Feb 2025 01:53:13 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2549983939072914952=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dmitry.baryshkov@linaro.org
Subject: RE: Bluetooth: qca: add Qualcomm WCN3950 BT/WiFi chip support
In-Reply-To: <20250201-rb1-bt-v1-1-ae896c4923d8@linaro.org>
References: <20250201-rb1-bt-v1-1-ae896c4923d8@linaro.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2549983939072914952==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=929674

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.22 seconds
SubjectPrefix                 FAIL      0.56 seconds
BuildKernel                   PASS      24.49 seconds
CheckAllWarning               PASS      27.04 seconds
CheckSparse                   PASS      36.85 seconds
BuildKernel32                 PASS      24.26 seconds
TestRunnerSetup               PASS      435.55 seconds
TestRunner_l2cap-tester       PASS      22.70 seconds
TestRunner_iso-tester         PASS      32.20 seconds
TestRunner_bnep-tester        PASS      4.89 seconds
TestRunner_mgmt-tester        FAIL      123.10 seconds
TestRunner_rfcomm-tester      PASS      7.65 seconds
TestRunner_sco-tester         PASS      9.54 seconds
TestRunner_ioctl-tester       PASS      9.27 seconds
TestRunner_mesh-tester        PASS      6.06 seconds
TestRunner_smp-tester         PASS      7.05 seconds
TestRunner_userchan-tester    PASS      5.07 seconds
IncrementalBuild              PENDING   0.50 seconds

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
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.143 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.190 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2549983939072914952==--
