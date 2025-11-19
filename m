Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D632C11F7
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Nov 2025 08:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763539253; cv=none; b=GjUwTs20DvzqRXQS2PsqK4YnseuIW3dMPbB2Vq0rexmWS46bVRCBK/AjnabBe4f7Grs6MsYC9wUDSQgeOC8nlfGop0DovIx8T2xCDdFBcIhR54EFlExa8Fg62bDebFbzC1ucT6OlQN+ksfEeUvkTWBkkwWxjHHqZJGGjx9ZTm74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763539253; c=relaxed/simple;
	bh=oVE51ruxuzV/HXDbehSLCcz0NT5Zv6YWPUrr1rArQFg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Q3LEOaNlOQhmou/4KGQg4+YJ7Yroz68ZGd5AIP8qvH5b57ELozm0Vsgjq24s9HK4wMAcW/r/IQdlaYaUr5teWZiuUipAFuNZXOWDKsBRg4o1Bi4lTXH+yjMIpBMhfk1GGAgHC4aYlNKROrTxNHCJ0SEFIFeta+FWRoTIQ5uIL1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8Wzm0G4; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8Wzm0G4"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8b2d7c38352so67369485a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Nov 2025 00:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763539251; x=1764144051; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DZTuAomtAksPi+y6eEVg92fJwKWs5GY9ltpeCGl6KN4=;
        b=h8Wzm0G4ZYab0EWpAVXr/DIe/baFGd69vDenZB9QNDfyZymNXbmTJeXHT+L37DgZ3I
         qv6gLO2pSSEuIy0Ys+AVXL7JOCKbweIdrdxS6PrP+pwX8ZsbP8NSCRxsMe8zI1n2lFVv
         PZ6vuW5XI4bMQtpyvfKONOxuajuvdKuEpvSdWzTzr6H/R+nnZl8wwWHLVZLZlzIEQkXL
         52mq/U5XLA5jaBYFIhuTIwtHwPKIXx+NEUysCUQQlIhFdzDtTMY76HEhgdv4NQP4KFJ7
         gbH3aC6J0ZLlJEQycWOg64jrO6kITejEW+RbQY3TuVw+jSxSwxdmE7Snq5xgigVTQW7r
         +UeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763539251; x=1764144051;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZTuAomtAksPi+y6eEVg92fJwKWs5GY9ltpeCGl6KN4=;
        b=I6yUQqxvSoQpjuP3J4h15DpMMigr5tSJTLUXwsLQf7hCk0lNE7RSuvG2CtOaltZzV/
         8Zbru8IIUS7AiiAqeL+zNB53UevM73WOINArZ6V8tXUFV8xBOnbWcq46BKyNGT97274N
         kPxN1NtPRei/smm5i766d8PaejublG9Ya/BjQkSoWFzyKTuU+nWIEZSzgG2IYNY39Jzz
         czVIhbKC/VVyNh6DoJ+oXELrCBmYOGe21SYC/P8RKY3Yx9JFaobEb0EPBltJPy1fN6zZ
         HuTFieRFV1eigNYKjRiW9xWxIoUWFXhnT+A8sZc5G4XWlCIlWA9SJvaqLmY1XYQTX7lY
         o+8Q==
X-Gm-Message-State: AOJu0YzdLhJHr5MNfh8KExVtjNMkgMlvR505zZLVTGEZr3tYpca2i15b
	px2IdY9RqROeL7ulo+1pUkjcZRIKiate1X9aNMdL9qRp6IoahfSWIVUDPBkQTA==
X-Gm-Gg: ASbGncvUWuEMjiGBKxJJp5/qvYmsDU+vSaE8PgUZoqi1jF+10rv0n8HLbENWMHmLA5P
	jFurNYlxaIo/cmg34+ulDAuNLcpnYSbEIEtxv915fR+GMM6SRKX6gYORahjko4GKPrnB5DxO/kS
	F1e2Hntn/udNEy7ReYWl+rDBrRLdQUrykAzgBp49CCv0tB+USoa8bQM0ZB0VP7zdpkMXrN7DivV
	6HT+0dV/YKt8EPY6HxVcVjNIHi0dqGnR64HnY5y+yWLbthYsPXVIuOnSZllfZ4kEi3m+nmEsk+m
	mQoLrNlYGw1FtmWAytRDf0TUUPa3wPrTFGZdxIqy1l/WS4z9oWzEZar1WzuL+QJPdb0hmhqFjOX
	Oh0fsy5XrDUl50RurwuC3k63gvTR3/Pi9v/XtDaOwinhY3tMbWtL31Yf+Y3SWk9Rsg9kuTIK2pi
	JwV0wEPQ0J9xh6azYk6ys36VT57L7UwVeKNPU3
X-Google-Smtp-Source: AGHT+IHHqUiSk1dQyWiPhO6kunj7qO0Z9GVyRNmi+OI2g5qXRkJBGmmm7oLK/co7BCJD1KN/N2nqWg==
X-Received: by 2002:a05:620a:700a:b0:8b2:6e88:1f3d with SMTP id af79cd13be357-8b31823023amr189460085a.19.1763539250588;
        Wed, 19 Nov 2025 00:00:50 -0800 (PST)
Received: from [172.17.0.2] ([4.246.135.66])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2dd1d956dsm911276485a.28.2025.11.19.00.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 00:00:50 -0800 (PST)
Message-ID: <691d7932.050a0220.1fa754.3788@mx.google.com>
Date: Wed, 19 Nov 2025 00:00:50 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2003710455283385616=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 13875017792@163.com
Subject: RE: Bluetooth: btusb: Add new VID/PID 13d3/3533 for RTL8821CE
In-Reply-To: <20251119073338.713247-1-13875017792@163.com>
References: <20251119073338.713247-1-13875017792@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2003710455283385616==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1025173

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      25.48 seconds
CheckAllWarning               PASS      27.35 seconds
CheckSparse                   PASS      31.21 seconds
BuildKernel32                 PASS      25.09 seconds
TestRunnerSetup               PASS      545.57 seconds
TestRunner_l2cap-tester       PASS      23.56 seconds
TestRunner_iso-tester         PASS      62.57 seconds
TestRunner_bnep-tester        PASS      6.11 seconds
TestRunner_mgmt-tester        FAIL      124.14 seconds
TestRunner_rfcomm-tester      PASS      9.14 seconds
TestRunner_sco-tester         PASS      18.89 seconds
TestRunner_ioctl-tester       PASS      9.80 seconds
TestRunner_mesh-tester        FAIL      11.44 seconds
TestRunner_smp-tester         PASS      8.37 seconds
TestRunner_userchan-tester    PASS      6.41 seconds
IncrementalBuild              PENDING   0.66 seconds

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
Read Exp Feature - Success                           Failed       0.096 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.092 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2003710455283385616==--
