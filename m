Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A36131739
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Feb 2024 11:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707220677; cv=none; b=Oge0g3NVGFQEDt5wZ/6mvxMgEsXS0wWso8TWlTfgPUk9h1I2FxA7cKGcGw/qD0DrqUoHeDNuWUUdiFGScPUMKi1YI2h1KYTCHJsJScej4NwSS3kjK650VLMW2RELgcOYQjkxSb/HF1WaZwTNzdFGTNNA5EehADwkzqraAvDME7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707220677; c=relaxed/simple;
	bh=IeBXpJROfCJnurucRnvAUS6lTTt2inzVov5CMijzshc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lmInOpPo5apFIaeLJ5sZAM74zn7tn8NkRWyf5e1O8vZE+SFXCtVVxmjJubVdCtS5l6QXeuV4IMz6EudYr1Mrf5rv0X9FIA0QsXxfSv5Jn3K6kJ5+V9KsVgA1YkYrM7mRf0ikaK+0d61QMbKsOIU9sVXp1ldK0Ha4ewxH2569uz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgeAqKqm; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgeAqKqm"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d932f6ccfaso5492435ad.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Feb 2024 03:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707220675; x=1707825475; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tkwYx+DpQLNUH6nVYyU7XYAfIf8RjaI8OwVS/BN+yAo=;
        b=NgeAqKqmt606mQu8GP29LnBrkKml9qvZ7YzyqW2qXwDLXwxmL6q21OLfAbGV3slLsf
         rgQMg8iKwPRxVZmLKY59A1bmtqCax6pXNVRhquLlcmst9GZ2OXpHsNu1rGS9lYpk5KIM
         NNz2/7e+HXsSf0AYOQ7lnEl6v+m3tMmTKPblLuB7z/SuqrIX5SJBIUpEPK3UYbstJRdQ
         HU3/NkCply/VLCzdQbNnvU1I7OprtPNSpbFyfXu3GlIWAwPn2Nv9Pzi2XEc9adE/buPQ
         lDaBgIxnPak27rQxkCTustcCBFpt1gP4yMbaEwdwe0LK/XPumF86fRwZNYDUbCaDdHwQ
         /jew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707220675; x=1707825475;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tkwYx+DpQLNUH6nVYyU7XYAfIf8RjaI8OwVS/BN+yAo=;
        b=Z81mLYFJoNZoG/d4uu3jJD9BnXgLefZJRPC8JCIh22PIL7Qhehdb91DKXpH6qW0EIm
         FdxeaY+4zJSF712A8KnOVlXmi9Mo3YAgAmfevLvIeVBkG0R1ubekFNVTPoDEzpHbpWBR
         2KeEs8eVXTrrIWnM6kJULQhfNG0Ylk6UZR6BNCbDR3eNKebSW3mKUpGY7AXjTlxSKR5S
         vvhrje6yT2C3npUhy1OawEiYqsk2oCtE6f+cGM5YdFreB+wmwGA9KEnRYW/QXk0a+RZB
         b2TpWSA3OQ2DyxoYwdjjbXJkcCrPKDv1p91tHSW/5AOZ7K5VP7TP3Ct/2OpSWGSw5Qxc
         Tlnw==
X-Gm-Message-State: AOJu0YwhTpLBxTzdnSXGmS7MRv/JCnpDHqAFMUSG+TW5P3gHklFRMU//
	RIdk/GhF/x/hX4Gb21wo2OnnMkIT46UjJzxC2iLPFUCgltwElFL17PLy843b
X-Google-Smtp-Source: AGHT+IHS1GdEU9FX1gN6OZVEGgwfR7cF2ihXaYnUl5gjNyoMCdZxvnF9dheW2mXNhP3icU/EUB5qLQ==
X-Received: by 2002:a17:902:c115:b0:1d9:39b4:2012 with SMTP id 21-20020a170902c11500b001d939b42012mr1176051pli.42.1707220674915;
        Tue, 06 Feb 2024 03:57:54 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXuHTYyg8GFqX978cjABcs7a0Ja7w/EpRrkeu81vNzQJ62F8TxjO0QQDP3rzxK5H+sPL8IkLYOJ1qEaNdiXtA==
Received: from [172.17.0.2] ([20.172.28.128])
        by smtp.gmail.com with ESMTPSA id e6-20020a170902744600b001d93bb0c9c8sm1677659plt.85.2024.02.06.03.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 03:57:54 -0800 (PST)
Message-ID: <65c21ec2.170a0220.9652f.4da2@mx.google.com>
Date: Tue, 06 Feb 2024 03:57:54 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6905802178570016860=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, verdre@v0yd.nl
Subject: RE: Bluetooth: Improve retrying of connection attempts
In-Reply-To: <20240206110816.74995-2-verdre@v0yd.nl>
References: <20240206110816.74995-2-verdre@v0yd.nl>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6905802178570016860==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=823530

---Test result---

Test Summary:
CheckPatch                    FAIL      2.36 seconds
GitLint                       PASS      0.45 seconds
SubjectPrefix                 PASS      0.15 seconds
BuildKernel                   PASS      27.68 seconds
CheckAllWarning               PASS      30.95 seconds
CheckSparse                   WARNING   36.26 seconds
CheckSmatch                   WARNING   98.20 seconds
BuildKernel32                 PASS      26.92 seconds
TestRunnerSetup               PASS      501.62 seconds
TestRunner_l2cap-tester       PASS      19.21 seconds
TestRunner_iso-tester         PASS      30.81 seconds
TestRunner_bnep-tester        PASS      4.82 seconds
TestRunner_mgmt-tester        FAIL      170.51 seconds
TestRunner_rfcomm-tester      PASS      7.42 seconds
TestRunner_sco-tester         PASS      17.06 seconds
TestRunner_ioctl-tester       PASS      7.70 seconds
TestRunner_mesh-tester        PASS      5.88 seconds
TestRunner_smp-tester         PASS      6.88 seconds
TestRunner_userchan-tester    PASS      5.01 seconds
IncrementalBuild              PASS      48.73 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v4,1/2] Bluetooth: hci_conn: Only do ACL connections sequentially
WARNING: 'firware' may be misspelled - perhaps 'firmware'?
#62: 
requests in the firware.
                ^^^^^^^

ERROR: Missing Signed-off-by: line(s)

total: 1 errors, 1 warnings, 0 checks, 176 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13547031.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v4,2/2] Bluetooth: Remove pending ACL connection attempts
ERROR: Missing Signed-off-by: line(s)

total: 1 errors, 0 warnings, 0 checks, 87 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13547032.patch has style problems, please review.

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
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 497, Passed: 479 (96.4%), Failed: 11, Not Run: 7

Failed Test Cases
Read Ext Controller Info 1                           Failed       0.052 seconds
Read Ext Controller Info 2                           Failed       0.060 seconds
Read Ext Controller Info 3                           Failed       0.054 seconds
Read Ext Controller Info 4                           Failed       0.057 seconds
Read Ext Controller Info 5                           Failed       0.064 seconds
LL Privacy - Add Device 4 (2 Devices to AL)          Failed       0.111 seconds
LL Privacy - Add Device 5 (2 Devices to RL)          Failed       0.114 seconds
LL Privacy - Add Device 6 (RL is full)               Failed       0.143 seconds
LL Privacy - Add Device 7 (AL is full)               Failed       0.151 seconds
LL Privacy - Remove Device 1 (Remove from AL)        Timed out    2.023 seconds
LL Privacy - Remove Device 4 (Disable Adv)           Timed out    2.687 seconds


---
Regards,
Linux Bluetooth


--===============6905802178570016860==--
