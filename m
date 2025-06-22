Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64399372
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Jun 2025 17:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750613572; cv=none; b=pPd5TLbDolEn/s9Mr9pHjhH2bvcc3i6uLztyb4myR6I4rF6mQEhOfI4KhtPY4IyMDNW6vIFIK1hwAwbiwUVyss6IczXRFgkdQYmiqX4DGAYtM22M/N/k9kM4tuWqa1TFzfzfEaQ2hZLl/XhLYtvITAFkjJFzqGnqkHZiCLQ7SU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750613572; c=relaxed/simple;
	bh=YpoHyzc1ABp0djbNlVr5D4e/trL0tkgs+LdTHXxj30g=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=n8YSvQ80RrRZwrUYkwRCpmjJsXbnqvZxYzjpHC28/NZ5XvXCj0wvK970tgJoOr7D+SUv3Vx/VnAxTvWLG/hlQCynWkANma7Ncu/5EDFSNbg05M+eHvCjTtjCq4RH32OCLoEWAJRHZJmioLp76ASsWeMcm4NEStoMU4T8Gi4uDLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ep4sgdn+; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ep4sgdn+"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-748feca4a61so1768041b3a.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Jun 2025 10:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750613570; x=1751218370; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=67hLbMPTNJzTeaLDyaHXigf7PB/6bgeP6ZpnXmEssWc=;
        b=ep4sgdn+u8VE3gzhzAkkRFlTANU6OvCvxCGdyNFw2hZ8ngSPOzkNafCln0X9Klas0M
         UAiU4T8VO4atecGPDg1PZw1sfRZ5AUi8+5dtou/JX0CCgrrq0qBFxDQXXRyDuUkeCy/p
         G1fn0HupWR11h0BTF8s7felAipBmhaAlLUfJF1PaUtY2WRN2LTLUSe7vVGXVrbU7H8sg
         95F6ZShLI+JXOKp/zZXPENBZad927SVzeLjTXBjkNeqd6mFPrVKDSJ7lGkpkQ55S9wTc
         2DXNguoJfiwGDIoxjzG/2ewyBU4G7KUdBfdaQw6KL0VKwaAMD2P2M1rQXXRtbl6icJqE
         R58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750613570; x=1751218370;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=67hLbMPTNJzTeaLDyaHXigf7PB/6bgeP6ZpnXmEssWc=;
        b=iiDIcbqxIcOFOrEgtyQBoToInlnAjyeQFeqaXoueBfH+Ds7NSVv6IZUfLc+SQ7dBI7
         hzee7tw3iw0JbJ0hfxRHDL0tbT4g4AeCQcjStVpYHnO0t1GR6VVoks07H6X693nyqnfP
         pWyNhv/32mK/+FCAHyufbdchwp4HPly2DNdzCe56/35vG4mrG3MRw9ivcD0YQ6IEMKVb
         jZCb8KAYCxspnuCXFLoWh18u8/qyISkulE4xNj40cJk8M0D1wC8vJJ2rZuZg/08+fLy+
         3QB6oXD63f82A5NsrdwiSzumXbFQwidKSkjJFwSluAFl4zuBniEJnodzCNls+2IgluSV
         O0XA==
X-Gm-Message-State: AOJu0YztBuyiLKRNbQs/lbfTf97bgFN0Um5c5ZfR0tuWejA0w/PS9bJ7
	VErQG/RIV8MwcJJXicyNvgU/48vTTSfkd+5zfLgNVWNUKtNBkK8z81FCMhNzQg==
X-Gm-Gg: ASbGncsa8TfEe+n6asUpEtnTtYuxWOL0vbK0aRvdmLXKBS6C4TbqWzYoc4o+GFmA7BI
	wWNnEKZ1ThD6ZcMBDVFDpAmZRMbxI9WxKHz9zVDH5QhYAYDtdMAEANmOW1malL+ef+hKs2BOZbi
	J6vTJJ+MeR2qA6h96NriVvFPW/ivJ4AfzSTM7qz1VRFCGdkjWi4jBNfNQQViAdqMMonGjRWKyUi
	274gket91QLokieWL+kwpnko8zrrBVwdvtAFTnrE8rrYeggoY6Dc+Mxc7tPFZnCXUjPipgs2rmE
	JJSFo/AW+sDYcMzV59+FRhGT0GCtxBhyJ3kLQwqCSZI2q8a+rLfMKH7GG58BuNFsfA==
X-Google-Smtp-Source: AGHT+IECsUPdQJaOfcWy9OQUy/o6+YAgDtdhTMez+Ju08934TlAqywMNeHaBoWXqccjNUFylmXDiIA==
X-Received: by 2002:a05:6a00:a1f:b0:73e:10ea:b1e9 with SMTP id d2e1a72fcca58-7490d6153b4mr13231796b3a.6.1750613570329;
        Sun, 22 Jun 2025 10:32:50 -0700 (PDT)
Received: from [172.17.0.2] ([52.155.62.9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a4a34cdsm6657319b3a.67.2025.06.22.10.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 10:32:49 -0700 (PDT)
Message-ID: <68583e41.050a0220.2ff1e6.9076@mx.google.com>
Date: Sun, 22 Jun 2025 10:32:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6639194829870103186=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, linuxsumedh@gmail.com
Subject: RE: Bluetooth btusb.c: Add pr_info() for logging.
In-Reply-To: <20250622165753.65461-1-linuxsumedh@gmail.com>
References: <20250622165753.65461-1-linuxsumedh@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6639194829870103186==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=974616

---Test result---

Test Summary:
CheckPatch                    PENDING   0.41 seconds
GitLint                       PENDING   0.31 seconds
SubjectPrefix                 FAIL      0.36 seconds
BuildKernel                   PASS      25.30 seconds
CheckAllWarning               PASS      27.98 seconds
CheckSparse                   PASS      31.31 seconds
BuildKernel32                 PASS      25.26 seconds
TestRunnerSetup               PASS      491.56 seconds
TestRunner_l2cap-tester       PASS      25.90 seconds
TestRunner_iso-tester         PASS      50.41 seconds
TestRunner_bnep-tester        PASS      6.02 seconds
TestRunner_mgmt-tester        PASS      134.71 seconds
TestRunner_rfcomm-tester      PASS      9.53 seconds
TestRunner_sco-tester         PASS      15.08 seconds
TestRunner_ioctl-tester       PASS      10.31 seconds
TestRunner_mesh-tester        PASS      7.58 seconds
TestRunner_smp-tester         PASS      8.95 seconds
TestRunner_userchan-tester    PASS      6.40 seconds
IncrementalBuild              PENDING   0.56 seconds

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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6639194829870103186==--
