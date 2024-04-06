Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BD92E64C
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Apr 2024 14:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712413792; cv=none; b=eR3gtMhwpGv5dpcnjAowHj9WNgNEiA0kZJt/BHMTM85MugZXgmTNxRh8TJofPGPCKn5lzn72oHL9UStV8sbALvUZgx0RT6isOmGwzKjv8sIhkuTxyvpZqVI3t0Kntn3Ea8j37bWxMyN+t+ljXJ1P9uq2r0PONCbyNPjrSCIAn0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712413792; c=relaxed/simple;
	bh=9T45qVFrKce0MSRJRyKsQbJuZcK33Dmysmi2tBmg3WI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mGsO9atNzaUpFa3cDUqdNuUGb5uTRxiCNUR4EV+zeUlcQqfeGBuQTQinJFUSowDDHa48JN0n9C2lD31HPrbTp0pSotaEaiIenA6y/oY9uTNCSTjNjkIjsEnND1foKMdeAYm7EZqTsDpTHI1fbkUIr/EX/52odJ/PcFtFVqgxo7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8dnpOB2; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8dnpOB2"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e0f0398553so28800505ad.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 06 Apr 2024 07:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712413790; x=1713018590; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NcC0vTgfCPrhso281KySqzSyRrNbnlE0sdP6q02/g3s=;
        b=g8dnpOB2iNsjvZiRRmeJSW7TcpgqeSOG+9TbrZK0yRjW1HDsKcVGnJAYPm2RxgNFX/
         h5Z3gYzeEqY5Ai+IDV7T31CD3L6/A4dUS8GEJsKKtpuM1i2MDp8lcfqQ1bsQp8rtFJ3V
         8GRN3LFST7KQXnu4Ds8zO9FQrXdZXbBlF6YX5s4tj2QLf6O9V7goTWlWUNe6po598DJv
         jvOeCoczXQC9pmYN9EBHWRhryPi8byM2a1ZYCl5l6rG/frtYWf4XUqWXQp33Awbpeks3
         byKGTy/+BZHzLU7qd+jUzf4K6CdCDtsI020BcbqMLzWuIn7Gw+w+/3OCE2e9LkD4rFen
         T8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712413790; x=1713018590;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NcC0vTgfCPrhso281KySqzSyRrNbnlE0sdP6q02/g3s=;
        b=XRAnWmU7Z3O26Dq/pMbPZY40ILs5c+6JoRiCUcq/Q4Z8FiqV/wlZqmiv1ly+9qmGKd
         DaJco6ZkQZH8i+tjPGqz5DSR0cQhSfONIIsgX9uy5pC3wTTJrBaA3sYlDVHC++Lb7Zn7
         FXI31Ofm8eQHJf+tyqY5xRexV8eE55sURyob+if45XCQAMJWdYl0F+Iz6r6zI8exKfGa
         oDAx3RX09d5PBZjthTauRvZiMJHdZXuReU6jxeMNYydfraubNyiruL9CoY/dT7WJHXLh
         5J5VGfV8zVp4TJYlbHjg/j28VKU4EoJA6MZNmFmSbQTTE1pjEOvRHIho+zuzPiLYu3U2
         vMrA==
X-Gm-Message-State: AOJu0Yy35Zczrv0b4ewKlxNKSSTChitTg44Cw4kKQ1NkE9nG/JjFSwf6
	cFaWnmxUeeH2D1fcfI1ouw8stVLwxJt8bUqjdP9ez5s7a04OCFjjKRdc47xC
X-Google-Smtp-Source: AGHT+IEucRtaB6WIZsymzHrHm/riyI7aLDg+grCGJTP98NijeL7ejOwk1bQdFYEO8cHh9vyOe1rZvQ==
X-Received: by 2002:a17:902:e5ca:b0:1e3:cb7f:11a3 with SMTP id u10-20020a170902e5ca00b001e3cb7f11a3mr4172131plf.50.1712413789685;
        Sat, 06 Apr 2024 07:29:49 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.5.208])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001dbb6fef41fsm3474028plh.257.2024.04.06.07.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 07:29:49 -0700 (PDT)
Message-ID: <66115c5d.170a0220.54838.a593@mx.google.com>
Date: Sat, 06 Apr 2024 07:29:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9054352392430053202=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hdegoede@redhat.com
Subject: RE: [resend] Bluetooth: hci_bcm: Limit bcm43455 baudrate to 2000000
In-Reply-To: <20240406135106.16821-1-hdegoede@redhat.com>
References: <20240406135106.16821-1-hdegoede@redhat.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9054352392430053202==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=842037

---Test result---

Test Summary:
CheckPatch                    PASS      4.80 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      29.60 seconds
CheckAllWarning               PASS      32.93 seconds
CheckSparse                   PASS      37.98 seconds
CheckSmatch                   FAIL      34.61 seconds
BuildKernel32                 PASS      29.01 seconds
TestRunnerSetup               PASS      516.94 seconds
TestRunner_l2cap-tester       PASS      18.28 seconds
TestRunner_iso-tester         PASS      28.37 seconds
TestRunner_bnep-tester        PASS      4.62 seconds
TestRunner_mgmt-tester        PASS      108.48 seconds
TestRunner_rfcomm-tester      PASS      7.21 seconds
TestRunner_sco-tester         PASS      14.88 seconds
TestRunner_ioctl-tester       PASS      7.63 seconds
TestRunner_mesh-tester        PASS      5.74 seconds
TestRunner_smp-tester         PASS      6.69 seconds
TestRunner_userchan-tester    PASS      4.80 seconds
IncrementalBuild              PASS      27.70 seconds

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


--===============9054352392430053202==--
