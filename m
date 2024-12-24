Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B144414901B
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Dec 2024 21:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735075821; cv=none; b=pLUmqLKdHE/phQJArVdUe7y/UmHaSeMWNPSHkYdmIrVF21zl51Nr5HWslFnA3NUaoic59whMKt3HmnBAJf1wPdbu8A7FVdy7Aj/lT/+/dwfWvEHuIf8jYIy/0srnwVl+t/sGFNiDrzJXTMBh2GJWg0Asvp8TmsLNahNI5Tuc1Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735075821; c=relaxed/simple;
	bh=gEuQQCLGt4ViBg4BmPncovk4k7d8mVwwdcSX/uxf0Yg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VpITFXeHMPrDSV5QK32Z6CKVLCrsTAaxqZ0yJt9vemQ23QC97dPZ6z/3kDZoKFK+QAPPWSP8IfQlzcpBLRYlvN0aKIGwkAxkaeYMzGMTj9E5Q3m43sV6pkyd5Me3SCqbqmJYc623L82X0Ufe0CcPvd5m5rkR0ofLGHdpiVj0y5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmtjRAQj; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmtjRAQj"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21683192bf9so62447385ad.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Dec 2024 13:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735075819; x=1735680619; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uK+Fl/SQPl5lBNHLc8lT9HHfRQ9k1FaZ+emYb+jRGng=;
        b=WmtjRAQjGUJXi1DGvesgw4u23nlSMzuCdAoSv+C0QTnLGhp8W/WiiChGvFsUfoMpFH
         f1LYTX9S+74EwvbQgt+YxGpflpULd4QbiMvBWpyTz7zHProEmDc1jtQCFcriNIO1GHMD
         c8e8M1KMN6jWs2GwKlPSGG1mNf9yNTpy0XdGmcEut4dl8Apolq//+gAUWONDeDU/TAO8
         UhlGNO+zvlTN68z9qvHAm+b+lizChdg5QApdb15gPVn5YJWYKxiZZ6Tlt4kiLLBUNopf
         XRK2FnlBiiCd+/yJm/KjbVTesxfrwdudT3kzYWhnyglzu6g4gf37md6l6nHNY997dsex
         BczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735075819; x=1735680619;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uK+Fl/SQPl5lBNHLc8lT9HHfRQ9k1FaZ+emYb+jRGng=;
        b=v6cPU8ZOI47GOqVSX7IboBtyhysG60na37MmdiOx0i3AcMAk6zzDFnlFX6TPU4Yjc/
         qYxQBPS51FU/WevL/aVbn1olz9SpcTwX9eQH10qOr/Gy5zYcKZdC5CHx+6LGrGeQNHVz
         A29A2f8bYPKott8tkOkU6lfRwLikaAr6JUPfb/5tAD2dWXj6kJA6z5eOwWwlTjpq7LkU
         o4tMAOlhafm4gMHzLHhkPTQduEdipXbRicP2XZkStVgVWJyL4+XvfvmcAKjZrnFM/QxH
         xzcz9+XiXjD907R395A6wA54A8vrMlqX1jfuRqO2V0OtT8fNMnPq9kP4GMQVLLWb9Dkx
         nPNQ==
X-Gm-Message-State: AOJu0YymI6Haqq//ll7gDQZ9J9z6CPn3WDX8L65FBSm7KjoaXqTrVTTK
	TrXi9A8d05TMqC60O6Nz1R6XTDLEl9crzUCJYMB8paMwjNaXTNJrja7Xsw==
X-Gm-Gg: ASbGncstCj1O5qlXTDHW+GTgL9VXhkIyx8tqGBRVh6oht1QHF2WCDcVNPcyyFFeQVHH
	lMtKMghxhgZl4DwrAGkr4ImDdVZXDT7EzXzS79CTc2IU2GY+JT1JAKymJIUPVjx/AlGXGjm+r3a
	SiHQpVVjNnTKIXoe/8y+arXaTFq5103i2eCLLnR7ApX2BxuhUKIw7C8n16ipoUJRBtNL01aD7S+
	zQABLo4HkcL81sUxB4yuQtwklgjpImgRo7lc9RK63w3Ez2GN3/BhcKi5VPot54=
X-Google-Smtp-Source: AGHT+IEHohjTsraL/1UN7ArDDvrRqR4xoqimGG++rE9gPLyCkHlE13OeVNV4FSzSNGdL/mUu5Vf88Q==
X-Received: by 2002:a17:902:d543:b0:216:1e9f:c5db with SMTP id d9443c01a7336-219e6eb63d8mr287690325ad.28.1735075817680;
        Tue, 24 Dec 2024 13:30:17 -0800 (PST)
Received: from [172.17.0.2] ([138.91.70.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc964b54sm94546795ad.1.2024.12.24.13.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 13:30:17 -0800 (PST)
Message-ID: <676b27e9.170a0220.32d7e6.dab5@mx.google.com>
Date: Tue, 24 Dec 2024 13:30:17 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3311654241585988053=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ajhalaney@gmail.com
Subject: RE: Bluetooth: btusb: Add new VID/PID 13d3/3610 for MT7922
In-Reply-To: <20241224-tx55e-bluetooth-v1-1-e83ebc81507a@gmail.com>
References: <20241224-tx55e-bluetooth-v1-1-e83ebc81507a@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3311654241585988053==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=920794

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      24.99 seconds
CheckAllWarning               PASS      27.59 seconds
CheckSparse                   PASS      30.74 seconds
BuildKernel32                 PASS      24.55 seconds
TestRunnerSetup               PASS      436.09 seconds
TestRunner_l2cap-tester       PASS      20.48 seconds
TestRunner_iso-tester         PASS      29.95 seconds
TestRunner_bnep-tester        PASS      4.78 seconds
TestRunner_mgmt-tester        FAIL      119.56 seconds
TestRunner_rfcomm-tester      PASS      7.63 seconds
TestRunner_sco-tester         PASS      9.32 seconds
TestRunner_ioctl-tester       PASS      8.13 seconds
TestRunner_mesh-tester        PASS      5.95 seconds
TestRunner_smp-tester         PASS      7.00 seconds
TestRunner_userchan-tester    PASS      4.99 seconds
IncrementalBuild              PENDING   0.86 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.181 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3311654241585988053==--
