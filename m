Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C69740D586
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 12:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781441832; cv=none; b=jYaPGTMI8W9NpqoYWfUQloEw9RcdlOwVxhNg2gAWAD3z9wBmjtCPc/hOcJOkOadYZbpO5SvUn0ldKkPAEd3phJi3yaXcPIbnTMN/jexr6D7bhxYAVfXtZeadbR9zQ4WGCpts8YfFlYpieKR1Licl1rfY+I9rz6CWZ2uOLSCrp8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781441832; c=relaxed/simple;
	bh=GuYb4IkVwXX333as4I0e8LoTdwdpX+NuiAQLhOWYckU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=sX304FcewEDbZbYKbr0P1Vue5WJTRDnTbqnfp4pI0+3qQn7iGXpJkpb8uewr2j1YH2yYJtk+3kfneaAUbgBhzJBcytqn5+IskLy5tA28x5q0xgPn6Dn8NsAFslqZxVvyDexnG2aeGJWSM7ZuPt8VfcWANp1Juorwf85LKghDP0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXIT9CNl; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXIT9CNl"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-30759632453so2709412eec.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 05:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781441830; x=1782046630; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BYWGwO4ryIuOLAl0Oot6fW1kuAOQ7mlmEMgstQIMDNY=;
        b=LXIT9CNlaPm1UqBuGCPoq03dAqDzMCYdpPw49XUkG+HLFz4mqlbO1gK2toGUMxXSFU
         1eVL0Sjo74AtqkoWm8mpD3cpohYZ5ZFdOCzee4qMR46WHhWqRBRwgDnmdRHYjqhMStX6
         OdPIk7OliUN1MCpl68DQMHxbrOT9lwiOC4UP3Dj0PlA7tkkyM6Q8Ua3Jes9sX1W/S40V
         A9pSt51SSqaYg/ybh/WEy4GXH4FbXnet1PsXLH1klAFcZYerKHZzvU+WJsRkiQygbzBl
         qWVovnxjwY38npc1l2+H3AqrQ34T/Gz+pYuEeq3EFup5XsMpHj/zs3JtT9qa2hxNV+rl
         /P5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781441830; x=1782046630;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BYWGwO4ryIuOLAl0Oot6fW1kuAOQ7mlmEMgstQIMDNY=;
        b=flLhq7dbwtSUMa3iZ3nLHxig6IO7y08k/Hvmj6Hfp7IWFyQuOp5CQXDO5q+XoHrBAB
         sbqZQNo3FABs6PafrZ4lUJ6K4QWzZ3D6SoeiaaRFD/tzZFG5tRJH23sHRjrHwNCXvHUV
         ggS+DDGG1bOAR1Ai5JfQKdJ0e7owxeW86yQPb0ug9ZlVXWI11DzBcwKKVZojh0smCalx
         8PES51g0IGULWV3cHf+vH/s7iVBH6v8t5KQXPdqSbI2woQ/7qVws7P2VOZytIRa1iwCK
         dPEiDXX6JlDdOC5oQq0XoHOItG0lBv6+zt2J+NsDvhdjSxlWZOCujE8+CvveKK28x+mB
         hcHQ==
X-Gm-Message-State: AOJu0Yx9xjLZS+c8xJxaLL1Vnya9uh57Hpu/DLjJfjY0ISttMHm2FrCl
	qSijOlH2i45J7acdHtSeK4MNrXquUI0sUOPvN3wmEvCm4dTlpj5ouuGykJCA5Q==
X-Gm-Gg: Acq92OFPNOwGXiZzaVhc2r0OyeDrA1/SmSqsjh/yz89OwNvu6L/GiaFwHWmQhOYPIAP
	E4/x16QxfdDr5BUoIuSvyf9BfWz4wqS1HoRB+ytJ73v1dEZXf3wL4TCCZuWu9f8ljLhmn3olP9b
	+JFBHuGahHftc1ovSSx7jgt9vUJu0Bl6FNNaH+VwdzoRlQaJ/J4XepENtMDYWb9+pRq4z73fNzm
	+kO0r2rB4LaYXC44/ruV48UM8fRzZK7Zn2sUWeMuwFIiqbFkaXKJMujfH9TZoBmg7CmwNjcrW1G
	npXYxnSOVKqjeoQr/KYR9eY4vvBXG/t0UaYXUtrdXlrvnzlRMyzZ3kcEs3TpzJ/HZBJINIAHQUM
	cAWtYJsJmRwSmob75GvsgQQCHi9VslAkF6FI1eixcc97TH48/flTZ0ff5y8d9FoYGMeLIUn0/m/
	C1Joa3HQcVmJK1kd3IfHJYgDdgfazZv54=
X-Received: by 2002:a05:7300:320f:b0:304:5644:f97a with SMTP id 5a478bee46e88-3082009bf0fmr5768547eec.21.1781441830046;
        Sun, 14 Jun 2026 05:57:10 -0700 (PDT)
Received: from [172.17.0.2] ([52.190.182.120])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e48c3dcsm11502703eec.1.2026.06.14.05.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 05:57:09 -0700 (PDT)
Message-ID: <6a2ea525.6139c123.2df0db.6e31@mx.google.com>
Date: Sun, 14 Jun 2026 05:57:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0996188796800005579=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: enable context analysis
In-Reply-To: <ad7f2913bb19e81661bae8bc51ae89144fce433e.1781432726.git.pav@iki.fi>
References: <ad7f2913bb19e81661bae8bc51ae89144fce433e.1781432726.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0996188796800005579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1111252

---Test result---

Test Summary:
CheckPatch                    PASS      3.44 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.98 seconds
SubjectPrefix                 PASS      0.54 seconds
BuildKernel                   PASS      26.52 seconds
CheckAllWarning               PASS      29.29 seconds
CheckSparse                   PASS      28.58 seconds
BuildKernel32                 PASS      26.00 seconds
TestRunnerSetup               PASS      575.93 seconds
TestRunner_l2cap-tester       PASS      58.42 seconds
TestRunner_iso-tester         PASS      87.26 seconds
TestRunner_bnep-tester        PASS      19.12 seconds
TestRunner_mgmt-tester        FAIL      208.56 seconds
TestRunner_rfcomm-tester      PASS      25.04 seconds
TestRunner_sco-tester         PASS      32.00 seconds
TestRunner_ioctl-tester       PASS      25.73 seconds
TestRunner_mesh-tester        FAIL      25.83 seconds
TestRunner_smp-tester         PASS      24.88 seconds
TestRunner_userchan-tester    PASS      19.72 seconds
TestRunner_6lowpan-tester     FAIL      45.81 seconds
IncrementalBuild              PASS      33.20 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.236 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.574 seconds
Mesh - Send cancel - 2                               Timed out    1.991 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
Total: 8, Passed: 3 (37.5%), Failed: 5, Not Run: 0

Failed Test Cases
Client Connect - Disconnect                          Timed out    5.323 seconds
Client Recv Dgram - Success                          Timed out    4.988 seconds
Client Recv Raw - Success                            Timed out    5.015 seconds
Client Recv IPHC Dgram - Success                     Timed out    4.978 seconds
Client Recv IPHC Raw - Success                       Timed out    5.004 seconds


https://github.com/bluez/bluetooth-next/pull/314

---
Regards,
Linux Bluetooth


--===============0996188796800005579==--
