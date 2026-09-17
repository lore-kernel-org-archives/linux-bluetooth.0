Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D934B4A3D48
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 23:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789688343; cv=none; b=P3cq/A4Z9D+RMZRFbRIT8tTlpi/b7GB7aK/1ifQS+Bzkb3oLYKNfniEnP1yk2MkARA1BEgXRzG31OcozwUJFbpBGbTd0QuRTFaTRF2DOr0QaLZsYCI5UicdenqF9wg8JNNVTTcfrolsw5V/QNJXxHWeGw/vpcuEaN1aiCZ6Wmto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789688343; c=relaxed/simple;
	bh=kgo+E/95qG/kGEYEAgByTRhHx1qrEF2kIUhUynoyqWI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dKYERHP5clpqBDa6fwYgUWyBvg71aEoQadBGVD5KfubOzeCvetUZdaG2Z921VzQhn/uCciKs9dZgYRAgeL/cf9kbFR/MVkagVILMvafiIfDxFIew2lNY3fdetbggwYZrgk03w+TLiUQfCv0dRvI4zF5zUWCrMOQ/HWYZzzyUSco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+UyKvCP; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+UyKvCP"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-398cb5615deso195740a91.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 16:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789688341; x=1790293141; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2fIbgNEcDGGfIsfog9cf9Z4nITGK5BUc5QYosIqJ+nQ=;
        b=T+UyKvCPEHRUyYj3eCeLo2Xx1FITfREH6s5eObirY4d/ap1GAJZI8j65o3A9cgURfU
         2RrmrpB1BDGIclUlYeBxvdU2Itul1OIRssFfQca3/wkvRdw4X4VnbPLa6YQwPWKarbtc
         7LfX2ZSeDO8MASFmhQbgwv4jTBxfkpOuKEZm22peVUP7q+CF4IZJYS9GczndT6K/R8ga
         /KTvcseS1F4hcsC0l15J3AlAufsCUDIDqnE5GFX5IfU46ijxwpDEiEJ4ChzOGBccvq4C
         3nTEe1iQee/f+1+OZxqlrYtteE/LRHvoXRXzDGPvGZtqd8y9+Gh3smxgYFouq9zE0YIt
         WrpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789688341; x=1790293141;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2fIbgNEcDGGfIsfog9cf9Z4nITGK5BUc5QYosIqJ+nQ=;
        b=t+e/nt5Tqezok/Mu37Nyoamnxs+boHwidUS6ajpO4dd7CVQ6sf3AUrvfIgIcNG1rpp
         1pl8dvVf2jZJYzblBKSwy/LnnveMbSJUzEweN0/yHrNE7+0gVRdONERiV94DhQEGgQJ/
         2fCo9r5Ugup7d+qOxwuoss5Z71eOWrm35EX1ENyQvVYpwZ3dplaMxcOSktUUogIKWAnE
         PyHzbw9ngCk42L+1X63vinNNgESZ9sRYrZMn7XPFxz+gxj+eJT0+6/sMCp+Ywnw7xLCn
         pNgOXH4uoFmoStVqOUddb0DojizDuZIDNnxXDgJJUG2qVSmvwmx2W5ygJVaYaXhwfR2m
         Av8A==
X-Gm-Message-State: AFuF++k01rpT2kw9SYAJ0LtGHBU+W5p6G27H/7KgPD2t2iTnxLP8hJsH
	+tjfp5rnSidEyhGo+Wdawtvzp6lgTpHhSTjneIvD3hA6JLf1fBj4i/CJZnSPnv4o
X-Gm-Gg: AYBFou0sH8Yo6m/w2BIztE8D/EKmNFpd7OWTptDG5er1XT+LcnE46biPHFM8xzJtowT
	K7QV23V01o7MZZ/+ejsZAciEm+E3oDk3uGHhELagiBli/bEbYK0PbJqKynPEFA+MQ2w307S6/z5
	jsiwkuEhmQP4OuZUPKdXKiEw6qSawVawjEn9+NRMp0clQh+d69GAmJQWP/AUAIuCLfpnTnJNCje
	n8UsiiAUjLPQSOVIepNgp230llkBLB7Zf9fLsjuT3NzDWnxeDtlw5oXYZsznbOR81mbUdUVI3U8
	hXlahyeVZn8TEXjVeNz458iaOavdRU/plrDc3ZzJkXdO7LfUQAwQVUZNnm66jtw+2g0D1hmozb9
	kUdJ/JDAoQ+W0MwZMOyUjFzyTHc2IWVZkZitdkw5V/PfaJfwQqJvB7y93o1qlvEiM1NyXxVLaXH
	jx505q47n4t/S2bZFv4XJXxMy6yUxOtYrPEV7dTdCCjp3K6M5+ZeRdrzMgoCmCRl6xlDMmSzVtq
	c3VpA==
X-Received: by 2002:a17:90a:e7cd:b0:395:7fff:a08f with SMTP id 98e67ed59e1d1-39e549bd704mr1549181a91.0.1789688341026;
        Thu, 17 Sep 2026 16:39:01 -0700 (PDT)
Received: from [172.17.0.2] ([68.220.59.227])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144ce046d96sm58218c88.11.2026.09.17.16.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 16:39:00 -0700 (PDT)
Message-ID: <6aac7a14.46c6f052.1fc5d5.d274@mx.google.com>
Date: Thu, 17 Sep 2026 16:39:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6304698541733598778=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sean@starlabs.systems
Subject: RE: Bluetooth: restore powered-off Intel adapters
In-Reply-To: <332acbc859506a0c313a21c14d177a5cde07fb74.1789679981.git.sean@starlabs.systems>
References: <332acbc859506a0c313a21c14d177a5cde07fb74.1789679981.git.sean@starlabs.systems>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6304698541733598778==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1168087/

---Test result---

Test Summary:
CheckPatch                    PASS      1.57 seconds
VerifyFixes                   PASS      0.06 seconds
VerifySignedoff               PASS      0.06 seconds
GitLint                       PASS      0.41 seconds
SubjectPrefix                 FAIL      0.11 seconds
BuildKernel                   PASS      29.99 seconds
CheckAllWarning               PASS      34.08 seconds
CheckSparse                   PASS      36.76 seconds
BuildKernel32                 PASS      29.98 seconds
CheckKernelLLVM               PASS      36.07 seconds
TestRunnerSetup               PASS      825.96 seconds
TestRunner_l2cap-tester       PASS      16.70 seconds
TestRunner_iso-tester         PASS      28.99 seconds
TestRunner_bnep-tester        PASS      9.09 seconds
TestRunner_mgmt-tester        FAIL      61.44 seconds
TestRunner_rfcomm-tester      PASS      4.44 seconds
TestRunner_sco-tester         PASS      7.58 seconds
TestRunner_ioctl-tester       PASS      4.58 seconds
TestRunner_mesh-tester        FAIL      7.77 seconds
TestRunner_smp-tester         PASS      4.29 seconds
TestRunner_userchan-tester    PASS      3.13 seconds
TestRunner_6lowpan-tester     PASS      4.36 seconds
IncrementalBuild              PASS      30.50 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.022 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.391 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds


https://github.com/bluez/bluetooth-next/pull/785

---
Regards,
Linux Bluetooth


--===============6304698541733598778==--
