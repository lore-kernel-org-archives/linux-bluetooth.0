Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com [209.85.219.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268EB1DF723
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 22:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766009053; cv=none; b=c1rLql+rQAF9zXe7qimXA//hqtKqpxz/DjzqQuqvXNz/xEmx3T4hmmiXw8c3cvLKo8kb9M/ZkYdPqL055LIWiP+cHtkKKdnD6Whx7QOkKRsCxCDrcv3mA/4YqYS+ZpiSiCLChGJYodHgtqrEhXhXBH3Ciy1BoGJTc6F5FQfZ7PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766009053; c=relaxed/simple;
	bh=SQWhB54VQ1f+1eq2hX8qRBgjViQ3hd7avYVacBCVEnw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=iiaMNLwiTVtS8VPJC4hri/BicGLjDZJLGKUcUGI+sgwxunMxdiIF0FCIM0nh8gsKDpg1sEP8vncqYCOlg7o7fhAehWk1Nrb7lFQYm1duqtwhDAm8wYu5AXG5t5hQq/Eajg67LO3GU+Bv4Pdw+UaoyDLnMkaFKqiRpUWezhcTW3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArDC6Mai; arc=none smtp.client-ip=209.85.219.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArDC6Mai"
Received: by mail-qv1-f67.google.com with SMTP id 6a1803df08f44-8886fdf674bso71107686d6.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 14:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766009051; x=1766613851; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9hV87IL8Z2TNyUDv26/6XDwfHMs62GBBkyOnYcCSFLo=;
        b=ArDC6MaiQO/Bf/Gog2oycomRLP/ufiq6hLsLKYk2zcV5Y8NUpbFJp5kc1zElV5RKrJ
         si9amaq+7rhjIIAmtUXFjaN9j9aOz4v8VdPbVcPoPEu2gZoH2TV41uUdZqqnITA1uhjt
         uZzodPzvtV8H5133jz8BvPn1YyTGtpJ7I1O8r1mLwO+o+xui/hD9kHQNS0s70AiU4/jk
         TmNmAkCOgMU5fuT003STJ0uKnaJVYVnDekkJPfQRBMafzHJrNsn3zYg3lpW0a6GzVb9W
         jwz+40ZZliUUllS8bZtdsnseuc1BgPy2k0pLSCXOhbFZwVWI6BbQQlZ64DpIYtSoIj6w
         EHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766009051; x=1766613851;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hV87IL8Z2TNyUDv26/6XDwfHMs62GBBkyOnYcCSFLo=;
        b=xP9+SGA34YYKfFdXm7bA2KL6FFqGkYgGIbIAlTIfk+PBMNGK5+cCIw2Vawu+9FnAPb
         n/6DCNH0ZCiOv5X0YQzvpcBaygzka6ruFMUzX7QQa2+08kH42ZuzKHHyJonQNSC/50nU
         jC+/xWrUH9DnjwVQYe4AdEpa3q21EFfP74S1oAnqCwdgLzy8nen4OkYFJTSh2jDkpWUu
         3L20+RLIErLuEg/t+5HNg/qWyzO5nm8RSRo46/InQHSyWu5rQRxKPih0dVUdrLeypvKx
         nyYJhxRl0F8VXUw61s9ROM7cEjgQFzCq1GL6QLMubP3zWs6BFbn6NZCqZU7vr6sDqpFZ
         2WSw==
X-Gm-Message-State: AOJu0YzMA9hBQVOz4wQBIg9RUs6QJx7IH+cXtQUwoPPdMI2JKWvhI2YS
	ckcOq37hSyx23L3f95AlDjAEfSY3y5tgKHsZdsXiDMcMjVEdy14urTiFj4u59l9b
X-Gm-Gg: AY/fxX7vjlRoBue6vxl7Nm8pMSQUtVMfk/YebS9aHkLqei969DMUaNih2k7zfG7wgcv
	veXoLhAJ+0TbsC+WERFCPiZx3JtEQRkwGVBjM2dbluR5Eeob2qvtvc7Dyx5mV4KatbcS5qS6QfJ
	SUgy2DrzBA2/qXHmKWejCYYLyPFRi/MIaMBuG/bUjlUN9BFojYfv3W7RT9YI3nOC1woni4g0ZOJ
	UoBbNxqeDgYQ6Fx3XXnRqi4ZwXwEx3UJcSKEVOxUzCaS8O2Jp+ObKYVTZ7cM5+u9pQSNDDsJeKi
	WsaBWDZib5sYGlB0cyK8zk5bae81hyBQwwTZJUhYNV5WGjxhURcPobH+hWfC/OKwAf6OGafOmp8
	Y7c9EH5O7sN3UOQL4cB8qKZbSXnSCLNgFxH6J5YSeQ3qDJGoyFDyEDg873mzlNBTRgUNGGIkqno
	XqCIMfG/GZZsuY+Q650Q==
X-Google-Smtp-Source: AGHT+IHz4O7vTnfhy/eDbOd6cZjnpADVPd5qENV62GtLRaV0wCZy0lZJ0aFN016t76y/pO1l2FaNYA==
X-Received: by 2002:a0c:c24a:0:b0:888:7bac:7a1a with SMTP id 6a1803df08f44-8887e42dfccmr215164676d6.32.1766009050605;
        Wed, 17 Dec 2025 14:04:10 -0800 (PST)
Received: from [172.17.0.2] ([172.183.131.16])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88c5e169c8csm4753746d6.24.2025.12.17.14.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 14:04:10 -0800 (PST)
Message-ID: <694328da.050a0220.32a1a5.baa5@mx.google.com>
Date: Wed, 17 Dec 2025 14:04:10 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1853096358761750813=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ssorensen@roku.com
Subject: RE: [v2,1/3] Bluetooth: hci_conn: use mod_delayed_work for active mode timeout
In-Reply-To: <20251217162112.444181-2-ssorensen@roku.com>
References: <20251217162112.444181-2-ssorensen@roku.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1853096358761750813==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1034349

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      24.48 seconds
CheckAllWarning               PASS      27.05 seconds
CheckSparse                   PASS      32.09 seconds
BuildKernel32                 PASS      24.61 seconds
TestRunnerSetup               PASS      530.15 seconds
TestRunner_l2cap-tester       PASS      25.88 seconds
TestRunner_iso-tester         PASS      82.71 seconds
TestRunner_bnep-tester        PASS      6.37 seconds
TestRunner_mgmt-tester        FAIL      134.87 seconds
TestRunner_rfcomm-tester      PASS      9.56 seconds
TestRunner_sco-tester         FAIL      14.58 seconds
TestRunner_ioctl-tester       PASS      10.33 seconds
TestRunner_mesh-tester        FAIL      12.41 seconds
TestRunner_smp-tester         PASS      8.67 seconds
TestRunner_userchan-tester    PASS      6.69 seconds
IncrementalBuild              PENDING   0.76 seconds

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
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.108 seconds
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
Mesh - Send cancel - 1                               Timed out    2.713 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1853096358761750813==--
