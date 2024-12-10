Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C96C181B8D
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Dec 2024 20:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733862850; cv=none; b=qIAhnCFxkrD72LRnEV97TEM9fOJV6pyweNxCeG1VsO4rbDZ9IoIh+jcRY8k5VcefsFafwzcJVH9Cv5mO512aM/HzBsSzglHy55APBZcO0MznSyyRzeD7U9/qvaV8C4NBAjZctUPZh2rEush177CmgbBI6OFH77Ergkki3om/eJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733862850; c=relaxed/simple;
	bh=AnVJj6kbFbWLYsXspTDdqeDmG/mwQv28XiRxUQWkRS0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YNkcJSXgPeSwKo4qOwsEOdCvsqPCE6LaChg8VpcWPUJQHe0LcGB9B3iJP8GFCqx2iiVYzBbV4Qxw8f63HPqNY/UuIHK5DTcUXOnipN3/OiHN16vOtCjEgqy6EFXMN26UVG6/ofXY1fddrQgtzbBY0Qrj7BnnaGo0qZ8PTGtBvDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mviNXyeF; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mviNXyeF"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-467838e75ffso8946881cf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Dec 2024 12:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733862848; x=1734467648; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cLMuxTdmFm4nM0FqrrWImyS8LvWMJ7+VAsxUCHIlftE=;
        b=mviNXyeF+DCppsPN9qD3ogNLuqsVUgejK4vUUewQUIWvF0Z/fkzLYbgVhHk1jX/+Fm
         L4tILbCJiXpHnN6WBjhMov8sbibOmDDJ/+XQth6vS1ZIS09SxULCYTO5OU1R6jpnRiLt
         1JgS6w8DZoYrcwjfBwFNT4TKgc+sl3Egh8buIUo92+DSB7AiGn7wBtguO7vij5ZD3For
         j4Mnpy/sKwwHqOhyDoKoL4+I8ueDbEUn3LjmI9lZOoMpG8Ul5y1AV27Ah+s1D4pj+PDl
         sltZ+wPKSx+x+BPIB8LkjcHmtEHrGRHIl1bNtUb5Yx5B2CcVRt7vqTTeN26hsXCmqqF8
         msyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733862848; x=1734467648;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cLMuxTdmFm4nM0FqrrWImyS8LvWMJ7+VAsxUCHIlftE=;
        b=XLKqaQbazNLjFrQ6UgONZYTyO/kx3TQX1woAjH6pK4jBbKP87XqOrSwPfiEJw7w3nl
         mvFpdIiI6lLrK8JlJjY3Z2VMbfFt7LcmvQz350w09FkNweJIJxlqISkIi/NclTBABGIT
         AUlmZ9Rp3wClTiEW1PfUJlWls0FAQ86+qodD4XMK9p4vo8DXloM/OyMhTdqS0bVR5QvL
         Rk8Igobd9FRCkIr6aGph5ujdyX6++aEmh1ieRPZQJwUIsGlIhSp2Fy/noWZs4+RDdFNN
         dMuu4Is0cLWKLO3z+MSsXfA27xXgTp6NpFHGhfPgtyP1zqcytOFFYMnLc89E1HzTl9Ht
         SXjw==
X-Gm-Message-State: AOJu0Yyfy3sVD+kkV0Szt+rMxSCM3ZNs0CKLv16vLpDiexevKQB7XM0A
	Bl7Thv8JdsHFH4M9KxZlVpcdmoykp5jJGUpBo6E/EdTZRBF7Qnp5zFAN+w==
X-Gm-Gg: ASbGncuD+ELEUh3+ek/ppkwZi1vUXHNKyGvqqLBJyUR60S1LaqoVy7D3JYT+p/UDwuh
	D+r8Lr7u99zfLz46NaMTl2gW4FNRuF1cJ8q6wOOLdOXTYjggeiBCjohkPGGTahy1WlgwrIyENGO
	jCyKkmHTbwm8nibHZamcil19YXh+Ue5ojLHd7XRmhQnBK1Hd7bdPBZ1Zb/Zk3de9sQmyLefJ5Ao
	dp7riHnUuBXHsGCCUiHIc0gf/R5U7R0p8D1DmwVGC4yQEY6/i6I/NnSiYE2
X-Google-Smtp-Source: AGHT+IEftpiXF1b/vKgwuDOvt5Vm7hcYtWq6IcOcL/HlmGQsjWBMh6PRizNU0/+OhtSqlV/GYtV+Hg==
X-Received: by 2002:ac8:5947:0:b0:467:83f1:71dc with SMTP id d75a77b69052e-46789391c03mr4888891cf.54.1733862847990;
        Tue, 10 Dec 2024 12:34:07 -0800 (PST)
Received: from [172.17.0.2] ([20.161.78.229])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467594e1d2fsm32474161cf.55.2024.12.10.12.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 12:34:06 -0800 (PST)
Message-ID: <6758a5be.c80a0220.299b03.cf29@mx.google.com>
Date: Tue, 10 Dec 2024 12:34:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1579185104856657634=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, cascardo@igalia.com
Subject: RE: [Resend] Bluetooth: btmtk: avoid UAF in btmtk_process_coredump
In-Reply-To: <Z1iYKvmenw81i1UG@quatroqueijos.cascardo.eti.br>
References: <Z1iYKvmenw81i1UG@quatroqueijos.cascardo.eti.br>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1579185104856657634==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=916487

---Test result---

Test Summary:
CheckPatch                    PENDING   0.24 seconds
GitLint                       PENDING   0.21 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      25.57 seconds
CheckAllWarning               PASS      27.55 seconds
CheckSparse                   PASS      31.19 seconds
BuildKernel32                 PASS      24.98 seconds
TestRunnerSetup               PASS      440.43 seconds
TestRunner_l2cap-tester       PASS      20.71 seconds
TestRunner_iso-tester         FAIL      31.68 seconds
TestRunner_bnep-tester        PASS      4.86 seconds
TestRunner_mgmt-tester        FAIL      120.89 seconds
TestRunner_rfcomm-tester      PASS      7.65 seconds
TestRunner_sco-tester         PASS      9.48 seconds
TestRunner_ioctl-tester       PASS      8.28 seconds
TestRunner_mesh-tester        PASS      6.03 seconds
TestRunner_smp-tester         PASS      7.08 seconds
TestRunner_userchan-tester    PASS      5.13 seconds
IncrementalBuild              PENDING   0.91 seconds

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
WARNING: possible circular locking dependency detected
Total: 125, Passed: 121 (96.8%), Failed: 0, Not Run: 4
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 487 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.194 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1579185104856657634==--
