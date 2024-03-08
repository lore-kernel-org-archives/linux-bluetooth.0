Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637DD8C1A
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Mar 2024 16:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709916296; cv=none; b=p9K1wz9bkPc02IdkxHs9+lpmYo02td8KLpwKYJRskEDKXkfKBL5Zl32PMsUlDNjJ/oOgWcjdk1FXetSdHPASQmKqsJu9YCsIux+1wE3uU9U1Xtn/2Thnwg3duHhOzuSHbPgXOo3Y7eZwWGagaWmV7P6WpKjJQ9/6WNqFzd2C9Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709916296; c=relaxed/simple;
	bh=aMJd3TemE99M9OAxV6e1U3hASFXl5vRb73CHpB/uB/0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qyVpgKNI0zzQBGLgw5LGXCOtv5MqsIfv2One0YuQal08Iec9DeBbil1tPEusQa+yY94aMMtZEl9j4Rk5woK4etRO+Z4jYCAq4gLbdzYq3DhIFV4vsIWqIFtX701gF0T0eNM+kp3iUCflKCOPjA7WNk3hPovOABoQv5BDOc7CO/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VdsKhZtH; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdsKhZtH"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dcc7f4717fso8356575ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Mar 2024 08:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709916294; x=1710521094; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SoW/syF6TI2pDReqvMdKWwBqNGbHk/lXLryJVadAREc=;
        b=VdsKhZtHbLIFvsNbXHQIHxUA1fjdqiVxZBT6TuJDVdey8oFTlhfwLFaMifq1hbhE67
         BBvqJx6GugkaJhpgCfWGrhLIl5K+DE/5c0CaEZ0P3Whbh0vyVS5QY9l9CWrQudph+K0O
         XtRB+i2WW1RPhSV1bicCsH613Euu/FPknov79vv4kBxdiELEzk8Wh4d57TiW38ReH60G
         VfPIg6F0S51xSZP8YGzWtBY2HdS88EtM56wO4qLJQVp6Ohtj/bZVOUrYITu1x9oS3ZtY
         6swXk1Dij69+m97rI2PUZletcV73ah4RF9btxk1V3FSOEdkBZOu3rB5t2+GSfcle39WD
         B0FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709916294; x=1710521094;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SoW/syF6TI2pDReqvMdKWwBqNGbHk/lXLryJVadAREc=;
        b=SrRO5lKyGd0MvLu1rcxpI81jMOksOefnBcLIJZuVyRajrkXxQYz8Jf9rli//ds5RVJ
         uQUkNJQjbz/A/Pm1DWf+prGcYFKKmJ6COV1GTFEHxbx/xWUE7DsCv0fX4JOG8sRnUubK
         3j5J7eBV2JWZkguOFxkShHiUNruhad9g0E0I7kV+2HiGyiQ/4el7qCeEiZd1GBjFr7Oj
         K/2SNMylpva1TYOqr16M69SuhOc37/q/vnEdBsQy8FIIYwSVyxNLgKqMrfh4qW6nFqnH
         qzFagiSvM33spYslen86Va8uBTfAkI3UmFl0DWFt6JWPjxtskMvCjsEgYVyjsZYXU5HT
         tNkw==
X-Gm-Message-State: AOJu0YwrTOXVTX/r5nmnQGZ+ew6pvcfwr8gPUJS/CDvssJhpxWzABZ7C
	czqoOZBUmujUKnLtYBdj+grEIok0QKwDR1ZyVLcPgrMG3Mk8k0fKHA80fc3y
X-Google-Smtp-Source: AGHT+IE0KxlMxxvwWyK6xwsGCEYxjHhzosD7OGAiTQ8KYVHBBdo8RGd5D7uN5i4RP+usY9ytqNu43Q==
X-Received: by 2002:a17:902:c40f:b0:1dd:7e2:b9c2 with SMTP id k15-20020a170902c40f00b001dd07e2b9c2mr11628322plk.10.1709916294456;
        Fri, 08 Mar 2024 08:44:54 -0800 (PST)
Received: from [172.17.0.2] ([13.91.68.162])
        by smtp.gmail.com with ESMTPSA id i7-20020a170902c94700b001dd598ee468sm1983395pla.67.2024.03.08.08.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 08:44:54 -0800 (PST)
Message-ID: <65eb4086.170a0220.3ac61.7f65@mx.google.com>
Date: Fri, 08 Mar 2024 08:44:54 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2841279062303479388=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: hci_sync: Fix UAF in hci_acl_create_conn_sync
In-Reply-To: <20240308160715.88478-1-luiz.dentz@gmail.com>
References: <20240308160715.88478-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2841279062303479388==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=833836

---Test result---

Test Summary:
CheckPatch                    PASS      0.50 seconds
GitLint                       PASS      0.21 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      28.49 seconds
CheckAllWarning               PASS      31.21 seconds
CheckSparse                   PASS      36.86 seconds
CheckSmatch                   PASS      100.73 seconds
BuildKernel32                 PASS      27.56 seconds
TestRunnerSetup               PASS      524.37 seconds
TestRunner_l2cap-tester       PASS      20.51 seconds
TestRunner_iso-tester         FAIL      39.68 seconds
TestRunner_bnep-tester        PASS      5.02 seconds
TestRunner_mgmt-tester        FAIL      116.26 seconds
TestRunner_rfcomm-tester      PASS      7.61 seconds
TestRunner_sco-tester         PASS      11.25 seconds
TestRunner_ioctl-tester       PASS      8.13 seconds
TestRunner_mesh-tester        PASS      6.06 seconds
TestRunner_smp-tester         PASS      8.09 seconds
TestRunner_userchan-tester    PASS      5.15 seconds
IncrementalBuild              PASS      26.60 seconds

Details
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 117, Passed: 116 (99.1%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect2 Suspend - Success                       Failed      10.272 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 6 (RL is full)               Failed       0.198 seconds


---
Regards,
Linux Bluetooth


--===============2841279062303479388==--
