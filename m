Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C6327BF7E
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 08:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752050432; cv=none; b=JU1QCJpiFgevvvzwFqFtjIuVFRuJ9SALg4alu0Ep/AsAY5OkhTzsJQhYtWIMqdqDmK2GH1Y3n8750w1mc2iABbVH5iOtgUI80UL7apIV0Ae/lGi3AAyxlUo2u2jU5VqE+wbAsFb/aLevegckM+uSLCKAo1aa1X0Xv42Rxj66VWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752050432; c=relaxed/simple;
	bh=eWOtWicaCj2ZTYLJ7KXvRe4H7g+OR+ZBR9G/afDFqG4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cUMsLPNGdqsMT03PWzQVHwJdBgUbimkUIRRHvgnka6yGhU19/FwpLw6uQgTSzgmjR0MkL+rgu3JG3IFSL1Wls8AimeKXgX5+UeBXEJS7Styg6WNkHDJ1jZTN8tiZKKCL7nk2EzWngATLBCxX7gNytteDSmSVBfveK0i0k3qFiqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9MHIS+R; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9MHIS+R"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-749248d06faso4244270b3a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Jul 2025 01:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752050430; x=1752655230; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L0yofl9yIYhasIFy3el376hhgLe324m4CmwRmGAbDac=;
        b=Z9MHIS+Rjt0S3CTYoXRIUKe8Jd16Pb2Dq/lDLeGLs6Tg39cYVmx8RZXwNER5B9oQKb
         t5cNpMItBUeFZlXaoUVuoyd9PIDI3eaF4TmcJhbzlVhQBY7K22AXf0iP0JYI51TeS3qk
         a2MM8BBuzAk2fR9b8dTymI/8f/H4EyhRsc3GHidNx7ieJvrbllI3fhl9Cvdz85INcm1C
         zRE6lsyhVpSJ3W+cpmM8lngGo7aF9XYph1HQxhW6YK58HaRQ0m/Jak9khXVL4aQ1No/d
         AtvoGOJ7xS38AC9FiA+WunImIkHRUSfDzPDYuhrHGLzeE4yVFwuETUrvyS8Na4bhgikF
         v9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752050430; x=1752655230;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L0yofl9yIYhasIFy3el376hhgLe324m4CmwRmGAbDac=;
        b=XDdMAQ+lMQdg2j/NMFcR2x2puXd5Cf5aOLnWwIemFgboXep64ECqEgxrlufoWZgXi+
         zoui/iBt+j9p2uU6ptCUKLhNmDDo96m353phOnsgC3599b89lsQCrKVCUC653rlC3/DT
         SU9NATkqMtZz/QlmsKNAnOl2Co6cYC7g44nt0hOcLFWQmRBnwJ1WOzDcrByUHsEFruxA
         f910NXZ6ymiK3RAs1K64h80cA0Hvm2nT7FwWJsghDcY5dd/1VzaJbS2LwVI1K/jx7q8j
         4r+15R5WMAHC5tgBmydGQ6BjB2Ug0Q+V1Cjd4SsrWlp86xL8Y12S6gNHPu3cxkd33gII
         +AQA==
X-Gm-Message-State: AOJu0YwUIGY2aExO7xPLxvfYA9IFa/BPXZS+Hdjb9i29opgkooA1AGv7
	9SMyeJncUXGQAJ9bIoLjHtGL/c5DGFpYXZl3/juTxDsqm9pXs8CaUsyWWfXIjQ==
X-Gm-Gg: ASbGncus2DbDe+zx+obru7NPpK+DwPskfPZHJBeigb18Y8EIA871BoO9gkjZvfS8HH3
	WZWq+R4e8qadCR4rmV5Z9PvAzY7mZMQO0ifa4h9xSCSRf4SI/uuNj2Cy4eLF/mBtqAvXtpBjktu
	n042kI4LA3e0MDSL/yWhcPnKgXFiTXeedouyg+5vvi1oxzublcyMy9zgO9Wh1tK7uLm0Uo3oSTT
	N24BjZRGcO9mHiLiLdz4zgKnY8BFT11JbVSznut1ghEslFbZPcCIuYFQeVFY6bpQiF9AD5yxezd
	RPMnLUhaUNXq86W0KaZw8EgUrRikx9OwI/czha/oPg5G9WRAQqeLWW7ov3uwUW8GuaY=
X-Google-Smtp-Source: AGHT+IFjfWaO5F9iMX60MZjjXMa35Rdh9TdWx10THxpSJAwJlXYxizjFPhurNxyNZj/u+0OCfYHOYg==
X-Received: by 2002:a05:6a00:3c8c:b0:749:ad1:ac8a with SMTP id d2e1a72fcca58-74ea6684ae5mr2717278b3a.11.1752050430212;
        Wed, 09 Jul 2025 01:40:30 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.140.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce35cccfasm15129722b3a.58.2025.07.09.01.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 01:40:29 -0700 (PDT)
Message-ID: <686e2afd.a70a0220.183b31.d5cf@mx.google.com>
Date: Wed, 09 Jul 2025 01:40:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8732604812107273506=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, alex.gasbarroni@gmail.com
Subject: RE: [v2] Bluetooth: hci_sync: fix connectable extended advertising when using static random address
In-Reply-To: <20250709080213.6097-1-alex.gasbarroni@gmail.com>
References: <20250709080213.6097-1-alex.gasbarroni@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8732604812107273506==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=980377

---Test result---

Test Summary:
CheckPatch                    PENDING   0.46 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      23.74 seconds
CheckAllWarning               PASS      26.13 seconds
CheckSparse                   PASS      29.93 seconds
BuildKernel32                 PASS      23.86 seconds
TestRunnerSetup               PASS      466.09 seconds
TestRunner_l2cap-tester       PASS      24.86 seconds
TestRunner_iso-tester         PASS      39.74 seconds
TestRunner_bnep-tester        PASS      5.83 seconds
TestRunner_mgmt-tester        FAIL      132.13 seconds
TestRunner_rfcomm-tester      PASS      9.17 seconds
TestRunner_sco-tester         PASS      14.62 seconds
TestRunner_ioctl-tester       PASS      9.94 seconds
TestRunner_mesh-tester        FAIL      11.40 seconds
TestRunner_smp-tester         PASS      8.44 seconds
TestRunner_userchan-tester    PASS      6.13 seconds
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
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.172 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.240 seconds
Mesh - Send cancel - 2                               Timed out    1.992 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8732604812107273506==--
