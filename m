Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B530414F112
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Apr 2026 14:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775572150; cv=none; b=lNKcINda9UPQPfURna5dBna9KBet2WN+h+fv8cEZsTCCoj3juJ/K/KXBiSS2OUXJZ2BUdBHNO3xSrO3KvQFua4up0q5rlOf3QMLF/fQVOU/CFbJUKRy1RlaFpCX5czsgBxxhcDCSzkVUZsCIdJTV3NXMcVAgdzmFfnzQ3rp8SNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775572150; c=relaxed/simple;
	bh=oaUs0bCqA5FztY6Llnf9OfPPhhYityAX6LO77CSkRN0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OYKjfp63rlVQmxU9LiJRC31d5YMV58QESxz5IenHZIDjWmEMD+GBVaNRMyxbZEDAPoD2m66VDlqBceZHCsUhmiCg9VrZoY9O9yyMOcwSZA1VIeLGepGMQOBdyFqBd38cgVHRf71zSeWl2HuVPH4ygox2ePNJ61iIkaMCjmqLMHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hi74fOg2; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hi74fOg2"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cbb6d5f780so535819285a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2026 07:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775572147; x=1776176947; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Nn0rfxR+vzjmb6npwf6S71EUCsICV/5w6NVQFJFDMRA=;
        b=Hi74fOg2jY/YNPIKBdfqOhw2G+171HU8BJNcIjkdyY9D6w2VDYJrchPeaRJfhjEHny
         PeARsGCacTgzRwTF/uPRgNFgC4a5VxYaQRAyS4mCHK7kYmJ6dzICKRPpXIek/EmdET5u
         f9YIyRZhF0jYJ4V6W+2gS2JAih0o1EEClbBniRjPR4IYcUQDV6tYWSKGHr/6rvdGl6o8
         AcKcIMVLMZ77y3ZfGZz7tLqOHuweefEAedP+08rXL7k2xcpETb3ac2OGdDPpvP4/FRnf
         0+5cRN0qQA5d6BRgVP/2fK1miaXzB3eiAohmZfHRhQgJILWPfNU4s4C7l/E57jrS3iw4
         xGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775572147; x=1776176947;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nn0rfxR+vzjmb6npwf6S71EUCsICV/5w6NVQFJFDMRA=;
        b=KeJ/Yo+1fxyTzTrL/HmUb4ZmmHv0r4jv1MPPsioFJ9qj5N9crv9tytv9XpO/C/FkM5
         nd1S8dHZlVFPzbedF6cwFZTBoSua+XJNo95DyPxNglyNtvEamxiqxPL1Rk2xOEfKR841
         aEx6kXp7KorPivZFI0msaM5TNMpKC7kxoqNGVEQAbBqZTPN4z7VWWoshvLmnVZMGmuNf
         5Na/hahzWRgp5ykifi8HMKJ5gfVthjPREo1DSYnyUXpCUR7crH/2gmQEiAUiZzXOWJv/
         9aePtBXVsJum6UPpT7hhHI9HIqx+7RInaKbEH1a5JTt6A6Ab3v1AYCjGddtoNBRS7dpO
         501g==
X-Gm-Message-State: AOJu0Yzze9YAwIh3gXJUnkFVug+j7foG9GwT47pymzyibY8QwzjyaMLy
	d8CVdo83jQIJgqcPGU/sd0oIwFBe6M7YwRWfi2GxFkhbdI7rcYuxDrBuUdy6cA==
X-Gm-Gg: AeBDiesIKzsqaeVdSQqREolSqd5s+keKQoDf6Y2FprhAD2si3cmwdc5CfpgcE6r87UP
	aE6s4IYl9OxEGPMw910m5uhPZX4AVzb2WTMcZSs7YCoJXHi3FLkfgZVYhrLoJ7+rZfHorlha23b
	vW/MbMaM4qECS8Zwj22ZFduwTp7zw3n+fRGISLpVq70XKCHHIPB56xlZvPmz+SRXEYAgztUpm9p
	vE2lVKiB73LXaXYF3GHbOWKRwmwxtr1zfG7o9bGcDJZ2hbRGN7JSYOYuWZL/XXmTJtK9ePzPrVF
	OpWqJWaLB1AfJyQENmFC6mndIvgpQ7fi9YZ0UJaBIKIiq6BU1xPeyowA1joCExF+Z/sLuz5Xi5J
	MRkzLJqycTZSmvh/9eO1dDPL+j4Q6nYsdGhz7TRAjGm0PiTPtEVjZ09XsG5cxi03Rm8nz93KTfk
	/KkwbIQ5xoMl/RK+Ul4KPH4Ng8Ie1DIv2TYDa41Z5Otg==
X-Received: by 2002:a05:620a:400c:b0:8cf:dbf0:5039 with SMTP id af79cd13be357-8d41928553fmr2514318785a.15.1775572147255;
        Tue, 07 Apr 2026 07:29:07 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.131.213])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d6339bc438sm753966785a.26.2026.04.07.07.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 07:29:06 -0700 (PDT)
Message-ID: <69d514b2.050a0220.f8f35.cef0@mx.google.com>
Date: Tue, 07 Apr 2026 07:29:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8045444478876084366=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, fnkl.kernel@gmail.com
Subject: RE: Bluetooth: Add Broadcom channel priority commands
In-Reply-To: <20260407-brcm-prio-v1-1-f38b17376640@gmail.com>
References: <20260407-brcm-prio-v1-1-f38b17376640@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8045444478876084366==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1078138

---Test result---

Test Summary:
CheckPatch                    PENDING   0.52 seconds
GitLint                       PENDING   0.33 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      25.29 seconds
CheckAllWarning               PASS      28.06 seconds
CheckSparse                   PASS      26.67 seconds
BuildKernel32                 PASS      24.76 seconds
TestRunnerSetup               PASS      532.79 seconds
TestRunner_l2cap-tester       FAIL      28.28 seconds
TestRunner_iso-tester         PASS      39.13 seconds
TestRunner_bnep-tester        PASS      6.35 seconds
TestRunner_mgmt-tester        FAIL      113.42 seconds
TestRunner_rfcomm-tester      PASS      9.71 seconds
TestRunner_sco-tester         FAIL      14.83 seconds
TestRunner_ioctl-tester       PASS      10.28 seconds
TestRunner_mesh-tester        FAIL      12.73 seconds
TestRunner_smp-tester         PASS      8.64 seconds
TestRunner_userchan-tester    PASS      7.05 seconds
IncrementalBuild              PENDING   0.98 seconds

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
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 95 (99.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Server - Set PHY 1M                     Failed       0.118 seconds
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
Mesh - Send cancel - 1                               Timed out    2.707 seconds
Mesh - Send cancel - 2                               Timed out    1.993 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8045444478876084366==--
