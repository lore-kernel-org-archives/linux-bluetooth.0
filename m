Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22113793CD
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 08:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775120149; cv=none; b=RlCpDJKwqcJXOsrdjMtufc8l4r6fyobTRQ5sk9pr8gmXYWP5ajazxUtekVFLzLynsf0u1JKYo2MHf0Xi7xhF748r+HynZmUVtz/zbbhInxZO/KjEqfv4WWNnz+nsMAwnMgrJ6X6pL3I/SATk2q6fuO/usmKwGcAOYQPRxzOTSrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775120149; c=relaxed/simple;
	bh=inMEn10x3uHScoz6+nnfr5lSBA6pQfWr9Rjjq6MQ0cc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QJeaxyC5MajNL4zJxih0pzdTAu7MjRdGhlsn7hRw1MbZO7XZAv6Nw8a79Y0gGHgNmxcJKGHJ2sGnMdfSIB5GWUF50tKUXgeauTkcbNXoXXnsP30H1g9LZ80S6gI8EI0D9HMopeAhZ+oC7RtxMPdlwtznyYtAX27fEB0h0xwd0wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxL2iufj; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxL2iufj"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50b351eaf81so5837971cf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Apr 2026 01:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775120147; x=1775724947; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Wq05JcQratHDvb0XfAUwWxpLJe4ES5FevW9OIndBRc8=;
        b=kxL2iufj4e8wKNH+Lq27vhMejpjZRiAayh/urlrX5k6ThPNEAS1FG3jCbmNfydl+JL
         Q14t60+IXSjorhVksXm5dhEbpdS1N61Dsk2xKvh6KN2bqGZvL1xSVQA1Von0tuF1+GTT
         7vyNrEEwisdS14oar2/OX54aJBxBBMXOgQTI6OwH147B18sbik18r9RhaJaweo/GCWWC
         3UOEr8evDJW7Y1tDEj+oJ5JcTb8h2oA3oyEHBIGwCQpR8GN6wu7hC4F/u8KGHPzgc0+e
         NUNjMzKF2kMjNTfLN9quVV+Okc0qvVwZOzDaWzTQntbhlxapRq5lD+Q1TcZSeVaCbWUO
         +ppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775120147; x=1775724947;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wq05JcQratHDvb0XfAUwWxpLJe4ES5FevW9OIndBRc8=;
        b=hZCqzEa+3z+7I982WaSvRC6E9/AbrxbETs/ikWnoxtxW/KansTk2udR2VKZg80RoF0
         RynsvmFcVxBRXgWoxJANlNqbWRrKQ2T8LxmqglpYjR2IA65n12MsMx2NAPbYmvlUW/uo
         1G0zRhhofmA2GLASW7p495+0XVJRPuNvOHP2dylKu+0yQ6mgZA+Iw3wOqI3dFropmWgu
         2S0izi1pArr7dBaKAvrSaXCXRn0r4QcIdW7YlQD7W2/qIXU9CkMgoNKl3OIJDIlf5uqx
         C9ZtRRYGsIt1djLIxMVL5ZaTFY0wsQpFBHnwDcwX3oPCSeDZi8lo02MFWfGF/yY4C6gK
         MK/A==
X-Gm-Message-State: AOJu0Yy+jrp2OniLdO52g4ZauHme4YVxmxUyzDk3rUfJLKMi8HLlzkd8
	onxD30Q5EJO9sh7o8BcQnTq28lrKMNox58FCoABihkC0cAnaBwrXVF+gDT0EGA==
X-Gm-Gg: ATEYQzxOsohOaLeUnELnHrp0b9jxSa/7V9lZSVYRL9eJ57gG3lzPdlDAzzC/3A40Mzz
	V3Km6h9etpFZdODcTi1qWPFqHhC1fiI5rN2CvK0wEzWavURp0bGQSKb1NUOazrlbtsFYW/iIaet
	QSM2nqbGbWQOQdGcpSypa0kiFQX6TY3FWRa4Lv62OurwI0WpKvMaTvYS+VrAb03Ya9/Kiut6mHl
	WYE31R3KGQdJP7UqrLX7jaCKBuuSCXwgy1icnEsbONy1nSweXlEm/Jq+7yUsnq5jR0E9Dc9heo6
	eFmt8TkjNIBuWkfMWVlHNtSYEcUtHYHQJ0SUBtTqH1ICq4L8SvzgHEUvBIZiHlegE45dgtDuz80
	hEUpzlHApX61nfmuiz611xNOO/9ilPjmmQLPhhMlOiLTiy68LId9Y279ppLmctUyKKhg7eTSlmu
	QmOv3QYTLXimiXwN5gAC+Zrj0tRU25
X-Received: by 2002:a05:622a:a0e:b0:50d:2828:1b54 with SMTP id d75a77b69052e-50d3bc9f437mr99813431cf.36.1775120147258;
        Thu, 02 Apr 2026 01:55:47 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.86.184])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d55893cb1sm4407091cf.27.2026.04.02.01.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 01:55:46 -0700 (PDT)
Message-ID: <69ce2f12.c80a0220.d2939.9047@mx.google.com>
Date: Thu, 02 Apr 2026 01:55:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8836775361111710819=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, moonafterrain@outlook.com
Subject: RE: [v2] Bluetooth: btintel_pcie: validate RX packet length against buffer size
In-Reply-To: <SYBPR01MB78812A5517C2CED45F5BD315AF51A@SYBPR01MB7881.ausprd01.prod.outlook.com>
References: <SYBPR01MB78812A5517C2CED45F5BD315AF51A@SYBPR01MB7881.ausprd01.prod.outlook.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8836775361111710819==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1076292

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      26.66 seconds
CheckAllWarning               PASS      28.85 seconds
CheckSparse                   PASS      27.81 seconds
BuildKernel32                 PASS      25.22 seconds
TestRunnerSetup               PASS      569.08 seconds
TestRunner_l2cap-tester       PASS      27.95 seconds
TestRunner_iso-tester         PASS      41.82 seconds
TestRunner_bnep-tester        PASS      6.37 seconds
TestRunner_mgmt-tester        FAIL      114.20 seconds
TestRunner_rfcomm-tester      PASS      9.57 seconds
TestRunner_sco-tester         FAIL      14.52 seconds
TestRunner_ioctl-tester       PASS      10.34 seconds
TestRunner_mesh-tester        FAIL      11.56 seconds
TestRunner_smp-tester         PASS      8.62 seconds
TestRunner_userchan-tester    PASS      6.71 seconds
IncrementalBuild              PENDING   0.72 seconds

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
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.104 seconds
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
Mesh - Send cancel - 1                               Timed out    1.834 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8836775361111710819==--
