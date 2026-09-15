Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB1B2E6CAB
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 17:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494341; cv=none; b=RDKA7IHg9cC0o1xy7IbJdS+YwMBsRdwSHuSfFC/7shBsOlHQ1iViEuuu5jSCAQWehCyXKwOEe9qq1GL+R7Lu7YGxrEO+JAG5+/iXQFGDZDsGYeM9Xk/H4AxomDU8xqgSgN0XQHzx8a6cEdD3D2Nhu5jCZvGs91PUb6VT+sQ1BZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494341; c=relaxed/simple;
	bh=ujXHGazhJJ77L1nfP8VOXxMPaLjOOQ04RbZecwnEF9g=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WYkXvyKRf2/4gqJenVx/b6ov14miPJjiHH6D6gJkZtHqCHS+8RjqKjPEGq3PTsCdX0ZIUJ10lAIbMHSUOENs6nHB5TwTMi3Trzlv8K8hsWfNd8VBfGahH99y0f94xu/U4KgeSKuTdJjWcqFXMnj2cBSjpInjJUCt/YUAgQGr2XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIQ20bSi; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIQ20bSi"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2dd88a115ebso383325ad.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 10:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789494338; x=1790099138; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FmR8cIIVJmisKC3Lt7OFoM8bshZflp1tqb6dsDUbh6o=;
        b=eIQ20bSixCCTpSGAqGmEJnKfQlPwR8kYImSkGSsDCv4FPhhpcfDZOO4bCFo7ZecVqS
         u6bkGSwiy6WJ9QCHi6+K62hzrBYGL4vW/X7Lvw+1CQhXteL/vvOJ3qFypSLq0nkWpz5Z
         g3PV5x+uVvLMl6WkY4L1Ek97IBy5m79llcqAKWMT3vsUuHzhSuMQGZY+2BNST5uRefw0
         rbdaLjYj7FgqM+7ImCuwREyzpTZbrfjmKghagWY2CENmeXOzjHIDfn2c19xG33h6HSOC
         6rKkIy04ynQk1UbfY8/wm8Ajg74zkKc+3qiuWsnD8lsmr9bxC0faKVoQGE0vp6QWQ7JO
         AwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789494338; x=1790099138;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FmR8cIIVJmisKC3Lt7OFoM8bshZflp1tqb6dsDUbh6o=;
        b=aEM+EJKSrX7KGHlMJIHjYccVJpPxSiQN6PR/tuOQdczBW2QbmKK1SaTbkTFi8E4AAX
         QDz9omOw9QD+iz5w5LXKQ0sG+vYxPe+NgYu2+8VRqjNjN7Yfx1LprYHaygLzaVhydJ21
         /lGT0UW41d7c140pvamo/QxRR/tmve/1pAoSR/AT3uIYgu01fmTxXf9ETOHxrA69OTRB
         BER2lVOkwPZWd+X4fehYa2Ic+9hPOpnWQNQeEzzyl+SnMXZdiJBsPGMvMqstyBXsp46/
         8/tzxUoegt05xKsvQgh5zAlJOZojAaaempf03RZrDeT0mxiKTiIvgTOFCCMq3gyP8ZEP
         ceeg==
X-Gm-Message-State: AFuF++noxbyPHHWTmPVy9hCcjJKfGg4S05+bXe8nLy0y/Cg5mCreINcF
	VdmHgnpmV6/riIL0zQFiN6FItGhSQD7FoJOf2eQRxw5+CGaouDJVUEA1l3g6pQ==
X-Gm-Gg: AYBFou1JIaoebHGZEuxvAp/zwGbDeCOMzIpreXtDdGYME1IbxPmMaj4iFhNp/WFFjZd
	eNC1HQ1E7zoQXYXibzNaX6qlnx/Z5lFC3mTJ3mZhDFzqh18kE8m3xeCmxi95KxOz2tJJo+vMMkM
	g6SJZfRrvs3vaCtWH0J0txGSrn64/L38bFlqErOY3ZK5VdK1ic+5o5sRBTaLxsnnfMWMG96RIh4
	ij2mirUEiFEFKw9k+9V1/d8K/Y3vX33eYYKhNZIjNbBJ4FfQITkyGY38Eps7g2WtNglkz5MJ6ld
	wfdMLCSBDy5Uwur+vFGV4hKsQ/BgoL+EKqse61kURhxsiAhjpFBVotU/DDofewZIsmHwQOLn+QT
	3oZvlUw2rdU4XsPK1RT89VpMIdb9ceweMYuFffEobwxIrw3266LGBwLWRY7hYPkzmYi1wWsHP3V
	LagLnsNFg9cS+SV2PuvLtiVs1cBT1Kx57+ifulyrJhtMkrCba5BcB2ApjxKE1f1rTLnbOofy5zh
	31UJ9GytuzbWXnV
X-Received: by 2002:a17:903:19eb:b0:2d8:d4cd:dc8f with SMTP id d9443c01a7336-2dd83866744mr34474065ad.18.1789494337961;
        Tue, 15 Sep 2026 10:45:37 -0700 (PDT)
Received: from [172.17.0.2] ([57.151.128.96])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5a6a182sm557010eec.8.2026.09.15.10.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 10:45:37 -0700 (PDT)
Message-ID: <6aa98441.3efc6ce7.5c04a.f2ac@mx.google.com>
Date: Tue, 15 Sep 2026 10:45:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8191911216635803629=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, qwe.aldo@gmail.com
Subject: RE: Bluetooth: hci_sock: reject out-of-range OCF values
In-Reply-To: <20260915160359.3107468-1-qwe.aldo@gmail.com>
References: <20260915160359.3107468-1-qwe.aldo@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8191911216635803629==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1165737/

---Test result---

Test Summary:
CheckPatch                    PASS      0.60 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      29.76 seconds
CheckAllWarning               PASS      33.34 seconds
CheckSparse                   PASS      35.91 seconds
BuildKernel32                 PASS      29.37 seconds
CheckKernelLLVM               PASS      34.86 seconds
TestRunnerSetup               PASS      792.23 seconds
TestRunner_l2cap-tester       FAIL      8.63 seconds
TestRunner_iso-tester         FAIL      8.02 seconds
TestRunner_bnep-tester        FAIL      7.98 seconds
TestRunner_mgmt-tester        FAIL      7.93 seconds
TestRunner_rfcomm-tester      FAIL      7.88 seconds
TestRunner_sco-tester         FAIL      7.99 seconds
TestRunner_ioctl-tester       FAIL      7.95 seconds
TestRunner_mesh-tester        FAIL      7.84 seconds
TestRunner_smp-tester         FAIL      8.02 seconds
TestRunner_userchan-tester    FAIL      8.06 seconds
TestRunner_6lowpan-tester     FAIL      8.00 seconds
IncrementalBuild              PASS      27.88 seconds

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


https://github.com/bluez/bluetooth-next/pull/777

---
Regards,
Linux Bluetooth


--===============8191911216635803629==--
