Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com [209.85.160.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76FCA932
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Feb 2026 19:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770837702; cv=none; b=bD3Muy2hJGmlR91CusoZHMnIhm4a3Bfm2DV0HhzN9vK2P7lLgXj92bnrZkaajDYDjYUAB5cdNwdFNkdyTJCzSunmbMzLyz8giPKu7kgGBYjaojU/+6tmMqNrAjGHDqBP9PRoowRA5E1dpo7KbStm765U7TBgwOJycC1zirveeO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770837702; c=relaxed/simple;
	bh=epGwRPe4PSHV+EhSTGEbroM9T3fDQ99XCMsPnAIKNQA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=H/nRQ1ZX0K1gIk4UuL6YJOvaMGWQJP0y504Fv6tX2b/I8iqRh6FyXLW+dgcIOFAQkonVVxATDoPt4JKciGHFEj3YrCqhp2NsDAjgXN3B5lRMZUAXv3Pv+XCdM7p+9HlAlPxAHxc6AV9jr7Tdmgg+c3I5W+vOkFNFyOCUaZTUNAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezge7yPk; arc=none smtp.client-ip=209.85.160.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezge7yPk"
Received: by mail-qt1-f194.google.com with SMTP id d75a77b69052e-503bf474fdfso64697661cf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Feb 2026 11:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770837700; x=1771442500; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z5HRq/4Lb+yIcirpczatTeixWYd3ibaM7pcQFlo6hYg=;
        b=ezge7yPkQboPsXNWu7QwLHaPXQ8UCcVlmHHVwat74xmEVxVou3cesKa0JHQunh/OWG
         hvP5t2H+UnIIkOVDK4v3aP16P8bAYI/Ed+iiqEN8Z4C0mVUmUmhbnCMwbtg3LGoLGtpI
         V7RB0SMDVxvKeUuremcUHFUR3vZ7/unNzI7BDNhyMjQSr+sxY+TIeQE+m8IoKzxmqhYr
         Cb+shFqjYQuVbzi5eHGqkLPoQQGuHUtfQQxX3j86SrEgv97hIb0SeIhSEdDBSWhBS3qX
         Z7jznh5jV40K2Q3hG5elQZFdUJpkjpfbmsHnQirRxdZ2XwrA1TFaQ+qYAk7mtrEHwvvx
         nCFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770837700; x=1771442500;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5HRq/4Lb+yIcirpczatTeixWYd3ibaM7pcQFlo6hYg=;
        b=btJRtATEdMZwXZf1wdiuOPAIyMAerBqh/BNZk/o9wsOGuFcmgCqpUoEchkxWy/nCnP
         fbaD/9ePAzyQjNGETIviRWRWdleiRoMmdg7eO2YjVynbIc1zQQiSDFiYGr7HWppapNfj
         N3b8vb6ws3xJFHkz06vqj2xY+pBJ1JKmjx0BX8+KJSDnPGOkDgzIlYi41W4SPlkMWsL5
         w1VpmEt6veGQ3ukQDL5yQIeEK7ou/OsT7vn7+I7S0OZBq76M6Tpj+EQpOQ8ok8oSTCBt
         sUpo3af28hqBbxrOTcJJdbX1by8Of1iqH0Zi4/Ox2kdNW3EyWMaAGcxqwzHWvSFw5Iub
         dZNw==
X-Gm-Message-State: AOJu0YyxwAX2CDNzeIvEYrIK4DagAYsBKDPqs7HUeAAwl0Tqv9RsbzYJ
	W0CX5diZcnH1flkezTNZxofP1Gln61VkfrF1hwEgfQrpHRq9m16/RUQERG+TN3rj
X-Gm-Gg: AZuq6aIc/VscDbYybST5DP+o0W7f27Xwx21NVt4kHqUG1FHjg882BK/gjNIdgEsgWJH
	L7YWViZCPTcxj8Ttgq/sGCtQqOWOa86a+/EMBKrAS8D+l79od6NhN8M6iXXjIywhsmdXCb/WPaS
	lLQOTPfpLOvSd62BMYgRdJIq/st3HdllgvoxI7jS43Oiew2CX85kiwRVZrNQzKhx1CPqGRQQf05
	dP+jaIIvUgmfmfmymBgY0Vf2aO/RX9K1cIZ3TdUXJVaD16+dMHO2NWfdjVquSG9LBe/3jC/bG6V
	B4q7EWQ+ZDAfCt6rRl4I34hf0+rPRTE+932sMp5BjvIsz0UMMUs3a2a9cFQ81cMFGr4AgqOXxhM
	H8ZBPcjLuSrgEx1KdeJPewrzDV6e02i51jFEJCSU5WeIBtlqnwtz1wW+4PUGt4EFukqSdraABZv
	lBo2bRhZb58Aj+/cLKH0GGLTBmg8p7
X-Received: by 2002:a05:622a:1ba6:b0:4ee:1e95:af68 with SMTP id d75a77b69052e-50691e2e1c6mr7658871cf.36.1770837700357;
        Wed, 11 Feb 2026 11:21:40 -0800 (PST)
Received: from [172.17.0.2] ([64.236.201.17])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cc8247bsm20717416d6.6.2026.02.11.11.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 11:21:39 -0800 (PST)
Message-ID: <698cd6c3.050a0220.d7389.ebe8@mx.google.com>
Date: Wed, 11 Feb 2026 11:21:39 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2612373109411709329=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, halves@igalia.com
Subject: RE: Bluetooth: purge error queues in socket destructors
In-Reply-To: <20260211-bt-purge-error-queue-v1-1-42159dd7bb28@igalia.com>
References: <20260211-bt-purge-error-queue-v1-1-42159dd7bb28@igalia.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2612373109411709329==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1053212

---Test result---

Test Summary:
CheckPatch                    PENDING   0.48 seconds
GitLint                       PENDING   0.28 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      27.78 seconds
CheckAllWarning               PASS      29.51 seconds
CheckSparse                   WARNING   33.09 seconds
BuildKernel32                 PASS      26.17 seconds
TestRunnerSetup               PASS      571.40 seconds
TestRunner_l2cap-tester       PASS      28.65 seconds
TestRunner_iso-tester         PASS      76.16 seconds
TestRunner_bnep-tester        PASS      6.40 seconds
TestRunner_mgmt-tester        FAIL      127.55 seconds
TestRunner_rfcomm-tester      PASS      9.61 seconds
TestRunner_sco-tester         FAIL      14.96 seconds
TestRunner_ioctl-tester       PASS      10.49 seconds
TestRunner_mesh-tester        FAIL      12.53 seconds
TestRunner_smp-tester         PASS      8.96 seconds
TestRunner_userchan-tester    PASS      6.99 seconds
IncrementalBuild              PENDING   0.87 seconds

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
net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:153:35: warning: array of flexible structuresnet/bluetooth/sco.c:1603:1: error: bad constant expressionnet/bluetooth/sco.c:1604:1: error: bad constant expression
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.118 seconds
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
Mesh - Send cancel - 1                               Timed out    2.473 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2612373109411709329==--
