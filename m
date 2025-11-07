Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC481991D2
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Nov 2025 04:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762488134; cv=none; b=HGtnE/il+8Dr55WZqMS7qX7aLWXHLtDeYgciKbn89/SwkHhPAXPrnr/v4ZaxshYhQttzt7KtKHwM2G+ETZQ3gtunmzULWa1VzDweK+KhEkcZwnVVs/mNKUg65jLEM1adjDU8I0dUF53ROWxQqDK0oZelBcIBz20Rf/W8abA4H40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762488134; c=relaxed/simple;
	bh=USsRXUEEIanvvBEO7MoTfkIpzCzWfZwKEe7iGdX/TfQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LfW/jJnlaqJP31s6KiOdQRFIAKdWaXdESwRZ77dTq52Ls2Io2t7NN70ie26MgJfQsNMIuw5g1XPiQl4fkPnqvLL98blvSIHRYSPzWvK+Wop+Y0tC4Q4uVGYYreaacNotUdsqZdt8uHtmcypaio33wMvXx0YZvBtgodIGzU57Nhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9Bc/1zD; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9Bc/1zD"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-339d7c4039aso323693a91.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Nov 2025 20:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762488132; x=1763092932; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nLuSfaljxOq43LE3I+ypj4CsTjB8e3arjLxZYAHPATM=;
        b=U9Bc/1zDZ/tAgiAIQ/Stq3DzdWfvLv05COkSVEXfQO4ueqsjs171Zr3DToGZ3JpwJX
         7ZVSAdL21VSE1QJtMS5B5aiUoXKlT5aj0bm0/J9y2SQGFIj1uBcsFEmgBotXlSm5YDEM
         irfrFI1QXC9shW0dZvO9MkEWPSjoTx5rCB+bTW4doCfSuHUe4yNbbKRP7v+xt6hByVfm
         FCAJ9Jts4dO1+t1pX8iPEZvNLg6nNIreZYAcKd0utY/wHQ6eFdcPEXNB8wo9aEeke8O7
         m4U9e+rB0BKUjp+GWL2Da5IETMKfbP9Ymjy4UkLj8Mx8W4kWNmU4Rtj22uXfE5lFY3dx
         fJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762488132; x=1763092932;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLuSfaljxOq43LE3I+ypj4CsTjB8e3arjLxZYAHPATM=;
        b=SblC0hkXVH6ru23MNJ8cgc+Am5bsTIBYhGBE6qVL3znPXQSZltOBG3GqkFC2oYpZnc
         KvCIQlshJ1Fn0Te/zx7Q+I8MwJQIaVcdFIuTneMxVNpnxnNcs4F/MI1Sj9vwr8RuYBBU
         NPjG78YPMLbdUYJFP4tsDbHnxgjHIXHo4SHc2uRmpl/p4WpYm4OS/1wf2SfBE0JHJkxz
         Hk/K19KbuwpvJYeRyzvAlFeJQftd/Au+vpL4r/6obpQI5fhYRTsXB5oAxj35kQ/JaapQ
         VxLkLLqBgd0cZpjkb3gDzbNEkdPUGVM/KqGggasTkrb5ZrAND5W4nddZ+3xQQgU82a/b
         PZ7A==
X-Gm-Message-State: AOJu0YxAlP9rSLiJZA50Ys9prcSH24vRalt8F5VlhKP8MBAAMz8oPISW
	YYN3tU5x9wsO1RYUI6kDD5NxNOxmo+seoXnqT6Rm1h5Ol0qEKkbtQ1knil5h8A==
X-Gm-Gg: ASbGncuqYJYKFRWBM7gYr4xoDH825wEAFNMYkIyRpIzg8tJXktxQBj/TbI1x1gyzMvy
	kkbV4YlCiEjfnUw2ySoXovofmzxEmBnpkQJnp+YyLGZcaeRKj6M9PxOkFb5uT/pCSLOc8iVUjUX
	DbAg/GH8txMA6kHSgzZ2HpJwslzCH5+tPIi3UR1trk6rAb86YR2FUGZQARI3l84Atq7lwn3ypC7
	9d98YdI/SA8jaxTsGL+kL6AOxxUUnT0xrPHtN3dkoxGlx/Ig9rjBpUEU8sfjrZGMxSbLWU1X3qF
	8KGQSeY1RKufN2iu0MrurvYafXmr1iU3R6PRgT+0Ga5sB/dGSLJu3esLQPiMLiBDsst95ZMrWSR
	BEajFRLBwMOGD5CcFs3xzoDR4xlxNX0LLJSeouBsTj/+BPEzirS+OlS9UGcYrtremVmTXctdpef
	CIhMZ7Ig==
X-Google-Smtp-Source: AGHT+IEYdJg7BZmVOVVl2cmh03fCBqdande/tFIl9EesJUM2Eyxv7Jor2jmVkbrWQdZWMW85DxIraw==
X-Received: by 2002:a17:903:2411:b0:296:2b7a:90cd with SMTP id d9443c01a7336-297c043ba3dmr22975265ad.32.1762488131517;
        Thu, 06 Nov 2025 20:02:11 -0800 (PST)
Received: from [172.17.0.2] ([128.24.163.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5e3c5sm44943415ad.43.2025.11.06.20.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 20:02:11 -0800 (PST)
Message-ID: <690d6f43.170a0220.2a797e.42fe@mx.google.com>
Date: Thu, 06 Nov 2025 20:02:11 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4100289990857043915=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_shuaz@quicinc.com
Subject: RE: Fix SSR unable to wake up bug
In-Reply-To: <20251107033924.3707495-2-quic_shuaz@quicinc.com>
References: <20251107033924.3707495-2-quic_shuaz@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4100289990857043915==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1020728

---Test result---

Test Summary:
CheckPatch                    PENDING   0.43 seconds
GitLint                       PENDING   0.35 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      23.16 seconds
CheckAllWarning               PASS      25.66 seconds
CheckSparse                   PASS      28.63 seconds
BuildKernel32                 PASS      23.13 seconds
TestRunnerSetup               PASS      467.12 seconds
TestRunner_l2cap-tester       PASS      23.50 seconds
TestRunner_iso-tester         PASS      73.83 seconds
TestRunner_bnep-tester        PASS      6.05 seconds
TestRunner_mgmt-tester        FAIL      109.65 seconds
TestRunner_rfcomm-tester      PASS      9.18 seconds
TestRunner_sco-tester         PASS      14.11 seconds
TestRunner_ioctl-tester       PASS      9.78 seconds
TestRunner_mesh-tester        FAIL      11.58 seconds
TestRunner_smp-tester         PASS      8.34 seconds
TestRunner_userchan-tester    PASS      6.47 seconds
IncrementalBuild              PENDING   0.95 seconds

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
Total: 492, Passed: 487 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.098 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.058 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4100289990857043915==--
