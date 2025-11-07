Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58244214A8B
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Nov 2025 06:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762495335; cv=none; b=BTAv8yQnwTwtIUtf8+ucDWKQIHoyHELnS+z87JAFx+AbizOOnpk38ZdikxZqvkfgWONX+fpuayv4gLOx2He60eNiqSOLPSF4QpEg4HnYTdMTWTDpaA8DSNa7R3Jyrf496nyHvypEMTz5brfXepxFKCDz7blo2CMZASC3tI9KWYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762495335; c=relaxed/simple;
	bh=ZEv27SiSPY57E2/8jSqFF5ZjfrrjE2sFaGvwk83uU3s=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jdsUoVKbHWqQVnTMTiODVOblWBXRZwmNf1T9Pb8pqJ/9Q1u6H2FTs44azVd9ljp4VAzY7mGf1o/HumGpxeWODj6Zko5GDrWshwYPLMFSB0XPwgLY5rrDqddygnse2ww9imR+YRnyOg0zzpjh8XVzoh65uKUt5yCjfHi4JiNvkF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RkoJ//oi; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkoJ//oi"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4e8a25d96ecso5735871cf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Nov 2025 22:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762495333; x=1763100133; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LRGV1QZGUwefs5PbXJVhsueSJp/zDf5lSyiSBFeyCi0=;
        b=RkoJ//oiuDyeX9Wb2nA5r8BlHfK6N5ctcKvh57jgFlvMeagUuJr0zFZ98bjPghgs0w
         Ih4NURT+rkeFceHgkCksDflWSymuWb5xQh7Xm5xbv0gUL6fuIc8re2SZbhsirA+6S2zS
         9AueBEItquTOhJGfQatuAB3uaU4Ci+yo0G0TiAD4FueaR80N03WhUiB8FQ34Fka4TOde
         xuwURNyafDhjo+gXqah18Uz2CtrgkpgkY/TfTxqjJ7vwNFzbwyB9AGSSiDXXlcMTqz/Z
         NaI8SSCUVs6OcRuoea+s+c0jHKmO/2VkD3PUsSvjHvAtZI71iMD9571xt4/X/5M8e7yN
         pD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762495333; x=1763100133;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRGV1QZGUwefs5PbXJVhsueSJp/zDf5lSyiSBFeyCi0=;
        b=TGO9jAV8/DXgmixI49fLgsMJg7nV1/Lyob4MBOuRh2y6do2GkKihRe1Lffcad1sWaM
         pJJM0hWWoX+9RnoEedzt37Tj57xLXs5BKcshrLpPwplhMinDWKPMBliuiMkfzPvrx8cd
         c+4cLvHx2+k3O4ijZxHlXQDgqbgx2EaqYql+3R9b/ymsM9z+Ev6gC7NcVGIspH+KXPcy
         SXVK5eIvnSlMgS4F5SyTqJfIApOI+KeXYkEjMsY650fLs21BtyPPK4CgoHmSuMR6jDMm
         VxEMjz0JF/YBZBY3nh1uP2S29YkoACjD+oDDOUKykAm6Q9ZSDEwHs2yL6GCCteHKRnTB
         ymeQ==
X-Gm-Message-State: AOJu0YwGwGMObvLMu8dlFcf/13ZH1sKPpvUZoVQWmg6Yj1pZob+duW14
	QUeD3E/ZYlIMb/sy7lZsW5+iMhulpEt6prvZOSSdhuAQ0d5MkhVUmDlMZr4w1w==
X-Gm-Gg: ASbGncuL0CdkE6pjI2DJk3VlzwH7fmY5V9YXhdQYKacAy2kLuz4C+SvdGfeg49MT/G+
	1tJGqNxqYr+0Ng6TNk0vBrvIztexCzZheMqZgeMxvrlgazKxdEIuGKiv52HOYS8PufC0uj/HC9u
	8hyvLLhzCt370jKmImAiW37I4mnGXyAGJNEWNAhDIeanVhq5NXK+MavO7+Vh8hnH2ndwEObkFxD
	dOdt3km6Cmayv0AepsLnN4CNFvDkB14C7rBh3jY8i0kmzhWruVgRF9a/eTVA7oVu/1Pe9BEFfwE
	7vYIi2oKiI6aW1M6aMUFnGrOVFakoaE2eVatVVW8oS5GvVn/Uxh4zuHK2KYSbBLOauYu8UAc0Ft
	vFRgebHUd+VY1qau5IsGPJ7CeSBJIf3Qb2t942KtyoRHvyxoP8/rjzlTAczKUWHk+p+jPMnEkp8
	oT+UAmxQ==
X-Google-Smtp-Source: AGHT+IHFOhfCLEHYo80nhAgIX6gi9pC1Nh6knW9BGFE2/HvsUexFmCBQy+Ni1a62cKRmnV01hJd6uA==
X-Received: by 2002:ac8:7d96:0:b0:4ed:2164:5018 with SMTP id d75a77b69052e-4ed94aa1c52mr20629761cf.80.1762495332966;
        Thu, 06 Nov 2025 22:02:12 -0800 (PST)
Received: from [172.17.0.2] ([4.227.173.116])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ed94a4123csm10351301cf.4.2025.11.06.22.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 22:02:12 -0800 (PST)
Message-ID: <690d8b64.c80a0220.3987a5.2150@mx.google.com>
Date: Thu, 06 Nov 2025 22:02:12 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8205915906103377564=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chethan.tumkur.narayan@intel.com
Subject: RE: [v2] Bluetooth: btintel_pcie: Introduce HCI Driver protocol
In-Reply-To: <20251107054011.219938-1-chethan.tumkur.narayan@intel.com>
References: <20251107054011.219938-1-chethan.tumkur.narayan@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8205915906103377564==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1020747

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.73 seconds
CheckAllWarning               PASS      27.29 seconds
CheckSparse                   PASS      30.82 seconds
BuildKernel32                 PASS      24.74 seconds
TestRunnerSetup               PASS      494.09 seconds
TestRunner_l2cap-tester       PASS      23.50 seconds
TestRunner_iso-tester         PASS      70.41 seconds
TestRunner_bnep-tester        PASS      6.12 seconds
TestRunner_mgmt-tester        FAIL      115.98 seconds
TestRunner_rfcomm-tester      PASS      9.23 seconds
TestRunner_sco-tester         PASS      16.37 seconds
TestRunner_ioctl-tester       PASS      9.91 seconds
TestRunner_mesh-tester        FAIL      11.45 seconds
TestRunner_smp-tester         PASS      8.36 seconds
TestRunner_userchan-tester    PASS      6.47 seconds
IncrementalBuild              PENDING   0.60 seconds

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
Total: 492, Passed: 487 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.093 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.062 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8205915906103377564==--
