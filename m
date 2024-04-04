Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7414D83A19
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 11:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712230217; cv=none; b=nG6sa0GO0f+NA1bLy+PuuUqKdqsVGmMC/CdfjQcZ1i+ewrGjz3x5PrrR7lYMcu8si2ky/1enCKiLQreFoj57IPmO+f9DEFLJ6V4anQbGDgfo6flPEyumJfY+trzTqIfavczMDtHrVF4NBK2InDIZ7+ciluY1iuKBzUbX9mSY5lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712230217; c=relaxed/simple;
	bh=57Aow+AP1rZEtvOojub4ED/8gXRj3Rb15l/FWRYE7bM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=e5MZAU9WnseQKHGlp6WjjpGd0C4s8s5fx6vm6BTleoQnehAxpYGwAZQ/pYQC9rjG+y5N55z7BljvtEnQ4iUJVpC1qIWH4XbbDdbELEbKNk9/VZKcCqOLq2cBqacwOQ4xnvUOUJdi44jbBlNDefFGwNR/KmLFUZk90f7jna5CinQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRUCX8j0; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRUCX8j0"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-78d44a8ab6eso12509485a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Apr 2024 04:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712230215; x=1712835015; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kdNWMi//cKsty+izL+kFLM5i6mOj27IQIScpDwiI1EI=;
        b=VRUCX8j0I1gdLitBTfW65sbB6iP0O8oReMB6xqqDLa7wEg1Hg4y2xgEmERkfUKj3jK
         3BGHVQftwC5m+lRdvTrxb/VOHUI9RLaBkPV2qeLtwDS9i/YGT285awIXNF1z0Z7JDKim
         5Xx3Mms2huSc/4Ouj8s9Up5SDDiS9DWaVzyjoDzkC4hY1/Za7kRqfM82cvQuJl7/Wnf6
         85v3gCIzm63GVuU9ZvNpRJw/Zq7DwKxnlZuvtqud5l0N/AahlsRl7GBZ2+vzJytihoeK
         so2qqYxMtXxFIcDdvmglVrB+PVUdN6+v0P57OJUhQoC3ZKT+ru3RUthFjL4r6qhoMr8S
         aozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712230215; x=1712835015;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kdNWMi//cKsty+izL+kFLM5i6mOj27IQIScpDwiI1EI=;
        b=pqWMh01q+HhUqmAx6v/fCTROclFanKBbMucN0tssJF6ioZiZgs42ej576iBPCaDCYf
         l4NB2ND3cea/KmFrukGCSL+8LNNAb5JgMhQp9XWTGJbyarIFZ8Sc8dhedZUm7J3n8eSP
         +Y7CJZdCMJ32twXe5vKVL4He7aTDZMh77GmzPB874Zvh40Ax0wtqYZCPS5S94yIDsTDd
         N1MufAifYT+FoG5NFHUeeC074msD8jynotCRjWrYKKDXNKZMNhist7I0/gdE9HrHNlDd
         WbKIDRqV+mgV5qdgZ2DNtnlsgqXEEB/8+242JbV2+Lul/KR6K7Z8I94aZgiohYxYHRbb
         9TMA==
X-Gm-Message-State: AOJu0YwRlbyBuvZrJ0GkBMUVniB4WJzcDUXiFSgGlgKoMdDmsI5JOSjG
	yHO2796Aztq9v3SSqu8k4ZWiwtXonFYh7uaNIxVk1+qZXiGalkaJ60bkNbP8
X-Google-Smtp-Source: AGHT+IGKbJp1lJqQmfz62SwkUQtvQ0t8mJA09ehZHlKXrmas175MSPB0rzxQwRT98vqcoiA3YAPrCw==
X-Received: by 2002:a05:620a:408a:b0:78a:2655:3066 with SMTP id f10-20020a05620a408a00b0078a26553066mr2107983qko.35.1712230215207;
        Thu, 04 Apr 2024 04:30:15 -0700 (PDT)
Received: from [172.17.0.2] ([40.71.163.65])
        by smtp.gmail.com with ESMTPSA id j15-20020a05620a146f00b00788481cdf4csm5815816qkl.111.2024.04.04.04.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 04:30:14 -0700 (PDT)
Message-ID: <660e8f46.050a0220.e43c5.01f7@mx.google.com>
Date: Thu, 04 Apr 2024 04:30:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3856419044336586082=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: Bluetooth: l2cap: Don't double set the HCI_CONN_MGMT_CONNECTED bit
In-Reply-To: <20240404185022.1.Ic27505c8f1ca7d4a653b1dcc1b08cdfc862a4622@changeid>
References: <20240404185022.1.Ic27505c8f1ca7d4a653b1dcc1b08cdfc862a4622@changeid>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3856419044336586082==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=841371

---Test result---

Test Summary:
CheckPatch                    PASS      0.69 seconds
GitLint                       PASS      3.74 seconds
SubjectPrefix                 PASS      0.46 seconds
BuildKernel                   PASS      30.28 seconds
CheckAllWarning               PASS      32.92 seconds
CheckSparse                   PASS      38.53 seconds
CheckSmatch                   FAIL      36.35 seconds
BuildKernel32                 PASS      31.00 seconds
TestRunnerSetup               PASS      524.59 seconds
TestRunner_l2cap-tester       PASS      17.95 seconds
TestRunner_iso-tester         FAIL      32.79 seconds
TestRunner_bnep-tester        PASS      4.69 seconds
TestRunner_mgmt-tester        PASS      110.26 seconds
TestRunner_rfcomm-tester      PASS      7.36 seconds
TestRunner_sco-tester         PASS      16.95 seconds
TestRunner_ioctl-tester       PASS      7.69 seconds
TestRunner_mesh-tester        PASS      5.80 seconds
TestRunner_smp-tester         PASS      6.77 seconds
TestRunner_userchan-tester    PASS      4.89 seconds
IncrementalBuild              PASS      28.13 seconds

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
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bpa10x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bpa10x.o'
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 118, Passed: 117 (99.2%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect2 Suspend - Success                       Failed       4.241 seconds


---
Regards,
Linux Bluetooth


--===============3856419044336586082==--
