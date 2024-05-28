Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA82BEED6
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 May 2024 03:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716865489; cv=none; b=tUxhewRiQn18WTVZBTEbDKwk5f+3ZBAH6f27eAGIwlRY4ikpjElk1dFkKLpgZrlx9DAvd/pPPf3PtXldRZz5g5waAbxHnXbitpcUxqjZH+dRn4X/M/NypSxhm2VFnTds2Nrac7R+FRwIrwZggEF1FbWVyiRAhRy7XZI5iYF8ugQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716865489; c=relaxed/simple;
	bh=oo5ErvbZLtCzb36j2WmivnwMC2qItRLN8Lf4KycxmKc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CigAa9eqy6J8oU7buhnsKAHnCOD5s3mUd8vPxiywZecuUR59VczC2WPYHSAaDiZ53/DHlqgp7K9QOqNOQCnz9Offz8wP5D4gIMcMG30DRld6+UwyDVoBBEPuNTqWnV3bBzXxUW6d87wjUNNVtzi4PS1t2Zh1e6cbJesBuvV7BQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUTBNsh9; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUTBNsh9"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f47728fa4cso2440425ad.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 May 2024 20:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716865487; x=1717470287; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T0wu7PuVSK3taz38lWD04FduouFm5fRzBmkdoRgNc3c=;
        b=XUTBNsh9z6GL4QEYoji/cMXI1BxGIIvYNq4xxx8ST6UrxpYXD5+AGSSGRwMvnabfh/
         ZFElQ7UE1zSBEEojg/rdECvRI6t47CYi2Fko2vUsTkkPibZ9oLmCXXpObXMjNy53RBH8
         5Z69pNPWjysZ140PBjAP/Wt9wMUq7UoYDecdM4MRiLrOpRqMz9qidJPM6qmZPmxKUh2R
         pqi3s1hQ98AwlTOmDsarCJJlp0exDXHgnURhM64/2KuMJwX6ptu/Qs+sx49MpgVl7W0x
         n6UhuAe9/B6pmJcDuRz3gqr1+EuoeXnUY/VFtnG4MZSmlYzyKdUJ+jurF38L5VPFixUA
         QDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716865487; x=1717470287;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T0wu7PuVSK3taz38lWD04FduouFm5fRzBmkdoRgNc3c=;
        b=e/DmmOIIH5N7Brt0q/WfqXFDGfhVAtPrBI1CtM5wx/yNk6UzVXhiyWlY4ho4TbvZ2A
         zObv5ZyvepolK6xS2vL7x8Xo1v76ZQKfG/TwKxNxvktogs7TDgkmeXL8krqXohaqnjwR
         /pE2sXm4aVK/7gZS+nRAVi8IyTG73BDTKJpr3ItnfKtqnXs3xgNCrhLI5J2ERVBSjg1M
         tjL4ovM4fGYRFX+lC1jdS2pZncTrJ/8LXQT7b6KgGJ/yibZPGVsBwHVATpcV0+4ZOlbN
         06aFpRf3jTdilbc9W+AM7T5uplAnDES2tFQjEQJQZ4TcAS8E1doX9HMQzCfxZ+eBrRXW
         2hsA==
X-Gm-Message-State: AOJu0YxEbAGxZiOtJMmzVdnEqoVXN43b3pTbty9mmTfyjwdmg7xkBBMR
	bsdoTDOMCw/NJcvQPGZUS52Lfg9x7ofBxcZCgIAARgmEOm3sKSKfeB6dAg==
X-Google-Smtp-Source: AGHT+IHlFln/Yl1jXglTW9Q9zCr7cgzObqSI0P/DIDrxhu7X0aK5Ge3Ypz4BdLDGSfg9IPU+4OIxQA==
X-Received: by 2002:a17:902:f682:b0:1f4:5a89:39a4 with SMTP id d9443c01a7336-1f45a893e7cmr106663215ad.21.1716865486824;
        Mon, 27 May 2024 20:04:46 -0700 (PDT)
Received: from [172.17.0.2] ([13.91.68.175])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9683besm68345375ad.138.2024.05.27.20.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 20:04:46 -0700 (PDT)
Message-ID: <665549ce.170a0220.a4e51.1644@mx.google.com>
Date: Mon, 27 May 2024 20:04:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4163811627371675144=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jiangyunshui@kylinos.cn
Subject: RE: [-v3] Bluetooth: 6lowpan: use DEV_STAT_INC() to avoid races
In-Reply-To: <20240528022613.1974961-1-jiangyunshui@kylinos.cn>
References: <20240528022613.1974961-1-jiangyunshui@kylinos.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4163811627371675144==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=856341

---Test result---

Test Summary:
CheckPatch                    PASS      0.46 seconds
GitLint                       PASS      0.19 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      29.45 seconds
CheckAllWarning               PASS      32.52 seconds
CheckSparse                   PASS      37.78 seconds
CheckSmatch                   FAIL      34.80 seconds
BuildKernel32                 PASS      28.65 seconds
TestRunnerSetup               PASS      521.62 seconds
TestRunner_l2cap-tester       PASS      18.17 seconds
TestRunner_iso-tester         PASS      32.60 seconds
TestRunner_bnep-tester        PASS      4.81 seconds
TestRunner_mgmt-tester        PASS      112.67 seconds
TestRunner_rfcomm-tester      PASS      7.35 seconds
TestRunner_sco-tester         PASS      14.94 seconds
TestRunner_ioctl-tester       PASS      7.78 seconds
TestRunner_mesh-tester        PASS      6.81 seconds
TestRunner_smp-tester         PASS      6.93 seconds
TestRunner_userchan-tester    PASS      4.99 seconds
IncrementalBuild              PASS      27.66 seconds

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


--===============4163811627371675144==--
