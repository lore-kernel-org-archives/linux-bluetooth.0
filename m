Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C89F23B0
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 14:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745244111; cv=none; b=s5/TcNK0cSX4nEqTRNtTbw/JWj8YUN0x64k9FxEan4CPsCbhaTrqfUcpaaMF35ghxyadu193aF9NtDs9ALekPoJj22XQMVw8Qx9WtT7gHqJQiDQhJ43yxkjr3zRq7VHfdXyh9Y3J76IZZ5qI2ButHsK6StwVuu7byJ9oc4+jjhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745244111; c=relaxed/simple;
	bh=uYW0DJZQrULp5bnfENFkd8draVfy/ICypLACaXGcudg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=kKAQiWpzp+4cNObgDPonze0N4/gjsCL+J/EOSD0gMiXcQfhZ0c1Fd5AfYvGNzcHG7RJLUHa8tXwUHh3mNDUVFRkbnhizZNx+pek9CAPlvCBYPm8zdSIiPZ0V+3i50HhEhRawV+CKm0ZVodUDkAMiUQb09n0Pc6tCrG6pewGfPcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WekW+Jy4; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WekW+Jy4"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7369ce5d323so3065434b3a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 07:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745244108; x=1745848908; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OG1hlvTrH+xS594bv2YKApU4h9hkTxCsde+zWR5rrbs=;
        b=WekW+Jy4zhkpG0KFkUTJmi21qXxVtbtWfAKqlAPXGddM/FazSMLQs70NmZzTY+6278
         XTZobp6AQPMOZHyFSjoblu6w3Cd1qGLD5YHsTukQdEmgDMliq7oVAEGWZ9upA1ZLB8Vc
         Gu//TJ6EO+8S3kqsw00EazuTAOPY3n0lHtOtclKZE+gW3s/9+Tct+4bLpPKLbnBqZzgV
         Q3eLTS1a5byLBSktesZy4g3NuKuCes1y/Bg/XeXI/3Mh1SZK5sufDUp2n5R5RePxjtWR
         3Qys207Iyb/bMVcUX2kK0T1+flVWH1svmvxMt9xwGGEkZ2Lmz8S3WguDCxRHhIGFckyG
         lR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745244108; x=1745848908;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OG1hlvTrH+xS594bv2YKApU4h9hkTxCsde+zWR5rrbs=;
        b=Q97UYlBf07ZIsxnutXGu25gRP+AKhD2xgEkLhxdL0ftVdUY5SGpGeMXptkwBLIjSAL
         NRM5Cm+C5fnoYb4AAp2DpYGghoxTxiVjrwRSvYu/1op4S5DFQjoGphDEDPQqQUu+1TAg
         hSI4SSPx7s+0VD2+FzHTt6xAqUfJKwG7qjQwEwcqd93tHfQa2Rc5v/X25zm21W6iP9da
         S9jND8P6y0ytRmDlE4oYEUY+18MUf9SXPFMWxw8yp6fm/tXR3Pc1zfxOryQHI5ZSUbD+
         kxPyvSOXL2bVYdRpN6WA6gmcE/DucWVidhVARWEhytNqz/DXRHsqRLS1nS/IyQeKDuXA
         rlmw==
X-Gm-Message-State: AOJu0Yy1k4FIfSDVEjeWmJVGftNQI/S0WMZUugvkwmjcmqYR0O6Ha/aU
	KncIjhswvc6JFqGbU8Pux+ZTCBc01MtqlukLqNyFpFwwFAJ7g7U9SflIig==
X-Gm-Gg: ASbGncuYmtX5aULYBLkhyCqY0CLw1x2ayLGCm2fuFevqLY1Zsho805muNmWUHD2eAFe
	kWB4dL4WIJy4FyQtDw8v6IMEeTRZf9fONg4JmVIIKb3+Z1thurAfwYWtvMRKLxl4wrR3aY8nFM3
	lgaHOlU3zJ1Xdy1d37kGZN0pL7J7PvkrVcislTyeZasVJxe2AC7ma0FY7ZPRKNFKtqTphVNQy8t
	gTY/1nwMX+Qxy39leeVORTRWwnOp9m91zbOKv2XY2kWM5pJlfE7aIeO0+UDVr6HmzMwOh54JLMJ
	PGq2ez1Omqdzt+NCAf9z6Jt0MIghVG2U7FzCEKNwFFt5CTs=
X-Google-Smtp-Source: AGHT+IH03mcQC7Q3VqpofJ2w4+WxIDGYmaNc9tZ0mcvSJ5ATAuLWwXMbsK08ReIrKN88uKaM1KIX7A==
X-Received: by 2002:a05:6a00:e8b:b0:736:41ec:aaad with SMTP id d2e1a72fcca58-73dc14b3b4cmr15281281b3a.14.1745244108198;
        Mon, 21 Apr 2025 07:01:48 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.46.148])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfaea2cesm6548733b3a.164.2025.04.21.07.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 07:01:47 -0700 (PDT)
Message-ID: <68064fcb.050a0220.3f9ea.7fd4@mx.google.com>
Date: Mon, 21 Apr 2025 07:01:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7890753894353483175=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: Bluetooth: btmtksdio: ensure btmtksdio_close is executed before btmtksdio_remove
In-Reply-To: <20250421072914.466092-2-chris.lu@mediatek.com>
References: <20250421072914.466092-2-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7890753894353483175==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=955282

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      24.56 seconds
CheckAllWarning               PASS      26.99 seconds
CheckSparse                   PASS      30.07 seconds
BuildKernel32                 PASS      23.97 seconds
TestRunnerSetup               PASS      462.27 seconds
TestRunner_l2cap-tester       PASS      21.38 seconds
TestRunner_iso-tester         PASS      30.72 seconds
TestRunner_bnep-tester        PASS      4.61 seconds
TestRunner_mgmt-tester        FAIL      119.29 seconds
TestRunner_rfcomm-tester      PASS      7.73 seconds
TestRunner_sco-tester         PASS      12.51 seconds
TestRunner_ioctl-tester       PASS      8.17 seconds
TestRunner_mesh-tester        PASS      5.91 seconds
TestRunner_smp-tester         PASS      7.09 seconds
TestRunner_userchan-tester    PASS      4.88 seconds
IncrementalBuild              PENDING   0.85 seconds

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
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.166 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.193 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.146 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7890753894353483175==--
