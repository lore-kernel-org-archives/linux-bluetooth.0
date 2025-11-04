Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7541830AAAD
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Nov 2025 07:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762241834; cv=none; b=obhGYp+AKwyr5OB0dEeS8SkaX8M3gdmSzCVeS3Huiy65bhaZuAFBfAGVBDy6BylNMtngM3RXDjOeSgAGGvRp2FHhgAdcx85oIV9zn8pzzZBJYVVV8pEhu8yuaxPK0TWa6CNBIPQQjovQGNqvWYK1HrIQe3CZb+nEtTpYvUQlV+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762241834; c=relaxed/simple;
	bh=VYpjbgZ/DB0FnnboBsOc0EBykZ1N7uQCCLfBAsCPQ2M=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fdi1vZNu/4uwKrQL/mQ65rFKr09F/5+uzeZC37frE7nPhBJWSLD+/qORrgFKQ+HubLbGeL0aGK6Blz6ymRaE2jpAz4IXOWiB6IlZjKZEPSnx0Mz4/57itSWHCVIyG0NLKRuX5YGpr3O95qB2T00JHcsXzWHQo4JbR123Dqo51C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPXmVGjH; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPXmVGjH"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-4332381ba9bso32149085ab.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Nov 2025 23:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762241831; x=1762846631; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9VsMTRP/0eGT6B20LLEF2h1xQn2JIe/SbdjrRkFjJFo=;
        b=EPXmVGjHY4zm5RrDmQpWvduXHFchHCf859XGwbToxHfVb5+6uzNUEqJ+isGRaXgHPd
         o50pz2Yzi/hn3eND3/AVMjOqXFfAB5OZNjsXcVbnBN6O9p5X2unk11UQUF/WM0q1Ydny
         t7Vfufun1RZWzSmwJS9u/sSHp6GnrWP/vdGXb8b0AfBMv75PqFlBMMDve/abEbK3qvHh
         Ft1WPanqp35k+78OaAA6AZNRPD2N/qmwShdOI45YtkxzcirJiIUq+Db63zdLiLwRsCiz
         SBdzTGYm+gh3FBBEETMAHymH6CXtkqScut7s+fFIVCJKDchIXlCD806nulA1wk85B93K
         TPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762241831; x=1762846631;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9VsMTRP/0eGT6B20LLEF2h1xQn2JIe/SbdjrRkFjJFo=;
        b=MEz4LtRuLkua4TxXCOn7uqtip9Kx+aGTzItaxP1F1d2uxKiLOHMAVUI1vuykKdms+T
         1waluMO1qT/GqPWQUKwXG8X/wxh2PwnZHNO2HzTbQ0osEfCnk5wWntd6w/l5YHhfwW/I
         Owr6/j8tG+nQ03XJSye0cbVX7ETGByqDy2dHJ6yIwsRn8S1oCIjLM4wpnjvtS08euBmr
         fu+FYcEtBZZ74MjUMEX3U/JHlsY+EDHfBmLe5ZfFJ6Y5wNqF80+3mfxpzq9lYvYkjtPr
         rFiT7N9I6R2K0lsnCJqBy/KTz7+7bDWWzDPpkW88KljBcjREQsMMlp0qnW1JHOHAl/M9
         wTwg==
X-Gm-Message-State: AOJu0YyXtmmHbx4FzE1O+UTFJ8UpdpTe1lGQZgKzsU5lLju9F0HKgDXr
	rB4cnXCmdqMv0i6qoBeFHjeJxofktQRA/JzqQ9NMHO7HNVdKnyQh767gNf6epA==
X-Gm-Gg: ASbGnctr7UvWVayBiQSGPxTqZ/vwbDel8fZVNXBR4ZvxaRS208Kyt6MYDU+qc4cXRHQ
	KjXwXL643OurDniatgn1PrkmWClloLXKGXO1eTI6SJS2deJCbBVrJoCardrdjgqRUgZZftccvJx
	PJUJWUpiHQ9HPvgc99Rl5DWzmJi7TV+8/1sarKJqrPN1+3cLVHoVoWFVrptQFVV9x+TiV0Sh4hs
	h3hhUOu2GKaTmCzx2nRqQN/BHArsRMVLn8UX6QPVaPD1MGfrMTDFaXEVBGO9mImkii5W087f3NB
	j10YKuUnCHWlJ2hWqwi7SLp2tBKITa0KkMZdCuNzdh3bODmcv49kMGqvISP8RbjoTZTmc2/OYRI
	WrWzQAlXN/UEVNB9VeCTT4/O4zPvCksJHNxLfh0S55Bg2pH80yvoGmIhRe/wGOjFSkjf1JpBPjJ
	pzEz/Jog==
X-Google-Smtp-Source: AGHT+IEeTXTz+VyB/0RezId2pLyRDE2grcmfUFplpM+TcwRI4kUqfxFKeHVqwZX3ok8wRwplEboK5Q==
X-Received: by 2002:a05:6e02:1805:b0:431:d721:266d with SMTP id e9e14a558f8ab-4330d1ea309mr225086885ab.31.1762241831335;
        Mon, 03 Nov 2025 23:37:11 -0800 (PST)
Received: from [172.17.0.2] ([64.236.201.50])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7226f55desm1061186173.61.2025.11.03.23.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 23:37:10 -0800 (PST)
Message-ID: <6909ad26.050a0220.329a10.2496@mx.google.com>
Date: Mon, 03 Nov 2025 23:37:10 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6488954833063053785=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chethan.tumkur.narayan@intel.com
Subject: RE: [v1] Bluetooth: btintel_pcie: Introduce HCI Driver protocol
In-Reply-To: <20251104072222.195729-1-chethan.tumkur.narayan@intel.com>
References: <20251104072222.195729-1-chethan.tumkur.narayan@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6488954833063053785==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1019272

---Test result---

Test Summary:
CheckPatch                    PENDING   0.39 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      25.68 seconds
CheckAllWarning               PASS      27.92 seconds
CheckSparse                   PASS      31.68 seconds
BuildKernel32                 PASS      25.76 seconds
TestRunnerSetup               PASS      501.82 seconds
TestRunner_l2cap-tester       PASS      24.10 seconds
TestRunner_iso-tester         PASS      88.70 seconds
TestRunner_bnep-tester        PASS      6.26 seconds
TestRunner_mgmt-tester        FAIL      121.87 seconds
TestRunner_rfcomm-tester      PASS      9.57 seconds
TestRunner_sco-tester         PASS      12.85 seconds
TestRunner_ioctl-tester       PASS      10.31 seconds
TestRunner_mesh-tester        FAIL      12.50 seconds
TestRunner_smp-tester         PASS      8.69 seconds
TestRunner_userchan-tester    PASS      6.64 seconds
IncrementalBuild              PENDING   1.05 seconds

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
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.105 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.158 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.757 seconds
Mesh - Send cancel - 2                               Timed out    2.000 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6488954833063053785==--
