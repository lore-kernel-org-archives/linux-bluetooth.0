Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF3B3AB28C
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2026 20:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773348735; cv=none; b=hPnvboeaRRHxxKMQTzhdZW4wWkr8Rbp3RLILXGMh8xEvKkCf2Ai98EK3E7So72/OK71qw/mhw6qiTP48M4Vh/9K8w580kg53dnnsUBkeIOXWA2ZuKPaMqbS5OI+0fnpD/DCKptB2O8icBwNV82Vje4NHEHJ0GJQHMpwstjLUimw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773348735; c=relaxed/simple;
	bh=oAgGqodVbrrow/w03SK7D6GL3i9rhlgrlM2SCkWG49o=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=M5kUSiZJc9urj4HY7ch1i+YJpJAjK5E2UKC8YG6NOZjVFx0kk0M5mB8Nt/03Y0fcycfjTGsgeX2ZREAT0D8RWxKC/8k3WiqNFIfPHB+jxT0KHtxshuRrmLpjWFuAWJ5uj98uPRecgBO/rVfDLFcekmLYEOAuCkv33+7+B64paNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UjvG2hCQ; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjvG2hCQ"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-126ea4e9694so3980529c88.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2026 13:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773348732; x=1773953532; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vqnZFxBWjQjaXsdxxn1pblgLespQi9Vt0x+gttOM3T8=;
        b=UjvG2hCQmHfycG2q9hsG1PDHMa/3VZlCwQeEfbnxy39PPjOI7jC3OZNM0HCmpL76O3
         Ju5jFvQRRvxoITrGL/3jf631BqO7CVIDSaHzR++7bfPXlXU9Ul8p81z4Z9YbzNQVsfqM
         RwiR1gAFNw0xzd9omIVrEBH55g3+vP0yJm5+3JJFFuHYZTJ3tIJwpSbV0qWXvmUMKphF
         jpAovPD2x7StVBunx/39Mxq2fcGSvz77xDEpZj3ybdcY9QmTKc26LK8CHhW5lcz5KTIC
         E33npo8qJrsLvqFP+lKO785/k3Zb1CjeGGUmLcWJ6Q5EoYbFZfbgBON0QPwNe7BQlAdR
         Xznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773348732; x=1773953532;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqnZFxBWjQjaXsdxxn1pblgLespQi9Vt0x+gttOM3T8=;
        b=ET9fZA5wg2GdzF6O+9i+HEpzI91Uv2ttVe2DetREn4+mcjkzctAygE9uUZy9o3g4Kg
         n9A7wCDaqop1Kdez9k6mAt6embewg56ICxcHGrSH0lPjtHGx7eL9GG9VjpekIgqdiOWH
         WrTFDxRwywMmrK6JjIWH1sH1uo73YPtJBcT2azhI1qgik7pOHi1jpOaHpUzgklRp1Dbn
         j37XbrVhY57WrS+EyVbxJa5vsb7y33hoUnL4yTP7euzK0VaEssUpnBzkEMY6M9m7SXJz
         PRajaE7/eE7sSGQ9UakTOgHnm8Fh1wdy2QA5QJ6keDITMRO3LUiOVXr4eoR5kfwgsUDT
         euKQ==
X-Gm-Message-State: AOJu0YxFbGwZ+8IQukBZmIpWA4hMqJZqwPtfg49/SfHMmJZLfD4JXwYl
	OYIyUbA3EL0YNUd8Ts8AN3SeOBCEhDKNUzaatDR+Vbm54GOEypUiVGaz9eQ+EA==
X-Gm-Gg: ATEYQzw9r6tsifWOkpzIUest0KkJUrZAlo/mESMQljlJQGx/H4AaSBblyqAdfVggKQy
	7H4gtpNrO4IbRJlmGoatB9d5jguLMom3UVK/nueqHh2nokgs6zgz5wRMJQ72vL+fW9NrIMLIF8x
	FT4Y40T+hPEGzygZ/GN6yl/X7bY81ZxCUP06RtBJTfgbcfssd/FxqnROcgdMqOgHJHse80nyEz6
	2a5fYNvm44PIKC8OG29pIh2EmqMQd27s4b5HPBnV81/1qnQ606MnfLu8UIu1d/vfRaTeqkgP/Lc
	rL5xxZ5KN0juBJ+STkam+vL5PgEOpFgbZJFD8P3J3Nvcsv48LURstiNL8khkMXOlNpJ5Kx91OuO
	lcIWm6FCj/cJVpEQY7PlH+1lrPZVjgcCSb7fD0FWxUqAy1BKaMnyNMHX2qf85JNk7RDq4u9ECfG
	RVcInE1VMOd7ZVbXzQO7xehY9l+44=
X-Received: by 2002:a05:7022:684:b0:124:9acd:3ef9 with SMTP id a92af1059eb24-128f3d1f295mr452256c88.8.1773348732238;
        Thu, 12 Mar 2026 13:52:12 -0700 (PDT)
Received: from [172.17.0.2] ([52.161.50.35])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128e7bf1e1asm8468863c88.3.2026.03.12.13.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 13:52:11 -0700 (PDT)
Message-ID: <69b3277b.050a0220.1b0aa9.9727@mx.google.com>
Date: Thu, 12 Mar 2026 13:52:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7663763984117967342=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, imv4bel@gmail.com
Subject: RE: Bluetooth: SCO: Fix use-after-free in sco_recv_frame() due to missing sock_hold
In-Reply-To: <abMhaMILH0Db12LU@v4bel>
References: <abMhaMILH0Db12LU@v4bel>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7663763984117967342==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1065910

---Test result---

Test Summary:
CheckPatch                    PENDING   0.45 seconds
GitLint                       PENDING   0.41 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      26.58 seconds
CheckAllWarning               PASS      29.11 seconds
CheckSparse                   WARNING   32.70 seconds
BuildKernel32                 PASS      25.66 seconds
TestRunnerSetup               PASS      577.00 seconds
TestRunner_l2cap-tester       PASS      28.96 seconds
TestRunner_iso-tester         PASS      66.37 seconds
TestRunner_bnep-tester        PASS      6.33 seconds
TestRunner_mgmt-tester        FAIL      127.44 seconds
TestRunner_rfcomm-tester      PASS      9.75 seconds
TestRunner_sco-tester         FAIL      15.23 seconds
TestRunner_ioctl-tester       PASS      10.57 seconds
TestRunner_mesh-tester        FAIL      12.47 seconds
TestRunner_smp-tester         PASS      9.00 seconds
TestRunner_userchan-tester    PASS      6.95 seconds
IncrementalBuild              PENDING   0.68 seconds

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
net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:153:35: warning: array of flexible structuresnet/bluetooth/sco.c:1607:1: error: bad constant expressionnet/bluetooth/sco.c:1608:1: error: bad constant expression
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.111 seconds
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
Mesh - Send cancel - 1                               Timed out    2.590 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7663763984117967342==--
