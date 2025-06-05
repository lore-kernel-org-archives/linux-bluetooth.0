Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BD186347
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Jun 2025 16:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749139325; cv=none; b=XQKvGhJMyUJDRfHgLQzyuPJ/es9a8WDArcDf1uXUdZdhkyOYiLn9hCmOplvOkCFXx+8Oh2oaZlPNu3eaeB/s+TtiHT3RJJr0rR/ncRK0WE+L5hL3BkniGHvK4Act4oTeviYYQL5iibfK2EeOXzPJl+PcEXG0Iqwk9Id1ervFGzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749139325; c=relaxed/simple;
	bh=OcYXZIIxG3r9KHvi99XhE+dEWB+SGx4j8mqQqMCCtkw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GYGyVo8fUMGlGOGJXlIDDQqrVLQ7AmzZ/uakTG6F+m47oIrM/49p4obLrptWx76R2lpMGB/Gu2uQpX1OmTDwXYDSCNoOZMKNJwuI1vzdRq4BizOwqqy94cIn+Y/XlacgNmhO23DD/a2t76edqRDvz8/H2P55cRErfVy2VEEMIt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0dYETN5; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0dYETN5"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7d09a17d2f7so114807085a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Jun 2025 09:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749139322; x=1749744122; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wvvok4cyX4J7cBaxL4AyCdP0vghEPVD9GOEjg+EVb1E=;
        b=j0dYETN5eFXqzN6b8RPbV3HFk4yULzcxsHl1RGjeCu6WNCJg35Xm3xu/oRHN9qwk7e
         HctRFpPSXN2OoJ16A4nHR3OqWXa3p1jr5tJ0P1qEpxNXimCaHeXuG4W/1MI3z6DKHEBV
         HQUpi10efWJ/VoubNhuYJAOFQYiJ53DcjLsC3vtZZtR/wPo6BzCoWBUadEOTyTsCsKmQ
         sFJlCZkJaH4MGEICzJcG99fU4JuxQxlVtOUDhcCRXsMGj+YESukt74no9SILPaMR+mDS
         m3cMlFggXEDN6ZnN2flamHRtCwwi9KuVra4QiVpgpGQVoT36FOha4c9ZALeDm7LZ2ntE
         A46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749139322; x=1749744122;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wvvok4cyX4J7cBaxL4AyCdP0vghEPVD9GOEjg+EVb1E=;
        b=IH/VY4SNpwviFbvSQvYYqbk16OhVbokIgFPXv+ntXwnTnwYEr0epP28RpkavfJtiCX
         DiBGHO+KFB9R3KicGlpfQHp37yfV/+sVCa3tdLOmEMF8x/r704nVNi8Nqa+zahdcKS58
         Lb7F1Sj9FwgPeRyN/gzOnIJDWzBxIPavMcxBAWjqZwcM7gEyL/pXJ7PUa9Vpd7HczqwA
         96x0HpDA+Heo+CXwzUTt27gHCK0qmA+4Tp+URSGHQ/qSHGcSODnRFP35slSD8yR8whaB
         YF414ZuekDsRroqVmxKrPmRZxwvI/MnUi2ZjpPqft6pBSJpRwT3pfm6RGtjSHfRDWCqI
         8Idw==
X-Gm-Message-State: AOJu0YzKpFDkl7zlUWrmHSNI1vDiCI2SuMI9g+cc08UY2QYvrWEZZ7QL
	shdTbJildCIJ2lMXOnWZ9SskB1FskfFgMmYRc2aOYsGJLqRWhPSXvqyvU08slg==
X-Gm-Gg: ASbGncv4Aa3x1DaOGukoUAMNs2pBgbUtftP6mvtJqn/b3a3i729CYOEIMzhfJzvNHUM
	uHJVOKg6spGkcQX4umIpbQOFPQQ/pC+SKbk65k78LBsCnKr8jc//qQGnRiSmk63rg1JfoIcizUF
	s3ujdzrsPDG1apyGcmhoNSoia9vvqUy9Fs9XQbuUaTRsMOUwVdztRc4ysTJIlNgtNUtcpgPiq5n
	Pcx7SxMfEJLfk5WuB2SPXQYTz0NrJjqizJZQPFjNMtXAKCMxdBPKQnlKZK4316pyel/g3qDU4Uu
	Yb39V4QkK4B9/1IEuipHFOZl7o0FZUayb2jAKSfTeR1UhxCflWy8jekVs3w=
X-Google-Smtp-Source: AGHT+IFPWq+cZ2yR6tBtIO7L/cfGSELmz17dMbHyfm4uxQrHHVZYmNaPOx47YQEZjgl2lWHolXzekQ==
X-Received: by 2002:a05:620a:6883:b0:7cd:ba:7b63 with SMTP id af79cd13be357-7d2298c5bb7mr17067485a.45.1749139322109;
        Thu, 05 Jun 2025 09:02:02 -0700 (PDT)
Received: from [172.17.0.2] ([128.85.161.173])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d09a1a78d7sm1273240485a.101.2025.06.05.09.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 09:02:01 -0700 (PDT)
Message-ID: <6841bf79.050a0220.278b34.7288@mx.google.com>
Date: Thu, 05 Jun 2025 09:02:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4547221996640489340=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1,1/2] Bluetooth: Fix NULL pointer deference on eir_get_service_data
In-Reply-To: <20250605152316.807664-1-luiz.dentz@gmail.com>
References: <20250605152316.807664-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4547221996640489340==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=968964

---Test result---

Test Summary:
CheckPatch                    PENDING   0.23 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 PASS      0.23 seconds
BuildKernel                   PASS      24.37 seconds
CheckAllWarning               PASS      26.93 seconds
CheckSparse                   PASS      30.79 seconds
BuildKernel32                 PASS      24.99 seconds
TestRunnerSetup               PASS      461.11 seconds
TestRunner_l2cap-tester       PASS      25.14 seconds
TestRunner_iso-tester         PASS      37.97 seconds
TestRunner_bnep-tester        PASS      5.90 seconds
TestRunner_mgmt-tester        FAIL      132.98 seconds
TestRunner_rfcomm-tester      PASS      9.30 seconds
TestRunner_sco-tester         PASS      14.85 seconds
TestRunner_ioctl-tester       PASS      9.99 seconds
TestRunner_mesh-tester        PASS      7.47 seconds
TestRunner_smp-tester         PASS      8.53 seconds
TestRunner_userchan-tester    PASS      6.14 seconds
IncrementalBuild              PENDING   0.63 seconds

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
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.227 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4547221996640489340==--
