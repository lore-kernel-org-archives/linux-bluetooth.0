Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28B7DF6C
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Apr 2024 15:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712848017; cv=none; b=Le2WsQ+TZe5Ez6YdeS+sr6Gm0mbKVPHn9fnb1pMKqhc7JT3RkCp5oONU05ha+UlSmHe8rRhJZCHmXmPxPV4Qe5BvlfWSZByVTl+lARxlKj9K2uEZB9NmlSNXrXvJTaZ5aYYmdJCGOWy8PvcjuvpqUO8ZZJgNB8+Gr3iSv/6vKOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712848017; c=relaxed/simple;
	bh=xAA+IkqN8aMV+SpeRLmMWmELCN/ADIT20HJOrX9FTtM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UsEkapnM11kZyuJMWQjuavpZ7NOrBSbUDsVarmIClab0vdZsRu9fACeTyh9GY98F2iiWuB0/PrxeY/SXxDngWKWv2FoppKRpOjSaibwKKoMI/YBHKkCWEw9E1XRcA0dZNIItllx5rg1LO8EnmhkYLU6JXp+zKp1yn4YSX2Pd52k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfrvNKN1; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfrvNKN1"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ed112c64beso4286678b3a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Apr 2024 08:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712848016; x=1713452816; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/3x9k5GA23wqDIdFgP2zUtyfP9y4DEqYI8IXOo/DtOY=;
        b=LfrvNKN1Ghl0zBf0GgH7Tluw/CWhVGvrAYGFQ3M0ZvW5rdzee+dDXGGcU2bbLICUVn
         ALh8yayFgqgRF8JLDfXLd3MHEegMiJrJFZwXs/9+cUC4zw9x3kniRFwH57qwaiu0t52Z
         K5poNmwjJ4YaXSGlIaMYUrNktzZ1OLSsVai0yNDzVYMV8e93sv6O9qcerS/gENtTNcIh
         3/Vlz6jvV9hbVMLzARaRlHMWu1L+49GXPuXZsrgtyUbgn9NZ3ceI320ptZ+7RS1rpLhJ
         mcEim2nNU512yAh4sb/R+w5khfxrZikAwnCrmhohSbuT1ddBDe+Dghhg60zRX5tey1Kc
         WoQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712848016; x=1713452816;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/3x9k5GA23wqDIdFgP2zUtyfP9y4DEqYI8IXOo/DtOY=;
        b=pZl3A58m+MmEORVSuvdu757SYWVBWYajP5FS+b8E3J800w67lWzUONyMdv8XUGbXfV
         W5+a6+YPI0TUETeWBy0zgHaOQ9wL1vHIxgLJmcIGJg7EfX1kzjjowOLDf/jc+zCmyAqY
         nQxpBhAdw4vK+UOG6tskFDGgcJvXNOTKdUegoZ4olcQg1xSl3gIzz3zaLuBx2JQ/SHDp
         232HlS469I5RC2y8GHO7+8YLgp9t4Sa31eurjzBjTbVXdTESk0VrPtmqMKp4UC0GDY04
         V0GUGBfdcAcXYMNnIK0sMllQH0WzE2Legwvs/iv2+RTKfvB8nPOsSTTRMAilcl8wN489
         JqQQ==
X-Gm-Message-State: AOJu0YwheRct5F/H/5IBTn2M0fArc7ons8p8k/JQEpngy20ZP9MR43XR
	zvyopnyxaNGCZM7G2KVbLdkACH0MjzuVYB529XaRBXq7nUTOoskVMhuylg==
X-Google-Smtp-Source: AGHT+IGtKhZG92yHUaNJhZ+K+ZMJchyaXOZNEeAgAtSVcEMmmfJkCq5GoiSHG1A3Pi3FLJhmR0nlwg==
X-Received: by 2002:a05:6a20:1044:b0:1a7:a412:c881 with SMTP id gt4-20020a056a20104400b001a7a412c881mr66397pzc.30.1712848015657;
        Thu, 11 Apr 2024 08:06:55 -0700 (PDT)
Received: from [172.17.0.2] ([52.238.24.176])
        by smtp.gmail.com with ESMTPSA id u18-20020a632352000000b005cfb6e7b0c7sm1199247pgm.39.2024.04.11.08.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:06:55 -0700 (PDT)
Message-ID: <6617fc8f.630a0220.6d858.3330@mx.google.com>
Date: Thu, 11 Apr 2024 08:06:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2066525851052256688=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3,1/2] Bluetooth: hci_sync: Add EXPORT_SYMBOL to hci_reset_sync
In-Reply-To: <20240411144214.109478-1-luiz.dentz@gmail.com>
References: <20240411144214.109478-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2066525851052256688==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=843648

---Test result---

Test Summary:
CheckPatch                    PASS      1.01 seconds
GitLint                       PASS      0.58 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      30.69 seconds
CheckAllWarning               PASS      32.86 seconds
CheckSparse                   PASS      38.69 seconds
CheckSmatch                   FAIL      35.00 seconds
BuildKernel32                 PASS      28.81 seconds
TestRunnerSetup               PASS      518.19 seconds
TestRunner_l2cap-tester       PASS      18.29 seconds
TestRunner_iso-tester         PASS      30.92 seconds
TestRunner_bnep-tester        PASS      4.67 seconds
TestRunner_mgmt-tester        PASS      110.54 seconds
TestRunner_rfcomm-tester      PASS      7.22 seconds
TestRunner_sco-tester         PASS      14.90 seconds
TestRunner_ioctl-tester       PASS      7.60 seconds
TestRunner_mesh-tester        PASS      5.77 seconds
TestRunner_smp-tester         PASS      6.72 seconds
TestRunner_userchan-tester    PASS      4.78 seconds
IncrementalBuild              PASS      32.82 seconds

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


---
Regards,
Linux Bluetooth


--===============2066525851052256688==--
