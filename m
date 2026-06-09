Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FC01A2545
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 02:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780970895; cv=none; b=iMzHCW0trz00ZiorAV7LbhcpBISng6W0bEY+y3aPKJUQ0n1F0HoKz/yA9UVOT069Mf/G3bklsKyp2iO2W6T6K1+OGrZF20YSd6yMCawVgFKgJ+crOAs3N+YyKwWrF2SjJYG+9hoC3H1DaYAMNPB07lrHIo6qrH9NL8eP5z2lu7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780970895; c=relaxed/simple;
	bh=Ln4zT58os/97Kvhuy+eYHECDAL5SI2IkoHIlb2vRXFY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YB+DIuBQw/NE2INHL36HLtNfLv9sSQQQJeuVlzZkNUbg/1dvD39WxYX8v7tBj4hNCwJFJuQpvGa1CzC1e0EFXyV0C3/NE62NjydTUQdTMfbDGxbknKSu+cjR8wgj5mo4SpARmkRNumdrF9w+DmRUwPLhzZBm57vjwAZH6nA8jT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RDs0Dx09; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDs0Dx09"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-304e83724bfso6036393eec.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 19:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780970893; x=1781575693; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8KissBNeHBam8tIBnKU1rS23OQjXAI713//R69ONic=;
        b=RDs0Dx093PeIBUlxObaa//symrWalSWFAkaaWXOhxmUl2gjJzBwanHDK1UqtFmH3Jg
         3CgVOc/waL5IIbymr2A2koaE9MZwWOspg/NVZ9DkdUYPghmDZIQ9RGE8BrF81d5ZmyZB
         JWvjSAW7ReH5tiER3PUsg+zGZj27NDUytd/Nq+2MSJG6Z7X03gm4J03oY8JmvqIHn6tE
         cr7PpWkGhk/UYMJ6/9kaJO1KDns9HjtLCg36XPomE263S79AQVIQEDwkgGLHVGUbVfuN
         lX433D5my/haHP+RMj/8/RXocSTLcZ3ol3i+bYkpEWagipvxhiUKL/kVjHENjzbu3i0Z
         7FtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780970893; x=1781575693;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8KissBNeHBam8tIBnKU1rS23OQjXAI713//R69ONic=;
        b=izRYCEyjwIY7pDxo6xWSdzmQppCc0aukBmGgsgtUAB/QSuUNXpfnWAJ70sQWiXX+92
         1APAOfCxaBmnZPkR07OlynWK0oVe9GqaTDhPh/LPqEDPAMlWZiFuTuvPahucduRUW7Db
         yPI3zstezAO6OmbPE0K2DbyZZsES860GEIRQ6iE45b6K/b241+9D0vMbcgoaPMkl3FeP
         ahV7LVJKVN6eMGS/BMGG6a2zL9haXhrn4x9vD1/TNG/I7YPWruEVUWel99u/9cTCcCtF
         KxuTahpqV7EEfmGoSqG1z+F7EtLgcF6pBht4w6buYxkkDbE4xLCjztd0cJKl/le+eMCG
         xn2Q==
X-Gm-Message-State: AOJu0Yyz5+DVEWYue6QhguQuYxzXrbaEoU2B4yplK/hz5SGZKKlChiWe
	6JgRoO/mEtXPMR5HJAKRwW0BnUB7x6/KalqtAQ41uHs3oxWDZChmrlz5gsiwgQ==
X-Gm-Gg: Acq92OEXlGq+Z4VxF7j2uv+1YO9DagkadyEQex1ZYf6FAhyZNDvprb5/DsOaaUyxSDX
	5SIVb/1hIYRJSsKGtZTJbz8MVDeNzxVSYk+mguHiiw63sYxMP5eIINszyDLlyTctfciN/hQU6rS
	5bOlHztjJndwExwL1mXTNdTXS7y1exy2St0VjS9kRRp76+fvIdngChYqq+DqrSmFt75H6vfkjfO
	7YVx+tPhk5EF9s59SQYOuC58bfjbUD5avNGxa0rsXeKG7FEVl2uu0zskNxkxDY4lfNDmqQAArUl
	hY5BYXukEUyIuF0T2AlirKJz8zll/g0aYrdxe7HOC3zzXhCgDzpMB9LASedcjVTbnOr4qrpTZpJ
	vqlVInNyoFVxZJSg5Yv0mw7KKlEPFnQOgLYc4u8/wdQWPLRWLjZdSybaUXzoi6yQSn/9RQr70ea
	c+GcEWbzcsfDrrUMkrUrprZb7AozcYvoyE7bPAXDUF8ZUXORFfrDlt
X-Received: by 2002:a05:7301:1e4a:b0:307:156f:268c with SMTP id 5a478bee46e88-3077b3a7ba7mr9379161eec.13.1780970892621;
        Mon, 08 Jun 2026 19:08:12 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.225.202])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df64eb9sm17316893eec.25.2026.06.08.19.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 19:08:12 -0700 (PDT)
Message-ID: <6a27758c.fb9e70e9.2c4a2a.9832@mx.google.com>
Date: Mon, 08 Jun 2026 19:08:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2667282378625539559=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sam.moelius@trailofbits.com
Subject: RE: Bluetooth: hci: validate codec capability element length
In-Reply-To: <20260608235627.1233330.bc5338ecae62.bluetooth-hci-codec-cap-short-oob@trailofbits.com>
References: <20260608235627.1233330.bc5338ecae62.bluetooth-hci-codec-cap-short-oob@trailofbits.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2667282378625539559==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1108156

---Test result---

Test Summary:
CheckPatch                    PASS      0.61 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.21 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      26.58 seconds
CheckAllWarning               PASS      29.53 seconds
CheckSparse                   PASS      28.04 seconds
BuildKernel32                 PASS      25.93 seconds
TestRunnerSetup               PASS      577.06 seconds
TestRunner_l2cap-tester       PASS      60.65 seconds
TestRunner_iso-tester         PASS      78.61 seconds
TestRunner_bnep-tester        PASS      19.09 seconds
TestRunner_mgmt-tester        FAIL      216.08 seconds
TestRunner_rfcomm-tester      PASS      26.05 seconds
TestRunner_sco-tester         PASS      32.97 seconds
TestRunner_ioctl-tester       PASS      26.16 seconds
TestRunner_mesh-tester        FAIL      25.86 seconds
TestRunner_smp-tester         PASS      23.83 seconds
TestRunner_userchan-tester    PASS      20.28 seconds
TestRunner_6lowpan-tester     PASS      22.87 seconds
IncrementalBuild              PASS      25.00 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.249 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.188 seconds
Mesh - Send cancel - 2                               Timed out    1.989 seconds


https://github.com/bluez/bluetooth-next/pull/293

---
Regards,
Linux Bluetooth


--===============2667282378625539559==--
