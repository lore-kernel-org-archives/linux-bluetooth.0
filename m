Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902FD2AC17
	for <linux-bluetooth@vger.kernel.org>; Sun, 15 Jun 2025 17:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750010282; cv=none; b=Gfl4f8IhKp2b3+RXVHoITU0nU6m/cn7AIlCDzW5ioPQMt6n9yf9KoUFmm2/hzOlYlD5A8XNS57SrZn9gkXm32AAD+CYWBNCoc/pk9+257gKwJVLYZw9YErx6zPr7H/ErMBwaVlYwG5KTxT223J2D300iNSxHUIZpPgf7kYNtXUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750010282; c=relaxed/simple;
	bh=Gvr7l9y6rAl2SInEDtEPkLNmrMM0Vi4tLV1ihNhT8Xk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lTsgt62WL5Sb4RPKW/GleWuG0kx9mTUVqYAj4RZeagCrgIh/PTljoaor60/QVtk9KtA5RCqz/tV1U/7Jr5O6OTixfbwEaBxNYxPkrjr2mXMbcPFsHh/OyX/ZuDqvSe8uwy2OVhGPsRocvYbEX2+mD00dBEtni8dQCPrX8AU74qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItCPm7F7; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItCPm7F7"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-73a4c557d47so159974a34.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Jun 2025 10:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750010279; x=1750615079; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cA30draSZCNYGvvNBXVLSS+iCwA+ppAx/UnyzmufwsY=;
        b=ItCPm7F7hfxGF4k1j1g9FUKBdn8dFxBQ8Dyj4etanuIv2Y3IleP5IBPym9BZDDm8wP
         WJ2Tl92IJ4yLPgSvKzCay4YnLdnD8cuDgRjv2wfNDMMYyA/aEAkyOm6GiXuj1ANIV45P
         WKd0TnQYkRGR7+5Z1EaRRGEsIN3kqIbZ20M0hDUpxTAcSsd82Q/9OBscV6F09SSYDeFT
         QZlPDiyGW2dzzbLJEbK1X8NRlvCOFYhG271EMx2m+NjrYqL0RrYR00xTzyjBiE/MaEY9
         0+3XPqAyYeG00kDfIeif0UGxoMn81OshH9mhHM0mDesmT3hMnd6CrYhPPV9pH7TEtFCn
         YFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750010279; x=1750615079;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cA30draSZCNYGvvNBXVLSS+iCwA+ppAx/UnyzmufwsY=;
        b=q8Pl+4sgg3PQJD1QQ5fGk06rXsC76zM5hSkYnB5S1AzDx7vMvQ7W1maYCTcgJ2vPVL
         uZdau++SDXFvZDQzsc3rSOSW700MktYgqZ1L1IT6zoQtKDX0PoIrIPwPAZrtHZQQ4CfB
         TW6tW/jHYPjQCNddFegsyoo7X2TVKGT4Z174HS7l5cBF1r+p45VA5haGH6LXDAR3Cv3B
         HWkg0ZbALXME43gDkfR9iSsKfd0u4A8zcRItf3wfkOjQfpJCMLUs6eiFGmBeNgXba2xM
         QgnxlCzv2G+hUtOxQMqVawP45DH/KoT0iF8Mn4fanCfGol3PKdhqOB15N2t1H7W1lUeU
         Xtng==
X-Gm-Message-State: AOJu0Yw4c3rpJgsgvuLtWOLxeW3Ce0sTUetAypeJ+Z+8EBCZ4Ad/22OL
	fUlp+nFBk24DWNw85vMoFWavMJGk1qr43CT4TqtuQzLEBLE1ylsBlwVW9wzZNw==
X-Gm-Gg: ASbGncvXcqMAyob9GjU3BXmuaw/28Wp439EHcwDhlgeZ1YbpvbgTyFWUJArqlZuh4SN
	j/BqBS1RlwjMD3TpG9kt10mbSkCXiiyPg6zWby01X2Z8gwMScPBmL3SmIAkTN79lmsWrS+dXURY
	Us0CYVEfRzB9aC8eT9uGRMB+WPUhCaj3DXVl1Xwwl1P110BchPkwe/zD4Po9xf43+r0QZiGlthv
	tdS90sk9vvjLr+4Sz691Xn3m1Ev9Urq+8vJ/vh79/u+oc7jt5A4SfGOnd+U7q0m34KCOW8xWM8j
	ZJOhDGgMiDoBMdfcEXUz/iQI+TBiWgTfLLdzhbou32Vee3ls2o+JJqazh5rTpyb2zE0+3T56NT+
	IJlI=
X-Google-Smtp-Source: AGHT+IHnIvsqISQKsQOHO3q0l0Ab3SMflLHagTaD51r6q4ZY2XdHSzGAXD/O1DSFNeiIWRSkjhdAJg==
X-Received: by 2002:a05:6830:2d88:b0:72b:9316:d596 with SMTP id 46e09a7af769-73a36297a0cmr4443662a34.3.1750010279341;
        Sun, 15 Jun 2025 10:57:59 -0700 (PDT)
Received: from [172.17.0.2] ([23.98.189.226])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73a284039bdsm937094a34.22.2025.06.15.10.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 10:57:58 -0700 (PDT)
Message-ID: <684f09a6.9d0a0220.1cd41.558e@mx.google.com>
Date: Sun, 15 Jun 2025 10:57:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7671111640209749791=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, avkrasnov@salutedevices.com
Subject: RE: [v3] Bluetooth: hci_sync: fix double free in 'hci_discovery_filter_clear()'
In-Reply-To: <257a13b8-6d60-21b3-c714-c6cb74b7b091@salutedevices.com>
References: <257a13b8-6d60-21b3-c714-c6cb74b7b091@salutedevices.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7671111640209749791==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=972244

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.28 seconds
SubjectPrefix                 PASS      0.27 seconds
BuildKernel                   PASS      24.57 seconds
CheckAllWarning               PASS      26.79 seconds
CheckSparse                   PASS      29.91 seconds
BuildKernel32                 PASS      23.99 seconds
TestRunnerSetup               PASS      455.15 seconds
TestRunner_l2cap-tester       PASS      25.01 seconds
TestRunner_iso-tester         FAIL      7.83 seconds
TestRunner_bnep-tester        PASS      5.84 seconds
TestRunner_mgmt-tester        FAIL      132.07 seconds
TestRunner_rfcomm-tester      PASS      9.20 seconds
TestRunner_sco-tester         PASS      14.64 seconds
TestRunner_ioctl-tester       PASS      9.81 seconds
TestRunner_mesh-tester        PASS      7.24 seconds
TestRunner_smp-tester         PASS      8.35 seconds
TestRunner_userchan-tester    PASS      6.10 seconds
IncrementalBuild              PENDING   0.73 seconds

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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.223 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7671111640209749791==--
