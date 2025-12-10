Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA98304BAB
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 13:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765374967; cv=none; b=Dsiqw5zP0R8MN5nTuTy6pLKLO1GHXJFKvCxWvzopaYddjLYR3qMfMMKAnk15ylx1FyncjVyAuKPWCoABzy8kEsUmwWiKI++Mz2/HHacjDCadCyCTRY24K6pA/CGCU7QngYs5dcyYgih67ty1OWkBSfLfs/IR5LMVOyKCwhVVgoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765374967; c=relaxed/simple;
	bh=krHI3j1pKeLGTXU1R7gwxzvRNrNcXWs9TQ5qXPoglqk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DgeSKaMrJhDYmapUcwf8znzfZWxoffFVrcMVFDvv+V2GDWyiMlNzMMkBepIj6leDPgfe9dBzuRt+LGRoISXdirRuTSNfliMnPYObzv7+sB6mVAcSO2ISr5ybp/at+uO1HIdlxeWmFxq0aCTm3KcWR6q8XUKRTEivB/8q6+timqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+asl209; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+asl209"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3438231df5fso8641337a91.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 05:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765374964; x=1765979764; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YdkkgyUW/S/WVJnXAWOx/5BAsgppb9BR9lSoLlh2/ZM=;
        b=A+asl209/eIExg8knJY/6soSXb2STTLebwSGa44wsBE25yzLx4G2FOVQuBz9rFh+M0
         rNvnQ6X/adYdTgoKciYmYJrIHWbO6DYPuBdlVipUy6hQNcPprSQ6MHhc7eWf21I+6CpM
         +jMBMMWesWXvBW5iAD+C5NKFO7isgAx7wNnlqYIkbXd5bcKJtvWCUipSXn90lc7AkJwW
         h8GzsTg53bG1n9OpDAQrhGDY217BCOFyUjWTgM+YULyUDfZMSbHT6MVRE2+ZqFfqgSuZ
         SD9rNlL/WqAoqZ+xZDJu9JaKjYTpioPL4x55reBhuM2fTBaOw5D+BeYbUF9LVpNuCugE
         BwwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765374964; x=1765979764;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YdkkgyUW/S/WVJnXAWOx/5BAsgppb9BR9lSoLlh2/ZM=;
        b=LJnH+N5KqjrCxMdJrUeEocJRPeKghAbVZkDv/B+lMtcqJX2hEW39NEWS/ajPu4qcEH
         sZaJ0cOWlJEuZmYTQjnqkvvv62GLmPhlq4hn8lU2s2O4267vaEav2JptQJDU2ETK1z85
         gkDZzA1FUV20OFkjuu7ME75EXG0DvAfNTvYm5w2WI4OOa29jPcSm8rfNopaBhgfNZBTo
         XDxdrbZa57eYV6jD2ap5YgTLXXmzI0eYIJagwMZW/8W+BzagkUr+2h4h7MVcyzyU5teo
         BMMmwq4doCvCtbbGGlBt1ldC6RmHSpvOxcIq53OncvQZKMUEUwDm30WGySWLGUhvFH7V
         SOKA==
X-Gm-Message-State: AOJu0YzT8GC03pTTrjUeVoTOWZbeZoik9ybJkzHU7AMIzlUvgoplyD54
	pHA8ZQ5pv642gPm6U/zxMz6iLDnPAuvqewS1FVnBkAdMJjzAtmrTCQuQdg39NA==
X-Gm-Gg: ASbGnctIXuPbLjgmJHSapaCEp0dv2MqQeOrsUn+Ue4VMZY4RbFvfpWrsbfAaznVoKtF
	Uj6aqTUxJkfy66B6r8sIXi8BUZKAYXBXwsPJ48/MyXoNDx/knSzy9CEQIskkHD16KlktrI/JU79
	BEJQph45uot4rCZoWCzSXaVOCFess0mixEjAlPBSqxkAYt21030mQCb1yRUqspc2u+ToPR08rx2
	JYzBfg/D2+Wf1HrVYd2JO/vBZpxV/g+uE4BhxGBGBbMTgbv9C8JnNiCNlYEi6KbnwxizPxjqjD/
	bwAaq4FVfaQfPeuAPet+Tq1y17gkrmjjUZwEVjDzQZtne1X0ck+tLkUZqQMFmhN9/NUrrU+glpY
	vZbwO24x0E3N0Yyz4CFwyzyweqRSeikk/WetGUCfMvFKkV/a5BOdXo5ob0rLEOJKb46o5epSdLU
	dwwMQxBsrEHyHEmPC1SQ==
X-Google-Smtp-Source: AGHT+IFcjqjYlvNhIVXs4VLh7AT8qzU7dZWG2baE6YRh5e1chUiWdXmWzyuZPB2dTeLpbiczGkpgGw==
X-Received: by 2002:a05:7022:6898:b0:119:e56b:c753 with SMTP id a92af1059eb24-11f296cbd6dmr2168370c88.24.1765374964416;
        Wed, 10 Dec 2025 05:56:04 -0800 (PST)
Received: from [172.17.0.2] ([128.24.162.182])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f283d4733sm9234119c88.17.2025.12.10.05.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 05:56:04 -0800 (PST)
Message-ID: <69397bf4.050a0220.1f5019.99d9@mx.google.com>
Date: Wed, 10 Dec 2025 05:56:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3943769852500295432=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hildawu@realtek.com
Subject: RE: [v5,1/3] Bluetooth: btrtl: Add firmware format v3 support
In-Reply-To: <20251210123407.3971233-1-hildawu@realtek.com>
References: <20251210123407.3971233-1-hildawu@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3943769852500295432==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1031978

---Test result---

Test Summary:
CheckPatch                    PENDING   0.55 seconds
GitLint                       PENDING   0.43 seconds
SubjectPrefix                 PASS      0.20 seconds
BuildKernel                   PASS      26.80 seconds
CheckAllWarning               PASS      28.09 seconds
CheckSparse                   PASS      33.52 seconds
BuildKernel32                 PASS      26.48 seconds
TestRunnerSetup               PASS      542.65 seconds
TestRunner_l2cap-tester       PASS      25.13 seconds
TestRunner_iso-tester         FAIL      62.09 seconds
TestRunner_bnep-tester        PASS      6.39 seconds
TestRunner_mgmt-tester        FAIL      128.09 seconds
TestRunner_rfcomm-tester      PASS      10.08 seconds
TestRunner_sco-tester         FAIL      15.21 seconds
TestRunner_ioctl-tester       PASS      11.02 seconds
TestRunner_mesh-tester        FAIL      12.61 seconds
TestRunner_smp-tester         PASS      9.10 seconds
TestRunner_userchan-tester    PASS      7.33 seconds
IncrementalBuild              PENDING   0.75 seconds

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
BUG: KASAN: slab-use-after-free in iso_conn_hold_unless_zero+0x76/0x1c0
Total: 141, Passed: 141 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 487 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.114 seconds
LL Privacy - Remove Device 3 (Disable RL)            Failed       0.205 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.172 seconds
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
Mesh - Send cancel - 1                               Timed out    2.467 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3943769852500295432==--
