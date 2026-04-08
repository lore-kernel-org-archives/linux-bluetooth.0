Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3312D29C8
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Apr 2026 10:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775644305; cv=none; b=BPf7cqS1f2gWCNiGbuoAm06znbywbYFegdUS25mv18BSs61gYc3Vz8RfliQ8JUVZje1yCwjwatK7xLLBNXzqIkx2f+lZocclim19eYxGaprXvbRCvBTVEkC/mEc8GNfqKpJ64dLV3o6zsPw+hOfakDAtCFyvgZbfRx93z79e/Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775644305; c=relaxed/simple;
	bh=Eh8F2a8r71UNH/0td5Y9zj/8zR71vWQf39jTwrn2nQQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dFHKzrR/1qfy29DY2nt8KsHtwT+L8FPbEWXvxkAAe88AtqMNKcBJRFPdBDBdTcoXuTlGABkXqUEXg7dCA4fGOsmD5IVaAQN76CN9b5dIIEuUvrI0N9W3Eo0CBiU62mMbPdLqHtiABIjMA7Nc9Qnn8z28TiPZBSjm7Ztu/F04GWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnE/Lgp/; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnE/Lgp/"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8a5800772f3so52276646d6.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Apr 2026 03:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775644301; x=1776249101; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Gc6eGiwFE/lMgesMxuig0Uzc4U14McF41hvfH0b/674=;
        b=TnE/Lgp/U/osJX7Bs2nvhB4/SX5zYsRDeKUz0X80lrDybD+l5fPnwlUSP+aBrDPGHs
         u6RR8UIhRl24wbNENGFH3Zsw2+jcZ2Ta7dSF8XJHf1GH6M+0h2Y88x4L3AolunLRKyHR
         O7uPsILYFMkhU761S6jn2kxVg5nquJEnhfCQNC0SlfhDNVjk/+Jo7dnZsl1pc5L8WApS
         aB9nQgtQB1lua8XkmmxJoNdHLBX4gS67weIOHQ3XLee79DbQoxvGD6fYsWCI9GSPWgPF
         iIhAvAywrJxtd+fdOyobdEeUj25gLTSr8lTZqcT/15XQhg8PWkTf98MbsaXLxt/XUXGU
         BCvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775644301; x=1776249101;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gc6eGiwFE/lMgesMxuig0Uzc4U14McF41hvfH0b/674=;
        b=ABR5Ix0bhWgBtMeLCN5Wdpls/jrkzacz+eX+IRu4pFUlALDJR2l+OIof+ck1hxtFDe
         J+PGNuqR529iql70A+aViurCSBJ5OFiuSWJnwRHI5c3Ni2rsnoohv/927zf7hVg7PuA2
         hRdAynMNLpIViZfSYUg5mM3BIj3GzdTK1O6XRKITKetZk2ChP9QwOY9Giq5EdtuBLf/E
         +zPFNEk07IaNEx2PV77opVWt3sMPO/EgNb+A+Y4vy5z9vegzW7BmMis57deboHciIseL
         gltsS8FapbSlIYRKjmEwGmCI2bMkpejipJtiyBjoAo5ZHZWBCro804o49O/q/ff3cXyl
         LaEA==
X-Gm-Message-State: AOJu0YwM0gxMNduigDMmE2yF4cfV+2xwwLidYJUIsMkZNZl8z7fyLkkv
	nJXj/Pdvg2U9L6CmTkuoJixGvYe2QIDOhtVNTUvwuG+m9ZSU+la2v/3Xj3gv2w==
X-Gm-Gg: AeBDietCKctVGQwqc5aZqvAFFgffybqwT5V/jxT9C+ZAI2/gmHlriiqMPuonYcAOaC9
	Q/i7cfkA1DZ5Vv9g2FkHtWpsLsN/cPHTa7nkQC20FUMWD6ByLIO/Cb+0gXuDXkvkBzHUeEZOi/r
	MFNyMwZGcv2oQqoLdCLJmYWfTPxiBYkI5seW/vOHqOogQDBDtNcCF24fGuM/ARrI4isCBFHTL3s
	J5S5db2Gn0oUP8C9otDcG7XcIK9NmnIPVbBZunO2toxTLR6beIp2ZH7U8Bkw9XvDgy7dftkplYE
	l3QbMd56PECXdkLrITfGLmbVoBs3gF/t6E6UGcsONJszaWJUwCZTOhk2bRbIkcmO7HaiT3RYDfX
	sKvRNkmc5KPg1mSUweTQ0klUyeWHbXippKN2xLxYoV5U5Wh/jkTJNgSumLuCCCpiiCfYLzS6jTg
	v+wbsHd8Wq/50TyKJThuFv+Ro2DnzITQ==
X-Received: by 2002:a05:6214:f6a:b0:899:f829:e8b9 with SMTP id 6a1803df08f44-8a703460b75mr316295906d6.23.1775644301125;
        Wed, 08 Apr 2026 03:31:41 -0700 (PDT)
Received: from [172.17.0.2] ([20.119.41.198])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a5974ddccdsm171593286d6.41.2026.04.08.03.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 03:31:40 -0700 (PDT)
Message-ID: <69d62e8c.0c0a0220.33d01c.0179@mx.google.com>
Date: Wed, 08 Apr 2026 03:31:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4590162522157813666=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kaihsin.chung@synaptics.corp-partner.google.com
Subject: RE: [v2] Bluetooth: Add Synaptics 4384 Chip Support
In-Reply-To: <20260408092128.1915973-1-kaihsin.chung@synaptics.com>
References: <20260408092128.1915973-1-kaihsin.chung@synaptics.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4590162522157813666==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1078548

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.23 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      26.12 seconds
CheckAllWarning               PASS      28.42 seconds
CheckSparse                   PASS      27.57 seconds
BuildKernel32                 PASS      25.43 seconds
TestRunnerSetup               PASS      564.78 seconds
TestRunner_l2cap-tester       PASS      27.77 seconds
TestRunner_iso-tester         PASS      33.34 seconds
TestRunner_bnep-tester        PASS      6.36 seconds
TestRunner_mgmt-tester        FAIL      113.95 seconds
TestRunner_rfcomm-tester      PASS      9.37 seconds
TestRunner_sco-tester         FAIL      14.38 seconds
TestRunner_ioctl-tester       PASS      10.17 seconds
TestRunner_mesh-tester        FAIL      11.55 seconds
TestRunner_smp-tester         PASS      8.54 seconds
TestRunner_userchan-tester    PASS      6.69 seconds
IncrementalBuild              PENDING   0.49 seconds

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
Mesh - Send cancel - 1                               Timed out    1.910 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4590162522157813666==--
