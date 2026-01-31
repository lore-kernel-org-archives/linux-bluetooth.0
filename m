Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com [209.85.160.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7598BA34
	for <linux-bluetooth@vger.kernel.org>; Sat, 31 Jan 2026 03:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769831861; cv=none; b=L17YCucRKPGIBIQjeZlFYgClympCsNr/NMx7mKKyb5WBSNsa1xmUyntap2CfNagBjkY+xYsKuhS5pA7mzK2RBTjrjQV4vqj9bkoI5mnCl8N0swpyWNo4HF+ApnXChQ8fXbVFv7KmWWTX2QUGKB0XOxb7GMlRi4CdqGcrlmSaB1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769831861; c=relaxed/simple;
	bh=4Oy+E1eJiQww6cN/1dPmMM+e1BCwPi94mJrWp8HZx8I=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=sGFDX4fyvHrp1lswzTYYc1r5R58sQ6cO0t7SBWq5NxJVzhvsjttyC4IJJShd0/EMc+ai/aRGFKV1veuumLnpu9TSIdjnaYi2GTbYCwE9uXJzYU6vCQTms/M19Xdv59tMajiCLW46s1z3pD/hLYD3TDtZBifg3s4F9T9hSEp2Us4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2ifux5z; arc=none smtp.client-ip=209.85.160.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2ifux5z"
Received: by mail-qt1-f195.google.com with SMTP id d75a77b69052e-501488a12cbso32155021cf.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 19:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769831858; x=1770436658; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tFxAhrLNgTCh+ibkmWt7QT5BefyL3rnJuUyEty7zstM=;
        b=d2ifux5zEKJNAtgBH6Cq4uPdF7QWOv7EUtgH+5vNvcbuYk4A6knElY4MVbpWama3Q1
         8kz4NYEuT/Oydtz25dfHai0G4OwXl5+Or7lY3O1rDfOrPgggxtdXfUtMpWwggbKPRXrB
         Ol2ZcYPGBYBusg2W0hK1cq1eURJH0C02473rNX+bI1Pf3AlRsI480LnqGtOcKmtaD11l
         8IC1DjszTloMIPgaTLsEltDupL6JH24HFJEsqHotNlvLTGecGm9ATbIfKKT7elkJZypb
         F2tDgszp7HPicDIhzCSRmWu23b/arapOxgBbbZZXalnbsGCGkupkU1pyjVuETD+r6+LO
         PnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769831858; x=1770436658;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tFxAhrLNgTCh+ibkmWt7QT5BefyL3rnJuUyEty7zstM=;
        b=CGROZyWgT1325ID2ZiNc8FxcSrXIjnXZnUvBbipLTYc7V+dnchOacbRZ9+h48hZoqs
         fm3IULJ7ZxWPgRD+CXfzESz602SHO7oEhekTLkFDSdjMPpa2x7GKul38X5/rHDY68KK7
         iTJN4kgdYTlna/8JmdndomUt9YG6IfSB0TYRZYigF1mGxNvOGcFE8vkyeDFAqlS3V2GA
         0yoay9FypS4XdNHlqQGCO1Uygnz7JSgndMciLpokk2S1EaEZqBSCwxSBoQxbSSdCuQ1E
         XYbYQjXOfEG9z0JoWAFUgJx5GsTSOvlKxyv8MGdKdbhzFD0pX5LTVuHkUEvzRHJHtlKT
         lP+w==
X-Gm-Message-State: AOJu0YwTkyGPxBcRL+zJpd9dv7BYflFZTTZobzn1/1vJ29gHAbMxgy+P
	smoro8UazVg02ea661gJKd9tZM7+kMUk5yUY4c1ZGsfyNtF1HjtquUN4gJgGr6k1
X-Gm-Gg: AZuq6aKvD4JW7qBsIiJHxcp7QhHMqF5huFmrNWZ4RrEnumxdq7/RCPVtTG1YEo7uUJN
	a8D4C4H5MMbnyWbUs/uMeCSuR/7WcmWI4+KXqPkgswpO8/wr+NbUcKy2/VLdnJah2jo/qSRe+40
	MnMGKlT8HcFIkCCB4rEL6hLodrzH9q6vRpaY4Me2FyZ92+tmugXRZjYHEQd1bT9LUFEkrZzcA9V
	mSIb7ktneBD58+vZ/3yYg01d3qRBgqre6Jt4wkrEPZVaV2FPxy5+211lg7uovDEFTJW9ZGjD3QC
	EzSs+0tpTdKVO97qncPDsozputH5T0qi2BrdsWBAZsuSoKmG6sBc5xMtNsCmD9CU/fxBv8Q8Ik9
	fpFaF+BQ/4zVqpxDzllFujudUMkSI3JKvrFZZYpOrNLcUoKpKtNVMVNXsKQOLeGzPt7h2rEFoVz
	qa5TF77uW6eo8ea2XMgA==
X-Received: by 2002:a05:622a:1207:b0:4f1:e0c7:7892 with SMTP id d75a77b69052e-505d2178205mr70799321cf.21.1769831858497;
        Fri, 30 Jan 2026 19:57:38 -0800 (PST)
Received: from [172.17.0.2] ([135.232.232.32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5033746eec5sm69288481cf.9.2026.01.30.19.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 19:57:38 -0800 (PST)
Message-ID: <697d7db2.c80a0220.12ed23.d82e@mx.google.com>
Date: Fri, 30 Jan 2026 19:57:38 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0533372471485851129=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, enelsonmoore@gmail.com
Subject: RE: bluetooth: btrsi: remove unnecessary module_init/exit functions
In-Reply-To: <20260131020032.45838-1-enelsonmoore@gmail.com>
References: <20260131020032.45838-1-enelsonmoore@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0533372471485851129==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1049197

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 FAIL      0.35 seconds
BuildKernel                   PASS      24.15 seconds
CheckAllWarning               PASS      26.49 seconds
CheckSparse                   PASS      29.88 seconds
BuildKernel32                 PASS      23.53 seconds
TestRunnerSetup               PASS      522.56 seconds
TestRunner_l2cap-tester       PASS      26.68 seconds
TestRunner_iso-tester         PASS      71.85 seconds
TestRunner_bnep-tester        PASS      5.90 seconds
TestRunner_mgmt-tester        FAIL      111.96 seconds
TestRunner_rfcomm-tester      PASS      8.98 seconds
TestRunner_sco-tester         FAIL      13.63 seconds
TestRunner_ioctl-tester       PASS      12.18 seconds
TestRunner_mesh-tester        FAIL      11.37 seconds
TestRunner_smp-tester         PASS      8.20 seconds
TestRunner_userchan-tester    PASS      6.38 seconds
IncrementalBuild              PENDING   0.70 seconds

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
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.099 seconds
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
Mesh - Send cancel - 1                               Timed out    2.161 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0533372471485851129==--
