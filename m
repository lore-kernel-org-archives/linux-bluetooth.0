Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAFC2BAE2
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 23:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713398238; cv=none; b=CssPkAKT1c7UX4kW2IcPZiqF0/k1iApLBKd7MLZSDfnCUHimLjMHUYFTR1ATM7Ndr4dkAp2fAFAAzsp3t1mPDRf0u50M3/FEUehqIwSPibMrhJHoNelPcnZhcwU0+/7IsaybQFHrJtRmzC2/OHANjoJiCEEXbTKfN94e6w/qg0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713398238; c=relaxed/simple;
	bh=Fv36H1EpYObsK2eVwJ9xxdBBmQUELhvQoEA96lzsybo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Y8MGPwA7IlFIblpLo+eWutOH3+/KMA25LKO0GoFlCA2svmX9dpMZcXLdZGAifSC2j+fmGhdnLrJUvM0WRha62HTCOyZd7GgM+JvuyyDUcuatTA7PflszMCanX4VcEcJyur4gb3Mdwm37R2VR3MRwQJ8ubPyfcIc2yAjPydyZr8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcZ9Wmot; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcZ9Wmot"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-de466c641aaso85363276.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 16:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713398235; x=1714003035; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OYeoUEVDE2BZo76XHmTiTQtL705R6jLoFVLPk1Xz37I=;
        b=AcZ9WmotzZe7y10wR+p74qd3hnnnGWpEGPaU31h5k4NNh5jNpj1WTeRJteIxtIUNEJ
         Qn9L5XTseYgy2gbMfjXxco1d7twiX13X+UDOv4fblJItDZKfMmb8L7U6T1BASFJQfFwH
         oQI6jUADSMJuKBrw2oPcw8uxqe6ArFQNpvOCqL+j8daju3Z17Gn5d3StZrm2efUrTeOw
         RODV2qC5L2kTgs7MOxRsgYqFLHIF6XeQkt49IZFRf8UXKRfT2dOMkM2Ccs04f04WQRg3
         1dRSTvh5muG6JWKWXhNx0CXDc+nSgPZSbecAobcaDl6CgLIpCur9f5FH4XluqEPFFneS
         Rgtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713398235; x=1714003035;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OYeoUEVDE2BZo76XHmTiTQtL705R6jLoFVLPk1Xz37I=;
        b=XmVf9z4IDnyj4RWj4wAbS/7YslBNh0yxEslyspWvfcBPhtHLGTo/jlsHVM+fFWAMlW
         +EkJHxnRDaluEz9blztwhBNXWpi03NZt825GtIHVu0gvKcEO8kOa4IffrVgOaTCTHQL+
         g4UmQehFDPoBcFp0bqxoYi3bGCaY5zouyPmw6bqZIXUq2kSqPK7aZpU8WFw0BwFuRbyJ
         VfPxH0+0+x1sSLbR3RgfETQjcXR9K+jFZauli7CtgEnUqZ9478amvT+85vAL3XLE4jEe
         HZYiUOlS0W49X87Mu3Tv1elvsL4Gu6MUIvFTAALr1Y/4ZRJ2kQADGBiBsZRKjwXi4zLy
         BrzQ==
X-Gm-Message-State: AOJu0YzOxMoBkv36k4/s/o5JaoQLAIGi85qQLVgYmn+jh/94GpfADBIP
	kC2k/ABiFB6owH5R6XypTFhw0u4e6TKbw8YEEdXeH9tNMJrAHMvaqEcTSg==
X-Google-Smtp-Source: AGHT+IHXYvNu7PASaEqAXbu2K2vFuUGFnwW0czXvoVJa+Mt3UES9QltgiymVfl4NzBgMcFmLMOrBew==
X-Received: by 2002:a25:9187:0:b0:dd1:37ff:696 with SMTP id w7-20020a259187000000b00dd137ff0696mr930394ybl.59.1713398235510;
        Wed, 17 Apr 2024 16:57:15 -0700 (PDT)
Received: from [172.17.0.2] ([40.79.247.227])
        by smtp.gmail.com with ESMTPSA id z15-20020a0cf00f000000b0069942e76d99sm130415qvk.48.2024.04.17.16.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 16:57:15 -0700 (PDT)
Message-ID: <662061db.0c0a0220.49386.0ba4@mx.google.com>
Date: Wed, 17 Apr 2024 16:57:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8615021766967909544=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sean.wang@kernel.org
Subject: RE: [RESEND] Bluetooth: btusb: medaitek: fix double free of skb in coredump
In-Reply-To: <da0859c4b24d314d9ff38179c26a58ee7e3f16d6.1713395895.git.sean.wang@kernel.org>
References: <da0859c4b24d314d9ff38179c26a58ee7e3f16d6.1713395895.git.sean.wang@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8615021766967909544==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=845618

---Test result---

Test Summary:
CheckPatch                    PASS      0.64 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      29.93 seconds
CheckAllWarning               PASS      32.68 seconds
CheckSparse                   PASS      37.67 seconds
CheckSmatch                   FAIL      35.64 seconds
BuildKernel32                 PASS      28.65 seconds
TestRunnerSetup               PASS      518.27 seconds
TestRunner_l2cap-tester       PASS      19.18 seconds
TestRunner_iso-tester         FAIL      35.29 seconds
TestRunner_bnep-tester        PASS      4.93 seconds
TestRunner_mgmt-tester        FAIL      118.55 seconds
TestRunner_rfcomm-tester      PASS      7.75 seconds
TestRunner_sco-tester         PASS      15.37 seconds
TestRunner_ioctl-tester       PASS      8.25 seconds
TestRunner_mesh-tester        PASS      6.15 seconds
TestRunner_smp-tester         PASS      7.00 seconds
TestRunner_userchan-tester    PASS      5.29 seconds
IncrementalBuild              PASS      31.42 seconds

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
Total: 122, Passed: 120 (98.4%), Failed: 2, Not Run: 0

Failed Test Cases
ISO Connect Suspend - Success                        Failed       6.212 seconds
ISO Connect2 Suspend - Success                       Failed       4.232 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 486 (98.8%), Failed: 4, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 5 (2 Devices to RL)          Failed       0.164 seconds
LL Privacy - Add Device 6 (RL is full)               Failed       0.194 seconds
LL Privacy - Add Device 7 (AL is full)               Failed       0.216 seconds
LL Privacy - Remove Device 4 (Disable Adv)           Timed out    1.877 seconds


---
Regards,
Linux Bluetooth


--===============8615021766967909544==--
