Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA76F9F7
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 May 2024 11:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715514944; cv=none; b=pKs2glmIC/zjsUDtxYL/uGTVpnv2BhHZTRmuMxIR27BowbqfxsfSTJPLbNdyDWa/+UZhwtlLkrdTzpHoHuucTx5q+dzdne6H7q+9w7akN/3l+vgaqwnX1DhsAAv9vZ5laSV0bUL+4+eMO88TPzgxgNyBzylQsif49zNt1zEZWaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715514944; c=relaxed/simple;
	bh=khOcufkcbmHBPbkZmA3nJgBEwG+lXrgdB9/0zYwKpOM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hShAReDOILz16AZWn7kO6KfUHOvFoFKUMFaxiIt1jRas+q9KPlOIc0N/h9w25EmUwhdOGottq2FYICHptHLYxaeWNjFCPi4KfOUzhcGp0iQmeTi3a2VcQP+7kS+S6xEAszxwoyOp/6Yq9pYG/KShWb1sPJSNX5+e8VQPBEHXvtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPAeu7L1; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPAeu7L1"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6f457853950so3032554b3a.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 May 2024 04:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715514942; x=1716119742; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dnHcjLB+PIQC1I1j1YHy5/OLmNs4J3rE9qrL4AtreGo=;
        b=TPAeu7L1F6sfTMqZqsttl/uMRCoEBeI1QyZ8tqkDRi/cDbwQsXg4x7Jn+yEbOw/KMS
         0OzAoSWRHO63jWB5g+Fy3Ev32Hk1t4X2rpCtkr5/MfwRSC8TeMr0V45Tl8TF+UwDK2F5
         O+BH5jrf0jWP2lPSBG8SETOuk2Zj/1c6rZACEoX8Y6ypXnv/eBsPpfBusw3rw1e6cey3
         UjKP/7yPVBE1G4vcwafGbh+XdIA0yNzYeuaP+3J4azyHxVS2r8lFLA2YPUNzQjJyzXut
         V3taJX7A7B1QAJ1ioiABksALFH+NfdpvWDfORTzyWVTiQn8ZZrMWJld9ZcybPfuJ4gLv
         wHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715514942; x=1716119742;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dnHcjLB+PIQC1I1j1YHy5/OLmNs4J3rE9qrL4AtreGo=;
        b=LBb8eDO1Yw/heiSXDYNMvpIE3NBth4OmyrHHx2BhtZGXGweX7U/ZbCsPx++WYvyjCy
         d8h9U3DLFsFn8GQL3WOz1EJPI2z9/bIfpMLlDnDfUB+90LqTYVyX1PkZAnoaWfvRBhe3
         pZ4OCQzvfVQk3Cofm3HAde8YHCqTPHgaiN1Y2YUy+0RlaKTderew2PKceuHkL72X18PA
         iK46mPqlnzS+vG8dA437C73gwyuNMk+ftWhHzRe6pQFCZY5mGhNSXltLG1SThl45xjJq
         CGFVDNMiXxHFtUvcDWb9M7v5ziwy1JLwfJX9t9AJ+myFxfvzzzTOOj2lHCnbTI42gSnd
         ocJQ==
X-Gm-Message-State: AOJu0YykNqRwwJ7B9AlL2mmY8ivo7Ue7wVhS6nbS6y2PdIrYSRUJYjhS
	qEx6SY6NhztfBX/639KlTInUTk5UVXCAdAZez2iMgUpBI3kAdl9vV/g8/A==
X-Google-Smtp-Source: AGHT+IGQVaabwSlkeTZ34szKV2dbg81y2ZU49S9rUn2EZciovvKNMtbRXRU5udfJANnnMV5N5rLrPA==
X-Received: by 2002:a17:90b:438d:b0:2a2:f4f4:2c4a with SMTP id 98e67ed59e1d1-2b66001a442mr14680822a91.21.1715514942160;
        Sun, 12 May 2024 04:55:42 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.7.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b67105649fsm6127279a91.6.2024.05.12.04.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 04:55:41 -0700 (PDT)
Message-ID: <6640ae3d.170a0220.2b54e.fdc4@mx.google.com>
Date: Sun, 12 May 2024 04:55:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3755922231331868382=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, erick.archer@outlook.com
Subject: RE: [v2] tty: rfcomm: prefer struct_size over open coded arithmetic
In-Reply-To: <AS8PR02MB7237262C62B054FABD7229168BE12@AS8PR02MB7237.eurprd02.prod.outlook.com>
References: <AS8PR02MB7237262C62B054FABD7229168BE12@AS8PR02MB7237.eurprd02.prod.outlook.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3755922231331868382==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=852638

---Test result---

Test Summary:
CheckPatch                    PASS      0.83 seconds
GitLint                       FAIL      0.47 seconds
SubjectPrefix                 FAIL      0.31 seconds
BuildKernel                   PASS      29.53 seconds
CheckAllWarning               PASS      32.27 seconds
CheckSparse                   PASS      38.11 seconds
CheckSmatch                   FAIL      35.80 seconds
BuildKernel32                 PASS      28.62 seconds
TestRunnerSetup               PASS      517.15 seconds
TestRunner_l2cap-tester       PASS      18.47 seconds
TestRunner_iso-tester         FAIL      31.31 seconds
TestRunner_bnep-tester        PASS      4.69 seconds
TestRunner_mgmt-tester        PASS      111.49 seconds
TestRunner_rfcomm-tester      PASS      7.21 seconds
TestRunner_sco-tester         PASS      15.40 seconds
TestRunner_ioctl-tester       PASS      7.58 seconds
TestRunner_mesh-tester        PASS      5.75 seconds
TestRunner_smp-tester         PASS      6.70 seconds
TestRunner_userchan-tester    PASS      4.87 seconds
IncrementalBuild              PASS      27.48 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] tty: rfcomm: prefer struct_size over open coded arithmetic

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
10: B3 Line contains hard tab characters (\t): "	[...]"
11: B3 Line contains hard tab characters (\t): "	struct   rfcomm_dev_info dev_info[];"
37: B1 Line exceeds max length (117>80): "Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]"
47: B1 Line exceeds max length (125>80): "v1 -> https://lore.kernel.org/linux-hardening/AS8PR02MB723725E0069F7AE8F64E876E8B142@AS8PR02MB7237.eurprd02.prod.outlook.com/"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
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
Total: 122, Passed: 121 (99.2%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect Suspend - Success                        Failed       4.172 seconds


---
Regards,
Linux Bluetooth


--===============3755922231331868382==--
