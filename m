Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C282F4A
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2024 05:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712899954; cv=none; b=XyNy9bx+nfI0exBawSfWmT/T1B8A1nvWtNnbaVVtGR9G/VyuLxMxbU3jxS4DL6qKt5xah+KmkVnwYg0JnGpGI+IGCLj8azpgbezd3qaLUYkqYui/j6oUnhVfwmFjf/yLaLFXSLBunv+mbRJRRLA/5gUVvipR43MBLtgbE8FBCvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712899954; c=relaxed/simple;
	bh=RI3JAIbUb/BNnC9CuZeSh5yWJKUyjGb000Vml3QcEkU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FK2Tsrd54zNeu5N4gnMF7A4H4Vd1hen/3LVBEkqdZTLzLBWTZB/ow/I0UOkdTcq/2E6Dv3Smx/JATwkDwgqeVy64XS164N45ICI1KlCBEwoZVbHCSfCJ0ELVc5Tp4f/9gqehr1riEB0eE51DchJTiDuB1//jmizFfxdBYjeIyJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdceMbyW; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdceMbyW"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-69b16b614d7so3269906d6.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Apr 2024 22:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712899951; x=1713504751; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ODiPZwfV8bbg4vH1Q6tn9s23oyx6IqAfn7M+X2sp9ag=;
        b=ZdceMbyW4WyokeN7o/yMDjai4ym9CisZ+7DUPPYfziTs/NTM7P8ggVRy4Og/V/zkZc
         1/54m4IF4ziSzN6C4BVH+dMvS94NVGd8cQpxKMdCMw+Ij5YzDHn3MLa+6LgvTWFYJ1wd
         uQ5Xnom3HIAOjLoY85ymNSk+ZltVM+J/okkQoCGsEwv9OqgxkwTbIeDRwmYDlhhWwdNk
         ukTZltIGGWFhcFwg0+wTGOOiQ3bpOmfk0YN62mtpkR8jddJ3GGhfbP1Efp5nTeVdrorR
         6vim0M8lvrosg3iKLxTW54r1A9VHCrPzqhyQfUg0oNIg4kHbybIiKoVC9jHCVJ0FD0pj
         ++bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712899951; x=1713504751;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ODiPZwfV8bbg4vH1Q6tn9s23oyx6IqAfn7M+X2sp9ag=;
        b=W9Ml70hMax/YmXyxN8es+5/WKsboHEeLt5j+fb0r+h7GI/I+dckVTG08rx/d6f/TrX
         jF8ZwNBsLde82haKNC47UjyyVblp7y/p7thsln7jdek1MLViKMxYVfp7g8a6HECHTqog
         zchUo6KIbmab+7AAD3+4nY8uWDGxzcf4JX0Yeq3NVHDGTpP5ltczKR6FkUaKFZ64LOvE
         SQ356Vu8d/8kTo9Ic/2NBaYTa61nlr/ZueA6dG7UtWJyE1/+X49f5Us+YY2oVGOrAaxR
         2k6LEWLR5Au4AQ8rb6MncbN91Ezi7EGWpBnRzZSkTizg9SSI6/+vn6u546Zb90lvxLNx
         f6Ow==
X-Gm-Message-State: AOJu0Yza/K8qkcFs83Z7Q44ZzDPK3Uo94fvDqU7LbgyKyNZ0UOT3x0zg
	vNyABY5kiwPB1DkRZWkAzPnSpoeBDtj4WojWi1P0HmjXofjTO8BnNBNP6A==
X-Google-Smtp-Source: AGHT+IGXp7dzTS7m0XuqN4KGbwJJ8xRXwVJG3B14XXtsVFvQCBv9l2NFUCY3Eaz1NJdYtYwsrPoj5g==
X-Received: by 2002:a05:6214:70e:b0:699:1756:d78b with SMTP id c14-20020a056214070e00b006991756d78bmr1831468qvz.40.1712899950708;
        Thu, 11 Apr 2024 22:32:30 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.37.81])
        by smtp.gmail.com with ESMTPSA id g26-20020a0caada000000b0069b10f48ecbsm1897964qvb.47.2024.04.11.22.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 22:32:30 -0700 (PDT)
Message-ID: <6618c76e.0c0a0220.3ae97.472d@mx.google.com>
Date: Thu, 11 Apr 2024 22:32:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3958963721763300707=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jiande.lu@mediatek.com
Subject: RE: [v3] Bluetooth: btusb: Add USB HWID to usb_device_id table for MT7921/MT7922/MT7925.
In-Reply-To: <20240412044057.25055-1-jiande.lu@mediatek.com>
References: <20240412044057.25055-1-jiande.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3958963721763300707==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=843853

---Test result---

Test Summary:
CheckPatch                    PASS      0.61 seconds
GitLint                       FAIL      0.65 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      29.55 seconds
CheckAllWarning               PASS      33.21 seconds
CheckSparse                   PASS      37.35 seconds
CheckSmatch                   FAIL      34.55 seconds
BuildKernel32                 PASS      28.81 seconds
TestRunnerSetup               PASS      513.63 seconds
TestRunner_l2cap-tester       PASS      20.36 seconds
TestRunner_iso-tester         PASS      30.74 seconds
TestRunner_bnep-tester        PASS      4.83 seconds
TestRunner_mgmt-tester        PASS      110.06 seconds
TestRunner_rfcomm-tester      PASS      7.43 seconds
TestRunner_sco-tester         PASS      15.03 seconds
TestRunner_ioctl-tester       PASS      7.87 seconds
TestRunner_mesh-tester        PASS      5.89 seconds
TestRunner_smp-tester         PASS      6.84 seconds
TestRunner_userchan-tester    PASS      5.01 seconds
IncrementalBuild              PASS      27.49 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3] Bluetooth: btusb: Add USB HWID to usb_device_id table for MT7921/MT7922/MT7925.

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (84>80): "[v3] Bluetooth: btusb: Add USB HWID to usb_device_id table for MT7921/MT7922/MT7925."
1: T3 Title has trailing punctuation (.): "[v3] Bluetooth: btusb: Add USB HWID to usb_device_id table for MT7921/MT7922/MT7925."
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


---
Regards,
Linux Bluetooth


--===============3958963721763300707==--
