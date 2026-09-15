Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0F041E6D9
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 17:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789493838; cv=none; b=qV9hsOb9CYqFK0RtDz797loBmaSHSmQr031PBiIitjr6zI4pGM81abrhH0QidmIO3hWOf14/wIIUKSt0vbkpE+/QOuMNbQWD2XtDFMySCfxRX0iYpnWEJ9xhKSmCaFPSn1JImndmXZL/yuQ7oKTALHIBVUEpqe9uiSZl5t3AH/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789493838; c=relaxed/simple;
	bh=9uQlid6rNYqU1Oyu2gpNYrRG4/owAVlKF5tNlbGkxG0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rOijRPtNlerSFGQkvIh4bg1Ao5dVeyvpk1OHOr5TFPKeN7uYTuP7VWqmpmSjuRdZvepAvlD+IDKvczhzEMuxROZ5jgHOZviysH41QyXRPoP8ZGr1/P6gZSmqah4idkJe8u0ZKvJP9rYW1qNKS+VQr7m9L63xIne2sT4M6rc07fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7WKWwBy; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7WKWwBy"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c5b53d710cso63679b6e.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 10:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789493836; x=1790098636; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=f03/Lrq6i+LTkxtOAPd7C+XOPT/mMn8km8Fe0Zt/FNQ=;
        b=a7WKWwBytwI0YXG4YFGVoETanKGVLY47BJPHd9k3W8X3d8nuS3llV35yg+ztJxvTXM
         t/a+UsdhPxJJLUtNUm4yFL2g6DQQKZy3IAtyOO9TlI192XDAQ2FwbwFiHsNqrxufqmZS
         f493slTw1vcgpd6xs+cozLz2OG+SaNRV6PTg6jXnGyVigaVyhTlgMowkHz93QS5RGNH5
         g/mE0eh7BZIu0bi2I+4SsCi9oV0PFXy0SRxjDLSFhdBrfJGi1mXITdXPmyswRjIgHz8l
         99GGDjXDjJBL0K9yCT83Os6JCPg8zetZKbtrX3Nu1ETxoyGgkl0C4TSExL2ih38m6XYi
         3dsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789493836; x=1790098636;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=f03/Lrq6i+LTkxtOAPd7C+XOPT/mMn8km8Fe0Zt/FNQ=;
        b=Eoh8yuEQFINja4108epGoKiR0HJYwwTsuHMkRl7C1ss+y630Fe8g5FCE88LkoN2LBI
         Bf8MWk/LKLb9xYKY/mFO4DaVDqQyQ9VH6xrTnzLfukDEzucEyOn5M06qRSrflKNOhsSa
         3sEDxI6aPGwFIoip/9mMpemyT13Mc8WCcRo72A2+s9GG2FL3UvJvgOqSrXOOrM7THG+o
         nodfXL/BLeCAHuj5pHB6RT3X/tUc4UWfqDqdSeM0gBed4hq9PGwmclDEn5q9VHJalcCN
         sfPHvvhjJ0bc/dMWiSP24q4nyaNAKYDXYTD4Tnb35x7Fu2V7QTBSlVgsHGFgrtlnV9WQ
         eYTg==
X-Gm-Message-State: AFuF++kRvkeMSvyeaXo6BU2MdbdhGk21yaUBFuwi2Dvgob/igHDOpwuT
	++ocKa3KlY7zhNc90LwXvWDL6FEOv/8DJ1fa8BKvSowqa4z/W/Jupko2MjDrjA==
X-Gm-Gg: AYBFou0G8ba+6swFLGS8ph4AwO26yS7Z+uqExPf474H8xaytDODTOidMde2UXKR1uWC
	2JMaQps1yjvkkZD6PgDtxFLjpfv/0e9cvqoGp5z1ttyvAQx/44hCXg+b1n9zuUCynONHEk94oYW
	kg1XMjqYJpVsI44Y+nq5OF18Wa1YWwWQsEG28tCI/teQtVZLrulCBRNOqpVfEt/Qtf8XlU6JtB/
	3BoptVQKJRpbyjEDJzq1LQFvz+dd2FtOYIeI8hrlAofiDEcIEnj0LXfVgJqkqRqEOCu2SS7WeHA
	FAo1s8w0+ZRxCnnvJiInTCEveDM4erDJo9SFBWmkLrh+qM8jLwVRfnsi6tJNO+1eLEZqCL/qYkK
	ZEqb0Nhg2RLbnA26e4qSvki22Z7UZsD/XLXj9A6ikgBw5cbR3j2BhfTlzmfYbVaeXyFIYtnhiHo
	j+VFMfghL3N41RaCBp74PIIiTy9gVdlX1XXt0ptp781YDGSFlKXMaLost/8diRE7jiAoSW60Gb9
	6xnxpo=
X-Received: by 2002:a05:6808:2208:b0:4b9:e5fa:8908 with SMTP id 5614622812f47-4c9acc9f843mr1838483b6e.27.1789493835856;
        Tue, 15 Sep 2026 10:37:15 -0700 (PDT)
Received: from [172.17.0.2] ([20.118.29.120])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4c331bc937bsm14396400b6e.11.2026.09.15.10.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 10:37:15 -0700 (PDT)
Message-ID: <6aa9824b.6510e82a.23dd7.055c@mx.google.com>
Date: Tue, 15 Sep 2026 10:37:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0361684581838185016=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, qwe.aldo@gmail.com
Subject: RE: Bluetooth: hci_sock: validate event length before filtering
In-Reply-To: <20260915160307.3106955-1-qwe.aldo@gmail.com>
References: <20260915160307.3106955-1-qwe.aldo@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0361684581838185016==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1165735/

---Test result---

Test Summary:
CheckPatch                    PASS      1.40 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      19.67 seconds
CheckAllWarning               PASS      24.44 seconds
CheckSparse                   PASS      24.92 seconds
BuildKernel32                 PASS      21.20 seconds
CheckKernelLLVM               PASS      20.79 seconds
TestRunnerSetup               PASS      504.73 seconds
TestRunner_l2cap-tester       FAIL      10.09 seconds
TestRunner_iso-tester         FAIL      5.83 seconds
TestRunner_bnep-tester        FAIL      5.90 seconds
TestRunner_mgmt-tester        FAIL      5.89 seconds
TestRunner_rfcomm-tester      FAIL      5.68 seconds
TestRunner_sco-tester         FAIL      5.88 seconds
TestRunner_ioctl-tester       FAIL      5.70 seconds
TestRunner_mesh-tester        FAIL      5.76 seconds
TestRunner_smp-tester         FAIL      5.70 seconds
TestRunner_userchan-tester    FAIL      5.90 seconds
TestRunner_6lowpan-tester     FAIL      5.81 seconds
IncrementalBuild              PASS      19.58 seconds

Details
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_bnep-tester - FAIL
Desc: Run bnep-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_rfcomm-tester - FAIL
Desc: Run rfcomm-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_ioctl-tester - FAIL
Desc: Run ioctl-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_smp-tester - FAIL
Desc: Run smp-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_userchan-tester - FAIL
Desc: Run userchan-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
No test result found


https://github.com/bluez/bluetooth-next/pull/775

---
Regards,
Linux Bluetooth


--===============0361684581838185016==--
