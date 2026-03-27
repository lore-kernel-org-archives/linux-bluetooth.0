Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11353DBD6A
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Mar 2026 09:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774604094; cv=none; b=KXeGwypKrT17ei7QBezUl3osFRQH4CTZ9DP0rqurCxTAt62OlOlnwZFTs51Z12xlwPRC/2MMcB008FO+Kidlohjr3kwDmLtl0Y8GxrOP2imYWNaiIMg4nPDbkLOUPe4GfogajAyyPsqhJiJSo24tfwmxKhYIwTmNHbPpHOHqcxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774604094; c=relaxed/simple;
	bh=oQQ6oNiW3sA4gG8a7qxlrfFpOTmr8tDPMyEsyqX/Log=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VWwfG0ShiereU64kMQJjsW4Jc0NBjPQpxKV9ZDE0mQWsqp4OwaCsk9WWMDC7XwE6LQfQCraaO2hB9WatgzCv+xxmw/kdW52wW2EWlqO6a3D7ibEKBa8de/mRY6pB9Lu2lHJQL5tQje7reL1K/PW81tS98SNCppLU8nbwMHQrY5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ysi31AjE; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ysi31AjE"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cfc2d1fdbfso163040085a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Mar 2026 02:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774604090; x=1775208890; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xuntwJuvudponBOwR1oTpJaJiAF7OJT7ehUhkMrvcFk=;
        b=Ysi31AjEfob6AjzHSEMIMi0/8f21p9Gki5RrTCYma48Shn8Tc40QZGDJ+0Ecc7irZa
         CVqeCEUIp6UwU4asOYZuz16N4ug84shUG9TfHCGtvD9LYpoAu9I11j2BNeU3Hd+OYWYW
         wWs+A8GAmO8gnajz+LhvrjOrnJd1hXq00TO5RySROb/Kn/Rh3BP6oywROjuEJfl702SQ
         bJUzN+9z65DnVmphhiZSIkHCDghwK4jQlvUDF29izJS0XbDG5DekBhLJXQxBRGlFjLqN
         hyxgAQPXRkJs6LaZ1aNQiGCjBwYpjSPzyfUAc02SKqwNn8tUVnZ19kGv83BghH/5q9jW
         Y4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774604090; x=1775208890;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xuntwJuvudponBOwR1oTpJaJiAF7OJT7ehUhkMrvcFk=;
        b=P2NpwM76dXZeFvzppoW/aMKw7hfCvvcXH7tmFvqpP5t0b/mkUKNw46khFEvy/bhsyK
         j6P0eJ2LsSzHLLvEl94MBNGHvvR65q45PqXmDA7o9KrUgLjg6SxLVwgncgbTiyxy1kB+
         mBw3pTxPuM3Wt6Wu86nFVg+fWudHqVYDNsB/aTwTNq3182t0P9QrecIhSWnOaOdqHRDO
         T8+2+Nk9xmBcfzYrH2CodNbvColzqTmL4ZH7tIgEyzWjW9cM/qyHQo21rdeDGMJDPcnD
         NF9FfexBWT3XZ178mi5ZVIR1s1auBqE01uwpypRWN5UbyU3myhKUuu/fSef8SNtUy5Ap
         zP5A==
X-Gm-Message-State: AOJu0YxE+O1dVUwb3hM9XsMrdtU8WneEyjI6OdNPXVl1tM3QQP4JoT3Y
	3sBiXreMH53508qpoJEuWmTx1fvWqORWZEz/Ng/8idRdBBA4s3Ccg2KocyY1zA==
X-Gm-Gg: ATEYQzz0R7pVrDk+05tMoHYc167idr/JnUkBvQG3hWinT1M6HswGMLGAzc/QiX3Yeon
	ykI+wqbPvvo2IiGi1d4Ug7EjKYJSB8fMCLJM8nRj2H4g6/OeJGY5ipLqFVAvMjx5D5+O4VYHHND
	b6YwHjsac22cIsCgXSmRSMw0Dce8yExzntBAIz9WnNLQXmC5DGfEVM4hu7+zya63yRdUQxOSklR
	/b3zdRkMybzIV6mRP41rImiNf40tRYjmgQf0HBaA1Vq0beOVpxwJYrcjfaOiUaqL4RuZLUG0oXU
	PMvFhCCX6Bpaefx7mGdYp+9N+2l/FeAg32LcZUd/uGT63G+cswRXtwaBf/BcDjSFAQ9pClEe6Iu
	Q5wR9yEjDyGCWwUPdHKvzSfdbKl+8uT0w7W1IoOsErRgIaQ//USGEAtn3I/wEiRFd5TRH1Y0oJX
	VfdJKYG6ljt34D+ycPbMMFXkaEP2/8xw==
X-Received: by 2002:a05:6214:478a:b0:89c:4d3e:fa41 with SMTP id 6a1803df08f44-89ce8d42241mr18799316d6.12.1774604090508;
        Fri, 27 Mar 2026 02:34:50 -0700 (PDT)
Received: from [172.17.0.2] ([20.97.196.165])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89cd5855b15sm49960356d6.3.2026.03.27.02.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 02:34:50 -0700 (PDT)
Message-ID: <69c64f3a.050a0220.23a6b7.5391@mx.google.com>
Date: Fri, 27 Mar 2026 02:34:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2654171059118808353=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com
Subject: RE: [v4] Bluetooth: qca: Fix delayed hw_error handling due to missing wakeup during SSR
In-Reply-To: <20260327083258.1398450-1-shuai.zhang@oss.qualcomm.com>
References: <20260327083258.1398450-1-shuai.zhang@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2654171059118808353==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1073417

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.23 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      26.06 seconds
CheckAllWarning               PASS      28.27 seconds
CheckSparse                   PASS      27.47 seconds
BuildKernel32                 PASS      25.09 seconds
TestRunnerSetup               PASS      568.15 seconds
TestRunner_l2cap-tester       PASS      28.15 seconds
TestRunner_iso-tester         FAIL      31.79 seconds
TestRunner_bnep-tester        PASS      6.39 seconds
TestRunner_mgmt-tester        FAIL      113.48 seconds
TestRunner_rfcomm-tester      PASS      9.45 seconds
TestRunner_sco-tester         FAIL      14.35 seconds
TestRunner_ioctl-tester       PASS      10.19 seconds
TestRunner_mesh-tester        FAIL      12.43 seconds
TestRunner_smp-tester         PASS      8.58 seconds
TestRunner_userchan-tester    PASS      6.87 seconds
IncrementalBuild              PENDING   0.58 seconds

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
Read Exp Feature - Success                           Failed       0.105 seconds
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
Mesh - Send cancel - 1                               Timed out    2.747 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2654171059118808353==--
