Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345D320C038
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2026 04:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773808917; cv=none; b=AjVYzmy+Svs+zzXhMUCC4mR9MDcLRp2LtCThwMnH+pxpCgn9LjPAE+PPchTTokhP2QOHRAkWl1w9+9RzHdGwkquj4/puTcoNqqJkNMTu3XW49hACOA5m+aTh+Q5zjwWjOBczNx0Huw5qUc8wDgrrVxrSvV0xhXt3eWWUa/fh8J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773808917; c=relaxed/simple;
	bh=wJTjPTYZX373W1RYE8B09IB4I/fStUfwvqhrDrJUYvo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=R0y7Qoo97CwA+8RvaN7UKeMKaGJuJM6Ge7DWfiFNA+mjdhTtzHSmqYut0Q50EFiMahjtTGwx4NbBHnY0CDYaLtJHaiKPhGWkbYXlrbwpB/1HFa0fE5tYBnp/I/KMMEdaqP84QFX3VjQUTtbN296j8rwabC9wn/mhi8owXwBsAz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2iUtlRb; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2iUtlRb"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-40ef10ec84cso4628579fac.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 21:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773808915; x=1774413715; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sKrrtF1JwDekpidxZhNNatAt5+Z10DLs9Z4uoRvOTb4=;
        b=A2iUtlRb6wXCTSVC1MkwB5uk/vqFFJRFXTqAbBrvkgWD9TmLLPC388GFIrJ0/JDUpj
         zqJXZrVVxZjvAb3fkTiITYuX7YfEKOWi7/dPuQgas1+O6OBTOKmKVhN6aR7NYDmAPjZf
         8sC+qTW2FfF+mpJHhnzxYwvgh6HdnFc/6K910sVwZbj7uCpZYZoqAoCbVC0wuIcffNdg
         kkTBN7Uhb8rIiQTlnEJhLq28KkYQ51sGu1aW/A8IIu81L6R1zT1BNnDC9SAMrrUGHMyG
         ucDfVZheXcLaXPIwsDz7DR9Gn4NAxMH3N0KmKWtWy8VWQpG72GQGfvFyCKjsAeu+i6PW
         tSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773808915; x=1774413715;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKrrtF1JwDekpidxZhNNatAt5+Z10DLs9Z4uoRvOTb4=;
        b=CHJBMOvb1NFyrwq9CatsE95uHNT4VdXs6kY3zuQgb4Sx1VYPTHYTc6UNmCzLOEvjS8
         xqNEsXDFlcmpbrrlKDE9HBFrsNY/4WjTE+V9lUsxHv8KRLbO8nwmPvw5PptO45cMrNa1
         mJMPiipc8Xw2K3c7sQ/m9zjU+zTOchnJQ2YJcvgZ1nn56KN9FF3IUOVuocWYhJoAU8Mq
         7PHqeIJvoB72KiFf7CggGiS7CQLpL3ygzuTNlh22s5SMXs09ifhYM7lqO39xloeeJMXP
         Zc56gWqCfGR4mMovYWv89vbyvVF99PKaeYvPmKCHuYXNDMleBpX8dAFK03i6Y6IBlyco
         /56Q==
X-Gm-Message-State: AOJu0YxfDeKIpD+YeqS6+6dWwVTe1Mtt2XA0hvWYX3iOsfbPtEshvez5
	HuHAvGCd9W/EQifXbtOmp301dvtkE3KkNrxk3daiSk2dtT0vpKMkL3ivvD2gVg==
X-Gm-Gg: ATEYQzwoJzToTRWhw943MBBQ/oS02lGRPcyBX4jLgPMX8EnmlNzsWRb1iAyPRFxUwuG
	5oZmSInynk/n+31mAHiysHEPzYlFk2OMM+/IGLiKZut6MJZZDycUR6Td6M7bT6OG2e5/zw1/WQ+
	W/ucvKLF71lMiQTQcdVntqragYt2JKtE01dAcHEdZ/0ZFE1+aXOE/FEEnhALzvmhPEPqS9+2rEP
	iEM99or4fKu2kYYwAc45N/IlCQPJGMj2OD24bsHAcLEWySNQMh6bK/3Csx1awyoAoHgV6U06JXd
	7XtjLHi+d/LGKsJqEyR8aUinOSNzcVzj0L+uG1oq+9GqYI0VfLM4xR+98r4DSDFLjs6WvF6oWof
	BnX9fhTcHzAVHHbYHvfZiUlwnVBCmhPsOGDFNXnqHttAXEUocxFE0iJlThEo3BrzMBA+wPJerie
	hCR4OTtUY7PhD0PECd4pNDqlfRS2tWfew=
X-Received: by 2002:a05:6870:3045:b0:417:5970:28ea with SMTP id 586e51a60fabf-41bd4260506mr1364061fac.51.1773808914697;
        Tue, 17 Mar 2026 21:41:54 -0700 (PDT)
Received: from [172.17.0.2] ([130.131.237.129])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41bd282c965sm1964893fac.2.2026.03.17.21.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 21:41:54 -0700 (PDT)
Message-ID: <69ba2d12.050a0220.66d8c.4771@mx.google.com>
Date: Tue, 17 Mar 2026 21:41:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8789100542215849901=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zhangchen200426@163.com
Subject: RE: Bluetooth: HCI: Fix hci0 not release in usb disconnect process
In-Reply-To: <20260318025724.1431313-1-zhangchen200426@163.com>
References: <20260318025724.1431313-1-zhangchen200426@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8789100542215849901==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1068376

---Test result---

Test Summary:
CheckPatch                    PENDING   0.54 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      26.72 seconds
CheckAllWarning               PASS      29.14 seconds
CheckSparse                   PASS      28.28 seconds
BuildKernel32                 PASS      26.13 seconds
TestRunnerSetup               PASS      571.61 seconds
TestRunner_l2cap-tester       FAIL      29.12 seconds
TestRunner_iso-tester         FAIL      28.16 seconds
TestRunner_bnep-tester        PASS      6.27 seconds
TestRunner_mgmt-tester        FAIL      115.22 seconds
TestRunner_rfcomm-tester      PASS      9.43 seconds
TestRunner_sco-tester         FAIL      12.39 seconds
TestRunner_ioctl-tester       PASS      10.31 seconds
TestRunner_mesh-tester        FAIL      12.46 seconds
TestRunner_smp-tester         PASS      8.50 seconds
TestRunner_userchan-tester    PASS      6.67 seconds
IncrementalBuild              PENDING   0.94 seconds

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
Total: 96, Passed: 95 (99.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Server - Set PHY 1M                     Failed       0.120 seconds
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
Read Exp Feature - Success                           Failed       0.110 seconds
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
Mesh - Send cancel - 1                               Timed out    2.781 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8789100542215849901==--
