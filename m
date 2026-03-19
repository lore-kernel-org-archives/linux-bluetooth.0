Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D983ED124
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 16:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773938262; cv=none; b=IMDweTMSFshN6aq7+xQecW0LFKGh3rzaonWrUaFuZmrZt+K8PZKtHohuOzwgmXhzCYegMllYMX/itNjkI1aUg7ctHYWomGeGLPvxV4xm8n6zcmXOhkRmgsxcic9t+jOG5WXpGR/+jXc038pVXbFV6y+yD0QZn/+mFeTRwPHS7Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773938262; c=relaxed/simple;
	bh=u3flBUDYgwNC9ynOlyuA2jmwJpGZDYeWT1VkAWEzNsY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BZPcF4EKcR8IdXWlN1MyeHuKrtwwfFafMHMJ2vt4JiAn2WfeEyPBhRj6+JjWZR8y/IAEnGUJtn2s6whSL2cFIGZUw4870cvtRnrLaEzLqPw5uFtgbTQSc6qYVN8wwEeGc98gPANXoA8pLWPx8QbTRbr6j6PQWigl6DXcIby5i6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIY0YahF; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIY0YahF"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2c1092cc08cso57779eec.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 09:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773938254; x=1774543054; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=67rtTIc1eV4fOf6qrwHivv2z8tbZtz/zqN7qusgUfI8=;
        b=fIY0YahFuujhgsLKmni9EAImv2QWPkm0Qb9H6jHK4pFZbmzvo5ddDtnxcg/+o16x77
         YvwIptLjH6tL2WgQMhctXe7ra2ldChwg/RGz5WHK/N41ZCHRAjC4j688n2ROtyIzCja/
         yKI/Ndtu1N+2UNcMN4/cXz7Po7oWQN2XdCYPhqPhb+dzP3bG274rhOn5aDeqOihsz3I2
         XdTJ82fDsWK26G8PmLqKeUcI9W2YiWGL+ItrX/cxq4HjgtzxgqLPoM0qlnP9M61+iSIQ
         dNmqLTqUIscTgPwz5rZfbeHmkremyLeiq4qzg+E33aOZfYaAcjHB9C65yGVwHzy5Mi7i
         04SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773938254; x=1774543054;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67rtTIc1eV4fOf6qrwHivv2z8tbZtz/zqN7qusgUfI8=;
        b=SAgZFZMCd5uHyV86kL5SxSnlzZBukwrYuNwmO2k0WofeeVuBZtXywWif1TQJGs3UCk
         yQo9iEsfzqwQjQ0C9Azs/QPB5ypUCTivsDBDWffDdTZe+uWBWwlNWJKWxSJEavaaFB0h
         Ma0/Enl5ZCU5etR2xrqn3ErvTrlCuQmrtvkK9T0DUs/0roQhO9IzDe/lTqWP9GOOo1cB
         SZ0v4+z42FtpWDI/HVfa2N0sivjMtQuJUjETOvTyAyduPj6f2UdRUoLuBeQMLmO0TXwX
         X+Yca2l3sijSFWS9IiU/DYclFdePsRGYPwkzJrOyZC7GprZDpY/d+pWOwl5Olqz6tCjE
         br+g==
X-Gm-Message-State: AOJu0YzWdF7O/95J3AMRWGEjR2KEnfSfQIqEKRah0KHMUARZcqQQFhKa
	UIU8zppEmwnsf99POgufy9LdfBIgy8hKyDzsCsEl8aIw+254gYNLYJzjNND6vA==
X-Gm-Gg: ATEYQzyY2obsTbAJmBOva2kGWRW9xKOBVvBhm18KacTuvIIsxe2h+P825XRFcDuQKJH
	snweJimaP19BY6YgTTOBjJfXEwt6r7rvSv6KVMH98G4M5fJ5ahf2EvyXMgYd9uqR/ONNVaz48kN
	UBiotYKwpoXao/f8t1bwAB0KYf+olAmqLFxpdLdFBJXXJJo8q3o+Be83DQw6kaFcR7TZNABFPxr
	GYC5pmA3DwzG5+XIKfx3EyCJTP+mysKclvPLGZmZ4EhoDHWOE+Z3cxQMJ5VqfzvbaHtIGnhvDBM
	EOOk4VyybLa5ma8ymjz8dLe0fA1y3a7+HFpT1KIItM5yRkThqz6XxHi4qyiSXJri1rIGRnPnfCj
	3hXX5fCqenvPLC0RJYalRBneb9poTrW1EMRAr52M+N/Ksyg+6KHJwCzKIFysqYUT4PvBWRc8zXR
	HYD2PB9jaTDxQc1Psp3EZZIt/yleVT
X-Received: by 2002:a05:7301:9bc8:b0:2be:8216:57c8 with SMTP id 5a478bee46e88-2c0e5115c54mr4064567eec.30.1773938253954;
        Thu, 19 Mar 2026 09:37:33 -0700 (PDT)
Received: from [172.17.0.2] ([52.161.55.200])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0e53e616csm8848544eec.13.2026.03.19.09.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 09:37:33 -0700 (PDT)
Message-ID: <69bc264d.050a0220.228f92.e8bc@mx.google.com>
Date: Thu, 19 Mar 2026 09:37:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0868601292214015863=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, imv4bel@gmail.com
Subject: RE: Bluetooth: SCO: Fix use-after-free in sco_conn_ready() due to missing sock_hold
In-Reply-To: <abwSbezp8_z0K_eY@v4bel>
References: <abwSbezp8_z0K_eY@v4bel>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0868601292214015863==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1069343

---Test result---

Test Summary:
CheckPatch                    PENDING   0.45 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      26.66 seconds
CheckAllWarning               PASS      29.30 seconds
CheckSparse                   PASS      28.05 seconds
BuildKernel32                 PASS      25.49 seconds
TestRunnerSetup               PASS      576.43 seconds
TestRunner_l2cap-tester       FAIL      29.41 seconds
TestRunner_iso-tester         FAIL      35.97 seconds
TestRunner_bnep-tester        PASS      6.38 seconds
TestRunner_mgmt-tester        FAIL      115.59 seconds
TestRunner_rfcomm-tester      PASS      9.66 seconds
TestRunner_sco-tester         FAIL      14.31 seconds
TestRunner_ioctl-tester       PASS      10.16 seconds
TestRunner_mesh-tester        FAIL      12.55 seconds
TestRunner_smp-tester         FAIL      11.03 seconds
TestRunner_userchan-tester    PASS      6.69 seconds
IncrementalBuild              PENDING   0.55 seconds

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
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 94 (97.9%), Failed: 2, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Server - Set PHY 1M                     Failed       0.123 seconds
L2CAP BR/EDR Server - Set PHY 2M                     Failed       0.122 seconds
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in le_read_features_complete+0x7e/0x2b0
Total: 141, Passed: 141 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.106 seconds
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
Mesh - Send cancel - 1                               Timed out    2.738 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds
##############################
Test: TestRunner_smp-tester - FAIL
Desc: Run smp-tester with test-runner
Output:
WARNING: net/bluetooth/hci_conn.c:567 at hci_conn_timeout+0x15a/0x190, CPU#0: kworker/u5:2/54
Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0868601292214015863==--
