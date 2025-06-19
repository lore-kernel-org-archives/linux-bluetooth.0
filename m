Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478C223C4FC
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 11:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750334296; cv=none; b=E6kquFv7gdpiQuglN15abMDr2WDwUKAQSlQt0Q6xiSuWMUnvzaDuXP5NPV6ziuIYm3byV8YyKG9poTnSxhHrwGwKnqU51XTFRbpGR120yzVYIL6wA/edzXl6TmWunHyLAg8RHUrxPOSIonbOmcPm0xKDuDm8O2UHkEG14goFzc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750334296; c=relaxed/simple;
	bh=bGLtgR5sSg2vira776HYwqtu62RL59yc6hUkdHrxr0Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=I5/JClgHqHTZ1hPOcJQwlclm/khAKeINUgFgvePOxenu9YaoFgWSrKYLMAzLQ48azgePdtVacy1RzxurRU+y+2loCyACNKtichfRLUzZZRCXrg5fTdHUH0LzqLzQ0+BdRqHaz0zpyPe/ZzaGXyqkCXBjaonCFPpEdoas8EvibfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5ba26ol; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5ba26ol"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4a44b0ed780so7958611cf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 04:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750334294; x=1750939094; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5gZTGsFL0KQMn0HW6gK71pRHsVP8OkUdhDzdKT04UOA=;
        b=E5ba26olm8MSjG9w8bD+zVRAjfyKgQYKMX9H6ZMu8qMUdUyx+6p2YA9x7oIKhJB0WT
         uuXYndtz4c06GszhFfMB7wm9EpxdZdjb01tsnFTSA5//C5aAc1y4nZNwdD4d0sL6RlLR
         tM4+1P159MZ6elT/6jk4nn0+wD4/8KDHduMrzNwFDECtasQdBij8X7VmSRGcGT3KiN2G
         0H8cJsRfjlTSJqEL3/Gmnsb6h08lcFrmT17yGI+PXfCdx6jUVA88xObTy+RJzFFT7KrU
         mKNdh+F0Aq4fx3su9G2EPlXEDEClFJ7yE8Phd7S20wTw2HZxpl9F66PnskZOGUo6fLdf
         +ssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750334294; x=1750939094;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5gZTGsFL0KQMn0HW6gK71pRHsVP8OkUdhDzdKT04UOA=;
        b=D40WBxxOThjap2Wi426FoUANzvloI6a9R8XkRqFU0b8hQxZA+mjuW2/Gd88IeMxm0g
         Odsk2U1boSNG6gESSTrzYk05pAwJHBQHsYSFcGPSiHmZp2y/TNsD2JVJ5uYazp78AKld
         HygBmIfuHsPVOlzyxEKsRBegseL1xvz9bAodwO/pQnpMU+WYmg9d7PwINSpLrqVv2FGm
         KqPuJGh/9fk13WDrVl70HrfofvnRnLgjUEP2kXxlSpKfkCRp/0FOoWSUI3+wm5eN2NI0
         BU9mO5Ku2bdV98dDpVGLAC90z91DPFy2vVgbv0hefqPBofPWZ0j22ESWeWb1Nd5kg484
         AEGw==
X-Gm-Message-State: AOJu0Yzo57ogYKpL6ZhTxHqqR80gBUNysGw3V54FKKx3TJ/1GjuVNEgG
	977A7q82ASB0nZPzCjJrPmwLsdqpGS7XjaWws0kDhApxjhdQCd44/8pnVj7bwA==
X-Gm-Gg: ASbGncvFBZf5B2XBlOe+mh0G0pqd6qkCpD2owJ/ooRrqdEQvpK49t6wpQ9kMRmGpMVA
	oGZPyWeP6d8vITJBZ4qYkr3xej5Ue+BI2fEIf3fQUYeQeY4CO3T92G/6CaMu1Gj7/6/9PQr5yv9
	ABVvZEXQD9xczVkVgCUwEB88MUkhc5up2ZewitRNCTVE/W96uTPW/ORGRBe20ZJXZqDusbCFm1Q
	8V7HQQWx26mT31wSr1fE3Sdueibl1e3rb+gTw5+CvGXuOQ9oKm6jsXhl4WzTnsjFpdaYUHAAmx1
	A41s3WZ4jJPd+zRtizK+JPJpdrZ1AIQ9oP8MlrozHLG99GHnfFGyRAMgTN/7at7Jn46knw==
X-Google-Smtp-Source: AGHT+IFhmIgpmX/Uhk956eJiAmoDGS5Onc2GA2OXihDw8QBqjHLLiE0VtVy4xo12It+E9NWjLgu0zg==
X-Received: by 2002:a05:622a:1993:b0:497:6a94:dba0 with SMTP id d75a77b69052e-4a73c5d0165mr288380711cf.25.1750334293774;
        Thu, 19 Jun 2025 04:58:13 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.230.34])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8edbc09sm872919885a.92.2025.06.19.04.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 04:58:13 -0700 (PDT)
Message-ID: <6853fb55.050a0220.b95d3.48c5@mx.google.com>
Date: Thu, 19 Jun 2025 04:58:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5669979186175057375=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v4,1/2] dt-bindings: net: bluetooth: nxp: Add support for 4M baudrate
In-Reply-To: <20250619111629.30098-1-neeraj.sanjaykale@nxp.com>
References: <20250619111629.30098-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5669979186175057375==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=973804

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 FAIL      0.45 seconds
BuildKernel                   PASS      24.21 seconds
CheckAllWarning               PASS      26.75 seconds
CheckSparse                   PASS      30.69 seconds
BuildKernel32                 PASS      24.55 seconds
TestRunnerSetup               PASS      460.11 seconds
TestRunner_l2cap-tester       PASS      25.22 seconds
TestRunner_iso-tester         PASS      38.87 seconds
TestRunner_bnep-tester        PASS      5.86 seconds
TestRunner_mgmt-tester        FAIL      130.30 seconds
TestRunner_rfcomm-tester      PASS      9.18 seconds
TestRunner_sco-tester         PASS      15.13 seconds
TestRunner_ioctl-tester       PASS      10.05 seconds
TestRunner_mesh-tester        PASS      7.48 seconds
TestRunner_smp-tester         PASS      8.48 seconds
TestRunner_userchan-tester    PASS      6.07 seconds
IncrementalBuild              PENDING   0.46 seconds

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
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.221 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5669979186175057375==--
