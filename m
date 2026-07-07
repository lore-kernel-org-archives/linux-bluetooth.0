Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8DA396585
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 06:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783405550; cv=none; b=NykbXmJBs2GKC4NSZBYJeVUh+ZItxKZqqAk7pyEQn/PbWF1cO0IgeLfCJ6SsdmuzHASDd/2KMqs/I66vAX/Z6cFcDmME9LaLq5mIUeUFXfTMgofYh5juYcRF6aWzvO8x2s9cEgwujdb48oEzONIrAWt+dm9GsDS7RCFuuS//iUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783405550; c=relaxed/simple;
	bh=13Mit8Rk/20yKGJkGxlbAjXjI/KtFi6HKtTBbL+AEWg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=S/xEVUVnBY6F9HyELGJELgWsASJd799DigUaJI2WYUWyYVdHp/HSZaYn9cJyivSHuOcMoh8qAwXqPM6IqaGyj9Ds5fm6yhwM06K7rabecGFjzbLbziZFgC7OXLQDw/Tcz+9qLhGWPtH26XVC4k9pab9ncQr/cLzt+eQVGYz4JQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqyumIPy; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqyumIPy"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c85b73ffb52so1962585a12.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jul 2026 23:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783405548; x=1784010348; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HysEdsIFTzjN0QS0SWa22Kub+mU6Iu2LX31PreQiMCE=;
        b=TqyumIPydga5SEYgTDJbgTSi55OCxjvxF/i/HiSGiR594kpT5FpF331txZXnFUl3U4
         UcIYxMydDc5jxhLfkS5o0cnX9NzDTdTMPFlyLrIyFnZQbEY7RIHd14p90VffT3nepnVa
         yuFHFCiN/7myU8stSLRSFf15xNUMN4DtSek0VHbDpkicD1/GnJw74p+UmgpHLnTeBL0+
         fRmcf6iMfqvTuMc1J+i03QwOgwEUpiaj58bJTsUAlE2x02x8sqpjFBFlTMJMUq73cbP4
         zogulqrNC6hWAv7XtpuFwvRifRmEDgvVw/jAA+K3qZu/o1U1fnRDaSFzw5p9wYPLNGU/
         Ox+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783405548; x=1784010348;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HysEdsIFTzjN0QS0SWa22Kub+mU6Iu2LX31PreQiMCE=;
        b=R8ZKXYyE1g+CRMIuoFWXjvBzp97wiPQQZexx7tk7YQi+pcZnZFP2P1zmWPlTNAmbid
         Rw/OhWa/CKV3x07OkYkzVySKBo5p2slpCLXPK8/SuEdh6iTLLh8LuRn4rVYn6t/jp2g2
         mksENDuDrAH1c09LskcCbJmyVe9CE73bYXNU6EhBbcW/w6tObzwOcFpqVAFOvRf5ENIC
         DCXV9w2ELISMZELhDOkehF3Y7EJivMnRVMnIBbigKd8FdFT0djjErVUgBOxgIFlW37qn
         Mhzl85dTJQ7QaXdBlyCQFX5VLj7WszyKKJgy1qBdHaUt5K46cTyjhrb/ThPEI2FrUfop
         QEEw==
X-Gm-Message-State: AOJu0YwrgeKWFfkzZwEnjEUBsPoO9hUyF3Z7v8dSVmtkLCpxnhk3e07i
	vxjHHZvAoxbNriYwaKpf7awD+MehsMzXWZmInjU9iu4ynqjNux9lI+0KqpA/jA==
X-Gm-Gg: AfdE7ckMiYewxohkMM6M2ZmOkee+RRyGc6UY5UB2cdstjhQlM5nk6r7IhmQtEHxVfFg
	C5hBTucFXVKkrpNL+y8nIwpeL6tXsfKL14UikVSIKJH8NQ2ng6v6je9QrUg5KIfy2k8VkP5pJlO
	D2/s2hPCT5XzNcNYVGl4ovWX/+AMzvrM8g/As9kzC3Isd/NoSPigVW2/162Lc6cW9d+cjFu/qSW
	tuHnaMXaNoknN07DimdnI864jhL7mM6CoKFupplFOGwVHT4pt9AAw/qE7ZHN0qiucS2EeGDQ3Rn
	MBB6/BTqwbaGaADtqgqTIyONBUGvDS/MujLej0HLhZUWgedBC/2Yy6ecefT2GGcIu3tRg++r+Jl
	Tia8DzYKWCr7NmFVvKyxTID4enM1PYHPAUvu12ZradHVioYuS0bvLMmgBs/6HBUfv4qmSov5hqJ
	AAQHrao2esQHnmG4JedSw=
X-Received: by 2002:a05:6a21:7e8c:b0:3bf:a941:8932 with SMTP id adf61e73a8af0-3c08ed3e8a4mr4384862637.19.1783405547986;
        Mon, 06 Jul 2026 23:25:47 -0700 (PDT)
Received: from [172.17.0.2] ([52.250.243.96])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f598dsm4727371eec.6.2026.07.06.23.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 23:25:47 -0700 (PDT)
Message-ID: <6a4c9beb.faf16b37.2f0e1d.1eb4@mx.google.com>
Date: Mon, 06 Jul 2026 23:25:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5613445148860618656=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: [v3] Bluetooth: MGMT: revalidate LOAD_CONN_PARAM queued update
In-Reply-To: <20260707041518.2799385-1-zzzccc427@gmail.com>
References: <20260707041518.2799385-1-zzzccc427@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5613445148860618656==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1122775

---Test result---

Test Summary:
CheckPatch                    PASS      0.58 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.20 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      26.97 seconds
CheckAllWarning               PASS      29.68 seconds
CheckSparse                   PASS      28.27 seconds
BuildKernel32                 PASS      26.52 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      504.02 seconds
TestRunner_mgmt-tester        FAIL      210.77 seconds
TestRunner_mesh-tester        FAIL      25.86 seconds
IncrementalBuild              PASS      26.62 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.240 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.398 seconds
Mesh - Send cancel - 2                               Timed out    1.987 seconds


https://github.com/bluez/bluetooth-next/pull/405

---
Regards,
Linux Bluetooth


--===============5613445148860618656==--
