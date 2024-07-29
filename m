Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6150770F6
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jul 2024 20:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722285399; cv=none; b=I5bDgpe/CXRZf4m6EqI0AcWwG0jh1qmTYuG2GRXL4Pjcn8zBqQ/RQ7v9vn6svunsQqk8YGRbPfd+HjxNowGuqvETIoz0CvjQQ5xS2DbOjoKOQZjw6IcJ25oc179HnR8uwuY2MwbiVmlEYT3AnlBYQ2pImZ8MvIEsA9NQQnR7r4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722285399; c=relaxed/simple;
	bh=8sKAg2VY/mLTiXiaNqY52Fyg7+UXJup/19ZbSiVR0mU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hXO9dMtObhfJbmxhr8tEqJGWEpW/PhHMQaGZ5blrfJKjftxeLVu0uSsVwiADW+XqRMcnehDr88Gv7gtsk84xYCn/2WUV388D1cFElRCFc7VX9m2cViHGEVB6LqK5HGdaZ0WFF04Cyd5JP+fkebBJSypNFjx9sRi+A/5j9IMNdTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1XKipqQ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1XKipqQ"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fc692abba4so23440655ad.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jul 2024 13:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722285397; x=1722890197; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EODSjSXM69n0IL/KnoDaJ3GVwNxUJHmb1pWBswc2DBA=;
        b=X1XKipqQnmx398lGvBDbPZ153Zy2xEw3SwD/IowfusOzKze2JcUUGgmFZYUBURdnle
         Qw7sImY37MHPicsfoP9HuOsP+Fp9Dm9GVJ5vAOsHl1bi1aegFn7E+L8FunflOXRkhWLc
         R6VzwWor6udFOHMsDRegwSA1/ps/rHDnWFigT47jpPcvODlGCVCrePlaV+HBOYjSzwar
         umc1giEBW/cZ7nAVCeLVgUj4m3oaO9Dhqfgm3bjngQYKa/LvtpZl+h7Y3QZPjDfijCNI
         hz+HUVm+OtIyJhiFZr42n0Bidvo5U2ozXckXGQPA+cI7Q2ia4X1imrUzn3Nim/eE8oaT
         RUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722285397; x=1722890197;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EODSjSXM69n0IL/KnoDaJ3GVwNxUJHmb1pWBswc2DBA=;
        b=cLbq6k8nuOg8iLQ/NrzTgkpLCOx5hBe6H/P2pvnrNI0n5Zvx6LxCrXCJI5Ikjip5Ur
         Ka2k+8ss7NCsVnEnU1SttC7oK0aefaNb3GZQ6pKQTivwC8aFYyRfuNBA04Aj8ONNczml
         gWNQMYTPpUN7KnVFJrYhiD+SYUpz0eOEl5E68OOfgjEEz6fXKXOE0liPS9vQ4qgX29OB
         MmQFU5ib8ITUApX9RAcDCi3VMraAvky5I2S2Hb2Q6BlSeWunL4WVoAsB3EC4/TxwWsJ7
         GVdTiqf+LFNrm7ho6KvoFpbEGJfZjvvLyNYxwrvpjEYE5rvQmHrwx/MJVyNvcWLhO0lz
         JiDQ==
X-Gm-Message-State: AOJu0Yw1ko3BBp4yRk9JorDi7RgdmNlWBlzn7oNpmNRVuGRFj3T4SQKC
	duwDeo7CWTAmiPFItDfqh1EXDeEv+Z1PiRQXcpdkp1CTmITSnAeEtJ2IAA==
X-Google-Smtp-Source: AGHT+IGXcG4zXufpcZMi8opFgFkM/y+/lrbKvBWQxCG6qeaA1RYewIPrFzjxcrcIB2XC9LpAnSFTRQ==
X-Received: by 2002:a17:902:e88b:b0:1fc:3600:5cd7 with SMTP id d9443c01a7336-1ff04780da5mr65035195ad.10.1722285396635;
        Mon, 29 Jul 2024 13:36:36 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.38.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f279dbsm87397395ad.208.2024.07.29.13.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 13:36:36 -0700 (PDT)
Message-ID: <66a7fd54.170a0220.1ea32.5518@mx.google.com>
Date: Mon, 29 Jul 2024 13:36:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3103455721049507630=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, anton@khirnov.net
Subject: RE: [v2] Bluetooth: hci_sync: avoid dup filtering when passive scanning with adv monitor
In-Reply-To: <20240729195810.25040-1-anton@khirnov.net>
References: <20240729195810.25040-1-anton@khirnov.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3103455721049507630==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=874705

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       FAIL      0.51 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      29.84 seconds
CheckAllWarning               PASS      32.25 seconds
CheckSparse                   PASS      38.01 seconds
CheckSmatch                   PASS      102.65 seconds
BuildKernel32                 PASS      29.27 seconds
TestRunnerSetup               PASS      531.58 seconds
TestRunner_l2cap-tester       PASS      35.70 seconds
TestRunner_iso-tester         FAIL      46.15 seconds
TestRunner_bnep-tester        PASS      10.24 seconds
TestRunner_mgmt-tester        PASS      117.63 seconds
TestRunner_rfcomm-tester      PASS      7.49 seconds
TestRunner_sco-tester         PASS      32.95 seconds
TestRunner_ioctl-tester       PASS      7.98 seconds
TestRunner_mesh-tester        PASS      6.08 seconds
TestRunner_smp-tester         PASS      6.98 seconds
TestRunner_userchan-tester    PASS      5.06 seconds
IncrementalBuild              PASS      27.97 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: hci_sync: avoid dup filtering when passive scanning with adv monitor

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (84>80): "[v2] Bluetooth: hci_sync: avoid dup filtering when passive scanning with adv monitor"
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 122, Passed: 117 (95.9%), Failed: 1, Not Run: 4

Failed Test Cases
ISO Connect2 Suspend - Success                       Failed       4.230 seconds


---
Regards,
Linux Bluetooth


--===============3103455721049507630==--
