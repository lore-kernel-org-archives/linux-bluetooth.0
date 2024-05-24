Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8DC3B28F
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2024 17:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716573463; cv=none; b=Ml6MM6CcB9HHVU8yq4yWBJEKSYb1/hRksX/6t1G9qP8/4+Q2Wb69yBXs2lMIoQe9spbvssI2bBZLpALPn/b/lel+Sq9e2v/ZDqBXPxk3O9dYzdHhv1Te58hgAXtxsJPO/gSdnCsdzrjHSTkAcVYnzisZqhNoHU1Di2VTkgqgQdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716573463; c=relaxed/simple;
	bh=ayFbHz5S3s7w5FCzf0HEiZuaE2LLgFTQ3tU+Epzz0us=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NaiMSJJ9Biq8UBq4iN/szR6wdqCrTTEakjEkOJobkWn9zg65Pr+h9USjGD25Jn7VR98BbPJWFYfUZ4rN/kYgstSTCrK4qviOjM0J7Gkzo5Cn7f99ZwHIx8MfveUM6GOKOHVoSjfoWhuIEdL2bX685aYCkQwsw4oGaiKfFD5Ju6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRIR8UOl; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRIR8UOl"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-df4d5d0b8d0so3964561276.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2024 10:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716573461; x=1717178261; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4Uxsjo2bIOsMLDBI2pt7wuhMj1uCbAaQ351AKht8iAA=;
        b=lRIR8UOlQ++NH/GgN2yNz1oG7SVS9aKCfGtDR5Kj0WyAy14fK+QunFnZ+v8QrVIiaS
         12AkOXhgRlpzvahz3kvanfDz0lcJFMRuGkPrLgNuBNTNKGAdQwV3ubGv0opQo2AcTfrH
         xMKZD1AadA7t31VAdtAApaI9Xw2z1IfOZ2/kAAoOUDhQSTxqYWcxfS+KyE/5/NnoDy0+
         CMXcizYBBFzogBVlfbCrLYO4OsZxv/4205JeUwjdzB533KkmVBd3iwK8sKprZTdaN/p1
         pzjF55gbamu35O1EYshkFJTyR8um+OO3DzZEVpBHSF3fzwEP07QgphGUKUa1x6dpsF3P
         /Y2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716573461; x=1717178261;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Uxsjo2bIOsMLDBI2pt7wuhMj1uCbAaQ351AKht8iAA=;
        b=SeQFq8dYjHXL0bc6m4RB7lB4xl7rEzOzOg54ePdnulCtd1APmuwU8Lh8IMM9yl0S4o
         6eJWT2QHZ7M7MBQeAH1+8zDbDYCUgLcOXK0COQMK5EE51ZqYxM/Rofe6BGnLA50xpnIR
         0+tmR/U7c2i4LDqGCBOXiioqacIAuNOD849pVaoZDH4MAMsjPE1ffbtgHp3qD66NSE25
         fB98Bekq07Fasg2yKGa7bAGzE5PyxhidWs0soL2FNVV17L4m4Y5NFrKm9q2/EtUSMNhI
         RoFeyk2l1VSf37wIBRnR8b5ePhtkSo3TlZz7d+xX7p4xQKerKD8WwOblOAs4B8TJIw8d
         nOeg==
X-Gm-Message-State: AOJu0YwrtGKjKC1/DD/6tsrkjHKGtlNo07kUWMchOBPSCbPm1k0Cpjqn
	OrWtqIX/V8a4Sy7F8DUUrBi0Lh509OMN0uHuw7CjndPkgoRMqX1j75KA9w==
X-Google-Smtp-Source: AGHT+IFSc+XM1sJIFkXyVfdX91dnJYmpKyCWJBMAdZv3CSmMv+u5Kxs2VzTCACMJ9JpH2r2I2aZbNQ==
X-Received: by 2002:a25:256:0:b0:df4:ea00:d01 with SMTP id 3f1490d57ef6-df77225db4bmr2896403276.62.1716573460595;
        Fri, 24 May 2024 10:57:40 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.46.223])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abd46562sm81242385a.134.2024.05.24.10.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 10:57:40 -0700 (PDT)
Message-ID: <6650d514.e90a0220.54129.3540@mx.google.com>
Date: Fri, 24 May 2024 10:57:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3666380899691388857=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, erick.archer@outlook.com
Subject: RE: Bluetooth: Use sizeof(*pointer) instead of sizeof(type)
In-Reply-To: <AS8PR02MB72373F23330301EA5B897D6E8BF52@AS8PR02MB7237.eurprd02.prod.outlook.com>
References: <AS8PR02MB72373F23330301EA5B897D6E8BF52@AS8PR02MB7237.eurprd02.prod.outlook.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3666380899691388857==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=855756

---Test result---

Test Summary:
CheckPatch                    PASS      1.25 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      31.68 seconds
CheckAllWarning               PASS      34.92 seconds
CheckSparse                   PASS      40.10 seconds
CheckSmatch                   FAIL      36.75 seconds
BuildKernel32                 PASS      31.00 seconds
TestRunnerSetup               PASS      552.81 seconds
TestRunner_l2cap-tester       PASS      18.88 seconds
TestRunner_iso-tester         FAIL      32.64 seconds
TestRunner_bnep-tester        PASS      5.18 seconds
TestRunner_mgmt-tester        PASS      114.80 seconds
TestRunner_rfcomm-tester      PASS      7.70 seconds
TestRunner_sco-tester         PASS      15.39 seconds
TestRunner_ioctl-tester       PASS      8.17 seconds
TestRunner_mesh-tester        PASS      6.23 seconds
TestRunner_smp-tester         PASS      7.17 seconds
TestRunner_userchan-tester    PASS      5.27 seconds
IncrementalBuild              PASS      29.54 seconds

Details
##############################
Test: CheckSmatch - FAIL
Desc: Run smatch tool with source
Output:

Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: net/bluetooth/hci_core.o] Error 139
make[4]: *** Deleting file 'net/bluetooth/hci_core.o'
make[3]: *** [scripts/Makefile.build:485: net/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: net] Error 2
make[2]: *** Waiting for unfinished jobs....
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bcm203x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bcm203x.o'
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 122, Passed: 117 (95.9%), Failed: 1, Not Run: 4

Failed Test Cases
ISO Connect2 Suspend - Success                       Failed       4.230 seconds


---
Regards,
Linux Bluetooth


--===============3666380899691388857==--
