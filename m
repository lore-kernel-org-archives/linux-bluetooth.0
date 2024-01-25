Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AA13224
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 07:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706167941; cv=none; b=iFCXYuW5TIpJPTug1iLkgRIohDl0cD1Qh0/sgwOAcC2A3zUgAQ2LicSr+XXVXeKDGIpyUhSF/Y+3jNZbMmGFm75uvdlsF4Cun0ZwVuRXT78ByEJ9WvPa40AHKAbP3jhTZ+ZwP1L5DboYQf9e7DFPCAtCi09zblZKHmo4ySbNe50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706167941; c=relaxed/simple;
	bh=WPRFu633FAulrbA7yvTthY5W20/wnQ4pLFCJaUrd6R8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=M1mHlHs9j+iAVelfZu0oDpU0sXBopsRINhbwzQ5jmQLQExMZj4Jg/JmlF7mHrsFnbk920GGUPYyGjs465ncHaFCaTETc3vXzr9LdZ6u5UJ4nKk16oEPa8ACvmBCzWk8oCie5JgaAeBWWoJBYDJwRrdqca+keb8qYa1XIh1F1B7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aYrImsIo; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYrImsIo"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-42a0ba5098bso32792631cf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jan 2024 23:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706167938; x=1706772738; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6uZl6Kork7PLO+d11FeX6KEdtSLMqgaj/Un369HD7Sk=;
        b=aYrImsIozJ1LlfkJzOmE9Y/y01G4y/E2MU2DGMUHUw1MPtxLrUMI+M413EwHVJMW0r
         uIn0jyWMX0KaFUZ0EtnCjkeDv7Xq/jU2pYTFCX67eukid22GAgfuVZwgguwRMN8av5yC
         UQ0n1gEbLY5J1UoAc9OTMi8ZZRJmnYpEKxWJdFeAQyTSXKKRMFZsnX3Ye0iLMpyagv0i
         e9cvlhq9FGYjxejEFRYRT54xFob1Qg5KdwahJ5NLyPCJ+9I2uj2IwNxtgqERq57PqM34
         M+PZjv0PPxnY3cRnZZFKpLB6YP7toSvMTrXqHbHIngPNzqehvhIy37Bqm5NzuJukwHaM
         A11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706167938; x=1706772738;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6uZl6Kork7PLO+d11FeX6KEdtSLMqgaj/Un369HD7Sk=;
        b=wVskQuZAA7gsHXZcQgQ4gLIu5xUl9ukQfg3sAJ4A1ErLw8PMOrUa0DUBF5o0XKyRfR
         rrWuqCPuQ5vZ1iyXRnF8QLZYcZ3LTnRbrNQseTY2LYqeHT1gGtIrKnPc56rUeug8KUeF
         VUCIal/dlvWKRh8tgNv1C9vwbqdIwCiAS35z55+k9Gx1YPtqaidXdNG01drUXy/JPFZV
         6v4QPmVTiNsfu+Lcp8y9lxt7X45xYo5SzGMayqCUVW/mDx8zuLXOHNdB8arGbn2Zfhu3
         pVSdNYPWjekWvAnUy6HUQgMqtrcluLc0+vmGXsSmkpQbNbbVmKipc+WAvVdj8hba2re8
         aXNw==
X-Gm-Message-State: AOJu0YwYpev6Svb26/O+eGWuyGpf8P0Yp5JcWXJfw7hnfyWNCO/+4W8H
	OfxULyedXtLUI8uFqBW8O23dvvXL73dvLIbvMvTEV0TeJgYaEXk79j3vgkNU
X-Google-Smtp-Source: AGHT+IGKptQ8viRl2DDJEAvhVCSf6+TmodVMQ3h3jeUprriAdYKg1EZ+r9AW/QC9u2EH+RJVHQTQnQ==
X-Received: by 2002:ac8:5bc9:0:b0:429:c7ce:6eb3 with SMTP id b9-20020ac85bc9000000b00429c7ce6eb3mr695377qtb.113.1706167938132;
        Wed, 24 Jan 2024 23:32:18 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWRa8k+qY4o+x8c7ZfTNT2hgoq0mnUOgDtMA1RjPDURhVCiQ87po2tQ0UsG3OkrkJMKd6T4KZsAKYjcQs/iJhl34X2CbOJZIy3ImuU=
Received: from [172.17.0.2] ([20.55.213.182])
        by smtp.gmail.com with ESMTPSA id hj2-20020a05622a620200b0042a40e3ca9fsm3432560qtb.85.2024.01.24.23.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 23:32:17 -0800 (PST)
Message-ID: <65b20e81.050a0220.ddca3.2647@mx.google.com>
Date: Wed, 24 Jan 2024 23:32:17 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3803379477002697673=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kai.heng.feng@canonical.com
Subject: RE: Bluetooth: Enforce validation on max value of connection interval
In-Reply-To: <20240125065028.228877-1-kai.heng.feng@canonical.com>
References: <20240125065028.228877-1-kai.heng.feng@canonical.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3803379477002697673==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=819736

---Test result---

Test Summary:
CheckPatch                    FAIL      1.07 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      28.05 seconds
CheckAllWarning               PASS      30.91 seconds
CheckSparse                   WARNING   36.43 seconds
CheckSmatch                   WARNING   100.01 seconds
BuildKernel32                 PASS      27.22 seconds
TestRunnerSetup               PASS      435.23 seconds
TestRunner_l2cap-tester       PASS      23.18 seconds
TestRunner_iso-tester         PASS      42.96 seconds
TestRunner_bnep-tester        PASS      6.84 seconds
TestRunner_mgmt-tester        PASS      152.18 seconds
TestRunner_rfcomm-tester      PASS      10.86 seconds
TestRunner_sco-tester         PASS      14.45 seconds
TestRunner_ioctl-tester       PASS      12.15 seconds
TestRunner_mesh-tester        PASS      8.84 seconds
TestRunner_smp-tester         PASS      9.76 seconds
TestRunner_userchan-tester    PASS      7.20 seconds
IncrementalBuild              PASS      26.48 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: Enforce validation on max value of connection interval
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#82: 
[0] https://www.bluetooth.org/docman/handlers/DownloadDoc.ashx?doc_id=229869

total: 0 errors, 1 warnings, 0 checks, 24 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13530147.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


---
Regards,
Linux Bluetooth


--===============3803379477002697673==--
