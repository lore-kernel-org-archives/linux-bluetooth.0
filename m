Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AE4653
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Nov 2024 07:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732606347; cv=none; b=HiZUTM0NV0LHrRlZpZYode5zGDSE13/ZeVCkE6mfXwDwfxagWy6/SlYx1D4Qg9JvXdkfG1LThpWNJqxBRMBEm4uGXWXQIc74yadp/p8aRnLnmJ75jW87hoSeGxbMFuNK6h8bx6Hf6OGFIMYxC3/d4/ItvSXqNXbtLhpVpfpu/zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732606347; c=relaxed/simple;
	bh=4BDQ5OBeposaJDUE6PmV0qS7Bso79AN6w8Smz1GUHiE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CeZCUAZu6zclPJKVKajR8ShH9qbEjs0Lpvgx9z0wbx9R9dTpIRPdC4u/uSBB4QS3+iOEqCZW/773w0UFDkYyYvpQVAjCINclQbF+wKGN1ZcFclFdS/hzr7UYA9dd1+6trcbEVu1CnRqr0yqeic+u69aujLzO2jSP1zlhZcnHpbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=maa0wvWm; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maa0wvWm"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-724f81aff1bso1764293b3a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Nov 2024 23:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732606344; x=1733211144; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UP7YY5fTxXHRjSOQPzQGjhH32PZoMKXQRrDAdPZfGPk=;
        b=maa0wvWmTbX1MMve4CXsgH0hoe6BqojvE81LbaEYz7KzVrj4lflD3VSsHEhxLV04Y9
         nEel+9RIVxihHxbCNMDL9nCMCD8koh/S9tqspv5EgLlcVbbNaG+3c9frjLqYY0m61y1R
         1GKwdKS+R6FffOQcvPKwJ5s6eXFa1nPtBY79hu0wznqfisku/yj5v4MM99u0BDqvaB4F
         JW4sKR+wwTrjuQ/Q4RBMzhlD8MMZwKrSlBH4eePUxIPO2Z78ijdGME5vWlSNexuW7cTX
         pEjaAWcCiTj6YfjDsr8uGITyb4nNuqOPCX6HMYbLJb0g/Oceuq3zGPnRm2toGrEoj0ip
         zp4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732606344; x=1733211144;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UP7YY5fTxXHRjSOQPzQGjhH32PZoMKXQRrDAdPZfGPk=;
        b=G4lWQYgaoe5aNCZKHBGzFiQhwGDlCB7qtirgr366a00Q2/mVwYsaeHSOQjacGPcf7z
         IiSs9JRu3IUNu0i3j1kAbpMosgWPJbHgXDXVZeTxbsyKIohr29hPPWIpJQHt4q9RdypY
         h9Pvq0r9rrH86bLXB5ckU3UK/BhwSBKS4mVzIaX/+4PZA+Tl+XUwY0JLxPBAHT2fZHaC
         eJ3A/T0QgKZuk8RbP5uvmrNm9p+fooJviViAhYiaWomEf/z8AeyOqYkNZVN7434BdlhW
         3P2pwCBVisDrheTPTMxDWWz6tCFVCR64wIKoLGl7aCWzIXQhDBEf+Q5bCgd/8PYnxpQy
         GuzA==
X-Gm-Message-State: AOJu0YyT9k4rwCtr9CllTVbQUhXqjKSnA+HoNSc46x7XzezibqHkaGBR
	KRSokflDO869OXVIk7Wnh8iebrwxM/DGYe9Gc0zW2k+TJHiFwSZ1j87Akg==
X-Gm-Gg: ASbGnctQ1plGJfuO8X109YFh8qOeIlNIik/Hx2fubwsEPoJ2oWLjsmDGRNfTSb/zOL2
	b0UqZqmjqEqh5b/K6ZQD8QR6LxxopwDYhPa+bBd0bRsG72TmewlbGVBozB6HwF9Z1p2gw6HSrCZ
	z0nbSTDDImt4I+ccBRO+A4GL3SPCsVmptoweubFM0Ga0zZjEwACuyADy691361y82SfSgA57i7H
	zX1cG9h3y7wOoCbKkil70BvSuM17FtQUKnZBb2RtQbfgkmqOrIkcik=
X-Google-Smtp-Source: AGHT+IHMkeUGXOVrW9hj+GXeOiJzCZHd6h6OJj21BnOHnDUiURKF8PxjBSL55ue11cKEztLwvlY3NQ==
X-Received: by 2002:a05:6a00:21cd:b0:724:e7d9:575 with SMTP id d2e1a72fcca58-7251ce4af41mr3772347b3a.13.1732606344507;
        Mon, 25 Nov 2024 23:32:24 -0800 (PST)
Received: from [172.17.0.2] ([52.225.76.16])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724f408e917sm5569346b3a.1.2024.11.25.23.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 23:32:23 -0800 (PST)
Message-ID: <67457987.050a0220.274fd.40bf@mx.google.com>
Date: Mon, 25 Nov 2024 23:32:23 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6933964642730741646=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hildawu@realtek.com
Subject: RE: [v3] Bluetooth: add quirk using packet size 60
In-Reply-To: <20241126070542.3828431-1-hildawu@realtek.com>
References: <20241126070542.3828431-1-hildawu@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6933964642730741646==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=912422

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.05 seconds
BuildKernel                   PASS      24.43 seconds
CheckAllWarning               PASS      27.33 seconds
CheckSparse                   PASS      30.13 seconds
BuildKernel32                 PASS      24.54 seconds
TestRunnerSetup               PASS      434.24 seconds
TestRunner_l2cap-tester       PASS      20.32 seconds
TestRunner_iso-tester         FAIL      30.07 seconds
TestRunner_bnep-tester        PASS      4.75 seconds
TestRunner_mgmt-tester        FAIL      119.70 seconds
TestRunner_rfcomm-tester      PASS      7.48 seconds
TestRunner_sco-tester         PASS      11.33 seconds
TestRunner_ioctl-tester       PASS      8.05 seconds
TestRunner_mesh-tester        FAIL      6.17 seconds
TestRunner_smp-tester         PASS      7.00 seconds
TestRunner_userchan-tester    PASS      4.96 seconds
IncrementalBuild              PENDING   0.63 seconds

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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
Total: 124, Passed: 120 (96.8%), Failed: 0, Not Run: 4
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 487 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.190 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in run_timer_softirq+0x76c/0x7d0
WARNING: CPU: 0 PID: 33 at kernel/workqueue.c:2257 __queue_work+0x687/0xb40
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Failed       0.118 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6933964642730741646==--
