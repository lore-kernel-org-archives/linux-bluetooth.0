Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10341ADC7E
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Oct 2025 03:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759892510; cv=none; b=QFSCz4nqqHEl8sybKDD/rsuK3l6Uwxs41jHLL8CqYgTKXH7y8pz15+eBFmVTGGadyFNtQv4pYeBU+q+z9O1vvg6sMzPQFEDR7XSPs67QJ0xKfaFi0t5zoSbv4yzQMT2UQ01owh0v9yJ09XH0r8b1JqijkJShwKGDrVOAr0IblnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759892510; c=relaxed/simple;
	bh=GA/HfNPmEPv6UABUXkhM+a4527LgYyYKllfMcF7Wkzs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GJn480jJ6+kyV3w8Wbu7iaI0Ed5qcXOPTE2kR9qZP03HI6cwj0vfD8gZNl7KYFbq1rmwLMkdLgA25TQmypBN4RM0Y0c3V4KB5fhkF7DCAxE9oSjhTP84x4L7s9TMDU0g6cR3gK7P34PFGZiVlUYneZ4PXr2yIY82ZVl9avDBTvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBLyYJtM; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBLyYJtM"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4da3019b6b6so63195891cf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Oct 2025 20:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759892506; x=1760497306; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WXbtPEnQitHddEzY/vfsqw7FPMPJITL09DmbY39t3KQ=;
        b=UBLyYJtMzohB4a0C0EQM/mCql7qAVO6H0csgjg9+dS7GilBZ70D1voHQ1o7DWMksjg
         ox5t2BNVvyLZNkhV0RKrNmb27S6LB/p0Jc0LhN2DkZ+3F2ia67Yp3xmJGK+V6OLW5ec8
         4//TyBuFTBlC7qbmz/LBUZS0otHMbcWetArv1YYLcZ8i++ZYXmub/cVhCM6befdCBMxI
         7uVoAfjowX1MpEV3TrozCmRdv74mqOwE/utGJnaYd24Zl1kA8LroC/kTBJVAg2c8eaz0
         o3TVvS7a76gftSsYXGvMpaFVscQDfKFq9okyb1zFjHrxwJqhkr+hiKpO4YW1VgJ19SuR
         Z+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759892506; x=1760497306;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WXbtPEnQitHddEzY/vfsqw7FPMPJITL09DmbY39t3KQ=;
        b=tn8SpMRBXLyCfJXdScsCwz/QCYj8CJCesHAYNPNpQIAk6jbCelbcLD3jmlEdI1EuCx
         F9GfBNaBb0gnqY8nOcTwqlv+R7OqmX1CNhPz1cO0wsBAZnyNLczBX6S77UbvR3tmnerW
         4bohtqa/fWpWT8xWs8/5zt/bIfRIJDoCAVn6lvSjvTNWu1dlwOV4mxOFEoKRlZy6bfFY
         jBVYxEBeWY/XomkGISK0FWepoXdy7VkfiH6cPJs7dT20TPJEYjvTzipLB9b9Gv3DoHaJ
         2tY18ABIQ513XoQBORey5QUykwOEHkctKxm43yqO6IzZmZiuWiTjzArPIgyuQ4rRxy4R
         rXGw==
X-Gm-Message-State: AOJu0Yx3XWoozNTlcbs3uASLPEuTlxxoA2RTlCMuDjzfBJIqpLfQTpaB
	NifOsqs70ERIdRep1pY3R+psWDScjarytBTR636cYeY9ghCu3yPaobtXpU1ilw==
X-Gm-Gg: ASbGncu9cbJkMDVRi69TcpZvCCwDh/7ClovpZOFaG585jd4Gm2RD2GsKJVnJQzaZ+o6
	UVA6JK0O6slw3XTLE2aBqrA9xCpW//hu/s0vx2wwh/MURWnxBQS7wCTRUkq87SEhBtCHQ7hXok3
	oT4bB5sfWZBVdyVBh2JBbddge3l/ouazKhz1kNZp9njtb7shatBTij545Qzo50fIVMy+rVUOSXD
	f6xlQ8TGK+y1V2/UBHNH7ZzYh38j6wrOMtZYKwFAjALkfuHk0zUNo5QBfLWuuB52HQxGyvXAZgo
	5PMzSp03RKcbI620BbdUJcDEoXA3vI4dDj2g6+Vf4ddV+D87vgxX0Cg5cM8ZhVfUIYaeIqtJAuI
	3qEu9vNpexcNXMQelTgJgQ5zn1WXexTu7bqNZTd8x2nxDaWHPF1Qf
X-Google-Smtp-Source: AGHT+IHQhNYiKtNvqpVZiIIMb+31x23QqqxrNxoMs14E+YmapCqZzjQWZt+T5JgLeS9yyJFevvRDyw==
X-Received: by 2002:a05:622a:181f:b0:4da:c4cb:c831 with SMTP id d75a77b69052e-4e6ead51247mr26139291cf.45.1759892506193;
        Tue, 07 Oct 2025 20:01:46 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.119.215])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bb4469bcsm156119846d6.16.2025.10.07.20.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 20:01:45 -0700 (PDT)
Message-ID: <68e5d419.0c0a0220.2d4ee.42ca@mx.google.com>
Date: Tue, 07 Oct 2025 20:01:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7871385508119340835=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, eeodqql09@gmail.com
Subject: RE: [v2] Bluetooth: bfusb: Fix buffer over-read in rx processing loop
In-Reply-To: <20251008015640.3745834-2-eeodqql09@gmail.com>
References: <20251008015640.3745834-2-eeodqql09@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7871385508119340835==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1009231

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.23 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.24 seconds
CheckAllWarning               PASS      28.02 seconds
CheckSparse                   PASS      32.38 seconds
BuildKernel32                 PASS      25.47 seconds
TestRunnerSetup               PASS      499.51 seconds
TestRunner_l2cap-tester       PASS      24.60 seconds
TestRunner_iso-tester         PASS      72.40 seconds
TestRunner_bnep-tester        PASS      6.24 seconds
TestRunner_mgmt-tester        FAIL      124.47 seconds
TestRunner_rfcomm-tester      PASS      9.47 seconds
TestRunner_sco-tester         PASS      14.61 seconds
TestRunner_ioctl-tester       PASS      10.27 seconds
TestRunner_mesh-tester        FAIL      12.33 seconds
TestRunner_smp-tester         PASS      8.61 seconds
TestRunner_userchan-tester    PASS      6.55 seconds
IncrementalBuild              PENDING   0.83 seconds

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
Read Exp Feature - Success                           Failed       0.107 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.601 seconds
Mesh - Send cancel - 2                               Timed out    2.002 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7871385508119340835==--
