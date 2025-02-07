Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCF723C8CB
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Feb 2025 21:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738964494; cv=none; b=bdXEk9tYreTVIJKCmJ59SFjODoN4KOvQUXNi1GSTbYj+i0vG9C5qTdkXXZ1Y9AfsMIBjbuuUyxMocrfNS9xSXwXrQct8d8W12CQTDw4PpwnzxV8e6U+cSkCBxZVpZHHgYgiJpK3OT9uWXZ2+SuQV7FGg54+YhuHRtlKicKl+uRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738964494; c=relaxed/simple;
	bh=0qwaUh3FX8kzjjJKoHZUa8Z2/M4yyVqRsgfLsvaVUT4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=oNKkG7oUMJI8pkWcJi1ScGfUF3b8o5Jd7y9fSYSmMtA03kh0HDF/zT5sb+bcFYLvx4FJwFO1ToyaGdeHGl7eApzAZEX+y9AhcU/JV1f6QnjrRY68sR1Ao4lL2D4aLnpfZ038uEb62F03tmmv8eyKnKRxpKSkOSp692ig1bXcRFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCU0malL; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCU0malL"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f4500a5c3so43926065ad.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Feb 2025 13:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738964492; x=1739569292; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=134ccd1380Q5QMWD+4IMqOEFyc+dUgt1LLuXIDbSYp4=;
        b=TCU0malLVGeU6EsdclTSL6ign4h+Ln7eD+4Ij60oIi66Ps4CMHYeIYYD/s4oSHMVkL
         S0kAMvcrIO2AUByORVCFfU0Vrx3gEtTQT9aCIFNMAeqBkP8mTymVFnOosufM0UI89g5D
         unz2FdsA/NWAM/BB7wmkpGvT1zNUYOGqcJ+72220e0BI1I1+oy4m9F25xh6+DZHDJImK
         MRgEquX4AleEaXG8GQJJbFSBKxd2pLom63JZEsULyi7rYlo+mx8hdxGOaMQGwbvdvKZg
         YP1jxIqLQ9S8KLVleztHwogOrBmLpo8nJ9ML9e/7hyCQaSfI8sdN7XdLngovfVFukqMe
         WZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738964492; x=1739569292;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=134ccd1380Q5QMWD+4IMqOEFyc+dUgt1LLuXIDbSYp4=;
        b=RSYcw+fmJAsqGtPh456k8Z0fLl07oh12sUyJxU5H35fM9YH9/WifTdThoWJykQ7tg6
         sXfsBu7y66AaPPWiu3odU+r/hfOIJsapb5CxMWZc5mQ6RiSZJu3tE+rV9o5vJWIY+xnd
         HyYA68QBr0gAir85gecWKHvQ2EufSDcQbrlcmbsOpeXU5znXNOqzpMhPi1Dm9p9qFdlc
         cmfmdFf5RKLdGzwJlYqe57nMWiHqQO7ZRH1k6jDoyItAY4ZXI8zowozpzzhmAqFilQr0
         2gpURZf2yLrIrCypuR0+zxhAy2Rp5o705SxLWY+F8nTCikwogDflEPbP9vptqu9Xrk+O
         9OYw==
X-Gm-Message-State: AOJu0YxWL3p2l2Niya3618zvcQQn2YKgGeHxPDaBZ2kdzMPM0KvHK5nx
	vf3VSadeBdXu+T7Bce249Z2r50Yrhex74viT65lvGLHIp8a5O3SJLHN1nw==
X-Gm-Gg: ASbGncvZJxskXOHZvag6xszXlvdhfH3aYzSMscB+VmMTbqt0A1ViXvVGFLolwGeR/zE
	WVARBXQDwGnaWZ8znWIysYNvQEmRsVbpPMX9D9/yQaIel0/UTKTe1lEuyZbEWHUOrmRuVkBGC3H
	SCRPyx4fOUvgAx1eEBNDeDi4GfZ7Oui6Enhw3C30lG/XoDOIrtvao7Hl211tHtLLKRSBA2TyXdj
	IejZuWMexpbcJbm+8pWExs0WJRonVDOt9ia+qk52Wp1ZyV0FOiCJyLOh7XO0nb9eLyyuUAR8e2G
	iz+s/Ne7JDhCbRk4y8XpQJY=
X-Google-Smtp-Source: AGHT+IGUSy/mZCpyb9/9g27fz4ivZesSVTq/wQbBhBhFcRYBK7NAG0xCcQHC65BTc0xEVvGVN+y7WA==
X-Received: by 2002:a17:902:f706:b0:21f:85a:3824 with SMTP id d9443c01a7336-21f4e6ca741mr88879035ad.4.1738964491730;
        Fri, 07 Feb 2025 13:41:31 -0800 (PST)
Received: from [172.17.0.2] ([52.160.161.187])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3650f087sm35669725ad.6.2025.02.07.13.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 13:41:31 -0800 (PST)
Message-ID: <67a67e0b.170a0220.3dbc0.e7de@mx.google.com>
Date: Fri, 07 Feb 2025 13:41:31 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3525576858174503177=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dmitry.baryshkov@linaro.org
Subject: RE: Bluetooth: qca: add Qualcomm WCN3950 BT/WiFi chip support
In-Reply-To: <20250207-rb1-bt-v4-1-d810fc8c94a9@linaro.org>
References: <20250207-rb1-bt-v4-1-d810fc8c94a9@linaro.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3525576858174503177==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=931756

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 FAIL      0.66 seconds
BuildKernel                   PASS      23.98 seconds
CheckAllWarning               PASS      26.67 seconds
CheckSparse                   PASS      30.19 seconds
BuildKernel32                 PASS      23.84 seconds
TestRunnerSetup               PASS      430.03 seconds
TestRunner_l2cap-tester       PASS      20.53 seconds
TestRunner_iso-tester         PASS      31.29 seconds
TestRunner_bnep-tester        PASS      4.81 seconds
TestRunner_mgmt-tester        FAIL      121.48 seconds
TestRunner_rfcomm-tester      PASS      7.68 seconds
TestRunner_sco-tester         PASS      9.37 seconds
TestRunner_ioctl-tester       PASS      8.07 seconds
TestRunner_mesh-tester        PASS      6.05 seconds
TestRunner_smp-tester         PASS      7.01 seconds
TestRunner_userchan-tester    PASS      5.02 seconds
IncrementalBuild              PENDING   0.48 seconds

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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.175 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.185 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3525576858174503177==--
