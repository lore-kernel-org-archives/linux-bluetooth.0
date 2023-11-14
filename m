Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279231173B
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Nov 2023 07:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8j0Swwh"
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEDD196
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Nov 2023 23:32:23 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cc1e1e74beso48039875ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Nov 2023 23:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699947143; x=1700551943; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iKBkBMnlq9mKP7sTAYXv2kA+ucbgpt2LmpnOVMHBRDY=;
        b=f8j0SwwhTlvMx22BCPb463hkw95GHM03JtxTP3v4AIyILjk4OPq1L7f7ZY/hEPfgf6
         jek2OMMCbdyuS7v2hTu3l6U2oEaSBudm3ep605bbbAmLK0joDY9KkN6tqQoycwQgsRpQ
         Cd2LouF79qhUq1OxHGA5+Y4RkGwjrWsCtTaJurS6/o9ovDtQljXTHiQBXdQopDjfe9rA
         qrBy1WAv8Dln2iDzahCxmb/U5OLuVXtFxAa2XmDnRvh/alR0kPfwR54rAHjDq4UK9o6x
         6nVorC9ab44EHbHhaHEHd7CtN1ngP8xbRnn4fxPQ7ZyxnMPggZ0ew8vwAxvjTSOsPuIW
         h5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699947143; x=1700551943;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iKBkBMnlq9mKP7sTAYXv2kA+ucbgpt2LmpnOVMHBRDY=;
        b=duWm0vps0H2AvbMlLXrQd1OtboVdsoeHf0jCUDoD70Ubri9eyjTO1Eg5OAH+Qlmr6X
         2G4/r16jK6oVdRBVnTH2Yslt/kg5E4WBTrgQxgTEF5WyUtyfibjlvbtZOm1zJaSVyZBv
         4D2iJHraOdYonJKe9f99b3oWY4c7RMtgz/UvJFGJregFMNUtZ7pMQ1EeXEVtxg3pcYd7
         vwovqV+0SCLrsXShacmUJKgg1nvyCttDDBv+JgeIwa+JvLE6BC7Rund2vY+cIW8lBJVI
         IDH1e2L2sP6tbvRZlJlarPbk4JU+okxnHZ1V/U+ortYBHhyY//EfIBxv9/IisP/tun9h
         BdpA==
X-Gm-Message-State: AOJu0YwcVDMxqukKUWNMHEY78N5N4Bi16S3ylVRkzfCVCR3SlnPxIh55
	yd4KiFbSIM2Wews76DHs/hBT1d7Zrso=
X-Google-Smtp-Source: AGHT+IHYLBNZUQmrRsC5RMzLGDskNre0c8mfiVkF+YR78VMzHVxuuCGPxn3gRRyIMkJCdajIqoULNg==
X-Received: by 2002:a17:903:cc:b0:1cc:5db8:7eb1 with SMTP id x12-20020a17090300cc00b001cc5db87eb1mr1284949plc.51.1699947143006;
        Mon, 13 Nov 2023 23:32:23 -0800 (PST)
Received: from [172.17.0.2] ([20.172.24.208])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902d50400b001cc307bcdbdsm5069962plg.211.2023.11.13.23.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 23:32:22 -0800 (PST)
Message-ID: <65532286.170a0220.fe9b2.be9f@mx.google.com>
Date: Mon, 13 Nov 2023 23:32:22 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4046268754091773363=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, marcan@marcan.st
Subject: RE: Bluetooth: hci_bcm4377: Fix msgid release
In-Reply-To: <20231114-bluetooth-msgid-fix-v1-1-1d15394bf342@marcan.st>
References: <20231114-bluetooth-msgid-fix-v1-1-1d15394bf342@marcan.st>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4046268754091773363==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=800912

---Test result---

Test Summary:
CheckPatch                    FAIL      0.84 seconds
GitLint                       PASS      0.22 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      28.15 seconds
CheckAllWarning               PASS      30.67 seconds
CheckSparse                   PASS      36.38 seconds
CheckSmatch                   PASS      99.46 seconds
BuildKernel32                 PASS      27.21 seconds
TestRunnerSetup               PASS      423.58 seconds
TestRunner_l2cap-tester       PASS      23.34 seconds
TestRunner_iso-tester         PASS      37.47 seconds
TestRunner_bnep-tester        PASS      7.03 seconds
TestRunner_mgmt-tester        PASS      169.49 seconds
TestRunner_rfcomm-tester      PASS      10.98 seconds
TestRunner_sco-tester         PASS      14.79 seconds
TestRunner_ioctl-tester       PASS      12.41 seconds
TestRunner_mesh-tester        PASS      8.96 seconds
TestRunner_smp-tester         PASS      9.94 seconds
TestRunner_userchan-tester    PASS      7.40 seconds
IncrementalBuild              PASS      26.28 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: hci_bcm4377: Fix msgid release
WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#78: 
Reported-by: Aditya Garg <gargaditya08@live.com>
Cc: stable@vger.kernel.org

total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13454901.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============4046268754091773363==--
