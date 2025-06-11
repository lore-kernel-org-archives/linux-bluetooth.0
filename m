Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22B327511A
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jun 2025 10:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749638119; cv=none; b=qoDvk0IkYbr4QLnbJQscieor+QJZ6B4bHluRleVR4iFguxAkPTNey5sBBQFUxcQ0jwuUMJJWkpcK17qyVOuugAjZh03R+X8v6xTwpTakNDh8LS8WTiF2MwBREh9hWGSJiGcJrBt57apqtDB0EANuds5pgYEDfKrctRvuaJJFmbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749638119; c=relaxed/simple;
	bh=wXsLvZnk4QNRb84ieZrm7VHEFlJE77XCewpB+uVIBnM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LWmsJ2gUyEi+BAACv9djw4fletDMouDxfeVjMLc0jyPVXaoWTsZanu8aHie3sIDXsbutKCePlaELgcUjML9UXedziTpHMKun25m+Ve+USZI27SFC0zEUGBQY5R6HmHp1FnFdSsvJqtEx8/18Wz2OPXRkpFnnVl5A8zaQjEqaDSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+aSHbzo; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+aSHbzo"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6facf4d8ea8so67619846d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jun 2025 03:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749638116; x=1750242916; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Sydx6soShtuZRk3s61WZ9Nj0yOBiPK9FZsyvjzKQG0U=;
        b=Y+aSHbzo79YukOPWjjmRDft2n5VULY853U40aji51lSyiXCsKSysV5vESw5J7MeaQp
         d2QzY7oEDrTHjeNgeNMXw2ctI1efVOVLlGAfmD0s9MxeLguGJv+jW/kfP1h+jNNLAHrB
         K2/8mNC1K7802bKoKwdV0baffXskcJUCxQKLTrRB7kw/Zxy6nc0z31XnQoE64sDDjCE+
         1/gbmkkAVa54dyaiQ2mye300Mt41Y9XPWceRPek6zq0GR2qNMvc9yxtrE9lZPtWgbcO3
         IcL+VIjpTwwvovOXiFgiymAu2EWAwDM4Gr23j6kqualVCrdQCZQuccaFMnF8MgxdK+R0
         Nj5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749638116; x=1750242916;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sydx6soShtuZRk3s61WZ9Nj0yOBiPK9FZsyvjzKQG0U=;
        b=weUX3cw42DUdPBGfWlht6HWzrJNg8iyQg8y9ocjwq5+JNXqF2nYd/J2iScDFJKkjLl
         O0ohG4T8XsDFw7CxyUiAqi+i4USnGNrTJX79ZPSRTbsS2nHzQ4LLwEIbwq3gScfatZeR
         IxjamJGvHwFErq2pw7walEXCE9TJiBKX7SlTbL7aqxDOVr67dgskUxuGVMy7p8C45+Af
         EmmtKdLADjyjCulcD+aRMc4nYU/uMguFBggX1mbl1NXxHrt7x4YXAzOHq33N8jcdwQ8l
         +mpUiFrhPWogOUHpLtK3f2SgMBGt+2Qq3X0vgq5UXnVoDUANWBhtqs+mVzaEJw3RVeZh
         4JUQ==
X-Gm-Message-State: AOJu0Yx9LsINZrYQAZQAbDeHJa5eJPtp1ECDFE/V+qLd2LZ9tAGw3jKe
	nVv5NakjZ45VR4/Os0NkeHar6ZQXkdF8dIia5QqEMUIJbuAHJ5bZrodSBJ2P+w==
X-Gm-Gg: ASbGncuNPCtj8vRs91D/Ar9XZXM2LYbdsrMCKg1hygDf2ITtNb8+5Y6hPgLUQDcEHL9
	97E0q/qZfK61vZ7fg0u7MuKTWL60G8S0jTs9y1+uBF3V/mHNN+N6TKlPLXYMrQSahp+14vLWdBJ
	LSKVeBU0j220SxPM2tFnc+43H72FB9dzsuT6mPIIZfwa9O7zUe8IY9Jag4v6NND17HzI3KJZb4s
	6Bja8nZ03tskbjxC5bRIT9y92Zgx/ckOfnljCbAlO8rA4JWV/T7Js9rpYr74tDOtfeGfsJJfX4V
	qPgDcKiH20AcZvl4Ch8OB14BuUnDEEB85UhPZdoOBaC0Vgt7g0Vjnbej61htjrdF2KQ=
X-Google-Smtp-Source: AGHT+IHamz0ktLkJcPvGgCCNx6lzUcWpaoY3PrXNW3lokV3TLaVlSbCiFGFI/L6nvuEnwf6wtgIqVw==
X-Received: by 2002:a05:6214:1d2d:b0:6fb:3c9:2d65 with SMTP id 6a1803df08f44-6fb2c31b581mr46427796d6.2.1749638116430;
        Wed, 11 Jun 2025 03:35:16 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.62.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb09b36759sm80229196d6.121.2025.06.11.03.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 03:35:16 -0700 (PDT)
Message-ID: <68495be4.050a0220.1df354.0e7b@mx.google.com>
Date: Wed, 11 Jun 2025 03:35:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3613308244443093900=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jirislaby@kernel.org
Subject: RE: [01/33] tty: introduce and use tty_port_tty_vhangup() helper
In-Reply-To: <20250611100319.186924-2-jirislaby@kernel.org>
References: <20250611100319.186924-2-jirislaby@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3613308244443093900==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=970748

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.19 seconds
SubjectPrefix                 FAIL      0.32 seconds
BuildKernel                   PASS      24.22 seconds
CheckAllWarning               PASS      26.60 seconds
CheckSparse                   PASS      29.80 seconds
BuildKernel32                 PASS      23.93 seconds
TestRunnerSetup               PASS      458.26 seconds
TestRunner_l2cap-tester       PASS      25.11 seconds
TestRunner_iso-tester         FAIL      7.85 seconds
TestRunner_bnep-tester        PASS      5.85 seconds
TestRunner_mgmt-tester        FAIL      132.57 seconds
TestRunner_rfcomm-tester      PASS      9.27 seconds
TestRunner_sco-tester         PASS      14.77 seconds
TestRunner_ioctl-tester       PASS      10.19 seconds
TestRunner_mesh-tester        PASS      7.29 seconds
TestRunner_smp-tester         PASS      8.64 seconds
TestRunner_userchan-tester    PASS      6.27 seconds
IncrementalBuild              PENDING   0.61 seconds

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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.203 seconds
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.210 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3613308244443093900==--
