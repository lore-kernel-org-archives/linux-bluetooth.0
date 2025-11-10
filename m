Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1683228CF41
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Nov 2025 04:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762748001; cv=none; b=ESIt+mCLxUrxm8AEvWit2tkemh07uAAUqj3sm7CcOezU7CgpKMpD8uZ3TcF7H22bisHpd2xikvYXiIo8Mrgd9RzcyoGrF974Xdlu/7sM7k3Itcv+B2sijBq7U0A97l9in99P3Fee5qHiKMjpuxUMxpA6fgZ7oBP363wE2M2lfns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762748001; c=relaxed/simple;
	bh=ST9cW395sSkLbZ08QBGTTX45o9/MfltAfu0kzcYq39o=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=K1Cx9d1cKqrZYJmnCQSCmVaVzc48Oee5/OFiy8wR02oVCWwItyaUMCVxP20fxISw5tmyjik7hGIJL5MGwxFQYR32LpqRjF+bBUcD8kYAuXcntPuJVvOqlcJ+XDJsFPLvGCqT8wbnMSpsYpYh08ic8ieXF9RCYlsu5QHWmbrQ2EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFX8Iul5; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFX8Iul5"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-782e93932ffso2042721b3a.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 09 Nov 2025 20:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762747999; x=1763352799; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AcdnwA53p8nsWhoCM2ib2r8/Ko20Qojl5Jyt5HJSO+Y=;
        b=CFX8Iul5csPOF5y8JN9pJ4Lh+NcvLZ1G7UyBp9l8WNBiGI9nT9B6ysQnbP0dfu8R2O
         IckTYZoMPnu91f1imKrazxCgMWdWR8eyQi18XEUtJXYtHhZKlENNhQ0+NOxePYIIhaqz
         qtA5GrB2HLQb/AUTZe92G1fPnODY+e24GR/LHhWYeiI76G3xEoaKivHOm97wB43oVsng
         lx9MHfpFgCikf19rnhr1aIeYjslvebZ8QoE8LBXTOsyFeZOcRNk1HMgvz3Pu+KafdUBF
         DeL+IOYJuEAgGw+QSifXzDLimpJsJJHIKru0Kh5m1F/BtIj1yPqnJWvpxkOL273Wwjda
         fZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762747999; x=1763352799;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AcdnwA53p8nsWhoCM2ib2r8/Ko20Qojl5Jyt5HJSO+Y=;
        b=fAazN+EQoCCcQSA6ZtpZ2rsgemy62RYSuJBD/mYlU3OomMAtT3jsFw4AWAx1PBOdWl
         fXZV7ihlJF7SPiPQiAjKjFec+OqKO7kSX/EsPccVWTQOJtRiz2ZmnUGNEFT2uey3yTt5
         E4OJ79m7jgwMJsxj6riP0JWxOO0/DC7vVJWib0VSE/jBAB9xg3b78DR+ctCXJjRLrn2N
         kMgYSEuHe2/2+yKWLdbyenYp88ISyUqsLHYNWR+Njgd9VwvY7LfBogRaT/lRuMzBBlAv
         Czd6drx2iV+78yKMm4nL69scAnvY+Fvk4cy5dOLF+3VC4v24MYwxVB4OzfZWNcJOwfAc
         8jQQ==
X-Gm-Message-State: AOJu0Yxj59hfZntds/sUQZvC9whIWk1g/p/rJTQRNsUmQoMYhUPkKxZs
	j6dNTcdNH1Eiv6clmm1Yh1mh7X8Iz1fPh13ZM5fQWwoYsnwg7+HcnIJbSkkoGA==
X-Gm-Gg: ASbGncvdG13YavERU0EalzDZbUFMwz27y2hVj0sprZfV0/7g5XR+iPHiJHNiTfDrpP3
	+2mYltUISTAGRJjxCEMSDWE4uKFvDIbz3nHC2dlpF1AHtvvtWJif1a03X6pStELnlhFj32xkVeX
	9qS/phjqRA6XmXZ2Y6cgeSWfyhVSev/U+vNxHbyoaZj4ZeFVTNTp8RrQwsWbaFBI/qxnBccrops
	uFNISqPcjrhkzF0JMuhJcqTAHyHt1glvcRbKiPoRbh61o+hZUxkjPccZ7JEcFXB4jfjQYmaXU8p
	s7NDJB1/PgzNoa8M31WouMyZIwZTTMUHnOCDvHd72nqgrS0R7bHQAm12n42eD6vF5DluX87wybc
	HlueeEmI5+myCiu0XCeKs9AKgAen06vqWaHt+flGL5S77+nBN0rcV0YZm+IcB9RMZJFibp5RdvD
	WPpqd0cSKE
X-Google-Smtp-Source: AGHT+IGeRhDkRbrdNLYMd3kQiswGAS3tVgh6y+qKAModHMvwDa0sDwqunXixQApIQisDo+n162piDg==
X-Received: by 2002:a17:903:3ba4:b0:297:df4e:fdd5 with SMTP id d9443c01a7336-297e5647bb7mr77600235ad.23.1762747999122;
        Sun, 09 Nov 2025 20:13:19 -0800 (PST)
Received: from [172.17.0.2] ([172.182.195.180])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d0adcb47sm6890868a91.1.2025.11.09.20.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 20:13:18 -0800 (PST)
Message-ID: <6911665e.170a0220.2c641b.a2ae@mx.google.com>
Date: Sun, 09 Nov 2025 20:13:18 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5466329062226738903=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_shuaz@quicinc.com
Subject: RE: Bluetooth: btusb: add default nvm file
In-Reply-To: <20251110034134.1016537-2-quic_shuaz@quicinc.com>
References: <20251110034134.1016537-2-quic_shuaz@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5466329062226738903==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1021377

---Test result---

Test Summary:
CheckPatch                    PENDING   0.50 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      25.49 seconds
CheckAllWarning               PASS      28.38 seconds
CheckSparse                   PASS      31.54 seconds
BuildKernel32                 PASS      25.13 seconds
TestRunnerSetup               PASS      504.57 seconds
TestRunner_l2cap-tester       PASS      23.93 seconds
TestRunner_iso-tester         PASS      83.02 seconds
TestRunner_bnep-tester        PASS      6.12 seconds
TestRunner_mgmt-tester        FAIL      116.13 seconds
TestRunner_rfcomm-tester      PASS      9.28 seconds
TestRunner_sco-tester         PASS      14.38 seconds
TestRunner_ioctl-tester       PASS      10.11 seconds
TestRunner_mesh-tester        FAIL      11.51 seconds
TestRunner_smp-tester         PASS      8.55 seconds
TestRunner_userchan-tester    PASS      6.57 seconds
IncrementalBuild              PENDING   0.83 seconds

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
Total: 492, Passed: 486 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.104 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.198 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.972 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5466329062226738903==--
