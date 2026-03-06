Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759EA37268D
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Mar 2026 19:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772825740; cv=none; b=qGoEX/z2+WpJuFmgK1+v2d3U6vKhoDlsbG9e0ue7ZBt1ZaWoZhKcCKzeDx03Jm0e/ntg+JseDEmEjag2HaFdoa9d9onnwlcNCh1jTb7Gsac3cNde0SIsqviuffF1/UDVZVAjo3ymsFmbDovGJSac4OK5H5lAGlFqC/759tJWsCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772825740; c=relaxed/simple;
	bh=9kXPwdId7RRFJOy4JYyjoWLR49jhMC0q3poeJm704xU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=eZcVugPKp0mOXJlIGa/Y1Nz/W6KM7A6SmXTBRHx2z+0vuolSwGoQy7hz+GfWxy93mA54gp+1AzFaEZge522Gd4GHUn++DAhNYSFomdgams4Am/z54Q2y7xPy1Rm6Buwr/HHjjsOpS8feA1aznwOHMcfKnhq0bkYQB9mAilvYxzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdBpNqN7; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdBpNqN7"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cb3e0093e3so919437185a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Mar 2026 11:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772825735; x=1773430535; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vzPvZ9gJiYVHDJSflltEpcldfeaRbMkLYPciTGWahGs=;
        b=ZdBpNqN7vKLEc7cI/8DmiWM5n3hLn+BoVKwvrlSpz71H6fTIzJpSdXbfICdSqVx0LS
         3VWe6yGUFAsTJg+glUE9Q8CbbHZi0Y0yZUoiNCXj2aB45E9N/10l5CHEmqF6nISGOfE4
         xeFFHtQ57dXBq8ThBoiTKKpil7VxIHpovWDHTvdNWse+q8XBaWIn9VB6Ow+fMP2BYNLM
         YJp9WRStF1AeA848n1+WML6XsQoiQ33Y6aOxrdE9CDDqL1TDW41q2ovX0bZ+Cwpx3hgg
         IrSfwm2HyGpVrWecSKfDtauYPxl5ZgNHvyn02MosIv8u4YJg5Q9zp54kUupZq04t+4n9
         819w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772825735; x=1773430535;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzPvZ9gJiYVHDJSflltEpcldfeaRbMkLYPciTGWahGs=;
        b=wpKG8Px7k2ACewYxKs1NYjGxWRPsjzTLBh8Dd+ujD0G5t/GB14RAygB4UCmHUwi+a1
         KLM3P0x8Q0KA7SJipd43OP+Oo31C2ApJaTo38HnZLqtSehwF/7Vq3SmLZluq0Go66Bp5
         P6ArIpKyN9hRe6/GnrcYbgw+JZ10BRCFh4eUKRv3N9UCoJQj4SECIabYo/YsA7pyb+T3
         t8HdINkf64aS4pn+GFZKbpra8ttmGhJWgzo3NAg4iljcLotrk90Ga32wQmJiuTO4Q02Z
         TgbRvPz1zA4EC5CYqkEBGB8ZGsdRBKJMvFe+5DPyBD+kpkbXvfCKjY6t5DRZeSZtGxlX
         b7CQ==
X-Gm-Message-State: AOJu0Yx8JEVa0oegD/qk8jqUxpdIl9mbC3H+Zyj+7CZWAvsi39yZFsr7
	cLWzOWeaz6hDgiR7Ltxhmc84idz94WlOzTxXCFMO4pm+mteiYs+gVo1dXEhdJQ==
X-Gm-Gg: ATEYQzwnGBQnXC2v2dj4SqHEn0xS2v47xVGm/BR+v2tzkJKGgPrx2PSGyNcCaNb47IO
	y8bS9xq45WS2Q26ToPlwbofYai69atSdSYOJgxzUX2BEeC6vefvUzWukDiD5wQK4+4O/TXjrXBq
	4wHz8x+QwNsr+FUWyQdHtLDYm2qXGidOG4PW4jAIq35+d0YrYBZ6w4vAascGduQtoqtQpnfoedf
	fF2fPnAKGHgYAQaPbUDBAvSy7rSeJdJ/MfpP+Papg62qG8sufsbGAcDhNsONMB2Q+NCZpIGAEm6
	OoxQ0NeP1MaLcD++c85uiST8Eos8/KgAKkXxxdwj6ZiSlo2lTwukxnEFqdZsWsrigozfxdHDP2K
	aGYvOHXCqVsCcjHzII7xbzjfXyFKFmkkCExLSkYtqmUcKkAE4pGpT/hXHy04Q+ckwvVhjIJipEG
	yggdvx89KCgujuk3qJyGytN8pxN+4e
X-Received: by 2002:a05:622a:164e:b0:4ee:1fbe:80de with SMTP id d75a77b69052e-508f4979dd5mr43287231cf.63.1772825735128;
        Fri, 06 Mar 2026 11:35:35 -0800 (PST)
Received: from [172.17.0.2] ([172.214.47.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-508f653c566sm16320141cf.8.2026.03.06.11.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 11:35:34 -0800 (PST)
Message-ID: <69ab2c86.050a0220.326f0.28a9@mx.google.com>
Date: Fri, 06 Mar 2026 11:35:34 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3597844044992789830=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: L2CAP: Fix accepting multiple L2CAP_ECRED_CONN_REQ
In-Reply-To: <20260306183932.631223-1-luiz.dentz@gmail.com>
References: <20260306183932.631223-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3597844044992789830==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1062792

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.22 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      26.22 seconds
CheckAllWarning               PASS      28.97 seconds
CheckSparse                   WARNING   32.73 seconds
BuildKernel32                 PASS      25.62 seconds
TestRunnerSetup               PASS      567.97 seconds
TestRunner_l2cap-tester       FAIL      29.84 seconds
TestRunner_iso-tester         PASS      76.31 seconds
TestRunner_bnep-tester        PASS      6.47 seconds
TestRunner_mgmt-tester        FAIL      126.33 seconds
TestRunner_rfcomm-tester      PASS      9.81 seconds
TestRunner_sco-tester         FAIL      15.09 seconds
TestRunner_ioctl-tester       PASS      10.45 seconds
TestRunner_mesh-tester        FAIL      12.52 seconds
TestRunner_smp-tester         PASS      8.82 seconds
TestRunner_userchan-tester    PASS      7.00 seconds
IncrementalBuild              PENDING   0.62 seconds

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
net/bluetooth/l2cap_core.c:7799:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7800:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7802:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7803:1: error: bad constant expression
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 90 (93.8%), Failed: 6, Not Run: 0

Failed Test Cases
L2CAP Ext-Flowctl Server - Success                   Failed       0.112 seconds
L2CAP Ext-Flowctl Server - Nval SCID                 Failed       0.108 seconds
L2CAP Ext-Flowctl Server - PHY                       Failed       0.116 seconds
L2CAP Ext-Flowctl Server - Set PHY 1M                Failed       0.148 seconds
L2CAP Ext-Flowctl Server - Set PHY Coded             Failed       0.148 seconds
L2CAP LE EATT Server - Success                       Failed       0.112 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.113 seconds
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
Mesh - Send cancel - 1                               Timed out    2.596 seconds
Mesh - Send cancel - 2                               Timed out    1.993 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3597844044992789830==--
