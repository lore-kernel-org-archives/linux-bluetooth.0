Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EA8318EC4
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 04:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773895202; cv=none; b=hpziTe+BYsTZM0EEqh8fTvI+nbCW+M2iKP1G6KJF5E4XkUQjEms19uF4HoHqmlEYXDwyF59nLworvzGsYSc1Ww5sjuUg3hu72FNtrAc6WMqiLrUQU5pzqCHX6mXHiyM19MXDQOFvIbXEAgQTfbIEsrVzZ/JPQg1kGvPoO7XysC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773895202; c=relaxed/simple;
	bh=u8QEgxrVLWha8Y5X/Ox89SwZwcEXfC4nfdOPp6WzJp0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QDM1XNMu9zBsJU52Sb1eJH0lhM6QhKkgJgIDUJAnsv+LqRjB8wUFQjYrrA0uaMaqPcWwX8+qC5UqxBKYfBFqhJlhV+UdouGlG4ww8waqxoT72ZBCb0RAht6DDrafT+Nzg0+bOCF3QEe0QWzYImqMh+r/QldcD/J3ufrB7h5nUYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kc1lLDzH; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kc1lLDzH"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2c0ecaae7dfso979582eec.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2026 21:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773895200; x=1774500000; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RefYYMlCS7qCXWC2zZrl+YDC0JzItbXJPIXv7+8cXek=;
        b=Kc1lLDzH9msH0iJr34k25QFEDtkK4BU1g4wiCPS15EfWxuxdCf5dHg8+SuscCNuqs6
         BTz8psKA50oCB8J05L3AgeXZN8eJ72N99aG8H1/FYd8c4AieSEWEnnhCymqQnZuuJd8X
         yTFIbqLvysA5s3NsFcO6eQGrfYR8JJ9rZ+wTUz6aPwL4ffpA303OyY11cNf/AUV7Ua++
         GlFryFEejpHkq+dKf7YCP7HbrTQiIOfbw1j9DU8MssVAByYzT9A7j0K1EwwwDAvcg/E/
         nrmgqQYOWyktT7LWp22Jz8G5joYgOjh2unf0/xmnMaoDpPZwUFDQp9IGSsnqlFGei9kP
         vjbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773895200; x=1774500000;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RefYYMlCS7qCXWC2zZrl+YDC0JzItbXJPIXv7+8cXek=;
        b=aQv3zUBAivE6+/M2Vh2FeuGs+YiPq5setFSDzhSvdwXI1XPzsX395lGwa08Q3mX36R
         FRQxJT7gtyuKKAFMinNeec3ANxUlqCfgHbHcy1ZMFJS2j9KCuc4h4AU76G9HIXM86PO6
         9Ny4vVHkADmutHRrKKybTHAxSl5GuU3zE6IDZudEZ85/qgxdnw1TRjrtAfTjzPzFashb
         W9u4kA5zEwUT9udUNXgoU+1Knvo6FPHjpl7dtxRF8wnkBHhYimeO/peTN9E4UGB0E2/E
         i12QbDggQ880PpVhkZQ6Lj1Jo7jX2Zh3j8kfxeYJw6IbBlE9PrvGCaIzvjq65RMG8rKk
         NC8g==
X-Gm-Message-State: AOJu0Yz3kbDJQlDEmKDrnJcRk+sccuUoviKwhdRgG9CnkDE/ymZKU4py
	EBolRyGgBByMchmm4SLCnfQAM07a4NBLYCudT1Hvn7VQTXBJe9OKN1jO5WYGXQ==
X-Gm-Gg: ATEYQzwH+Ez3Osl7XcIodKusnertjTAfPLlP7rxseWGBfScnvlxfcKf+iLAISWWKEoG
	LIdIk23zJbPiPnoT1X/ynEfH38HIa/EeTs3LRKPs9tFcU8GdcTARAgBwDh6loBNgNmMk3gyxZj9
	KzSvAgJQzuJdRg4cZwkSF5N6PAqU+05PgoIG48ODvfWRlOwk1dtqfSXAlOOAgba7mzHaNZRIWg/
	C9VHHLxCM6aZHxUiU2xl/EmLP/23BMxAqgLsRh7XkWr+TL2hF2+Xub8KjM6LIAi0tIMakPCMn4w
	0fA0yRGUg6YT7SkI+0nWAlveJYY9dhUNvZ0ZYFXtMOi3F5UkPV8KO33wH4FrpKiQrR9LXnmT6DL
	N9U1oUp8XrrckKTiQfaOukBaXEbxtURZEqDUHMEnV/fj0N3Ci6jmgjRMsTKPMHkEYgJiBM3e8pu
	yfccUpOnQ2drYdFjqcyWdleDVwDbWPcLOT6fIY
X-Received: by 2002:a05:7301:1286:b0:2be:2b8d:399b with SMTP id 5a478bee46e88-2c0e4f5d6a6mr3200554eec.5.1773895199710;
        Wed, 18 Mar 2026 21:39:59 -0700 (PDT)
Received: from [172.17.0.2] ([68.220.58.6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0e53e616csm6696791eec.13.2026.03.18.21.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 21:39:59 -0700 (PDT)
Message-ID: <69bb7e1f.050a0220.228f92.3705@mx.google.com>
Date: Wed, 18 Mar 2026 21:39:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1480232049438518868=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com
Subject: RE: [v1] Bluetooth: hci_qca: disable power control for WCN7850 when bt_en is not defined
In-Reply-To: <20260319031040.4096297-1-shuai.zhang@oss.qualcomm.com>
References: <20260319031040.4096297-1-shuai.zhang@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1480232049438518868==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1068977

---Test result---

Test Summary:
CheckPatch                    PENDING   0.47 seconds
GitLint                       PENDING   0.37 seconds
SubjectPrefix                 PASS      0.05 seconds
BuildKernel                   PASS      26.00 seconds
CheckAllWarning               PASS      28.61 seconds
CheckSparse                   PASS      27.87 seconds
BuildKernel32                 PASS      25.66 seconds
TestRunnerSetup               PASS      568.95 seconds
TestRunner_l2cap-tester       PASS      27.73 seconds
TestRunner_iso-tester         FAIL      34.88 seconds
TestRunner_bnep-tester        PASS      6.18 seconds
TestRunner_mgmt-tester        FAIL      114.81 seconds
TestRunner_rfcomm-tester      PASS      9.34 seconds
TestRunner_sco-tester         FAIL      14.22 seconds
TestRunner_ioctl-tester       PASS      10.25 seconds
TestRunner_mesh-tester        FAIL      11.46 seconds
TestRunner_smp-tester         PASS      8.51 seconds
TestRunner_userchan-tester    PASS      6.67 seconds
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
BUG: KASAN: slab-use-after-free in le_read_features_complete+0x7e/0x2b0
Total: 141, Passed: 141 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.108 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.854 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1480232049438518868==--
