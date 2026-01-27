Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com [209.85.160.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516B930DD01
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 03:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769485394; cv=none; b=igwEdUkO92m6QIJ3xzZu3VQfD7RE4tBS84EA+ciNrP40pTaQC7tZ/JxGQYlSZl3lSEv3guVVRHUkd+AhY3/2GhCBXjYiKzvOeYxyEzr0GQsqQXbg6z6YLYuLXyadUR8hwdcPBP/vJ+alDXqQXONgGV6/JpayPbTLjW2PxZDEkJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769485394; c=relaxed/simple;
	bh=SY41OKqZnVkPXxdH9O7fhbxj0a3NZnDA1j+tq+4oSvw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WX1LZmfnQAzlo8Exi6I6y0hbaVff1ELQsOH7Ort4MU9R1k5YKiaE167/qqNi2WtdOxLFMqymZA8nxL0zl4f6vWolJ+iR6UcP7EYMT2G8vBvoLcHLQauNRX+tpTLZRO5kCvARK7430m4sXEG30qBKM+CbLCLRu/OSKKoU9hr0tUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DYDKPe4d; arc=none smtp.client-ip=209.85.160.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYDKPe4d"
Received: by mail-qt1-f195.google.com with SMTP id d75a77b69052e-502a789834fso44590951cf.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 19:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769485392; x=1770090192; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oqlHbA5aXTteTld9YTnPOAEOBqjVJYtnXpNhembmqI8=;
        b=DYDKPe4dtyBuBRyKaPmQ6IcxQ8yIduwsSHaVZEQvEKBHXAms8KEA6Prb5tVWVn9V52
         oe3loOQSmP9S/GaRf5jqhwWnm7qAwAOy3t9xg7BMHmL0ECsC+Pyq3BK9P1V4DYBy9BXC
         qrTOsaLX2NwdFkQyTLcR5H1sH4f1aDRECRFHjI5XO8qLh5vNl/TB4QMe4gyOUpaJst0W
         aBn+MV7sSiGMlHZIgAPfIc/jc5ljov9LDH8/K5R8aANDvjxbIu21JpMf9juuUOZlk76X
         eYDygfXVuGQAh5bV9/LhAvPQsxzHdzH1CUuIOs99ZQXZzKc6gEHHgyGL4RoQ4lxFkYbz
         afTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769485392; x=1770090192;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqlHbA5aXTteTld9YTnPOAEOBqjVJYtnXpNhembmqI8=;
        b=pzsp9IyqZSDvPUs05/V54SrT1Oj1KTAkN1uG6GhDxDj/zcaav+6WuOv2+xb3XPVgwj
         8RkZVsVyoXe9QqG2oBS+l01fTWWjlw8Q3sdPpC75cZQubQbWlBJbhXjFe1pZPZ6wO/ar
         klQp6/2pPMkklf93Vz3iPIqMyts1W0OGv9FuilJahij9nU5NGALd24MLAOaImXqrmZYe
         Q0WjQxhiCE61vUCPkanXS39oSfl8rgoPQsWd36sxt276Rjw6sdNTZhtJl1Lk8/92NVof
         XFrQGukK7UvfEly+fPzFzMsYX31sTyOHtipJfEcPAMjREmIeQ0J1UB0QKzp+bOSL/3qE
         WOLg==
X-Gm-Message-State: AOJu0YySYjtxxBQRCinGxGZlj7ztmcA0ee2IpvT73vJNUnXhdibi3k9k
	ZMP1u4RllCXt9nU7L1bTUoJyrRoJnra5gO6IJqNPdrncojjDiG7qvqv8coVnf8eU
X-Gm-Gg: AZuq6aLzBLZHqWXxer3z3H5bNgEtNlcbqcyFFl+yxA3nI+1ooWLvM1rNsMo20ecPWh7
	Cq0OvblE74780TQKuf1TKu6kfGkszN8cXAfVklzlxS3C3wgFQO/n5cZ6C3uCObl9cELJ6Mhbc06
	vyxEOEluMy74JfgidwjboHJ9pwXZueLBNlUALz91PWBn/uqAxfJ3axS4/BP9o8ZOLCR7sMHzQsP
	U6jqFeLNDDNw38LxR02mgqBBPWjgC1HfEoHRRV/oI6JVAaAxNisHiitCBy0r65R6Sm95igZU42w
	iOgG0Tr+TLAr9WOTEM+0jAXXREsMDT2mxBaDHY4MvQVA3vrOjAQnGKpApLbkjGHcOVpItqXqzRc
	9K7tGMtXpGahUAOuGFSndUWdt+tXvdUheczs04LE8z1We6hQRmu3fMGziQZKj3ZUVe4ZAO+CdHu
	Il7/Wj2/1ZMeR18Nk=
X-Received: by 2002:ac8:5f52:0:b0:4ee:bac:e3a9 with SMTP id d75a77b69052e-5032fc1a7b9mr3523191cf.68.1769485391940;
        Mon, 26 Jan 2026 19:43:11 -0800 (PST)
Received: from [172.17.0.2] ([20.55.13.162])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502fb8e74ebsm92499571cf.0.2026.01.26.19.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 19:43:11 -0800 (PST)
Message-ID: <6978344f.050a0220.21ae78.b632@mx.google.com>
Date: Mon, 26 Jan 2026 19:43:11 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5558350807920842344=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mengshi.wu@oss.qualcomm.com
Subject: RE: Bluetooth: hci_qca: Refactor HFP hardware offload capability handling
In-Reply-To: <20260127025423.1418207-2-mengshi.wu@oss.qualcomm.com>
References: <20260127025423.1418207-2-mengshi.wu@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5558350807920842344==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1047345

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.22 seconds
SubjectPrefix                 PASS      0.26 seconds
BuildKernel                   PASS      25.18 seconds
CheckAllWarning               PASS      27.98 seconds
CheckSparse                   PASS      31.47 seconds
BuildKernel32                 PASS      25.12 seconds
TestRunnerSetup               PASS      557.27 seconds
TestRunner_l2cap-tester       PASS      28.78 seconds
TestRunner_iso-tester         PASS      55.61 seconds
TestRunner_bnep-tester        PASS      6.30 seconds
TestRunner_mgmt-tester        FAIL      120.79 seconds
TestRunner_rfcomm-tester      PASS      9.50 seconds
TestRunner_sco-tester         FAIL      14.70 seconds
TestRunner_ioctl-tester       PASS      10.14 seconds
TestRunner_mesh-tester        FAIL      12.50 seconds
TestRunner_smp-tester         PASS      8.57 seconds
TestRunner_userchan-tester    PASS      6.68 seconds
IncrementalBuild              PENDING   0.57 seconds

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
Mesh - Send cancel - 1                               Timed out    2.772 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5558350807920842344==--
