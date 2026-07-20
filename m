Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81D2434E32
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 16:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784566082; cv=none; b=YpXjYQTkkq8MmyuWLDvr/1cSUP4MX/jfCcP0oki/qvUoW9DS/J4lTn/EBJni8OSt6U5s6FUIFdB4bBYx9S2BHfLxF0WE9dMSbRd+QOYiYI1r7bEUFgqXCqm7lONL8vyjtowIbItgK3u9c8nHdk+w1YqHKNfIP/raR6k0UVvLi2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784566082; c=relaxed/simple;
	bh=Fo1yVQcggw8huR8L4shf7TzbIP9fIBsb+NnC/nn5i/Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ly+FxGd7lKTUa5AhNTnw4r4TPiEmp9jrGm7rJH8F3nx/ZmHy3a4W/C5UATLBTUWDIExo7YviaawmKi64QYuzlxaOTnUwNNI53tO7px5iyGI5UAPBVZ4vTcu89rEe9Tk4kAiKL6aU83VZ+osWFUINWYoB/7STi9Pj93z+OGX4A3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sIPItpMv; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sIPItpMv"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c9e7391839cso6329886a12.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 09:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784566081; x=1785170881; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NNRsbityB11daGf6l3cxtEsdSRSDKD9+mz/w3nBtt78=;
        b=sIPItpMvSGWLWbvwaKsOiRlD3V0O075Eh94vsyyLukJNJC040Uqsabu+pgpIiy9i5x
         Hy9Fr3NIsJ3AfTaBM/u+e2+U8Q48ON49O0kdVGztQVw4yoiow3Dhs6fTeVZN23IReaPs
         sPJJCA0y6/AJ4h9gqhjGAxmhIh3P72ewMsYhwT6aR1ICLNsNv85UIXbni28027iQv4Ll
         KFdXMyvkjZ9qme/01HKK/eTpRaENM5SU5LjTAOShaVJdYRBaO+K4gF2Ti0KasBCQgzLr
         N76OANz/IGNPmpdbxRqGwduH4thdaNgWPmBWOIqcvySzBB7H2uITJDZKzcuODCztb0p+
         IKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784566081; x=1785170881;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NNRsbityB11daGf6l3cxtEsdSRSDKD9+mz/w3nBtt78=;
        b=FSRlvWXhkMroebtVRCkf+HDFuUMn7SA1A0nRhKnXdJLFlI6fdrazsLtDbTje3zUDkS
         h5reFFlTuOyFFoz72t2Al/J6q4Y4WTplu9MCrgnXwLjIet6CfHWNy8qq/7Ga760ByDYv
         q3dDpoZMPa0ouemqSXtUDZcAYSFXtKQzJ5g6xVDAG5aRzpTukcZ5xM2og1dXT3Jl7zVL
         9GUw8cZ0GRG/iNwCVxVK6aBoldItqmXdG3iiehUDzDm85eKW3DJljTulI8eFq+A6Fw/y
         ctp+1hggtzgS/TZOFqx8LY2ig4J7G2QBk40hpgxOTZdt7D4AhkXnmexVHKRAiBm/x8Fi
         +x3Q==
X-Gm-Message-State: AOJu0YxX/Pui4P/jUm0Rx1LuoFot1KQ1eunKVzjxLb/Q/t5Zr7KS3wlZ
	XMjscT7w84o5XqkjLtj0Zog3tprdidecvoDsD8ENjsdV0R89M+PtDJj2krcKpw==
X-Gm-Gg: AfdE7ck7PFQ3LnpQSWR+b3piARNhVd7G+voLNNWHE+ezo+LbWqjh/GXcGNazFzae5Ae
	GIcsm+naC5NyxOXTLi3bF1kGT/Z2vFVqC6cGSFGZtq+Kaee34+6w6z+eZKCldOs4i1Bcmgac9t0
	yflftsr48rZLS6kMF3dbxCp+l70mhQ8giJyTLpk7APSdR+N+TG4fe67cvlnA5lX/yP7Z1yg2KLl
	NXnLwA+xi/IaCEO6zYXT2zs3Ui8lCLh/lpWm/TQiZO6vP7JcJGauJZITxr7Zk8wWzYZJFX7ji8t
	yr3kKUOt1QNE6YbF5ZL+hCjykN9akmXNryWxOrY6bo/9rP6FTAUgTRMOS2AV8XZZoMJJCCf+sZQ
	6P6W66XZTp1b4Mugs/UtywmnZ2CL4VCvdR9T0IcxkHsXPc77qxVi3CgotJyOmlO7wI/T3wUbnvv
	mFEOCiTCoO
X-Received: by 2002:a05:6a21:4a97:b0:3c3:64cb:9b99 with SMTP id adf61e73a8af0-3c3ad5ff39dmr17558858637.6.1784566080913;
        Mon, 20 Jul 2026 09:48:00 -0700 (PDT)
Received: from [172.17.0.2] ([52.250.243.36])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429f9d439sm45536746eec.5.2026.07.20.09.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 09:48:00 -0700 (PDT)
Message-ID: <6a5e5140.743400b0.23a7b2.c05b@mx.google.com>
Date: Mon, 20 Jul 2026 09:48:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6295401824228557050=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iva@yenya.net
Subject: RE: Bluetooth: fix BT dependency for submodules
In-Reply-To: <20260720150919.9602-1-iva@yenya.net>
References: <20260720150919.9602-1-iva@yenya.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6295401824228557050==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1130992

---Test result---

Test Summary:
CheckPatch                    PASS      0.95 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.22 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      27.63 seconds
CheckAllWarning               PASS      30.42 seconds
CheckSparse                   PASS      29.04 seconds
BuildKernel32                 PASS      35.21 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      512.13 seconds
TestRunner_l2cap-tester       PASS      60.63 seconds
TestRunner_iso-tester         PASS      89.18 seconds
TestRunner_bnep-tester        PASS      19.06 seconds
TestRunner_mgmt-tester        FAIL      213.64 seconds
TestRunner_rfcomm-tester      PASS      25.85 seconds
TestRunner_sco-tester         PASS      31.82 seconds
TestRunner_ioctl-tester       PASS      26.32 seconds
TestRunner_mesh-tester        FAIL      26.18 seconds
TestRunner_smp-tester         PASS      24.30 seconds
TestRunner_userchan-tester    PASS      20.34 seconds
TestRunner_6lowpan-tester     PASS      23.37 seconds
IncrementalBuild              PASS      26.15 seconds

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
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.250 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.216 seconds
Mesh - Send cancel - 2                               Timed out    1.992 seconds


https://github.com/bluez/bluetooth-next/pull/463

---
Regards,
Linux Bluetooth


--===============6295401824228557050==--
