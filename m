Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD502DEA6B
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Feb 2026 18:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770661290; cv=none; b=ljA26IemYcyaAIlZwSx9LTT6ek1Qhnb3y85szk7xR7okS0aMOB3yg/SI3bxC+jb44jlxoeENxCUpduGC5M1Cb8P3pDFPyuvnE6IBFhl9o8ry4HFuT77GaAyeNKFLqfGdO0XgMEak/bQ5RgT9kRUr3IxJV3JP8kydkXbAL5WArvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770661290; c=relaxed/simple;
	bh=Sn7VXfY9VCb6F4mvRyB72Uqvoa2Q4p1RcEDXPrIhPYs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Lc2rG3wurspS98yOIm2YNUKFD82oglVvHjprC7oMwwfQlpbZAkDruStlnsMQA2PI18RndkxxQznfciOpyBBvQHn3WGpn5EASO6dbGkTEp13iI4rAn7+Q4+h3oQpprnAp9IsyTeIEz4ae0+sv7mDczJvV0Drc/GpCN9nkjivSM5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBAAxRGq; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBAAxRGq"
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2b82c605dbdso49571eec.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Feb 2026 10:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770661289; x=1771266089; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vNwFqMEIt8QNPZNSyvWwA3FrL0muObSVf9bTZxNEc2A=;
        b=kBAAxRGqG7oz5hW/2loTqe8HefbITqudlk3PH80SUoIK6rUWxGpg4eA7BHQ+RGWBej
         jPK7Gr3GkdgUrj/btRK91LQe2ybdknYKlZK1kj+d2CMU4HGyVTcQuxgsIVc72MhsOy7D
         voLjjldDCDfbnX55yEuBs9uGoe1klCM+Qg2Y6fEAcpCIzV52i+0dVV3xxh5/8DQ2O5JF
         AL9t9gjSNMgSj235fE9uEGU31NYAO0t6BskoNi2sgloHDEV0mJMTTAZg68yvXa5KXHGg
         SHN7FANVzbEF+6B7M4gR04b54FzIKQozrOn12LzI8VXvrga6IZ5m/C1FI7CiZ5YBHHui
         3Ojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770661289; x=1771266089;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNwFqMEIt8QNPZNSyvWwA3FrL0muObSVf9bTZxNEc2A=;
        b=INeZRwD77knNxOKN4jV0zkOEand96t1qtid8RRAHpwMDBr2MX/XHXd9CbN48JFX3jk
         qc8INOxL7dJf0beIJlB1xRfvWn1cjzXjR0ECK+/i96hBmzLk+5hgBAYKrlOwz4PHvu4t
         3VfGtzWnEfvl6ZvkaxOnghZ2GkADQXSFM8eFD8okjDlFlsw9r7g6em8vjgfU0pWcvarD
         Xz5MUWY3Q68fQ+ed4HMCIr4UCIDZw8LRIiECmvnL82V3qGlB7gZkpBDunbGwO5My05gS
         K/GiJN4ww7NBBckaWTR5wWsFelfJQtrU9yna2IdXAlIkNak7tRy3t+bOGdmPUXfKgBep
         WXpg==
X-Gm-Message-State: AOJu0Yz4fj7opXwWOG1PIEkROFVfIiS6dKB2vMSaINb2fhXBnZthQo2E
	uf+ElEOXZ9W+hAOF5RO+VpnaQzKf9d0yri7mUQjbrWbvR5RDZezkXzP7R9YgYFzf
X-Gm-Gg: AZuq6aKpSrzU+w0nT/3TmgJou3A3RSqSxl0ttSf2rmzunoLjC5vOCs57h6rlN2RFfkp
	IpJszJ6agOyBi70fRrHSGgDulXqV0kECiPZ5YR8DR0auyECrPN5ZMEjhePdq1Z3gOxwQbq+VJxu
	axyL8TH2n3+/uSAYpmehxmO1k6ZMNy/vFyok//r8dKvtVZAjV/XrAqrDzDlRdG7ywmG/43NPC62
	xuntnNH01empz/TG2QwwO5a6Z+YtjYMUwAp7T9M5Lqe6IOEKaq8IBagBU8PY6eWoPx4XS5uU8Be
	npG/ea1Z2zV+7I5zLXWdTiELdZfNWGHeWJfrLTPsD1dn7LRne41RhCZ2I4rvJzH0yM2FBlXV5aJ
	1iGT6N+M29BmMiJ13RY/BStmGGMN3vsCNbmrKpDSi5WTmpzT9dJnMyCAbfL432DQ8/C0yE9dmzi
	S13DrsdYqsWyE35Q==
X-Received: by 2002:a05:7300:e207:b0:2ba:7b71:4f4 with SMTP id 5a478bee46e88-2ba7b710fd3mr1041607eec.32.1770661288984;
        Mon, 09 Feb 2026 10:21:28 -0800 (PST)
Received: from [172.17.0.2] ([68.220.58.6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba71a0af3dsm2602131eec.0.2026.02.09.10.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 10:21:28 -0800 (PST)
Message-ID: <698a25a8.050a0220.28211d.dd8c@mx.google.com>
Date: Mon, 09 Feb 2026 10:21:28 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0311527531795967313=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, marex@nabladev.com
Subject: RE: Bluetooth: btbcm: Add entry for BCM4343A2 UART Bluetooth
In-Reply-To: <20260209171158.22641-1-marex@nabladev.com>
References: <20260209171158.22641-1-marex@nabladev.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0311527531795967313==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1052376

---Test result---

Test Summary:
CheckPatch                    PENDING   0.53 seconds
GitLint                       PENDING   0.38 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      26.15 seconds
CheckAllWarning               PASS      28.35 seconds
CheckSparse                   WARNING   31.97 seconds
BuildKernel32                 PASS      25.28 seconds
TestRunnerSetup               PASS      563.29 seconds
TestRunner_l2cap-tester       PASS      29.35 seconds
TestRunner_iso-tester         PASS      86.48 seconds
TestRunner_bnep-tester        PASS      6.32 seconds
TestRunner_mgmt-tester        FAIL      118.63 seconds
TestRunner_rfcomm-tester      PASS      9.48 seconds
TestRunner_sco-tester         FAIL      14.78 seconds
TestRunner_ioctl-tester       PASS      10.28 seconds
TestRunner_mesh-tester        FAIL      12.53 seconds
TestRunner_smp-tester         PASS      8.76 seconds
TestRunner_userchan-tester    PASS      6.66 seconds
IncrementalBuild              PENDING   0.73 seconds

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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
drivers/bluetooth/btbcm.c:781:1: error: bad constant expressiondrivers/bluetooth/btbcm.c:782:1: error: bad constant expressiondrivers/bluetooth/btbcm.c:783:1: error: bad constant expressiondrivers/bluetooth/btbcm.c:784:1: error: bad constant expressiondrivers/bluetooth/btbcm.c:784:1: error: bad constant expression
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.111 seconds
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
Mesh - Send cancel - 1                               Timed out    2.606 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0311527531795967313==--
