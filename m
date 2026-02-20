Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB74834EEF9
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 15:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771602967; cv=none; b=T8bGHb6uQZlpf1ql/NioYY4DoZm92zKRMmBUKng02Lhooo63P2bbCan5nVwA0mXX+sa1EGMhbmbGa/Wf9swp/D0GBbDKvbPzk5LuIoGSSFuBiRO6EY9T3AeTBSxv5seCWQv6AVjAayxJzAXkN3BgBU1m2tUc/rzVh0+pQvx6Xf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771602967; c=relaxed/simple;
	bh=q3vvlacidOFpP1aDrCByKCQiRhmL66f6waC8G9uCCbg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=saXhzPAgpBdbJejU7PJU3TEGMrHLh0czHDNUcaIw4ZIjxEL8a0ftdDkXW8SNfN/crHZ+bZuDRx3ucuoz0ax/psxZ1xe8me30/hp0fT+tW0pnXcOYDYeX3HCiZCthzRZgt523gSyU+BaIPXZ6k3CdA1sPnIl4XRwDVs+f11ZHizA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nF96YqfQ; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nF96YqfQ"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2b86ce04c5cso4271655eec.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 07:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771602963; x=1772207763; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K2mmHNVxW+zN832ua59ckvu1ScNFetYkqxXwl8F9j1Q=;
        b=nF96YqfQp4GOP7isHfe6gGFjkIUZePX69WLmCvwUBZ9hzrL5EKnVZMKBmZDU5b3SE4
         voPJavJTONetOyJMPOz6Z4ACAcTqqPE5PF4/ZTORW6/8EZUm1QS3GyJaRtg4n5GJqAXE
         zMPBHShXAONc1Mhl26zmSZhpslQ7z2Dw00g0DAOa9o9fig7gcDWyRhlpGyqw/IKDkGRN
         UpN0IM60YeLZ478mxbYpzDC8R7Z5+4nhvaaTE2YoqTZmOZvkCmj0kq/BL38mABDZunaF
         791BRoXAID7FbSCNLrTbwIw41pBV+92fxN+fSrgoEQ4Iz+ImdMCjxt97ixuCWGxW+MI/
         7twQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771602963; x=1772207763;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2mmHNVxW+zN832ua59ckvu1ScNFetYkqxXwl8F9j1Q=;
        b=bjIU1SF57y7jx4EfD2V69pEfDXqMasH3Pq2EWwrPaUzNJKiTMeWAFNWKilxLBtq01k
         ahXv6snCUe04mjE/9+spIizJURoWBOcfonqJXL3nH6fcETvSdQOdb1kh05U4VtrIalzV
         aQ5O6SWPRjDM8iRV25B37Xj426wdApT9Z3xjNtVKjiVeCfxDnIfjc5YMJMrFwDUk1Lij
         BI5VRmFniqEPWuXH7BkeZJJC9rpSUApq/0mPhm19pSWCEjEt0peR0kPkyIf4vCTM/i8N
         +63iPjaqyW5NaEYsk9AvpL8/xyfy+u9l4kue4fyahZRavsB7FX6k/B4zU7K9CLKtjk5Y
         zf1g==
X-Gm-Message-State: AOJu0YzYdfO1lfavfqCKRZG913iUoZM5uc4kt3zBWCdBw+14VemlF6q8
	n5lZoprQ/88PT6ZZM/hUjvcmKkLK1On5S91J0V1C8r8QBJiqyKXWx6RHV9X9fnsJ
X-Gm-Gg: AZuq6aIhZ355gjhPpLsVXWEH7bq3IvJn0XaNgSTcX/te4DQ6FY9JAhTOI2cDU8x/viU
	z4L9L3bclCa/eXTn1CjSbmPY+Bk6XiRWcq1gFKDHh1XySHibKouYpIrhuuEE13khT7Cn6OnCq29
	ngNlh6Nm6hwJj78KhMBk4tzYX+voJbsekQaeSj3MF0VmCOIX3f651lbN7WX2q6tuK/SmpXgST21
	dbkLhN2/Kyi+9KBiRkiDlHmSwWQKVCTL+urJkwyuBnU63bbvd45E61+oDS8oas5xVtPXSawXtfB
	5ygsw2vc9GEkMticNtWrRbPReyi9yjFkYhryIvp+3ucDBq9LZg7BLLNyYGdhx6fLEJ3vHNY6Ow6
	XLwsOsa56AZtUCTTXMTQlA2zxoHx5+afjvjPR4FYCpZCTHkfQUWsHYv7DfHT3zUqk+2TqfcWWqy
	cKm+/w7YCMn4B7FoOwxMSCSantxx+mgx0=
X-Received: by 2002:a05:7300:fd13:b0:2b8:1d16:9736 with SMTP id 5a478bee46e88-2bd7bd59c77mr21054eec.23.1771602962407;
        Fri, 20 Feb 2026 07:56:02 -0800 (PST)
Received: from [172.17.0.2] ([172.208.152.209])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb66c24esm23180030eec.27.2026.02.20.07.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 07:56:01 -0800 (PST)
Message-ID: <69988411.050a0220.cafe.aa75@mx.google.com>
Date: Fri, 20 Feb 2026 07:56:01 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0717466054265337233=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, maiquelpaiva@gmail.com
Subject: RE: mgmt: Fix heap overflow and race condition
In-Reply-To: <20260213060401.14200-2-maiquelpaiva@gmail.com>
References: <20260213060401.14200-2-maiquelpaiva@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0717466054265337233==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1053791

---Test result---

Test Summary:
CheckPatch                    PENDING   0.44 seconds
GitLint                       PENDING   0.36 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      25.74 seconds
CheckAllWarning               PASS      28.01 seconds
CheckSparse                   PASS      32.06 seconds
BuildKernel32                 PASS      25.96 seconds
TestRunnerSetup               PASS      564.39 seconds
TestRunner_l2cap-tester       PASS      27.80 seconds
TestRunner_iso-tester         PASS      89.83 seconds
TestRunner_bnep-tester        PASS      6.31 seconds
TestRunner_mgmt-tester        FAIL      113.20 seconds
TestRunner_rfcomm-tester      PASS      9.43 seconds
TestRunner_sco-tester         FAIL      14.52 seconds
TestRunner_ioctl-tester       PASS      10.15 seconds
TestRunner_mesh-tester        FAIL      11.61 seconds
TestRunner_smp-tester         PASS      8.54 seconds
TestRunner_userchan-tester    PASS      6.63 seconds
IncrementalBuild              PENDING   0.91 seconds

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
Read Exp Feature - Success                           Failed       0.104 seconds
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
Mesh - Send cancel - 1                               Timed out    1.831 seconds
Mesh - Send cancel - 2                               Timed out    1.993 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0717466054265337233==--
