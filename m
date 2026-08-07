Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5471231C91
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 01:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786065862; cv=none; b=sVCl3jAh3NpYwksBLY35IVtbC/x7Fof6Kg8flOrePghP2gRN9txKn5SxphM4pOSXYO2aFXVMrtlDQVpiBOQI+UxyWx68GY9prQdTbrgWtMXdvltHWPVWXGWBAqi264EGoFOkapbzUOj8RM6pcZb8NKbCt3vNLWy2A1JMLsknwVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786065862; c=relaxed/simple;
	bh=Y48Bu8ftOGgA51dtdprbH/3SwW4sJFO2CX5xPugceCM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Ck6C1OQTz14q+b6bEYo/6ix2yPfoQRoGbVzlzwfAmMfslDvuIRp2R599AlID/V/+XwuHOso1OlEQuuMUZ6p8E1DNBTgtwQ0JSlcgiibn+S/FP2pYaELxIQofCWIDXg3nrrliDaOzWgCt8DwOI4Y47xCKreSogTO7EHgYfKBaCZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZF3qehz; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZF3qehz"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cad8076b01so34736345ad.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Aug 2026 18:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786065861; x=1786670661; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5dpj+odImyjqm7gpO8EySGKAd7gDJNWl/ZQyEavYGXs=;
        b=JZF3qehzL3d5bFhX3JYaxMsJBV0HXl6oBHj0cO1Q2KiYXk8isEja24K5UK1aqhXDut
         TWhaAzV/xCCbUpm1QmroM9687WyMpbFTfDl3qavVhFOdPg8PboQL6ZjNPec84jWazZ7U
         B2U++s8VaOjenwfephQECb6xUWYYs8200tELqrIsL2PxVMFZHZuDL7zzBsOC1m2nqssH
         kmm1cPn7Y5dWPCy/hMTRmbKLzIsrpucrINgPM8lWM3hItsVyJIeOdQ+ke4R1ham6rLzw
         7mKUnRoaLX/rvFkU9dp78JA4e0gq5JgBEucNELaF8TrGePxiqDaQZwPD3I1KzcxSYedU
         19Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786065861; x=1786670661;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5dpj+odImyjqm7gpO8EySGKAd7gDJNWl/ZQyEavYGXs=;
        b=N4q1kDHDLlno2RfV5qXJZuNcHw4KBf5EKQAF/JrtOqyFBnZ0PVDx6iCU3+8x0STL5c
         QwwEK9/lgp604nH3tiUWZvn67OkhSAYpUf1M4EjiJzv8OhNsV491RXO08QWqcElu9jwD
         VyuDiz14ol3148T+33QHjOUCt7RqIakGfKz3IG0/sywkLciGbvFSpPGacCej19cmpnCH
         FmoQOpGme/wAWKC1O8l+KW+hk2XDVWVSS0VJWVReZD6lfoVXS8pqkkJsuLodV8Io236b
         1c0U4Fy2SDb021uLhxrvyJM/18tP3HI8EZPSU3KYqD6qO0P04y79oHcOTEGM4h14X+qK
         hoWg==
X-Gm-Message-State: AOJu0YxxwVDfQRMJpKF8xrmJkI5dv5Dh9Rw2jQXwHReRphKtsp9BmOds
	YB0PtfM+srf8XfO4j8pYAFqpTL4FGM15s7i+v/WFiLQfSrGD1+ohYMAp7RjI3g==
X-Gm-Gg: AR+sD135jIACmoPnPbl3V7px08UaVrSTF1M22WmyERgXlbyJxc/JWMVFRoEw/BhOu9b
	Kkm01VMGtTO1641KVmsZ/mZTChM/bs/uGENQ3YUSk8P9PiSQhAU9Kz/b+9KAQETTuYWmCibEO8z
	QfyS4UbyMubeO9P/vH2JuOGe+JmdVk9A+0VgETh6BtgGNqp6UXrE25WsbBmnvfAhJojnJBYNy8j
	MTMWhx5RYq17d6BZ1ijFlpNK51wCTh+Z9wX9e8xSiEn+R0KSltTMr1TRNnvpmLiXTnFWIhmKN6G
	Xn6Zr2taKHzh08w+aO8dvtvzj5MiNGdaZ1J76WojocAsUWqPYatIxYTb+d8j+G+9qz5v4MaAEBq
	jsMtYvV2Z67IF/en7sVmCawbMvdWx5+gFrcMqv6fdlbZ/x160K65pDk4TjvTTJcfriZh5i9AEtP
	t3FUc4rQZPEPAviFMm1YqBvX7wjaoPiEdJqNWSua9MN9P6i/zikd0Y0boZ6e3NqA0=
X-Received: by 2002:a17:902:fdad:b0:2bf:9760:b94d with SMTP id d9443c01a7336-2d0ca7fd072mr240725455ad.15.1786065860966;
        Thu, 06 Aug 2026 18:24:20 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.4.3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bec68468sm970204eec.31.2026.08.06.18.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 18:24:20 -0700 (PDT)
Message-ID: <6a7533c4.436e7ae1.3d40ea.f1c6@mx.google.com>
Date: Thu, 06 Aug 2026 18:24:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8250647669659926563=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, amirabudubai@gmail.com
Subject: RE: [v3] Bluetooth: l2cap: Create temporary hcon for inbound LE connections
In-Reply-To: <20260806225237.51411-1-amirabudubai@gmail.com>
References: <20260806225237.51411-1-amirabudubai@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8250647669659926563==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1141804

---Test result---

Test Summary:
CheckPatch                    PASS      1.34 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.50 seconds
GitLint                       PASS      0.26 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      24.67 seconds
CheckAllWarning               PASS      26.91 seconds
CheckSparse                   PASS      27.70 seconds
BuildKernel32                 PASS      23.76 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      455.37 seconds
TestRunner_l2cap-tester       PASS      62.51 seconds
TestRunner_iso-tester         PASS      80.03 seconds
TestRunner_bnep-tester        PASS      18.71 seconds
TestRunner_mgmt-tester        FAIL      221.43 seconds
TestRunner_rfcomm-tester      PASS      25.11 seconds
TestRunner_sco-tester         PASS      31.57 seconds
TestRunner_ioctl-tester       PASS      26.33 seconds
TestRunner_mesh-tester        FAIL      25.00 seconds
TestRunner_smp-tester         PASS      23.09 seconds
TestRunner_userchan-tester    PASS      19.44 seconds
TestRunner_6lowpan-tester     PASS      22.85 seconds
IncrementalBuild              PASS      23.12 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 495 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.247 seconds
LL Privacy - Unpair 1                                Timed out    1.857 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.948 seconds
Mesh - Send cancel - 2                               Timed out    1.989 seconds


https://github.com/bluez/bluetooth-next/pull/542

---
Regards,
Linux Bluetooth


--===============8250647669659926563==--
