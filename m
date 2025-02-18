Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E2F267B94
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Feb 2025 14:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739889244; cv=none; b=pmoWUa7cXBjkGORPe/1ZXFaURmmIRiAvy/+zOgUCAW5mf/wNXlGkUjT11cB0vvOM2JXmdFEGmuX7zxVboFwE5qmPQykn7rHwps95rmBsWO8UjSi4CfhAZXkV2cV2dRnY/KFavbbv/xrnvbJCKBPGHlT0vf9z0FEeu3B0fmntqSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739889244; c=relaxed/simple;
	bh=O2G52WIL8BPg5EhJDHALX+WqQD/5jy1Yx5P7j8VqBxs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=I0lvEacktIiCNb8bOUAlsZ3uVL1cNtfMuGONAalUeFePWsKftxfErhgOMLCnUCF0ZQzmTO71KsUzHHqjjC5Gnzpu6HaSAJ7rRCv25Gglmfye4EapZLQP3iPFzM8QqBTI+K1w2zqqQP5KxssMFx71ShxSa95vsxTMOUsVGY4pEi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agcLmRud; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agcLmRud"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e6846bcde2so12444206d6.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Feb 2025 06:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739889241; x=1740494041; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UzbG9GpO/cqwchwE1y475jPRE5Kylh9oJcCr/TTfioM=;
        b=agcLmRudL/nxjOICeTD2SebDgpUzW6FsABaRHW1/1dOVpb9HVkTHO+J5Lhf1JIXUEI
         mEEWXNcOJBFb46cE01I1vApWIbtrqQryGV9JJat14NvE0a8FL7aQUb1dPBRJwTl6NYmm
         WyisekZ+CISPEINJz0EEvpxD9nXp7btC/wgLxJ0jelIQQpX8sPmGkI8Ut05+g25cRhZq
         stbXLBqaZ72Mz/PHPZX1TPZqwmzBCUTJQJm83f2UVPh7FTcVqCS2B22Rn1Yr129KyXB/
         hD7SvELW8bXWy6RQlwfHnmiqP3PA7035xuzw7PDo7c90IWtBSUIj94TdMtN7NwuJauy4
         ofBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739889241; x=1740494041;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UzbG9GpO/cqwchwE1y475jPRE5Kylh9oJcCr/TTfioM=;
        b=P2Q1z6XiRORGMizwKGgNO5vmVLnlLWnt3G0cY0FU8OLOcgVG0zQCOpsym20rxISvWk
         Uol/QHJJ6Oso1oHh/0gxspkVc1pm7YZ1eDg51nC+HcbtYX2oYlvGZvbs89FOfqTx99LA
         Sy2WOWBuh6NNSSBs7PBUzH9DugEVNSOknUOGXyGkohlPax4eWXK8++MbMiig3LEqBOHJ
         aIv1UHbg8X+zyPKEGZM4GbvSBBhMi8NDhPVHiKv7Zvcis6THJMxej1jaeYSX1kifgzPT
         xsdEJPdDtDHzH/bSWBloerCOzhge6h6ULshQcaM34gCkHJ3cpndNQ7zScUIz54cN/DGp
         brKw==
X-Gm-Message-State: AOJu0Yy5IygIhh6xuDQdGFyHvtIxZ+Yf2L6tFda40nFcFBBX/iaa5qju
	xBsqZJHMr916079Fx9/ozfrmYjTqqwaAe5AM/MgkJVxpQCyEfNWznzHXlQ==
X-Gm-Gg: ASbGncszrjnPZop5nBibcaVzjiVbRkWiTnBKKmv4+gvTM/NwCJ35xtioJAReQaBQS/F
	9F7t7aymFenR8zUXlq1jUAejYdHoAnEr0+tlMFKMmCLOFVazl6va6lHZL1TKlG0KPIfItXN/YFj
	NTW0mP5VnmZqS7hTrB9kS4aFqED0duBw9Ou7cI7WYDMAGEht3Gk3EYRifLzAn5gD6LjfwhI59tt
	UyJofhUOjit1+Fu8Zhy+7JkRKm2wQ3ZDvmThCGWdcVH97N0QPGAY5nTAh5E2BRMMyJWt+aZDH1T
	d6HOXN0owmZUFIO8TdLC
X-Google-Smtp-Source: AGHT+IH2jM18kd5/E6RE+ioP2r4oqnfdueCAgixOqWri0M/U/B+YGCwYtCQscI6ynXd5ybrs/JGadw==
X-Received: by 2002:a05:6214:258c:b0:6e6:591b:6981 with SMTP id 6a1803df08f44-6e66ccce2c7mr210100296d6.23.1739889241274;
        Tue, 18 Feb 2025 06:34:01 -0800 (PST)
Received: from [172.17.0.2] ([20.25.192.57])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e672c1e7f0sm34568956d6.114.2025.02.18.06.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 06:34:00 -0800 (PST)
Message-ID: <67b49a58.d40a0220.22d6bf.d123@mx.google.com>
Date: Tue, 18 Feb 2025 06:34:00 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0704840615771779722=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, haoxiang_li2024@163.com
Subject: RE: bluetooth: Add check for mgmt_alloc_skb()
In-Reply-To: <20250218133548.2564549-1-haoxiang_li2024@163.com>
References: <20250218133548.2564549-1-haoxiang_li2024@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0704840615771779722==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=935110

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.20 seconds
SubjectPrefix                 FAIL      0.40 seconds
BuildKernel                   PASS      24.88 seconds
CheckAllWarning               PASS      27.93 seconds
CheckSparse                   PASS      31.65 seconds
BuildKernel32                 PASS      24.58 seconds
TestRunnerSetup               PASS      438.79 seconds
TestRunner_l2cap-tester       PASS      21.28 seconds
TestRunner_iso-tester         FAIL      144.87 seconds
TestRunner_bnep-tester        PASS      4.93 seconds
TestRunner_mgmt-tester        FAIL      130.25 seconds
TestRunner_rfcomm-tester      PASS      8.06 seconds
TestRunner_sco-tester         PASS      9.69 seconds
TestRunner_ioctl-tester       PASS      8.59 seconds
TestRunner_mesh-tester        PASS      6.24 seconds
TestRunner_smp-tester         PASS      7.57 seconds
TestRunner_userchan-tester    PASS      5.32 seconds
IncrementalBuild              PENDING   0.56 seconds

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
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 125, Passed: 109 (87.2%), Failed: 12, Not Run: 4

Failed Test Cases
ISO Defer Connect2 CIG 0x01 - Success                Timed out    2.274 seconds
ISO Connected2 Suspend - Success                     Timed out    2.748 seconds
ISO AC 6(ii) - Success                               Timed out    1.911 seconds
ISO AC 7(ii) - Success                               Timed out    2.514 seconds
ISO AC 8(ii) - Success                               Timed out    2.521 seconds
ISO AC 9(ii) - Success                               Timed out    2.514 seconds
ISO AC 11(ii) - Success                              Timed out    2.517 seconds
ISO AC 1 + 2 - Success                               Timed out    1.973 seconds
ISO AC 1 + 2 CIG 0x01/0x02 - Success                 Timed out    2.003 seconds
ISO Reconnect AC 6(i) - Success                      Timed out    2.014 seconds
ISO Reconnect AC 6(ii) - Success                     Timed out    2.001 seconds
ISO AC 6(ii) CIS 0xEF/auto - Success                 Timed out    2.007 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 482 (98.4%), Failed: 4, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.197 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.187 seconds
LL Privacy - Unpair 1                                Timed out    2.004 seconds
LL Privacy - Unpair 2 (Remove from AL)               Failed       2.557 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0704840615771779722==--
