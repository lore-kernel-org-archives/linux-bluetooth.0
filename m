Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0155314A6E
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 20:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763411978; cv=none; b=RyEWR9IY/p0jNe5eD38WWxr09cUxF02qWUpue0QiMa/uMEbGcxDw+R+cMk3R++yu3xx/YcuPPT43IOIQ6zFsRXj8hBaEHDT3cysnjG1pNIn9bMjxVF3VS5dwS46Lp29JlQliAEPh9MA02ioT5tS9VBatPFFbXiHhfPRZ+w359xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763411978; c=relaxed/simple;
	bh=NdhF46dwQ7b/sDjkoO+n1ilp61/2t+7h5ha9LjRqHx4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ik7Xf6PVtjzzseP2AvmMoPL5WQJYsYJpwYipGAHjI2ZiGX8P16b3BuiRJqATEZM645dyapr0HlQa2t0xwK9wU4vFz5p6vuBLzpQRKaKkLEdVV5VmwQpPUk+1BIsoFfoq6bcoFfLVOzab4FMTZ8j0kbJLOXAoZcnBf/cYrQJDoas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOaeBFe6; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOaeBFe6"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b99bfb451e5so2935282a12.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 12:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763411976; x=1764016776; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=M3ukrNvOtHAJXPro0Nw2nmQVhw1LrZSvcOHq62uknks=;
        b=lOaeBFe6CKDW+njzRfVEtwHWGdhU8lzU5EzJzTVJxiMi4mNBWBxc/S0lmN3AR6TqmC
         KIC6OaliSqN+dD+uGbZBJCMZEJIcSNq4TskkYRod1DVsRFeTLjgSYNk66iEGUMRdMFOc
         chwYB8ROuCJDm7S3i4BJXI+ibcPGc75iZdmd1xmi26TKHUMNqvzwf0KPsfmWOkAOdEmA
         38BIOlIl95gjWlxfn1Yx8ESjkL0wMlqbmHlpYLU6HPa9k6ID4cyIx8O5lhUflN2lQIZW
         0/Pgmj/xBfSgAmNSXHoqgP28ZGRgVWoGR0weo80NqY2y6dhZmniW7MzPJ8GcZ7t4YxNp
         fHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763411976; x=1764016776;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3ukrNvOtHAJXPro0Nw2nmQVhw1LrZSvcOHq62uknks=;
        b=AU5xWMdEDOG9ju8eSpMLJOaA5azJ7E4vxB4f1WMzs5GUMzZ2vJ5LthPcX5IZ8rs+8A
         hnF0JbG2diVV+A4FB1s7RKef9msAfzCZ2UZO/dKnaFXHXShI55BSJMV/JqzHgFlczDuC
         Sun4SQvZOq8g0/XwVTXZdtUEAy1KA+NgIIAafNGCwtR/pILbZnijVL8h//hclzi9zdMu
         vpaShxToZeADhPMczu9bXqgqb24GiqfuJlEHPAX3FLN6l/Rr2zc0JzNWlw4Zunx5z9NG
         YNteQOW/Yh3hGSZXWsy2VPcLWSYt7J1IRiycjE3kLH7HktXnPQ/v+arQtx8vj63J8BCs
         ++bg==
X-Gm-Message-State: AOJu0YxVy5NS3CnVZL0+w8va2/BwAWFr2iKYLMEcMCGq4AA8Rf3ufBer
	fwcplYCTBS/EKJ1ZEYS3Bzt4lg8jXZY8NB3rfl6AGJsLIPlkxC0pExkp3GENCA==
X-Gm-Gg: ASbGnctquL50RqkRwvo+023oXNXzhjWFvmeH5Va1hQtNxO4IEMQNuXa+KVf51kJcKWT
	bCFCIpuFY0BVg0ZEPinq3kAFZenvZwnacRVQCFu/RqDEt+Qu+0CxC2CnXMoYsbx2g12oMy0lYZU
	2B1ZbXJoUek221u3FlrBFFz7Ld+zWqmugaPs3LV8Dx/U04IF3aN+o1bg3+jxPuOTE/oKMK8ki93
	gk1FgRki/u39gN96zMW9JEJr/XhlqUMSDbg3Cya0g8knsQkZ7QpW4yjnis5Vsf8Ahc+T6ecpPbO
	K/OLl63CNrhcRKLrddQkNBFA5ZX4pIcz0GXC0rnNakn8ltHlKPTJtHjnQn6ZRo1t/JtNK3huF/d
	2fRrjP1CWP+1uqiOrinoL2tGY7Nd7aEfJtXl+XmeQSRj4GbogLI7zrJ1RSC7xnMGq15NmWk4dzq
	DCQxi+5JhlFHVUHcvkJA7br03o7S0=
X-Google-Smtp-Source: AGHT+IFKetBZPl05O7Sp0f8l22AMT2vlo2Eq39NBdwUfJvLreGvlvDQgQIdrBtl/h0O/vbQywY0yHw==
X-Received: by 2002:a05:7301:7314:b0:2a4:5657:3f8b with SMTP id 5a478bee46e88-2a4abb25f47mr5331439eec.22.1763411975597;
        Mon, 17 Nov 2025 12:39:35 -0800 (PST)
Received: from [172.17.0.2] ([52.161.45.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a49d9ead79sm65060440eec.1.2025.11.17.12.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 12:39:35 -0800 (PST)
Message-ID: <691b8807.050a0220.5a6e9.dfe7@mx.google.com>
Date: Mon, 17 Nov 2025 12:39:35 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7085622963731012397=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] fixup! Bluetooth: hci_core: Fix triggering cmd_timer for HCI_OP_NOP
In-Reply-To: <20251117201255.3969812-1-luiz.dentz@gmail.com>
References: <20251117201255.3969812-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7085622963731012397==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1024481

---Test result---

Test Summary:
CheckPatch                    PENDING   0.46 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      25.04 seconds
CheckAllWarning               PASS      27.39 seconds
CheckSparse                   WARNING   30.75 seconds
BuildKernel32                 PASS      24.71 seconds
TestRunnerSetup               PASS      545.49 seconds
TestRunner_l2cap-tester       PASS      23.71 seconds
TestRunner_iso-tester         PASS      76.59 seconds
TestRunner_bnep-tester        PASS      6.03 seconds
TestRunner_mgmt-tester        FAIL      121.04 seconds
TestRunner_rfcomm-tester      PASS      12.68 seconds
TestRunner_sco-tester         PASS      14.21 seconds
TestRunner_ioctl-tester       PASS      9.79 seconds
TestRunner_mesh-tester        FAIL      11.52 seconds
TestRunner_smp-tester         PASS      8.28 seconds
TestRunner_userchan-tester    PASS      6.43 seconds
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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_core.c:85:9: warning: context imbalance in '__hci_dev_get' - different lock contexts for basic blocknet/bluetooth/hci_core.c: note: in included file (through include/linux/notifier.h, include/linux/memory_hotplug.h, include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, include/linux/radix-tree.h, ...):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 488 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.104 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.141 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.069 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7085622963731012397==--
