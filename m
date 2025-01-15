Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2643820CCD1
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jan 2025 11:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736940577; cv=none; b=SNTK+ZrqkQ8FFHxjJ43XNXUXgdI5Fl1VTALNh8TvvlJcq8BZa9pyRKfSon5b7XoL3KuK/XvnpkOo4Zq7m9YRRvtqis6lBQN4vbYr9padVwpRv81naRlUMQYMXfglRY7STHE16W5TsrNZffaKF+xQIRlfIwqjPiTrJ0CAWRzRpd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736940577; c=relaxed/simple;
	bh=4HcPghJ5b+71lvlfQ/d+zP1p3G7IcXUJfc0gIcm0O0g=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QGL8kuLeFmDv27AAKEHvLb7QAIUZYqJ6goCqUqJ51ziAITL60tK+Bw2o9E0nE3fQqa16WyeGlaDK5pxgvcb72qSDktZC+7C8cQ3JZ8gFlh94SxmPn+FzyGalSpAoqXj8qoWjVloueNai/T2Gt+8Sj528JRjF5EYa+MQt5yAi12E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A49G9dBn; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A49G9dBn"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2167141dfa1so13258095ad.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jan 2025 03:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736940575; x=1737545375; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UW1+ruCvcf5oKTaS2CBfy1cPZFz4sb7+gong27ICaC4=;
        b=A49G9dBnh8sOcYUKafCcomnuj+wfq/goOY0oF8IuxLvoNT8PsB5i80RpsWpYlY4ZxG
         on2z633Lahr2M15dFRBM4TSy9a6KUIYaT1LVswppwrTCCrq4T5VjS2teo2ZwdJjaWjwh
         nZ8rQB0I8p/QRE0msc93JyPiIYXGhGwMCKbX8JK5Wr0hVReDmCjjxERFg2JgJ0kRPEDT
         adct8vRTEK7JZj6f2L5EGJJ416LWMBVivnGMQcAXQAqe6QK/tFHA23Ce8DVKDsCSp1ev
         XlnbMlGs2Kqa6O8fl4qrO/OyxveRuuMvtnddtgDb9UXwe5e0bg3pnQjGHsUeFoKMIgxw
         VDlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736940575; x=1737545375;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UW1+ruCvcf5oKTaS2CBfy1cPZFz4sb7+gong27ICaC4=;
        b=jkhylo8bSQPU2NnVCHMmPR400HCg3HBaE4WJKhHjAuLd6fB0MgBWqWz98aSSBka28o
         BPX8EtJ+zZpmQBV8Yci+g4DDA+XcsHf/Kc/4qUGbevnAOoAouWhMf2iCqS5c4w0xQe7i
         buC+kYAjs9D3kHN+x/GDnM0ED5hivIRXrzT3njKWbJkt1BMLFUPGsM/YYwokQmiKlvYm
         /t9RH6wqsO3vq7KEW0GJbnqObKMoZMDuUwJYUfqhkclQqE6Rx/LkCn2Jg2Bl5myf5m8w
         Cza4JNUgMPiXwNKOt9mEQZC4A73LKpJXtvM9dGBzlRaQpqL/WD4EUd1miOUOh6m9QdhS
         e14A==
X-Gm-Message-State: AOJu0YyT5VGSVX+1EsDPa5WDKL3FAsC+a33cDgKmC0eyPtclPFGind6Q
	MEGL4R1UTa+Ckk44b0DMPk85ruMm/I8Bm7Imh0cjCyJBwjS0xgdKGRLhqA==
X-Gm-Gg: ASbGncv4odsxg4izPNWv9e+92r/rtEo0AtAtzdUtuLb/OPqN03CqefE8wFmYmvsNpXA
	GriiJgEZ8D+AlUO2pya9Du6ehDVpoANs+3DalqJ5BrpVJqFPQt2tc4GU+Iy9FRYxleR/iJ1SKeD
	zVC1yEHxcM5nEXUVzOSyCVuo6356m8Ex2Gu8aXk7yJlFtyuT3GAMflZw7TGBBjlChOrCnuP7hBs
	eBfhoPqTUlRBVFnNWIHtEsh0/xkJzBQhrF8WdvvEOianQMOu+nCZycnQh7p6V9h
X-Google-Smtp-Source: AGHT+IGGhEuNg4tiJVJSalP84Wm7ZR101uVPRqv91CJcbKJrSLGJ4jXFxYu6a6r8vEii6NbF6F3gmw==
X-Received: by 2002:a17:902:e943:b0:216:6be9:fd48 with SMTP id d9443c01a7336-21bf029dd40mr43376895ad.3.1736940575054;
        Wed, 15 Jan 2025 03:29:35 -0800 (PST)
Received: from [172.17.0.2] ([20.171.103.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f219e38sm79864115ad.136.2025.01.15.03.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 03:29:34 -0800 (PST)
Message-ID: <67879c1e.170a0220.306f8e.bdab@mx.google.com>
Date: Wed, 15 Jan 2025 03:29:34 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2457590575499853394=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v4,1/2] dt-bindings: net: bluetooth: nxp: Add support to set BD address
In-Reply-To: <20250115104614.2381674-1-neeraj.sanjaykale@nxp.com>
References: <20250115104614.2381674-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2457590575499853394==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=925659

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 FAIL      0.43 seconds
BuildKernel                   PASS      24.30 seconds
CheckAllWarning               PASS      26.13 seconds
CheckSparse                   PASS      29.59 seconds
BuildKernel32                 PASS      25.06 seconds
TestRunnerSetup               PASS      419.74 seconds
TestRunner_l2cap-tester       PASS      21.05 seconds
TestRunner_iso-tester         PASS      38.26 seconds
TestRunner_bnep-tester        PASS      5.92 seconds
TestRunner_mgmt-tester        PASS      121.42 seconds
TestRunner_rfcomm-tester      PASS      7.63 seconds
TestRunner_sco-tester         PASS      9.44 seconds
TestRunner_ioctl-tester       PASS      8.37 seconds
TestRunner_mesh-tester        PASS      5.98 seconds
TestRunner_smp-tester         PASS      10.51 seconds
TestRunner_userchan-tester    PASS      8.25 seconds
IncrementalBuild              PENDING   0.56 seconds

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
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2457590575499853394==--
