Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CD61CFB2
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2024 05:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716528777; cv=none; b=WkutAWGOlG2/OWIesHcqd3jBn30ymjN/tI677ylQo10WdsFSgV1ZUtDLWh/Rbc4ai7K9zdNQPZDdv2WlXxzUOmcSFR+gtA20wRX4TsSzhuNYniG7j+f9MG9dAtUK96xsJuhmTIuQX7IiSaLfy0nP5EY2bKvEXLxq6krDoiLexn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716528777; c=relaxed/simple;
	bh=QGUsD4tQaWbpXYsIi7Is2X4weqG7pn55NaH9HhdbW7Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WT4IySvanFm0+8Wv+lwnMuluXprd9gD2szgTMMK2fPJQsqkY++uSL4AkE9f+q2XGyTpRG2EALmnxMIJxFBkXSWP7+YLVcWmZQSFbl7NOyDz7soXl6e2e+BKOwZLGy/GCMaHJPFTVfK1flKZh5LXsfqXP3g91cmsriwHnFkD963w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ze0Y35LH; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ze0Y35LH"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6f1016f41e2so3356333a34.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 May 2024 22:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716528775; x=1717133575; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3cH8ccNoMo13McXvyACYXHpWDAgMMscVaX8JYxEW/ag=;
        b=Ze0Y35LHx+jjk87l6n87eHRAUOx+QapZmk6IqVtatJYIsvdMQYqo/Q4q7WSginAzuO
         d97V95xfB9BvmEx2cjoOGoh1tFKHu79mPuCXbMZOFbCWiZUVyBkz79FlaTZYIPh40Ywk
         TlWZU1vQ952afbX9u96d7xCwdFSUBrObxkzcTfYsCfIo6CT1eVJrhUN8zMlo0nj1wF+N
         AkQsCakr/rv+OV4netzMI77n0ySXQmh+eSY+UelM7qc0+kAkgf500rY2i4kzSmyljMrh
         V4Go16qe5kTpRI0Sn3Kv51TV1+E4Msz2gwcKhIftTldPhkccFwl6we3cTxfRr7H3u6rT
         hh6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716528775; x=1717133575;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3cH8ccNoMo13McXvyACYXHpWDAgMMscVaX8JYxEW/ag=;
        b=o7GL72i0TswLSEeLn3KLVK4zVm2ZiK5hQg5by9eP4mbqOhLv/KhklFAv44SXO91aWX
         HZqRjV7OaOksI/LhYA1B7cZw37wSLSrKLGCVySf8qR/zMT1CpeF6j73nDvaNtkpswDuw
         WggxRz9+OVaoUV7PFSsUKlH/YwM2+Hw+DeH56GQAthHfRHBVVfpgipvg+WBuikbyTcWk
         ZviivM9aEwSpkw9ksp2BkMRNdnWmRTxt/aeYXDr3DSWT0rJImaHJHPf3hydIPL1XIJN0
         nlVZmrmiwnlt7W238xPrXkoL+xlkDw8YDnsi35fC9jcSpnRnzqbAqvSDR/G0sqKT0/0z
         wiGA==
X-Gm-Message-State: AOJu0YwrjRZKnjPRYInbZtYIbPoS8pXQgOvGx0GD/B3K8IzEffkHH0jE
	AN16KXdf3gvkDDUgsT+3GyZyJ1C6kReUQ/vz3cRgCK6Un5OctukPg14gsg==
X-Google-Smtp-Source: AGHT+IFElsY8GUKrC5TIh6YIrVr4ChlGFfDpGlcb8/uOU0JtO2ivc+F/JX8/pWQXTjogr+uk1Jg9fA==
X-Received: by 2002:a05:6358:2826:b0:194:6301:a71c with SMTP id e5c5f4694b2df-197e510cd08mr172527755d.16.1716528774944;
        Thu, 23 May 2024 22:32:54 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.36.33])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-682229ddfe5sm425482a12.53.2024.05.23.22.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 22:32:54 -0700 (PDT)
Message-ID: <66502686.630a0220.82582.17d5@mx.google.com>
Date: Thu, 23 May 2024 22:32:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2548169209370983142=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yinghsu@chromium.org
Subject: RE: [v3] Bluetooth: Add vendor-specific packet classification for ISO data
In-Reply-To: <20240524045045.3310641-1-yinghsu@chromium.org>
References: <20240524045045.3310641-1-yinghsu@chromium.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2548169209370983142==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=855573

---Test result---

Test Summary:
CheckPatch                    PASS      1.25 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      30.49 seconds
CheckAllWarning               PASS      33.36 seconds
CheckSparse                   PASS      38.84 seconds
CheckSmatch                   FAIL      35.05 seconds
BuildKernel32                 PASS      29.91 seconds
TestRunnerSetup               PASS      524.58 seconds
TestRunner_l2cap-tester       PASS      20.42 seconds
TestRunner_iso-tester         PASS      30.50 seconds
TestRunner_bnep-tester        PASS      4.93 seconds
TestRunner_mgmt-tester        FAIL      111.65 seconds
TestRunner_rfcomm-tester      PASS      7.48 seconds
TestRunner_sco-tester         PASS      15.03 seconds
TestRunner_ioctl-tester       PASS      7.74 seconds
TestRunner_mesh-tester        PASS      5.92 seconds
TestRunner_smp-tester         PASS      6.93 seconds
TestRunner_userchan-tester    PASS      5.08 seconds
IncrementalBuild              PASS      29.54 seconds

Details
##############################
Test: CheckSmatch - FAIL
Desc: Run smatch tool with source
Output:

Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: net/bluetooth/hci_core.o] Error 139
make[4]: *** Deleting file 'net/bluetooth/hci_core.o'
make[3]: *** [scripts/Makefile.build:485: net/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: net] Error 2
make[2]: *** Waiting for unfinished jobs....
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bcm203x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bcm203x.o'
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 6 (RL is full)               Failed       0.182 seconds


---
Regards,
Linux Bluetooth


--===============2548169209370983142==--
