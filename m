Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB0623CB
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Aug 2025 08:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754556124; cv=none; b=nJGXE48phHVCbbBo93/obKujV+1zRPTd1xsF6+oGR+O/n7dXZzR78OZHcVIFlCyZ9GYgQ0yuQIHEkfz/fg/XPWP3GK3MHrTgjejypEQN76872FmzEIFJgaHUPkKsPEMQd7qq44FOKjroU1dYix4SarPa4MxR/c9r50xnhVTI4BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754556124; c=relaxed/simple;
	bh=bA02cbpJ7uu8X88G46nY7r6qYuLfT/czp4z01HOOwCY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=s/Uz+CVIxPTEiqoxcNGy59NxqJCgLsvYJFMnfQ9BCk5G5XyiWvahD2Fg9KThsNEqqZG4Ai9lceZNZ7O6+wuk5fFypyl78EQSlA/rX7wGbVVUv5hoLZk+Z+ETrjFaGrze4AFAprP5gKLLg5Xb/3kFsfQhvIcmlGD1Wrz9S18zxbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idpAxYJ+; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idpAxYJ+"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7e278d8345aso79034585a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Aug 2025 01:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754556122; x=1755160922; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DuRivbF7tZumNKOCWOyqXJx8ifOWkpEiyC7VzKmW4HQ=;
        b=idpAxYJ+oTWjULAXTsdC+xSxXhhmHPMf1QTLR6urwYe7m7AHMQg+Rw21DzbrzWH7mB
         e0bh8r3gSlIxUCHhS6M5kEMSJ88xJDCkBuQiRZbGspkP6/z02o5uBQXMIvxtnelYj2hG
         8Pcbxq6FsYdz9ioE0UEw21LuWZqeWRvyntNc7wZlCu4f84IbngKnM5LbVgzIDUmINvf1
         KLVX0eAwnXk25qKooxJ4p8CUwa5HuinRa3eKCmf3CdZQiRvk/BCNUfEruhfrbybFKAPs
         7xLXgmkOXfZyKjjti0DXBg0GBmER140CBeqrwWv5TQh2pFW1nfMLi9FvW1TjBFEpIZEN
         exPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754556122; x=1755160922;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DuRivbF7tZumNKOCWOyqXJx8ifOWkpEiyC7VzKmW4HQ=;
        b=CRMpbTAv/5o7+y+dU+44MNiGKuRCPMVaHZaTGBVi7TrVREuYGcfO5QUyxIyiEBwog4
         hdWiCU5iO9PN0Iau6DN/RFBvngvOlOPH4v+lCKAeOncwFapQACRY5C8LcSj05LpWuBGp
         ssjIwYnvPMvFo9WvZviZMsmOE6KXGtNlSR5CF0pfOsMWJTp5hGVKan8UF8VW1lpayhu7
         LcH1ftC+SVV5zAyg11HvMV68PvRbIut6kr4Tj8Eo/w5zKn1bhQd6xjJZbkKjqB96R4ne
         Zc/ZDsPcnslpvWtq8mVn9SDgwKF5HYD1OkimlmQN78E1Br5cNISr7He2I1AoICnVACJf
         AZ5w==
X-Gm-Message-State: AOJu0YwmLIWxK95KbujtK9DzRMa47RB5YUN06zD016o2bYox3aqFWAu5
	t3ZX9DkvZjLnK3jzMHNHigol9O91Wb428Pn+W7vrgE655m4vqitxAFlSkmC6qA==
X-Gm-Gg: ASbGnctc+0wMowqtbUvA/eNoVoBSwDSAxqbBJVIzSmmBQM7vb/hpc0Y6O3fOf2mejx8
	/nowUy7p6cosYNy0Ill2FjGAt/b/Xs9GOkEs+q/nf5FEdkj09gH4V6vNtwWnl38tBUtSURlMCeE
	vZQPF/5y7qE5ieihfFttsvXuwSw/MnEk4bzk/joxKwOeusVt7lRJwVP9K6c+YzfXJwNRmAkRzCT
	SIAf3o3qMrNLQC9Sb2SRTmiRCoLM+2UKxuibPj/4TkU5PB/jx6JTgin/Y/UjHng5mnF1cUbnWNO
	5l2SPWuXLASktR3mZn3ZwPHWILSDo5PU03d11P5/HaAguzOromkYjU6ktcK2F42u74OKYC0dVb1
	rjytqpb3j0Gb3pDgio9k6ceqByOw=
X-Google-Smtp-Source: AGHT+IHyQPFKk6fEQAa8iXYcFWfsR2hn+yRBS6aBqyvGeEy5yXNczdt2XmB43buQz7AOodeI0UT4lw==
X-Received: by 2002:a05:620a:198b:b0:7e8:2411:e837 with SMTP id af79cd13be357-7e82411ecbcmr134174085a.36.1754556121722;
        Thu, 07 Aug 2025 01:42:01 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.39.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e817311ad9sm193358585a.41.2025.08.07.01.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 01:42:01 -0700 (PDT)
Message-ID: <689466d9.050a0220.24f207.60bc@mx.google.com>
Date: Thu, 07 Aug 2025 01:42:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3169416128356667932=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yang.li@amlogic.com
Subject: RE: Bluetooth: hci_sync: Prevent unintended PA sync when SID is 0xFF
In-Reply-To: <20250807-sid_invalid-v1-1-94b3902a49e3@amlogic.com>
References: <20250807-sid_invalid-v1-1-94b3902a49e3@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3169416128356667932==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=989014

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.33 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.16 seconds
CheckAllWarning               PASS      26.81 seconds
CheckSparse                   PASS      29.59 seconds
BuildKernel32                 PASS      23.84 seconds
TestRunnerSetup               PASS      480.63 seconds
TestRunner_l2cap-tester       PASS      24.91 seconds
TestRunner_iso-tester         PASS      37.85 seconds
TestRunner_bnep-tester        PASS      6.04 seconds
TestRunner_mgmt-tester        FAIL      126.92 seconds
TestRunner_rfcomm-tester      PASS      9.28 seconds
TestRunner_sco-tester         PASS      14.69 seconds
TestRunner_ioctl-tester       PASS      10.11 seconds
TestRunner_mesh-tester        FAIL      11.42 seconds
TestRunner_smp-tester         PASS      11.96 seconds
TestRunner_userchan-tester    PASS      6.43 seconds
IncrementalBuild              PENDING   0.61 seconds

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
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.176 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.184 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.098 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3169416128356667932==--
