Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA64242D89
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Apr 2026 20:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775678873; cv=none; b=mIm16hgFbM/hFMBFkTU9tFzlo+x3h38tfFZtyVOuSx8UmeRt8RznIZ/rMxERFY7qLHZU30k6+ojdDS67CVH2VIzO8FIJhLWkApHmb1z2l/25DX9oTW+41vulZ/1J2KbTCs6djTR40fFSkWaE5lCxL3LuPjRSblk5fo9wtkTp3B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775678873; c=relaxed/simple;
	bh=ws6IViV6Em10kN23hW2VYEBPGBdGAMUVAm88wK6geL8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=W0MJuPzcjgwIAePCfj/4gI1peMJK0Aoa58l4wJDdY9+c3a3EVmUzcY2mU8HSUlcHk2/sBxBlqdgWcIlHZBIvggo0AENu+Z9JwBPNqlpTVHLs+eeHMHFn++7jDKxbh0ZQ2RNMFDODGE/62DRntoHIzgNUfYD9HIvQZGKbo1Qd1RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dusqZcy7; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dusqZcy7"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8d65f4073bfso25743985a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Apr 2026 13:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775678871; x=1776283671; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=E6wry2KEmj0AbP7h6F5zr66B7AVj92YmDUEYyd87vCU=;
        b=dusqZcy7G4bTP8NVYLXJ1Tp4IVBONI1PHHyR0MBjkTmbmLV7l7Z8Z/9NoGB+dt0G9x
         YvuQ+uEWEpkmFBouE8gSKB1cV45XUE4YAwT0gTw8wO0Yfhmc4/9scZd9EptuKx8GfPas
         0GpiCUQ0+dfBMSNYbm2yqQ6rw5gOcVGswOuso3VShTs8eEAZi0VOt/koQeittqILwNdO
         hPMu64lxsZ7RABt3EUeoliahj3yldv5vVEsVJPGtgQhi0DujYwvlVvfCvaHkqcBto3oi
         hhNtTnPqW5VOH+RMIfCCJhexbgUAuVtI4IpneR336lAKk3qlmhllC3A13XnDe/XChOtC
         3DLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775678871; x=1776283671;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6wry2KEmj0AbP7h6F5zr66B7AVj92YmDUEYyd87vCU=;
        b=sWE/DWHNSBwgwGHTqWCD7k0QV1Ar1oCyGESEWeTK4mNDTJIy0qgMI5hVrBLl8bhxYv
         rjZD7cDe7X3Lw1qZuLAnxKsH3NNoqkb02S+FyNSKPaZd0dsU84Mfoqmrnr06+Fi8gC/c
         UMorXAdlIqJldIvj6tDyH7Gl1porMLi7miej9LFSgAeRrd9dcCDtniEaRvd38FjkKcFd
         y3yGwkBUx+Tj1fy1Y+wnc0uorhHjlcrNSyKMpO5ChSL3hH2QfzV2PG56CKH6bZ/z5XxC
         8WkFM1dwW5YcDhHXg5APMN3kboMXt6WNyXy2QFMll8Mof+df7zISJEZqOZ6veq+PYr4/
         7d+A==
X-Gm-Message-State: AOJu0YzJOyWDJ9l5N3xZWe0i+43ilyjZQ35b5ZlK71Go9EjkyGnuEXTn
	OWDD6Cum5KSB7xWvU70BgxeoExoKGZH2l3biRZ2zQ3k+j2CFRdh1P9n8BpczgQ==
X-Gm-Gg: AeBDietn9BEPbgUV0jIf7fmxhG6KeSTi9mAAjIeEQTLzlSEc26mmR0kehfmjvE+titQ
	we85KtG57w0xs4WvxMrmE2oB+9lI6sTAztdYTRNtQyKqg8Y+9E0U0kWE99ou3IvMI8tRDdnC/2U
	1iCx9L9zv0WK+O0XxvoMtMeDYBiCuRoeTzdcCtE2Dq4jyQwOTw/XJCvN+R+g1cB07JI0lSpG0kd
	fbB7QLCZlZL+XbjvVrbGLdi9AWaftJ2nfWf2Qk5DolNjD6UE7nFs5jqXdn3KgdccB/GgB025L4n
	9/nOcsfgV1jdGm48+AgThKJ5R4C7O8B0mSxNokMaPCC1w4xkUOkbUxoJWNP10Uyu8JY59F+s9A5
	Ot6xghoPYhVYMG/or/cmmADPHfurl/b6cWKnwwdpoAY1sWyBWhniENhANcYFTVGKQM4Hl3dZK9U
	3CtG/12ofNYJQZPm1+jmjYAU5MrnY/qYM=
X-Received: by 2002:a05:620a:d85:b0:8cd:80f1:f473 with SMTP id af79cd13be357-8dc3bbefdd3mr175908585a.23.1775678871093;
        Wed, 08 Apr 2026 13:07:51 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.224.82])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a5488a28sm1617409385a.2.2026.04.08.13.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 13:07:50 -0700 (PDT)
Message-ID: <69d6b596.050a0220.1cdd01.9e29@mx.google.com>
Date: Wed, 08 Apr 2026 13:07:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9152503645349185262=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, shuvampandey1@gmail.com
Subject: RE: Bluetooth: hci_event: fix potential UAF in SSP passkey handlers
In-Reply-To: <177567405034.77733.13793767420759611909@gmail.com>
References: <177567405034.77733.13793767420759611909@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9152503645349185262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1078865

---Test result---

Test Summary:
CheckPatch                    PENDING   0.49 seconds
GitLint                       PENDING   0.28 seconds
SubjectPrefix                 PASS      0.26 seconds
BuildKernel                   PASS      25.88 seconds
CheckAllWarning               PASS      28.13 seconds
CheckSparse                   PASS      27.57 seconds
BuildKernel32                 PASS      24.83 seconds
TestRunnerSetup               PASS      567.22 seconds
TestRunner_l2cap-tester       PASS      27.70 seconds
TestRunner_iso-tester         PASS      37.67 seconds
TestRunner_bnep-tester        PASS      6.40 seconds
TestRunner_mgmt-tester        FAIL      113.44 seconds
TestRunner_rfcomm-tester      PASS      9.37 seconds
TestRunner_sco-tester         FAIL      14.29 seconds
TestRunner_ioctl-tester       PASS      10.35 seconds
TestRunner_mesh-tester        FAIL      11.48 seconds
TestRunner_smp-tester         PASS      8.62 seconds
TestRunner_userchan-tester    PASS      6.77 seconds
IncrementalBuild              PENDING   0.64 seconds

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
Read Exp Feature - Success                           Failed       0.107 seconds
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
Mesh - Send cancel - 1                               Timed out    1.860 seconds
Mesh - Send cancel - 2                               Timed out    1.992 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============9152503645349185262==--
