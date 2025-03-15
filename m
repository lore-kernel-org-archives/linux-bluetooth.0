Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5387FA32
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Mar 2025 03:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742009061; cv=none; b=E8dJ6LbdoadVBGlfNfcMo6XiWHT7X8GI+gggCAgWiO++yDz4w4yJprmuNY6fK2dxGgS3MzeG+LqKXN/v+NEY2kP46GSvb7Y6XE+wQJ/Qj+fCxKaxA90zh8TW53OHWAD5UhXhlbdnEi8OgutXmrR5Rpl7QAO4F05/YRNvAtBECnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742009061; c=relaxed/simple;
	bh=vlHHI7lGtQxK0AWvWAWwXXevoiwSClmQvXX2V5lKM3w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=eM+GSMif+nuCzqFzvh5zF4XEYyHlC5/AxlTRg/dBV6urm2bCZgA3aunuiYXsVHh0tTJtgkP3pnGPCmtFt3aBlhi1257esioKRKPlOyMKbeRPiFLIo1+JnUaXAj/kv9N9EXDk4sHJkcViZjirZ4NYESxcQq7Pw/wPwl5dIFsqy3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSe2acVE; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSe2acVE"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22359001f1aso70070865ad.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Mar 2025 20:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742009056; x=1742613856; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MNmFXyNVZcTwjp8UAF07Ru82Z0yUnBzNqybhMfOaLa4=;
        b=KSe2acVEvEZDtXObAKftWC3bvvf8ZBvV7ewtUcrHss+5qHgLnJTk7H0qtNWH4Nnxbl
         2U0gaO/pjs7MNeu3GQxdR8sV4+INSU4mwIWaymoJ/48nfgzagB4knwAN7orlutM080hV
         L+cpsEGZ8wHBk2tGL2RHZmFL8UD+juo+zQcIrbSOqR1y59o0RXZ3b4tnBiZdmUjlP1nk
         AHhNRQelKGrRURfly0Ux6RejiGwGk++iQIXegCmpyLMI9HRjudBbQUQ+Eq/VJR2g8xen
         W7qioTkulKtXxHGijm/j1rN0dCdYefKVXA6SBFw1ir5s8osnn49Yo8sWxQXVyCDtdoT+
         /xfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742009056; x=1742613856;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MNmFXyNVZcTwjp8UAF07Ru82Z0yUnBzNqybhMfOaLa4=;
        b=cfKXgaNnISIiDxmaJaHswpw88LThDqAbRqQImsGfCIxyEgxRDcqIlC2kXWpdJRSj/0
         99o3Sd3VcKI8CLMCLbujYaAsUmi0QPVUN3VcDP4m8I5NHivy/xQxBhsxlDiY/S5OoH9p
         c2knMz05pnwAYA7/AOW7vsArgBFUvvFEYjhJlS55e4UZKIowDQ4wXxzVE2EkUQwi2+ov
         BX7b92k6esZuDu8Mt1wF+mNGZ3pjl1hDBSBReqtzLEELcNv7UuhB8VTrTMykvajafS9S
         JaGBM6AwFv3Hlv2Nl5tMXY2CMdFHFsQGItzWkRDSHcFkXXHOzZmfpUVv2fCC5i7edeWc
         AeuA==
X-Gm-Message-State: AOJu0YwyO2C1RD9ohIyCqwUbXqK7SVKZC2GTgjoQdb1l8m0akyDGRl/2
	+7SPLLnjQaHDCmq40jODk2Ew07hI24qJ6EML+XIO8qLG1O+9IG27lICPOQ==
X-Gm-Gg: ASbGnctQv2odvZGB29LVDekzBKm+fKZDqnY6+Ftmvpj0TriWPr1XpQ1vm6+k2pSTXBi
	9g+iH8CNtIzHqOfaGpEO0y5Fq1gtBfcS3nLBzkidSpBNGnOSIF2cHsJkdaBSEGBt72sF3CbPZMW
	AEZPwWD3pNFhFEEDhtj6JouOGDWwK/Ftrq0S7pyvBgQwxEwdODV6MkW2pRjUul+cnfnciw03pCH
	QPMlyK/l3zlXbjbIu+jNCpeDFLPdwXaIA0SKzSSM5nfNG5/e7vWlFCSY2jIob+VhmVtRxhajp0F
	smiaHGVX9H7epH9vTKX6jjwhtErljz0vKiqeCiIBR2zRnAJ9LWRGwpZ6wiE9Fg==
X-Google-Smtp-Source: AGHT+IEZfYylrzzh0XEloP5PfGOCUN6HqCqM2SMsWjFtwhfT180yppXE9WSvSucA8G48yFEfLo3jcg==
X-Received: by 2002:a17:903:1b6d:b0:223:fd7f:2752 with SMTP id d9443c01a7336-225e0a954abmr60983745ad.29.1742009056227;
        Fri, 14 Mar 2025 20:24:16 -0700 (PDT)
Received: from [172.17.0.2] ([20.43.247.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbe766sm35975255ad.184.2025.03.14.20.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 20:24:15 -0700 (PDT)
Message-ID: <67d4f2df.170a0220.3285b2.555e@mx.google.com>
Date: Fri, 14 Mar 2025 20:24:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0933479923309110928=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hao.qin@mediatek.com
Subject: RE: Bluetooth: btmtk: Remove the resetting step before downloading the fw
In-Reply-To: <20250315022730.11071-1-hao.qin@mediatek.com>
References: <20250315022730.11071-1-hao.qin@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0933479923309110928==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=944217

---Test result---

Test Summary:
CheckPatch                    PENDING   0.39 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 PASS      0.05 seconds
BuildKernel                   PASS      24.47 seconds
CheckAllWarning               PASS      26.74 seconds
CheckSparse                   PASS      30.14 seconds
BuildKernel32                 PASS      24.12 seconds
TestRunnerSetup               PASS      431.97 seconds
TestRunner_l2cap-tester       PASS      23.11 seconds
TestRunner_iso-tester         PASS      37.09 seconds
TestRunner_bnep-tester        PASS      4.75 seconds
TestRunner_mgmt-tester        FAIL      123.66 seconds
TestRunner_rfcomm-tester      PASS      7.94 seconds
TestRunner_sco-tester         PASS      12.27 seconds
TestRunner_ioctl-tester       PASS      8.64 seconds
TestRunner_mesh-tester        FAIL      6.25 seconds
TestRunner_smp-tester         PASS      7.19 seconds
TestRunner_userchan-tester    PASS      5.01 seconds
IncrementalBuild              PENDING   0.86 seconds

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
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.164 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in run_timer_softirq+0x76f/0x7d0
WARNING: CPU: 0 PID: 35 at kernel/workqueue.c:2257 __queue_work+0x687/0xb40
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Failed       0.110 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0933479923309110928==--
