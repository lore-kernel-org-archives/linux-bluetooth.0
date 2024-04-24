Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E57B1E493
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 14:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713969182; cv=none; b=dfC652xmKZXbbv1aXv9U6SfuBa26P9oTuxAR61Nxr/46paiH+Rg6ao8CZiuxb/shDyz/d9uDzaDTAyyGMnPIzEsn4uX9wN1f13+6HiotQF7VZ4tTKr3h4/OWGCNRfOOX0LciuYGhnN+b9WOKXl6cZXQlcRbX3Wxt6IB1onrZe6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713969182; c=relaxed/simple;
	bh=U2kT5VTI/CCphUu5Q/i4UcOv9wN58UdRP30ogyV5Ra0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=aR/1+SInrSGjC3e3Nlf96uwPPbFtNhc7sBsBniVUNhHN48/RGZXnwIP2TWyJkX91lqu8EGkMz14CQ5+30ChTCHfcwsesJW30VulW6HIFiPdxqZSIRbA7ezSyDfzmgUTVKdnVya+k5X3Q7xcyvd0yNqU9nAETluFQzpX6jR67i4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/sQEIVU; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/sQEIVU"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e83a2a4f2cso40106485ad.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 07:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713969180; x=1714573980; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xmiOUMfwq1HHKl0c1wAzFI5+Vv2IBvlCbnFbMDQ7vVw=;
        b=O/sQEIVU5HPBZI0/P3EPGlHtIHG2EpyBCtFdXbJFZ8ZEIki5QrVbcweI/Yb4fHppTw
         Elf8X0A0OnfdMmYpy1U0j1Md7GkfUCIClVRlHvppFCcmSEghooxoTLKdisWdh+UB7ejZ
         DIBRO9UcV/uvjVSF9xV9QUJG1j01N4U6DJta+cYq2DBU2sUZKwX6G+29PXprvuxflahP
         UnxMtBaAZ/paJJGjTetm5xxVbJyqIZsx86Zpn2Hl7k2xRWHCslc4U1jUze12rfMrw79C
         acCe5nZen5JBRcc7WLk/g87Fv5lzXf5NXKz2VA4jZRGhCUY6AXxoI+l4FQFi1tUEgcIy
         5nHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713969180; x=1714573980;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xmiOUMfwq1HHKl0c1wAzFI5+Vv2IBvlCbnFbMDQ7vVw=;
        b=d4wBNQa9Eum8+R2bs+j006V5kWJmdKIbkQtA14lQ5b2Ad4WGGibcqvK9ljTQ2fH3Sv
         o1SnkvSIOFiF16P06v+t7sd+VyqDw0hIKQWMz8hQgOPSPfOny5IDGXGevpxESwjd49tH
         xkzyafea7MedJRGgskk//vRAkm20u91T0DeW+ko8nNKbISuBF6Nc3KdVy8EBnw7CndVR
         6VxYepcAXZohBhciER/PX++9q4A9LE8V29J25MiENsINKMVTguSvAZiwhzdV3UcwgO7U
         AeNMXn28ZM+/VWbcFz6RPbw04ScxK/VUFHX0baSHpYKyGPWqQXvDXRfbkrChUDH/SZx7
         l5Lg==
X-Gm-Message-State: AOJu0YzQ7qp9A2xD4r6fM7Davk6c2fBneo/sp4VMJ4I34oh4scbaos9W
	9XEGhM0qaAznNn3DcOjggdnJyi9UXuJqKw2FYXf/FKGPzZvkgNEPqFngyA==
X-Google-Smtp-Source: AGHT+IGf517DtZlogK8oqXs0I0FsmGedVmb8Z4Q78iqg4UeHkOEG4fJNn8jD/gyIUnqkmPnCIjtRQQ==
X-Received: by 2002:a17:90b:23cf:b0:2af:4e61:23e5 with SMTP id md15-20020a17090b23cf00b002af4e6123e5mr1608320pjb.26.1713969180369;
        Wed, 24 Apr 2024 07:33:00 -0700 (PDT)
Received: from [172.17.0.2] ([52.157.14.174])
        by smtp.gmail.com with ESMTPSA id fu4-20020a17090ad18400b002acfe00c742sm7773692pjb.21.2024.04.24.07.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 07:33:00 -0700 (PDT)
Message-ID: <6629181c.170a0220.7e563.9b8e@mx.google.com>
Date: Wed, 24 Apr 2024 07:33:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6244989426316973866=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, joeyli.kernel@gmail.com
Subject: RE: Bluetooth: hci_sync: Using hci_cmd_sync_submit when removing Adv Monitor
In-Reply-To: <20240424135903.24169-1-jlee@suse.com>
References: <20240424135903.24169-1-jlee@suse.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6244989426316973866==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=847477

---Test result---

Test Summary:
CheckPatch                    FAIL      0.90 seconds
GitLint                       PASS      0.20 seconds
SubjectPrefix                 PASS      0.05 seconds
BuildKernel                   PASS      32.20 seconds
CheckAllWarning               PASS      37.80 seconds
CheckSparse                   PASS      40.29 seconds
CheckSmatch                   FAIL      36.63 seconds
BuildKernel32                 PASS      30.35 seconds
TestRunnerSetup               PASS      528.17 seconds
TestRunner_l2cap-tester       PASS      18.40 seconds
TestRunner_iso-tester         FAIL      31.30 seconds
TestRunner_bnep-tester        PASS      4.63 seconds
TestRunner_mgmt-tester        PASS      108.20 seconds
TestRunner_rfcomm-tester      PASS      7.22 seconds
TestRunner_sco-tester         PASS      14.93 seconds
TestRunner_ioctl-tester       PASS      7.56 seconds
TestRunner_mesh-tester        PASS      5.66 seconds
TestRunner_smp-tester         PASS      6.62 seconds
TestRunner_userchan-tester    PASS      4.86 seconds
IncrementalBuild              PASS      27.45 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: hci_sync: Using hci_cmd_sync_submit when removing Adv Monitor
WARNING: 'deamon' may be misspelled - perhaps 'daemon'?
#106: 
Normally this situation is happened when the bluetoothd deamon
                                                        ^^^^^^

WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")' - ie: 'Fixes:  ("Bluetooth: hci_sync: Only allow hci_cmd_sync_queue if running")'
#116: 
Fixes: d883a4669a1de ("Bluetooth: hci_sync: Only allow hci_cmd_sync_queue if running")

CHECK: Alignment should match open parenthesis
#136: FILE: net/bluetooth/mgmt.c:5479:
+	err = hci_cmd_sync_submit(hdev, mgmt_remove_adv_monitor_sync, cmd,
 				 mgmt_remove_adv_monitor_complete);

total: 0 errors, 2 warnings, 1 checks, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13641928.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


Use of uninitialized value $cid in concatenation (.) or string at /github/workspace/src/src/scripts/checkpatch.pl line 3229.
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
Total: 122, Passed: 121 (99.2%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect2 Suspend - Success                       Failed       4.232 seconds


---
Regards,
Linux Bluetooth


--===============6244989426316973866==--
