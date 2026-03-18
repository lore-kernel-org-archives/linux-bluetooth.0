Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDAC2DCBF8
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2026 19:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773861346; cv=none; b=A2Bm+z3A+B2itFFQctges/VTkWhkJQnD+R/Aoqs6S+Q3u32XnvM+O4wShGcbicEvdY2Qj7YKV4iWKz+AEnqheg3XytLpfM7hyDA7FUSqwc30iO/Rq9LfjiAdE1j6RFovv7NF4xeuWBVIvXmv08wSiQwB3+/HjSnnd1YP5SV/0LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773861346; c=relaxed/simple;
	bh=JeRBlKND1mN8q+0YstOK8hp0eZHNNtdnc2Yhl3MiQdg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NJzuLUgH+vShd8q2kOcKLJOpHOlK9fgKh1BQORdrqPNgyHGpdrE9gfV9ocLJ0QtGsAZlI1FcqpSeHjK0n2iH1TlcQm7beZ+/XFokn43/PoPBWdivUYfmrVqtCGuqCpJAqkGkCoZFo4hJvLErBgyaQoXHGCAl67NeRm6Bi0PST0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E76VHWfw; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E76VHWfw"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5091d71aa11so1870941cf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2026 12:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773861344; x=1774466144; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xFvP2ZgaLajldxD6zV0gaXEQtgPDYrMnOYCKOgzx594=;
        b=E76VHWfwycT7BUJN7F4wjeO60fC9JLoB40z0/Cx/AWeBZxusZs/1wn/9ZG+3NOct73
         tXOjIopkYxZg1HEsODTPzNYU4JTzpFmiaMsXuK78XJmmDeEW1JCfyZ41EB5gpXBPbMxq
         SFDp2PhZowq7PQfVZlFMWMfRgd/7KAcSPXV3vqEpSo75MYQiazgs4na/DTMIn8tl04ym
         19n7YXX4J8ENVdhz3+AF07CxWJP64F1Ze1GTA7xOr960WE3//HV6k3019CikGWKrzQUF
         d+igur2IlC8e8Zu8vgDpr1EjMkIlsmtzHplqLpqm1YTqdg9gdIWye/70texQG9VwxeDM
         slwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773861344; x=1774466144;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFvP2ZgaLajldxD6zV0gaXEQtgPDYrMnOYCKOgzx594=;
        b=WhuR6s5y86Y9RypaNeB7s0mfoWwYPRJFZ82VF86c5UkJTNnkjOKgbTwrSR1uR+GiOQ
         IexNGYWbEGFbREV5bTvLYBT2BdX+GcjrU82bvIQfmFF7Clbx58mY+7SqnIKgXo3WoSwo
         mYSFNQQIk01DoWvFHIRNY3Z5DdEU8O7DUco3j0Y7KZy3MtrQMLddpyvdYVPebv4QjM4V
         CKtMvJup24M1yHjqDMnSuvn9AjNENk4q1eoLd1sJvB5m7xuwjJipPyqUM+rFDagK3ad8
         8U5pdzGmq1tTlcVJ8tgTSwkhhUn3SK0VPi/aAu3H+LZRxfGJpWCPKl6B2T6olaqyUr/1
         +DaQ==
X-Gm-Message-State: AOJu0Yx21go/TxIptPzUbCqnow4gG87OXiTGwumYmRgbYv5AjX0Kuliq
	lC5yLYBdBZJSPwZvC9bYMvMKbkGxE2gCWSsbBAjSPolhaUh/MsvUZJgy3y8Kxw==
X-Gm-Gg: ATEYQzxtlcRA0ll5+SVloLaLm6DcJ6kS016d7gwXnuqTU8Au3Pr6308VIsyPnOzHLLh
	aonZruyXMM5b2vHgZMSJ55n5Xvi5li0m+MFXTCiWjnponlNflEdA1ziEu098PB6LdbEHM+9TDVm
	Fu+DcIBaheZUOzAFr9EZlqbXqQ5xhDdPdcZpj+xYkqJ63eBMjPdqnUPcBZxfcwm9lf15fyz6qFq
	rEnHVEkYaMbokGEzBfTuGJMhL8r/FfJYmwh5b7rf8pyTLzW6bbTXH/AFxphdXYnh8u7r3xZYoo5
	QI5028Y3KkLiUYcX+NNKP7Qq0HCTCpD2BKLqVZD6Mi+4loWnwNmN/zmgoD/tgjxS+J6k87NXvEC
	KOyzLLuw9OsmJhzey0hDSvBP1jLF6YYxCS2B5aBUpYPOsdk2EyiLdwMokSPW0A9nGoPwACENGYU
	ZPLk4xObBFuweOTXVG23hdIDJ3gVMKk/GmpC7OhJcI
X-Received: by 2002:a05:622a:11c6:b0:509:4342:9966 with SMTP id d75a77b69052e-50b2461b2a5mr11414971cf.16.1773861344190;
        Wed, 18 Mar 2026 12:15:44 -0700 (PDT)
Received: from [172.17.0.2] ([135.119.237.66])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b135d523bsm28647251cf.27.2026.03.18.12.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 12:15:43 -0700 (PDT)
Message-ID: <69baf9df.050a0220.379d19.fea6@mx.google.com>
Date: Wed, 18 Mar 2026 12:15:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2855593718281383770=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3] Bluetooth: L2CAP: Fix regressions caused by reusing ident
In-Reply-To: <20260318180922.307838-1-luiz.dentz@gmail.com>
References: <20260318180922.307838-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2855593718281383770==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1068803

---Test result---

Test Summary:
CheckPatch                    PENDING   0.40 seconds
GitLint                       PENDING   0.33 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      26.51 seconds
CheckAllWarning               PASS      29.30 seconds
CheckSparse                   PASS      27.94 seconds
BuildKernel32                 PASS      32.66 seconds
TestRunnerSetup               PASS      574.24 seconds
TestRunner_l2cap-tester       PASS      27.95 seconds
TestRunner_iso-tester         FAIL      45.96 seconds
TestRunner_bnep-tester        PASS      6.32 seconds
TestRunner_mgmt-tester        FAIL      114.54 seconds
TestRunner_rfcomm-tester      PASS      9.37 seconds
TestRunner_sco-tester         FAIL      16.25 seconds
TestRunner_ioctl-tester       PASS      10.16 seconds
TestRunner_mesh-tester        FAIL      11.47 seconds
TestRunner_smp-tester         PASS      8.71 seconds
TestRunner_userchan-tester    PASS      6.61 seconds
IncrementalBuild              PENDING   0.96 seconds

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
Read Exp Feature - Success                           Failed       0.102 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.876 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2855593718281383770==--
