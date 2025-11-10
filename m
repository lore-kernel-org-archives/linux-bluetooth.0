Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C6B2D6607
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Nov 2025 06:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762757095; cv=none; b=lNtvPKPY41bUBvRGCCmG77Cq6Dvup1FKwr3mzT4F3QFMm6ILYQW2PwV0omthCY61U+PktCPpHWqqubVUxIT2GXqt4zg7XM/8gck9/x7ewzowkCEDQVa1CZ1jVfbUOSkhZk5wXy03SFT8++8jYDoffNcVVuS13htQA27SIBxpXKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762757095; c=relaxed/simple;
	bh=V4ch60GaCNsySGAH8nvtQs6NiXJ+wgxSToo3maKee0I=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VJ0U0wNBzLZbtwy9L+muBGTizQEs7UnPR439z+rTy7AHKVCPfIfHfVSFBScOvGaRqIgX5FBovvY8b2jZLmnqcNeeFgj+oHqrmmzhVLnXS45R7H/6kguLilm5d+cmIzbhcNqKBeidJsf/KEiSZtGlZDbEuRbuOu2tTCFsiyqSwuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5nA6k+T; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5nA6k+T"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-9486354dcb2so106355439f.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 09 Nov 2025 22:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762757092; x=1763361892; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KG1G6OJ7FjFvYpOJqXHXrL21eekiQ6VLcpZp1hX3oLs=;
        b=D5nA6k+TgvVyQbucC4iTir2h0/VXJRHdO3s5ltwZGj207VSHTlUyTJiCw8USQz5r83
         AgvtYr+wGnRbV7FGVvKmFcpoU+Vj26rwr6ECtEwPWwZg8Bh5XucI0NEs4ApwAniBnqSc
         BE/RX7bq6wtoYkOU7zXU/0S1dBGeTK45NxijHi2N7wDLlLUcDjokG2dQFSALPnGXswFJ
         hsXsjePUCKnGgqeqII2Cg42jUjrc2GSg4tH1qRq8K8h7frekLuZ1a2dE9p0b6S2abBXP
         QmcPQAbz5f5I/FF7BNu1jjBBxatPIXAdv9O2vmrpKBksNgywATjLTof3G5OnfF4+TxiL
         OwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762757092; x=1763361892;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KG1G6OJ7FjFvYpOJqXHXrL21eekiQ6VLcpZp1hX3oLs=;
        b=LR1J9BfFNOsp0tgPWN3RQJwtOOCBGMMn/K/MJern20uirUvhlk3GqbKexx6z01D37G
         dK7hkROy/ZKvxrRdryhdCDSNtlcnnCHJ18AUBgyCqxss6kwVoj+4QEFgWQc5IQ/v0Iic
         h+SFhI1aBuVpyn6NehOoH/G5n/67vcSG/oiCn4Q0mnl9h8KjuuXr9jdAwEs2i7B2pSbp
         2JX4jrvzGIJCk12/aoGg+XCDTTrhqy2yOINWTMq+P5xDVoidnk3VvWRHvX8ePggRepm7
         pkeWmdpe6HxqnnZRxvYeTwtR3ozsxjZaHIonrhHUrH/aGqEnfgkr8NZ46FQ8eWm9r+FJ
         HqNw==
X-Gm-Message-State: AOJu0YyAGdKt6WQRzEViqr2XwJzkqbGkgGHsOcXyHT3BWlIVqBsieMDy
	EObL9Py5aI9JuqCkSG9GU2RlXXBScilUXIg2yPmSkEhfIDA/5A0bYvjZgwsqEw==
X-Gm-Gg: ASbGncs+0yozgiyUzzjhH2O5ikDFjhzUv9NcfilB6YT0JXWshAN4vo2N8GVRR6MskHS
	XdLBg++hAHtqfGqPpimyHyCOHukQ/8aGEAigmmKtQux/2yTfqkKdi7y4BTPgSvhSIGXLEZ7vn9t
	tgbeNElhitJXEj2y2k6u0Kd4gD65w1ScW/G9w5C+AEgzvtjBGBsGe3wuJJmwVbqc5oUMh9j0ryk
	jl2+kHEMcMUQZnHC6yH0FVlYO45+YfgCPLfN92k5Ofo98iwTkjeLKjLugUAyTSi3d3XgKJAkqgl
	01+Nl9SG0dIDkISgsnn6uRkl/Na2yV5BT1cuQsn9wRYmPZhCKp698+uouq/KE0XbfZRe2oP0EUn
	QZBqh7x7l0Ib5YA84UZIgzt3l8IY1A3c/2DcfFHbqQrVpj+6C1C5ncKPwwm2jvlpl1UFHOw5yiM
	cPGZgkcT4=
X-Google-Smtp-Source: AGHT+IHyVTFP4GqBeflW5hzFWzP+jonyjOxofOjSytaE0gBw9i1ypUcau+fspkgblOHXIPg07u2Uew==
X-Received: by 2002:a05:6e02:180d:b0:433:306e:2c83 with SMTP id e9e14a558f8ab-43367e6744dmr82122965ab.28.1762757092583;
        Sun, 09 Nov 2025 22:44:52 -0800 (PST)
Received: from [172.17.0.2] ([135.232.201.42])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-433754f1e7dsm21087325ab.11.2025.11.09.22.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 22:44:52 -0800 (PST)
Message-ID: <691189e4.920a0220.125fe8.29fb@mx.google.com>
Date: Sun, 09 Nov 2025 22:44:52 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3145060970549948571=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, wei.deng@oss.qualcomm.com
Subject: RE: arm64: dts: qcom: lemans-evk: Enable Bluetooth support
In-Reply-To: <20251110055709.319587-1-wei.deng@oss.qualcomm.com>
References: <20251110055709.319587-1-wei.deng@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3145060970549948571==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1021398

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.22 seconds
SubjectPrefix                 FAIL      0.32 seconds
BuildKernel                   PASS      25.28 seconds
CheckAllWarning               PASS      28.49 seconds
CheckSparse                   PASS      30.76 seconds
BuildKernel32                 PASS      24.57 seconds
TestRunnerSetup               PASS      493.78 seconds
TestRunner_l2cap-tester       PASS      23.77 seconds
TestRunner_iso-tester         PASS      65.94 seconds
TestRunner_bnep-tester        PASS      6.87 seconds
TestRunner_mgmt-tester        FAIL      116.88 seconds
TestRunner_rfcomm-tester      PASS      9.15 seconds
TestRunner_sco-tester         PASS      14.29 seconds
TestRunner_ioctl-tester       PASS      9.79 seconds
TestRunner_mesh-tester        FAIL      11.44 seconds
TestRunner_smp-tester         PASS      8.49 seconds
TestRunner_userchan-tester    PASS      6.50 seconds
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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 487 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.105 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.964 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3145060970549948571==--
