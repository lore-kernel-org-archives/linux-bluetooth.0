Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E80833D6E8
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Nov 2025 16:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763656891; cv=none; b=K3XzP/x24/GFcHp+hASxkQRnqX9f2KZHG2a6zLBMVB+XZsaKskrYr+XThybPwZnHXuXPrJQrwGuqHO210PCEXgEScjlOn+IcDe9O0HlpgL28eP4AXs0+FA6HMwXhmlq80xMAJIS+bWfvTSfRoYZSvSK9c48hN6MXcA+hvv96Q90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763656891; c=relaxed/simple;
	bh=Gh7BGRq9+xlpWu5D6177F3AOjRBR+0GLT2RzVTZWqWY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CYbrHWt6HJMowVowIH2f2twGGu6gi4P5/Pt7vOiDUkZqihtGzRMmsb5bPzNxynJAM8MiM9BN+vrCuD4g7anbMOw+G21rX29GhZ6+SO5/KdTxk5TgjRP56Y9P1cQ2IoX7a53Ep6jkuYSgxqUpsF4iDln6uGedDG3j0T5nsnzMU1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMlV6s8a; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMlV6s8a"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ee1e18fb37so11751471cf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Nov 2025 08:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763656888; x=1764261688; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YOnAUcC9uxAjICDF3N4vcSVSBu4jlzwKhwPQVQw1mKk=;
        b=ZMlV6s8aJ2XdRGdLsbtk0tTB5UBMBMwdkKbpxaaN3qypfPYrpWBCzDW8ImdYUevNk4
         9wv2Cq9+EDYR080Dulz2bjAixFsAQQLineeqSwll2ireRapiRPegb2PcONqLvvWltGWN
         CTBulSOTyjXF5Or6fNvS8R0iQh3R32Usog7RanWBUL9KJxw60TB8px6P1TlzvMzrbhey
         rplbCYFRVoYmfjqqlvktXbZA0Sfw1/VC2npBjPl+cjqqeZGRKI+9YOz7ZT+mnZWSFNid
         DKCLNLhQ3jg5kdqcA4GoHuz9Jgi6sUV+GGXH386VDzlvyJTx50+9CVoeOGFjfmeG3ZNL
         nrCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763656888; x=1764261688;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOnAUcC9uxAjICDF3N4vcSVSBu4jlzwKhwPQVQw1mKk=;
        b=w/mgcaYlEwHPeMeqY5LgYVXv5IwKEDS66nHexQ8Q/S7GvR0uVD4+h14vH7dZVJRCkq
         1z6P0qsDb6yhLfH/rkRvPeUL8QQuLEphf8cROyk/K8KXK02cdILDP4UVtL9u+5PZdpNV
         GXq4bT96O0jt7lN3SS8Mz6FOn2GTe/p/o5iNTWBHGdbRjiig3qNAqfO/Xj7YIB2cUPDJ
         NlEHecTZ9ZGwy1IGBC6Ppy/2wJcymyhERbueRlfeRh+YHv/+rvBfDWvi4rJbRTkJPUD2
         OYVp+rGi09J3839b7wdItSkxBoGVm5gu+nr5sotyZ64GP452c/40pJQUwFJMzRLk/ZQf
         sO7w==
X-Gm-Message-State: AOJu0YzSTf2vSnvzIdE2yY/SC9ia1D5xBjU+Dsl7VjEPJ+vWu7ci6Xz9
	xkT+Ui5kmVCKYjfev9ol8syheZJ7WbaripADlj9mwlqjuXGYPNKSqcznb7RLQA==
X-Gm-Gg: ASbGncuXcHXcrSUm12Tf3X/7q/Xwbvu3xTw3ZACgqd4WEMSLje4XeEFIwRO5hs9T+2D
	YJcKphAFvFiUtz7XJH4WdjCjwr2dXyOBa7HwlrmxohXQCqlldpDLbkBRhbET2JCxDUBmr+Xl2Tm
	bnnqi5qTQISbhP6wmf5rlKSbsWVRWcHnF0oWFiikBITV9rfRSeMVmSn8+LwuDNE5aZOhnsDgVTe
	iueidYQhdFmAkR2lTXImYPIgLY76xaTFSB54HtUwlfckdib9mEXRS3ah4MNneXDAH2zlIktTM6t
	Mqb+VC1EDJCjeyvqB4/VpXQwsMN5DStlGK5aZAA24YlR35SNGOapFWtDuDXB/rCJZPEA4Mx0GUu
	h6FT0AvjdzMigSW8uaZuZLOXPdVSne5Vy0I/lP61e5hwnoQ+SNEyBQYUjDmnnnrcV+OnZIZyXct
	t7G23NBKkpaLAVEPuTwurqAR2zz38=
X-Google-Smtp-Source: AGHT+IHbWFGlPkfT/0JKxtn3F8rkq9vmSgB1UdKDCmdWb9bI68Tk+0Vf3iK56QGG9XPOssosof8cog==
X-Received: by 2002:ac8:5808:0:b0:4e8:b980:4792 with SMTP id d75a77b69052e-4ee49481d04mr50679811cf.37.1763656887818;
        Thu, 20 Nov 2025 08:41:27 -0800 (PST)
Received: from [172.17.0.2] ([48.214.54.116])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ee48e67fa9sm18506801cf.23.2025.11.20.08.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 08:41:27 -0800 (PST)
Message-ID: <691f44b7.c80a0220.2ad282.5a53@mx.google.com>
Date: Thu, 20 Nov 2025 08:41:27 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1226899162555020841=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dianders@chromium.org
Subject: RE: [v3] Bluetooth: btusb: mediatek: Avoid btusb_mtk_claim_iso_intf() NULL deref
In-Reply-To: <20251120081227.v3.1.I1ae7aebc967e52c7c4be7aa65fbd81736649568a@changeid>
References: <20251120081227.v3.1.I1ae7aebc967e52c7c4be7aa65fbd81736649568a@changeid>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1226899162555020841==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1025911

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.07 seconds
CheckAllWarning               PASS      27.24 seconds
CheckSparse                   PASS      30.60 seconds
BuildKernel32                 PASS      25.01 seconds
TestRunnerSetup               PASS      550.71 seconds
TestRunner_l2cap-tester       PASS      23.65 seconds
TestRunner_iso-tester         PASS      64.88 seconds
TestRunner_bnep-tester        PASS      6.15 seconds
TestRunner_mgmt-tester        FAIL      121.43 seconds
TestRunner_rfcomm-tester      PASS      10.49 seconds
TestRunner_sco-tester         PASS      14.59 seconds
TestRunner_ioctl-tester       PASS      9.74 seconds
TestRunner_mesh-tester        FAIL      11.47 seconds
TestRunner_smp-tester         PASS      8.37 seconds
TestRunner_userchan-tester    PASS      6.42 seconds
IncrementalBuild              PENDING   0.67 seconds

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
Read Exp Feature - Success                           Failed       0.103 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.108 seconds
Mesh - Send cancel - 2                               Timed out    2.001 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1226899162555020841==--
