Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574B72C15BC
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Aug 2025 21:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756330386; cv=none; b=XhfT1gbeU5+ntqG3zTMXw4+7pflody/zG+U87k42swbtAM2frM2TQrldg2wYxvEvyrIbB7W0h9F02Te1GvVUrEPzRO+MeRmNuWUbnuCjQqeSuFn7LrByfni3tY6A3Oi1B6qbCduxrRyGsRfYe4AHG5xBHBoSX5IzEvVzvWXaYew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756330386; c=relaxed/simple;
	bh=XDRpPiulX9E+RxQYC5LdWtx8lOrfS7n1LxD0uioIRiA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LAAOIB7lASgozEZZ4XE/nKZYaXxh4L3bWgkY4dFC5REoD6iuB1GMV9c3fwYR2tD7fXWRRg7SDG48Hxxvi9pREBj6AiTBTtp0RHHmIEYNP2YXjevZgcEJgEBfilxqi/SZEXwGr3qBknFtShZHrboOwAmyS4M6YcSgvNzj2e3e9FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVC1rUj7; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVC1rUj7"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-70deaa19d5aso2757156d6.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Aug 2025 14:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756330384; x=1756935184; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=X8ZqWlf24nN0qHFkep3R4C6l+AzFRrTGzrlOv+iO83E=;
        b=OVC1rUj76DAxXkLkh7XjW3TZsrq6zgdqb1G7TR4AU4wY5WlFQEIuKIAvRytgujS6As
         MNRDlkKMSTNrzRq1t5xt/PoJ6JWwdKIhc13T2I0Met1E6+5OR1dLk/ukZ4h+YlpB1oUu
         ZaHsPyi56Igxzttq2DyXuFvXdQSMcWQiAKS7bwqeN58vh7L6WvWgz1TbBhY016rX3KUn
         jESgA5x3qS1AK/nsNXBpEzYiIpArc4GTLzaaQg6b+ONyTenqqtSuOFLS1Hf3y+HeRbRe
         4k+hcqC8CTPMQ1cCCoaPRRxxieP+PK+MzyOnQV5+7HPWRaj54NLoEJLrY0G0THiR/39H
         cHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756330384; x=1756935184;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X8ZqWlf24nN0qHFkep3R4C6l+AzFRrTGzrlOv+iO83E=;
        b=vqJAWj+Dw29HCKt+KzLTPoYj5ZGZAgyeHVN6Vvu9SHDi8ywt22dOE6apyR/kDD+2S9
         v+fys/sBXUZtjy2ZxbWf7fKgxz9kNVUy7skhQfnVphZy4hsXPQWWlaQU5pBlBPPt1JTt
         2/AUyeRfZ4R6j0FVBfsaCZhW18h9zUTAvl5oDS1TM8BiSa2ley8LL50zWnAJbJXKluB+
         LwJJX7DY7DwyQPrX8dMuNZRX9r/Xlz0bdk95N5iuCg+fhUB3P3IblZNwXelmJ/dbh8f3
         b1RcVS3lXTWpu0tzJCbxCa1uLxSTy6vMHCG3x5HAL5Mjc2gYNh+pHZoJJTkwtyAy8aM/
         QjPQ==
X-Gm-Message-State: AOJu0Yz9MMWDzsUywbuUZkqlyybx/BFNzt645ta/NtRXqCU7dmKjeOky
	kRT/9xQzmvhdBtrXMEGl0t4ZeYU0smFxPbolkzNkZRJuXhl1aXaQG+xYgbCehDCj
X-Gm-Gg: ASbGncvxTHPLJfe/f3Sab5sR0HhWjUZcrteFkWkNsH2ry4lZih1jIbyfZktfLvaCNuX
	Bgv5X78OUMdn6Z2UyqejFBJAfsUWLvFZDAxGOmKQL+DSa1Jwpf8H8EIi/Tu5X0rHZxCUkcgnm8t
	eOfMmtbMlQPcrdOT2ruaeJRzl0xhI6DoeTtrEb1iYELjB8yEutpjrIvW2iMMgYDmj4nQ/rTOVEI
	ggoinExJKU20Liv/J3aK5e3zac84RmecmztP24zU82pASVPPfCRGOBC1YKIVXv98WmpanZ8rRy3
	wJD1jK3finmgiHEEkKxKycZwJLCIVZZvjQS3YCxf1fTpAtWzvbJYScK0tPCxa8rcohtiAbxt7oz
	UJVpiJC/oSPZBMB5YB2VEWAuyuZEH
X-Google-Smtp-Source: AGHT+IG13U31LNmZMIAkauNF1x4KPnpWOy/wQb01POQ69+epnkC1WnmNMHSi2P4f3E3iuHHeBWMYhA==
X-Received: by 2002:a05:6214:5011:b0:70d:eaa2:e39d with SMTP id 6a1803df08f44-70deaa2e5a9mr24948176d6.1.1756330384010;
        Wed, 27 Aug 2025 14:33:04 -0700 (PDT)
Received: from [172.17.0.2] ([48.217.142.87])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ddb4bcdefsm28587616d6.65.2025.08.27.14.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 14:33:03 -0700 (PDT)
Message-ID: <68af798f.d40a0220.332f7.bbda@mx.google.com>
Date: Wed, 27 Aug 2025 14:33:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2310930906089159510=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kuniyu@google.com
Subject: RE: [v1] Bluetooth: Fix use-after-free in l2cap_sock_cleanup_listen()
In-Reply-To: <20250827204015.3712705-1-kuniyu@google.com>
References: <20250827204015.3712705-1-kuniyu@google.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2310930906089159510==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=996215

---Test result---

Test Summary:
CheckPatch                    PENDING   0.81 seconds
GitLint                       PENDING   0.23 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      23.97 seconds
CheckAllWarning               PASS      26.61 seconds
CheckSparse                   PASS      29.74 seconds
BuildKernel32                 PASS      24.01 seconds
TestRunnerSetup               PASS      477.23 seconds
TestRunner_l2cap-tester       PASS      24.76 seconds
TestRunner_iso-tester         PASS      36.63 seconds
TestRunner_bnep-tester        PASS      5.93 seconds
TestRunner_mgmt-tester        FAIL      124.21 seconds
TestRunner_rfcomm-tester      PASS      9.37 seconds
TestRunner_sco-tester         PASS      14.77 seconds
TestRunner_ioctl-tester       PASS      10.09 seconds
TestRunner_mesh-tester        FAIL      11.43 seconds
TestRunner_smp-tester         PASS      10.49 seconds
TestRunner_userchan-tester    PASS      6.26 seconds
IncrementalBuild              PENDING   0.45 seconds

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
Read Exp Feature - Success                           Failed       0.107 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.100 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2310930906089159510==--
