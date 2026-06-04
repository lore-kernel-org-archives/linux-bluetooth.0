Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B968738836D
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 05:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780552143; cv=none; b=NUsNw0ZqUdjB26HUGk0ucmPKJ6bOWIqR00eo15CmaDfA7TCPC3CZVaWZcRsXBf7tYjcmEclqpqJYScuMwlvMczp0IWAnYP3N56QT0dYn5iqwTM3ylLHD9XCBTtJRAibehnJPeIW60fhTOKF6bI1AXbSSwlZy+QZPrCD6NYHA7AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780552143; c=relaxed/simple;
	bh=WRv4sK2AYi301pkU+LgxfmAEZvMWbYX+/t0fgG8QTd4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fNCpFOoChGjGfQFShT+KdmIJJM3fbkKcx+5RkjuzATJnM/BKTX9rMqslfl2MWtqkUM4M9fmjDVmyyrTEp7FQBM/SJmMElTvygMP/dsfdyo5Equy308YKXrH2WshsHEEAs9uIeqjXix7SnFVSliqZMDie21P2/iiK600ng57xHrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSdP4iIU; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSdP4iIU"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8ce9ddeddefso3323446d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jun 2026 22:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780552139; x=1781156939; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=q07pIW9JAcNXHTJ0UE9t0KydrfACDl1pg59mseh8vZ8=;
        b=OSdP4iIU6lFGtH+GiU0XLs2UPQN3IaCqaQYm0nctAB82iA0HfbmW93A3IeCUJAWKTZ
         AVoAuXZlJpNuO9uNqHiMVKCVWYuv2F47O7jVbewfwaSgwcQ/wIE81MjGo5rNQMCA4yg8
         bPNhOJ6qCY4n5eg7g4ei7lZrgBVGRhzxo3rQDm1r9awznR6NDklHhTOQ851VnBFthqvD
         ZnTkxcxnalmUeDRxxH/voYyQXKAc6vtZQzLEiOjBiR5br/CA1fQk+cSOdj7Vx9L2u2iV
         N/Ih8s3sHXJo/qW05idJWDkM+zex41QQ7sua9RVbWPemJeoVORDK3VnpWPQFhjCvKqYP
         CHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780552139; x=1781156939;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q07pIW9JAcNXHTJ0UE9t0KydrfACDl1pg59mseh8vZ8=;
        b=Sa8UGjcuquBhmh3fV5sHJcdw924HtUjDksCXP0+xg9S+HGj+A93eAPnjtuVlGqwwzB
         xW/LqtE9jWg05Ev8jod8A/uo7iFw7M+Is9Gue9vJ/uTEjSleFiZE+epjzeDQ6CFLuXMH
         PeKJdtGYxmhbiabxJaQ4sE/2FlDxvLQaQtDeflkLi3tHW8fwBmlf3uMe7iyotbzeswUd
         nQOHdYvo12lPhhx3JlmeWGvmVJlqyWEBvomDFoZepzM5IaFY0c79Tflzz5K24i/9sin2
         kIrOsypxMAp6GXQbLScVRSsAi8/0wqTKM2SeAqaF0G/nOvuCbFvdHIOzCdNTphbmrMFS
         eovg==
X-Gm-Message-State: AOJu0Yzz1C15fba68VDTJRsXhoSLjPWbnQRqLY6kelWY+KHN16AeghYx
	YAk4EW+P3vo05Ub3uPuJ7+y9L+F9sUttRJTekhyjm5wl1QKTbYmmEiR5J8EPvQ==
X-Gm-Gg: Acq92OGVZAULK1vYO5iK0OlpIbQh3G7QrLW/RkVx0vQiAE+PP7HbXP5mGvU+ZNzoDrg
	yPJhMqmUuGby88ZZneNEP8Ru/nP0hCv3i5YDdPKjRvswd5J6PcVm9R9GrJbpbjcx/TSgJ/1dXYu
	YGf0ycPWEJpNHoZY9zQTAQlxD/oM4dF0hrxJo7wTx4fM3fhWczLoaKATFHOk0G9cKCJlBh0ZyNV
	PSmSBOuT0ANYb8S4d/pisFou/vCfnUZjb4KaZF0YubxMXVy+NWNzjDtcrdC7Mar/v0XAYKSqM2w
	94Rs2R9FDwISexpAgv21v7uv4mxHPJBz4+ew7Hetk3RIwWVPXu8C5mFrZ1ciK46c9NPRg6L8xPB
	ndKvwsOPshwY5PYsiYryzipbBoKc4UhWXtHOGjJdEcgW46pTltXMvDnOuo7AmgG7/puKOTZat7j
	7ljVzsz1U8AOgAxyUlUkk1sDXHgYl1QUCPZjeblCrj7oo=
X-Received: by 2002:a05:6214:61d1:10b0:8cc:e718:f0e6 with SMTP id 6a1803df08f44-8cecdc04feemr82561776d6.2.1780552139502;
        Wed, 03 Jun 2026 22:48:59 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.133.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccd9fa7fsm43355846d6.9.2026.06.03.22.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 22:48:59 -0700 (PDT)
Message-ID: <6a2111cb.541e6ed7.38c93c.64f0@mx.google.com>
Date: Wed, 03 Jun 2026 22:48:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5548688735092568215=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, Tim.Bird@sony.com
Subject: RE: [v2] Bluetooth: Add SPDX id lines to some source files
In-Reply-To: <20260604004125.715884-1-tim.bird@sony.com>
References: <20260604004125.715884-1-tim.bird@sony.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5548688735092568215==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1105609

---Test result---

Test Summary:
CheckPatch                    PASS      11.11 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.16 seconds
BuildKernel                   PASS      24.21 seconds
CheckAllWarning               PASS      26.43 seconds
CheckSparse                   PASS      25.14 seconds
BuildKernel32                 PASS      23.25 seconds
TestRunnerSetup               PASS      521.43 seconds
TestRunner_l2cap-tester       FAIL      60.35 seconds
TestRunner_iso-tester         PASS      82.36 seconds
TestRunner_bnep-tester        PASS      18.66 seconds
TestRunner_mgmt-tester        FAIL      212.20 seconds
TestRunner_rfcomm-tester      PASS      25.41 seconds
TestRunner_sco-tester         PASS      32.36 seconds
TestRunner_ioctl-tester       PASS      25.64 seconds
TestRunner_mesh-tester        FAIL      24.88 seconds
TestRunner_smp-tester         PASS      23.19 seconds
TestRunner_userchan-tester    PASS      19.58 seconds
TestRunner_6lowpan-tester     PASS      22.48 seconds
IncrementalBuild              PASS      22.52 seconds

Details
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 95 (99.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Server - Set PHY 3M                     Failed       0.277 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.243 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.857 seconds
Mesh - Send cancel - 2                               Timed out    1.989 seconds


https://github.com/bluez/bluetooth-next/pull/285

---
Regards,
Linux Bluetooth


--===============5548688735092568215==--
