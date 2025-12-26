Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8A331A053
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Dec 2025 11:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766747200; cv=none; b=MbYramVa7aArCPsPFpwgc89xQoFDVaeB1dyhzctV25+sbdETNKf3PRA9d5WPLzkAE4WvMSHQRGynruoN5R6fwkmp+1Ux7RuOGzmS8g1Dl5AYsIXm3W1xOQw1trT7zGKkvhxxNK+6kAwTH/VqTXUSwQfymkbVbW2aj6jjURdI/3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766747200; c=relaxed/simple;
	bh=PxLNAr1cM38NJvx6o2k4MJfALrdaSOXKT5nhyWo6YhY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=EAoxbd+HzU7TERXkj5j1dPg74LAzLk8Yd97LBFJsv3Myz0i0582y1aQX4aTW0cnJSJ88RDt7jOAjgjza/F89sGT+Mx6cmdzbU5fq14V5FN+orn+A5XMigw8f2WcEDx5G6u8EPoQ69DH0poF1eHqIamr3MUY3YS6uFVgHKt7QJjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KdZSbMSb; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdZSbMSb"
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-7cdd651c884so944795a34.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Dec 2025 03:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766747195; x=1767351995; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tQFA05uDKfDl3xDQ6ozawJAS0LZ73waJGiB7Iult5zE=;
        b=KdZSbMSbY+WCpaloM5hLt+Kz+RQiAYYAYaVZE3BD9vlInOAep7q6oTlXy3et15Q+PH
         BgpVzA+Ewp+rXtXgDLZIc/AVZP3ucwqj9ItnTDRuMBWBHjagEBdtSVb948mY0a4aoEBw
         tzUKU2UAbimgRKOwl9jdBsJ+rI5YaE4j6JA/Zu/3L6KvNcDrHLVTeiKiIr/UiND7wXzW
         8jfIXR4yjGJCOxiSax6xXsrKphIhO+32FTWV2pcWpvMTiynAuEG8reJJBgD8KIUIwCVG
         gJK8Y+NlSY5D/c4X1FjN2XCueYUXBIw1brZfGfjg/5YzEY2kMrIVUPPIVsRbmPHuPU6O
         BgDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766747195; x=1767351995;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQFA05uDKfDl3xDQ6ozawJAS0LZ73waJGiB7Iult5zE=;
        b=RUir8ph7xxMcnDm6jhYMBK0f1FPLjv/HIUf/i9E9PXbOrWx5kTnEyVHKE1xWvdfEZb
         INUa7JLAr0ELcgL4s7S5ioP9pVqUX7Efctv7MO7bZt7FhGRfkzUrrN+KbnZivxJHtDNI
         6GkfaFj2ezeKtXpQrjcsXRzaWYhWBw1A/5qwFm1dtJqCVD+bhUKe7xMoU4pvbONq8zNT
         cKIV+n/5tqqYF2NYv7IaGXrBzEAjvYdsIkU/xb1/HwgeV/J4C7iHSvMsiVcuBmaSgocJ
         mJ4++y1JtBOK6mof+RiHG8oSgZwGZAgOSsdUebEzieefa4f+y5GKubSdy6yX2sXipGRw
         N4kg==
X-Gm-Message-State: AOJu0YwELtV/fC6LWun/dmv5bhObCnU5/lnyizAuxgdn6klShSnsmiH4
	pOccIXDQ2YsTSTbN/4+7Hj9XbYkBEwMT9F6lFfMKi3HdPYREazSvZ64UGLS+WdVd
X-Gm-Gg: AY/fxX7LiaiPn6tOJ9F00XcbMm2SbOXtHO3Da1J7mfRKL9numBg4AABj46CBHimKnbb
	GLF9t7qrttvIHIE+HlHV+YgrBP8ctrgVdMq9Y7KZLuVMGazVMrO9rQ/PUrUaE1KO7/0+hXTq0GC
	O4ymhCRDXo851aRypwswgECcqoWcR4G56+fvRgwn3ZTKOEfBLHpPvC90xssxNRkY2kd8xSNCK6j
	LGCMBOA/4D6DeHRilfg4GB7/QdJ120mXHGY3Ca4ax2dpmL1Z8KJ/PlqjMzjDLM3ga9FleueoWEK
	hFyr/qtPJVvJ7jPWtmzqyKfGiaRlY6yOFD4Y58bipRSbE5+116EEakDJI77eVM0+aBK6MAY7op2
	m1KYGsmpxQ9JdotFF8FlzzWgwyKvfIESoUNmWEimQlYyWzn35fAkgL2omUXCysgUNjp95YDNmhn
	Af/boWx9whsX0G9f7DFw==
X-Google-Smtp-Source: AGHT+IEIM5T2FxICNErq9QZT2yOfG2JG692JG6D6SI4RAcjghKR5WdjzM11nH4TL/iRpY5I6gPO1uQ==
X-Received: by 2002:a05:6830:6dc3:b0:7c6:cd8b:2e5c with SMTP id 46e09a7af769-7cc592fdee8mr9912518a34.18.1766747195200;
        Fri, 26 Dec 2025 03:06:35 -0800 (PST)
Received: from [172.17.0.2] ([52.173.178.214])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc66728296sm14878713a34.4.2025.12.26.03.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 03:06:34 -0800 (PST)
Message-ID: <694e6c3a.050a0220.e5099.0341@mx.google.com>
Date: Fri, 26 Dec 2025 03:06:34 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5059520878717788286=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jinwang.li@oss.qualcomm.com
Subject: RE: Bluetooth: hci_qca: Cleanup on all setup failures
In-Reply-To: <20251226102707.3449789-2-jinwang.li@oss.qualcomm.com>
References: <20251226102707.3449789-2-jinwang.li@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5059520878717788286==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1036686

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.33 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      25.48 seconds
CheckAllWarning               PASS      27.57 seconds
CheckSparse                   PASS      30.96 seconds
BuildKernel32                 PASS      24.87 seconds
TestRunnerSetup               PASS      550.23 seconds
TestRunner_l2cap-tester       PASS      28.31 seconds
TestRunner_iso-tester         PASS      63.90 seconds
TestRunner_bnep-tester        PASS      6.26 seconds
TestRunner_mgmt-tester        FAIL      116.33 seconds
TestRunner_rfcomm-tester      PASS      9.41 seconds
TestRunner_sco-tester         FAIL      14.30 seconds
TestRunner_ioctl-tester       PASS      10.03 seconds
TestRunner_mesh-tester        FAIL      11.81 seconds
TestRunner_smp-tester         PASS      8.52 seconds
TestRunner_userchan-tester    PASS      6.54 seconds
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
Total: 494, Passed: 488 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.103 seconds
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.182 seconds
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
Mesh - Send cancel - 1                               Timed out    2.060 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5059520878717788286==--
