Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002B54078C6
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 12:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788180281; cv=none; b=BZhcYUPMqTZdDXR+IwHW/5Q0W5lgPFSUQjD+rKoHJBHnBWctcL8gnnMTTOO+hLT3N9dbKv5kXa8mG1H8iHBGi4lQnXrXJIIGY0S9TsuPfxO/5giBnGZY5X5EaMPALWJTujjXeYOGBixuILkbKcWOp6YaYvHhTLSlG/yeMJqV8Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788180281; c=relaxed/simple;
	bh=c4G3+gQYO/9imfWsBZhDRdwyB25p8MCK1uDI1d81zGY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=g5OXiadojl311UJo4hyYdg+YegMyXupPwMnUzKN6xOenR34QDLM5SFYLKR7Wox6TgHCDilbjOmMH8EVAzPamhQT76jfNmgOOV61wZWHeuuijMU2FGdlVLEvsB66ebhbvMo6SmDVcYcR4rs2lQaYCvWq7mP9KdwXuBZNujFHHFco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h911asyq; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h911asyq"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d8f265cbe6so17033735ad.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 05:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788180277; x=1788785077; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QjBWKR+831R7jKxPW6k5XoCLeccdVn4Lu4QhEzlTD5Y=;
        b=h911asyq4XCzD7kR1f6XIG4Lv24Y9gYiSUVIhiOtKKb5DRlRpt+9IXr7JBxdYvOWjZ
         GSiSZ18PS7pxf7eqIOFSqqnDxEX0HpcSH7C5xA4YaBjbQ+LzGNMWm28CuaCItg24SFM6
         uCZ2W6JmXD4jaTphou1EBOxyehSOuqyadaGoBN4ds6zrtWyJQFoqZGfWF+1dOQA6caPm
         JwgqxzH2Ns+OxwaNJVX2bcYdkJjVR/xJUd2+oyX+AkYMamilIhnx7ZFfYGvftEv8VQF4
         GEGd8oX/G3hNOKyOzP6LVD+rhI+f51NVEhZTbkF2+uybojHRsal34B1080cjuaSR8IT5
         7LvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788180277; x=1788785077;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QjBWKR+831R7jKxPW6k5XoCLeccdVn4Lu4QhEzlTD5Y=;
        b=snmePGv1LFgN+pgItghvYHzos8GaCsX9kP9wBN0GSfAjanJlT+6jTPhogs7CBnFPmA
         OsT5iXCu+pTavbBVFeV0315KTu6pTVbQjs1iNjUN9/2ppOWgfaiTt8LVJzPfviSqo6PN
         elfi0CiBjN4M8axYVOKM4MzGIr7+dEbl+7GWrWH7mCSMPmkmC7DppmCyf+MtsMEjTRpV
         dEraSwIp0J0nvCIiVsgetAJvtnPFJi58sVlb9PuNa3PvkLIEm1U9p+x2oQ7Ij3rUh/dT
         s5O0sQlO/7/0os1sqITiNVb2lTl8gITiRGQKAZMinxtT7U9PQretrkYAU78hH4ysA9B/
         Ky8g==
X-Gm-Message-State: AFuF++nf+Ji3vp8jugmtKmi/pHbtQ1xszU2VbI4yor7rTGy6kpAbowVx
	mhkoaQF9fCbYG5DC+5lfZ4f+AjzjeA2UM35T3XDnXwmpWoMtnwLlYnuaJtk3k0P9
X-Gm-Gg: AYBFou1dfLRyqmuAUIRtimxb6Pvfp4RPZD+B/+L29eo2c2onNyUh2epQHGjfzvZPUvc
	WGvKLC+0AwRe6MzyMRqEWWrhPaA2IDcyTh7k9h3GpHK7ASPxSwd6cY/fL5ytwIliAfsgQaE6S0i
	EGkqi4QWhdQm0mJAdoBgZumBv0X6t2JQNgzpSn1ZaISqXq6UW7/W97AiTnh2PYh4p2q5yxV7XjL
	xwY+fhpQcOiJpYpcJ/tcc2/5uxqy9PLcF4aKNmPLALOmoEkm7hlHmzQxJwXY/xx3IMwZ6NVaoFC
	z3k+TIJ9rPt2SI+s0f0S4Vn68+gcghW5LboBJ/eUzKfDBULlAIZsN/eCqyjIobs4jamdT96kA5r
	8vt4Ar8/3HRjAkiH/fTjYDRj5oC0BDuNuZ9T4RhAzFprHcCO4fdDSBABaynrIM7lWDPZYi+qd4T
	DrGmw0m47c0yqKEBffEgVq6k4Xuxx6B0FTKwu8mw1ZmOyHv7Ihz0CEXZXFzqgoELc8tJE=
X-Received: by 2002:a17:903:f8d:b0:2ca:f21a:a6c5 with SMTP id d9443c01a7336-2d74dbea25bmr434839785ad.1.1788180277133;
        Mon, 31 Aug 2026 05:44:37 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.109.195])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32b5bef7683sm15586463eec.12.2026.08.31.05.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 05:44:36 -0700 (PDT)
Message-ID: <6a957734.496fef5b.138ea8.3a30@mx.google.com>
Date: Mon, 31 Aug 2026 05:44:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4877653978135580193=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, valentin.kindschi@fiveco.ch
Subject: RE: [v3] Bluetooth: hci_sync: pause advertising for the scan address update
In-Reply-To: <20260831090232.1726063-1-valentin.kindschi@fiveco.ch>
References: <20260831090232.1726063-1-valentin.kindschi@fiveco.ch>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4877653978135580193==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1154320

---Test result---

Test Summary:
CheckPatch                    PASS      0.59 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      25.40 seconds
CheckAllWarning               PASS      28.17 seconds
CheckSparse                   PASS      26.81 seconds
BuildKernel32                 PASS      24.68 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      462.48 seconds
TestRunner_l2cap-tester       PASS      68.22 seconds
TestRunner_iso-tester         PASS      111.20 seconds
TestRunner_bnep-tester        PASS      19.09 seconds
TestRunner_mgmt-tester        FAIL      226.15 seconds
TestRunner_rfcomm-tester      PASS      26.17 seconds
TestRunner_sco-tester         PASS      31.89 seconds
TestRunner_ioctl-tester       PASS      26.55 seconds
TestRunner_mesh-tester        FAIL      25.93 seconds
TestRunner_smp-tester         PASS      23.38 seconds
TestRunner_userchan-tester    PASS      20.25 seconds
TestRunner_6lowpan-tester     PASS      23.28 seconds
IncrementalBuild              PASS      23.76 seconds

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
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.251 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.994 seconds
Mesh - Send cancel - 2                               Timed out    1.987 seconds


https://github.com/bluez/bluetooth-next/pull/672

---
Regards,
Linux Bluetooth


--===============4877653978135580193==--
