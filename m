Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01650226191
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Dec 2024 05:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733810369; cv=none; b=nm8q/Pv/fE8xpwv763iKCnE3wQqRqHVobANrqa8PdMWn57CUhseIYJVLlLdA4+U0OwioyB8A6vVIBTkByunHh9Fgla454Sq7ScNHQ+IEa2YsI2jn21AjKpxOlDe8q4BA/9b/BvRg/JrvRGgJQh9jKYGsQcQUvf4OJ4e5CflpHtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733810369; c=relaxed/simple;
	bh=sUXhZb6OsAeoGC03Oi0w3V8+qTqyiB2DnsvZadkwAP0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=F9wLX0qGQ1dCcnQWN/8/ym6YIZwNpA87sSdezH39r8eCHsOTnwmWCAYD2JAPE5AmedlQTHfDi/BDtOriuszodY68ZZdURNMv6fPAov8ZXOzDHunDPJGQFfKZAbtQj8u+PXHnXPUBRsqZHlbhCRVXdTMbBSFfRa8oZ2KlKgzaqDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUhnT5mm; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUhnT5mm"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ef8c012913so1893627a91.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Dec 2024 21:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733810365; x=1734415165; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7ASh9tUxmsENQRBndwwzfh2TlcSnVUXUK1T5hc/ymBI=;
        b=MUhnT5mm6INI4hvlRDB/PHbKG0Szsy59wjHgR8/M35Ji9/614Z1gD98qnz0SRTaOti
         1wVsGFZdDuoS1AXptbqLA4nhYY4p3pQ3q/+gzQFIDO9BZGhjgLsWulmvL812KMRUKKR6
         wiNtBkoncc37DBj5WK/NSh+Aqlf8MTT+DSIjcfuHTyBMuaZJG23kMIvzv23JsnQgkRTx
         9FccquvM8vYFaN6hSea3c5HdhZJ9O6wQZTCoeMucIIl2+5iwRv2eaKmkv9Bm1b9MnO7y
         ApcUoLhJAAuZF+KpgDCIKf5HR2RyUThf87ca9jb1f0zJn7Ir9KYQswXjPHM30bWDIdOr
         PvFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733810365; x=1734415165;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ASh9tUxmsENQRBndwwzfh2TlcSnVUXUK1T5hc/ymBI=;
        b=q02a9Xatyx4oSRx3IReL4pyw0RlJwlc8SNdp0dArihghQU9djk0jA4ycx3bzR6SxGt
         4pVeUViAg9jyoNtNPlpFZq7xHd+zMmWqPcERqzBeYz5gisAxvNGDqptwAYTNQ1lIKQdJ
         2GDflSOsge+hnfPJHE3NuvvPud8GpFjGViWqLLClK9aldiKxr1FqyAvYgiU9UM43lsEz
         lE8omlsEvXzdvGceLr/+bxNtXC0dpibC3uZOz2AmIZRp7+iREj0pY9hUkpngLCOkIJAI
         WTC27ZUZgIJM2+PN5K99W0gQAdhuU+FXrl1P/AwdTMINM/Whyv0R7wR5/nFAAP6YvG7Z
         MkiA==
X-Gm-Message-State: AOJu0Yz3rSKkyBJ2QjVtOlQd/8+Q0oSOcJg4tUwfhzHeDYeq5Sq0p6W7
	hsRCDx/z/FnNUDlt28S6ES7W5LxRtf1irMW5BhhCiVKmkfrJZPpk3zjKJg==
X-Gm-Gg: ASbGncutTTuaf8yBS/IxCCQDfpFL5WbuWqsewKMHSAPTj5DlJ2QeTQAyQURst/Mjdvc
	5fRTU51Ag9SFyTW3cacnXJbniPCVvsAoI4fJ4pWJLuq9R6NnNCP90SiTs5iJYBhkVleD61tZWgk
	QAE3JedNaxBOYPp6K9wf6FmZEWKz/F6ySkBmd/GjVLVn6L4kjJJP93dLv01bJFBk6luhuztJ5qN
	7DCqUcC7gVi3iAXeJSpZQRhTOnHv3yt2jIOqp2lj9S7nSp/Q5plpIH4bJQ=
X-Google-Smtp-Source: AGHT+IHT/6y4lzfOmY7ecfpPouuHbJ+HufDfAg8wixkwDSk1unRMqDn2p9VO/7mFic1PRVW72smPvQ==
X-Received: by 2002:a17:90a:e703:b0:2ee:7824:be93 with SMTP id 98e67ed59e1d1-2ef6ab27ce6mr19023385a91.34.1733810364999;
        Mon, 09 Dec 2024 21:59:24 -0800 (PST)
Received: from [172.17.0.2] ([52.159.137.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef45f958d6sm8904179a91.17.2024.12.09.21.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 21:59:24 -0800 (PST)
Message-ID: <6757d8bc.170a0220.23f9df.08ad@mx.google.com>
Date: Mon, 09 Dec 2024 21:59:24 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2009264407220069799=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mazin@getstate.dev
Subject: RE: [RFC] bluetooth: hci: Fix UAF from MGMT_OP_REMOVE_ADV_MONITOR during closure
In-Reply-To: <20241210045114.16912-1-mazin@getstate.dev>
References: <20241210045114.16912-1-mazin@getstate.dev>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2009264407220069799==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=916223

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.37 seconds
SubjectPrefix                 FAIL      0.34 seconds
BuildKernel                   PASS      25.31 seconds
CheckAllWarning               PASS      27.56 seconds
CheckSparse                   PASS      30.91 seconds
BuildKernel32                 PASS      25.33 seconds
TestRunnerSetup               PASS      445.38 seconds
TestRunner_l2cap-tester       PASS      20.43 seconds
TestRunner_iso-tester         FAIL      33.58 seconds
TestRunner_bnep-tester        PASS      4.73 seconds
TestRunner_mgmt-tester        FAIL      119.64 seconds
TestRunner_rfcomm-tester      PASS      7.57 seconds
TestRunner_sco-tester         PASS      9.19 seconds
TestRunner_ioctl-tester       PASS      8.05 seconds
TestRunner_mesh-tester        PASS      5.85 seconds
TestRunner_smp-tester         PASS      6.93 seconds
TestRunner_userchan-tester    PASS      4.92 seconds
IncrementalBuild              PENDING   0.99 seconds

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
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.179 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2009264407220069799==--
