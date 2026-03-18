Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6DD3B28D
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2026 21:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773867795; cv=none; b=I24HBCEFO3neFphkC1ZiOwxGETg801xGlgN5S9g7xs9iL16+GjOwxSMl/yBqap2xVYgkuHtNZg0kE8SCy7gyokwg/Kz6eMZyPHx/2TIzItCYUDLkHyADhxsifzHFGpxI41p+0pu67sgWWDEbZJKqwOTs5v9J0Fouu/3K+jq1/yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773867795; c=relaxed/simple;
	bh=b0rRccuvBkE7oXoRqAFK9rfykVlK9JrHR/Xsy0FT3Js=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nyIjprzf63zYseaRv1O37u8SXKgifUuhLxSAVZ0XNx1HpJTK3p5ktgYD4uWLxlLboF7/ZXuerJuXxosb0iNn4TfCKj/I3ld/HQeIOqpVvthGxHpAmcyWvamHu/t3yQ87YCacbgTQMyQvEvKgaTsx8Q1i0spnFTkBnN32KMMfvls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCQiwMTr; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCQiwMTr"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-128ef6c4a41so229396c88.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2026 14:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773867793; x=1774472593; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aPhRxmzzZ76V3HNPV1umlfnItB2jEZUaDg83hk1PDyM=;
        b=dCQiwMTrcpBqDA0otgEh4wXRSEaUi8O9Y2uo3kUk31O3aOguC+bmVjT2bezK280lww
         LI7awZpfhs/KyHgGdWhUIbjcR529Y3bpvfw8DriyZZbiQeNgfDn5jlz0MfR5aS0B754b
         c0xoYWcHDikY53mrnh69k6T6DOasZl+GButmOF8Jrl+CCbR0ts2sy1HvS9PLUAfnp93+
         dElmJwo0RuAfXu5gf4MTvTJWRBh8NRVTrEiJQ/a+5cuYiy4BOzuzo7WRIRn8PeOVFcKx
         5+x+PTkH7AYyP/GuyfqbWR+BOSOhGXLbhp1awBsW00qmN5nwdMbJ+MuumUTAEXkJrw/M
         d21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773867793; x=1774472593;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPhRxmzzZ76V3HNPV1umlfnItB2jEZUaDg83hk1PDyM=;
        b=dXP7XEyRvMyjdG40jhwHqj6xWo42JcEa2hVWEHAnZxLM3QqiOgGzMpYEP4Aj4FGXOu
         Md7/L3uoD/son8YyHZwbSnOab0Je2vzAby0wyfTRAAk55bg+PXVnk1zRf1MLVEAIGxBG
         aSbwhk9ffoEoNksdvU89P4kojiK38Nifa4utNAFLf8gerfPc6FenzNThBO2OCDrAQ9TL
         ZL95EEV4PHF1e1fAwQpFvdr8+cmkJd+9M83DDgFRJXTuHmJ1gjRepGEvUrDdWUpBWTbu
         9CjbWd2G34zPuUloag/CDixhiTvqpjBp1S2yCpsDcAZJ+8y0R7sMSBL/r0F2yLEtV2x9
         dK2g==
X-Gm-Message-State: AOJu0Yz3SJhRmcQzmx9ccEuJ7InhLkX8plahnhOFiypXqN1hkH6dPEtB
	4iElK5DF8fkN1OW7TT2GIhWMqqv7UHNzItxQHEVZV/vc4DsFq2D1TVhcYs1+Zg==
X-Gm-Gg: ATEYQzySfXS+SRtZ1IBWZtQL3kPY/fyar/rDJtzzQOAZt6OUdNJZesaLQ3+CIXWFOOz
	Rdh0bWUaVm/i0sFVlNyxFtvf+34yRf0ybAvymWgA0vzpvh8EeD5V8pAOiajFKosfbH5Bd/ryz6c
	shmAiBzcLAn8XZTQoO+KsZEFn8eW6HdHkESwNVINe2V4XAUDzpfF/fqUv5YuTtMrwrz09QOcHzU
	ObmnPKGzTethJ0+o1/C6YaJqfzkDo8op8JH0Rqn04TrfWjwVCO6W142exoP6ewBrfJCXo5DIn7C
	VoUQxWJS6rWTL/8MDI5GLECU2eWamszCBIZwSq8uqXsoDSTiPJoyBngGhxHXoIODXeuJ5XFCdBK
	1+fNxaHJusf7h1/lQrEK9cLEXJYVIy58bscgOYIjvlOnO+5IjGR+vtZkbshrDGizjydZ8QHwOlH
	5IF8snYYyXIw5mlgB24PoMVCHxnMo8vQ==
X-Received: by 2002:a05:7300:3724:b0:2ba:7069:686c with SMTP id 5a478bee46e88-2c0e5193a13mr2219114eec.17.1773867793360;
        Wed, 18 Mar 2026 14:03:13 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.211.85])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0e55a2be4sm6495714eec.22.2026.03.18.14.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 14:03:12 -0700 (PDT)
Message-ID: <69bb1310.050a0220.13e5cc.deb4@mx.google.com>
Date: Wed, 18 Mar 2026 14:03:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0605545448647750361=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sean@starlabs.systems
Subject: RE: Bluetooth: btusb: clear remote wake on idle Intel ACPI paths
In-Reply-To: <4863e9725130166fdfcea77298f70500dcc03b02.1773863497.git.sean@starlabs.systems>
References: <4863e9725130166fdfcea77298f70500dcc03b02.1773863497.git.sean@starlabs.systems>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0605545448647750361==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1068865

---Test result---

Test Summary:
CheckPatch                    PENDING   0.61 seconds
GitLint                       PENDING   0.38 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      26.88 seconds
CheckAllWarning               PASS      29.82 seconds
CheckSparse                   PASS      28.22 seconds
BuildKernel32                 PASS      26.09 seconds
TestRunnerSetup               PASS      576.58 seconds
TestRunner_l2cap-tester       PASS      27.73 seconds
TestRunner_iso-tester         FAIL      31.08 seconds
TestRunner_bnep-tester        PASS      6.33 seconds
TestRunner_mgmt-tester        FAIL      113.55 seconds
TestRunner_rfcomm-tester      PASS      9.48 seconds
TestRunner_sco-tester         FAIL      14.67 seconds
TestRunner_ioctl-tester       PASS      10.34 seconds
TestRunner_mesh-tester        FAIL      12.53 seconds
TestRunner_smp-tester         PASS      8.52 seconds
TestRunner_userchan-tester    PASS      6.61 seconds
IncrementalBuild              PENDING   1.08 seconds

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
Read Exp Feature - Success                           Failed       0.106 seconds
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
Mesh - Send cancel - 1                               Timed out    2.708 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0605545448647750361==--
