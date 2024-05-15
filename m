Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3340238FA6
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 May 2024 18:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715799558; cv=none; b=HBZ7ogf+Iczpn1L5PnBTtKcwg2idD1lQ64G7/agDbwpGzP0CLvyZaeNHpUW1LoF76wI+Vn9iK1ZfSbxRFyCA418P2sp6ncZEwFU/Ds0xT6i83v3lbiCfvEggY0rFHFDQR9oPJD1h0sWtj43I289eCkSAUpY2b9L9JZrVGBVHm1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715799558; c=relaxed/simple;
	bh=ZAyMd331l81ydV2LHGYeWruOKeH94Wq+6eYmH5+2O7M=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mCYMeePTD3u4hNSZCeVAO9g6rMDtcd9n2mG8IozNh0ThscJxadgcAkvqVfGuC1X8vDLHx1sbg8QvTqWbe/qcmhFboHY6LhCz6Xnr7e12DQVXwAe1zD300u5jJkRpvB3NDWgyA65lqz/PGyAanDir5uiL62rKAKzq7dHBPqbu85Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCiHJnh4; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCiHJnh4"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1ee42b97b32so59769745ad.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 May 2024 11:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715799556; x=1716404356; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TmoTLTQxMrMM+qKQoSKfFKtQ4Lja2Hcl3lvBTYwC4QQ=;
        b=LCiHJnh4ZvvAkQaPqXsbSlgH6A1p6qQESUBo0xNwNr0oHGephjWEsCLZqkt02fXdpj
         LMbamXNvbE2vts/0p9ohPUHf0Yh7FzYda6qYIQHiNNMSBguMhoSei3bv8C2yz2Uj3kxJ
         AIVjdHw802eVACOktX9OlNVhyrn+hcCJsMyDeYSydT3KOO/rwAmHUULhreb/iGslkTdy
         yBMbsSe1Mfd8uppeP+ruu65uPnGCiKHHsmTGYJObtkR8bbfQOuP3piCj+IRfOc7G7dzf
         eNLeGfD9t8XaJKTxMBhhW1wDxBgM9Y87eHLMeeeqMmiJWL/zYRkgMb6UPPsbhFYhAaVl
         SFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715799556; x=1716404356;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TmoTLTQxMrMM+qKQoSKfFKtQ4Lja2Hcl3lvBTYwC4QQ=;
        b=lEEQ4v0iBaxRpzsm1+bt+QTYuJmEextspUbQhwXXxNzOZ/HziCB1Yc/8QKDpbqZPnl
         YKWlJgdU5aXIFKY9nIuubBfV5J6fv4Hl4J2gf5/1xCBd5rewaZ1Dw6weNQRBzNn6dzCr
         eRtxe8rzJHyop3hWstL1AoTitTU/mGGn8/WwIxxDXashWr8/+DngrDmz2XByT8RPgFUZ
         dagY64fhxWcFbGphHkRPv8kpNbOKw4lTT1zg8tDyAa1bU7jAX1YsIwarhRzn1Erk1isU
         6UZ4fTGArBhPeHnzuY5fygyT2qQW5P4L+of7SgUhFiNusOGZUr627R8A3hPcfqWXbiOy
         VqzQ==
X-Gm-Message-State: AOJu0Yxb4B09rmCBTZJvvRNkhy8BBCmdcuUnRo7mKwSH7LbpZtvzfHGR
	Rl6+cVo2oEg98/3rGl5vmlJr+dNqcwAv1yiOtAH/Ji1ydFzDnBauQlWR2g==
X-Google-Smtp-Source: AGHT+IEkJxG+Ge/+0B/Y9BN9l6vzx3AC/+Dd2chbBZAJMmpkfaiAnUBazh5+Jyby3dX/L5/KQACgRA==
X-Received: by 2002:a17:903:11c4:b0:1e4:9c2f:d343 with SMTP id d9443c01a7336-1ef43c0fd9dmr193139165ad.7.1715799556205;
        Wed, 15 May 2024 11:59:16 -0700 (PDT)
Received: from [172.17.0.2] ([52.238.28.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d1734sm121362035ad.29.2024.05.15.11.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 11:59:15 -0700 (PDT)
Message-ID: <66450603.170a0220.b02d.f679@mx.google.com>
Date: Wed, 15 May 2024 11:59:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7024756818947665427=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, devnull+sven.svenpeter.dev@kernel.org
Subject: RE: Bluetooth: hci_bcm4377 fixes
In-Reply-To: <20240515-btfix-msgid-v2-1-bb06b9ecb6d1@svenpeter.dev>
References: <20240515-btfix-msgid-v2-1-bb06b9ecb6d1@svenpeter.dev>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7024756818947665427==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=853487

---Test result---

Test Summary:
CheckPatch                    PASS      1.37 seconds
GitLint                       PASS      0.56 seconds
SubjectPrefix                 PASS      0.16 seconds
BuildKernel                   PASS      30.43 seconds
CheckAllWarning               PASS      32.81 seconds
CheckSparse                   PASS      39.27 seconds
CheckSmatch                   FAIL      37.98 seconds
BuildKernel32                 PASS      29.23 seconds
TestRunnerSetup               PASS      530.30 seconds
TestRunner_l2cap-tester       PASS      20.59 seconds
TestRunner_iso-tester         PASS      28.30 seconds
TestRunner_bnep-tester        PASS      4.66 seconds
TestRunner_mgmt-tester        FAIL      111.38 seconds
TestRunner_rfcomm-tester      PASS      7.42 seconds
TestRunner_sco-tester         PASS      14.99 seconds
TestRunner_ioctl-tester       PASS      7.81 seconds
TestRunner_mesh-tester        PASS      6.05 seconds
TestRunner_smp-tester         PASS      6.95 seconds
TestRunner_userchan-tester    PASS      5.05 seconds
IncrementalBuild              PASS      39.84 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 488 (99.2%), Failed: 2, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 6 (RL is full)               Failed       0.197 seconds
LL Privacy - Remove Device 4 (Disable Adv)           Timed out    2.571 seconds


---
Regards,
Linux Bluetooth


--===============7024756818947665427==--
