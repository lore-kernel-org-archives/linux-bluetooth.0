Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0F933BBA2
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Apr 2026 21:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775595812; cv=none; b=I3uYkuamkOuOI7sC7w3COI3QSsII138WNZTCv2BgrgKfh2JHZA6nFJFxCw2YxYhaeYGaFgpYGAaVKdQLKMiu0mgqHgLAwR/Ep9E+mYmBWpGhEYwLEq4puoiGCpcLUiIr1RHCheUaEqs6/RGuVzDn3yNhxbDiK1cOpAJfd7egimc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775595812; c=relaxed/simple;
	bh=qxNEKcuzTrW4Kxlj7cxP2/NxWPhVOIbMN7tCKwiz3WM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=JcEKa0+9OahDldMbawN95MjU65EXHfQw3ezbVNZQCAtoTF3cYzwPBRaKwBgJwyxfuxRJLSGn2ppqI7SV84KHR0mAdy4tylvPl7sIJifbmoVPeF8NzJ4wwYSq6pJYacZMshBD3x11R+S/7tSf6L/s+viMPNF0W2E1DcWeMOUfGEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4i8t8E/; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4i8t8E/"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8d736211595so216220885a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2026 14:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775595810; x=1776200610; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mfvY/gZUm0PpkkFQU1uZqUPfV77QW/MHuCniZeAkyXE=;
        b=W4i8t8E/wDNE+2A0sAIThpALdSZj65OfMQf8/1cNt4Zp8UQqZQq46+R1Z14PHZXLKE
         RQHS4yruCwLG4kuksx5CWUi4YTSw/CRGInssJcUxIV1RanY1vsih/+cwPckFvv1dmJHw
         eOJ1YJ3NKU+XrAM+CAq+UjGWp58QDhfvzBVvuUssemANYqcVSxUBevugH1AMmQ6hS4Ls
         hSGHRUREFRfxIiw0ulgeiLSKUNN9GwoSaRjt83D4sOIbSNca/eN8s1ruw+edL4Antssg
         2g5iIfEfa8MMaEYeXOI0uDuQi7EbDf7R6RohrCzPFiS2/uH2htdHZg+bA2kff8d49OI5
         SqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775595810; x=1776200610;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfvY/gZUm0PpkkFQU1uZqUPfV77QW/MHuCniZeAkyXE=;
        b=gzRfU5hKWLoKc1HWlH2zQNzys9ltYpc41VrHiILq387us58fwSjn03cD13dcwXMafj
         tPDJ45BB46coIdZRsw9+mSDIyd3Tiy5Hmd8LQoQomI/ZJXU+EWFrtc8vF2G2k5KvoAIC
         69jZGAffNDHjr+F/YE0fjh7MPBiaN+T4D6kPzTzt3gug8P7tT0/lHC0sDgFLajk5izrl
         swCuQQbgCWfcoJhHjeXQwI+yd30iUhXAgcsh5+iGRX/LXjS1TiRMI2CKzkXeQevw6tRO
         7fC1L4vFKFtSXe/Nsk5bpxKZ8z+22GjeElINJvslZYwi0r2VgYu4nMk2tlk5fo8F8Lze
         XU/g==
X-Gm-Message-State: AOJu0YxmyjdvVoyA9B99/U5TYMyex/TWW6sY8jDvFyBJRG76fRbPWvVf
	BlDLPCMZtu8M0j8U1I81t80ijg3cnqyks5j/Qnm/P5sBrMXfxy/pPo3IYFG1cg==
X-Gm-Gg: AeBDiesMhXSAp/BmiBT6usXKIqK9QJpVUegnBxLoo2G5JAr+LyJwqt9RC9KpvkCNLuo
	0182AN1OHdn5oYYOioStPfsUz94+W6sDyNjl8u+zPyeEXvei6UKEXEH2GhSGAUebUV/ynEz3E5Z
	QuObc0OD0frTYMrHhu1XY23vsbiSobx/Z53WIvEYFn1K2320kNsOihYtDxTavlf+lKs7ZA3leMR
	IJ1oC+T3USwSOpqTTInnSaTDK+xayrBfBdwZfHs4eyv0LyXDSJcxXD0zKx2ZZkVXvcRWs7dCQwW
	lLSvAaJoR2CmwfxQ8gFn2L0vNvn63ncXNqUYV687N32w3hOvsWcpgVss/A5oUAB1IxnChpB5J8m
	pw8hpV0PEHYFF7vX9A68byM6mfR465/1WBVmR+DasvH+JJcB1s48XVBb73Lh1T2h5SXkZo578eI
	ZzvyFCHT9EwsnxD/lUEsiBSe7hq6GuXJ4=
X-Received: by 2002:a05:620a:448e:b0:8cd:79f2:dc50 with SMTP id af79cd13be357-8d4151e4ec3mr2491507285a.0.1775595810112;
        Tue, 07 Apr 2026 14:03:30 -0700 (PDT)
Received: from [172.17.0.2] ([40.116.109.133])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d9eabff99dsm238962285a.39.2026.04.07.14.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 14:03:29 -0700 (PDT)
Message-ID: <69d57121.050a0220.23a956.72a3@mx.google.com>
Date: Tue, 07 Apr 2026 14:03:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5430222280658506271=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, gustavoars@kernel.org
Subject: RE: [RESEND,next] Bluetooth: hci.h: Avoid a couple -Wflex-array-member-not-at-end warnings
In-Reply-To: <adVmLsJCQrBCMDD6@kspp>
References: <adVmLsJCQrBCMDD6@kspp>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5430222280658506271==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1078355

---Test result---

Test Summary:
CheckPatch                    PENDING   0.45 seconds
GitLint                       PENDING   0.30 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      26.23 seconds
CheckAllWarning               PASS      28.84 seconds
CheckSparse                   PASS      27.69 seconds
BuildKernel32                 PASS      25.71 seconds
TestRunnerSetup               PASS      576.20 seconds
TestRunner_l2cap-tester       PASS      28.40 seconds
TestRunner_iso-tester         PASS      40.63 seconds
TestRunner_bnep-tester        PASS      6.48 seconds
TestRunner_mgmt-tester        FAIL      115.67 seconds
TestRunner_rfcomm-tester      PASS      9.52 seconds
TestRunner_sco-tester         FAIL      14.64 seconds
TestRunner_ioctl-tester       PASS      10.58 seconds
TestRunner_mesh-tester        FAIL      12.52 seconds
TestRunner_smp-tester         PASS      8.64 seconds
TestRunner_userchan-tester    PASS      6.82 seconds
IncrementalBuild              PENDING   0.50 seconds

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
Read Exp Feature - Success                           Failed       0.112 seconds
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
Mesh - Send cancel - 1                               Timed out    2.660 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5430222280658506271==--
