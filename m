Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5C8227EA7
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 14:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065169; cv=none; b=eKNYz5tNxBOvghDIzPOSgNJ/Zb1J5WJ9dTHMKsrL/JLqqTgJAeP5UHK/HZ3MZR3YcOqESH8ccAOPNqefkY8i6KvqvgxisAydr4ITKpU1Mo6arpO+DvUiJdD05NvXEn3USGxvQnZHSOBd3eOK4H+oZmkCWR5ad7W48VWM7mA2E14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065169; c=relaxed/simple;
	bh=C8zYAvkygcEw2dPltBJAl61X+rxmlcEft1SanAvf+UE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZnjKudhB0SFuUd872KQ/21yQUxauuFCuFuIzdWMNALRVuaPA71nDGntimu7Dt/8dFcwyBs5kDdCD7E8UTioDiC03xwTj15533J/+dvgvET6pkur53w+nTbMTijOUc96XTUYGUsB45VBbZtSoGIcqHYlWZh7gltUBruN+5SNpyMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lh8uIr6h; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lh8uIr6h"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so59284155ad.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 07:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787065167; x=1787669967; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AB/XFB49c94MkwmTAP03VVUaS7arYQ9zILPSG4A6vxU=;
        b=Lh8uIr6hROq5klS+zfhOtsnqkvQSDA7Hm1STh2JCa/1ubjJNYeF0PnhL/fghBvNcoV
         isHpxShO8qZ2+kDKMwN3+t/e4k0X3YNIWoSGBLzmfVbvE5m7/BvaEV67mNo9YhnO/KSB
         kWuWF7UEyoLWCgH4SA1+Hs8YOJr/OuEqF5/06QX4DprKDjHZnHwSL4WIs9V8jywHK5vB
         mnsYN+lM2FZ7npwUD59RpXEUpsTEIaXA2LjNqcqEIqISFUymvF2Ic+E8SBMHNFa1rWZv
         Xqd0a5AlkQVliFgVTX2AexvgyRnUBnAYD6AzmQUNKgmHdvgHRx3abkChb55acDRGeXTl
         qgPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787065167; x=1787669967;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AB/XFB49c94MkwmTAP03VVUaS7arYQ9zILPSG4A6vxU=;
        b=o/DNU/DHM7b6xXq+ii0J1GeEzAvFkk4bhVG3i/eGEPd9q6SzDjCLlZTXm2mMZCiF/T
         CnQWtxb46zKRnrxUrW4+tY7hakGpqb3E/wjOy35wF/xpmg1IqoofymFF6o2c9WpwvSw4
         P7q6OcqSJ1n2ycXQhV1x4esR1jiY98gcYcJMZmyz0Ud/3sCA3CZ/OTOQ1fXfWS4O2hQb
         x1gcIJvsCxoJDO995s+llqUNZVK51w/utrkVl9M8bahwKxXoWNJTPfj14fU3V1A2+qcK
         QPrb1bbfmTrQQP14sAzy2k0rms8UY/S5ljxzUslRBt3EsuGB7VVcFsXr7m5DwO7worfa
         vSzg==
X-Gm-Message-State: AOJu0YzoyauCB2dxRwZ1AK2gvkgjp6Veo0FT/XDAfyVUrzOZTKcZiUIE
	nzzOF9cNVf0P6tjEDUlBr1UImm8WNch9xasI2cF5otAyUcfPx2K8bL8j1b+HAA==
X-Gm-Gg: AR+sD12tC2zin+77MT1e+7XTc6QS0A9DdXESXsP5dSFVEBQtokVZDrHzjDYdOChUrGR
	bx3dUhLIF28M7kxqxhaO7hoyU+w/280vYty381mfiFgv/hIZqa+uEh/vDWXnjmY4rxIK7xCGWfT
	dISWDxQScRopx6lQiCydy0d4CFYdj5XpTngoACGBqDsJsrVIjY0D95yfekzM5GIaKB4sZGG57He
	wP2/UwjcNitEQKOoLdeG2Di43yub9RfuBYKaPgdmwcSRLkEAITKkX50SfelqnOrRCpPcFxNJZg9
	+d38mvLGoK0QGScOxIAYAx+BWUWGkubv4ltLL9Aj69DWNZPttxIVADPvRJZ09hctY9WJbdn3ly4
	GRO/dBvMjAFujsumvHvFaY7kADqYc8odF1UW/zWO/Uzf2/9EimNbBim1dC+0B3m0VlASD/7Bfas
	rXb1TBzZo4g7xnfa0W6PtqM5DalmeH2gU2DdANQPekCWcJySMUkkIH6a4xFug8YaahdtE=
X-Received: by 2002:a17:902:f548:b0:2ca:e565:7b15 with SMTP id d9443c01a7336-2d3b0874ce2mr322306835ad.10.1787065167348;
        Tue, 18 Aug 2026 07:59:27 -0700 (PDT)
Received: from [172.17.0.2] ([172.208.153.8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327b43d488dsm9331935eec.29.2026.08.18.07.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 07:59:26 -0700 (PDT)
Message-ID: <6a84734e.8dff2db4.239d40.98b0@mx.google.com>
Date: Tue, 18 Aug 2026 07:59:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2650093018592463053=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, valentin.kindschi@fiveco.ch
Subject: RE: Bluetooth: fix endless adv params retry after a cancelled connection
In-Reply-To: <20260818132935.1083808-2-valentin.kindschi@fiveco.ch>
References: <20260818132935.1083808-2-valentin.kindschi@fiveco.ch>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2650093018592463053==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1147864

---Test result---

Test Summary:
CheckPatch                    PASS      129.83 seconds
VerifyFixes                   PASS      31.66 seconds
VerifySignedoff               PASS      29.18 seconds
GitLint                       PASS      54.19 seconds
SubjectPrefix                 PASS      9.42 seconds
BuildKernel                   PASS      27.95 seconds
CheckAllWarning               PASS      32.02 seconds
CheckSparse                   PASS      40.40 seconds
BuildKernel32                 PASS      54.02 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      523.32 seconds
TestRunner_l2cap-tester       PASS      102.83 seconds
TestRunner_iso-tester         PASS      84.41 seconds
TestRunner_bnep-tester        PASS      22.08 seconds
TestRunner_mgmt-tester        FAIL      243.75 seconds
TestRunner_rfcomm-tester      PASS      41.81 seconds
TestRunner_sco-tester         PASS      40.28 seconds
TestRunner_ioctl-tester       PASS      30.45 seconds
TestRunner_mesh-tester        FAIL      27.35 seconds
TestRunner_smp-tester         PASS      28.03 seconds
TestRunner_userchan-tester    PASS      46.05 seconds
TestRunner_6lowpan-tester     PASS      44.01 seconds
IncrementalBuild              PASS      173.49 seconds

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
Read Exp Feature - Success                           Failed       0.257 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.696 seconds
Mesh - Send cancel - 2                               Timed out    1.988 seconds


https://github.com/bluez/bluetooth-next/pull/610

---
Regards,
Linux Bluetooth


--===============2650093018592463053==--
