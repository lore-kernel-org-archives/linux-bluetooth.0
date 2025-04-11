Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675C8221FA2
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Apr 2025 17:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744391118; cv=none; b=Q+7DsnR6u5mHUll9bHhld2Pt1MN/dVHz7QRfZeelnQ/aMc8ulYghQmNUs4+EGIjs3WxQvyoFgAQanMwSz5UXLNGhJ2xZ04UAQ11lj3grTbY4Vbh8aJSRnYsAYiLb2rozYeRfs3W97HwKf55xzNsLcbPquxo63ZK7L9fehGTXp1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744391118; c=relaxed/simple;
	bh=BWHsYnxU+sol4kvY+8lQ/NFoaH7N6gT78CotEtpKl0Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IWfDVs4GMXkgqb6Dr+/oPWp+rsSjudMfL3XGY3nwSH9zRgjQ5q6iBfgBa+GM9VWjz9pmFV3QPcuEodN+yVqZpjhOTHIBcpLvm9y/QC9Xn65dkVTIbjNTBkzFJQbI64qZOA/dbso8HJ6IVwajR45NgwT3tpe9a7anHWm+/0PVZnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=daFsA/2m; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="daFsA/2m"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-476977848c4so21660991cf.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Apr 2025 10:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744391115; x=1744995915; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=usgGrjDOgcvybJcYKGymzpumBY7gDS3/+SsvwMnf52o=;
        b=daFsA/2mBVgLwC2T1CMwRVRHc954Ncx9N09yS3Dhzy5NaA0NA1KD7Bz8XQ3zDsY9WL
         dbIGACLqNUnLxrbNDhfFjAD7i15EK7qOKyQLtv5Xa04emNCywurj1izSmFga+4zvzTpy
         jfCIYHHF4kyO4REbLaiJyiISdOFt+R691aLMT8b3UJO7i8r1hvEaBQ89aCu5nytAEOT7
         LzRELUWD84UqkedGV/n/FM9Mf1miYJJy7Tj7Lf5TL7rdz7M0Is5uzks9aBLnib6y4+o1
         ZBxt1TEEbRPq19dzhYxRCU6YuipLNKzzyhe4Y790pmQYoz3YlZ2K2ah6gorfF3CjS/vI
         qIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744391115; x=1744995915;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=usgGrjDOgcvybJcYKGymzpumBY7gDS3/+SsvwMnf52o=;
        b=vezdmBRURd5AD1i3KJagL+FjZNJq9+60cOP6476iztLyFyQTxf9fY0KBk2iybVMVtj
         I+MXV6bXVJ0VLppx/JiymC+0MYaIPSk0VTJCzAsJmA36AhxEzqkMLAnQBPqt3xTW0J6D
         /WzUjJQnhi2AKVdDoG8Qq07G+3VsYCePf+WKelDLHHRlGT5ZaEIldEXZAUfKnz8EqEEQ
         Bh29gIxQgzJYcRNAtmBdV7SG7kqvqUJ43vm3xKm7MJH5YPMcjSfg0CshNG8MT6BsE7M/
         4NRBD5yAUTFr3QGy53Gz31HNeC0/Qz149hEfKXqcfFYY4kbXiY0AmXBbw9OjThTTnrZJ
         VvEA==
X-Gm-Message-State: AOJu0YypCgcQPJLi8wIBMNawgpF4y10ElIOHstX86cm7fNoYXe46oCaZ
	D9yXxw1bejeZ6rg+IMQAUQuaO0hErYMR/csFqsTWewzgqqwO5Wp/nkgm4Q==
X-Gm-Gg: ASbGnctqPBMU7CcKTlRm6DpBZ10F+cVdKFnv40CquTIbOexfxsyFEPTgkULtKkSV3UE
	BxosITqs14/jy6Iq1jrWY+EdNtoOMCTyGDs+yT31Ht++VW7QgdvUe1fFAZUUwE8DaUPXSWWLGqK
	uWy0ndvyXSOcFrxnEYhaivJC6N5Dp8sseiI1UM7sVAmaiS9ZLSajXsnCIhixbVNYjBbppQuDfPf
	UNVPUv46MAy1+rTGnNDBBhkWFaIIlT/T+6/HGaLWjP8IrAekLaNegleW/1cuRFoKkdV+SEXDygm
	h2PP/BBucwDa2iXbNWkUIxBnjBmEUSwnF9rEVEtE7yim+w==
X-Google-Smtp-Source: AGHT+IEO017s3ROkBqqCN/9slKTcz9N23lCqyOA5rQe9QyX3pS/0rHaztsEGeOLnHmyc5WazxMTHFA==
X-Received: by 2002:ad4:4ea8:0:b0:6eb:28e4:8516 with SMTP id 6a1803df08f44-6f23f0f9405mr55260596d6.33.1744391114914;
        Fri, 11 Apr 2025 10:05:14 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.50.237])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0dea114d8sm38991746d6.118.2025.04.11.10.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 10:05:14 -0700 (PDT)
Message-ID: <67f94bca.0c0a0220.27764b.c94a@mx.google.com>
Date: Fri, 11 Apr 2025 10:05:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0465827284090928860=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v1,1/2] dt-bindings: net: bluetooth: nxp: Add support for host-wakeup
In-Reply-To: <20250411163719.326558-1-neeraj.sanjaykale@nxp.com>
References: <20250411163719.326558-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0465827284090928860==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=952573

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.24 seconds
SubjectPrefix                 FAIL      5.69 seconds
BuildKernel                   PASS      27.95 seconds
CheckAllWarning               PASS      26.82 seconds
CheckSparse                   PASS      30.17 seconds
BuildKernel32                 PASS      23.89 seconds
TestRunnerSetup               PASS      458.34 seconds
TestRunner_l2cap-tester       PASS      20.98 seconds
TestRunner_iso-tester         PASS      32.79 seconds
TestRunner_bnep-tester        PASS      4.84 seconds
TestRunner_mgmt-tester        FAIL      122.61 seconds
TestRunner_rfcomm-tester      PASS      7.79 seconds
TestRunner_sco-tester         PASS      12.44 seconds
TestRunner_ioctl-tester       PASS      8.32 seconds
TestRunner_mesh-tester        PASS      6.12 seconds
TestRunner_smp-tester         PASS      7.19 seconds
TestRunner_userchan-tester    PASS      4.98 seconds
IncrementalBuild              PENDING   0.78 seconds

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
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.138 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.135 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.187 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0465827284090928860==--
