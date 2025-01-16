Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8A924A7C6
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jan 2025 03:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736999797; cv=none; b=KaKdMCc4ZmVjWkSLoSnD8DMKd+ODxvlFbBplPr85xNAaiHMG2Bmpq1QxS0Z9SqSoze9cncpLWEyCn9KGFJY5iLyDcZR7J4osjQizl/PRj2/cjnA5p6D4GGH8ccOukq8yDPw6twGwieFZ2Ai/7Fu3Q/lpP9UDYFlUTOqGai6WmFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736999797; c=relaxed/simple;
	bh=ntjALUerVNY9Lfv99LMJD0TBPlhdRMmSx4tm8Nyuq5U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=c17no+sTlFVDEevP6A8J9H3rhUKDN9v4Cq9k5A0B4whHYfWLCTdVYVXFoUw4FF7SObG71UgdoowEQbzD82gIJVCoPOdIGF5jBCTmjM6ooEYCvS3r+liieeqpg0uxFy2kYMMKC9rWWl7Xu2aF4B8xviK/LbyVhrpGYQXy6W8byXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpGpWz5e; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpGpWz5e"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2efd81c7ca4so707958a91.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jan 2025 19:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736999795; x=1737604595; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=00AQZ7HhrbTDijV+BZnN2seTaGwN1bJfYEEMShNF5x0=;
        b=BpGpWz5etnKPz/JZF+Cxyl1ugep4V+XYokijnvDo3mNa4/xTT8GAwm5hkL0bqaLoMy
         eeTJ7VjMbu45JF93ofxcJiDpPa+LM5PHG9f7bNXwjZlzRiP6ueh/f7WW+nj+TbgfNbkp
         pn8j/atN123nTCyoBBQ7OnYD2V+2RiB9/K6/H6YnEryrthrWTrlZO7vKg71rWz0QR7jA
         RLKmjYEkD/IVc/xeqI+54mEIz3MA+vLjOrISg+OSKGtsH5NLn6qHesHhTSHY7hMbiXTF
         XVQetH3HbEEJT9iLvqkLq3pksXLvYaG6yWBm00SpmGj0G/aLJenLQE7bW0b6yKCGxrnE
         WzkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736999795; x=1737604595;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=00AQZ7HhrbTDijV+BZnN2seTaGwN1bJfYEEMShNF5x0=;
        b=f7z6lRvjrGHl1h+wE6jHSmw4rj6Vb61lngrM638NKyCvNW30Ljqqd07E60xQTg20WH
         K0z+ewWu27YqTO0SEu5UY4fSxoInFVfhgI5tdTfbMi3QDgqjDwIjSLjfOiV/XyJxpHGt
         R9hoNhXsKjsJ9oyi0Nn455D1KHkA0JHSZqDn+GR8tu9fxMlMakWTXbZL1HP4iK56vNOW
         /4DjXICVEAdFCSoS1/zYebuxwBqvrP0LHX84bC+HOPvTnDt6MytzVph7WYXDj3PHIPhg
         0vKuDiC/4WDfz2Oa2VHHu8C/Zo1C8GSXHLDhf35bBPQ3bU+FiT5OyOyK71POjcHmYG8X
         aCvg==
X-Gm-Message-State: AOJu0YyNUt8fS7D2CiApdoohkw482Hc9TJlMUYZUxl+6jd3QzRdPlPLI
	8mAyXTpl0kXNau4qB4sXKXt7Cj6w6VQ4QW+j/d7MOdgAzCyuM3n+6+YV6w==
X-Gm-Gg: ASbGncuwQMtHb9lQBrijPWR/DX9PuinT3Hd8PaqrzRc4xJlWLUx/0L13wgiV9rLq8g6
	Btw7KIZW4XF+ZWQ6MXSxNT8VJs2GsBa8CJs10unzBTj60wuF+t8/TrV1P0UJuXMhOQkzf6lO4n1
	bHuuvvTAcUfKMwdYy5Nze9eDNXkk662nNH8/bCM6NDRLIlTsJygP7ErJJE6guB07dLuFn7DxUBL
	fgnFTSOF3VwO0xLHJhLToepRfHIbkate+JLhWH9PInX7L363TOCkTafm32Catv4
X-Google-Smtp-Source: AGHT+IGt230PVNJLPbiDgdZHIWWHms7uWLkYfEWMoTOsw5DuzV0aHxuX56fLk4/lKGQZ7OxuGTCihw==
X-Received: by 2002:a17:90b:3bc3:b0:2ee:bbd8:2b9d with SMTP id 98e67ed59e1d1-2f548f75de6mr38595105a91.34.1736999795071;
        Wed, 15 Jan 2025 19:56:35 -0800 (PST)
Received: from [172.17.0.2] ([52.160.165.133])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f72c19a5d4sm2408967a91.17.2025.01.15.19.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 19:56:34 -0800 (PST)
Message-ID: <67888372.170a0220.8c689.0f4e@mx.google.com>
Date: Wed, 15 Jan 2025 19:56:34 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2872325840866430891=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dianders@chromium.org
Subject: RE: [1/2] Bluetooth: btusb: mediatek: Add locks for usb_driver_claim_interface()
In-Reply-To: <20250115193636.1.If8b655b5c6877bd9a1136ba0f1cd61cc6a4b6e9c@changeid>
References: <20250115193636.1.If8b655b5c6877bd9a1136ba0f1cd61cc6a4b6e9c@changeid>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2872325840866430891==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=925915

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.28 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.65 seconds
CheckAllWarning               PASS      26.88 seconds
CheckSparse                   PASS      30.75 seconds
BuildKernel32                 PASS      24.37 seconds
TestRunnerSetup               PASS      432.82 seconds
TestRunner_l2cap-tester       PASS      20.52 seconds
TestRunner_iso-tester         PASS      28.01 seconds
TestRunner_bnep-tester        PASS      4.85 seconds
TestRunner_mgmt-tester        FAIL      123.75 seconds
TestRunner_rfcomm-tester      PASS      7.54 seconds
TestRunner_sco-tester         PASS      9.29 seconds
TestRunner_ioctl-tester       PASS      8.11 seconds
TestRunner_mesh-tester        FAIL      6.27 seconds
TestRunner_smp-tester         PASS      6.96 seconds
TestRunner_userchan-tester    PASS      5.23 seconds
IncrementalBuild              PENDING   0.74 seconds

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
LL Privacy - Add Device 3 (AL is full)               Failed       0.210 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.146 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in run_timer_softirq+0x76f/0x7d0
WARNING: CPU: 0 PID: 34 at kernel/workqueue.c:2257 __queue_work+0x687/0xb40
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Failed       0.110 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2872325840866430891==--
